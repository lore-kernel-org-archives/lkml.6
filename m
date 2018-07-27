Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB06C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396C120673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="uJXXJkVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396C120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbeG0VUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:20:02 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38289 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389211AbeG0VUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:20:02 -0400
Received: by mail-qt0-f195.google.com with SMTP id y19-v6so6287552qto.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=MO+Pmh+CqC0Ra8ern4mOvLzGMmeseHZvch1HmG1W+/E=;
        b=uJXXJkVq3wT2MIDZWBrNpYLg5awov1FCGGqBO9idiYrCDp0iYdrx/8fqM6Yk4DrPGR
         89o9tOR38o4zHuvLanKUjsx4sT26o2eWNjlbjzWch/R0RtcUIAZOdtTBfuNXgXCMb9IE
         x6GXNf+XDsE9bM4T4rRvLggyuEjHO6aQ0K/c2w/9+gwfkEEKUR9pXELElPCwL//v3gyL
         7krMc6ltAWAINaoeZkOcYdf/p5WMnu8ygOwE3GjvwLLzIjyoCvQZn5uO/ZW+HbAPzrK9
         9RmaFRD4Ci55q1SLziMhYDam493Y36ixcS0OaC//f+OWE4cn0NUwDJf8fw2WXDziM3fy
         9L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=MO+Pmh+CqC0Ra8ern4mOvLzGMmeseHZvch1HmG1W+/E=;
        b=YPEI7yviWo9EVGvqCa8zpGxHIgxnUYbluNchhvrbikuE1/sgWRto0jTV3364le2BQA
         6PySTTrilwN7I0J+E5JOdWgJSeCBFFzoGo5Yytji9nNtoZOJ7nWf091sHgE/HwY4DsAU
         r0YTnpqckrU+BfqTuWGx8nxbSYTGdBWMT5UZ/+SeY2YySBmlEwyIvF2+AIuAkc9agcxG
         Tzz4fDnjYTeVyi4/eZ0a9cpPuoGADQiDniPw5VDn3LjJ96qbWI2RN0KYnvFxgkcqznC3
         BHPTiXFd2HyCDsWjNFCg3PI6JuK3czZtNEnilneJ5z040EgyXucWdFFMklQCJPz2mM7d
         mOtg==
X-Gm-Message-State: AOUpUlGBKZj02aS+xWSJig4D/mkXivA7B6Ms1fDlurogvrQWPj84AXUI
        /uwwpjl2V7ABi9Eu4967A+exsQ==
X-Google-Smtp-Source: AAOMgpcP8JgG5M7vFtn7EP0PYLaPQmJnHKNQi02KkEkNWoDd3uFf0BZ8bJjJrQRd5t/FvQRionhx3w==
X-Received: by 2002:a0c:f002:: with SMTP id z2-v6mr7006274qvk.160.1532721396772;
        Fri, 27 Jul 2018 12:56:36 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e67-v6sm2616406qtb.33.2018.07.27.12.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 12:56:36 -0700 (PDT)
Date:   Fri, 27 Jul 2018 12:56:32 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Thomas Richter <tmricht@linux.ibm.com>, ast@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        heiko.carstens@de.ibm.com, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com
Subject: Re: [PATCH] perf build: Build error in libbpf missing
 initialization
Message-ID: <20180727125632.33634af5@cakuba.netronome.com>
In-Reply-To: <c8409ab8-69df-17f4-9da3-610c60143d9a@iogearbox.net>
References: <20180727082126.87530-1-tmricht@linux.ibm.com>
        <20180727105923.2d5da6aa@cakuba.netronome.com>
        <c8409ab8-69df-17f4-9da3-610c60143d9a@iogearbox.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018 21:31:01 +0200, Daniel Borkmann wrote:
> On 07/27/2018 07:59 PM, Jakub Kicinski wrote:
> > On Fri, 27 Jul 2018 10:21:26 +0200, Thomas Richter wrote: =20
> >> In linux-next tree compiling the perf tool with additional make flags
> >> "EXTRA_CFLAGS=3D"-Wp,-D_FORTIFY_SOURCE=3D2 -O2"
> >> causes a compiler error. It is the warning
> >> 	'variable may be used uninitialized'
> >> which is treated as error:
> >>
> >> I compile it using a FEDORA 28 installation, my gcc compiler version:
> >> gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
> >>
> >> The file that causes the error is tools/lib/bpf/libbpf.c
> >>
> >> Here is the error message:
> >>
> >> [root@p23lp27] # make V=3D1 EXTRA_CFLAGS=3D"-Wp,-D_FORTIFY_SOURCE=3D2 =
-O2"
> >> [...]
> >> Makefile.config:849: No openjdk development package found, please
> >>    install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> >> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h'
> >>         differs from latest version at 'include/uapi/linux/if_link.h'
> >>   CC       libbpf.o
> >> libbpf.c: In function =E2=80=98bpf_perf_event_read_simple=E2=80=99:
> >> libbpf.c:2342:6: error: =E2=80=98ret=E2=80=99 may be used uninitialize=
d in this
> >> 			function [-Werror=3Dmaybe-uninitialized]
> >>   int ret;
> >>       ^
> >> cc1: all warnings being treated as errors
> >> mv: cannot stat './.libbpf.o.tmp': No such file or directory
> >> /home6/tmricht/linux-next/tools/build/Makefile.build:96: recipe for ta=
rget 'libbpf.o' failed
> >>
> >> Fix this warning and add an addition check at the beginning
> >> of the while loop.
> >>
> >> Cc: Alexei Starovoitov <ast@kernel.org>
> >> Cc: Daniel Borkmann <daniel@iogearbox.net>
> >>
> >> Suggested-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> >> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com> =20
> >=20
> > Ah, you already sent this, LGTM, thanks Thomas!
> >  =20
> >>  tools/lib/bpf/libbpf.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 73465caa33ba..66965ca96113 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -2349,6 +2349,8 @@ bpf_perf_event_read_simple(void *mem, unsigned l=
ong size,
> >> =20
> >>  	begin =3D base + data_tail % size;
> >>  	end =3D base + data_head % size;
> >> +	if (begin =3D=3D end)
> >> +		return LIBBPF_PERF_EVENT_ERROR;
> >> =20
> >>  	while (begin !=3D end) {
> >>  		struct perf_event_header *ehdr; =20
>=20
> One question though, any objections to go for something like the below in=
stead?
> I doubt we ever hit this in a 'normal' situation, and given we already te=
st for
> the begin and end anyway, we could just avoid the extra test altogether. =
I could
> change it to the below if you're good as well (no need to resend anything=
):
>=20
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index d881d37..1aafdbe 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2273,8 +2273,8 @@ bpf_perf_event_read_simple(void *mem, unsigned long=
 size,
>         volatile struct perf_event_mmap_page *header =3D mem;
>         __u64 data_tail =3D header->data_tail;
>         __u64 data_head =3D header->data_head;
> +       int ret =3D LIBBPF_PERF_EVENT_ERROR;
>         void *base, *begin, *end;
> -       int ret;
>=20
>         asm volatile("" ::: "memory"); /* in real code it should be smp_r=
mb() */
>         if (data_head =3D=3D data_tail)

No real objection, although as a matter of personal taste I'm not a big
fan of initializing err/ret variables unless the code is explicitly
structured to make use of it.  Here it looks slightly more like
silencing a compiler warning, hence my preference to address the actual
cause of the warning rather than catch all.  I guess one could argue
the other way, i.e. if the loop never run (and therefore ret was not
overwritten) there must be *some* error.  I like verbose/explicit code I
guess..

Up to you :)
