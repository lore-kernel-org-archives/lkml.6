Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA63222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393648AbfBNP40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:56:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404857AbfBNP4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:56:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C595B89AD9;
        Thu, 14 Feb 2019 15:56:23 +0000 (UTC)
Received: from krava (unknown [10.43.17.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5A86D5C54B;
        Thu, 14 Feb 2019 15:56:21 +0000 (UTC)
Date:   Thu, 14 Feb 2019 16:56:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools build: Add test-reallocarray.c to test-all.c to
 fix the build Was: Re: reallocarray failure on centos:7 superseded by raw
 data API
Message-ID: <20190214155619.GA18997@krava>
References: <20190212205557.GM3269@kernel.org>
 <20190212205750.GN3269@kernel.org>
 <D9304DB8-0E43-49D0-9F61-871CB14473F8@fb.com>
 <CAEf4BzaCMq5C94bp31Ew=PqcasfuUm-dEvSi6p9ErduRHRgGTA@mail.gmail.com>
 <CA+JHD93gPW4oPkumPK36UkQv_2AOxywAzTjDXz1VgJ7YHa5qBg@mail.gmail.com>
 <CAEf4BzYGzgoZ2c_zuvyjM1d734dMKLm_9Ki8XfFvUGMCMxU=Lw@mail.gmail.com>
 <20190213133855.GB1904@kernel.org>
 <20190213142136.GC1904@kernel.org>
 <CAEf4BzaNBSxZCVC2myZRkn4N8WLJ6cCtV1M6Qy-3e7ZHJHZp6A@mail.gmail.com>
 <20190214153018.GA23266@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214153018.GA23266@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 14 Feb 2019 15:56:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:30:18PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

>     
>     Reported-by: Jin Yao <yao.jin@linux.intel.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexei Starovoitov <ast@fb.com>
>     Cc: Daniel Borkmann <daniel@iogearbox.net>
>     Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Song Liu <songliubraving@fb.com>
>     Cc: Yonghong Song <yhs@fb.com>
>     Fixes: 531b014e7a2f ("tools: bpf: make use of reallocarray")
>     Link: https://lkml.kernel.org/n/tip-aonqku8axii8rxki5g11w40b@git.kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>


Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> index 74329957553a..e903b86b742f 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -174,6 +174,10 @@
>  # include "test-libaio.c"
>  #undef main
>  
> +#define main main_test_reallocarray
> +# include "test-reallocarray.c"
> +#undef main
> +
>  int main(int argc, char *argv[])
>  {
>  	main_test_libpython();
> @@ -214,6 +218,7 @@ int main(int argc, char *argv[])
>  	main_test_sdt();
>  	main_test_setns();
>  	main_test_libaio();
> +	main_test_reallocarray();
>  
>  	return 0;
>  }
> diff --git a/tools/build/feature/test-reallocarray.c b/tools/build/feature/test-reallocarray.c
> index 8170de35150d..8f6743e31da7 100644
> --- a/tools/build/feature/test-reallocarray.c
> +++ b/tools/build/feature/test-reallocarray.c
> @@ -6,3 +6,5 @@ int main(void)
>  {
>  	return !!reallocarray(NULL, 1, 1);
>  }
> +
> +#undef _GNU_SOURCE
