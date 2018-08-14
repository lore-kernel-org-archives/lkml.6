Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4714C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2AE214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="J0ebdlDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2AE214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732900AbeHNTMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:12:42 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34680 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeHNTMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:12:42 -0400
Received: by mail-ua1-f68.google.com with SMTP id r15-v6so13787698uao.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iRuenKUIWBuqHAcjNk19T2wq2U3TLJLVakenm0TqYXo=;
        b=J0ebdlDopMPDQuCRFuXEoEx+wqi368xrYWvzbIlxuNzD9wgQvOEvx5LDk865JRQswd
         mDNj/y1t2K5o2srUh2guKlFKhrRL4k8D5wlX8/4INCSsMY4Kw7dTDV6BFe+O6FPLIagy
         7AJs8cgM9hIpjFOKRfYarLpfN1sfmcmTdECsedl8LKqRCZHxi9kz/OxYmjH+2RNiD6It
         HqmFq3B4unCBQ0E1UXvx9PJv46+i1UQYCL2RwZrO7yAUsgNAyNPkIxcGG2Gp6DiSFhYq
         dzy8vjXzvFjWarWjD6cC/XvFOXpQM+hzb9fswKh7ITuq5887AX4ug+4Xaae4UUFp/ljQ
         eSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iRuenKUIWBuqHAcjNk19T2wq2U3TLJLVakenm0TqYXo=;
        b=HyO7L1BlFMRDTvdiNF9cm8ooAIY51TawmMZOHdjfBVXpxtdowozuFJUxIDxRzja24x
         6xjREUGNysAeoZb5zQcvtFQMdwBXd6UNwh0H3+IE5IZTLzq8R4xE8Q0KkWOuEBR+AXYf
         jJ36VQ8eLPBzdXTFTDBGdu6EE9m3Cj6ml6YfeU2vIG31UZ7FVOpAM6efrXhIqrgHV7wW
         uYEifceAaLtHa/+55AoKhz5mzbdSan5/zcGk7TkbJd/ogpjF8nwiAHjddDxSGJ9i9LUz
         93p0vGQ+oxN1QhqhhzuIOqhpSw7ivz7SQiIXhI8KYv5wOB3DI77OaW1bhOnt6I8zmU3J
         +5Iw==
X-Gm-Message-State: AOUpUlF5Gl0SD8Y3lpx4ot0waAiCnxwEOeKsy6sZO1SILBbR6108hOfm
        jdRKjYIkZERRss1EfMQqfZ6unUGLQHs=
X-Google-Smtp-Source: AA+uWPzDj/J0drWmVMkApnaTusGJLvqBNkmSRPBjJiZVuZl3HTb2A9CQmwNAwwo2K906BT2AFRefZw==
X-Received: by 2002:ab0:6a6:: with SMTP id g35-v6mr14865927uag.16.1534263890230;
        Tue, 14 Aug 2018 09:24:50 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h8-v6sm3135619uao.25.2018.08.14.09.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 09:24:49 -0700 (PDT)
Subject: Re: Warning when using eMMC and partprobe: generic_make_request:
 Trying to write to read-only block-device
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     stefan@agner.ch, Sagi Grimberg <sagi@grimberg.me>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7f57199f45df7212fdbba0bd1e78142a@agner.ch>
 <CAOi1vP9Y5Nrr7kVo5GAKnS4casbXPa+LSgY=si=mAW6OHs7-BA@mail.gmail.com>
 <CA+55aFwyCmYfUrGt61d-6B=1XiTLoudNO=_bQ9-g_rDg8Ao_VA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22fff85b-63e5-3cfe-0e72-255044e53bab@kernel.dk>
Date:   Tue, 14 Aug 2018 10:24:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFwyCmYfUrGt61d-6B=1XiTLoudNO=_bQ9-g_rDg8Ao_VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/18 10:22 AM, Linus Torvalds wrote:
> On Tue, Aug 14, 2018 at 8:24 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> Looks like it's coming from that fsync():
>>
>>   sys_fsync
>>     do_fsync
>>       vfs_fsync_range
>>         blkdev_fsync
>>           blkdev_issue_flush
>>
>> I think we need to teach blkdev_issue_flush() to bail out if the bdev
>> is read-only, similar to blkdev_issue_discard(), _write_zeroes(), etc.
>> The question is which error code to use.  blkdev_fsync() already skips
>> over EOPNOTSUPP, so it is a (no-so-good) option.  Other blkdev_issue_
>> functions return EPERM.
> 
> Oh, just make issue_flush() return EROFS for a read-only device.
> 
> Or maybe we should even just consider the flush to be a read operation?
> 
> But I guess the error code gets percolated all the way to user space?
> The safest option might just be to return 0.

We probably just want to special case a flush for this check. In other
situations, like resource allocation and issue, we'd want to consider
it a write.

-- 
Jens Axboe

