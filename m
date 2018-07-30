Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD55C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C88B20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="PGfNDix2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C88B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbeG3VLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:11:45 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35651 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbeG3VLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:11:44 -0400
Received: by mail-qt0-f195.google.com with SMTP id a5-v6so13397719qtp.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 12:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=OxA9Jw1dQpDaU07L4qo1lamIpnJKPnKAzdAh6eTQCBY=;
        b=PGfNDix2OGE9ieEGMp77cI13Zigl87Iv557WSYZY5XOltGqUTrdUsa2ifO/jPMN3U0
         4+HRyLICq7WG2Ip+l5ImL+T9zsbbLTXDt98A1l6cOLaNSvn5HJKabIQV35eGboVA2TBu
         FxvUWQyiI40L1vvOOj7D4lT4WrwJrAY4cf9U2vKF4L9hKhpbww4GV3O3vMK7pXQGtHtz
         jbJzLJVl0jcH7daJNzXSSp9DRe4HtLrlzF+W9m2r5IVTidmMDtMYBLULPpjoosussxk8
         t7xt8S8zUAw22cZNP0aH3u3d2N4igr5pCXVvZFe9PggoiB0l+3a9E2kM/ILVACwer96o
         tB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=OxA9Jw1dQpDaU07L4qo1lamIpnJKPnKAzdAh6eTQCBY=;
        b=QuQ3jiPGratfvEquZTk9lyKRjNgvRdFLjYGgl3lXNFKl7p9HnphEpDZ0fhfwIfyx3v
         evSXEPyGQuEnBL3rY2cP5rL+6IUG+1bJZUJ8YbnwdZAmTQ9LB12Ceg9wbYnqLd/BfH2z
         CwL5EnGB+qLKcHFRD28D1untLzbgDgMIjI3G/aOQRukmhUnjGDGazeifrbyIeU6BAgs1
         CgkFt1QuzbWq6L1cics7OXIhcxB/66Wzp77I91JvWXUmWDOb7uV3tX8/rveeVj1EHuw8
         uMR+dK6mg5wmZQP4QliKbFH4GN/l/x/nF1tFpxPO82FZwW4zt0mRaGwzjnPJziWSECyE
         8DZQ==
X-Gm-Message-State: AOUpUlHzn1liakTftQOpkzPpC57IuOtLCCD1msTXP2yhAi0At0Rfb4k8
        vuj9j2MeKWAbRkkmLc6YGsJpsnifOg4=
X-Google-Smtp-Source: AAOMgpeoRiOu21CLEmrYQbrtZ7i24g3OYfGhhe6Uwnfw9VGH4PXrj5SOpK2KcbFaPfy/26X3w/ovxg==
X-Received: by 2002:aed:39a3:: with SMTP id m32-v6mr18489735qte.109.1532979314220;
        Mon, 30 Jul 2018 12:35:14 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h36-v6sm8654087qtk.72.2018.07.30.12.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 12:35:14 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:35:09 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com
Subject: Re: [PATCH v3] perf build: Build error in libbpf with
 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
Message-ID: <20180730123509.0ffa4737@cakuba.netronome.com>
In-Reply-To: <20180730085323.75738-1-tmricht@linux.ibm.com>
References: <20180730085323.75738-1-tmricht@linux.ibm.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 10:53:23 +0200, Thomas Richter wrote:
> commit 531b014e7a2f ("tools: bpf: make use of reallocarray")
> causes a compiler error when building the perf tool in the linux-next
> tree.  Compile file tools/lib/bpf/libbpf.c on a FEDORA 28
> installation with gcc compiler
> version: gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
> shows this error message:
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
> Replace all occurrences of strerror() by calls to strerror_r().
> To keep the compiler quiet also use the return value from strerror_r()
> otherwise a 'variable set but not use' warning which is treated as error
> terminates the compile.
>=20
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Suggested-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Conversion looks correct, thank you!

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
