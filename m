Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFDEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A0D20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BxzaC61x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A0D20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeHVRwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:52:16 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40027 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbeHVRwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:52:15 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so3139742ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fS+sHCyYrCw+HMvls3AWquhz6m/pWvanaDHMw1yj5Fc=;
        b=BxzaC61xksduDP/fDeBjnUTb9WlNEYtPTxZnwBQjMqw7jgRw0C9eFRgV1ctCbM0CPU
         QFenThOOowcG1aBXdI/xRUKYUGJFxh9DrdYoKNsqTmg1DzavitH8ek9SGH9NpRzF6Jnq
         Itu4kDudqxet8iDtiHqxmEM2gzS3e4ZGExGmb/ZuasG3EdhvzETd/sxuW5bdU6G1kSgB
         0JxemgletmUzZkXYQx8Nm+TxX5l0wI4GbN2/MxO8PPEPx6Knotgb+AYVBhxhQUt/ggI2
         R/iBkPUG3IuwRc1xUKu75XDgMXiiB7DVeAuHDpCSCHxNHgWig/dgrprP2IO2pR0ckNJ4
         GHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fS+sHCyYrCw+HMvls3AWquhz6m/pWvanaDHMw1yj5Fc=;
        b=b1wovvP7lHb9Fm2FUlImQ4VNiJJVHUiiwLGji6sQ+pU2CkAfgCTYglt+Z3C2Ha7mB8
         U3v170PO/W9NcCzQAKMCSwiGwC52KPeRLJvUkIOk7KzXie0XQdOkf53ZTYhFZ9uyR+Qq
         MbGfcTDQai+SJfxyBX2N9SsLYjZOXor9Ba6rmbYjVOoxCSv7L7vyvLwcduV4SuX8bxem
         1lDZPU9hkCDmIPyZBVw9nGW7wDcdaaxKMBkIsOT1uTj1Izu5Ec9fOxAqa5XDZfjxCTt1
         ZLsZKAb6Dd25RRFCnUZa3048vovcZrz1qIvqrdAN+E5y+mt2V0JOK1A9FdcgHKgT+3Ft
         Z3aw==
X-Gm-Message-State: APzg51BFaUz1oAKW50TnvwK7UrJNz3bo2xvlmoG8mmjxs80jxNSGac6O
        n8iGaudfhrGBzOBztpD79InIsl4nArw=
X-Google-Smtp-Source: ANB0VdY5VWyJXlcHgtVtxK5HsWOy6YGlUl/F61E0Nvy/JVImbOe0iZ+rdVWtzRLLg3GzUK19IwdlFQ==
X-Received: by 2002:a24:3507:: with SMTP id k7-v6mr3371535ita.13.1534948027144;
        Wed, 22 Aug 2018 07:27:07 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s24-v6sm541890ioj.17.2018.08.22.07.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 07:27:05 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: Avoid lock contention and thundering herd issue
 in wbt_wait
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Anchal Agarwal <anchalag@amazon.com>
Cc:     fllinden@amazon.com, sblbir@amazon.com, msw@amazon.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6bab69c9-b787-b12f-7738-72e05bf74444@kernel.dk>
 <72f90be2-0b63-d3a0-e953-da9232f44d5b@kernel.dk>
 <761bb0ab416649b8bf3bac1706124456@EX13D13UWB002.ant.amazon.com>
 <7f6c399d-bda1-0bbf-4ea1-07fc510ed1eb@kernel.dk>
 <3498fbfb-e9f3-7606-1fc3-904a0e61ff57@kernel.dk>
 <168d80ac73a44a6f9242c47c164778fc@EX13D13UWB002.ant.amazon.com>
 <c5152431-6e36-6f6e-616e-1cfbd974817d@kernel.dk>
 <20180820224241.GA72523@8c8590bceeee.ant.amazon.com>
 <70e2063a-53fa-2475-eed9-07db277c8c0d@kernel.dk>
 <b2adf708-d396-94ac-b123-8027d3839fd1@kernel.dk>
 <20180822040126.GA18736@kaos-source-ops-60001.pdx1.amazon.com>
 <76ecb022-f167-67eb-8801-111fc209bbaa@kernel.dk>
 <834649ab-62d6-bc7f-ec60-6c1654ea3f26@applied-asynchrony.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d8c171ce-6dfe-e9e5-5673-8443cfec5f01@kernel.dk>
Date:   Wed, 22 Aug 2018 08:27:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <834649ab-62d6-bc7f-ec60-6c1654ea3f26@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/18 6:54 AM, Holger Hoffstätte wrote:
> On 08/22/18 06:10, Jens Axboe wrote:
>> [...]
>> If you have time, please look at the 3 patches I posted earlier today.
>> Those are for mainline, so should be OK :-)
> 
> I'm just playing along at home but with those 3 I get repeatable
> hangs & writeback not starting at all, but curiously *only* on my btrfs
> device; for inexplicable reasons some other devices with ext4/xfs flush
> properly. Yes, that surprised me too, but it's repeatable.
> Now this may or may not have something to do with some of my in-testing
> patches for btrfs itself, but if I remove those 3 wbt fixes, everything
> is golden again. Not eager to repeat since it hangs sync & requires a
> hard reboot.. :(
> Just thought you'd like to know.

Thanks, that's very useful info! I'll see if I can reproduce that.

-- 
Jens Axboe

