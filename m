Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33582ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3A0214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irh4KJLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3A0214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbeIRGW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:22:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43694 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIRGW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:22:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so105946pgb.10;
        Mon, 17 Sep 2018 17:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5aTPzpyTxiVqTJPxdFfzdWiBaENdhZvvSCpr7AowvCw=;
        b=Irh4KJLipVh+kGqhkuJQ3+mfEeWue72aeajWTBGnghx1t1tqk81VmIO11I3Mi1A6Rj
         fhYdenUUhTQJtqQPE3oV9/POnY+PjAtd1/Av+VCr99Fy/+Q264YMdyXDg6Ze+xSDMvOv
         eb1rHPj58wIWm2JHQKnx7o84nIPlSw7R91CC3jRguc8YQcdx4Bn+WSGUIggZzfh6bKSb
         0Du3yU3hEeRrSVoXS7XtbpqE2O5ILQQYwH3uQDGv061gmJSEguG7tM/L9RSi4ydIYGTO
         nq6PRaCbrTgVcZ/81RJgLzfhfqksjn66+MCmPzMu2lDU3RM5rUyM8CTahccmgaPMZ/Uv
         DKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5aTPzpyTxiVqTJPxdFfzdWiBaENdhZvvSCpr7AowvCw=;
        b=nQ/c+iDOlm6OILpN/rsss6+11mXEGDwcRzz/Bs0sDjCO5jvMSSYO5kqsFECQSRh+w2
         N1LOSSIc21dp7FVYzWKp8Z9dgdQU3k6wxxxCPy7tzPYgAbfoKWd2IZGtYW2wTpXOViP9
         oXnSOF/ozhD1H9Y+GVCiyEQ3MJa16hV5otJTtqT1MNfr84UqWLteyZZeph4y8lbI1a0k
         BMEnDxUUrD4B0sOG5KcZss2vMoN20B7YvisFZ+Dy23j9wQhT7K97nxtGUojXI1YwhxSt
         Jx6SfX3yVMDlhfc9OinKEDgqdCHIV+qDL6jKju2EQZhAUefCWsGae+mNapS/N/Y5mAyx
         KILA==
X-Gm-Message-State: APzg51A1n4giiAf+5LMCCLtn0zNMQ/p9UVuqP8snSdGr5JM7ymAt/SVa
        mcMnDSEPrzMua+Ekmc556LI=
X-Google-Smtp-Source: ANB0VdaREN7i6cREvHFmBesL2BpZmpvl5zwGFW1r09K+AiFC/3VwTw0jqnwNN4B4lMnyEaUJc2rtPQ==
X-Received: by 2002:a63:1d22:: with SMTP id d34-v6mr25957160pgd.133.1537231980855;
        Mon, 17 Sep 2018 17:53:00 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::1:5e9b])
        by smtp.gmail.com with ESMTPSA id i26-v6sm19433824pfo.107.2018.09.17.17.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:52:59 -0700 (PDT)
Date:   Mon, 17 Sep 2018 17:52:59 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC/fix] Re: libbpf build broken on musl libc (Alpine Linux)
Message-ID: <20180918005256.7uutwda4s3ofoxpd@ast-mbp>
References: <20180910172903.GB15516@kernel.org>
 <20180911122218.0d2eb3f9@cakuba>
 <20180911121543.GB22689@kernel.org>
 <20180911212451.hvnyfwyvcs4yojqy@ast-mbp>
 <20180913183240.GF30969@kernel.org>
 <20180913185629.su22fnimluoezntg@ast-mbp>
 <20180917151636.GA21790@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917151636.GA21790@kernel.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 12:16:36PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 13, 2018 at 11:56:31AM -0700, Alexei Starovoitov escreveu:
