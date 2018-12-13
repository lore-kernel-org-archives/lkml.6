Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D07C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB91920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bT3XD8DT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB91920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeLMAoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:44:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40436 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeLMAoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:44:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so162756pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 16:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eGCL8CXk2DxsRI6RmIenE/gWHSpzzo3ICYl1Dkuy9FQ=;
        b=bT3XD8DTdeHNd1n7r1baIPUQ89GQKbMby4TiPYbrsR8kiaghg/YQFkWEgaHm+c2j9P
         1UlBC6u5KTkRSzIMxaI4/bTCiPyybRCDtR4h4F1NPUNNL21q6axIUJA8bVsJv7/hLPtL
         6IGHyRtjtkypXbam8yBKBp1wudltVrnCLUYqx2pWAFNP51kFRbgaFZm5dR5Ud64wBr4H
         F8vZlbH8atdbIjbB5oYO93hNDcMJtU96lpGvdkOpgzk6z062VLLiR9h2fbeZVgvt4fdd
         v25M1E6LcBI3mDeM6Sq5iG++4pXKEbNJfdUu0KAwhYxKQsp/d60f1PPPRUb6/IiUACCq
         ppig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eGCL8CXk2DxsRI6RmIenE/gWHSpzzo3ICYl1Dkuy9FQ=;
        b=l8mmKXH9g87IeAXWYy5PHmNRuGRN0EwXkHNjYrs/RymECPYIY1ErMFunF1dWplcJgb
         QRwD/zlVSjtitxjS5zXdcKER6zlu76xaeONVJtWO7Wm90FcWqEp4HMGjmRU/jLXIHzRq
         34rqSDbIovB0d1Hzw8VJkOSeaXfAlAG1wrx3qVQ/bnv8B6hDjIOukxEfGPuFzmeHNEYf
         nxprHnlApJH88O9fYFHYdehXurZD3A07zs0kXkbIK2r8yRlM7O8nU2wr52KrNB/e0Uqv
         I/fxop+FPiUxXX/f7F/jZO2Og9qRic1NCXRXCrPkx8cYWzmb6tLXfFjDFjh09q7aG1Nb
         e9aQ==
X-Gm-Message-State: AA+aEWY+VJYUnoaeadZdUzQEa9ywlmiyk4Kr4KxWr6/K+e7CORivmh9Q
        R4w/7Q6Du7Q0ObPCWhxNj/1T77Byp5xUkA==
X-Google-Smtp-Source: AFSGD/WKp5J5LeNaoqGKcG5fzCqad43ccyyu0EEVy1qkK/rSC3+B2UvfamPnuXjatcvsz4hgIrN1lQ==
X-Received: by 2002:a62:62c5:: with SMTP id w188mr22423342pfb.160.1544661841546;
        Wed, 12 Dec 2018 16:44:01 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p2sm236938pfb.28.2018.12.12.16.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 16:44:00 -0800 (PST)
Subject: Re: [PATCH] blkcg: handle dying request_queue when associating a blkg
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20181211230308.66276-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <217c7b15-d54a-b51d-8b1a-c2ad0d404721@kernel.dk>
Date:   Wed, 12 Dec 2018 17:43:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211230308.66276-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 4:03 PM, Dennis Zhou wrote:
> Between v3 [1] and v4 [2] of the blkg association series, the
> association point moved from generic_make_request_checks(), which is
> called after the request enters the queue, to bio_set_dev(), which is when
> the bio is formed before submit_bio(). When the request_queue goes away,
> the blkgs supporting the request_queue are destroyed and then the
> q->root_blkg is set to %NULL.
> 
> This patch adds a %NULL check to blkg_tryget_closest() to prevent the
> NPE caused by the above. It also adds a guard to see if the
> request_queue is dying when creating a blkg to prevent creating a blkg
> for a dead request_queue.

Applied, thanks Dennis.

-- 
Jens Axboe

