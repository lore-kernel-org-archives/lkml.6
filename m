Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E112BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B34521529
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bgn4ezNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B34521529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbeHBRxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:53:15 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44556 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbeHBRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:53:14 -0400
Received: by mail-io0-f193.google.com with SMTP id q19-v6so2349896ioh.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DzVjRib9+pYIK2b+8X4YljSLtc4UzPBPZ3K+x/We++Y=;
        b=bgn4ezNx4CJGjlx/ZG5DEhQ63Qz1c6NMh5Qob/qHUZKEuW6/HLLNbsL02mcjyGHoEo
         /S6/BH6w99LQ1NRYGAW2sclF8vS1cwMuFCsi0LnjKNO4CHsZobpaAzkGrYTh967rbbdL
         OuWtbIKSj5BOfiDhMt+e1vhnxGzRFkdIsHehjF2bZDhYnUID8YnH1pgvLuMveiOK5KBy
         LKa8W/suCrPhojBVgVORZAG3xrpceqA7xdSnJqQCjXjgIsWFPawpktY3VNdG/Pmb71w1
         BlFvXmKdh9bDbzwCk+n79rJ8QACVAHKey0hgiJMutSQXRdET7rDpagboWPz7CzZVdxF5
         YlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DzVjRib9+pYIK2b+8X4YljSLtc4UzPBPZ3K+x/We++Y=;
        b=MSBILRMsXIMd2JPA67qln3GxgRmQSYTfkHBly3gXhdzdT3LneSryFBWTDt9Vo9K+iQ
         eISiZwPqM8zR6Xe+KzDbVINsrdczWbQupiCao0pk33fW4TFmtRfOOr/Q2oq0HN55bsmB
         Uah0WEwQnBKfUenjSP4PFPLJ9jBQIEusnhepxzrSu9RKkzCHYHMv4sPe1cUYxI00GaYY
         zxTKt5qH9uXSg9qclTiNdEMN3WFOEMG1DeHMDUq6p944d0fM4I+47IMmdduSGrupIKCv
         27XZnG7OJtdI87emgOf9mQ7zN1sCTyICYnDALJEeB10z+jg9GXo1RQEJFjizZj6/YhEb
         R7pA==
X-Gm-Message-State: AOUpUlE0McrN2CZc0pBqDv/nG3W2qJe61GQGIioTYBXIXXYKEzQ7j1ST
        imsmF1BCaESEVtRYkzBGl9kwuim/wh0=
X-Google-Smtp-Source: AAOMgpf8pjFw1o6VMo81/mXNgc9b6qz/viaUbrA0Hb0/CzYAYHee9RolmgBX9KSTx1r5umQMmRnr8g==
X-Received: by 2002:a6b:7209:: with SMTP id n9-v6mr3008388ioc.82.1533225686729;
        Thu, 02 Aug 2018 09:01:26 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id p84-v6sm908363itc.2.2018.08.02.09.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 09:01:25 -0700 (PDT)
Subject: Re: [PATCH v3] block: make iolatency avg_lat exponentially decay
To:     Tejun Heo <tj@kernel.org>, Dennis Zhou <dennisszhou@gmail.com>
Cc:     Josef Bacik <jbacik@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180802061541.49173-1-dennisszhou@gmail.com>
 <20180802155917.GT1206094@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2694b782-b28e-3885-660d-a1ee6d00e116@kernel.dk>
Date:   Thu, 2 Aug 2018 10:01:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180802155917.GT1206094@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/18 9:59 AM, Tejun Heo wrote:
> Hello, Dennis.
> 
> On Wed, Aug 01, 2018 at 11:15:41PM -0700, Dennis Zhou wrote:
>> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
>>
>> Currently, avg_lat is calculated by accumulating the mean of every
>> window in a long running cumulative average. As time goes on, the metric
>> becomes less and less useful due to the accumulated history.
>>
>> This patch reuses the same calculation done in load averages to make the
>> avg_lat metric more lively. Unlike load averages, the avg only advances
>> when a window elapses (due to an io). Idle periods extend the most
>> recent window. Bucketing is used to limit the history of avg_lat by
>> binding it to the window size. So, the window range for 1/exp (decay
>> rate) is [1 min, 2.5 min) when windows elapse immediately.
>>
>> The current sample window size is exposed in the debug info to enable
>> calculation of the window range.
>>
>> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
>> Acked-by: Tejun Heo <tj@kernel.org>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Acked-by: Josef Bacik <josef@toxicpanda.com>
> 
> Heh, sorry about not thinking this up from the beginning but I think
> it'd be great to move this to blkcg core so that the stat is always
> available regardless of blk-iolatency.  It's a really important metric
> and can be used for both monitoring and policy implementation.

Just make that change a separate patch, since v3 is already applied.

-- 
Jens Axboe

