Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754929AbeDCEvk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 00:51:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:43740 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753148AbeDCEvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 00:51:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,398,1517904000";
   d="scan'208";a="40254569"
Date: Tue, 3 Apr 2018 10:25:56 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Harsha Priya N <harshapriya.n@intel.com>,
        Naveen M <naveen.m@intel.com>, Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH][RESEND] ASoC: Intel: atom: fix ACPI/PCI Kconfig
Message-ID: <20180403045554.GT15443@localhost>
References: <20180402170614.5599-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402170614.5599-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 12:06:14PM -0500, Pierre-Louis Bossart wrote:
> The split between ACPI and PCI platforms generated issues with randconfig:
> 
> with SND_SST_ATOM_HIFI2_PLATFORM_PCI=y and
> SND_SST_ATOM_HIFI2_PLATFORM=m, we get this module link failure:
> 
> ERROR: "sst_context_init"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> ERROR: "sst_context_cleanup"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> ERROR: "sst_alloc_drv_context"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> ERROR: "intel_sst_pm" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko]
> undefined!
> 
> ERROR: "sst_configure_runtime_pm"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> To keep things simple, let's expose two configs for
> SND_SST_ATOM_HIFI2_PLATFORM_PCI and SND_SST_ATOM_HIFI2_PLATFORM_ACPI,
> which select a common SND_SST_ATOM_HIFI2_PLATFORM option. To avoid
> breaking existing solutions with the semantics change,
> SND_SST_ATOM_HIFI2_PLATFORM_ACPI uses "default ACPI" so that "make
> oldnoconfig" and "make olddefconfig" still work as expected.
> 
> Also remove mentions of Medfield while we are at it since it was
> removed recently.

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
