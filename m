Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbeDDFuE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:50:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:32863 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeDDFuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:50:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,405,1517904000";
   d="scan'208";a="34107471"
Date: Wed, 4 Apr 2018 11:24:21 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: rcar-dmac: Fix too early/late system
 suspend/resume callbacks
Message-ID: <20180404055420.GE15443@localhost>
References: <1522342412-10126-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522342412-10126-1-git-send-email-geert+renesas@glider.be>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 06:53:32PM +0200, Geert Uytterhoeven wrote:
> If serial console wake-up is enabled ("echo enabled >
> /sys/.../ttySC0/power/wakeup"), and any serial input is received while
> the system is suspended, serial port input no longer works after system
> resume.
> 
> Note that:
>   1) The system can still be woken up using the serial console,
>   2) Serial port input keeps working if the system is woken up in some
>      other way (e.g. Wake-on-LAN or gpio-keys), and no serial input was
>      received while suspended.
> 
> To fix this, replace SET_LATE_SYSTEM_SLEEP_PM_OPS() by
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(), as the callbacks installed by the
> former happen too early resp. late in the suspend resp. resume process.

Applied, thanks

-- 
~Vinod
