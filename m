Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06AAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFBB21B18
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbGH6/4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438419AbfBNWdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:33:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42985 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393758AbfBNWdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:33:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so8250446wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y7Q+lajtRlAESol5W4A9TP2N6MFs7uDbMW23tI0LGX4=;
        b=ZbGH6/4zZ4GZuz9UkEgyA9QQYCtFreg+99hNG75mpRPBcFMPXSPxyl06Pg/OJW/wGy
         6NfwIhuMqSKoJGf17NVpTZ5TNkD1FfF0pQlaivOoDWbDnWnJnHGmWGB5BNrlDsk1LBIT
         /K6WnNedARPMPKsmS2hKV8y1W9wHh4szPx+T7VJi7CPYhk6BnnIIBtnRI3hpWVL8vJ7l
         VJS0qJLRZOt/ixFzgJm0NzymY0O8eu3dzOhQBoNK813CvShkdvMSLA02tZ2vsu8mSS5q
         qNSE5SU0kklFKx9jAb/EAu7WFLQuOSdvM4kxSvPLNGlMbazVhf9RZyBfBsPg3xv6xZAD
         HzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y7Q+lajtRlAESol5W4A9TP2N6MFs7uDbMW23tI0LGX4=;
        b=ub2cObB4KGLpTgnJW+AV9ZeD5yy8lK1YRvYFbZdWWnrlz6e9GVjcq+5c7azrb2IVjo
         zd6tUbeEG1j0caXEgQ9Ti9lMk9Ds8EN0qSuxlGCBg0wxYiiSncuZL9ERekedFUOXuLCX
         DBQZHeHKqrscoi5yyVtekrZyosFUgHRfZC38dOf5meGjWVYgOJuee/TI2RmINFaWpH72
         LtMF6/zGP5x+bmlbRfAc/IGpT1Df+hAxj7Zd2EDswLsU0TdnubWWFId0/wBO1DEcOU6u
         cPlsu93F9BbdNQcumJpa+dv5YUJCOT01ROhSbQw+GTDQSzBwM9UqjxGFOPsNDLDcGjS8
         hYEg==
X-Gm-Message-State: AHQUAuZSDGlOjhIdDwwZHu1md82v9xCVV6uTd3hkbBgqHvh5p86yhzy+
        PZK/JPIWf8OHTiBzP5WofEV48j+N
X-Google-Smtp-Source: AHgI3IaXkSj7HM4Qv1i/2nd5hGdKx9czweR1/z0g4sNWDbp0uua8Y0ESyGk27gc4tLSgsaMjb+TsKw==
X-Received: by 2002:a5d:4a05:: with SMTP id m5mr4694283wrq.46.1550183630619;
        Thu, 14 Feb 2019 14:33:50 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:4185:fd13:4656:451e? (p200300EA8BF1E2004185FD134656451E.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:4185:fd13:4656:451e])
        by smtp.googlemail.com with ESMTPSA id w26sm8262793wmc.2.2019.02.14.14.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 14:33:49 -0800 (PST)
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
 <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
 <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
 <20181227065321.GA3749@lerouge>
 <e838fa7f-f43f-7b3c-aae6-edb4f6734964@gmail.com>
 <20190116062408.GA26169@lenoir>
 <f60567f7-fa7e-f424-12e6-b3df7a24c0be@gmail.com>
 <48a2817e-4133-967e-7e57-eea2f547cb01@gmail.com>
 <alpine.DEB.2.21.1902142245170.1646@nanos.tec.linutronix.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <fe610ada-c93c-2fec-3f45-3642272bc682@gmail.com>
Date:   Thu, 14 Feb 2019 23:33:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902142245170.1646@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2019 22:47, Thomas Gleixner wrote:
> On Thu, 14 Feb 2019, Heiner Kallweit wrote:
>> On 24.01.2019 20:37, Heiner Kallweit wrote:
>>>>
>>> Hi Frederic,
>>> is the update debug patch still to come?
> 
> Heiner, there is a related fix queued in
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> 
> See also:
>     https://lkml.kernel.org/r/20190128234625.78241-3-mka@chromium.org
>     https://lkml.kernel.org/r/20190128234625.78241-2-mka@chromium.org
> 
> Can you please have a look?
> 
Great. And sure, I can test it over the weekend.

> Thanks,
> 
> 	tglx
> 
Rgds, Heiner
