Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEB0C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25E820673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="k4hXs9Wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25E820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389149AbeG0TWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:22:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39040 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389067AbeG0TWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:22:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id a11-v6so3657298pgw.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ca7VtAOr5CbyNXYw+EYnGz1kTQzO9N05tUUdLE7DFCk=;
        b=k4hXs9WlXdONJpuVYpqEB8Z2x1EHYmErOjR3b/pYJrWjbgscG7dRaS1PsrGvqTyP7n
         /+hwewD30QQvyhcYGMra0hdRdxgD9juAHGk9svJktGE44+Xw13TNhlQ8KNPWeaUEsLbc
         5trjbpbwU7q+WZeatgeejahgZufaHX0+Gr3dSxsuRR44To8UPeyv8K6vi34XJYPRo6vy
         zBTdHsvDD0jVKbAX5Ye29wO3gFIt9y/sop0XyY+Yf3NCn6WIHMPX+dwUTJwJQJyy1Ygq
         /jj76zIQ3E3WEQhLWUUD3yjwuKQGDap+1FO8OL7bXArxZiNAMJxp9sZM+an/1X8WjL0Z
         Uhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ca7VtAOr5CbyNXYw+EYnGz1kTQzO9N05tUUdLE7DFCk=;
        b=kTNcTu/y8bseHk1FrD6/zyFwERiI7bwoFIR0dW0Tzw+hULpk8eEjY+mg/uv9Atcjf6
         GqcKykMht14jdMwN7/q9lqODOUdZMXJ4Flqb2nVAK6f+JYJCfv47kYCBj1weTQnGhaLn
         EDvlCYbNRNYHOJNJLK5AAzEBXt7aJH9g1ifV/yO1JqQMhwFMgbuCG0V1B8XvPAGZjtXM
         nJWP6YWuBmM2PEfUi/AQ8mHqH8YqAFDwPE5D0UCrtAMVlEcC3rjL5lvOTdUZNy9wvBPm
         Evq0PLfQCSE3VZlifN7mxacrCpiZhA1Ff1Kz4tYWXXKpRhWM58et99nCc+qdqkZFOBlh
         VtTw==
X-Gm-Message-State: AOUpUlEDi68mqeC2PLQ1x2PMaJyRmBxt11ys//GrKizBChKjo/DeC8hQ
        vNSSUE9rNL1Md/P8sLX8DaWw4g==
X-Google-Smtp-Source: AAOMgpebW93greJ3u7klPY8etcrCpMqO8OOEkvBF69E6rGF/HHTRWsoVjL4fxPKY9pbkRaIoaHCPNg==
X-Received: by 2002:a62:3d41:: with SMTP id k62-v6mr7649586pfa.35.1532714365982;
        Fri, 27 Jul 2018 10:59:25 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-231-89-118.hsd1.ca.comcast.net. [73.231.89.118])
        by smtp.gmail.com with ESMTPSA id l79-v6sm14440885pfj.179.2018.07.27.10.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 10:59:25 -0700 (PDT)
Date:   Fri, 27 Jul 2018 10:59:23 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com
Subject: Re: [PATCH] perf build: Build error in libbpf missing
 initialization
Message-ID: <20180727105923.2d5da6aa@cakuba.netronome.com>
In-Reply-To: <20180727082126.87530-1-tmricht@linux.ibm.com>
References: <20180727082126.87530-1-tmricht@linux.ibm.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018 10:21:26 +0200, Thomas Richter wrote:
> In linux-next tree compiling the perf tool with additional make flags
> "EXTRA_CFLAGS=3D"-Wp,-D_FORTIFY_SOURCE=3D2 -O2"
> causes a compiler error. It is the warning
> 	'variable may be used uninitialized'
> which is treated as error:
>=20
> I compile it using a FEDORA 28 installation, my gcc compiler version:
> gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
>=20
> The file that causes the error is tools/lib/bpf/libbpf.c
>=20
> Here is the error message:
>=20
> [root@p23lp27] # make V=3D1 EXTRA_CFLAGS=3D"-Wp,-D_FORTIFY_SOURCE=3D2 -O2"
> [...]
> Makefile.config:849: No openjdk development package found, please
>    install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h'
>         differs from latest version at 'include/uapi/linux/if_link.h'
>   CC       libbpf.o
> libbpf.c: In function =E2=80=98bpf_perf_event_read_simple=E2=80=99:
> libbpf.c:2342:6: error: =E2=80=98ret=E2=80=99 may be used uninitialized i=
n this
> 			function [-Werror=3Dmaybe-uninitialized]
>   int ret;
>       ^
> cc1: all warnings being treated as errors
> mv: cannot stat './.libbpf.o.tmp': No such file or directory
> /home6/tmricht/linux-next/tools/build/Makefile.build:96: recipe for targe=
t 'libbpf.o' failed
>=20
> Fix this warning and add an addition check at the beginning
> of the while loop.
>=20
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
>=20
> Suggested-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Ah, you already sent this, LGTM, thanks Thomas!

>  tools/lib/bpf/libbpf.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 73465caa33ba..66965ca96113 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2349,6 +2349,8 @@ bpf_perf_event_read_simple(void *mem, unsigned long=
 size,
> =20
>  	begin =3D base + data_tail % size;
>  	end =3D base + data_head % size;
> +	if (begin =3D=3D end)
> +		return LIBBPF_PERF_EVENT_ERROR;
> =20
>  	while (begin !=3D end) {
>  		struct perf_event_header *ehdr;

