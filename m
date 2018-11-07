Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103CCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C940A20817
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJMigWgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C940A20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbeKGNCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:02:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34867 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeKGNCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:02:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id z16-v6so15838466wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 19:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zEqzfn3SQBQil6hG2vcLpMl2UFCfiQlK6et5ld+8bLI=;
        b=jJMigWgglzogj4uElcDVZX4Ju87iSYKcPhYkoG11DqEW4tX0Iem4FcgbnIopqXErzz
         bkd1nMo5R1XPbJKe261PV+kLj6BroSBs+85dVknsETxLMjsy7M0/ifTZlrIS1ifn1xRo
         MltHA1rzi9v2AJ+uJMx48gSp9MqGYIaSc8tRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zEqzfn3SQBQil6hG2vcLpMl2UFCfiQlK6et5ld+8bLI=;
        b=M/SCNIOmcUDaz7nbCCwKOSMl1QIs1w4tClL1Nw569/mbOnORKJx92Pidc30ShJE+Mf
         DIZeG1PXQF5b7iYi91Oql2EMggJp9382oPWC4yHvyqY2VIwIrzjblYVSiALC69cfGO4O
         bT9oYnn+4wfPMYxJSc+QuCI/wDbfKTcD58+Uxo1vE/cxWAjhhsHnrIp8fpT2TJRvsFQS
         Lf9Aq+ZPg4mhJ1VqL1xEeDyg6LR7dnXzEeQqGOwxHE5LYsb79XDLU+NPR2SpSoeBYASJ
         +3VuLkbtCvizReLQ15a9NtgPSyHFTlsrzv3SGZGskzFslGZLIXVmQzdl4Hs49XlOVh+w
         1rWQ==
X-Gm-Message-State: AGRZ1gIu0MYIIU1PfqI2fRuSmt63UD5WQJdT9wXTJl7iiz24hMdvyb7M
        lvtOgnBSUb/t1EoPyLHZyf66ucPPjt1urMO6
X-Google-Smtp-Source: AJdET5dm8L2YxKRxI4EG50dnjCXKflLxtHg5TALMDwUW9qIEEuQeVulHVYUTF1slnVcC7WfEyZXHfw==
X-Received: by 2002:adf:e750:: with SMTP id c16-v6mr175984wrn.196.1541561626390;
        Tue, 06 Nov 2018 19:33:46 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id b5-v6sm31320530wrs.34.2018.11.06.19.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 19:33:45 -0800 (PST)
Date:   Wed, 7 Nov 2018 11:33:40 +0800
From:   leo.yan@linaro.org
To:     acme@redhat.com, Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Coresight ML <coresight@lists.linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Question: perf dso support for /proc/kallsyms
Message-ID: <20181107033340.GJ3983@leoy-ThinkPad-X240s>
References: <20181102025516.GA25374@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102025516.GA25374@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:55:16AM +0800, Leo Yan wrote:
> Hi all,
> 
> Now I found that if use the command 'perf script' for Arm CoreSight trace
> data, it fails to parse kernel symbols if we don't specify kernel vmlinux
> file.   So when we don't specify kernel symbol files then perf tool will
> roll back to use /proc/kallsyms for kernel symbols parsing, as result it will
> run into below flow:
> 
>   thread__find_addr_map(thread, cpumode, MAP__FUNCTION, address, &al);
>   map__load(al.map);
>   dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
>     `-> data_read_offset()
> 
> I can observe the function data_read_offset() returns failure, this is caused
> by checking the offset sanity "if (offset > dso->data.file_size)"  (I pasted
> the whole function code at below in case you want to get more context for it),
> but if perf use "/proc/kallsyms" to load kernel symbols, the variable
> 'dso->data.file_size' will be set to zero thus the sanity checking always
> thinks the offset is out of the file size bound.
> 
> Now I still don't understand how the dso/map support "/proc/kallsyms" and
> have no idea to fix this issue, though I spent some time to look into it.
> 
> Could you give some suggestion for this?  Or even better if you have fixing
> for this, I am glad to test at my side.

Hi Jiri, Arnaldo,

Could you give some suggestion for this question?  Thanks!

> static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
>                                 u64 offset, u8 *data, ssize_t size)
> {
>         if (data_file_size(dso, machine))
>                 return -1;
> 
>         /* Check the offset sanity. */
>         if (offset > dso->data.file_size)
>                 return -1;
> 
>         if (offset + size < offset)
>                 return -1;
> 
>         return cached_read(dso, machine, offset, data, size);
> }
> 
> Thanks,
> Leo Yan
