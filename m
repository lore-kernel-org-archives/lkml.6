Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59135C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1CA20865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7czckMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1CA20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbeKXTMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 14:12:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46124 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbeKXTMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 14:12:37 -0500
Received: by mail-lf1-f66.google.com with SMTP id f23so10086153lfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 00:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4lTWNqVS/0YXFtsbh12p3tJrqzSN/MR2ug+TBwr15lc=;
        b=k7czckMZO6jjFV3iul/y+zcG9HzWpu4LX82foiQTm1hPYPtqHiyHx33GSRIUh9AkoF
         GI54i6eOrOlDMTmCgLp7QCN0LHsQvLVa6k1JW1Vi4RavPr1FRS1pf45xjbrLzFS5P4LP
         f8zfyYo49JaVXxAlBEWLaAu8ltNZug/1pkfmIhqOlZcjq92ZQOWTzP1aIvZABntnGsJV
         2/dsp2sHLp/11URn7RJozRCsGlBx/KPvoqSHjNeXSrz/rs+4tMGg3cYm7Ygxlgz0o5PB
         IZJFcGKiURIU0RqpFauGfbVTlD9sJGqXwSZ+W+Jvgpl8If613BLLK2/WafvuCtQwMYF3
         lMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4lTWNqVS/0YXFtsbh12p3tJrqzSN/MR2ug+TBwr15lc=;
        b=NpUu+x+R90CZ/ULqzKgJj+NMOAWFeQombMMppPjLDlSVCuCVMesBJEhjk8WBoMZnXf
         iGzwyEXX6bCLTytoJLE54aJd0wmCytyC9g5Gf9GqhdE03oHtNDN65LGHeVgf98efb6ia
         X1SMUkmnqyyMIwqUTcXG6bYWUdJ8i7cMJDYm2pAPOMrP3g3fTj4uEEUgxElibPICSfqT
         nC6TqS8tyL2J9w5IKWIhOkRt4+use4pvXE6C7nktBOIxwVs0pyikQaEo9JLnVYeZ14ya
         jEVjGzfAvTbv1DLFmtUFGh9/VARy0c5H96Ju8CYIIKYPtGZOUf4Gy8v/CytlcqeZ2sG2
         d8eQ==
X-Gm-Message-State: AGRZ1gLHxMoSQKEXGjfIoSR0yLzYyrdYDJyVrgiSG9MzHODdGm7DITRZ
        wz74Z3fTvMILSYyJzhbFxZJejxtD6mSPIqto8wk=
X-Google-Smtp-Source: AJdET5fx+4RagNPVQnmL7pWBKgeCBl64pNvUWs9sraAPcax4vAVYZBvoAvRgAUbHr2Lj+6Wm0bER8MfqspezAcbliFQ=
X-Received: by 2002:a19:54d7:: with SMTP id b84mr10663967lfl.131.1543047891968;
 Sat, 24 Nov 2018 00:24:51 -0800 (PST)
MIME-Version: 1.0
References: <1542856462-18836-1-git-send-email-yamada.masahiro@socionext.com> <20181122143201.d7vifhlny7gmrhzd@ltop.local>
In-Reply-To: <20181122143201.d7vifhlny7gmrhzd@ltop.local>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 24 Nov 2018 09:24:41 +0100
Message-ID: <CANiq72miapoMHiXsq-gSu5+dhpGDE6Dnf3c_6DpHRkwNiPPU6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kernel.h: disable type-checks in container_of()
 for Sparse
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, josh@joshtriplett.org,
        ast@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        neilb@suse.com, Greg KH <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, cmo@melexis.com,
        Dan <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 10:14 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Thu, Nov 22, 2018 at 12:14:20PM +0900, Masahiro Yamada wrote:
> > When I tried to enable BUILD_BUG_ON for Sparse, the kbuild test robot
> > reported lots of "unknown expression" warnings from container_of(),
> > which seemed false positive.
> >
> > I addressed this in [1], but fixing Sparse is the right thing to do.
> >
> > The issue was fixed by Sparse commit 0eb8175d3e9c ("fix expansion of
> > function designator"), but it will take time until the fixed version
> > of Sparse is widely available.
> >
> > Disable the container_of() type checks for Sparse for now.
>
> I would prefer that developers upgrade their version of sparse but ...
>
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Indeed. If someone is writing code for the latest kernels, I think it
is reasonable to assume they are able to use the latest sparse too,
since it is not required for compilation anyway.

Cheers,
Miguel
