Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B02C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D6E20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="LZn+N3m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D6E20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbeG0TVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:21:00 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44313 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388957AbeG0TVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:21:00 -0400
Received: by mail-pl0-f66.google.com with SMTP id m16-v6so2621532pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=JUmhw8k0LOa/b+1NaNRTBu41N0wMec+6AoNYcB95TTQ=;
        b=LZn+N3m6ny4SRAXtaMeCPKmr4fUKDcrFFO03fKb4iPM8CVoGFpvrCW+L2z84UgDDse
         O9IL54xpphtiMFsbY3Y/tJqk2foZ1p0LpiQLM0IJFzyIadrM9ZZyjw0fhRqbfxLWGx8E
         L0fX5BnNpYVJ5WnwITA9IoiM4ckHKuI5Ysei1ZcogiF1q6gXyMlRcWUhIVCoBtUEGeKe
         olzSG28ka5LoEOiwPUpkxPixFDug5qToauTRkViBrePNIjRM9eFNX7GrcdT/T1DV9cDE
         1crRv7LlxLYN5jdAzOnQF2jv6D8y7XlD5BYfAeavDdZZZJqat3i1hLaKd7O34IMYwmEr
         Ff5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=JUmhw8k0LOa/b+1NaNRTBu41N0wMec+6AoNYcB95TTQ=;
        b=VPlpwaX8j+5DglZ8CxOx6X7YW1lH8Qg3NPWHerC/Ypt9hMu6cQjH3dy0bs94rNoQEN
         5peciTuNYUWU9wIB5GNPd0q+PoC1PZOpc6aaGTJev0ls2nZ0v2X/IA3v93t/zudO4HLh
         FvC6GzZ6zG3S7VXntJHFR5zd39ntlaCEw6Iy6pzKVTirBQ1qbSDKn63nADBwIIbqrLG9
         QT/pU3m9eGucoO3PFaatrLBHCT5BIKLLWSkXSP+Q8g1fjJjmLo9WJmbu68WWFQh22WW7
         xFs92Kpl/C+SQb6EZGDB7jQHcBFFujo6anZY0rKrP2HbDzMXnszPh7o9WAIskvNlT0SL
         VobQ==
X-Gm-Message-State: AOUpUlE9v1GjeObNUX8Y33AwSeXr/f9VwKPlCBToWoRZ6VavhgkWpEG4
        f1Yuj3vw4llp9EK2ciJOFQZ06Q==
X-Google-Smtp-Source: AAOMgpdEIKQLtZjenYbjC/t4D5VtMbWSRY4ASN77f1332T0eAfAgO1lK3xK2QCwcyaTJzpx+cAcOmw==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr6935114plb.108.1532714281007;
        Fri, 27 Jul 2018 10:58:01 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-231-89-118.hsd1.ca.comcast.net. [73.231.89.118])
        by smtp.gmail.com with ESMTPSA id r81-v6sm9034758pfa.18.2018.07.27.10.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 10:58:00 -0700 (PDT)
Date:   Fri, 27 Jul 2018 10:57:57 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        heiko.carstens@de.ibm.com, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, wangnan0@huawei.com
Subject: Re: [PATCH v2] perf build: Build error in libbpf with
 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
Message-ID: <20180727105757.2d851920@cakuba.netronome.com>
In-Reply-To: <325e3d58-89fb-1b50-8865-22c6f372671a@linux.ibm.com>
References: <20180725072126.2232-1-tmricht@linux.ibm.com>
        <20180725184835.5d37bef4@cakuba.netronome.com>
        <08b6ed57-40a4-7468-b78d-f2a2c5ab10a8@iogearbox.net>
        <325e3d58-89fb-1b50-8865-22c6f372671a@linux.ibm.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018 09:22:03 +0200, Thomas-Mich Richter wrote:
