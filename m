Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B08C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F2E20B80
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXKHjX8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F2E20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeHQBVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 21:21:54 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40606 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeHQBVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 21:21:54 -0400
Received: by mail-pl0-f68.google.com with SMTP id s17-v6so2743195plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NYP7VZBZNyqf1DnlV+O4f4dQ8mFO7hS1AjN3sKFUHIo=;
        b=AXKHjX8ewwVAyjzP4gSeHmCfM9OS5tpsxh0ZAYZsdm+kR7+mvBjzaTHSnxJiuOJ1lH
         dpYN91NWzFtP/2FhFsfE6E9eGf6llaJv0cLq9snpONP+/XkGmpPzvLzyCYoLb24rBWBE
         dVBpWD9TuXqDn/KDpyHpKfoicqm9UK5yYlWjhuIzfmRjj2gTasuxzDuHFWsppUW/VjRX
         ighNs6gWYEEhP+4vdPIfn7Q9iPViTW4SBl/6qm02xD9rUkB22w9vO3HmzMpedGpJ/w6w
         kk2SlqmY7qDryra4qiIVU+8WvBdSGbSsKh9VZ/JnKqh2otoKPeIdU9/P30l175lajFFH
         eu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NYP7VZBZNyqf1DnlV+O4f4dQ8mFO7hS1AjN3sKFUHIo=;
        b=sUz3vQZ5+5GRAUQLmxnnu+dqSkJkP9rGIqqavs+GHY4t8sxVtJSL9pSbJKv3rwYH7A
         S+nCvtJAv/yK7QTETB8Ng5TpConxvBcBlN57ins0SS7prN06FS/10ngrNq4woVLXinoJ
         BGVG0qRAnqwbajWewcxYsBOmr+2y1jfc+vt83bhT5FuiL8czEpp+dDFcO2Xc2hazsPL0
         OCrvUYFgIAveLn5ywRkJFdSlkebwfj1bUJdcT1iG0rsrqCwqxjoGZ36LpavnpZUxJJDq
         n/YmlBONnA1ytIpS2c5iL82Ws4l/ETh8R3lR6MFWhYZpPkrFk8x5mfynH2Hp36KAGR8n
         uwFA==
X-Gm-Message-State: AOUpUlGrnaR5Uayy6t60rOIrNQnusqrKww8XetGX3Oo6FSZa6qAPoZGL
        SOtGTgWgOOgaM3kLBjYnQP8=
X-Google-Smtp-Source: AA+uWPwrCkvEsNVN71pn575wv68RQLXPkpZsshuqg8LpPCsQ8cLOfBNMc8vXfvrLf47xnGeYK7aSTg==
X-Received: by 2002:a17:902:7e45:: with SMTP id a5-v6mr30596366pln.151.1534458061168;
        Thu, 16 Aug 2018 15:21:01 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::7:4c81])
        by smtp.gmail.com with ESMTPSA id w2-v6sm327873pge.44.2018.08.16.15.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 15:21:00 -0700 (PDT)
Date:   Thu, 16 Aug 2018 15:20:58 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] tracing: Add SPDX License format to bpf_trace.c
Message-ID: <20180816222056.2fddxbzpjox2for4@ast-mbp.dhcp.thefacebook.com>
References: <20180816154817.6e8f0b93@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816154817.6e8f0b93@gandalf.local.home>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 03:48:17PM -0400, Steven Rostedt wrote:
> [ Alexei and/or Daniel, I'm adding SPDX headers to the tracing
>   directory. Can you ack this patch? Thanks ]
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add the SPDX License header to ease license compliance management.
> 
> Cc: Alexei Starovoitov <ast@plumgrid.com>

ohh. did you get a reply from that address? ;)

> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Acked-by: Alexei Starovoitov <ast@kernel.org>

