Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE2EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE1020838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRx2GX7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE1020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeJYN4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 09:56:50 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36453 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeJYN4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 09:56:50 -0400
Received: by mail-vs1-f65.google.com with SMTP id c205so4709506vsd.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 22:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYVnAe22ReJw+Q5dS1mV8Xw2Cp8jGF5Lt+KtcKGs6L8=;
        b=FRx2GX7mnE6CkiOTL0Cdb1ywLCwe+D3JetlqxH6H5H3QYFCYW6NRFX1jPfpq06SZOu
         0fyQ+Vws0Zt9g4BULn0tt6qldPcLfqaVl03XyVBurw83Eb4CRkOve9zZyaiGXpw6I3gG
         71bY/9X2YFhEc8H8+sa855h2A2bSYNpZIJtfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYVnAe22ReJw+Q5dS1mV8Xw2Cp8jGF5Lt+KtcKGs6L8=;
        b=bXxfff4wXzQsWxzogmQJnkw1MYn9yRUy0F6fbKY5wGvdP1pJ+K2C3ZYzBIeagBnONS
         9+f0+/aL4x194MQuILqL93plkIKcN4OyC0TRwgBVK8B6k1aT+fh63/KD0DyVe1HCp8ht
         mfzX5zv4su5zO51mf3fveJzyf8kyCpVR/ev28LyhXEhj0weDhqwdyR+gEK3U9HHP5KQ1
         0vSFaryRs4h6LvC/y3eUI40/FmUaaMm4UH4kbAPeuvzrOA2VyMu6jOiLcIT+wrFGDAZb
         Piy4flVS40ES/FJ4qJ102RIOWoJuw7wDiJ0ckZBkoPUzZVTak/jzgtVhUddXTxyDWit2
         7g1A==
X-Gm-Message-State: AGRZ1gKeDnxvCVqTzUc8bdzfwARmDTHn8IXEcCWmpa1gsHnrQtlkEEZQ
        sNXrSAqMS/ZIWExyRyKJL2u7/ZV0UsIl/XuZnSCQsg==
X-Google-Smtp-Source: AJdET5dgku37159cR0j3xKlAl/u4cOT/oFy+IBWCIveiVP0kZXGd7eLIJbgWDiILfQqCVkaE+3Yq6eTbFbHEVDgjkEk=
X-Received: by 2002:a67:7c03:: with SMTP id x3mr56407vsc.9.1540445143859; Wed,
 24 Oct 2018 22:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
 <1538332682-12018-2-git-send-email-andy.gross@linaro.org> <CAK8P3a1UyHEATAhg_AP2oK8vkVHx+VKGX9aFBmRzzLpZECjxnA@mail.gmail.com>
 <20181005142911.GC15665@hector.nxp.com>
In-Reply-To: <20181005142911.GC15665@hector.nxp.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 25 Oct 2018 10:55:32 +0530
Message-ID: <CAHLCerNKw3_1E0Yoi-jq=hextG=xbbjU3=P=-25zeyc0MdmjxQ@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm ARM64 DT updates for 4.20
To:     Andy Gross <andy.gross@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
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

On Fri, Oct 5, 2018 at 7:59 PM Andy Gross <andy.gross@linaro.org> wrote:
>
> On Tue, Oct 02, 2018 at 11:30:29AM +0200, Arnd Bergmann wrote:
> > On Sun, Sep 30, 2018 at 8:38 PM Andy Gross <andy.gross@linaro.org> wrote:
> > >
> > > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > >
> > >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > >
> > > are available in the git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.20
> > >
> > > for you to fetch changes up to 6db0483cf622fc690e32e0804f8b86061f13962a:
> > >
> > >   Revert "dt-bindings: thermal: qcom-spmi-temp-alarm: Fix documentation of 'reg'" (2018-09-30 12:59:52 -0500)
> > >
> > > ----------------------------------------------------------------
> > > Qualcomm ARM64 Updates for v4.20
> > >
> > > * Update Coresight for MSM8916
> > > * Switch to use mailbox for smp2p and smd on MSM8996
> > > * Add dispcc, dsp, USB, regulator, and other nodes for SDM845
> > > * Drop model/compatible from MSM8916 and MSM8996
> > > * Add compat for db820c
> > > * Add MSM8998 SoC and board support along with associated nodes
> > > * Add RESIN/PON for Qualcomm PM8916 and PM8994
> >
> > Pulled into next/dt, thanks.
> >
> > There is a small chance that the two reverts end up causing more
> > problems than they help: they might conflict with the patches merged
> > into the iio branch, or they could end up being applied on top of
> > the iio branch and revert the changes during the release. I think
> > it will be fine, but it's obviously better to avoid this.
> >
>
> Agreed, I'll check in on this once -rc1 hits to make sure they weren't removed.

Andy,

While you acked the tsens thermal DT patches[1] so they could go
through the thermal tree[2] to avoid a dependency, Eduardo would
prefer the DT changes for tsens to go through the arch tree.

To avoid a scenario where these DT changes don't get merged until the
next merge window, would you or arm-soc maintainers consider merging
them in -rc2 (after the thermal-soc tree gets merged)?

For convenience, I've provided just the DT changes with all tags in a
separate branch on top of v4.19 here:
https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=up/thermal/tsens-preirq-cleanup-v4

Regards,
Amit
[1] Here is a reference to the patch series with Andy's acks:
https://lore.kernel.org/lkml/cover.1536744310.git.amit.kucheria@linaro.org/T/
[2] Here is a link to Eduardo's tree containing a subset of the above
series (I don't yet see a pull request):
https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/log/?h=linus
