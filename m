Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA6CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4BA20881
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJpUZCE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4BA20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeKYJGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 04:06:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36391 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeKYJGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 04:06:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so4448959pgm.3;
        Sat, 24 Nov 2018 14:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LikcDVwBhbS84Pit9yzkGJO9tMkkIp9vsHKDYOmclHo=;
        b=fJpUZCE+PBVqgv1KN9yNoWy4DThwrHWeOOpqbzNTbpXvPnxcwEXwA5f0ouurwZA3Ym
         PGahvuBNqdS4x+04oZ8QzDyTt3QxFzUWOa8ZUWE00Fc5INlUskK60lOWdt/xIDhjmCHZ
         f+kcrKCRg22CFTOSE1eJTd1mtstdhC23hmpc3OPRrNgqH0nlBYEeOfYS/p0UNfSj781q
         aJsL9rI8P4Ogxi6aesuWhMzR/PvY/gmmetZFmGg+61eLQ9uRMJc5ScDcn0sPUj/sfOEi
         2OCXAXI/WtgOh12CbZMATZKVUwVxTsd4ePwcbDCFgRhvoQidT44rf0SfpSQ1XT+lL/YZ
         bWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LikcDVwBhbS84Pit9yzkGJO9tMkkIp9vsHKDYOmclHo=;
        b=RgbS3vTaa0JNHpDM48xOJU/upihTS8DBTTRfJ1rE92gSeIUZh7QNgOAvJCpe3Cqsf5
         jlkcRiYqTW7Skfb5Z1TehiXbjUN6MhOL2Z9YHyR5o96b8STe6bqC4oigy30uGlNkgAoh
         i2XKMnJDsrJRCxfE3kvo5Ue3Ylm9KVgcYHXs/Ef0eiJUIkcnfrurejzc2rIx8uDL19+P
         TpNjxbCkCqEARiMUIQGhXtYulrfFhXOIMMc+mtBt6SNI7gV6w/aRYMPIcnV1tvkTw9il
         BbL7f7t5zBXCKUs4k4FycGkkXKg5R67iqRZ4VlZZ2rtdfgSu+VOr9lvl1xLZLQwAc5Zv
         6rBQ==
X-Gm-Message-State: AA+aEWYYyNq/PaNFc9TLTSm5Q4W7mXFloOtQGFBjXou5bnNBzepjJHm2
        rEiUa8KC4GGQgHGkYvotrow=
X-Google-Smtp-Source: AFSGD/U+e3TxAJckZPmHSlXI4aTG5ioJiwj2xHTaJvZMNg7UQnTvtIAPliEVjLuP/b6aLljtjZonPQ==
X-Received: by 2002:a63:6645:: with SMTP id a66mr18838125pgc.390.1543097835114;
        Sat, 24 Nov 2018 14:17:15 -0800 (PST)
Received: from ?IPv6:2601:282:800:fd80:f47b:a5b6:f52:61bc? ([2601:282:800:fd80:f47b:a5b6:f52:61bc])
        by smtp.googlemail.com with ESMTPSA id e9sm46211812pff.5.2018.11.24.14.17.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 14:17:13 -0800 (PST)
Subject: Re: [PATCH perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, acme@kernel.org,
        peterz@infradead.org, kernel-team@fb.com
References: <20181121195502.3259930-1-songliubraving@fb.com>
 <20181121195502.3259930-6-songliubraving@fb.com>
 <20181121221145.2cxph7zv27x7lbg6@ast-mbp>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <1fb2247a-debe-cdc4-2fec-76526dd07dab@gmail.com>
Date:   Sat, 24 Nov 2018 15:17:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181121221145.2cxph7zv27x7lbg6@ast-mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/18 3:11 PM, Alexei Starovoitov wrote:
> On Wed, Nov 21, 2018 at 11:55:02AM -0800, Song Liu wrote:
>> This patch enables perf-record to listen to bpf_event and generate
>> bpf_prog_info_event for bpf programs loaded and unloaded during
>> perf-record run.
>>
>> To minimize latency between bpf_event and following bpf calls, separate
>> mmap with watermark of 1 is created to process these vip events. Then
>> a separate dummy event is attached to the special mmap. A separate thread
>> is used to only poll bpf events.
>>
>> By default, perf-record will listen to bpf_event. Option no-bpf-event is
>> added in case the user would opt out.
> 
> I think only default perf-record for sampling should include it.
> perf record -e for tracepoints, kprobes and anything else should imply no-bpf-event.
> 

It should default off for those, but as I have said before users should
be able to add bpf load and unload events to the mix of tracepoints,
probes, etc they are monitoring.
