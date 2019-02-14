Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AED222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5bVH/ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438130AbfBNKWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:22:44 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36622 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391132AbfBNKWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:22:44 -0500
Received: by mail-yw1-f65.google.com with SMTP id 189so2120426ywi.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 02:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q4yCvwfvM8/XAYATV7sGIwksaWeHLnem1jx6xTKhQJc=;
        b=a5bVH/ww3fy5hi7hhblt1OMcZ6C7X09EtQzkxxPvecvvUA/mnupC1ZjyVnSbO61BP/
         DrsjgyTxVhYxk3EzKe7KyvkL+mx6qKi5zEuTscW7/yVpFav9MsefCHUELKVsMu8qNkIl
         HlDZbGychsCJpY1Pakag2AhizUyqW+Ao+YuusyYkgCF/DBdjA4mViii5V1Cc45perBQE
         BxTMMuJJZxKt9Nc9G5mQkGs9ZyV3lAhcvTwkB2J2RbPxF7CgOThiBFLRYL5BIW5dGLIl
         LEtYDlgIC4mq0CinIGogstF61KcxGRBeU/GSaU1+kg0pw24TQgq67HorGWtvDEnED1O3
         7dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Q4yCvwfvM8/XAYATV7sGIwksaWeHLnem1jx6xTKhQJc=;
        b=W3AAoypcAb4tzWZHSvWZrwkGYRKu6DHTI5yq0vOfw82KyM16N3EqSn3vAap7/HRnqv
         xfJRFj+xZ+o+gFG+iQcxwstwKOg8awZID7iEvwzWK9XTsssa/Urk8BjXYYngblT1QrjH
         60o3NcmUFOi2c9/oN034thk+f92E+ksWsahmY5mTT7ElWDQAtaIhorS0H6hqMIRGSjEb
         AN38bbhTqL42fixD66AhkkJeCd/q0SaMgP94fopwc7CH2+UdAaN1EFSJ8XVxc9L1gb4M
         yngvaHejtgv6izH1V15wHf1gYQRcUECTaXsyZq3DKjWQJh6sDkB86qvNsQ/TUgAVeCm/
         OfSg==
X-Gm-Message-State: AHQUAuZEeX0lYzxJ4We/rpbV32JDl/uieOQ8N0kKt6MhRHnXPEgJDnap
        5/0qRoyBwyBfBN4AqU6yhWA=
X-Google-Smtp-Source: AHgI3IaBeYdXT3qgPHpDwe74a0ZMf5ldRNprKg6m5kIeCwypMAtehmsf/FMYOQJwDArIFas9FexCIw==
X-Received: by 2002:a81:9bcf:: with SMTP id s198mr2185062ywg.314.1550139763090;
        Thu, 14 Feb 2019 02:22:43 -0800 (PST)
Received: from yubo-2 ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id y187sm689691ywf.50.2019.02.14.02.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 02:22:42 -0800 (PST)
Date:   Thu, 14 Feb 2019 05:22:39 -0500
From:   YU Bo <tsu.yubo@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: Fix potential USE_AFTER_FREE  problem
Message-ID: <20190214102238.nobo5vfsvmlyjyhv@yubo-2>
Mail-Followup-To: Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
References: <20190214052356.26884-1-tsu.yubo@gmail.com>
 <20190214083411.GA25842@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20190214083411.GA25842@krava>
User-Agent: NeoMutt/20180512-62-03f98a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Feb 14, 2019 at 09:34:11AM +0100, Jiri Olsa wrote:
>On Thu, Feb 14, 2019 at 12:23:56AM -0500, Bo YU wrote:
>> From: Bo Yu <tsu.yubo@gmail.com>
>>
>> There is a freed pointer "evsel", so fix it.
>>
>> Detected by CoverityScan, CID#1442595("Memory-illegalaccesses
>> (USE_AFTER_FREE)")
>> Fixes: 6ab3bc240ade4("perf trace: Support multiple "vfs_getname" probes")
>>
>> Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
>> ---
>>  tools/perf/builtin-trace.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
>> index b36061cd1ab8..4036b20a1067 100644
>> --- a/tools/perf/builtin-trace.c
>> +++ b/tools/perf/builtin-trace.c
>> @@ -2515,7 +2515,7 @@ static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
>>  static bool perf_evlist__add_vfs_getname(struct perf_evlist *evlist)
>>  {
>>  	bool found = false;
>> -	struct perf_evsel *evsel, *tmp;
>> +	struct perf_evsel *evsel = NULL, *tmp;
>
>hum, I can't see how this change could matter,
>could you pelase explain
First, this is a warning reported by CoverityScan,but in fact i do not how
to answer your question :(.
Second, if i remember right, temporary element of list_for_each_entry_safe
should be initialized with NULL otherwise it will complain via gcc.
Please correct me :)
Thanks,
>
>jirka
>
>>  	struct parse_events_error err = { .idx = 0, };
>>  	int ret = parse_events(evlist, "probe:vfs_getname*", &err);
>>
>> --
>> 2.11.0
>>
