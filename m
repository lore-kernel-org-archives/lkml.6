Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA99AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B6A20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQWhCyc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfAHM5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:57:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33239 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfAHM5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:57:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so1924605pfb.0;
        Tue, 08 Jan 2019 04:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ct+vC2YU8GpAw05IcANMMWtSRlijHvSbhvy81WFotpA=;
        b=FQWhCyc9PeU1oOqEsrbpxWVYO0P9hzzQKVL6vZwmxZMA1Lio8I5jMgFJEdu/aZ8Nyh
         jucRxUkIXAxwpT2/MvR1+IVjAX8UP81l+i4NZbNPEh9vAi4yUxTLVL5dZBsVCEAUsQ5r
         RRGmzVcKvIBykA+iAWZ8yrGzyToD0irck87qhPT5ZnqedTTn+GSwOrGm0m6HxpR/pxZC
         XbzEmUxLZ91ETTDmvKd1u0h2Irlwp+lslEbs8uUNVKPZiP92bjvvk/LNmsHq/FEtbfxG
         +Uf+w+WSKynASD4qtrREL+r0vNKcMvFSWmnz0cUKCYagPzgwJjFOKfwCspPqSj5UT+9/
         CJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ct+vC2YU8GpAw05IcANMMWtSRlijHvSbhvy81WFotpA=;
        b=eq7dw6I98Tb+XQsk36JKKIOV67gqc+O+h6G05jaWTohcAhxdO1KjdtjIw8p2tfHtLI
         LivU95juOi8rgzbpajynJmgWMsWDNyo6pToJS0xS7tbpQcFhG+DYJfQ5PQMC3fpqOJFl
         8dO0+qL8J+jUEUSa5403U1vVYYFsPx98klgVcUfeXcF+EOMsEZzQwcor4iKOzRresAlB
         NA2myTJ/+//uId0xGJEAOLIoDfiP95IYHKGchxyN75TqCd20JMPoLJsSgXKueQgGrq6f
         lmemkPy7rcHXxWHgBuTXeJ4ED/HMR9bH4UH7ByW3fGGN2mg0Pb0RI2FBRrp9IgZFrmB2
         sDBg==
X-Gm-Message-State: AJcUukcdL+3FfQ5ccBEQlz/OvXuYFQp5EVerMV85Zd5kO6pjqVTmsc+D
        BEKu0GW9vVcDqrLi0UaqO7rtAWAW
X-Google-Smtp-Source: ALg8bN4RkTwvvMWapfRZAiMg4IDxo1orXpIZ+5vH4fYGi4Dc95Ua9gkEuvY7eGKT2n2QNjBZqr74+w==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr1430990pgf.33.1546952238457;
        Tue, 08 Jan 2019 04:57:18 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.59? ([2402:f000:1:1501:200:5efe:a66f:473b])
        by smtp.gmail.com with ESMTPSA id w88sm121006670pfk.11.2019.01.08.04.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 04:57:17 -0800 (PST)
Subject: Re: [PATCH] net: nvidia: forcedeth: Fix two possible concurrency
 use-after-free bugs
To:     Zhu Yanjun <yanjun.zhu@oracle.com>, davem@davemloft.net,
        keescook@chromium.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190108124518.21986-1-baijiaju1990@gmail.com>
 <27392ae0-2c0f-f099-05d8-f9cdbfbd313e@oracle.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <f9ab7ba3-573c-6703-1b01-37a9e0a9b769@gmail.com>
Date:   Tue, 8 Jan 2019 20:57:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <27392ae0-2c0f-f099-05d8-f9cdbfbd313e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/8 20:54, Zhu Yanjun wrote:
>
> 在 2019/1/8 20:45, Jia-Ju Bai 写道:
>> In drivers/net/ethernet/nvidia/forcedeth.c, the functions
>> nv_start_xmit() and nv_start_xmit_optimized() can be concurrently
>> executed with nv_poll_controller().
>>
>> nv_start_xmit
>>    line 2321: prev_tx_ctx->skb = skb;
>>
>> nv_start_xmit_optimized
>>    line 2479: prev_tx_ctx->skb = skb;
>>
>> nv_poll_controller
>>    nv_do_nic_poll
>>      line 4134: spin_lock(&np->lock);
>>      nv_drain_rxtx
>>        nv_drain_tx
>>          nv_release_txskb
>>            line 2004: dev_kfree_skb_any(tx_skb->skb);
>>
>> Thus, two possible concurrency use-after-free bugs may occur.
>>
>> To fix these possible bugs,
>
>
> Does this really occur? Can you reproduce this ?

This bug is not found by the real execution.
It is found by a static tool written by myself, and then I check it by 
manual code review.


Best wishes,
Jia-Ju Bai
