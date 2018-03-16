Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AG47ELvwR7TtqG0fqTnp/BeP9ZwJ/1j/CK+WUEoXYW8jva69RK59sNyKQKIh+teK3cE86PwDnBSN
ARC-Seal: i=1; a=rsa-sha256; t=1521208373; cv=none;
        d=google.com; s=arc-20160816;
        b=Jgnl0eJqLLOQTyYdY5ujufa92TXFn90DBbxzAQiz+Hn0eYcu9wHizk42pbPQMIFiow
         y5l84s6QyIqwJsWuECqGIBiRsS1KZklb3w6l6CqqoL5MJwm5dYyJAxofr9vN4015MANF
         jQ4n2pGRw0OAsoPNbwpk5qMeVeHMdO7eaM7aAIlhIbBgSTpBQemLZk3P2IK5zKSOUC1f
         OPgqygDqIbVXSPX8nnUY4TUPdJBLfG4oZUjwAeOF1cKSxBNl5YD5+YK8EHR/MTuzo0L5
         3cvK9qZTS0hfHSjFe5NDK7KUqar1lwMcyIFl/041YLf9Iq48/D6SSghKJljjk7LlaLNp
         JstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=V5XC5uwXlUxPBIwRJIcCCen6rH00rP6D7aDihmVczuA=;
        b=uhnQ7nVj9nn1PM+33Cih59TURwzH9nXMZwWN8gnkvWiD9vOHdTEl9pwLg+HUlYiLL2
         vzp+q8H2DL2166t8YKkSzDe9uA9iK082LC6aU47bbUi+GZYE4T05Wgmi2o9mWKI0jiRz
         Pp8t58kaEH4aHJVAXHVjnAb/o66VfT5IRnvJnyo6qNrU3oDY7dQB0zvH1GGJ2Miv8WoW
         uF26nl2XrN/NSmHsBAkQ40fzw/bQWy26EIBg/OzPMqy2eaoCQ6SeGsi2eb2SE7r/03p5
         MOgkwiO/gq49Lq5qmuEE8NJ91rOepBfzzQQXjAaspBAR2b4S5SkU3+vYV7atwNnULKs9
         IkEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:15 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:15 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Alan Tull <atull@kernel.org>,
	Moritz Fischer <mdf@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Matias Bjorling <mb@lightnvm.io>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Richard Weinberger <richard@nod.at>,
	Kalle Valo <kvalo@codeaurora.org>,
	Ohad Ben-Cohen <ohad@wizery.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <stefan.wahren@i2se.com>
Cc: iommu@lists.linux-foundation.org,
	linux-usb@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-ide@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net,
	linux-fpga@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 05/21] firewire: Remove depends on HAS_DMA in case of platform dependency
Date: Fri, 16 Mar 2018 14:51:38 +0100
Message-Id: <1521208314-4783-6-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595102591233077781?=
X-GMAIL-MSGID: =?utf-8?q?1595102591233077781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
In most cases this other symbol is an architecture or platform specific
symbol, or PCI.

Generic symbols and drivers without platform dependencies keep their
dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
cannot work anyway.

This simplifies the dependencies, and allows to improve compile-testing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Split per subsystem.
---
 drivers/firewire/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firewire/Kconfig b/drivers/firewire/Kconfig
index 145974f9662b63e6..4199849e37585181 100644
--- a/drivers/firewire/Kconfig
+++ b/drivers/firewire/Kconfig
@@ -1,5 +1,4 @@
 menu "IEEE 1394 (FireWire) support"
-	depends on HAS_DMA
 	depends on PCI || COMPILE_TEST
 	# firewire-core does not depend on PCI but is
 	# not useful without PCI controller driver
-- 
2.7.4
