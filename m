Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1329EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCAF20663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCAF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393641AbeKVUe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:34:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:38621 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390158AbeKVUe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:34:58 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 01:56:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,265,1539673200"; 
   d="scan'208";a="110627573"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2018 01:56:12 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gPliV-0002cp-4h; Thu, 22 Nov 2018 11:56:11 +0200
Date:   Thu, 22 Nov 2018 11:56:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] ASoC: Intel: Skylake: Add CFL-S support
Message-ID: <20181122095611.GV10650@smile.fi.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <20181120213644.19103-2-pierre-louis.bossart@linux.intel.com>
 <20181121142721.GO10650@smile.fi.intel.com>
 <414b4c3a-7e04-2775-7d87-16a236b5b4e8@linux.intel.com>
 <20181121173841.GS10650@smile.fi.intel.com>
 <s5hh8gaaxdm.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hh8gaaxdm.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:17:41PM +0100, Takashi Iwai wrote:
> On Wed, 21 Nov 2018 18:38:41 +0100, Andy Shevchenko wrote:

> > Compare:
> > 
> > 	/* CFL */
> > 	{ PCI_DEVICE(0x8086, 0xa348),
> > 		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
> > 
> > to something like:
> > 
> > #define PCI_DEVICE_ID_INTEL_AUDIO_CFL	0xa348
> > ...
> > 
> > 	{PCI_DEVICE_DATA(INTEL, AUDIO_CFL, &snd_soc_acpi_intel_cnl_machines)},
> 
> The former gives a better grep-ability, though.
> 
> I have no big preference over two, just want to mention that both have
> merits and demerits.

True.
So, up to you, guys, what to choose.

-- 
With Best Regards,
Andy Shevchenko


