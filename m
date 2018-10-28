Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97DBC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B70D20843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQjbMVu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B70D20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeJ2Cjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 22:39:54 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42105 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeJ2Cjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 22:39:54 -0400
Received: by mail-ua1-f65.google.com with SMTP id z18so991939uam.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbzqfqhdnpMDXfjL7Pf2Sr+4V0JEWV3F6O+o3RGTp2A=;
        b=aQjbMVu3b+4uIcQKhffYf55FR0yWJOSKq2KQcqcn/Dc0uDBojRrZF3qlsxxGFUNE9g
         zFwGdl/o2wilATXDGW2VUQyGbVRQzCejKvecJU0J3OSMGhOEqE2w3nUkzzRdmhrS+uvH
         o8YUyVLHNf0Wq0X+lskzRjN0DSWVDRLG+nVfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbzqfqhdnpMDXfjL7Pf2Sr+4V0JEWV3F6O+o3RGTp2A=;
        b=galKoRVO6puF/4U2JalBgtQRq6Czj/2JEZNQ52KBUYmcH5JkMtC73DI3oJjFBfbYxy
         oobZJTgZxg1xBSwDgrQREUTtqejx9PxtpWNvnity0fVutApUmH4UKMLcA666hrbPTr0S
         cpIbKIwolvvqc9qFqbsD2xiitK7wTFA1nwTYtzqt194+d/5Y0qaLBZ+i8GwMTAJJiUqK
         p864ivxPb40CfqNI+wnvalOp4YolrhOFWfU9m18GvhQst+pob9cLCQ3kSW1JYYcKJNVm
         0C85nYOeJuuKEnijN6TTohUgpj8YkcdOhNQypBEkj6ebwq3MGd2ngx8xffluurxGRHkt
         oE6A==
X-Gm-Message-State: AGRZ1gKI1LExgGaIbGl0byVp05ARIeDmD0gwBR38P3QeCSpv+SLbz+fD
        R8EfvfkWdwV+PfmuK4obIh1C19JosxEzVeo93RoNaA==
X-Google-Smtp-Source: AJdET5ekazsxdUviuu+S3R0l3/4vTb/klOsPdnuapaBHYRDUL5+28jlOkrpHP4Cb9CF6hXwe9IcYhTMNqVh6K/ODiS8=
X-Received: by 2002:ab0:16dd:: with SMTP id g29mr4638519uaf.112.1540749272286;
 Sun, 28 Oct 2018 10:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
 <1538332682-12018-2-git-send-email-andy.gross@linaro.org> <CAK8P3a1UyHEATAhg_AP2oK8vkVHx+VKGX9aFBmRzzLpZECjxnA@mail.gmail.com>
 <20181005142911.GC15665@hector.nxp.com> <CAHLCerNKw3_1E0Yoi-jq=hextG=xbbjU3=P=-25zeyc0MdmjxQ@mail.gmail.com>
 <20181025160822.GA16095@hector.c.hoisthospitality.com>
In-Reply-To: <20181025160822.GA16095@hector.c.hoisthospitality.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Sun, 28 Oct 2018 23:24:19 +0530
Message-ID: <CAHLCerOd0BqAG+MVx1icm-yNMiW1U--iNzK9eeP7km1GnOx_PA@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm ARM64 DT updates for 4.20
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        khilman@baylibre.com, Olof Johansson <olof@lixom.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 9:38 PM Andy Gross <andy.gross@linaro.org> wrote:
>
> On Thu, Oct 25, 2018 at 10:55:32AM +0530, Amit Kucheria wrote:
>
> <snip>
>
> > Andy,
> >
> > While you acked the tsens thermal DT patches[1] so they could go
> > through the thermal tree[2] to avoid a dependency, Eduardo would
> > prefer the DT changes for tsens to go through the arch tree.
> >
> > To avoid a scenario where these DT changes don't get merged until the
> > next merge window, would you or arm-soc maintainers consider merging
> > them in -rc2 (after the thermal-soc tree gets merged)?
> >
> > For convenience, I've provided just the DT changes with all tags in a
> > separate branch on top of v4.19 here:
> > https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=up/thermal/tsens-preirq-cleanup-v4
> >
> > Regards,
> > Amit
> > [1] Here is a reference to the patch series with Andy's acks:
> > https://lore.kernel.org/lkml/cover.1536744310.git.amit.kucheria@linaro.org/T/
> > [2] Here is a link to Eduardo's tree containing a subset of the above
> > series (I don't yet see a pull request):
> > https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/log/?h=linus
>
> I can just send a pull request for -rc1.  No biggie.
>

Thanks Andy.

FWIW, the dependency patches landed in Linus' tree.
