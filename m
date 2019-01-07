Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E536AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B364F2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546874227;
	bh=uMpT5O0lOzBjpFPPwmWbYNqHrBmkCLg50NVs58cRHW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RJe2HN9uhlQQENk/+taKsKojs93Q2Fhg9Spvx/wPet2n9EpBu45k3jYBlllyy2hZ3
	 LpViMfin3mS/ExGH8RItdKqSit1XCiYJXX8u2mA3F1roPP6Hp8dYyXp2qt9hXfM/vr
	 8XGeybWWUHsqnBXyZW+F+8XnrwvN7WmYsC1PMNkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfAGPRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:17:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfAGPRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:17:06 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6522173C;
        Mon,  7 Jan 2019 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546874225;
        bh=uMpT5O0lOzBjpFPPwmWbYNqHrBmkCLg50NVs58cRHW4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i+yxbo7IMhEah2iqcEFHdRFMkM8HzmnqSeUjiSFvr1q685pDEBJHDAX3nR9+jqeP/
         7oEwGKq4YHUSFehj6A2DXEcVWcFq0m0pfADx2c1y1x+e7u6zDTuC+qR0sMeZKDNn5S
         WM+pfEVvK12i0BBUxPQV4Pt4XFDg6oJWy0EzzRnU=
Received: by mail-ot1-f49.google.com with SMTP id k98so604206otk.3;
        Mon, 07 Jan 2019 07:17:05 -0800 (PST)
X-Gm-Message-State: AJcUukcPZSoXEC6eWX7edSgUDerHekMDAItkXrcwkcFzn9fBgxQLYJ8+
        AZeDEHDW5QgsWtYkKrizpNOhup8lZDkCH4ZxQLM=
X-Google-Smtp-Source: ALg8bN4goN80bRZEpPH4a851HIS/9EhnFhlTaPI3ZM6ndfMRnyp4lhDKYCPe3qozCGoiFsb6Fa+fwg0Z89PRqmQOfGs=
X-Received: by 2002:a9d:6b82:: with SMTP id b2mr39781350otq.210.1546874224473;
 Mon, 07 Jan 2019 07:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20190105100606.6673-1-okaya@kernel.org> <20190105100606.6673-9-okaya@kernel.org>
 <CAJZ5v0g2bjzjuiDPTbBN8QgvOG0KMC0Ew2QOQH4u2+y6KRo0wQ@mail.gmail.com> <20190107121919.GA9570@sirena.org.uk>
In-Reply-To: <20190107121919.GA9570@sirena.org.uk>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Mon, 7 Jan 2019 10:16:53 -0500
X-Gmail-Original-Message-ID: <CAK9iUCPjMr0m+9HUXEbtUPrsvO84HpZV39CUYYkne=EpY_X+bQ@mail.gmail.com>
Message-ID: <CAK9iUCPjMr0m+9HUXEbtUPrsvO84HpZV39CUYYkne=EpY_X+bQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] ASoC: Intel: atom: Make PCI dependency explicit
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Mon, Jan 7, 2019 at 7:19 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jan 07, 2019 at 12:15:35PM +0100, Rafael J. Wysocki wrote:
> > On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> > > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> > > Signed-off-by: Sinan Kaya <okaya@kernel.org>
>
> > Sinan, I thought you received an ACK from Pierre-Louis on this one, didn't you?
>
> Yes.  I've also applied it already and it's *still* being sent without
> either a cover letter or the rest of the series :(

There is a cover letter but it is being sent to Linux-acpi and Linux-next only.

https://patchwork.kernel.org/cover/10749203/

This means that you are not on either of these mailing lists.

>
> Sinan:
>
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

I apologize. I didn't realize that you applied this already. I'll drop
this patch
in case I need to submit a new revision.
