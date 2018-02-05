Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517793882; cv=none;
        d=google.com; s=arc-20160816;
        b=j7NTz4QSSLYkT6cGF8JXAmwxvgkzMpbI8PFPCfH8rJrOAzYi17nMyubepG/UFdTh7H
         CiCT2bSPgAQaPud1IvFY1b6+cNfsAEAcMHE7pxANoRpi8XZq4nE8HIESYcFaovcOhbFx
         Jsv905aAZh5VS14nWwXGubLSuXuzkiNM2lcvRwBLAWsmwrW26aytD+fJxY9FSMRw08cE
         l0HT3F9NP9S8+ZAaUAOtu3mxJ2jFH7C33/qXlpi6+KIknomUwg0u4/Zqi5fxvL+iTS8t
         bbua1vd+h5Gj/unn0NHiy9htBsDJG9SmfCFQw3x9oNoeLBeXVj4bt18HChd4HWgk+7Fk
         GBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Nhjgb369kFfMAxmJ+/JeE60jQtyjPaYemsDs0+oDbEI=;
        b=DOpBby1Ccbm2WEJ3Y6+ZcSEgQzde5yzcx5hxgCeOSZ9VonV6QqpcjjeCJS0/3VOqlU
         a6co6BzNmnNwXSWnBlXp0xHqSU0nINnjuv5R1bUcI1bwwyO7bFmDmZbaMkAXwfX/xlHk
         j8VvGAvEGv37KIUnl/AHumkD87Z3sx4rxM8Oiv6xps4D29YiNviN4Wi58PkRVKa6vla/
         nQHf8iER0coyNYW6jlHp7xPeEdXljkS+yQQJrEJetvUbk8YgaRAXv+hrRQuJZYqXasJc
         hXzkY2k8UHAlYllsCYl8Gz/lmOCPFpzNNHRmk8xuNYsfGZZ0bNf++q5wTiDGm7LX/BpM
         /TkA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZV9IecGQ;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZV9IecGQ;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227xxt7cWp6GgSlTkQg9cNl2P+HTiCVcbbo/QiL6odiabOgoZwZKFm4UUdVFc75gl9Wc4MIpGg==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org,
	tfiga@chromium.org,
	paul.burton@mips.com,
	m.szyprowski@samsung.com,
	egtvedt@samfundet.no,
	linus.walleij@linaro.org,
	vgupta@synopsys.com,
	mgorman@techsingularity.net,
	hch@lst.de,
	mina86@mina86.com,
	robh@kernel.org,
	sboyd@codeaurora.org,
	paulus@ozlabs.org,
	will.deacon@arm.com,
	tony@atomide.com,
	npiggin@gmail.com,
	yamada.masahiro@socionext.com,
	Ulf Magnusson <ulfalizer@gmail.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Raviteja Garimella <raviteja.garimella@broadcom.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	yuan linyu <Linyu.Yuan@alcatel-sbell.com.cn>,
	Cristian Birsan <cristian.birsan@microchip.com>,
	linux-usb@vger.kernel.org
Subject: [PATCH 11/20] usb: gadget: udc: Remove USB_GADGET_DUALSPEED select
Date: Mon,  5 Feb 2018 02:21:23 +0100
Message-Id: <20180205012146.23981-12-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591522238102235522?=
X-GMAIL-MSGID: =?utf-8?q?1591522238102235522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

USB_GADGET_DUALSPEED was removed by commit 85b8614d7223 ("usb: gadget:
get rid of USB_GADGET_{DUAL,SUPER}SPEED"), but the USB_SNP_UDC_PLAT
symbol still selects it.

Remove the USB_GADGET_DUALSPEED select from USB_SNP_UDC_PLAT.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 drivers/usb/gadget/udc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 1e9567091d86..0875d38476ee 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -274,7 +274,6 @@ config USB_SNP_UDC_PLAT
 	tristate "Synopsys USB 2.0 Device controller"
 	depends on USB_GADGET && OF && HAS_DMA
 	depends on EXTCON || EXTCON=n
-	select USB_GADGET_DUALSPEED
 	select USB_SNP_CORE
 	default ARCH_BCM_IPROC
 	help
-- 
2.14.1
