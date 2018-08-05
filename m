Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_NUMERIC_HELO,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0C7C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 16:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06B221899
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 16:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="FJjDjISU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06B221899
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbeHESKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 14:10:30 -0400
Received: from sonic307-9.consmr.mail.gq1.yahoo.com ([98.137.64.33]:40735 "EHLO
        sonic307-9.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbeHESKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 14:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1533485126; bh=B4++H7lcSKCjXIf3e6GhAbA9uWKuBCQ5csKuNw0MfZQ=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=FJjDjISUUDvQjlIXpj6RVxDQA6w2F4vKHzePC4k1eyWesYTcglnSwxGbAOXw/YMDQhLG7xGqfGcWy6PwbRXwEae27dShfPxdYb8yC/XBrMzfDg/2wj+ER04ZEZBN30qgtf/GICgdVsPTk34WvXQrW0ZbofaYJFSNA6IKcHT3T5MeZoWr/7sxrmcL9Tq7ZcheIQso+ttapPfsgU+n/4/w/ujqz5oGWkfKLipi3bzl2MbZ0k1/MFRNBmJtiVz8HJW8a1z9204vltWlMdpCrzPxNNGnBHOFsilLJOtHG7HdstR2krWSvyZdeCz93OrVCridfYIQcjr/mTEVYjAsF+tg/Q==
X-YMail-OSG: z217Ts8VM1mJ4wdWbg44wmZCF5zv2SIQaw9CdLe.7W7IjjZvdwJUCZAaID3_uVH
 l6RqFya6zb6u6a81YADOfhVxaU3qqsqjBMZvoGiidVpBC9h5MkvSS.KPT1yM0kAXLT_QwxpIXCG0
 YrZtSoOtDPy.tGk.u2vnSJ8BQnGpR6WLxtwqFM.HGX43C.fdsdI.DVnCcRbZUY5VDoVKEnWqlpG2
 2L.pCr9VMJlIQBIQ1N2PgL.1GwVLstlgdEJF50QTQeBJ50sX0ACeSofff.zd2DRH6gBtYX4x4FUh
 VLVLYw1WCYk._9.mqFiBdtIkHpVEYa1yQrC0XbyU1EuOc60Rx2GmUpaF.VdP7y9QZQigYPev6kBj
 m3XzEKVUhwEhoazCkCUH5UjqEI0E7JNvu7d5OE2cQjXbEnLS8vrUAppnqKzT8RvNRAV70ZB8L9nu
 r4zMH1rbriN0YRi8zFGfSnuDPXPLRzJD0BVVXkKivzCJZfMMMpTOZ5ZoyDAj1t5IEksnoEO2OXj4
 _c4VhdKjk9vCH19I0uz0SDLdVwqsaZW2Ct8uXRvzdpjdIi1TLLZFjaT5SLu6p7k3KJEYOmVn3rWn
 ymLHKo2wunzG9P7dLS88_3Yvi2YjdrCnXfK2MtYXYiU0XAUI7k3a47TC7RbkrWqQYi1nty0Hc7DK
 zHmUzeCX2fYdtZ.wZ1n_tZoUnrulv14J5K7mIqTFM2Y4nNmEVc4ZqEtXm2.pwc4wlbAg6hp4olQC
 c.yAng1q_M4Q3fNCYITeMwjw3yfLjNHLhirHJGHAqzVMD0ihDcba2XGke61JOVEvyKvGnNOm_vrR
 l.1wQLZHjTdvNH6qDY1pg36N8PE3PTNiWxeQrx89Sqia2bOPCLwtcpAl4wuYBZ5JZbJwW23KkNG_
 5pmn2UUH2jMpTJrN44zx5G7j3nfGNqOfvcmrZHSGxKkfkJpnl9WihzbD7ceuxNMMGUIjuvzjDrLq
 yRWD0LYy55e4nVM9AlDqF8x5kVo9oVFyeXuGtYSRLuRws59ubO3uzDN6l_w7S7Jpv8bE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Sun, 5 Aug 2018 16:05:26 +0000
Received: from 116.226.251.211 (EHLO [192.168.1.7]) ([116.226.251.211])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 911663abacc0c66c1c0400804901dd49;
          Sun, 05 Aug 2018 16:05:26 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: fix if assignment style issue
To:     =?UTF-8?Q?Kristaps_=c4=8civkulis?= <kristaps.civkulis@gmail.com>,
        gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180805152101.11657-1-kristaps.civkulis@gmail.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <78215373-c086-28bc-e35c-27f93d4e7dce@aol.com>
Date:   Mon, 6 Aug 2018 00:05:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180805152101.11657-1-kristaps.civkulis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kristaps,

On 2018/8/5 23:21, Kristaps Čivkulis wrote:
> Fix coding style issue "do not use assignment in if condition"
> detected by checkpatch.pl.
>
> Signed-off-by: Kristaps Čivkulis <kristaps.civkulis@gmail.com>

I don't know whether this rule is mandatory or not for the current linux
kernel
when I checked the original patchset with checkpatch.pl.

Sometime I prefer to use assignment in if condition since the whole
statement
is more meaningful than separate to several statements...  although it
can lead to
some potential bugs.

Another case is use (!ptr) to replace (ptr == NULL) and use (ptr) to replace
(ptr != NULL) for pointers. Actually these expressions are equivalent in C,
but I personally like the nullptr concept... I also have no idea if it
is mandatory to fix
as the checkpatch.pl suggested or not...

Thanks for your patch :) if it is actually mandatory or strongly
recommend, you can add:

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang
