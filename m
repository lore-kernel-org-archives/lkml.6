Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EDCC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF512083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="b5Htvjnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF512083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbeGJS2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:28:51 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46761 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732920AbeGJS2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:28:50 -0400
Received: by mail-io0-f196.google.com with SMTP id i18-v6so5533367ioj.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YCJcwzgHg6b2PtZeCSrpNDW98r4gxMxNyeAT1AE0FRo=;
        b=b5HtvjntOac2U2JwmL4Om7jNGr+TXjRRF+PqQD5alWq0SCjFaYcOXHdhaXOPKLQsUk
         Z8NbCsRrrgD2ssHv0oQRxQIkZdzv+EtSI0AESZCZUEZp2irlT/LS5QOR3MWmQptzb4io
         CtYRpMXIoTQadPqCV7fDMH9uSGS4hKKtYBq2fuwkfSBjLygrSmJRSGJ6+LYa+cI3t+3Q
         Mae+e3IQn507OApBDeOjk3FcEvuM2hliugCU3cLfqzuwQsqU1WLDLDjMNU+U4jUGCVv9
         53PiU9sULT8CiOm46Z/4QwGAs45mjvdvxRIBj+QVUhKxKy4Fo2MSZKU3w/RBUjw1WdoM
         5TVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YCJcwzgHg6b2PtZeCSrpNDW98r4gxMxNyeAT1AE0FRo=;
        b=D+TmjGaoia3ivNqYDzzxvob7WHZyYBVz1EkCjpRLL1u3SEiVQQvRvhlON4rT02gvS+
         Leuzs1Wc6fvXIn1x6A02LyiDddY92SZnAepL7uTD4mObi3KIx+npVpzD+28AC7LRlsbm
         AUYapsjarAFV3ESdqo1SLGf6XfxaM5jE0txvqZw9DP5TmDigEwaIpe25IkKnGpGug09A
         +/qu+X8NlnDy1ue4CkW/Qsdz33+FLUArJCxaM0RJKRNouQyDr8wP8LvnrLabiq9GgyBZ
         /QkkSywjqX5hCuShOYTEjK784nWQp170A9N0L1KEMM/afPuHPY/K6/v/K+Nm0bEMOGM5
         M8Qw==
X-Gm-Message-State: AOUpUlEK6zo9AJ8qt/njuQO1qpuXpRUGqdYVtsRLVS4NCo2vxGwV7oBb
        GEe1voLWFgFbYOzkJdOkZbPyRpQaALQ=
X-Google-Smtp-Source: AAOMgpfo98Opq0peapICQaW7xZGkNnMNB99/JS8NG4CuiyMz9kPRxpObanrA8orLibmGO4kkEl2R+w==
X-Received: by 2002:a5e:dc41:: with SMTP id s1-v6mr6074000iop.200.1531247318820;
        Tue, 10 Jul 2018 11:28:38 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id n124-v6sm5040itg.7.2018.07.10.11.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 11:28:25 -0700 (PDT)
Subject: Re: [PATCH] block: iolatency: avoid 64-bit division
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <jbacik@fb.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180710152146.2371336-1-arnd@arndb.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d9014b7b-2eca-97ba-7e04-4f7f99e88c9b@kernel.dk>
Date:   Tue, 10 Jul 2018 12:28:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180710152146.2371336-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/18 9:21 AM, Arnd Bergmann wrote:
> On 32-bit architectures, dividing a 64-bit number needs to use the
> do_div() function or something like it to avoid a link failure:
> 
> block/blk-iolatency.o: In function `iolatency_prfill_limit':
> blk-iolatency.c:(.text+0x8cc): undefined reference to `__aeabi_uldivmod'
> 
> Using div_u64() gives us the best output and avoids the need for an
> explicit cast.

Applied, thanks Arnd.

-- 
Jens Axboe

