Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEC9C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525F920831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWU8LJz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525F920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeJ3SCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:02:52 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:33890 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeJ3SCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:02:52 -0400
Received: by mail-vs1-f44.google.com with SMTP id q15so7181543vso.1;
        Tue, 30 Oct 2018 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HqjPDwpTnA6YS2d+IWSpuJMkQG5qKMJATSJdeG0f0Do=;
        b=VWU8LJz5JCpb3AQRfQQikdEN1IqK9MywSccscX1bk55fFYXN4NAJWBUe8Cuh1IBLW8
         ikwR9he4NizAYaATEhFsjS7xS2sx3ztSO+NLQxJHNJr3W7OmPiibbBWCFP3a6sQNWRAg
         WUPE48F65YI5o3doR3ZAAi6XVsKpvg/pmB724bF1gd8M52CQ808wAJQzXUXKzfXdqGXD
         fnxp0S1y4ZU74z5uJRgmKW+wvnKMiVCzg/FgX+PCLCwl0VLOvKMJ+2grD/27r2wFQrKU
         1au/KYoiN207v5PRcgL28rGDeC7heXMDFn0qcNKLtSyFDJF/VYli0mfnHjaOII3jEwHv
         b1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HqjPDwpTnA6YS2d+IWSpuJMkQG5qKMJATSJdeG0f0Do=;
        b=Xhz6cOFOqvhaYRhNy/8m1wMGHsD05+o4HtoS6/qtlSRKyhe3PpmhhwakkCUPHz6aoJ
         FPViDdKhBIwUgqlRk5EjJ1eplKIpASouTSG/2sb3t86b6S43gl6ElG8PuuF/qeOoUQpl
         kvX2ULwF0QRnHu/kGZUgWqmJds1L9mxajWV8MEDr9pk1Gvgi1OfL3Rgoed1PrizY53A6
         fFklzZYmyQ0A36apwjFUjwRe8z6N1bJVS3fLhSReWMj/TerTx4UF6Go+YUPPqlpHzdur
         YRUJPW3/xg2VBKsZBrFD3Lt6HOfRUfhadrC6/Dl/AnX7YEtcZhUlVMZ0ATSvuQVUNIcc
         xq3Q==
X-Gm-Message-State: AGRZ1gKaymxX+XziPbpt9ryFHZmhyc2KwtRnr4UUSe/CUaC0DHQsU9aw
        RnLeounXTBnwkEIVx6TJvRTUKwUL/LoVVR+iivg=
X-Google-Smtp-Source: AJdET5eguoFtbQLy0AxQBmLbPb9smdjsXPfBEGeEw6+SfIRbhO96rlSw/vlAZQ/+QZbnLQArQpCfLf3Qi/j7W1wJjEE=
X-Received: by 2002:a67:7402:: with SMTP id p2mr7617282vsc.101.1540890615665;
 Tue, 30 Oct 2018 02:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <1540866162-149564-1-git-send-email-yuehaibing@huawei.com> <20181030071527.GA22121@amd>
In-Reply-To: <20181030071527.GA22121@amd>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 30 Oct 2018 17:09:39 +0800
Message-ID: <CAEbi=3em7rYJHuv4JOmrEUiiaE4SiTFT=rSurqZCrG4P+QXbjA@mail.gmail.com>
Subject: Re: [PATCH -next] nds32: Remove duplicated include from pm.c
To:     pavel@ucw.cz
Cc:     yuehaibing@huawei.com, Vincent Chen <deanbo422@gmail.com>,
        Nickhu <nickhu@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> =E6=96=BC 2018=E5=B9=B410=E6=9C=8830=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:15=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue 2018-10-30 02:22:42, YueHaibing wrote:
> > Remove duplicated include.
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>
Hi Pavel and YueHaibin,

Thank you.
Acked-by: Greentime Hu <greentime@andestech.com>
