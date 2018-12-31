Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EDEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0E7213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546284934;
	bh=qku8PB9SFYye9LzArIAekauMbxhaBS4a8xhsPNmtkco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HsRRBm0gd1AE4StF6350kVRRLuGWyE8Zq/Vm/qk6p32qAPmpmiYTXS5DAv5vygnaG
	 liMxzSXN18QVIfRePXETXWvGegQKsCvPxd3bK+0xiWQsyjYA6tYQF6U0EBJXFZHXb8
	 uGPY7Rhtb1gpGvQIzU122KHa0QrNzgzSrkfuvuzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeLaTfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 14:35:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbeLaTfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 14:35:31 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 267A0213A2;
        Mon, 31 Dec 2018 19:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546284931;
        bh=qku8PB9SFYye9LzArIAekauMbxhaBS4a8xhsPNmtkco=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KZF3963wgznsjwnKBldNV5KPlFgDlwwuQV2wpp4UqiBq9p4pwPLvExBF6OeOXIkI9
         NztuHVRzYISTWCpSI1o+A53n8TVllwlpMd8t+gcDTy9WWGvViWkBYa664aEBZn3J4v
         GKtSBrmXc1fOe2754MisEWATacw+J6pQO4KZZB8E=
Received: by mail-oi1-f174.google.com with SMTP id a77so22441033oii.5;
        Mon, 31 Dec 2018 11:35:31 -0800 (PST)
X-Gm-Message-State: AA+aEWbwDTolcXoSXbX6J/3lyf1N8mcXQ9YSXAUHXDTihmJNdOcXRuoJ
        DveMEmkPExA2mrOqa4EOqhFPwJwXf8wLrwGrQGU=
X-Google-Smtp-Source: AFSGD/Xuqp/LU5S52FTMzMsFdYKLdpML1/KI+AJ8C6D2fAdCSJcgGU6nRMAO2/+TfnAbsFetku8O0IR9wPLzjBSgcRI=
X-Received: by 2002:aca:2108:: with SMTP id 8mr26158334oiz.171.1546284930416;
 Mon, 31 Dec 2018 11:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20181230195612.6657-1-okaya@kernel.org> <20181230195612.6657-9-okaya@kernel.org>
 <20181231174654.GH1846@sirena.org.uk> <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
 <20181231193017.GN1846@sirena.org.uk>
In-Reply-To: <20181231193017.GN1846@sirena.org.uk>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Mon, 31 Dec 2018 22:35:20 +0300
X-Gmail-Original-Message-ID: <CAK9iUCNf9JqwvtL4O5KVHP9ZN3y66wZOTjOsGcXFc-T_g6xtEQ@mail.gmail.com>
Message-ID: <CAK9iUCNf9JqwvtL4O5KVHP9ZN3y66wZOTjOsGcXFc-T_g6xtEQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI dependency explicit
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 10:30 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Dec 31, 2018 at 08:52:52PM +0300, Sinan Kaya wrote:
> > On Mon, Dec 31, 2018 at 8:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > I don't have the cover letter or anything for this series, what's going
> > > on with dependencies?
>
> > Here is the executive summary:
>
> > I have a changeset that separates ACPI from PCI on 4.21. CONFIG_ACPI
> > used to select PCI. This is no longer true.
>
> > You can build an ACPI system without any PCI devices.
>
> So there's no dependency and I can just apply this?

The plan is to apply this patchset via ACPI tree. Need an Acked-by per patch.