> > On Thu, Sep 13, 2018 at 03:32:40PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Please do some testing with my perf/libbpf+str_error_r branch, it has
> > > two patches to get this fixed, the one I sent and a prep one making
> > > libbpf link against libapi.
> 
> > > [acme@jouet perf]$ git log --oneline -2
> > > a7ab924b7fec (HEAD -> perf/urgent, acme.korg/perf/libbpf+str_error_r) tools lib bpf: Use str_error_r() to fix the build in Alpine Linux
> > > fb4a79e04c2b tools lib bpf: Build and link to tools/lib/api/
>  
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/libbpf%2bstr_error_r&id=fb4a79e04c2b37ee873a3b31a3250925cf466fff
> > we cannot do this.
> > lib/api is GPL we cannot use it in LGPL library.
> 
> So, look at this second attempt, are you ok with it?
> 
> Builds with all the Alpine Linux test build containers and some more,
> still building with all the others:
> 
>    1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
>    2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
>    3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
>    4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
>    5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
>    6 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
>    7 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
>    8 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
>    9 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   10 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   11 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
>   12 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
>   13 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
>   14 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
>   15 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
>   16 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
>   17 debian:experimental           : Ok   gcc (Debian 8.2.0-4) 8.2.0
>   18 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-4) 8.2.0
>   19 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.2.0-4) 8.2.0
> 
> commit 1ca0d8249e5bd335b1c33a33569e4ed94025128e
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Fri Sep 14 16:47:14 2018 -0300
> 
>     tools lib bpf: Provide wrapper for strerror_r to build in !_GNU_SOURCE systems
>     
>     Same problem that got fixed in a similar fashion in tools/perf/ in
>     c8b5f2c96d1b ("tools: Introduce str_error_r()"), fix it in the same
>     way, licensing needs to be sorted out to libbpf to use libapi, so,
>     for this simple case, just get the same wrapper in tools/lib/bpf.
>     
>     This makes libbpf and its users (bpftool, selftests, perf) to build
>     again in Alpine Linux 3.[45678] and edge.
>     
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexei Starovoitov <ast@kernel.org>
>     Cc: Daniel Borkmann <daniel@iogearbox.net>
>     Cc: David Ahern <dsahern@gmail.com>
>     Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
>     Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Martin KaFai Lau <kafai@fb.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Quentin Monnet <quentin.monnet@netronome.com>
>     Cc: Thomas Richter <tmricht@linux.ibm.com>
>     Cc: Wang Nan <wangnan0@huawei.com>
>     Cc: Yonghong Song <yhs@fb.com>
>     Fixes: 1ce6a9fc1549 ("bpf: fix build error in libbpf with EXTRA_CFLAGS="-Wp, -D_FORTIFY_SOURCE=2 -O2"")
>     Link: https://lkml.kernel.org/n/tip-i8ckf6s06e7tayw7xxhhhkux@git.kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
> index 13a861135127..6eb9bacd1948 100644
> --- a/tools/lib/bpf/Build
> +++ b/tools/lib/bpf/Build
> @@ -1 +1 @@
> -libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o
> +libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2abd0f112627..bdb94939fd60 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -50,6 +50,7 @@
>  #include "libbpf.h"
>  #include "bpf.h"
>  #include "btf.h"
> +#include "str_error.h"
>  
>  #ifndef EM_BPF
>  #define EM_BPF 247
> @@ -469,7 +470,7 @@ static int bpf_object__elf_init(struct bpf_object *obj)
>  		obj->efile.fd = open(obj->path, O_RDONLY);
>  		if (obj->efile.fd < 0) {
>  			char errmsg[STRERR_BUFSIZE];
> -			char *cp = strerror_r(errno, errmsg, sizeof(errmsg));
> +			char *cp = str_error(errno, errmsg, sizeof(errmsg));
>  
>  			pr_warning("failed to open %s: %s\n", obj->path, cp);
>  			return -errno;
> @@ -810,8 +811,7 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
>  						      data->d_size, name, idx);
>  			if (err) {
>  				char errmsg[STRERR_BUFSIZE];
> -				char *cp = strerror_r(-err, errmsg,
> -						      sizeof(errmsg));
> +				char *cp = str_error(-err, errmsg, sizeof(errmsg));
>  
>  				pr_warning("failed to alloc program %s (%s): %s",
>  					   name, obj->path, cp);
> @@ -1140,7 +1140,7 @@ bpf_object__create_maps(struct bpf_object *obj)
>  
>  		*pfd = bpf_create_map_xattr(&create_attr);
>  		if (*pfd < 0 && create_attr.btf_key_type_id) {
> -			cp = strerror_r(errno, errmsg, sizeof(errmsg));
> +			cp = str_error(errno, errmsg, sizeof(errmsg));
>  			pr_warning("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
>  				   map->name, cp, errno);
>  			create_attr.btf_fd = 0;
> @@ -1155,7 +1155,7 @@ bpf_object__create_maps(struct bpf_object *obj)
>  			size_t j;
>  
>  			err = *pfd;
> -			cp = strerror_r(errno, errmsg, sizeof(errmsg));
> +			cp = str_error(errno, errmsg, sizeof(errmsg));
>  			pr_warning("failed to create map (name: '%s'): %s\n",
>  				   map->name, cp);
>  			for (j = 0; j < i; j++)
> @@ -1339,7 +1339,7 @@ load_program(enum bpf_prog_type type, enum bpf_attach_type expected_attach_type,
>  	}
>  
>  	ret = -LIBBPF_ERRNO__LOAD;
> -	cp = strerror_r(errno, errmsg, sizeof(errmsg));
> +	cp = str_error(errno, errmsg, sizeof(errmsg));
>  	pr_warning("load bpf program failed: %s\n", cp);
>  
>  	if (log_buf && log_buf[0] != '\0') {
> @@ -1654,7 +1654,7 @@ static int check_path(const char *path)
>  
>  	dir = dirname(dname);
>  	if (statfs(dir, &st_fs)) {
> -		cp = strerror_r(errno, errmsg, sizeof(errmsg));
> +		cp = str_error(errno, errmsg, sizeof(errmsg));
>  		pr_warning("failed to statfs %s: %s\n", dir, cp);
>  		err = -errno;
>  	}
> @@ -1690,7 +1690,7 @@ int bpf_program__pin_instance(struct bpf_program *prog, const char *path,
>  	}
>  
>  	if (bpf_obj_pin(prog->instances.fds[instance], path)) {
> -		cp = strerror_r(errno, errmsg, sizeof(errmsg));
> +		cp = str_error(errno, errmsg, sizeof(errmsg));
>  		pr_warning("failed to pin program: %s\n", cp);
>  		return -errno;
>  	}
> @@ -1708,7 +1708,7 @@ static int make_dir(const char *path)
>  		err = -errno;
>  
>  	if (err) {
> -		cp = strerror_r(-err, errmsg, sizeof(errmsg));
> +		cp = str_error(-err, errmsg, sizeof(errmsg));
>  		pr_warning("failed to mkdir %s: %s\n", path, cp);
>  	}
>  	return err;
> @@ -1770,7 +1770,7 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
>  	}
>  
>  	if (bpf_obj_pin(map->fd, path)) {
> -		cp = strerror_r(errno, errmsg, sizeof(errmsg));
> +		cp = str_error(errno, errmsg, sizeof(errmsg));
>  		pr_warning("failed to pin map: %s\n", cp);
>  		return -errno;
>  	}
> diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
> new file mode 100644
> index 000000000000..b8798114a357
> --- /dev/null
> +++ b/tools/lib/bpf/str_error.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: LGPL-2.1
> +#undef _GNU_SOURCE
> +#include <string.h>
> +#include <stdio.h>
> +#include "str_error.h"
> +
> +/*
> + * Wrapper to allow for building in non-GNU systems such as Alpine Linux's musl
> + * libc, while checking strerror_r() return to avoid having to check this in
> + * all places calling it.
> + */
> +char *str_error(int err, char *dst, int len)
> +{
> +	int ret = strerror_r(err, dst, len);
> +	if (ret)
> +		snprintf(dst, len, "ERROR: strerror_r(%d)=%d", err, ret);
> +	return dst;
> +}
> diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
> new file mode 100644
> index 000000000000..b9a22564ddc6
> --- /dev/null
> +++ b/tools/lib/bpf/str_error.h
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.1

LGPL-2.1 in the above?

The rest looks good to me.
Should we take it via bpf-next tree?
If you feel there is an urgency to fix musl build, we can take it via bpf tree too.

Jakub, thoughts? you've been messing with strerror last..

