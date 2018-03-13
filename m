Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AG47ELtcIMqJx7fwhm4cvq0c6YLRmadGBUWtruuwDeOXRVWj44uWUK/JflM64OR+VH1eEvXu6cRU
ARC-Seal: i=1; a=rsa-sha256; t=1520978090; cv=none;
        d=google.com; s=arc-20160816;
        b=wNsRL/MidnCGBMhX8eDYjzCiND4xRbE3V7ednbFqozo86MwINiByicc9ubjSS26bFF
         NJGCZbOLlPPVSt5DjasLS8M/+S8xd8QrrFDzJA1cbnGZqp+0CiRHU79filrZ9FoN79sv
         9O4ooMnU/fBrgWaeNscf9Skj/8bZT8puFNLvCFV6EWWpM9I3j0izn9NyVdYX38EkSPS4
         1oGTS7BYjab3QrPetEbtcmOCTn2wReSqev+mViCE7EOy3zdB+bm1zfgCpkLBj+YYQ8PT
         oKGh3xpZd3SU1i/kGri6aIFS7WwlTgW5KkKDjUwwRagw0BTvY5TElx9yW97kaomuTHQH
         Q5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=iGhRTvCO5+89q8tU945SRSkdpaepwENKGl5hH+XclrA=;
        b=eXde9O85lqdFQl7auDY9PC2EQBqMKkyyX4zfjdUDpbmB4OjjXAGd8KJaRwsTX33Jt+
         pR3aFh3u16XTXmeiVZQdd2a63PnO7qzQWzy4EXhczrV2apINxaH0HDkjwn3mHZhrw8JN
         lZndVdFgTlBsnmhV7tB9vIIIu7OF7SCYyq8kvEUee2y8hJfVUMuyARhgEsTbqS007WWN
         Ke0EayExK6etTSmzJwOQLWe6rxVPiup6dtemNDDPe2pvyKg6+IwAiFqA1boI4noo+lJB
         Xy8vfsSI4gFvgJKuBiov3rdTNwM6koaqToZK0j88z7nsXW8tajP7AtIWGDkRmmx9z/1y
         XhFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,466,1515484800";
   d="scan'208";a="211266008"
Date: Wed, 14 Mar 2018 05:53:58 +0800
From: kbuild test robot <lkp@intel.com>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: kbuild-all@01.org, hch@lst.de, robin.murphy@arm.com,
	linux@armlinux.org.uk, gregkh@linuxfoundation.org,
	m.szyprowski@samsung.com, bhelgaas@google.com,
	dmitry.torokhov@gmail.com, rafael.j.wysocki@intel.com,
	jarkko.sakkinen@linux.intel.com, linus.walleij@linaro.org,
	johan@kernel.org, msuchanek@suse.de, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [RFC PATCH] dma-mapping: platform_dma_configure() can be static
Message-ID: <20180313215358.GA20099@lkp-wsm-ep1>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594861122609809352?=
X-GMAIL-MSGID: =?utf-8?q?1594861122609809352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Fixes: 9a019f425175 ("dma-mapping: move dma configuration to bus infrastructure")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 platform.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index adf94eb..dc9c790 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1130,7 +1130,7 @@ int platform_pm_restore(struct device *dev)
 
 #endif /* CONFIG_HIBERNATE_CALLBACKS */
 
-int platform_dma_configure(struct device *dev)
+static int platform_dma_configure(struct device *dev)
 {
 	enum dev_dma_attr attr;
 	int ret = 0;
@@ -1146,7 +1146,7 @@ int platform_dma_configure(struct device *dev)
 	return ret;
 }
 
-void platform_dma_deconfigure(struct device *dev)
+static void platform_dma_deconfigure(struct device *dev)
 {
 	of_dma_deconfigure(dev);
 	acpi_dma_deconfigure(dev);
