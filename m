Return-Path: <robert.jarzmik@free.fr>
X-Google-Smtp-Source: AIpwx4+0DxeOFM/qamdDOYsR2qk9u4xaHIvJM49/6oZeEe/QsvWFMOQ4dXGokcztT2QrsGBSpl1b
ARC-Seal: i=1; a=rsa-sha256; t=1522679302; cv=none;
        d=google.com; s=arc-20160816;
        b=rKw1L4DfNLAUnHSI4517Jc3Bbq1ojBgYXyzHPIfxMJvhhMAWHxjWTEmaBEOc1FPdQQ
         nSJ54TCg+oYMQ6FOR65VYg63IYlcMDJ6dnfC8SINDWJquQpfHIpVfvtT9LP/KfxkW7RB
         DNBD6DvsWttC+W17sfXt1Pl329cF71Ec06uy8IyQg46etq74litZKxszKvuF37qFnWKX
         DGM9vkZOFIxUzop9Zt9ZG+Ulq51bnP5UtEOncttOE31yqK4ViOLmdKK1mIJKgyDXmmjB
         ues8suEBVins1kLFUY4oDk0J9Vcel9/bDzz8OHKSBw+FbmhP+fIO59wXTuzkqjUbmU+5
         m/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=tmmKUtLxFsAZZe96i+6g39GsH/rZpXjBUWfhCpzV+yY=;
        b=lbDSs7sl99WoJD8SBnKAfB5s8FoH4j9Mx4EQu+qj0qfblhPIrFM7pOTilbIgGvXYuK
         2Gp3b1tXwT/F8Y9b92Xgu1ad016arUsR4++X0eWshRNXCwqcDEK8uy7oS77HdpusqFNy
         fCSCeV62Urx8Rblkg2Hi4OHYU+hWCpvHT8KZwM+vzOZAtBcHIBiINhSWoCgfhRwD8ctD
         oQtLgUhd93yhcCNZMxCDryNKMXlBaDsa+r1ky66EfeB+YIDN2xHvmiJbsK0AXTC92C/x
         YYdpZE1EIZPK17LCgzVnuQ+fBH/Y370l5qITLmzCy/qr7AHc5drgHLasF9LtUIQCnQLm
         dyGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 02 Apr 2018 16:28:22 +0200
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
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
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
Subject: [PATCH 11/15] dmaengine: pxa: document pxad_param
Date: Mon,  2 Apr 2018 16:26:52 +0200
Message-Id: <20180402142656.26815-12-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644972466276699?=
X-GMAIL-MSGID: =?utf-8?q?1596644972466276699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add some documentation for the pxad_param structure, and describe the
contract behind the minimal required priority of a DMA channel.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 include/linux/dma/pxa-dma.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dma/pxa-dma.h b/include/linux/dma/pxa-dma.h
index e56ec7af4fd7..9fc594f69eff 100644
--- a/include/linux/dma/pxa-dma.h
+++ b/include/linux/dma/pxa-dma.h
@@ -9,6 +9,15 @@ enum pxad_chan_prio {
 	PXAD_PRIO_LOWEST,
 };
 
+/**
+ * struct pxad_param - dma channel request parameters
+ * @drcmr: requestor line number
+ * @prio: minimal mandatory priority of the channel
+ *
+ * If a requested channel is granted, its priority will be at least @prio,
+ * ie. if PXAD_PRIO_LOW is required, the requested channel will be either
+ * PXAD_PRIO_LOW, PXAD_PRIO_NORMAL or PXAD_PRIO_HIGHEST.
+ */
 struct pxad_param {
 	unsigned int drcmr;
 	enum pxad_chan_prio prio;
-- 
2.11.0
