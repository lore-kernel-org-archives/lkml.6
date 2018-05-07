Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeEGQvo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:51:44 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:51024 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751923AbeEGQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:51:43 -0400
Date: Mon, 7 May 2018 11:52:48 -0500
From: Julia Cartwright <julia@ni.com>
To: Naga Sureshkumar Relli <nagasure@xilinx.com>
CC: "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [LINUX PATCH v8 2/2] memory: pl353: Add driver for arm pl353
 static memory controller
Message-ID: <20180507165248.GK967@jcartwri.amer.corp.natinst.com>
References: <1521024235-30374-1-git-send-email-nagasureshkumarrelli@gmail.com>
 <1521024274-30467-1-git-send-email-nagasureshkumarrelli@gmail.com>
 <20180403165042.GE7654@jcartwri.amer.corp.natinst.com>
 <BY2PR02MB1411FA717E8DFB244F9B7976AF9B0@BY2PR02MB1411.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BY2PR02MB1411FA717E8DFB244F9B7976AF9B0@BY2PR02MB1411.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 10:12:28AM +0000, Naga Sureshkumar Relli wrote:
> Hi Julia,
>
> Thanks for reviewing the patch and Sorry for my late reply. This patch
> went to junk folder, hence I didn't catch this patch.
>
> From: Julia Cartwright [mailto:julia@ni.com]
[..]
> > 
> > It would be easier to follow if you constructed your two patchsets with git format-patch --
> > thread.
> >
>
> I am using the same but with out --thread.
>
> > Or, merge them into a single patchset, especially considering the dependency between patches.
>
> But both are different patches, one for Device tree documentation and other for driver update.

Yes, I'm not proposing you merge _patches_ but _patchsets_.  You have
two patchsets, one for the SMC driver, and another for the NAND.  Given
that they depend on one another, it's helpful for reviewers if you sent
them all together, with a cover letter which describes the entire
patchset, changelog, it's dependencies, revision changelog, etc.

Something like:

   [PATCH v9 0/4] rawnand: memory: add support for PL353 static memory controller + NAND
      [PATCH v9 1/4] Devicetree: Add pl353 smc controller devicetree binding information
      [PATCH v9 2/4] memory: pl353: Add driver for arm pl353 static memory controller
      [PATCH v9 3/4] Documentation: nand: pl353: Add documentation for controller and driver
      [PATCH v9 4/4] mtd: rawnand: pl353: Add basic driver for arm pl353 smc nand interface

Anyway, just with --thread enabled would be an improvement.

[..]
> > > --- a/drivers/memory/Kconfig
> > > +++ b/drivers/memory/Kconfig
> > > @@ -152,6 +152,13 @@ config DA8XX_DDRCTL
> > >  	  This driver is for the DDR2/mDDR Memory Controller present on
> > >  	  Texas Instruments da8xx SoCs. It's used to tweak various memory
> > >  	  controller configuration options.
> > > +config PL35X_SMC
> > > +	bool "ARM PL35X Static Memory Controller(SMC) driver"
> >
> > Is there any reason why this can't be tristate?
>
> There is a Nand driver which uses this driver. i.e The NAND driver
> Depends on this driver.

That's true, but it's irrelevant to question I asked.  It is perfectly
valid for both the SMC and NAND drivers to be tristate, why are you not
allowing this configuration?

   Julia
