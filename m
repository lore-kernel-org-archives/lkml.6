Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CD9C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5B920685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="TktAEwWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5B920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbeGZDDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:03:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34899 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbeGZDDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:03:06 -0400
Received: by mail-qt0-f195.google.com with SMTP id a5-v6so107521qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 18:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=aUG9f1IWSV9Bsf+H5cGZOGCe4o25xXyT6GwkaD6RM/8=;
        b=TktAEwWNMncHxeorLAM2nl9xoHO2jhkgzhtNyp+0Kjqp/p/BQS9Nab9YCmv6b1V6IR
         XDw/gLfYo40A9bHKa1qYuXaUww9N/vzdm1qX4P2I6bduZw/NosLv7O0q2tZS/eNKB4J5
         OT+c1pewIEeF8iDqdS+BqjQolhEF7Q1iKC0/kYAJBWqVMMvCDdskkfREYNMxBySlUHVk
         s51GwMdXJio/+JKG20kVa7709B7p+kG14GOjPgSRmMxyTTASZgCkvnvb8+4j4ekxb374
         a24ySK8XwqexL21ZxtfmJ7PeuowMbZSwIr6WUooWY7b0AKeFB7iRWgx3utRFhlKomPD3
         mXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=aUG9f1IWSV9Bsf+H5cGZOGCe4o25xXyT6GwkaD6RM/8=;
        b=iLsRRYPnJ2AG4GXDzBaUxuFksLd7nO7dA2O3RMFZqmE6dSPN7xhJZTYSBooijIIjwO
         rvQnvrevGvsKCHvViMsOc7wE6qQqpCQItltGpwcp21E0EbGhqMwHrSQ3YRrB6rb6TiSM
         kXcYCk8TY9FxRjVAMk5qS2aG65WtWVFBkwt5PI1dlCVWmeoIr1acrcUD1aP+uJcfpkDV
         ThpjBqfBTISxNqRR9YKLJga0IkM741OM4pXmBaWhIdjed8lb8WZNLnQ94apIKmWmxWp1
         enLEx78cK/ZSnKDZtTexmTC0XxDfrEFqHIWXI5QHrC6MfUgIOcm54mpZb7uo/xzcqCUJ
         n6mg==
X-Gm-Message-State: AOUpUlEIEg7djiBxRkU4a/Q0Wml1l+iwWV34Gu/BideeggjpycH3f6Jx
        TeWnQFJnYDgoWDnDCESO3U36Qg==
X-Google-Smtp-Source: AAOMgpd9haDUg7hg+vnozgzClwkb4s7c3ZrfmWOxL0rp1+MRAsLtNQPZUPggbonTL2Pd4sDfqVOCng==
X-Received: by 2002:ac8:43da:: with SMTP id w26-v6mr22872597qtn.137.1532569720515;
        Wed, 25 Jul 2018 18:48:40 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id t11-v6sm16538qkt.28.2018.07.25.18.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 18:48:40 -0700 (PDT)
Date:   Wed, 25 Jul 2018 18:48:35 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        wangnan0@huawei.com
Subject: Re: [PATCH v2] perf build: Build error in libbpf with
 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
Message-ID: <20180725184835.5d37bef4@cakuba.netronome.com>
In-Reply-To: <20180725072126.2232-1-tmricht@linux.ibm.com>
References: <20180725072126.2232-1-tmricht@linux.ibm.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 09:21:26 +0200, Thomas Richter wrote:
> commit a5b8bd47dcc57 ("bpf tools: Collect eBPF programs from their own se=
ctions")

Hmm.. are you sure it's not 531b014e7a2f ("tools: bpf: make use of
reallocarray") that caused the issue?  That commit made us switch from
XSI-compliant to GNU-specific strerror_r() implementation..

/me checks

Yes it looks like 531b014e7a2f~ builds just fine.

Daniel, did you try to apply v1 to the bpf tree?  Perhaps there is a
confusion about the trees here, if this is caused by my recent change
it's a bpf-next material.  strerror() works, but strerror_r() seems
nicer, so perhaps we could keep it if the patch worked in bpf-next?

> causes a compiler error when building the perf tool in the linux-next tre=
e.
> I compile it using a FEDORA 28 installation, my gcc compiler version:
> gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
>=20
> The file that causes the error is tools/lib/bpf/libbpf.c
>=20
> Here is the error message:
>=20
> [root@p23lp27] # make V=3D1 EXTRA_CFLAGS=3D"-Wp,-D_FORTIFY_SOURCE=3D2 -O2"
> [...]
> make -f /home6/tmricht/linux-next/tools/build/Makefile.build
> 	dir=3D./util/scripting-engines obj=3Dlibperf
> libbpf.c: In function =E2=80=98bpf_object__elf_collect=E2=80=99:
> libbpf.c:811:15: error: ignoring return value of =E2=80=98strerror_r=E2=
=80=99,
> 		declared with attribute warn_unused_result [-Werror=3Dunused-result]
>      strerror_r(-err, errmsg, sizeof(errmsg));
>                ^
> cc1: all warnings being treated as errors
> mv: cannot stat './.libbpf.o.tmp': No such file or directory
> /home6/tmricht/linux-next/tools/build/Makefile.build:96: recipe for targe=
t 'libbpf.o' failed
>=20
> Since this is the only occurance of strerror_r() replace it
> by strerror(). The additional functionality of strerror_r() to
> copy the error message into the supplied buffer is not needed.
> This is also consistant with all the other pr_warning() statements
> in this file which all use strerror().
>=20
> Also fixes a possible initialization issue.
>=20
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>
>  tools/lib/bpf/libbpf.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 955f8eafbf41..f9eb68ff2f4f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -806,11 +806,8 @@ static int bpf_object__elf_collect(struct bpf_object=
 *obj)
>  			err =3D bpf_object__add_program(obj, data->d_buf,
>  						      data->d_size, name, idx);
>  			if (err) {
> -				char errmsg[STRERR_BUFSIZE];
> -
> -				strerror_r(-err, errmsg, sizeof(errmsg));
>  				pr_warning("failed to alloc program %s (%s): %s",
> -					   name, obj->path, errmsg);
> +					   name, obj->path, strerror(-err));
>  			}
>  		} else if (sh.sh_type =3D=3D SHT_REL) {
>  			void *reloc =3D obj->efile.reloc;
> @@ -2334,7 +2331,7 @@ bpf_perf_event_read_simple(void *mem, unsigned long=
 size,
>  	__u64 data_tail =3D header->data_tail;
>  	__u64 data_head =3D header->data_head;
>  	void *base, *begin, *end;
> -	int ret;
> +	int ret =3D 0;
> =20
>  	asm volatile("" ::: "memory"); /* in real code it should be smp_rmb() */
>  	if (data_head =3D=3D data_tail)

This looks like a separate issue.  The ret variable should really be
enum bpf_perf_event_ret, so could you please initialize it to one of the
values of this enum?

The uninitilized condition can only happen if (data_head !=3D data_tail)
but at the same time (data_head % size =3D=3D data_tail % size) which
should never really happen...  Perhaps initializing to
LIBBPF_PERF_EVENT_ERROR would make sense?

Or better still adding:

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f732237610e5..fa5a25945f19 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2289,6 +2289,8 @@ bpf_perf_event_read_simple(void *mem, unsigned long s=
ize,
=20
        begin =3D base + data_tail % size;
        end =3D base + data_head % size;
+       if (being =3D=3D end)
+               return LIBBPF_PERF_EVENT_ERROR;
=20
        while (begin !=3D end) {
                struct perf_event_header *ehdr;
