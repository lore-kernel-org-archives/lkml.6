Return-Path: <robert.jarzmik@free.fr>
X-Google-Smtp-Source: AIpwx483nJU56l1tGnnkzlxa4IM7gGhiNtXaU7VfZWk9f3ZJnj1fgq76BtOT84UaNQmWfbxWURbM
ARC-Seal: i=1; a=rsa-sha256; t=1522679310; cv=none;
        d=google.com; s=arc-20160816;
        b=mFRPikLN1vndUYJMMm+g0HddVE8DMCPactY7iUJlojHv9CRuO55n5cj161rtfirUG2
         N6rxlH1BcR9shtgO750vZR1Fsjxb+Iwwb6DTWiTsyTcrpARuBj8ZsZXr8AL61SctFpmD
         NByci5M3v/L4I95qpU/t7kIBR2iuh6GULVp2UEjAnEKH777PTqxE4hbkz/V1wa3Dd7hP
         F5PX9qOdQGek9QBD/XHtRl2Vs3Dlwlh+OWNPhtTxli4trpEhjmIi/nyH16SBchP8sdDZ
         EWlmqIeW/AMiEZGSiqHb1RAx40jPbm+bnFWsUx3FaGoJRkwYMe6yOf2zFOss+GcpskEC
         Ci+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=99ElSoHz5AgT42D0x0ucEmjsaxIknXnLdaygmBy5p/o=;
        b=xIVqmCLBw6jlwUd6OR1hTI5n8Wo/89aQ6WmXNxAwN5qyZZtjq3xf9RQdbLSulilmW8
         U7Kl/oXJcUj4MIn5nabOJMgIxScd3F6vjLJoOUJ1xofQjshsofV9gukK/UFz/g27U1N4
         EuZQh1opKYx15CUidHIBJHt2/HcZvrH+lBuzW91CSxFDVbbd2l6hHP32o/Gf9tok/58O
         csqk6Uh3mx16MKcn2PclKCSC09DmwvhAE0/OhQx+GIMlyIXdzi9ZdLXgqJbYdJsU0bfs
         OitxfFy7Wmp8Ej8XuuF6pQYRiyaTyag4O7yqVBgbssNTN60VLKM2Q30G2+/ytkN49NkH
         YpyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 02 Apr 2018 16:28:30 +0200
X-ME-IP: 86.201.130.131
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Tejun Heo <tj@kernel.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Samuel Ortiz <samuel@sortiz.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org,
	devel@driverdev.osuosl.org,
	alsa-devel@alsa-project.org
Subject: [PATCH 13/15] ARM: pxa: remove the DMA IO resources
Date: Mon,  2 Apr 2018 16:26:54 +0200
Message-Id: <20180402142656.26815-14-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644981572750848?=
X-GMAIL-MSGID: =?utf-8?q?1596644981572750848?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As the last driver using the former mechanism to acquire the DMA
requestor line has be converted to the dma_slave_map, remove all these
resources from the PXA devices.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/devices.c | 136 --------------------------------------------
 1 file changed, 136 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index da67ebe9a7d5..c0b3c90fd67f 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -61,16 +61,6 @@ static struct resource pxamci_resources[] = {
 		.end	= IRQ_MMC,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		.start	= 21,
-		.end	= 21,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= 22,
-		.end	= 22,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 static u64 pxamci_dmamask = 0xffffffffUL;
@@ -408,16 +398,6 @@ static struct resource pxa_ir_resources[] = {
 		.end	= 0x40700023,
 		.flags  = IORESOURCE_MEM,
 	},
-	[5] = {
-		.start  = 17,
-		.end	= 17,
-		.flags  = IORESOURCE_DMA,
-	},
-	[6] = {
-		.start  = 18,
-		.end	= 18,
-		.flags  = IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa_device_ficp = {
@@ -546,18 +526,6 @@ static struct resource pxa25x_resource_ssp[] = {
 		.end	= IRQ_SSP,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 13,
-		.end	= 13,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 14,
-		.end	= 14,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa25x_device_ssp = {
@@ -584,18 +552,6 @@ static struct resource pxa25x_resource_nssp[] = {
 		.end	= IRQ_NSSP,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 15,
-		.end	= 15,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 16,
-		.end	= 16,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa25x_device_nssp = {
@@ -622,18 +578,6 @@ static struct resource pxa25x_resource_assp[] = {
 		.end	= IRQ_ASSP,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 23,
-		.end	= 23,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 24,
-		.end	= 24,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa25x_device_assp = {
@@ -752,18 +696,6 @@ static struct resource pxa27x_resource_ssp1[] = {
 		.end	= IRQ_SSP,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 13,
-		.end	= 13,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 14,
-		.end	= 14,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa27x_device_ssp1 = {
@@ -790,18 +722,6 @@ static struct resource pxa27x_resource_ssp2[] = {
 		.end	= IRQ_SSP2,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 15,
-		.end	= 15,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 16,
-		.end	= 16,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa27x_device_ssp2 = {
@@ -828,18 +748,6 @@ static struct resource pxa27x_resource_ssp3[] = {
 		.end	= IRQ_SSP3,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 66,
-		.end	= 66,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 67,
-		.end	= 67,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa27x_device_ssp3 = {
@@ -896,16 +804,6 @@ static struct resource pxa3xx_resources_mci2[] = {
 		.end	= IRQ_MMC2,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		.start	= 93,
-		.end	= 93,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= 94,
-		.end	= 94,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa3xx_device_mci2 = {
@@ -935,16 +833,6 @@ static struct resource pxa3xx_resources_mci3[] = {
 		.end	= IRQ_MMC3,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		.start	= 100,
-		.end	= 100,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= 101,
-		.end	= 101,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 struct platform_device pxa3xx_device_mci3 = {
@@ -1022,18 +910,6 @@ static struct resource pxa3xx_resources_nand[] = {
 		.end	= IRQ_NAND,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for Data DMA */
-		.start	= 97,
-		.end	= 97,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for Command DMA */
-		.start	= 99,
-		.end	= 99,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 static u64 pxa3xx_nand_dma_mask = DMA_BIT_MASK(32);
@@ -1067,18 +943,6 @@ static struct resource pxa3xx_resource_ssp4[] = {
 		.end	= IRQ_SSP4,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 2,
-		.end	= 2,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 3,
-		.end	= 3,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 /*
-- 
2.11.0
