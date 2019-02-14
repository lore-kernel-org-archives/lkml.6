Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2415C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFBB222DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550159924;
	bh=wM1Ga5uy/ZZbdaaYDJ+MHNE5B9JBZI8iKIXcZ/itppg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=II5acBseN0v60U7KTzo/4xMDi/So9XK+Bt1ROWVqf+yIwURiXC16v54xQQjiua3RA
	 eHWo4RWizoiEeeRUK9SQeRNLm5G13JPxAF6jVjSGMOeG+LEkD/bDJktnsoRyzkWrDy
	 jNKgCMUxa5LJ6uhdRTjBKQ4nJ5O+TTbhEkj5JnCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407686AbfBNP6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:58:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfBNP6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:58:40 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 065B1222DD;
        Thu, 14 Feb 2019 15:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550159920;
        bh=wM1Ga5uy/ZZbdaaYDJ+MHNE5B9JBZI8iKIXcZ/itppg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UsyvUooo6J1nQeK0R9SUJq9sBrULjlroQrlrOvIESxx16YQStqm/Tu6pVVyENNWu9
         4eBCZLgm2xRT2vThaN3an7/TyevukQqtduJstoKOtnzr+XZ45BiASGf5AGdgpzU7u8
         QLLIIvBjA6DrlIpujD1axnojDOUyGrHtmT73fE/c=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DEE3A410D5; Thu, 14 Feb 2019 12:58:36 -0300 (-03)
Date:   Thu, 14 Feb 2019 12:58:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
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
Message-ID: <20190214155836.GB23266@kernel.org>
References: <20190212205750.GN3269@kernel.org>
 <D9304DB8-0E43-49D0-9F61-871CB14473F8@fb.com>
 <CAEf4BzaCMq5C94bp31Ew=PqcasfuUm-dEvSi6p9ErduRHRgGTA@mail.gmail.com>
 <CA+JHD93gPW4oPkumPK36UkQv_2AOxywAzTjDXz1VgJ7YHa5qBg@mail.gmail.com>
 <CAEf4BzYGzgoZ2c_zuvyjM1d734dMKLm_9Ki8XfFvUGMCMxU=Lw@mail.gmail.com>
 <20190213133855.GB1904@kernel.org>
 <20190213142136.GC1904@kernel.org>
 <CAEf4BzaNBSxZCVC2myZRkn4N8WLJ6cCtV1M6Qy-3e7ZHJHZp6A@mail.gmail.com>
 <20190214153018.GA23266@kernel.org>
 <20190214155042.GB16707@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214155042.GB16707@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 14, 2019 at 04:50:42PM +0100, Jiri Olsa escreveu:
> On Thu, Feb 14, 2019 at 12:30:18PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> > index 74329957553a..e903b86b742f 100644
> > --- a/tools/build/feature/test-all.c
> > +++ b/tools/build/feature/test-all.c
> > @@ -174,6 +174,10 @@
> >  # include "test-libaio.c"
> >  #undef main
> >  
> > +#define main main_test_reallocarray
> > +# include "test-reallocarray.c"
> > +#undef main
> > +
> >  int main(int argc, char *argv[])
> >  {
> >  	main_test_libpython();
> > @@ -214,6 +218,7 @@ int main(int argc, char *argv[])
> >  	main_test_sdt();
> >  	main_test_setns();
> >  	main_test_libaio();
> > +	main_test_reallocarray();
> >  
> >  	return 0;
> >  }
> > diff --git a/tools/build/feature/test-reallocarray.c b/tools/build/feature/test-reallocarray.c
> > index 8170de35150d..8f6743e31da7 100644
> > --- a/tools/build/feature/test-reallocarray.c
> > +++ b/tools/build/feature/test-reallocarray.c
> > @@ -6,3 +6,5 @@ int main(void)
> >  {
> >  	return !!reallocarray(NULL, 1, 1);
> >  }
> > +
> > +#undef _GNU_SOURCE
> 
> nice, also test-sched_getcpu.c does not do #undef _GNU_SOURCE


Thanks, I'll fix that, since those tests are included one after the
other in test-all.c, they shouldn't lead those defines in place,
otherwise they will fail, as I fixed in other cases, but somehow missed
this one.

[acme@quaco perf]$ grep _GNU_SOURCE tools/build/feature/test-*.c
tools/build/feature/test-get_current_dir_name.c:#define _GNU_SOURCE
tools/build/feature/test-get_current_dir_name.c:#undef _GNU_SOURCE
tools/build/feature/test-libpython.c:#undef _GNU_SOURCE
tools/build/feature/test-reallocarray.c:#define _GNU_SOURCE
tools/build/feature/test-reallocarray.c:#undef _GNU_SOURCE
tools/build/feature/test-sched_getcpu.c:#ifndef _GNU_SOURCE
tools/build/feature/test-sched_getcpu.c:#define _GNU_SOURCE
tools/build/feature/test-setns.c:#define _GNU_SOURCE
tools/build/feature/test-setns.c:#undef _GNU_SOURCE
[acme@quaco perf]$

Its just because all the preceding ones undef it and the ones following
it doesn't define it:

$ cat tools/build/feature/test-all.c
<SNIP>
#define main main_test_libaio
# include "test-libaio.c"
#undef main

#define main main_test_reallocarray
# include "test-reallocarray.c"
#undef main

int main(int argc, char *argv[])
{
        main_test_libpython();
        main_test_libpython_version();
<SNIP>
        main_test_bpf();
        main_test_libcrypto();
        main_test_sched_getcpu();
        main_test_sdt();
        main_test_setns();
        main_test_libaio();
        main_test_reallocarray();

        return 0;
}
<SNIP>

- Arnaldo
