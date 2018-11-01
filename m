Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F5DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764BD2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PR3tO1RQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764BD2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeKBHzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:55:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40042 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeKBHzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:55:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id g21-v6so46228pfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TRQhdaKLLcber9B2Js4e48V71FbQxEqTYQjA/ZyGrjI=;
        b=PR3tO1RQY31oyIP2TtU/zhQMtrB0IWaWV/U+mKXJFRagMHrusZlTN7AtyLeB0vH2OB
         PKIazSSD/bbXLIkR0aBtGs1SRe/oXkwNRZiLLHlR2NE36uM4e7Ljz9anQHg5iimuol3L
         wI0wFyrZ6VK+kgcqR/nGo+DhvDeqgYJFvHuK/NJcdKZHk92jsOrj83w90CigJeHEhowa
         UVTBEU94XrWSU/miOz79t2Bjnzkk4PCTaukl8nAXZqTmQSVYSl+/7m/vw8NeGggNGLFH
         uuo7WiDSxmr8Vtgk9FzMuLXL/xpf5YURRQm7n+uEzF3HbvvJ0NwLmzYSsxevESqkv9p9
         bvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TRQhdaKLLcber9B2Js4e48V71FbQxEqTYQjA/ZyGrjI=;
        b=Lvsfd5gwpiJwY41m4Bw84wsyIh753IhC8gi9S7fmU/xwmsZapdDVxc+ZFp+uQaftW+
         Iay1UZIhwxKXd2GDry/KMGcW8eFB1lS9s0fPkyZPkhEn0fOZogTBMzqRPeLbfGmJ3TdI
         T53RHGTd6n11nmg+Jx4MmZvCdIt1jP9a/7ZRbtt9JrMbRlHcx7ZK1TgemkpN61VXjTjX
         4V+fLW/UrzcUew0TVvjZiE/rDpzvZzsRS6R5GcR2/C/sS5EQxHmKikiqpCOTH5M29jJg
         vNzXJrf+99jKHL3bJKeiEb+NIOjrtyRlrheYx1ycLfoXdkDO/qqdgc+0r8wfhVJOqGQh
         gZLA==
X-Gm-Message-State: AGRZ1gKoibzdNsLy3m3f7M4QXuJhAEwOh74GkcPgBQ7KrlnLctiRld2l
        b2UkvltXZY8AFFB6hSSR1ic8pKWi2ns=
X-Google-Smtp-Source: AJdET5eCYKjEnwCKWZt+aKZf4LDiiKZBGqeqvckyZMTMw8qMUbJj203BP160x89hKafKHd6ecs002Q==
X-Received: by 2002:a62:7e93:: with SMTP id z141-v6mr9738359pfc.241.1541112625287;
        Thu, 01 Nov 2018 15:50:25 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 11-v6sm57210564pfs.108.2018.11.01.15.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 15:50:24 -0700 (PDT)
Subject: Re: [PATCH 06/16] blk-mq: add 'type' attribute to the sysfs hctx
 directory
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-7-axboe@kernel.dk> <20181101215957.GH18005@vader>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <163b5cc9-8106-9369-9675-f93bca24cd81@kernel.dk>
Date:   Thu, 1 Nov 2018 16:50:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181101215957.GH18005@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/18 3:59 PM, Omar Sandoval wrote:
> On Tue, Oct 30, 2018 at 12:32:42PM -0600, Jens Axboe wrote:
>> It can be useful for a user to verify what type a given hardware
>> queue is, expose this information in sysfs.
>>
>> Reviewed-by: Hannes Reinecke <hare@suse.com>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-mq-sysfs.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
> 
> Out of curiousity, why sysfs instead of debugfs?

I don't feel that strongly about it, but it is a property
like the mapped CPUs, for instance, so kind of makes sense to
put it there rather than in debugfs.

-- 
Jens Axboe

