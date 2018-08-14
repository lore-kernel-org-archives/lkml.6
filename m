Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE574C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F873214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1/BTSND0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F873214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbeHNTOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:14:46 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37535 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbeHNTOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:14:46 -0400
Received: by mail-ua1-f66.google.com with SMTP id y10-v6so13807126uao.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eFC16Z6qdSckNuwhsQdqXbRBHnjwAx/qmhqUGZ9TT5w=;
        b=1/BTSND0+TTfk5RTSLbWVoOSx4MlVp23GuoMh7GpL59NBT/c1KM53DD7SQKxm9EdZE
         yAu3ZNvF6H4gEg8wNNggBrjFqNSLNaKGS7S9mnNH3X1G0r/LuMIXMEELTjQMubp3zShK
         Gtfk7X59vV6hYxpo3fYF7q0sFkXT0slat9bgyy/nf2UUAyWueJdELu4woCBsMcMzE+gq
         IksusyoWiZtXGXjYbooj08NSnG3E2QazsyHypkciliec6fDgwKT/t+rp8HJVexkcG6Ql
         Ryk3j87bTrMzfo7KNtO6apNfBWUkcYxDgQpI2Wk5QxCOFy928wrLryBd7iaPFGZ5gs7n
         WBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eFC16Z6qdSckNuwhsQdqXbRBHnjwAx/qmhqUGZ9TT5w=;
        b=kI32LHW1Bq6w0SxIs/TUJphrCCXpdXlbbMibTHY0xyTi54t5XQK6lHd9xnjgq4rPYw
         L8o/xC888tUDr3E7eP1uwTVNm4yCfbuDzMmge/RcfkVW3LQf492Ch0dpHdETA8Hm6X8T
         EDrxsBmCRNY31QC5B/PfOo7EbBReBKIVsLIdf52zTy/X+LTQy7ds6QhtxERZy19y/FA4
         pUIvnwf2UyBaGC4eN28wfbT2sEHyezyGT9RpAwj8s7Lwfx6qi0lehz8kjaIchdF4/dga
         vYgn0TBEPrjDDeO1xWuQrIb5S6WnT/doPKsFRGv7QQrKOjBML5Uk0fVfkw20HChz1l3C
         2c8A==
X-Gm-Message-State: AOUpUlFI2E4Ah+E4RP9gzycSwL59b22yZdR8gew3Dd1FV86DzuAeBEXh
        RJWS9RtujZQoeRnK+Co7OQnRk6UAV4Y=
X-Google-Smtp-Source: AA+uWPyL6hZdnzyG3BgTUx8BkJ/prVYiTdJ9KtpHGljDTLWa8tHzG6N7TGTMdLNxSjENZszh9Npm3g==
X-Received: by 2002:a9f:3563:: with SMTP id o90-v6mr14804086uao.79.1534264014439;
        Tue, 14 Aug 2018 09:26:54 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u22-v6sm6649981vkb.0.2018.08.14.09.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 09:26:53 -0700 (PDT)
Subject: Re: Warning when using eMMC and partprobe: generic_make_request:
 Trying to write to read-only block-device
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     stefan@agner.ch, Sagi Grimberg <sagi@grimberg.me>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7f57199f45df7212fdbba0bd1e78142a@agner.ch>
 <CAOi1vP9Y5Nrr7kVo5GAKnS4casbXPa+LSgY=si=mAW6OHs7-BA@mail.gmail.com>
 <CA+55aFwyCmYfUrGt61d-6B=1XiTLoudNO=_bQ9-g_rDg8Ao_VA@mail.gmail.com>
 <22fff85b-63e5-3cfe-0e72-255044e53bab@kernel.dk>
Message-ID: <e5589461-6331-7c4c-4171-7d7e304410e0@kernel.dk>
Date:   Tue, 14 Aug 2018 10:26:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <22fff85b-63e5-3cfe-0e72-255044e53bab@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/18 10:24 AM, Jens Axboe wrote:
> On 8/14/18 10:22 AM, Linus Torvalds wrote:
>> On Tue, Aug 14, 2018 at 8:24 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>>>
>>> Looks like it's coming from that fsync():
>>>
>>>   sys_fsync
>>>     do_fsync
>>>       vfs_fsync_range
>>>         blkdev_fsync
>>>           blkdev_issue_flush
>>>
>>> I think we need to teach blkdev_issue_flush() to bail out if the bdev
>>> is read-only, similar to blkdev_issue_discard(), _write_zeroes(), etc.
>>> The question is which error code to use.  blkdev_fsync() already skips
>>> over EOPNOTSUPP, so it is a (no-so-good) option.  Other blkdev_issue_
>>> functions return EPERM.
>>
>> Oh, just make issue_flush() return EROFS for a read-only device.
>>
>> Or maybe we should even just consider the flush to be a read operation?
>>
>> But I guess the error code gets percolated all the way to user space?
>> The safest option might just be to return 0.
> 
> We probably just want to special case a flush for this check. In other
> situations, like resource allocation and issue, we'd want to consider
> it a write.

Ala:


diff --git a/block/blk-core.c b/block/blk-core.c
index 12550340418d..29f8a60965bc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2162,7 +2163,9 @@ static inline bool should_fail_request(struct hd_struct *part,
 
 static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 {
-	if (part->policy && op_is_write(bio_op(bio))) {
+	const int op = bio_op(bio);
+
+	if (part->policy && (op_is_write(op) && !op_is_flush(op))) {
 		char b[BDEVNAME_SIZE];
 
 		WARN_ONCE(1,


-- 
Jens Axboe

