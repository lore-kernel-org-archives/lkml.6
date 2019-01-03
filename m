Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2C1C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F68A2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519430;
	bh=lansdoA9jFvFNRt/mnWPdEuWNekRSictCiQEJEQ7I6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t8tzEC4+RFu5lxbxVIi0T6SKH/3Rs1TsfuTi4T2ce9yBhxw3QNSe/fESKQYb7rva+
	 BWjCnb6WDw7w/yYKjG9IX8unvO+7zF/1A3zOrfxCIKcwLXqKME5bUpynAMdJGACalF
	 PvZxTbJBf2FHlV449dIW0P8APIqPDcPkEUWm1PTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfACMnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:43:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42886 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbfACMnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:43:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so29242984otk.9;
        Thu, 03 Jan 2019 04:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYSZcH3/WYQznPv18NCvqGGJcupQOOH7azjNyvKj1Lg=;
        b=KosgccjCiD81BVi2drp09f9a68SK4EbpmNmZMCfBglEz6kW6GyUljqtwSDD+R1MDl3
         OVz9NfYEMbBpKJJ2SP/GyP3BSxSU3ofyu2wL3zT1TVRsrzOg8kAhLRwj6CVQTZqxmjW/
         LQCxt+HanV+mtiYu1YnPtCpAFGUAWiu2QY/th6z6mQKlIImNNBiQOGPGryNrLd60R68X
         OpdWTHLQSiXtLZmghr253OC3El2e7EzKNj/iQDGEnR0T3A8uNJi2210nxgqWmqKl7E17
         8flV/ItL7VDBtEDcF8/telJgbNGrwffxm6NpzfX4dTsxgSdGDIw4a0McdL2CtJgq/2Mu
         SP1g==
X-Gm-Message-State: AJcUukf38EYkMj14CS1sFil6PDOp0bAHP16zOL3nVjLPx09dA7wjRp8f
        WfIuIbDGszCNuGBGLnlck+QZxXkQ4SL8L+RXcrE=
X-Google-Smtp-Source: ALg8bN50MihDz+hz2zhcU8pGGnP9kifjpGFJTlYFVLX54NrqlMQYeEsbDVVVgibNIYVoneg1HoelH925mzRwemsC4XM=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr35066862otl.343.1546519424149;
 Thu, 03 Jan 2019 04:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-9-okaya@kernel.org>
 <20190103123352.GQ1846@sirena.org.uk>
In-Reply-To: <20190103123352.GQ1846@sirena.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Jan 2019 13:43:32 +0100
Message-ID: <CAJZ5v0gZk-ft7Z+oRx+wxeoD2gEuuN-k52C-QqJNXUORHOa2HQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] ASoC: Intel: atom: Make PCI dependency explicit
To:     Mark Brown <broonie@kernel.org>
Cc:     Sinan Kaya <okaya@kernel.org>,
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

On Thu, Jan 3, 2019 at 1:34 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jan 02, 2019 at 06:10:35PM +0000, Sinan Kaya wrote:
>
> > After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> > CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> > satisfied implicitly through dependencies on CONFIG_ACPI have to be
> > specified directly. This code relies on IOSF_MBI and IOSF_MBI depends
> > on PCI. For this reason, add a direct dependency on CONFIG_PCI to the
> > IOSF_MBI driver.
>
> I still don't understand what's going on with dependencies here and
> still don't have the cover letter or anything :( .  As far as I can tell
> the above commit is in Linus' tree so I'd expect I can just apply it
> directly

Yes, you can.

> but you were saying that this needs to go via some other tree
> so I'm a bit confused as to what's going on here.

I guess Sinan wanted it to go in via the ACPI tree like 5d32a66541c4,
but that of course isn't necessary.

If you want to pick up anything from this series, please do.  I will
pick up what's left. :-)
