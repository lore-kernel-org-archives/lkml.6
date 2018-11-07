Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80160C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470A120827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3g5oRSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470A120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbeKGPog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:44:36 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35937 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeKGPog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 10:44:36 -0500
Received: by mail-ua1-f68.google.com with SMTP id j3so2970397uap.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 22:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7w37rNQzjnXnIG8v7gRvPQVS7IS1nJXal7n75Qcnxvs=;
        b=B3g5oRSb25SB0bw8zCvlAqLsAMBMv4viSqG9laedu25d1FIpBafo/7yP+Mfy1EdUPI
         9C7evtEba92R0Tz+VWCLJZILVfQHs3gMMcXVTGBLsBpAThNY1QRaIJHPjqC33k1SWFRi
         NVK2kGmKjzAXx44iZrhdcmc1MGUATVEDWY10k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7w37rNQzjnXnIG8v7gRvPQVS7IS1nJXal7n75Qcnxvs=;
        b=SUuymjW6YiwjlQyt7gUSQcKzZ+V9cmo1JimMYAcVbIiD02HXNB7A3Rrq9eMs9hNlgB
         2AgGci5yJinRpf/h3y/eSF5TRcY0wIe8smtNI8dPwWrOhFSiIDx36RzDsvXbH9eS1w22
         oKiODzQLqR7PseWnbL5zJJA2xxao74FtW+WLtFfy8acSS2v73mYYCMkBsHXBkncIMvKF
         /2rhTODSKA/yw75mAoL9vg0oZ/o38RG9ZKQ4k2O8LvY5ql+RMUrjpgp2ypwp/cXVi44H
         YwMxFxc38gslzmICoR0T/0zYhgm0dRCLtPb+/lB1b5pixVImRx5K8HzM9y4vA/SV2+Um
         XoCg==
X-Gm-Message-State: AGRZ1gJWrd4ChYPuQ8ERWmYGI8zUGZHGessq0TqBGtEjCr5RR1fQDaIs
        fxPubz0ebkLbThxFMElfa9uSOaMX/vgEYrKaMXQnNg==
X-Google-Smtp-Source: AJdET5cSeijSire1CaqhVOLAxQkXd8jVeuZbneD+uoTy0NwVi292IhtY/hDTFQYOFemzfqn7QPOSdsCtOBbbWA01j5I=
X-Received: by 2002:ab0:26cb:: with SMTP id b11mr246279uap.112.1541571341749;
 Tue, 06 Nov 2018 22:15:41 -0800 (PST)
MIME-Version: 1.0
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
 <1538332682-12018-2-git-send-email-andy.gross@linaro.org> <CAK8P3a1UyHEATAhg_AP2oK8vkVHx+VKGX9aFBmRzzLpZECjxnA@mail.gmail.com>
 <20181005142911.GC15665@hector.nxp.com> <CAHLCerNKw3_1E0Yoi-jq=hextG=xbbjU3=P=-25zeyc0MdmjxQ@mail.gmail.com>
 <20181025160822.GA16095@hector.c.hoisthospitality.com> <CAHLCerOd0BqAG+MVx1icm-yNMiW1U--iNzK9eeP7km1GnOx_PA@mail.gmail.com>
In-Reply-To: <CAHLCerOd0BqAG+MVx1icm-yNMiW1U--iNzK9eeP7km1GnOx_PA@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 7 Nov 2018 11:45:28 +0530
Message-ID: <CAHLCerOHa+HZEQmQpEbTtskd9mu-6DboEHg1RCLBCuKMjzuWNA@mail.gmail.com>
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

On Sun, Oct 28, 2018 at 11:24 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Thu, Oct 25, 2018 at 9:38 PM Andy Gross <andy.gross@linaro.org> wrote:
> >
> > On Thu, Oct 25, 2018 at 10:55:32AM +0530, Amit Kucheria wrote:
> >
> > <snip>
> >
> > > Andy,
> > >
> > > While you acked the tsens thermal DT patches[1] so they could go
> > > through the thermal tree[2] to avoid a dependency, Eduardo would
> > > prefer the DT changes for tsens to go through the arch tree.
> > >
> > > To avoid a scenario where these DT changes don't get merged until the
> > > next merge window, would you or arm-soc maintainers consider merging
> > > them in -rc2 (after the thermal-soc tree gets merged)?
> > >
> > > For convenience, I've provided just the DT changes with all tags in a
> > > separate branch on top of v4.19 here:
> > > https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=up/thermal/tsens-preirq-cleanup-v4
> > >
> > > Regards,
> > > Amit
> > > [1] Here is a reference to the patch series with Andy's acks:
> > > https://lore.kernel.org/lkml/cover.1536744310.git.amit.kucheria@linaro.org/T/
> > > [2] Here is a link to Eduardo's tree containing a subset of the above
> > > series (I don't yet see a pull request):
> > > https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/log/?h=linus
> >
> > I can just send a pull request for -rc1.  No biggie.
> >
>
> Thanks Andy.
>
> FWIW, the dependency patches landed in Linus' tree.

Andy, a gentle reminder that the DT patches can now go in safely.

Thanks,
Amit
