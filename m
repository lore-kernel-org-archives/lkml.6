Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F70C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEF120879
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="wmGh3EBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEF120879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeLLMFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:05:46 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:55678 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbeLLMFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:05:45 -0500
Received: by mail-wm1-f49.google.com with SMTP id y139so5461567wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 04:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cbSDV3HTi3PoWtcPjuS4YP7/TDD/tavlugXFvsnSMU8=;
        b=wmGh3EBIRUZuZ2VelVVqX8jlv6W9znGSdYZkEl02LTDiP2Sxbph94G3nQ9WeGgCqwM
         HX9YINABT55Vh386NL0+FA33yAs9XYylGO7jIX65xC1NWhwuvIGKu7SnVWBnidr2aF7I
         Llp6b2Kt75nUH23sIIyS5E4XOJwQ1x3PW/q8iMjLAStVXhh3NU5x0GvXK/XEZXm1YIxL
         PO0KTt637l1min63KXsjRoMa5Fy8aZzURztuLTz6bEJ1CFrWFdeJojqP3WBw31DD45TK
         N+V9M0QQ6TaZok7+G0EVKiYivjEOO/vTbE4wXtgR553RMxBX78aYe8RMIiof8Fifn060
         tWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cbSDV3HTi3PoWtcPjuS4YP7/TDD/tavlugXFvsnSMU8=;
        b=CmXmACUEY46nLUGz+Ri7AvxtbZt+7XbRknpnR3kd+yxsX8DvetzMXJmfObh9eH5RwX
         Bvu00uvfkeefU6krCHvlGubrfjFJlFzeeMN1xdYJNcOc3mUr7CGVvi4FiBN32/E9RCQZ
         8HUSa7eihBDKZZvzHXxud7uBTvSn/CvxKPjRk97Br1dC/L0BQXNZWVqCTL5dHKqqe+wg
         aUSjYpsra23p0t+rnvTDzonw+EWy0kRKi2cHNziuD98xjgsA4JwMYBVMFY2RrxlXTRoI
         P6fO9XBPyzjWuWLbCGrY7CMFccOpv2Gg5WHW28ogyr2fn8I27UXIm2shiwzpE53zD6Wz
         HRsw==
X-Gm-Message-State: AA+aEWZI7tDM5jF6bYD1rYs7NY1WAL0aY0G61v/kIQJk+XODqA5Ne+/Y
        d60/zNLvsZQFXO+u/4MqEZnoTQ==
X-Google-Smtp-Source: AFSGD/UCHXPWWjq3T2tFM7CCG7smHqP8DUdO3LoaGaYPOMsY0Dyz8fZFkhejPvMVgxe4ld80eUNoVQ==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr5637131wmt.99.1544616343812;
        Wed, 12 Dec 2018 04:05:43 -0800 (PST)
Received: from tmp.scylladb.com (bzq-79-178-94-132.red.bezeqint.net. [79.178.94.132])
        by smtp.googlemail.com with ESMTPSA id h16sm46260012wrb.62.2018.12.12.04.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 04:05:42 -0800 (PST)
Subject: Re: Spurious EIO on AIO+DIO+RWF_NOWAIT
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, linux-aio@kvack.org
References: <9bab0f40-5748-f147-efeb-5aac4fd44533@scylladb.com>
 <20181210124823.iw4mxmdqpsdfeap4@merlin>
From:   Avi Kivity <avi@scylladb.com>
Message-ID: <8fb27ba4-c100-5d08-71b6-ef393d7bcae1@scylladb.com>
Date:   Wed, 12 Dec 2018 14:05:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210124823.iw4mxmdqpsdfeap4@merlin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/18 2:48 PM, Goldwyn Rodrigues wrote:
> On 13:19 09/12, Avi Kivity wrote:
>> I have an application that receives spurious EIO when running with
>> RWF_NOWAIT enabled. Removing RWF_NOWAIT causes those EIOs to disappear. The
>> application uses AIO+DIO, and errors were seen on both xfs and ext4.
>>
>>
>> I suspect the following code:
>>
>>
>> /*
>>   * Process one completed BIO.  No locks are held.
>>   */
>> static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
>> {
>>          struct bio_vec *bvec;
>>          unsigned i;
>>          blk_status_t err = bio->bi_status;
>>
>>          if (err) {
>>                  if (err == BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))
>>                          dio->io_error = -EAGAIN;
>>                  else
>>                          dio->io_error = -EIO;
>>          }
>>
>> Could it be that REQ_NOWAIT was dropped from bio->bi_opf? or that
>> bio->bi_status got changed along the way?
>>
> I don't think REQ_NOWAIT is dropped. I am assuming bio->bi_status error
> is set differently. Is the blk queue being stopped? Is it possible to
> instrument the kernel in your testcase?
>

I traced the function, and I see bio->bi_status == BLK_STS_NOTSUPP and 
bio->bi_opf == REQ_OP_WRITE|REQ_SYNC|REQ_NOMERGE|REQ_FUA|REQ_NOWAIT. 
Presumably the NOTSUPP is the result of NOWAIT not being supported down 
the stack, but shouldn't it be detected earlier? And not converted to EIO?

