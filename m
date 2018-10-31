Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F56ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3084205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0eKlQ3w9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3084205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbeJaXV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:21:27 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:50370 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbeJaXV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:21:27 -0400
Received: by mail-it1-f170.google.com with SMTP id k206-v6so18499731ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RmmJvMvzdcnR4c5lP5FlQpWnMiMjQXEUwABHkWIb5to=;
        b=0eKlQ3w9fzwUXGUN4ZOdcKZ3tdx16mdHDMkf+ZFe79jfzzRbwUmrDVEFhV6AI/PZU2
         JiBoCzh4gwa3pSBs+Pyi6tBcyR6e4rYxst7IjnipTYWj81iAJwX89lVuZ+k+f2BD5OIE
         GpRcLt7lmlROKzsRgb0mXjCcOUX0SSiKXG4KvpBVbUAv6DwphdmUxBrSHyRIf97vn82Z
         QyhmCYIotV4gohQv4OeObs3yCEN9oe+ak7t84AIzUcP59/i7k+iGmlkqYabhcPVj3mWf
         8VMJDBJai/q3nH4Il/qiY7cdhNqhDxnTmWj9jxOCOWsZrgOrXDsJk5Q2/WFCvt4GR8al
         vhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RmmJvMvzdcnR4c5lP5FlQpWnMiMjQXEUwABHkWIb5to=;
        b=Xr1htRjo4eoIc2xvQG9sdH7o+AMhTR2c8hqbwhYVgVReyChHuceapHGRE5KSajYhZw
         RpKN/a84QovztMw1VFBRqRf134DMs5cDwkBp7U7b9isgTOgYXv61gba7gaM2OjtGahDT
         442WbKD7RGUzkbe5GIOTg8XnhMgAM0yJlk6k1KojTYMmSWiJMcHBsCqcp6mu9l0olIzx
         uc35fgCdZKAd2EWoTmQEuGgzv0pqPw0MPn0d3lFfPXdVDloEhX2NulEoWmQzyuvDivQC
         yg28e3k42F1E0qhFP+EnH0XKj9ECc6kQ3mefh2TBq+6EESYYnyKeDWQhplnRzFL3d5JN
         IG6w==
X-Gm-Message-State: AGRZ1gI8MRjUQSqPT9JAanaLL6bqHGAaHqflaoV9yd7z9yGeUsXG0G4S
        VyecOFsDFdFwfNnnRvQCrew9pu2Q4Ms=
X-Google-Smtp-Source: AJdET5em0qiq/YwHeo9QaZTnHDWLgmUpWvRkhqaoLA7GhU9GzKUxbUed08Keiqf/8Z2tfgvWLZ6N1g==
X-Received: by 2002:a24:2e55:: with SMTP id i82-v6mr2060366ita.17.1540995791723;
        Wed, 31 Oct 2018 07:23:11 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id g10-v6sm8509276iom.10.2018.10.31.07.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 07:23:10 -0700 (PDT)
Subject: Re: [PATCH 07/16] blk-mq: support multiple hctx maps
To:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-8-axboe@kernel.dk>
 <1e523ea4-1134-c299-281d-0dad276825d2@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4164e35e-1361-7ea1-f2c1-f9eea7030df9@kernel.dk>
Date:   Wed, 31 Oct 2018 08:23:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1e523ea4-1134-c299-281d-0dad276825d2@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 6:59 PM, Sagi Grimberg wrote:
>> +static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>> +						     unsigned int flags,
>> +						     unsigned int cpu)
>>   {
>> -	return blk_mq_map_queue(q, hctx_type, cpu);
>> +	int hctx_type = 0;
>> +
>> +	if (q->mq_ops->flags_to_type)
>> +		hctx_type = q->mq_ops->flags_to_type(q, flags);
> 
> nitpick: I think that rq_flags_to_type is a bit more descriptive here.
> just a personal opinion.

Sure, I can make that change.

-- 
Jens Axboe

