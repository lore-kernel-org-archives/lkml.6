Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59748C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FDE2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546278786;
	bh=1uChU92cpLvGVMd1CnZF/dbmeBiPo1aLrxS+rt412jI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DiILmyz/mdRUG83BkV0kw8DarN1+xoujPuop0CZ4L6xpoVdQJl6OVt76ou7ER/0aF
	 LQ1Pgl3CiNXKzMDPp7d1esa1dCM9mBxl7ncfLrgp9mBT3CuD9YU5b9cHKQRD/DOZb0
	 LDDLsK0mmVd2E+JKxfT4AY1OOyTtTcPHxmKkzkdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeLaRxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbeLaRxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 12:53:04 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B83C221720;
        Mon, 31 Dec 2018 17:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546278783;
        bh=1uChU92cpLvGVMd1CnZF/dbmeBiPo1aLrxS+rt412jI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KjicB0+zI/nrW0yCDEPn0n9QffkGaWHMK4GCFZFMocPEqoQMtO7I6Hy9naa/NdzAS
         PdCIaVJ6gtTZW30hI8MtARBS3crHwhaH+knFM8w3z33scvDn7wpLAy4PPwtXEXd45q
         DoROnpQEC/Y9eJRscm+70oy5cAUrTppPMfBa+t20=
Received: by mail-oi1-f172.google.com with SMTP id a77so22295378oii.5;
        Mon, 31 Dec 2018 09:53:03 -0800 (PST)
X-Gm-Message-State: AA+aEWZ9bv0JusOUJ7CIz0AE3rALtp0yA3KTZn5rV9sKk5WvUMymMVIO
        46S4mAq3AIRsZdv5genUiYulwTSvS3vT2MD5d7s=
X-Google-Smtp-Source: AFSGD/W70kUbVXipY1zIvuaDv7hOmJYIj+5yzjVeiv39jXWxqqxSCU0n/w+a2257xx/rVC9TSh1UCzAGL94Z85MZqz0=
X-Received: by 2002:aca:c186:: with SMTP id r128mr26499667oif.52.1546278783048;
 Mon, 31 Dec 2018 09:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20181230195612.6657-1-okaya@kernel.org> <20181230195612.6657-9-okaya@kernel.org>
 <20181231174654.GH1846@sirena.org.uk>
In-Reply-To: <20181231174654.GH1846@sirena.org.uk>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Mon, 31 Dec 2018 20:52:52 +0300
X-Gmail-Original-Message-ID: <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
Message-ID: <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
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

On Mon, Dec 31, 2018 at 8:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Dec 30, 2018 at 07:56:09PM +0000, Sinan Kaya wrote:
> > Code does unconditional select for IOSF_MBI. IOSF_MBI driver depends on
> > CONFIG_PCI set but this is not specified anywhere.
>
> I don't have the cover letter or anything for this series, what's going
> on with dependencies?

Here is the executive summary:

I have a changeset that separates ACPI from PCI on 4.21. CONFIG_ACPI
used to select PCI. This is no longer true.

You can build an ACPI system without any PCI devices.
