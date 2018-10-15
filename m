Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F43C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E24E208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSy4TRVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E24E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeJPBHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:07:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46087 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeJPBHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:07:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id p143-v6so3645611lfp.13;
        Mon, 15 Oct 2018 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n2MIXJzYhjB0nYYFlnw0K1ypobP188j8IQ/KhKuHXu0=;
        b=BSy4TRVFXP5ZFNBkpPcOa/7ZcLXS0WLgMwj/0eCZTJMC1NfOi6PyJjFXQkSI8oGEB6
         F6uVEtlbkqWaLSMnpFfk71JDwJu/PappTN6Vs3c6RH+GcNEwOQGofBC7PKb1yDkoFs6U
         jtBaOVj0MFYMkx34pmi0ulbtr1EZnz38EIimUbDp/5VK0PIKJfyndY0Vwu6Rdwyghees
         kaf58MDYY8ABK10BQlY+nua+hgSwPnQ8wSu+lEwNLdKMbxDmbi+LAQpSC73bIs6+My0D
         oKH744UPzCr9WlFpNKInMyYK7YI8N7JdQPE+TtMae2N+LCrEshITF6+0SH1eE1tZnL1y
         VyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n2MIXJzYhjB0nYYFlnw0K1ypobP188j8IQ/KhKuHXu0=;
        b=eleBP3fyINU6VqhHoUdqTB++jm0ihsSS960mJiIy0aKELZSRWcew69P+GJRWQXV3U3
         QxY0Cst5JUNcxqMVXEYtW94Y/I+I50/NrXWnglusXClxtkXQs7TEpeyfVFcfdcQ/pxLM
         mKm57rej0LUMFZIbMEKdD4w/MrE3RxoL6ZyNeotQN4lausehgps6d5mlaxn2HuIxSuQU
         PInbyKs2Y1XbP7ZO9TFEccHJ+IpQZHslbUsMCv6bs9gUbO/Z3cvPmUJUEgNU21pc1PWw
         oZPgkwE8gVf0wqWXHFs1e+/BgU7puCxXbQPmiJ1WjtPkOvOYph5V1Eis29/T1huvKfBe
         tysQ==
X-Gm-Message-State: ABuFfogXiYjoCXUakkjRQLRKYnvpobZ5ae0HDlOihKj5EPmJMhbsTFLT
        M4d7YwdJsXPxEUuy0m+l23M=
X-Google-Smtp-Source: ACcGV63pFwGs7tz7G8JFHkulm/vdRmFrFFuBPV5nkDoD/XQtO/MlHWx1/OaSbwlMIckM82kx+Plh/w==
X-Received: by 2002:a19:6e0b:: with SMTP id j11-v6mr10192445lfc.118.1539624102378;
        Mon, 15 Oct 2018 10:21:42 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id o22-v6sm2567876ljc.79.2018.10.15.10.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 10:21:41 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 9D58846065E; Mon, 15 Oct 2018 20:21:40 +0300 (MSK)
Date:   Mon, 15 Oct 2018 20:21:40 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
Subject: Re: [PATCH] proc: fix proc-self-map-files selftest for arm
Message-ID: <20181015172140.GJ2401@uranus.lan>
References: <20181011184359.15627-1-rafael.tinoco@linaro.org>
 <20181011205601.GA32757@avx2>
 <20181011210256.GE2401@uranus.lan>
 <20181011213006.GA13485@avx2>
 <20181011220009.GF2401@uranus.lan>
 <52504bd5-b4ed-518b-f748-c634172c6c68@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52504bd5-b4ed-518b-f748-c634172c6c68@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 01:55:14PM -0300, Rafael David Tinoco wrote:
> That is what I also had in mind, thus the patch. I just realized we had
> another issue on LKFT (our functional tests tool) for
> proc-self-map-files-001.c. Test 001 does pretty much the same as 002, but
> without the MAP_FIXED mmap flag.
> 
> Is it okay to consolidate both tests into just 1, and focus in checking
> procfs numbers conversion only, rather than if mapping 0 is allowed or not ?
> Can I send a v2 with that in mind ?

As to me -- yes, I would move zero page testing to a separate memory testcase.
But since Alexey is the former author of the tests better wait for his opinion.
