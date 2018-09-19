Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7C2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CFA214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYAXPfEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CFA214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbeISRL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:11:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38322 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbeISRL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:11:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id t25-v6so6507022wmi.3;
        Wed, 19 Sep 2018 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R0PizUhBP61QFCJsaGmnlMsGlM14hDSoqRhDM7NTVt8=;
        b=vYAXPfELW6KXfO88jrCx/PioIwPTQb0lUIfqSVP4T6/ZOPxZe2rAVgIOlgqdIkscGS
         LQ3RL4V+LYPkdXY6owD4Fzg8mMr6Yk8HsQCF6Ft3cMJqfAetrN74s8swI8nMzIpt5Iqe
         N/MtuHCWFWbpni4ygy1OCPsAJVpYVOXfZ2aFyvILq3LO75dVXb3VgBqAvT1Q1p7VNTJ3
         pu9Uey7EO9dyU3ivDTgNzp6yLRcrbLMJ9QrUplvpTeZSIIqXkwRdoUf6wLpT15sus/PB
         6E6iRsHqcbH3v4OuQG7cb3gFbzjc656cpYM4LvPcvv1YfB9WDn3M/1QlfAXSWXtcLXBI
         PZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R0PizUhBP61QFCJsaGmnlMsGlM14hDSoqRhDM7NTVt8=;
        b=M+xcCyua1WBNUsTsrnh4gGjirZyepl632HX9PbbHpVlTSxd3RtxDb18k1KWZBDKYUp
         4aY3AjbPlM4CNs0LDh+OV2GdxxCSHbkwhjby+V1DvRztDF5c25k4KicPRQNqSmLxp4U9
         svYrDE+hAsV0WGhH6CpHJI12LMeVhk9dIsW/YLE0HM1gXz7K6cvY3CgUk+CABhqSfQdx
         ikuzoeaT0+0XUGwADTWFxCXU2/eyLOWXa1ezPZpfWrQz1/8xXREgUGfkv5rB0QRqGgb+
         gNwB8OEEi7MTDT301AMA+PjhxSliZnwfuynMZl1rVJNrf4f1r4gOagE5BTBEgjlkFlh/
         o6dg==
X-Gm-Message-State: APzg51DrsUn4eGAaLd4cjawWQ6Ei20XolguDcuPhHmofhBnzHAPnZU2w
        eajB+CUqDU3sLeasAXeRM3I=
X-Google-Smtp-Source: ANB0VdaUNCvRUD1YHHTUyYoPqhJYUpZTuXrgV4UeCx/U69M+iZbZ8cRxBFf1UOtznz3+49zDSLvVEw==
X-Received: by 2002:a1c:8b54:: with SMTP id n81-v6mr18320968wmd.142.1537356866063;
        Wed, 19 Sep 2018 04:34:26 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w94-v6sm5319998wrc.38.2018.09.19.04.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 04:34:25 -0700 (PDT)
Date:   Wed, 19 Sep 2018 13:34:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Olsa <jolsa@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/2] perf/urgent fixes
Message-ID: <20180919113422.GA39073@gmail.com>
References: <20180918153725.7022-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918153725.7022-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit cb48b6a26cace226d8b299a48c73e808eb0c4f61:
> 
>   Merge tag 'perf-urgent-for-mingo-4.19-20180912' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-09-12 21:10:05 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.19-20180918
> 
> for you to fetch changes up to 169e366c08084aeb49a3793c892c9abfaa47eeda:
> 
>   perf Documentation: Fix out-of-tree asciidoctor man page generation (2018-09-18 10:17:16 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Fix the build on !_GNU_SOURCE libc systems such as Alpine Linux/musl
>   libc due to usage of strerror_r glibc variant on libbpf (Arnaldo Carvalho de Melo)
> 
> - Fix out-of-tree asciidoctor man page generation (Ben Hutchings)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       tools lib bpf: Provide wrapper for strerror_r to build in !_GNU_SOURCE systems
> 
> Ben Hutchings (1):
>       perf Documentation: Fix out-of-tree asciidoctor man page generation
> 
>  tools/lib/bpf/Build               |  2 +-
>  tools/lib/bpf/libbpf.c            | 20 ++++++++++----------
>  tools/lib/bpf/str_error.c         | 18 ++++++++++++++++++
>  tools/lib/bpf/str_error.h         |  6 ++++++
>  tools/perf/Documentation/Makefile |  2 +-
>  5 files changed, 36 insertions(+), 12 deletions(-)
>  create mode 100644 tools/lib/bpf/str_error.c
>  create mode 100644 tools/lib/bpf/str_error.h

Pulled, thanks a lot Arnaldo!

	Ingo
