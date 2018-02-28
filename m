Return-Path: <jthumshirn@suse.de>
X-Google-Smtp-Source: AH8x227KIA3LuvZj7+gMiUybEnZ/jDDQq5T6h6/cSiJ9DQJUp0oWPS/+9nhnWE/bfmBo9ZjPUPZk
ARC-Seal: i=1; a=rsa-sha256; t=1519807466; cv=none;
        d=google.com; s=arc-20160816;
        b=0LDZ0QN4OCpfD/j98NEQhE+5Ld4sGbkAle2DzKVWkx4FFVpQlbHA8Fe0P5yrABNk5r
         cd+hn9qiCLrgLCCHKGpi/TqYY3Aa66rrG5egO4N5nj7L3DQXDd2ioAJ/eQQnbSyzdC5O
         H9xmS+3mSUylrtGS1AtBwxiZrQzd0r3V/Z0QXE71ldHq/AJJP8WyGtPTc8fMihMptDZ6
         x369qqf9RGIoexZnP48w5bFQorofk3uy3NuYNLmTE/PqTxUfKg3X5RqMbAqOyBC7TTLE
         2HJ+sj+mIzRVCosC82N3iC2tJLvHOF5iLPNp+K6Ppw3CK4Iw6M6bWEiRObhF3l+sbkKG
         XUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=cAz+FiEkZb/81NzZ5HNrExD8Tu+BQdyfuSI8ohszYK0=;
        b=a48fCOsIa6xEBv0Z1Efz2fgr/+czYknRhRdSsLTJ1D0S+6jD9Av58Nu2jO0XhEBBts
         h2zH0WdjpbsDzah5goM+ezpkQ7fmqpR5wOIaoDlYPJWLz8ljcOl6sXzQwt8CBsEeFZtg
         zZWOopDWujYGicqjir/JMd5qkh1FntjOHHySMHd9uALvDAoeDzS6yJD89r35aRMtFL54
         VNlRdHn9lzs3xFAVIzWYrWiKkjOQzYLAWGrK3ELEXBXZQGpwo2Jq2803Gqn8QDgCrOO4
         gn66hLjlT06A6h0dj4vu7N+PqOl38A69j+vAhKIjJHMrqDRXmRt62t1im75r3tl4pX/2
         Pk2w==
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
Subject: [PATCH v2 2/2] mcb: add Altera PCI ID to mcb-pci
Date: Wed, 28 Feb 2018 09:44:18 +0100
Message-Id: <20180228084418.7566-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228084418.7566-1-jthumshirn@suse.de>
References: <20180228084418.7566-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593633633958111134?=
X-GMAIL-MSGID: =?utf-8?q?1593633633958111134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some older PCI attached MEN FPGAs use an Altera PCI Vendor ID instead
of the MEN one. Add it to the PCI ID table so the driver automatically
attaches to it.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: Ben Turner <ben.turner@21net.com>
Tested-by: Ben Turner <ben.turner@21net.com>
Cc: Andreas Geißler <andreas.geissler@men.de>

---
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
