Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0604BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C904620869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo0Zbg84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfBAMJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:09:10 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:46418 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfBAMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:09:10 -0500
Received: by mail-pf1-f172.google.com with SMTP id c73so3092643pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fZpMiKwOeewrj40v8/hphrAA/8AZ6zbGKkoRswf7HD8=;
        b=Bo0Zbg84WZIPiHkj/xBcSF4ge0mfNO01be320elT1Ik6ED+n3R7bbVNIHpQkmC6uRn
         kzhxjQHq7854lAey4Su1hBn2GHabKxCbctkxoxqdcWMSuJo7OL/XDRgYR3/ZbIxk+7Op
         JLllz5XEjIJrF7mlP4asSmUdIvMaBap8kiIbElNGKnCT6rEi5SJICVl3q5CzfbQU/y+C
         gI2M1I9SZJU4A1xZ57PtV47kl/xOExktfM8YThwBmtHJjQ8qhN43qSvRpgypzUX7ws9m
         Fw5Rs0OVGm11QvoMZGDnfmj5k4cYYue/nTyRyU4OPR9QqUhqNVL/HJV2Xn4Z+poznMRK
         YEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fZpMiKwOeewrj40v8/hphrAA/8AZ6zbGKkoRswf7HD8=;
        b=gkDlQMbSMn+KTXebxeC2OlmxjTif4DrnpWI9M2miVJUTXGh9VGZqkm2xmRDCW5Dl0/
         yesxJtI97K6N2a+glmZ9p5saKiSpC+Q7SAT7ZW/S6SH/NBTM3lhL4OK2xf2BfwrKyaTV
         44lS65R0y8/+p+urF6yyXV2MF7VYDGUfrf4GZNgO2IFI1uC1C/j6gGYPh9B4ESGVK1hu
         jJRZSCGw8AW8Jry9cBb1h7znnZE3Xvitov3zhirDUpAK8geQ7ku/Qj7hH3EcxAOm3WNV
         uz5ijGjgMeuDOMYGl5jTPI3AOc+bF23/usdleOsDglAYseBPZJCKNEZBRZWpNtaimTCp
         tP4w==
X-Gm-Message-State: AHQUAubAgivYcG9p97uGZfQLL6BDO4/n7rm8u4U/TYp7aG0cjj/x/3Xf
        zKj2Kxab0BjFTcIzyngWt48=
X-Google-Smtp-Source: AHgI3IY/Kb8rLSv8v4m8Cs4eYC/rYx5XiFZYiewVh9Uf1kMeB3/6+iYmro0MhVUfCWzsjng8JEyk3Q==
X-Received: by 2002:a63:f141:: with SMTP id o1mr2054648pgk.134.1549022949146;
        Fri, 01 Feb 2019 04:09:09 -0800 (PST)
Received: from [192.168.0.103] ([203.160.89.93])
        by smtp.gmail.com with ESMTPSA id j9sm9034258pfi.86.2019.02.01.04.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 04:09:07 -0800 (PST)
Subject: Re: [PATCH/RFC 0/5] HW accel subsystem
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kenneth Lee <liguozhu@hisilicon.com>
Cc:     Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        ogabbay@habana.ai, jglisse@redhat.com,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>, airlied@redhat.com,
        linux-accelerators@lists.ozlabs.org
References: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
 <20190125181616.62609-1-olof@lixom.net>
 <20190201091040.GA159470@Turing-Arch-b> <20190201100711.GB17779@kroah.com>
From:   Kenneth Lee <nek.in.cn@gmail.com>
Message-ID: <b405a81b-7582-8057-ce54-a6a646801450@gmail.com>
Date:   Fri, 1 Feb 2019 20:09:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201100711.GB17779@kroah.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2019/2/1 ÏÂÎç6:07, Greg Kroah-Hartman Ð´µÀ:
> On Fri, Feb 01, 2019 at 05:10:40PM +0800, Kenneth Lee wrote:
>> After the RFCv2 was sent to the lkml, we do not get much feedback. But the
>> Infini-band guys said they did not like it. They think the solution is
>> re-invention of ib-verbs.
> No one needs to re-invent a monstrosity that is ib-verbs.  If anything,
> that is a model that should never be recreated again, showing that we
> can learn from past mistakes :)
>
>> But we do not think so. ib-verbs maintains semantics of "REMOTE memory". But
>> UACCE maintains semantics of "LOCAL memory". We don't need to send, or sync
>> memory with other parties. We share those memory with all processes who share
>> the local bus.
> I agree, don't try to duplicate the mess that people moved away from
> (hint, everyone sane wraps ib-verbs in another model that can actually
> be used and understood...)
>
>> But we know we need more "complete" solution to let people understand and accept
>> our idea. So now we are working on it with our Compression and RSA accelerator
>> on Hi1620 Server SoC. We are also planning to port our AI framework on it.
>>
>> Do you think we can cooperate to create an framework in Linux together? Please
>> feel free to ask for more information. We are happy to answer it.
> Sure, that sounds like a great goal!

Thank you very much for your encouragement:)

Kenneth Lee

>
> thanks,
>
> greg k-h
>
