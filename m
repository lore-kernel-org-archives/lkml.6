Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7229C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8586520671
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLo9bVcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8586520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389746AbeKVHj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:39:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732609AbeKVHj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:39:26 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7419220645;
        Wed, 21 Nov 2018 21:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542834206;
        bh=3ttKOEbHRgRAdjtPaYkDN/wGyB7rr3b/r4xhJIfkELY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VLo9bVclF8NZunzD/NAJNfRGx6ymi8QIN8DySgNVnd0630mgy4a4PSH4filTDVVgG
         Zdec7L/eU7za1z6wzPEyF8Q+J0gIiNEHRE8ny6jp4Nmmiaav9m147DOFwKmwHGs9cL
         7Rs91hSNC7O55aI2gFInwxAj4W+wGMwWONPcTZK0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 776F31443D9; Wed, 21 Nov 2018 18:03:21 -0300 (-03)
Date:   Wed, 21 Nov 2018 18:03:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Gustavo Luiz Duarte <gduarte@redhat.com>,
        Ben Gainey <ben.gainey@arm.com>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Separate jvmti cmlr check
Message-ID: <20181121210321.GI6248@kernel.org>
References: <20181121154341.21521-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121154341.21521-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 21, 2018 at 04:43:41PM +0100, Jiri Olsa escreveu:
> The Compiled Method Load Record (cmlr) is JDK specific
> interface to access JVM stack info. This makes the jvmti
> agent code not compile under another jdk, which does not
> support that.
> 
> Separating jvmti cmlr check into special feature check,
> and adding HAVE_JVMTI_CMLR macro to indicate that.
> 
> Mark cmlr code in jvmti/libjvmti.c with HAVE_JVMTI_CMLR,
> so we can compile it on system without cmlr support.
> 
> This change makes the jvmti compile with java-1.8.0-ibm
> package. It's without the line numbers support, but the
> rest works.
> 
> Adding NO_JVMTI_CMLR compile variable for testing.

Looks sane, thanks, applied.

- Arnaldo
 
> Cc: Gustavo Luiz Duarte (IBM) <gduarte@redhat.com>
> Cc: Ben Gainey <ben.gainey@arm.com>
> Cc: Stephane Eranian <eranian@google.com>
> Link: http://lkml.kernel.org/n/tip-i2rm3qgzrla5thejrij0opgp@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/build/feature/Makefile          |  4 ++++
>  tools/build/feature/test-jvmti-cmlr.c | 11 +++++++++++
>  tools/build/feature/test-jvmti.c      |  1 -
>  tools/perf/Makefile.config            |  7 +++++++
>  tools/perf/Makefile.perf              |  3 +++
>  tools/perf/jvmti/libjvmti.c           | 12 ++++++++++++
>  6 files changed, 37 insertions(+), 1 deletion(-)
>  create mode 100644 tools/build/feature/test-jvmti-cmlr.c
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 0516259be70f..2c3c29aee7da 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -53,6 +53,7 @@ FILES=                                          \
>           test-sdt.bin                           \
>           test-cxx.bin                           \
>           test-jvmti.bin				\
> +         test-jvmti-cmlr.bin			\
>           test-sched_getcpu.bin			\
>           test-setns.bin				\
>           test-libopencsd.bin			\
> @@ -259,6 +260,9 @@ $(OUTPUT)test-cxx.bin:
>  $(OUTPUT)test-jvmti.bin:
>  	$(BUILD)
>  
> +$(OUTPUT)test-jvmti-cmlr.bin:
> +	$(BUILD)
> +
>  $(OUTPUT)test-llvm.bin:
>  	$(BUILDXX) -std=gnu++11 				\
>  		-I$(shell $(LLVM_CONFIG) --includedir) 		\
> diff --git a/tools/build/feature/test-jvmti-cmlr.c b/tools/build/feature/test-jvmti-cmlr.c
> new file mode 100644
> index 000000000000..c27b5b71a0f6
> --- /dev/null
> +++ b/tools/build/feature/test-jvmti-cmlr.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <jvmti.h>
> +#include <jvmticmlr.h>
> +
> +int main(void)
> +{
> +	jvmtiCompiledMethodLoadInlineRecord	rec __attribute__((unused));
> +	jvmtiCompiledMethodLoadRecordHeader	hdr __attribute__((unused));
> +	PCStackInfo				p   __attribute__((unused));
> +	return 0;
> +}
> diff --git a/tools/build/feature/test-jvmti.c b/tools/build/feature/test-jvmti.c
> index 5cf31192f204..799916d2e3e3 100644
> --- a/tools/build/feature/test-jvmti.c
> +++ b/tools/build/feature/test-jvmti.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <jvmti.h>
> -#include <jvmticmlr.h>
>  
>  int main(void)
>  {
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index e30d20fb482d..16b30a3b7c74 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -847,6 +847,13 @@ ifndef NO_JVMTI
>    $(call feature_check,jvmti)
>    ifeq ($(feature-jvmti), 1)
>      $(call detected_var,JDIR)
> +    ifndef NO_JVMTI_CMLR
> +      FEATURE_CHECK_CFLAGS-jvmti-cmlr := $(FEATURE_CHECK_CFLAGS-jvmti)
> +      $(call feature_check,jvmti-cmlr)
> +      ifeq ($(feature-jvmti-cmlr), 1)
> +        CFLAGS += -DHAVE_JVMTI_CMLR
> +      endif
> +    endif # NO_JVMTI_CMLR
>    else
>      $(warning No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel)
>      NO_JVMTI := 1
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index caf389051e90..1eaab256ecf1 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -95,6 +95,9 @@ include ../scripts/utilities.mak
>  #
>  # Define NO_JVMTI if you do not want jvmti agent built
>  #
> +# Define NO_JVMTI_CMLR (debug only) if you do not want to process CMLR
> +# data for java source lines.
> +#
>  # Define LIBCLANGLLVM if you DO want builtin clang and llvm support.
>  # When selected, pass LLVM_CONFIG=/path/to/llvm-config to `make' if
>  # llvm-config is not in $PATH.
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index 6add3e982614..aea7b1fe85aa 100644
> --- a/tools/perf/jvmti/libjvmti.c
> +++ b/tools/perf/jvmti/libjvmti.c
> @@ -6,7 +6,9 @@
>  #include <stdlib.h>
>  #include <err.h>
>  #include <jvmti.h>
> +#ifdef HAVE_JVMTI_CMLR
>  #include <jvmticmlr.h>
> +#endif
>  #include <limits.h>
>  
>  #include "jvmti_agent.h"
> @@ -27,6 +29,7 @@ static void print_error(jvmtiEnv *jvmti, const char *msg, jvmtiError ret)
>  	}
>  }
>  
> +#ifdef HAVE_JVMTI_CMLR
>  static jvmtiError
>  do_get_line_numbers(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
>  		    jvmti_line_info_t *tab, jint *nr)
> @@ -125,6 +128,15 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
>  	*nr_lines = lines_total;
>  	return JVMTI_ERROR_NONE;
>  }
> +#else /* HAVE_JVMTI_CMLR */
> +
> +static jvmtiError
> +get_line_numbers(jvmtiEnv *jvmti __maybe_unused, const void *compile_info __maybe_unused,
> +		 jvmti_line_info_t **tab __maybe_unused, int *nr_lines __maybe_unused)
> +{
> +	return JVMTI_ERROR_NONE;
> +}
> +#endif /* HAVE_JVMTI_CMLR */
>  
>  static void
>  copy_class_filename(const char * class_sign, const char * file_name, char * result, size_t max_length)
> -- 
> 2.17.2
