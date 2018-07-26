Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B323C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E659C20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="DIXZ5REp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E659C20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbeGZCa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:30:27 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39849 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbeGZCa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:30:26 -0400
Received: by mail-qk0-f193.google.com with SMTP id b5-v6so29061qkg.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 18:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=SDG1W7o/nFx5nqlG2/Pr5sAz7BUzYq+MCZUNcmT9HwQ=;
        b=DIXZ5REpIQaLXY/gnXjXoZ8nbCdiY+3theini6yAvXEmBuG5P5ziE9EKKfVNDDAI79
         DooitsylqNzJt87naqGM4jgM7vjpRnGmqF6ByKthgo8xDAk1Rqr7Q/IwRIPrtO9Z7jTc
         RI6dFsd8w1kV3yUaii6/lWWimCzc9YS4o5GsO6o+/2NNgGCAjPNdGBofUOUXyski3D61
         /kKxqUGpgtXy1Gfa1hCxbw5XtfL1db1wXlN630cBHGrJ/O+CV6TE3xQP6uA2MHHG/XHF
         Jje7nzh/yfz+i3TkP8OEb8UK6t6+e4a0tjkzYKTJcL/l42q26lHk3eNQ0ds936mj4vWv
         yOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=SDG1W7o/nFx5nqlG2/Pr5sAz7BUzYq+MCZUNcmT9HwQ=;
        b=kIOkoESI58Z+oGacPaH0cpeJ1sT5qx+ncRvt8kNxtemdwT5Ob9UxvtuczeyXoCD+/2
         Ig309CrI3JgkbG1zMl0Nhlx/2wB0KFVjA1wCsX8qdMetebOawVBTuCcZf4UUD0UK8Jtr
         jWiYkck1ja+BZjzhLxCPGsnRJ5Bs2f8+RMhllu2AYpUaHZIrJudgjtUKrsAWEvcjBhqB
         Wr0LvBwrtX5qUbACWPZMs5NkGK/WbJglcTvMUK0E/jkX4IaG0WUDQe8vHZ78jrJYylQk
         H6ybVZMewO/OjVqOCwrBkyIZU8hppu+VwGfWVU4NOBUH2cLwv2J/okqp8pqKD7P8OBjZ
         yfWA==
X-Gm-Message-State: AOUpUlHgUKGzXnuqB10GCmnvBGjiAZuujbXsCAYqtOQzdd3eo5OkC4xI
        TxbgcqgslpcfBp5zMthgCpzHgw==
X-Google-Smtp-Source: AAOMgpd5acnWTcs97HDFYzTulA6SS068sIkX/iM0sdWHP6DKbmERufTMFN5Hrry/cFyjEq+Fh0kN0g==
X-Received: by 2002:a37:a310:: with SMTP id m16-v6mr22430604qke.254.1532567767402;
        Wed, 25 Jul 2018 18:16:07 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id l188-v6sm9834712qke.83.2018.07.25.18.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 18:16:07 -0700 (PDT)
Date:   Wed, 25 Jul 2018 18:16:03 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Taeung Song <treeze.taeung@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH] samples/bpf: Add BTF build flags to Makefile
Message-ID: <20180725181603.69289f5d@cakuba.netronome.com>
In-Reply-To: <20180725163039.2838-1-treeze.taeung@gmail.com>
References: <20180725163039.2838-1-treeze.taeung@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 01:30:39 +0900, Taeung Song wrote:
> To smoothly test BTF supported binary on samples/bpf,
> let samples/bpf/Makefile probe llc, pahole and
> llvm-objcopy for BPF support and use them
> like tools/testing/selftests/bpf/Makefile
> changed from the commit c0fa1b6c3efc ("bpf: btf:
>  Add BTF tests")
> 
> Cc: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
> ---
>  samples/bpf/Makefile | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 1303af10e54d..e079266360a3 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -191,6 +191,8 @@ HOSTLOADLIBES_xdpsock		+= -pthread
>  #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
>  LLC ?= llc
>  CLANG ?= clang
> +LLVM_OBJCOPY ?= llvm-objcopy
> +BTF_PAHOLE ?= pahole
>  
>  # Detect that we're cross compiling and use the cross compiler
>  ifdef CROSS_COMPILE
> @@ -198,6 +200,20 @@ HOSTCC = $(CROSS_COMPILE)gcc
>  CLANG_ARCH_ARGS = -target $(ARCH)
>  endif
>  
> +BTF_LLC_PROBE := $(shell $(LLC) -march=bpf -mattr=help 2>&1 | grep dwarfris)
> +BTF_PAHOLE_PROBE := $(shell $(BTF_PAHOLE) --help 2>&1 | grep BTF)
> +BTF_OBJCOPY_PROBE := $(shell $(LLVM_OBJCOPY) --help 2>&1 | grep -i 'usage.*llvm')
> +
> +ifneq ($(BTF_LLC_PROBE),)
> +ifneq ($(BTF_PAHOLE_PROBE),)
> +ifneq ($(BTF_OBJCOPY_PROBE),)

Nice patch!  FWIW you could consider using $(and ...) here:

ifneq ($(and $(BTF_LLC_PROBE),$(BTF_PAHOLE_PROBE),$(BTF_OBJCOPY_PROBE)),)

https://www.gnu.org/software/make/manual/html_node/Conditional-Functions.html#Conditional-Functions

Not sure it's worth a respin..

> +	EXTRA_CFLAGS += -g
> +	LLC_FLAGS += -mattr=dwarfris
> +	DWARF2BTF = y
> +endif
> +endif
> +endif
> +
>  # Trick to allow make to be run from this directory
>  all:
>  	$(MAKE) -C ../../ $(CURDIR)/ BPF_SAMPLES_PATH=$(CURDIR)
> @@ -256,4 +272,7 @@ $(obj)/%.o: $(src)/%.c
>  		-Wno-gnu-variable-sized-type-not-at-end \
>  		-Wno-address-of-packed-member -Wno-tautological-compare \
>  		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
> -		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf -filetype=obj -o $@
> +		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@
> +ifeq ($(DWARF2BTF),y)
> +	$(BTF_PAHOLE) -J $@
> +endif