> On 07/27/2018 04:16 AM, Daniel Borkmann wrote:
> > On 07/26/2018 03:48 AM, Jakub Kicinski wrote: =20
> >> On Wed, 25 Jul 2018 09:21:26 +0200, Thomas Richter wrote: =20
> >>> commit a5b8bd47dcc57 ("bpf tools: Collect eBPF programs from their ow=
n sections") =20
> >>
> >> Hmm.. are you sure it's not 531b014e7a2f ("tools: bpf: make use of
> >> reallocarray") that caused the issue?  That commit made us switch from
> >> XSI-compliant to GNU-specific strerror_r() implementation..
> >>
> >> /me checks
> >>
> >> Yes it looks like 531b014e7a2f~ builds just fine.
> >>
> >> Daniel, did you try to apply v1 to the bpf tree?  Perhaps there is a
> >> confusion about the trees here, if this is caused by my recent change
> >> it's a bpf-next material.  strerror() works, but strerror_r() seems
> >> nicer, so perhaps we could keep it if the patch worked in bpf-next? =20
> >=20
> > Yeah indeed, the issue is only in bpf-next. When I compile libbpf from
> > bpf tree with the below flags then it's all good>=20
> > Agree that we should rather use strerror_r() given this is a library. =
=20
>=20
> Are you sure to stick with strerror_r? I ask because it is the only
> occurence of strerror_r in this file. All other error messages use strerr=
or
> as in:
> pr_warning("failed to create map (name: '%s'): %s\n",
>                                    map->name,
>                                    strerror(errno));
>=20
>=20
> $ fgrep strerror tools/lib/bpf/libbpf.c
>                                         strerror(errno));
>           issue I try to solve--->  strerror_r(-err, errmsg, sizeof(errms=
g));
>                                    map->name, strerror(errno), errno);
>                                    strerror(errno));
>         pr_warning("load bpf program failed: %s\n", strerror(errno));
>                 pr_warning("failed to statfs %s: %s\n", dir, strerror(err=
no));
>                 pr_warning("failed to pin program: %s\n", strerror(errno)=
);
>                 pr_warning("failed to mkdir %s: %s\n", path, strerror(-er=
r));
>                 pr_warning("failed to pin map: %s\n", strerror(errno));
> $
>=20
> The next issue with strerror_r is to assign the return value to a variabl=
e.
> Then we end up with variable set but not used:
> libbpf.c: In function =E2=80=98bpf_object__elf_collect=E2=80=99:
> libbpf.c:809:35: error: variable =E2=80=98cp=E2=80=99 set but not used [-=
Werror=3Dunused-but-set-variable]
>      char errmsg[STRERR_BUFSIZE], *cp;
>                                    ^
> cc1: all warnings being treated as errors

       The GNU-specific strerror_r() returns a pointer to a string  contain=
ing
       the  error  message.  This may be either a pointer to a string that =
the
       function stores in buf, or a pointer to some (immutable) static  str=
ing
       (in which case buf is unused).  If the function stores a string in b=
uf,
       then at most buflen bytes are stored (the string may  be  truncated =
 if
       buflen is too small and errnum is unknown).  The string always inclu=
des
       a terminating null byte ('\0').

IOW you gotta use the return value.

> Here is the source:
>                        if (err) {
>                                 char errmsg[STRERR_BUFSIZE], *cp;
>=20
>                                 cp =3D strerror_r(-err, errmsg, sizeof(er=
rmsg));
>                                 pr_warning("failed to alloc program %s (%=
s): %s",
>                                            name, obj->path, errmsg);
>                         }
>=20
> To fix this requires something like:
>                                pr_warning("failed to alloc program %s (%s=
): %s",
>                                            name, obj->path, cp);

This looks correct.

> And after pr_warning() is done, the local array errmsg is deleted.
>=20
> A lot of overkill in my opinion, unless I miss something.

IMO using potentially mutli-thread unsafe functions in a library is not
optimal, we should strive to convert the other instances of strerror()
rather than move the other way.

> >>> causes a compiler error when building the perf tool in the linux-next=
 tree.
> >>> I compile it using a FEDORA 28 installation, my gcc compiler version:
> >>> gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
> >>>
> >>> The file that causes the error is tools/lib/bpf/libbpf.c
> >>>
> >>> Here is the error message: =20
> > [...] =20
> >>> @@ -2334,7 +2331,7 @@ bpf_perf_event_read_simple(void *mem, unsigned =
long size,
> >>>  	__u64 data_tail =3D header->data_tail;
> >>>  	__u64 data_head =3D header->data_head;
> >>>  	void *base, *begin, *end;
> >>> -	int ret;
> >>> +	int ret =3D 0;
> >>> =20
> >>>  	asm volatile("" ::: "memory"); /* in real code it should be smp_rmb=
() */
> >>>  	if (data_head =3D=3D data_tail) =20
> >>
> >> This looks like a separate issue.  The ret variable should really be
> >> enum bpf_perf_event_ret, so could you please initialize it to one of t=
he
> >> values of this enum?
> >>
> >> The uninitilized condition can only happen if (data_head !=3D data_tai=
l)
> >> but at the same time (data_head % size =3D=3D data_tail % size) which
> >> should never really happen...  Perhaps initializing to
> >> LIBBPF_PERF_EVENT_ERROR would make sense?
> >>
> >> Or better still adding:
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index f732237610e5..fa5a25945f19 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -2289,6 +2289,8 @@ bpf_perf_event_read_simple(void *mem, unsigned l=
ong size,
> >> =20
> >>         begin =3D base + data_tail % size;
> >>         end =3D base + data_head % size;
> >> +       if (being =3D=3D end)
> >> +               return LIBBPF_PERF_EVENT_ERROR; =20
> >=20
> > Sounds good to me.
> >  =20
>=20
> If you want I can send you a separate patch for this.

As far as I'm concerned - yes, please!
