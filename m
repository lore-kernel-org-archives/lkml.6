Return-Path: <jthumshirn@suse.de>
X-Google-Smtp-Source: AG47ELtiAWN2yJkldvnByt9s9xvJxEe7hYR3yc3kBfOcBczVUfmM5eP/au3Nat0dSDYXfrvZebH9
ARC-Seal: i=1; a=rsa-sha256; t=1520847687; cv=none;
        d=google.com; s=arc-20160816;
        b=ooLh/b5cV/ROakEqXzSxRzHQ0cfvUmEyM8SoaPEbKq4oBKIhdgVA5gKRL7S/RWcUIj
         OgbBysxgKaxXRDDrFgf9ps2fO1e5Q3O06FcL/HV0iw1RZiIBChQ/nZYclIoi6TcrB51v
         Oj+bik3V50dy3PBGewY1SvaR6w5MFFDfDn4JQcub8cEz1PVKg0Wn8O9d5vKvra1N7oUY
         OuSfgvFph5kC4Eu6XS4O5kcIAd2e9ouKhMmw8F7EiUso13SSf6t6od2XOGBr6/Eb04wC
         ahdUm+ahQwsNkKkGFG5RKaVY/CSip1oBU+yeniZXLqlA/mDDWZuXF8hBqTaA0kDp3Ftr
         2spw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=wk/+VdHl2M5RcUvQ9uNC7a9rSXWq8cgTMuGLBO6h1oA=;
        b=ByW7KpKZIj6hV9o/EzEW/k2nvAxaezRubmQPhXTsiSwYlXViaeK3H7a2J3qSb5lPSR
         d1uXvR9f/1o/IGnGlOim0E43HUZuuojfEpF2Ch8kKBR+zpiYqwgIhcix6/HFs+P36wDd
         8BF54W8u4HDP8sCyLxlCEAU59T1e7hfBuPYv5b4qvW5iV54MV0izNOgIZ/P/RtuGGmlp
         z5zviWfty6OmSyscmDeAo5tRVSRZE8KXtW1qNylaWt0sqoKZERL1xff5MqalVhdu4mjU
         UQ6YG3LUpUZQWdZqUG7c6BKPcvtK7KOSLGxDJZP6gdHdqhrO2DbSOKNBwiDMze1MoHBc
         AhVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Michael Moese <mmoese@suse.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-pci@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	=?UTF-8?q?Andreas=20Gei=C3=9Fler?= <andreas.geissler@men.de>
Subject: [PATCH v3 2/2] mcb: add Altera PCI ID to mcb-pci
Date: Mon, 12 Mar 2018 10:41:19 +0100
Message-Id: <20180312094119.5298-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180312094119.5298-1-jthumshirn@suse.de>
References: <20180312094119.5298-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594724385345347346?=
X-GMAIL-MSGID: =?utf-8?q?1594724385345347346?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some older PCI attached MEN FPGAs use an Altera PCI Vendor ID instead
of the MEN one. Add it to the PCI ID table so the driver automatically
attaches to it.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: Ben Turner <ben.turner@21net.com>
Tested-by: Ben Turner <ben.turner@21net.com>
Cc: Andreas Geißler <andreas.geissler@men.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---
Changes to v2:
- Add Andy's review

Changes to v1:
- Removed redundant include of pci_ids.h
---
 drivers/mcb/mcb-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index af4d2f26f1c6..c2d69e33bf2b 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -117,6 +117,7 @@ static void mcb_pci_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id mcb_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEN, PCI_DEVICE_ID_MEN_CHAMELEON) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ALTERA, PCI_DEVICE_ID_MEN_CHAMELEON) },
 	{ 0 },
 };
 MODULE_DEVICE_TABLE(pci, mcb_pci_tbl);
-- 
2.13.6
