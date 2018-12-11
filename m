Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F83DC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A302084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRL751pS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A302084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLKXh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:37:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46084 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLKXh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:37:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so15798519wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=M+ZESdkC1LCs3NwWzelStNPrJ9VByThnOLUyRcLrGwo=;
        b=KRL751pSO9vI0naXAWLg16Vpb+UYRBUwgzGXdusWxlw7DB4gT7/41fJea6y+kV9a7S
         320YoouaoZmUXknQfGBF0BUGnornb/pd8ZqAwOj96jBgaT4lnYy+DR07hjZ8YZmlg0Uy
         SMUpyk38CHhAg7w4pTs7Zjbluj56NCH6d5ZmEbyX18HjnZf7Q100Z1OWSA0um815jEex
         ccBBp6Fw+BvfF0HKizFywp6ZEdHZvsOxK2nxbPTbCG00c30uAOwXWXYTm4acWka4xHk4
         DR4x3Y9NgcTWlnj0to38/26EXWoElqQkAg0TfxtyGYJVrnAnzRy6ONrnl4uF5b+NnHwV
         n1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=M+ZESdkC1LCs3NwWzelStNPrJ9VByThnOLUyRcLrGwo=;
        b=cA/TKDx+lVXAy+ViBsUfigc6zLFt7q2FK/h1gebAPgJzeyu0TCWdj+EAXBeFz9nxPe
         QIO/bkxvefYTjd6xwYHbE6c6QtmtJlJR+AMVRSSuExuKd4H98By1k+1hzoRFFN/g+Aor
         1jrPt0DZwee2KwpXdhGyarQIO4PzrJHHzhJjf6Hqre/X17AJ71N/9HcFE/htCQcYUfd8
         /al8MJjARTv4hx0Afb4uS+/QmFVEO7deyuD/ZGhWtWpRwBjOJ6z69vWUbeqWww4cJ+BW
         xLJM0IqvhPOQHxJaCTt4KdM1Vh/e+InZjRiJGcuKSc9+/I+g02o/89CpArKgBSm4RolK
         ElCw==
X-Gm-Message-State: AA+aEWZ0x8VGWAI6G2yLiQcVrQIAet/9khuus6vEVepJAqntb9tBr7Kg
        25SL3equtR8Y7RiGEbdGWQ==
X-Google-Smtp-Source: AFSGD/XQjHwISgvlQ+jM42C4tbqDu+tDRZc+vqSJAl6FEbmFiMPJlHLTzAL2rcDk3Lvmj9ZkHgirrA==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr15378411wrx.85.1544571476424;
        Tue, 11 Dec 2018 15:37:56 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id l197sm2923080wma.44.2018.12.11.15.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 15:37:55 -0800 (PST)
Date:   Wed, 12 Dec 2018 02:37:53 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     luto@kernel.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@suse.de,
        thomas.lendacky@amd.com, hpa@zytor.com, john.stultz@linaro.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Message-ID: <20181211233753.GA26593@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> And I had a bit of a WTF moment, as in "WTF does
> RDTSC have to do with a speculation protection barrier".
> Does it actually make sense?

It doesn't. There was too much s/lfence/barrier_nospec/ apparently.

> +	asm volatile(ALTERNATIVE_3("rdtsc",
> +				   "mfence; rdtsc", X86_FEATURE_MFENCE_RDTSC,
> +				   "lfence; rdtsc", X86_FEATURE_LFENCE_RDTSC,
> +				   "rdtscp", X86_FEATURE_RDTSCP)
> +			: EAX_EDX_RET(val, low, high)
> +			/* RDTSCP clobbers ECX with MSR_TSC_AUX. */
> +			:: "ecx");

I have a question: does alternatives ordering matter? CPU can have
both features.

And other code in this file uses "c" for clobber.
