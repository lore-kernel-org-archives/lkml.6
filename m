Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4108FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16952064A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="V0if7TGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16952064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maine.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeH1VoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:44:19 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39492 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeH1VoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:44:18 -0400
Received: by mail-qt0-f195.google.com with SMTP id o15-v6so2708925qtk.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wDtNyH+cCeeud0jMHDS2XefIPvixw/IS+NzLF+Dzoa4=;
        b=V0if7TGKsp1do6PPY6Jz5FlPkyF1ZI4vgc/D+Ymo4ecoO7ZBiE39zoXVOa278eTtM6
         MLwKK3ze3dihg3VCO16vu3f68o7t4xNdfhbN5OBgLNIEzG8hiP1gdQPc+a0ciMTkqOL3
         aLAdaQH5jN+SMuR/O+ZT7bkrLcuttJ2kcoTUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wDtNyH+cCeeud0jMHDS2XefIPvixw/IS+NzLF+Dzoa4=;
        b=JypNZDk2uMcFZqkrob3+e3EtIievDviNpL7zIZvtUBut17xEgCTqvWOlK44HjdY2FW
         IUbXrJrmNjs8MwzrtXtFaLFMOqG51+xA9ZRnhPojcDRQH0q3QMqH8nzEf2tOPqFItmyV
         M+u9oHF5AqU6FA78J/a5bIB4/Xu+AaRSM6K7471arOaU1jqM7wDw+3UB4J4DbI4Qtp/w
         vojkTi3AgXF7H8a6WgQZtR4LI7pn/8rKcbyCfCGLrcLSBp5ixVk8upEahx4J1bYKuZmR
         hqx0Pbqb/X0hHZDOZOiitPu9zw8heRRVVvtaHaVVds9yO+enEmc8EgxXEBJLP4XTXNIa
         s0GA==
X-Gm-Message-State: APzg51DweKe+rxI6yWW7I0sV5dumoEbl406VufrLyF2Bo0nR3X7D16/p
        RwQM2rhdjiI8qcMmvIC0BXWcbw==
X-Google-Smtp-Source: ANB0VdYGgSTtYNXCTopNjo10a0PFDSlrFK93fVLo4Sy8h9ZunGXeSYYNEfMjlX+h9jNLwTpKzZxJ3w==
X-Received: by 2002:a0c:ade9:: with SMTP id x38-v6mr2754210qvc.81.1535478692521;
        Tue, 28 Aug 2018 10:51:32 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id j66-v6sm831104qkf.50.2018.08.28.10.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 10:51:31 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 28 Aug 2018 13:51:29 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [perf] perf_event.h ABI visibility question
In-Reply-To: <20180827075246.GX24124@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1808281349210.21658@macbook-air>
References: <alpine.DEB.2.21.1808231401440.28868@macbook-air> <20180824085042.GL24124@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1808241706120.12717@macbook-air> <20180827075246.GX24124@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018, Peter Zijlstra wrote:

> Something like so then?
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index eeb787b1c53c..f35eb72739c0 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -144,7 +144,7 @@ enum perf_event_sample_format {
>  
>  	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
>  
> -	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
> +	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>  };

yes, something like that would be fine.

I am being difficult about this, but from experience when trying to keep 
the manpage updated, what seems obvious now will not be so obvious 6 
months from now and trying to dig through the git logs / mailing list 
archives to verify the purpose of an addition can be a lot of work 
sometimes.

Vince
