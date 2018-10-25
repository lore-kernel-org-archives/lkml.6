Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519C3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2A32082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2A32082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeJYRuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:50:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:27871 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbeJYRuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 13:50:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 02:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,423,1534834800"; 
   d="scan'208";a="244242618"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2018 02:18:39 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gFbmm-0002DP-VY; Thu, 25 Oct 2018 12:18:36 +0300
Date:   Thu, 25 Oct 2018 12:18:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sven Van Asbroeck <svendev@arcx.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, treding@nvidia.com, david@lechnology.com,
        noralf@tronnes.org, johan@kernel.org, monstr@monstr.eu,
        michal.vokac@ysoft.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        yuanzhichang@hisilicon.com, stuyoder@gmail.com,
        linus.walleij@linaro.org, maxime.ripard@bootlin.com,
        bogdan.purcareata@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v1 0/4] Support HMS Profinet Card over Anybus
Message-ID: <20181025091836.GV10650@smile.fi.intel.com>
References: <20181024142456.10084-1-svendev@arcx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024142456.10084-1-svendev@arcx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 10:24:52AM -0400, Sven Van Asbroeck wrote:
> This patch set adds support for the HMS Industrial Networks AB Profinet card.
> 
> Profinet is an industry technical standard for data communication over
> Industrial Ethernet, designed for collecting data from, and controlling,
> equipment in industrial systems, with a particular strength in delivering data
> under tight time constraints (on the order of 1ms or less).
> 
> The profinet card itself is connected to the system via an industrial bus
> called 'anybus'.
> 
> I have followed the bus driver/client driver pattern, and created an anybus
> bus driver, plus a client driver for the profinet card.
> 
> In case this patch set gets (eventually) accepted, drivers for other anybus
> client cards may follow: flnet, cc-link, ...
> 
> The anybus slot on the host is located on an 'anybus bridge', which is
> custom h/w designed by Arcx. Its driver is modeled as an mfd, which
> instantiates two anybus slots.

I highly recommend to look at my recent (for few month?) reviews -- they are
almost repeating each other.

Also check what we have under lib/ (hint: read linux/kernel.h for inline and
exported function helpers).

I might look at the patches later on if I would have some spare time (I
actually don't know why I'm in Cc list here).

> 
> v1:
> 	first shot
> 
> Sven Van Asbroeck (4):
>   mfd: support the Arcx anybus bridge.
>   dt-bindings: anybus-bridge: document devicetree binding.
>   bus: support HMS Anybus-S bus.
>   misc: support HMS Profinet IRT industrial controller.
> 
>  .../bindings/mfd/arcx,anybus-bridge.txt       |   37 +
>  .../devicetree/bindings/vendor-prefixes.txt   |    1 +
>  drivers/bus/Kconfig                           |   11 +
>  drivers/bus/Makefile                          |    1 +
>  drivers/bus/anybuss-host.c                    | 1301 +++++++++++++++++
>  drivers/mfd/Kconfig                           |   11 +
>  drivers/mfd/Makefile                          |    1 +
>  drivers/mfd/anybus-bridge.c                   |  441 ++++++
>  drivers/misc/Kconfig                          |   11 +
>  drivers/misc/Makefile                         |    1 +
>  drivers/misc/hms-profinet.c                   |  747 ++++++++++
>  include/linux/anybuss-client.h                |  100 ++
>  include/linux/anybuss-host.h                  |   28 +
>  include/uapi/linux/hms-common.h               |   14 +
>  include/uapi/linux/hms-profinet.h             |  101 ++
>  15 files changed, 2806 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt
>  create mode 100644 drivers/bus/anybuss-host.c
>  create mode 100644 drivers/mfd/anybus-bridge.c
>  create mode 100644 drivers/misc/hms-profinet.c
>  create mode 100644 include/linux/anybuss-client.h
>  create mode 100644 include/linux/anybuss-host.h
>  create mode 100644 include/uapi/linux/hms-common.h
>  create mode 100644 include/uapi/linux/hms-profinet.h
> 
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


