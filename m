Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2770ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA712054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zq+wn2FH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA712054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeJaXQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:16:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37728 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbeJaXQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:16:35 -0400
Received: by mail-io1-f67.google.com with SMTP id k17-v6so9779700ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=z3UnU1WCbMcx52xjsMTmFqj8S12KLpbdr4uuG/oVoJU=;
        b=zq+wn2FH32ZAUZzy6KRZoPO7L8vXIjLo8OF9oSLOqahJoy/IuNZ4fXUUeHBUJi5708
         W6eawWDADgYWVorjDyfCAarw6IKWX4/Tzz/jBuIM5Eyui7z+pR7dElpJ/yE74VIu8o//
         bDWAentZrUt2LcDKb4xu7gfdxVCuatDPxeX6j61LDmu9SGU2vdFVb25WhIBoCHjlw6cP
         8AVnf2KTjpAVglzYSL12Tu4UQG/ClzIet1U9fUmVFZlg50rM2OPqs0dMIbfMu/bk28qP
         bJUJwN6UeH2Nl/Fp//1ONwYkVgUpbhRwrQhXohfcygfcTyMr12GObLXoqlbF6t0WT5DS
         a+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z3UnU1WCbMcx52xjsMTmFqj8S12KLpbdr4uuG/oVoJU=;
        b=iM0FGZHyVhlzWkrjyK8yNl2jVM7gCx/12A6sV5/3kgtg5TG0zXfp/ZV/KBdZL9E809
         WIxOAC5ekoaDDVKuE0rngKqmF1fBNwpX5nSSkNw6Z10rL4Yqv3zCeZJP04dvufpPEA63
         uuh+/gZjlzyUdrRnMK/F2KKp3+l1N8B94+BUstSp185zzgmJzMm/L2MRj+aPKYcPsJRg
         Cao6W3nL/J6D11fFAxG9LFf8INaY3uH5ER1qCKOSW4GearYO3yZVQ4XdgIRuA4OBhCTR
         WJAkRzfktXRCr3XKs01P6HhkGeLCUatqGNNAAjrT0e/o5BR3MbPChT63jutIzZERihJK
         XVaA==
X-Gm-Message-State: AGRZ1gKPSabG9oKxAo74MAYDnO9dXOFI3plmEZg0qt3Z6cfYxYTCu7o9
        47LnFNE/xk+u0E54ZFR6aG8S99Fmgxw=
X-Google-Smtp-Source: AJdET5djFzw4X/PpHaNlTqS02AystkXXrzK9+YwGO8c66HZNrdF1xBQ5bg2Oj6ySLdB02b4oU7/XZw==
X-Received: by 2002:a6b:8c43:: with SMTP id o64-v6mr2160884iod.217.1540995501080;
        Wed, 31 Oct 2018 07:18:21 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q185-v6sm7847247itc.30.2018.10.31.07.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 07:18:19 -0700 (PDT)
Subject: Re: [PATCH 04/16] blk-mq: pass in request/bio flags to queue mapping
To:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-5-axboe@kernel.dk>
 <50a9c2d1-abc5-b04f-1f95-878f216a47b1@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c688cb45-eb14-c857-e90a-da6fd93f81b7@kernel.dk>
Date:   Wed, 31 Oct 2018 08:18:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <50a9c2d1-abc5-b04f-1f95-878f216a47b1@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 6:37 PM, Sagi Grimberg wrote:
> 
>>   static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>> +						     unsigned int flags,
>>   						     unsigned int cpu)
>>   {
>>   	struct blk_mq_tag_set *set = q->tag_set;
>> @@ -84,7 +85,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
>>   							  unsigned int hctx_type,
>>   							  unsigned int cpu)
>>   {
>> -	return blk_mq_map_queue(q, cpu);
>> +	return blk_mq_map_queue(q, hctx_type, cpu);
>>   }
> 
> Haven't read through the rest of the patch set, but it looks a bit
> strange that a type enumeration is being passed on as flags field.

It's impossible to get it 100% right at this point, which is why
it looks a bit odd. If you read on, it'll make sense.

-- 
Jens Axboe

