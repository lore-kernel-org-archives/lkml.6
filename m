Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755520AbeDTOsh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:48:37 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:36907 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755264AbeDTOsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:48:32 -0400
X-Google-Smtp-Source: AIpwx4+4w8yFbGGLJrwjkPLkl3Y5urUJ2XiEkNj3QiAagV5s4qdok4TP0asG9CBOpFNOyi55CmK49w==
Date: Fri, 20 Apr 2018 07:48:31 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL V3] Thermal SoC management updates for v4.17-rc1
Message-ID: <20180420144829.GA20978@localhost.localdomain>
References: <20180414183051.GA27921@localhost.localdomain>
 <1524037889.2553.13.camel@intel.com>
 <20180418141027.GA3303@localhost.localdomain>
 <CGME20180419104145eucas1p2e64408e3340d5af7731765df0e82f1cd@eucas1p2.samsung.com>
 <13169679.AINr0uuryx@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13169679.AINr0uuryx@amdc3058>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bartlomiej,

On Thu, Apr 19, 2018 at 12:41:42PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Wednesday, April 18, 2018 07:10:30 AM Eduardo Valentin wrote:
> > Hello,
> > 
> > On Wed, Apr 18, 2018 at 03:51:29PM +0800, Zhang Rui wrote:
> > > Hi, Eduardo,
> > > 
> > > On å…­, 2018-04-14 at 11:30 -0700, Eduardo Valentin wrote:
> > > > Hello Linus,
> > > > 
> > > > Please find thermal-soc changes for v4.17-rc1.
> > > > Rui asked me to send the pull request directly to you
> > > > as we are close to the end of the merge window.
> > > > Essentially this pull removes the series that caused
> > > > warning regression. I will work with the developer
> > > > to get that fixed later on, but I am still sending
> > > > the other few patches that are unrelated to that.
> > > > Let me know if this causes any issues and can still
> > > > be pulled.
> > > > 
> > > > Changelog:
> > > > - New i.MX7 thermal sensor
> > > > - Mediatek driver now supports MT7622 SoC
> > > > - Removal of min max cpu cooling DT property
> > > > 
> > > > Differences in V3:
> > > > - Rebased on top current linus/master, to avoid and merge issues
> > > > from previous pulled thermal code.
> > > > 
> > > > Differences in V2:
> > > > - Reordered the patches to drop exynos changes for now until we get
> > > > agreement on the fix on that driver for the compilation warns
> > > > caused by the confusing conversion functions.
> > > > 
> > > > 
> > > > The following changes since commit
> > > > 48023102b7078a6674516b1fe0d639669336049d:
> > > > 
> > > > Â  Merge branch 'overlayfs-linus' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs (2018-04-
> > > > 13 16:55:41 -0700)
> > > > 
> > > > are available in the git repository at:
> > > > 
> > > > Â  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-
> > > > thermal linus
> > > > 
> > > > for you to fetch changes up to
> > > > 15a32df1918259be6c23fc36014fc26ee66c836c:
> > > > 
> > > > Â  dt-bindings: thermal: Remove "cooling-{min|max}-level" properties
> > > > (2018-04-14 09:37:55 -0700)
> > > > 
> > > This pull request does not catch this merge window.
> > > So do you want to split it into 2 separate pull requests, one for 4.17-
> > > rc and another for 4.18-rc1?
> > 
> > OK. Yeah, I am fine with that.
> > 
> > > 
> > > > ----------------------------------------------------------------
> > > > Anson Huang (1):
> > > > Â Â Â Â Â Â thermal: imx: add i.MX7 thermal sensor support
> > > > 
> > > > Bartlomiej Zolnierkiewicz (1):
> > > > Â Â Â Â Â Â dt-bindings: thermal: remove no longer needed samsung thermal
> > > > properties
> > > > 
> > > > Sean Wang (2):
> > > > Â Â Â Â Â Â dt-bindings: thermal: add binding for MT7622 SoC
> > > > Â Â Â Â Â Â thermal: mediatek: add support for MT7622 SoC
> > > > 
> > > > Viresh Kumar (1):
> > > > Â Â Â Â Â Â dt-bindings: thermal: Remove "cooling-{min|max}-level"
> > > > properties
> > > > 
> > > IMO, together with the refreshed exynos fixes, the one from Viresh and
> > > the one fromÂ Bartlomiej can be queued for 4.17-rc, and the others have
> > > to wait until next merge window.
> > > 
> > 
> > Correct, the new chip support will need to wait for the next merge
> > window. I have already split the patches into the two categories.
> > The patches removing stuff are in my -fixes branch. All the other adding
> > new chip support are in my -linus branch.
> > 
> > Now, Do you have anything for this -rc2 ? If not, I will send directly
> > to Linus the stuff in my -fixes branch. Let me know.
> 
> What about refreshed Exynos patches (https://lkml.org/lkml/2018/4/16/256)?

Cool! Thanks for fixing that warning.

> 
> Fixes from Marek (first two patches) are quite critical (without them
> booting with thermal enabled triggers critical temperature handling on
> Exynos4210 SoC).

I will include those two fixes in rc3. The other of that patch series
will go into the next merge window.

Thanks for helping me to keep track of the patches.

BR,
Eduardo
