Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F52218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8qnX3GG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389993AbeLUK6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:58:05 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:34989 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731433AbeLUK6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:58:05 -0500
Received: by mail-oi1-f180.google.com with SMTP id v6so4442709oif.2;
        Fri, 21 Dec 2018 02:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fTL+4zZ1DGFCFTudLNfSIakFxQdiVQlzw7/3HVmY4dE=;
        b=S8qnX3GGBqT+phsIbUdtrSCen+S2n/q4N4FjFAOJ6npP8/lVULuQAu0hZJeDjnb1Yj
         GrYs7Mr/Kotl2xVFzR3BER2sRAM7hFH53R8fyhApkRWi4tmAo1QSK76PmsyeJIBzUI64
         xs/AsF1UcwRbcitkPs+9hwHD+OY/sTQTmlvs/n45ZJSFdk6O8NwxVa1n0gmDhBfe0URm
         gjWOY43Nv28ra0N5wwKWg325EoH9b+UevOzi7EIKKN58l8cZnpSEUetlrUSfC5AGUVTw
         cQhle05gRDlTdQjpm7mKc5NlllsRga7EoLQoUE8hk0ynUpwZSnTT9o5d0obJg4P0qbQK
         gp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fTL+4zZ1DGFCFTudLNfSIakFxQdiVQlzw7/3HVmY4dE=;
        b=BIkLecYLer83UyNqY6bSQArKg3OO2uZ5NU2uUI+6xcsBCj8q0cOKN0ZhE81sT+NRis
         zPDHAU/IT1RhMPUXKMitomeaYDkbqCTrzFRc6LGomvVQUl7aIdGjQm6tN7T3gIhoarNF
         rD+l3gqMPd85aoulBuv0hb9CoFTKPVmcFk2pgVoP05PkYggu3MzFtcLp2nANy4nzr57m
         eycCvWLpRHfHxY9+B0JVfHLUrH1fhF56nyA/MidbpD1ujimZ1klzlzQiQqjCeawLxzYm
         mU6kYJea7XJ3EVqgs3pG+qMgf2xLLxSJ/OAtmyCPV3VHilbYI7AssHLH1wOp3X6dNqqL
         pZVQ==
X-Gm-Message-State: AJcUukfgC0hjifqSexZLCoYhUspdjPJyHcF16t0o1dFfQNdQdQO38bEZ
        kHXf/e527dUwrG1NgVYtwAlmq6VSBXYFzdUmdLA=
X-Google-Smtp-Source: AFSGD/XsUEAFRzZTsPWiiUaZfCEuWfNCsPJdt6Jncw0P6j0R4WwZ5INoVhuooElKnQAio+KFfYqfia2C3oJV7mpN1sw=
X-Received: by 2002:aca:e755:: with SMTP id e82mr971966oih.153.1545389884234;
 Fri, 21 Dec 2018 02:58:04 -0800 (PST)
MIME-Version: 1.0
References: <05BD5679F4A9234798A0693ABF94E75ADFF7F3A5@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <05BD5679F4A9234798A0693ABF94E75ADFF7F3A5@ORSMSX101.amr.corp.intel.com>
From:   Jinpu Wang <jinpuwang@gmail.com>
Date:   Fri, 21 Dec 2018 11:57:53 +0100
Message-ID: <CAD9gYJKvcn5kzMKhHU2UO=99Vdus_v=5D-fZb6-+Fy=gDokZFA@mail.gmail.com>
Subject: Re: Fix "perf tools: Synthesize GROUP_DESC feature in pipe mode" in
 the LT 4.14 branch
To:     "Greensky, James J" <james.j.greensky@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v3.14+, only the raid10 part" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Greg, stable

Greensky, James J <james.j.greensky@intel.com> =E4=BA=8E2018=E5=B9=B412=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8811:48=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Commit d38d272592737ea88a20 ("perf tools: Synthesize GROUP_DESC feature i=
n pipe mode") broke the LT 4.14 branch when using event groups in pipe-mode=
.
>
>   # perf record -e '{cycles,instructions,branches}' -- sleep 4 | perf rep=
ort
>   # To display the perf.data header info, please use --header/--header-on=
ly options
>   #
>   Oxd7c [0x60]: failed to process type: 80
>   Error:
>   Failed to process sample
>
> Commit a2015516c5c0be932a69 ("perf record: Synthesize features before eve=
nts in pipe mode") is the fix. Can we get this cherry-picked and applied?
>
