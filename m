Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2480911-1523991449-2-3926542154997498494
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523991449; b=VqoPt0WgZjHqI1RG3IlN07SovTG20lsBoSE+200kjZge2neRpi
    1bEthJcqC4LbHAm/HqZePVUGF3RscwjPWZ9sJUNB4w3EZLf3sZw+HbSbaOY12ZiJ
    yt8k8edRCd3AqfN90MGvZKMHhKTlZE0B9kAapRETj0YPTEzHBKWpN8LJaYk5qREo
    tBD9NS2Sz3xUeOHT4MzgSYhsr8tsx0OLtZ3Ksue9Xn05FKMYafQbBAUU6jazONIi
    cuhxoqzPJxtVcYnugCjccwnNLur9gngcNqlkHRUb0BrMJUNaoWhz8bVRx2fbhiUH
    MyAcB1Y88EuUJ+g/em55+oGvPMWkLxmkpdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523991449; bh=dd6PQ
    zMd+6BeTQlJJ4pSLlL2Zv4q3y0z1+6WY9eDuD0=; b=IkABq6X7V0n5+xuHz5ZEJ
    tRAprWS4jvXsFeiOAJH8Di4cGsBJWRu4inuChFXLYTf3Eu0U4VbAQhJ6Z4P4Oyoc
    TWNzmaNy9MVVm2R1zdhsiMZbwpBJ3LazcATzTKLjyJd57Ox8FwL4R/Lt8WUZZubr
    +IONU1kpPFxYvOIAjJz1bHhVBD1y2L8e2h3B7VTHMMJ2Ir+BX5L3BtdieCfn2ZSe
    eMQSBQvZ7RC5/9K3BcMrRAu5DR/7BMQwOeWF6ulqF5wiAHANhzM6762t//S/AnF3
    9qXBXLhhYQ5YOmRi/4bmnDxxdcS/AQ3oWC6xbwPiL8GNpbZm9QAvLPRduaLhWNB9
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK2DxEW/6IxHYyYGFpynjbhe8CBU5XOz526oVMLEzfHLuArf/FlAsyjhCcRigLfMDxaDcMPgCHyIj82zKLRgmcbYl25F4/6uV2XbhYSKJz1oVXyPhojy
    KMM1bj8SBuyjJfLQkyrJLu6dpo4WDg1oIFvGqRg1omJHZIktoF+A9vJ4urGw0LsgxHknAKK51WEFQWFgBrnVTHUUEbmmvljxxLYX2lTBhUFShlFDixs47wcq
    3ek+Gj1iG2LdfqYMU52D1A==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8
    a=7CQSdrXTAAAA:8 a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8 a=XNYVfk6J6KFTGUcfqe8A:9
    a=CjuIK1q_8ugA:10 a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
 Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v3 19/20] staging: vc04_services: Remove depends on HAS_DMA in
 case of platform dependency
Date: Tue, 17 Apr 2018 19:49:19 +0200
Message-Id: <1523987360-18760-20-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 linux-media@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-serial@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-remoteproc@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
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
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
  - Add Acked-by,
  - Rebase to v4.17-rc1,

v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Split per subsystem.
---
 drivers/staging/vc04_services/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index f5aaf7d629f0fae9..98064ce2c2b47c7f 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -1,6 +1,5 @@
 menuconfig BCM_VIDEOCORE
 	tristate "Broadcom VideoCore support"
-	depends on HAS_DMA
 	depends on OF
 	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
 	default y
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
