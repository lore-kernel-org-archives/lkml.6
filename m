Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FEDC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B08520850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5Efix4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfARRyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:54:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36136 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbfARRyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:54:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so11108456lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 09:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ot36uq83wa0Y1fXewOHgIXxhyvpclDCNh+C0slktdko=;
        b=H5Efix4aOiYZ2WH4X3bqI5306kcx0Ab8InNNyVE+aDzQR+TCCQLtYMUXFD5tFrDfKD
         afnlPpgv9eO8RdPo+BdW5zRSMhcy4nslnzHjvkwHrABE/ODHJJoO0fgoQi138vcsq4V4
         RFHcZbhD3575Rq2OpiNR4EoWGw9dpEG52dcSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ot36uq83wa0Y1fXewOHgIXxhyvpclDCNh+C0slktdko=;
        b=YattpF4WvnVmJiapRfLp+n8ozZKNTZaYyUvj0Birbdx3ikSWZaKDVAwJkizaB57waV
         U9BebMnw+iqephrItOSaaVT0XbZuzkXO7Pw9veyI7PByHGiE3wXoIECFkAR00MNEpvcy
         Fm+iT+b9FMz8dN3RS9pl2aF+pePbLEEy/+qrnwujQxmRgY8nC5uG6y0ojrCMkXYq8EVK
         gDkiwTAISwjOG7UCHxU4A6ChFxWl4uxDI5PMUr1mw4aGXfV8rrejUrDxFoSActjsR2ym
         KD94gj7plDjUeSuMfN6oIUC1crSMka4GuJmtB3OwZLivACjASE8aPotpHEzpweN6eNRm
         VWcQ==
X-Gm-Message-State: AJcUuke8iU3Mj3VdvKZ2kXl64w3plFtMgC82cBNzu5cB+xfCEAov+vqW
        6Pax47x+JYk9zb3JJZAoKp5b2zSE6SvL9rJBA8Rpyg==
X-Google-Smtp-Source: ALg8bN72jZfHf1vjCR9XPkul7ByOERAeZ+50Sa1vRuLNScQ9VXXQJw6BxlIsG5o4O1zL5CHevKqLGw5eQ8Enfmq3kag=
X-Received: by 2002:a19:c954:: with SMTP id z81mr12897609lff.150.1547834058764;
 Fri, 18 Jan 2019 09:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20190116174320.14938-1-daniel.diaz@linaro.org> <7d75f420-d624-d53d-4fa1-3827c90fa608@kernel.org>
In-Reply-To: <7d75f420-d624-d53d-4fa1-3827c90fa608@kernel.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Fri, 18 Jan 2019 11:54:06 -0600
Message-ID: <CAEUSe7_eYmMSovO4JAabh+83CtY2L8eeMoCVKKS5P-fs7zVhjg@mail.gmail.com>
Subject: Re: [PATCH 1/4] selftests: lib: allow to override CC in the top-level Makefile
To:     shuah <shuah@kernel.org>
Cc:     Fathi Boudra <fathi.boudra@linaro.org>,
        Denys Dmytriyenko <denys@ti.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, 16 Jan 2019 at 15:56, shuah <shuah@kernel.org> wrote:
>
> On 1/16/19 10:43 AM, Daniel D=C3=ADaz wrote:
> > From: Fathi Boudra <fathi.boudra@linaro.org>
> >
> > Relax CC assignment to allow to override CC in the top-level Makefile.
> >
> > Signed-off-by: Denys Dmytriyenko <denys@ti.com>
> > ---
> >   tools/testing/selftests/lib.mk | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/l=
ib.mk
> > index 8b0f16409ed7..0f9c47eaaa6f 100644
> > --- a/tools/testing/selftests/lib.mk
> > +++ b/tools/testing/selftests/lib.mk
> > @@ -1,6 +1,6 @@
> >   # This mimics the top-level Makefile. We do it explicitly here so tha=
t this
> >   # Makefile can operate with or without the kbuild infrastructure.
> > -CC :=3D $(CROSS_COMPILE)gcc
> > +CC ?=3D $(CROSS_COMPILE)gcc
> >
> >   ifeq (0,$(MAKELEVEL))
> >   OUTPUT :=3D $(shell pwd)
> >
>
> What problem does this fix?

Sometimes "$(CROSS_COMPILE)gcc" is not enough: For instance, we need
to pass --sysroot to CC:
  CC=3D"aarch64-linaro-linux-gcc
--sysroot=3D/oe/build/tmp-lkft-glibc/work/hikey-linaro-linux/kselftests-mai=
nline/4.19-r0/recipe-sysroot"

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
