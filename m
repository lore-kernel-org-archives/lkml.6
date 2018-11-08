Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C99ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805012081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZyfVkdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805012081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeKIEDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:03:01 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:46970 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeKIEDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:03:01 -0500
Received: by mail-pg1-f181.google.com with SMTP id w7so9188486pgp.13;
        Thu, 08 Nov 2018 10:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7zaR5hXeVvGo1yXffIBxsrQ+olUdCy833Oop8XT0fbY=;
        b=rZyfVkdzy+1wHXm6+IXYCM7Uo1TQYP5a7WfMYJIzyVRaXFJ/Nxop9yjKU5Zd++oLBf
         PzbE7edkWvY71tgOjC0cjb4OPZwBCUBHIiJ5W0ov/BfGn6LOTo4/xkeJMgH+SM6GGmDs
         +AE1wa/SCNv1/kynlrgtDxXmmrmC7U3gE1vk+pmVn78H9lA0K9CVyV6IISyYi1wgXLnR
         IWmimlETVG+6Jq1t6ZM26CbdeomAllFUD9tMx87Y4c6YTBpwrDUrN8TYQdJC7P19QpkB
         CjdxyYRzphtp/5s4yIiSvILvHt9NvDHujz5BAgLJJ2n+JdMCE+4L0u5XutQtn+HGkah2
         bPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7zaR5hXeVvGo1yXffIBxsrQ+olUdCy833Oop8XT0fbY=;
        b=WB1k7BLI0h+g4IGb2ds2pfmeuu+LjnTMjjkzBU7Mj8/3WZMq7ub7OX5uOqhXaIbGWe
         4VfQqqP/SN26DKiQwAvEP/7nPUdUrQhkRw3GhxoWB3o2MghamXIwO2FTSgmbPGOKWUzm
         QRpKdP9kzHMcF7dgSAmcv/0ry5GvCDlRtswZ6T5zg8bwiE6yjsJ7Yit8C6/W651Qtb9O
         /AXKnt9iV+gY8P1uKysTH89iSyS65/RCjgnigrUervHfZ2jmXryOM7pwAbumI+nFKw2u
         MjlLi6lOzyuIfIoGObxuF0ouRwR4RuLCKjI+0L89dlH+Ha9ZnYKl5hjK9KRasf++pQpG
         WY8A==
X-Gm-Message-State: AGRZ1gLuW0IYLKto8BauF78brgFVG8b+nojkzvpLhGiRr/N+eIYM6zFi
        VZf9meduybe1ZzVsrgHIZpBpkIja
X-Google-Smtp-Source: AJdET5eFhISP0sDBcDZfVIVzZOIMicRmbZMzSnbX8/CO8wfaC8bh94/faz3+NKyV815unUUVInwB3w==
X-Received: by 2002:a63:fa46:: with SMTP id g6mr4703275pgk.18.1541701575903;
        Thu, 08 Nov 2018 10:26:15 -0800 (PST)
Received: from ?IPv6:2601:282:800:fd80:3ded:1ded:5c12:ca8f? ([2601:282:800:fd80:3ded:1ded:5c12:ca8f])
        by smtp.googlemail.com with ESMTPSA id n23-v6sm8145453pfg.84.2018.11.08.10.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 10:26:14 -0800 (PST)
Subject: Re: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
To:     Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "acme@kernel.org" <acme@kernel.org>
References: <20181106205246.567448-1-songliubraving@fb.com>
 <20181106205246.567448-2-songliubraving@fb.com>
 <20181107084057.GG9781@hirez.programming.kicks-ass.net>
 <31067290-4B66-4AA1-8027-607397BC0264@fb.com>
 <20181108150028.GU9761@hirez.programming.kicks-ass.net>
 <C858C862-E523-4CE8-AB39-CC9B27BE2538@fb.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <d5043aae-69b0-fd49-e82a-5a13834a3f32@gmail.com>
Date:   Thu, 8 Nov 2018 11:26:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <C858C862-E523-4CE8-AB39-CC9B27BE2538@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/18 11:04 AM, Song Liu wrote:
> On the other hand, processing BPF load/unload events synchronously should
> not introduce too much overhead for meaningful use cases. If many BPF progs
> are being loaded/unloaded within short period of time, it is not the steady
> state that profiling works care about. 

but, profiling is not the only use case, and perf-record is common with
those other use cases.

I think that answers why your RFC set does not fork a thread for the bpf
events. You are focused on profiling and for already loaded programs or
for a small number of programs loaded by a specific workload started by
perf.
