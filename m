Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BBBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F7B2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEz3pbLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391852AbeLUU2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:28:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33483 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388411AbeLUU2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:28:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so4790143lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 12:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oFWaRE3WuTkuC7iadBcaQRgeEnBHmlCsJDyfmFCJ5Yg=;
        b=JEz3pbLI+l9cMQwIv4RamEV4ktIbF0lhr690HWTADaXmUBiN2bPt3DATP836L5Y+gE
         YxdPiTARS0PMq3KnrZwTj7v8MsF1Vtn0GsxrGgzbPWg5NfpxdBPlyY008sIp8LPPT0lU
         V8k5ecU8qb0QzyQu6rWvsnJmxDdXsN7EWUU+miNbQimrOsoj/Mj/6QW0Wj3uNDLI38tf
         NaLQlxtjLRwNuR3R3Mokvytch8Aq4AvypqTdAX3pfRTRDhPF0quzR6Yj0hIq2JYMLJAc
         SnJobhfT3YEZN0MlSfFVbe2QwMatPORwX1gl+GQ0gbgxgpkkiCY4ws5VGVVTdreV6GuT
         EH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oFWaRE3WuTkuC7iadBcaQRgeEnBHmlCsJDyfmFCJ5Yg=;
        b=NPWbjh8VIoLEwK2kZSrGBM19h9p4JSB5xP6eOhh7/0QD5FiDLWzguAZEB+Vq42Vj+G
         cwgD8K1bdzEyPZxGFctcl3vgLZTZobsJuslIWPUSSv6//s4HWCz8RXFVdSFVYsAkFo6+
         6sWOHQ/+MoDh/GjX3zPXyD1XMXGBxyljrbKeHx1bZ4RIZhV47XNdPy8Xo2UC32/9Zwh0
         hvEWBbB+FmyqPy0H9vhqSiLG1DhL3GvcNOy8THBx3KSYbP5JdP11Bxz/v3BzV6+pSVP2
         78UVKYLrU2reM9cQ72pCRejInG+BNGfl1kj2lgvASj2lIauBwXyAQnLV4008Xrhd0hWr
         AI3w==
X-Gm-Message-State: AA+aEWbhN6DtIuWM9na7or+X1mCSzbusQXiibEreC18EY/tqE41UIKog
        rpSTtAM8Z/Ldzc7P2VFb85E=
X-Google-Smtp-Source: AFSGD/UGS1kQyast5SnXmF0E+3T21yx8839JFSe++VwmrkGvKmLAKrz6a3cVw4tzF+vzavHJcxrkvg==
X-Received: by 2002:a19:a60c:: with SMTP id p12mr2329418lfe.63.1545424089869;
        Fri, 21 Dec 2018 12:28:09 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id q2sm5322561lfa.63.2018.12.21.12.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 12:28:08 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 38E12460769; Fri, 21 Dec 2018 23:28:08 +0300 (MSK)
Date:   Fri, 21 Dec 2018 23:28:08 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrey Vagin <avagin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] fs/proc: timers -- Test for potential index overflow
Message-ID: <20181221202808.GB8441@uranus>
References: <20181101182722.GA2869@uranus.lan>
 <alpine.DEB.2.21.1811091010440.1640@nanos.tec.linutronix.de>
 <20181109092810.GF13195@uranus.lan>
 <20181109113153.GJ13195@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109113153.GJ13195@uranus.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:31:53PM +0300, Cyrill Gorcunov wrote:
> When showing timer's notify symbolic name make sure we never fetch a value
> sitting outside of the names array. Though the former issue displaying
> timer->it_sigev_notify has been fixed by Thomas in commit cef31d9af9082434,
> better to make sure we won't hit it again on furher modifications.
> 
> v2: Use explicit index overflow test (by tglx@). Since
>     it should never happen add warn-once to notify.
> 
> Cc: Andrey Vagin <avagin@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>

Seems the patch is lost due to other duties. Guys, should
I resend it or there some objections?
