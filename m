Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752806AbeDRHvj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:51:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:25511 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752166AbeDRHvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:51:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="192401955"
Message-ID: <1524037889.2553.13.camel@intel.com>
Subject: Re: [GIT PULL V3] Thermal SoC management updates for v4.17-rc1
From: Zhang Rui <rui.zhang@intel.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Wed, 18 Apr 2018 15:51:29 +0800
In-Reply-To: <20180414183051.GA27921@localhost.localdomain>
References: <20180414183051.GA27921@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eduardo,

On 六, 2018-04-14 at 11:30 -0700, Eduardo Valentin wrote:
> Hello Linus,
> 
> Please find thermal-soc changes for v4.17-rc1.
> Rui asked me to send the pull request directly to you
> as we are close to the end of the merge window.
> Essentially this pull removes the series that caused
> warning regression. I will work with the developer
> to get that fixed later on, but I am still sending
> the other few patches that are unrelated to that.
> Let me know if this causes any issues and can still
> be pulled.
> 
> Changelog:
> - New i.MX7 thermal sensor
> - Mediatek driver now supports MT7622 SoC
> - Removal of min max cpu cooling DT property
> 
> Differences in V3:
> - Rebased on top current linus/master, to avoid and merge issues
> from previous pulled thermal code.
> 
> Differences in V2:
> - Reordered the patches to drop exynos changes for now until we get
> agreement on the fix on that driver for the compilation warns
> caused by the confusing conversion functions.
> 
> 
> The following changes since commit
> 48023102b7078a6674516b1fe0d639669336049d:
> 
>   Merge branch 'overlayfs-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs (2018-04-
> 13 16:55:41 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-
> thermal linus
> 
> for you to fetch changes up to
> 15a32df1918259be6c23fc36014fc26ee66c836c:
> 
>   dt-bindings: thermal: Remove "cooling-{min|max}-level" properties
> (2018-04-14 09:37:55 -0700)
> 
This pull request does not catch this merge window.
So do you want to split it into 2 separate pull requests, one for 4.17-
rc and another for 4.18-rc1?

> ----------------------------------------------------------------
> Anson Huang (1):
>       thermal: imx: add i.MX7 thermal sensor support
> 
> Bartlomiej Zolnierkiewicz (1):
>       dt-bindings: thermal: remove no longer needed samsung thermal
> properties
> 
> Sean Wang (2):
>       dt-bindings: thermal: add binding for MT7622 SoC
>       thermal: mediatek: add support for MT7622 SoC
> 
> Viresh Kumar (1):
>       dt-bindings: thermal: Remove "cooling-{min|max}-level"
> properties
> 
IMO, together with the refreshed exynos fixes, the one from Viresh and
the one from Bartlomiej can be queued for 4.17-rc, and the others have
to wait until next merge window.

thanks,
rui


>  .../devicetree/bindings/thermal/exynos-thermal.txt |  23 +-
>  .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
>  .../bindings/thermal/mediatek-thermal.txt          |   1 +
>  .../devicetree/bindings/thermal/thermal.txt        |  16 +-
>  drivers/thermal/imx_thermal.c                      | 295
> ++++++++++++++++-----
>  drivers/thermal/mtk_thermal.c                      |  35 +++
>  6 files changed, 281 insertions(+), 98 deletions(-)
