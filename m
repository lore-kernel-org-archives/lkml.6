Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A32AECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6282082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk77Zuny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6282082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeKARia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:38:30 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:33628 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbeKARi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:38:29 -0400
Received: by mail-lj1-f179.google.com with SMTP id z21-v6so17330726ljz.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJdWe05eelAqk9R0fn8xtepbm2Zhn01pDFRHMlPMzro=;
        b=Kk77ZunyU57kngFOT5uGVYglC7uLPmeScOcVQAkyfLE8EC5z0stSjGVqMjgfTfNIWO
         uxmcSC0cm9aW35XvD4if5KJ51DbCtrrzIvnD8wKh+P80e5v4WstDYs7PPgumB6nQs/NQ
         JZeMyD6X9Ojl2B1xqaCasnCG+1qOVacbtzi8zq8R1tHHxrgFgqNzBApVz0fbdxF8/khL
         uV6qXchqN6MeLlot6WOVN5iVIpx0RmOBr5kBj6Ud00KWJXASfDvL1089p1mgcMZltx6d
         hYfrcm1Kl1NdQjUUmelV+ShFvKfKie0CRk2kcq0QNBT5c4Wmiy9vfhsP7nGIWdiHplhl
         xHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJdWe05eelAqk9R0fn8xtepbm2Zhn01pDFRHMlPMzro=;
        b=Ie7TZyraidr9b6+lvO1EvILHCEXLZ6f7oVGkSEdsszjGw7RWTrZP1MwSBSbr4rSY5U
         ltVAW5UsWasV1ykEqaJluoO+0gaiQw4wvyt5Hd2X78adqcw2hsI08SUrFP1mUnZVBhmZ
         HevaRVmHFuu0P2M4Si9NdYSKRXoy3jR9xw5BcEpR1N7dMufGZ87se7yQotop+vXBY9/6
         Z7O+pUgFj/8JXBmDrngQ8A17kgSaERKpdEn/gGt0X5n9+s8T7rBEN5YLUl5G+Xu8qi/L
         U6TrCiEyCUeD7/w9NXF217ybwuuON1osY+w6fXrrVuf8ttJgUuHk+JOZPaYYm9OXjbMa
         d5Hg==
X-Gm-Message-State: AGRZ1gJ0hyFNIkIoDhhTuxPho4fPEibZ0NPcsBMrqkxZXLzf+cqG3jUz
        MJsA3WmUpIrmS3c0sHAOExOyIT0kSaDgFqJzLaY=
X-Google-Smtp-Source: AJdET5fSDPPUd1Xl+nky44183Xgkpf90p3iByqGfQy5RS6/RVCr7lkGJugbjsjiGavNm60MWFdLt0b/7MD8RVsdLQV4=
X-Received: by 2002:a2e:9c08:: with SMTP id s8-v6mr3616294lji.149.1541061386637;
 Thu, 01 Nov 2018 01:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com> <CAAfSe-v47=pr9pCoM_mATbd0sRApU+TjB8L_e01TwAibn2Qj9g@mail.gmail.com>
In-Reply-To: <CAAfSe-v47=pr9pCoM_mATbd0sRApU+TjB8L_e01TwAibn2Qj9g@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 1 Nov 2018 16:35:50 +0800
Message-ID: <CAAfSe-vi_b-sK2YeNfazLQbiQr4vbmkbavdwKBef1=nN4_qq_A@mail.gmail.com>
Subject: Re: [GIT PULL] sprd dts for kernel v4.20-rc1
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "arm@kernel.org" <arm@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 at 14:36, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> Hi Arnd,
>
> I guess you may have missed this pull request.
>
> Thanks,
> Chunyan
> On Thu, 18 Oct 2018 at 17:19, Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
> >
> > Hi Arnd,
> >
> > For 4.20-rc1 there's one patch only for sprd devicetree, please pull from my git tree:
> >
> > https://github.com/lyrazhang/linux.git m-v4.19-rc1
> >
> > Please let me know if there's some problem.
> >
> > Thanks,
> > Chunyan
> >
> > ----------------------------------------------------------------
> >
> > Suzuki K Poulose (1):
> >   arm64: dts: sc9836/sc9860: Update coresight bindings for hardware
> >     ports
> >
> >  arch/arm64/boot/dts/sprd/sc9836.dtsi |  78 +++++++------
> >  arch/arm64/boot/dts/sprd/sc9860.dtsi | 215 ++++++++++++++++++-----------------
> >  2 files changed, 151 insertions(+), 142 deletions(-)
