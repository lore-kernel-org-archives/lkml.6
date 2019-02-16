Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39F8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED24222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4ledGi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbfBPJOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 04:14:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38709 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfBPJOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 04:14:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so12749538wrw.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 01:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fYMOvGuhrg7aKgCetukl6k8AtPhmh09/GDmH0YDxhPI=;
        b=h4ledGi9449zs2XWxbBtNW0Tpqr2tOJjzSJkg/kTJ5Cy4OShJmmDpGvvWWsxuAOK3A
         5xLZigYnKGbc8n2FjX0gosI/zAp7E01XUGH1WtaN2NFyByyE/5v0jyN8erI8lkX/tRCH
         gvv35xVR0kAskpz2KQVL4NT/ken0hCmoF+mDEEhLA3f1OVOX5SBsttjR6AhkbvbG+m1I
         U6bE3Ye5UNT35uW7Mh1VgnJYYzKTPRk6E0lTI6G5MaVtClfJHNclH9rtwz7iPvnc+fo/
         WLqsPpW/CXytH3KlgxOiMRGkxBYQzNo6KYGWyRHqBSDC1G1hiAb0xGEYoG+/lFE3b50a
         aAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fYMOvGuhrg7aKgCetukl6k8AtPhmh09/GDmH0YDxhPI=;
        b=dk13ZFglSMZ8QIaTtRSP65/lbduKw+yusqV1MgryQ/6/96/VdoTjoFMXNrpmTcnmoi
         WeA3INbKt+rQrD4/5sOJp1cTNiFGwRJTB+EUA+5b6wTQvVitlPNf02GL0OZp/5azx1Mk
         x/yYxSyLZWPqs1sQi0v9REYvflOVAymnlVSEnvG9f1pEGFBQSBBRsLI6XbGuGuMwIUb9
         hm3OSXb23pWF43px6E+wxYBW9tuDobqe5sSlHFvX0OjVyWIv12VKivKKpESgnejfDv/V
         mRHmGkIDMoiSDyB4todgkgfkElnCgSpjFCl6UKDpmt1WfDdXV4lEaNKy/c/qNTIb0HXX
         9JHw==
X-Gm-Message-State: AHQUAuYGHfP1blvibZJ4ouLjRqGR98qoRQUwH5CO1ie5aYVJ+DU4RqhF
        VggloE2/Y/nv65jXv0xetb/iSaWR
X-Google-Smtp-Source: AHgI3IZ37hCQkeB6Hds/2iWYMOjF+hq9TqeoPNnUoASPc/S3edFExoj88AmmelnMZ4oJEQkyrRiq8A==
X-Received: by 2002:adf:eb90:: with SMTP id t16mr9362888wrn.324.1550308449836;
        Sat, 16 Feb 2019 01:14:09 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:fc50:d076:bfa9:dffa? (p200300EA8BF1E200FC50D076BFA9DFFA.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:fc50:d076:bfa9:dffa])
        by smtp.googlemail.com with ESMTPSA id f134sm10261877wme.31.2019.02.16.01.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 01:14:08 -0800 (PST)
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
 <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
 <20181227065321.GA3749@lerouge>
 <e838fa7f-f43f-7b3c-aae6-edb4f6734964@gmail.com>
 <20190116062408.GA26169@lenoir>
 <f60567f7-fa7e-f424-12e6-b3df7a24c0be@gmail.com>
 <48a2817e-4133-967e-7e57-eea2f547cb01@gmail.com>
 <alpine.DEB.2.21.1902142245170.1646@nanos.tec.linutronix.de>
 <fe610ada-c93c-2fec-3f45-3642272bc682@gmail.com>
 <20190215003129.GA15707@lerouge>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <5cc3a604-6218-b439-4176-1d60a132e077@gmail.com>
Date:   Sat, 16 Feb 2019 10:14:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190215003129.GA15707@lerouge>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.02.2019 01:31, Frederic Weisbecker wrote:
> On Thu, Feb 14, 2019 at 11:33:44PM +0100, Heiner Kallweit wrote:
>> On 14.02.2019 22:47, Thomas Gleixner wrote:
>>> On Thu, 14 Feb 2019, Heiner Kallweit wrote:
>>>> On 24.01.2019 20:37, Heiner Kallweit wrote:
>>>>>>
>>>>> Hi Frederic,
>>>>> is the update debug patch still to come?
>>>
>>> Heiner, there is a related fix queued in
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
>>>
>>> See also:
>>>     https://lkml.kernel.org/r/20190128234625.78241-3-mka@chromium.org
>>>     https://lkml.kernel.org/r/20190128234625.78241-2-mka@chromium.org
>>>
>>> Can you please have a look?
>>>
>> Great. And sure, I can test it over the weekend.
> 
> Thanks you, and sorry for the shutdown, I was buried into softirq code lately.
> 
No worries, appreciate your efforts. I tested and wasn't able to reproduce
the issue. Looks good ..

Thanks, Heiner
