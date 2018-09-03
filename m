Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3526AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B2E20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY3J6BHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B2E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeICGBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:01:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38952 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeICGBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:01:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so7934567pff.6;
        Sun, 02 Sep 2018 18:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9wgy6/5BHTRfTSg2v8lvQnt8TozMG8bUSp7agPIOGr8=;
        b=jY3J6BHXW+9tWWuR/2HastT8HUpOgyIHaeMmIGtF2XBd6HQpB6V3l3hOe52/I0F7rS
         5sEDO7KoqiMAjYeIM+7Uw5S23H/51w8Cd4/cajBN1HzqJTmkU2PCCRpPKgASVQYiuRGd
         HBkjky6BRZmuX1Za+6+m2ObUnmyl4ZQJ5GOux2nVzB0kv9COn0kNwwAa9h3FmuunahyR
         DBt9xW2pWndncBjJEo4e+gn3Q2QSDB9/YuQdyTJ21Maz38COtKtxiSZXGg61jIjZwAbM
         DK7diYc747/Ij/XxrXinyuA5XY8O+m2vMhTgbVVTCv8/9CbZ5com/536N5YGHvVk7VAK
         xCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9wgy6/5BHTRfTSg2v8lvQnt8TozMG8bUSp7agPIOGr8=;
        b=bUqhFRNZBnbjBkhO2LiwhsfHdyNgbHV/UFgZStKQlIRoSUDQvaeWxPUSKQTe1L9OAJ
         Pv/yI8tejpCB5AhdAI1BE4otPPohVzn9Zj/bl9aDBdK8CFvPCK62cxW5jCyVHXg90lb6
         K74i+0QaTBUyQZRtVmlFagy7oonXqXVg93i1MlpqAePkvwTaCscrbMRMNt0a8yTTNh34
         Eb5r/LdHP0ogMtJC2la8lCyje9A8hmFUe6OCMq8lXkxQP9rvbHYbvVKe6a2RYQWOtP4D
         +6Pn96RjFcAccoNf1HOqH7KSqbhHM8HIeo77dsPt8adHHdWU2XMKZrU1EjBqLTdixRf1
         +C/w==
X-Gm-Message-State: APzg51CIjBgsUTvRWZ3gZveKuZYiv/a4gPqiNsOtgJUl4CetxMgvQ4SS
        6MIkmtzMmJsXzngiSuHvBeDVl0f8
X-Google-Smtp-Source: ANB0VdbXmBRgfE1q4TnVSz+1RDqXVB4zPjC8+A73bsbLUQttoNlcPAyuIWKWMKTVKfqJ4tv0jqDegw==
X-Received: by 2002:a63:ec14:: with SMTP id j20-v6mr24209159pgh.28.1535939032979;
        Sun, 02 Sep 2018 18:43:52 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.58? ([2402:f000:1:1501:200:5efe:a66f:473a])
        by smtp.gmail.com with ESMTPSA id z63-v6sm22378070pgd.69.2018.09.02.18.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 18:43:52 -0700 (PDT)
Subject: Re: [PATCH] net: scm: Fix a possible sleep-in-atomic-context bug in
 scm_fp_copy()
To:     David Miller <davem@davemloft.net>
Cc:     ktkhai@virtuozzo.com, viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        dvlasenk@redhat.com, xiyou.wangcong@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180901100026.16956-1-baijiaju1990@gmail.com>
 <20180902.160144.542360312136980090.davem@davemloft.net>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <0b682dc4-9c94-027d-dbab-25fdb15f48a7@gmail.com>
Date:   Mon, 3 Sep 2018 09:43:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180902.160144.542360312136980090.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.


On 2018/9/3 7:01, David Miller wrote:
> From: Jia-Ju Bai <baijiaju1990@gmail.com>
> Date: Sat,  1 Sep 2018 18:00:26 +0800
>
>> The kernel module may sleep with holding a spinlock.
>>
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>
>> [FUNC] kmalloc(GFP_KERNEL)
>> net/core/scm.c, 85: kmalloc in scm_fp_copy
>> net/core/scm.c, 161: scm_fp_copy in __scm_send
>> ./include/net/scm.h, 88: __scm_send in scm_send
>> net/unix/af_unix.c, 1600: scm_send in maybe_init_creds
>> net/unix/af_unix.c, 1983: maybe_init_creds in unix_stream_sendpage
>> net/unix/af_unix.c, 1973: spin_lock in unix_stream_sendpage
> Please, do a full analysis of the code for these changes you are
> submitting.
>
> Read maybe_init_creds(), it sets msg.msg_controllen to zero.
>
> 	struct msghdr msg = { .msg_controllen = 0 };
>
> When that is zero, __scm__send() is never called.

Oh, I did not notice this, sorry...

> static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
> 			       struct scm_cookie *scm, bool forcecreds)
> {
>   ...
> 	if (msg->msg_controllen <= 0)
> 		return 0;
> 	return __scm_send(sock, msg, scm);
>
> If this bug existed, sleeping in atomic warnings would be triggering
> all the time and people would report that.

Sorry for this false positive.
I will check the code more carefully before submitting my patches.


Best wishes,
Jia-Ju Bai
