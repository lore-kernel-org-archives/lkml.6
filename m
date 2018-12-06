Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C8FC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B14720989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544116486;
	bh=+C1L+HFy0OnGZOXzUxjtW69K4zeY10YZLZVj5JQ1/Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xhCQDI+TARnVtQNWVZpCjLcb/CY6t+fE9mW3HxDgWQ4OrsKL3O8l53Gyl5KtIuz4J
	 I2eQtRfi2Ru0/JyL/G/7Q99yERMRwLyEtsEABYsP8W4xXPNTZBAGNTwMdodhGedTgc
	 /22IAVL4GLxJKVtoPZYuP0L9UJBrveN+nMoeDAWQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B14720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeLFROo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:14:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLFROo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:14:44 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78FA620878;
        Thu,  6 Dec 2018 17:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544116483;
        bh=+C1L+HFy0OnGZOXzUxjtW69K4zeY10YZLZVj5JQ1/Bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cu+BSggFPcBfQ6FML6OtQNBz4LIFyeZcJnLUeFqkhJvkEyMXY30+ppa1AXoxjAflz
         9I2e3tcQlKd0dhbkgCgaCtneaW+jG/HSdcr+wD9tmumRdlExurkFBLbo/VM22jsGVu
         BoHvmGP3mpuQjOHTTrrKAWSUOUXjqNFCCg//NQMM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C2E044042C; Thu,  6 Dec 2018 14:14:40 -0300 (-03)
Date:   Thu, 6 Dec 2018 14:14:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] ARC: introduce basic 'perf annotate' support for ARC
Message-ID: <20181206171440.GA32567@kernel.org>
References: <20181204175118.25232-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204175118.25232-1-Eugeniy.Paltsev@synopsys.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 04, 2018 at 08:51:18PM +0300, Eugeniy Paltsev escreveu:
> Introduce basic 'perf annotate' support for ARC to be able
> to use anotation via stdio interface.

Would be nice to show the output of a 'perf annotate --stdio2' for a
perf.data file recorded on ARC :-)

- Arnaldo
 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  tools/perf/arch/arc/annotate/instructions.c |  9 +++++++++
>  tools/perf/arch/common.c                    | 11 ++++++++++-
>  tools/perf/util/annotate.c                  |  5 +++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/arch/arc/annotate/instructions.c
> 
> diff --git a/tools/perf/arch/arc/annotate/instructions.c b/tools/perf/arch/arc/annotate/instructions.c
> new file mode 100644
> index 000000000000..2f00e995c7e3
> --- /dev/null
> +++ b/tools/perf/arch/arc/annotate/instructions.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compiler.h>
> +
> +static int arc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
> +{
> +	arch->initialized = true;
> +	arch->objdump.comment_char = ';';
> +	return 0;
> +}
> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 82657c01a3b8..f7cb57c424d1 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c
> @@ -5,6 +5,13 @@
>  #include "../util/util.h"
>  #include "../util/debug.h"
>  
> +const char *const arc_triplets[] = {
> +	"arc-linux-",
> +	"arc-snps-linux-uclibc-",
> +	"arc-snps-linux-gnu-",
> +	NULL
> +};
> +
>  const char *const arm_triplets[] = {
>  	"arm-eabi-",
>  	"arm-linux-androideabi-",
> @@ -147,7 +154,9 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
>  		zfree(&buf);
>  	}
>  
> -	if (!strcmp(arch, "arm"))
> +	if (!strcmp(arch, "arc"))
> +		path_list = arc_triplets;
> +	else if (!strcmp(arch, "arm"))
>  		path_list = arm_triplets;
>  	else if (!strcmp(arch, "arm64"))
>  		path_list = arm64_triplets;
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 6936daf89ddd..66066fb4d644 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -134,6 +134,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
>  	return 0;
>  }
>  
> +#include "arch/arc/annotate/instructions.c"
>  #include "arch/arm/annotate/instructions.c"
>  #include "arch/arm64/annotate/instructions.c"
>  #include "arch/x86/annotate/instructions.c"
> @@ -142,6 +143,10 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
>  #include "arch/sparc/annotate/instructions.c"
>  
>  static struct arch architectures[] = {
> +	{
> +		.name = "arc",
> +		.init = arc__annotate_init,
> +	},
>  	{
>  		.name = "arm",
>  		.init = arm__annotate_init,
> -- 
> 2.14.5

-- 

- Arnaldo
