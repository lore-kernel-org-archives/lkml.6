Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C980C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76502171F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546509162;
	bh=zAJe8qw0kH7ieiXcKIkW+IZNr3Pr6z73VoUbDcaqAAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lBBJp2hlohRS0RpUiinWed0su7hZass6RzPVke5ofG7TKxLQ5Ek1kBgyjO09qMgjJ
	 nXtsEc3SXkWe+PNlZW62o7aeSZrJvz7o01LU1WuLHTP+LeUe3a/y07TJBq6WnLk1jU
	 mYmsw5cCrMtjk3NR90ZPrCaDPzvjkV/3O43sDhwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfACJwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:52:41 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44270 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbfACJwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:52:41 -0500
Received: by mail-ot1-f67.google.com with SMTP id f18so28906940otl.11;
        Thu, 03 Jan 2019 01:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7hJmE6M6okWD63zwDFmJVqMqwljZ5A1UenhsuRVPzM=;
        b=I66E0uRL2bITnblPTaqS1m7nqdG6qdpGkaTVziDEi/qL+0ktYGDkrTzue1i+WSgnWH
         imIo7NWCDQIOcqL8FHHnkRZO/58WIkb37zdOjoy8+TiLZq8GFOuy0xzq+zxEfQUTf68f
         XLW5iO0t+OBhz+tReKbluktyZFe9i8Vmfa3lHcftS7Wkh0i2QMbgotzoxhIh+Cl1X8lW
         9OFjZXRo7I1IYA/IaNKUqaKJG3T+DP8fdfFAt75WRSbBillWZ7yk/Kf5X7TdSrNfyQOe
         NrLwV0a6gFrF0OQGYG6vWgy2D97kY+VVny/pFPVth/3Ce6YQZsnJPVl7YfpcsPKvO8xG
         Si/g==
X-Gm-Message-State: AJcUukeG2nd97+uxw+SxmMdn6a6dkZP3YcR553g5AbE1u6i7lvKxBqoO
        W1xAlu286FxkXJ2TkQC7eql/NjSCqCOPaV/oQAk=
X-Google-Smtp-Source: ALg8bN6hfxHK6Q7FajLCDBvCLd7vYv5OF99dObIbG9wgkZdUQORgPD3BmgjNkRg+rOfnwXaD5OtO/GO56uVF8O9hxIY=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr31247795otn.200.1546509159295;
 Thu, 03 Jan 2019 01:52:39 -0800 (PST)
MIME-Version: 1.0
References: <20190102181038.4418-1-okaya@kernel.org> <CAK9iUCPWQ=9EgnUFo8BHraEgFwHs3FdbegPLwhT-KHD=r2WBkQ@mail.gmail.com>
 <8c69f8d0-6a95-0011-ff87-8ac9236a992d@linux.intel.com> <5797826.UxqLOWUXRU@localhost.localdomain>
In-Reply-To: <5797826.UxqLOWUXRU@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Jan 2019 10:52:28 +0100
Message-ID: <CAJZ5v0j=i_YN7szXLV8cKLp2XmoqUTQR6EJhRJhWFJzenhzM9Q@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v5 08/11] ASoC: Intel: atom: Make PCI
 dependency explicit
To:     Chandan Rajendra <chandan@linux.ibm.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Sinan Kaya <Okaya@kernel.org>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        "Ted Ts'o" <tytso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 5:08 AM Chandan Rajendra <chandan@linux.ibm.com> wrote:
>
> On Thursday, January 3, 2019 5:20:27 AM IST Pierre-Louis Bossart wrote:
> >
> > On 1/2/19 4:58 PM, Sinan Kaya wrote:
> > > On Wed, Jan 2, 2019 at 10:50 PM Pierre-Louis Bossart
> > > <pierre-louis.bossart@linux.intel.com> wrote:
> > >>
> > >>> This is pointing to a kconfig issue on ia64 arch.
> > >>>
> > >>> arch/ia64/Kconfig:128:error: recursive dependency detected!
> > >>> arch/ia64/Kconfig:128:    choice <choice> contains symbol IA64_HP_SIM
> > >>> arch/ia64/Kconfig:202:    symbol IA64_HP_SIM is part of choice PM
> > >>>
> > >>> IA64_HP_SIM is both a choice and is selected.
> > >>>
> > >>> I did allyesconfig and disabled PCI afterwards to find all the issues
> > >>> on this patchset.
> > >> Are you saying there's a newer series that fixes this issue for both
> > >> allyesconfig and allmodconfig?
> > >>
> > >> if yes, then we're good.
> > >
> > > No, I haven't fixed ia64 kconfig issue. That's somebody else's job. I
> > > used allyesconfig to find out all compilation issues on x86 arch to
> > > come up with this patchset.
> >
> > Nothing makes me cringe more than "somebody else's job" statements. In
> > this case, there is obviously a correlation with your ACPI changes since
> > the circular dependency happens because of the ACPI symbol.
> >
> > arch/ia64/Kconfig:126:error: recursive dependency detected!
> > arch/ia64/Kconfig:126:    choice <choice> contains symbol IA64_HP_SIM
> > arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice PM
> > kernel/power/Kconfig:144:    symbol PM is selected by PM_SLEEP
> > kernel/power/Kconfig:104:    symbol PM_SLEEP depends on HIBERNATE_CALLBACKS
> > kernel/power/Kconfig:31:    symbol HIBERNATE_CALLBACKS is selected by
> > HIBERNATION
> > kernel/power/Kconfig:34:    symbol HIBERNATION depends on SWAP
> > init/Kconfig:250:    symbol SWAP depends on BLOCK
> > block/Kconfig:5:    symbol BLOCK is selected by UBIFS_FS
> > fs/ubifs/Kconfig:1:    symbol UBIFS_FS depends on MISC_FILESYSTEMS
> > fs/Kconfig:220:    symbol MISC_FILESYSTEMS is selected by ACPI_APEI
> > drivers/acpi/apei/Kconfig:8:    symbol ACPI_APEI depends on ACPI
> > drivers/acpi/Kconfig:9:    symbol ACPI depends on ARCH_SUPPORTS_ACPI
> > <<<< LOOK HERE
> > drivers/acpi/Kconfig:6:    symbol ARCH_SUPPORTS_ACPI is selected by
> > IA64_HP_SIM
> > arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice <choice>
> >
> > At any rate, a 3 mn git bisect tells me the circular dependency is
> > exposed by this change:
> >
> > f3fd6cd74fedf99b6060f75df00943fda13b65f2 is the first bad commit
> > commit f3fd6cd74fedf99b6060f75df00943fda13b65f2
> > Author: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> > Date:   Sat Dec 8 12:21:38 2018 +0530
> >
> >      fscrypt: remove filesystem specific build config option
> >
> >      In order to have a common code base for fscrypt "post read" processing
> >      for all filesystems which support encryption, this commit removes
> >      filesystem specific build config option (e.g.
> > CONFIG_EXT4_FS_ENCRYPTION)
> >      and replaces it with a build option (i.e. CONFIG_FS_ENCRYPTION) whose
> >      value affects all the filesystems making use of fscrypt.
> >
> >      Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> >      Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> >
>
> FWIW, The patch at https://patchwork.kernel.org/patch/10725883/ fixes this
> problem by removing "select BLOCK if FS_ENCRYPTION" from fs/ubifs/Kconfig.

OK

Pierre-Louis, can you check if this patch makes the issue go away for
you, please?
