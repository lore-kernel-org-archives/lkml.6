Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AIpwx4+/rwToSM5S+t63JvLvl9krG6zuhaHfK0jtJoeJX2V7H2DWp8ikv5sLZoIiu87l2ewMibdV
ARC-Seal: i=1; a=rsa-sha256; t=1522244869; cv=none;
        d=google.com; s=arc-20160816;
        b=KkzJk3C2cpwWhtjycTblkjHYJCPJwbusb8VF6ATXUX5aLEzoRTO/e5W914uUsS8sve
         HnSjGev5AitMijvTe/ylsd658Df9qPRYIWBo156MoU6FxBTyDEI/hRWZ3K5bd1bS8Bfl
         hsEnI9haZakf5qPt7UqPPUsuThHN3kuWcyYgzuOPVJEszgJ1URvo3LZVs9S5OybbWRxs
         PYkS1p2FtZnd8tl5tyxihSVrB3fqs2XQe7mfp1Ud8lBlvoqEo2cEzIXhdueen4NOkd3Y
         3nB0B5UCoxiZOnO2WtvCQ/l65f0G+IKckIPNvEGu1tpVj4ODDZ9v8Pf0wP9PAxMzNWJO
         5kPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=J7D/9y1FFXIAJoox3080jcGlaa6n+G3IMqNAa4Ur50w=;
        b=FJpeQvmZ7QSRABv7v0Kia2ebUvmjJ8WSDOsLyKYIsL2JcIl0f9VWYC8sTO753dfjTP
         gsxs8rS6dmOfgQ5lDIrYEIhrIHr+aZNwCBnvJmcjqgfHIrUOEYoelPl+jsCgBPEaSeyp
         19icTKKoNrXY26LatAaY60iXiC/o86fxMuG/K2DxAnzmXCQtTZY1o5rU2f7BMmfVz/Yq
         HiXgZymvs+VXACzrFRqzhS2cyb9jjpqlsVX7cSN1ULfj25PbXGirQzHS3MRCAZgzqWDX
         BNIaLHnUiSv729o9PtAp2LxVqOgWQY0H9FRaAmXAFAR74JoOSvE0/Sox7DO7Dkaek/uX
         4Vrg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.131 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.131 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pci: move pcie_pme_root_status_cleanup into SUSPEND section
Date: Wed, 28 Mar 2018 15:47:18 +0200
Message-Id: <20180328134747.2062348-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:ivlY+y94Cpqa814dri0L2TTX32s9nxpO4i6aQLS13z0NJpHD6QV
 X6qlQsTmpmWr+ciggIaUUD3hT87IXKVykHebBtl8TftqyZFOC2sO0Kp1zpPBHmTlBQfcY3z
 YdPnAbuH1kFNjHn1tcnjR2vgUIzctVbUnI3atZeIzlq8v8hjwgKGxg2Q6oqMcet6r4ZzFff
 240OFmwVTRnafvYnxbbxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TFI0PRQpRiY=:hvLAJYJ3WDL+rzpN6AQpI+
 V1YgK7bMRprmeS/s35wu6zduNoIIxieKIeRgyjBu3yIcjZNmbqEMekls2e3OhkjVAvFGcsuup
 Nxh7RohABfSITqAhkZjx1YZsO01b/kAD0w5i555wgAsjRUZRRizWtk1eIstd5C447N9mApLcx
 ng+j0PLOXTsL0PgKK9cXTZ+QwKis8wJJ6I5AehmVAm9OJMo4GYfX3wjuMuU2S6WHEN7d9TB6C
 f/e/MKwQ4KUyKopELUVsCcl9qsTKJ6RemG58LPq6VIATvZyE7Z1BETXJsJbI+AePCyYyD06+Z
 CqQC6uYh92lAhsyyBUGzsjRhjgX6+fW55/zIr5qRfrFYJ4HZekyEDbpSM1HwKQPodqA2a9fiC
 6plfh8YqxHcG+R/dlB92mFPTVDGmw6p25kkJpK+aox15bpmjz8pauvsGSYSVtEd448hUwZtSG
 Xbc4TUqOxS0p8cPVNPVNIocWOxBsxWEhPMLzwVsVaABgTcu9Ajzjdo1/LE9C73beV9D4rJPTz
 5ODdhzoMy94m0KSuZrW4/eX2PMMWAcxgHzf+5NgPJBByD7ZeLAYdnEHqzOR8JDEVdi+i2kjs3
 Z+pgEDQ5mtCpDs4FSu9z4aPnoKWS7qMYDgUZYZ2cAJMWdf4zYysmKKDgvtZOx2+AKyZEiKyUs
 hfYIiFm1AuFTO/kVEj2k0q5b4kDfm6NxWayYMdooxmyC/8AzC9WoyyO1PRwAPsowvkGTySZ5C
 o2rRp7y0k/gEbdZ3Q8qbh2/etSeIYzYBaHhojg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596189436680749086?=
X-GMAIL-MSGID: =?utf-8?q?1596189436680749086?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The power management code in pci-driver.c is a maze of #ifdefs, and
the newly added pcie_pme_root_status_cleanup function ended up in the
wrong one of them, causing a harmless warning in some configurations:

drivers/pci/pci-driver.c:527:13: error: 'pcie_pme_root_status_cleanup' defined but not used [-Werror=unused-function]
 static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

This moves the definition into the correct #ifdef section.

Fixes: 6c4dfc1389e1 ("PCI/PM: Clear PCIe PME Status bit in core, not PCIe port driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/pci-driver.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index b9bca74e9eff..6ace47099fc5 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -524,19 +524,6 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 }
 
-static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
-{
-	/*
-	 * Some BIOSes forget to clear Root PME Status bits after system
-	 * wakeup, which breaks ACPI-based runtime wakeup on PCI Express.
-	 * Clear those bits now just in case (shouldn't hurt).
-	 */
-	if (pci_is_pcie(pci_dev) &&
-	    (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	     pci_pcie_type(pci_dev) == PCI_EXP_TYPE_RC_EC))
-		pcie_clear_root_pme_status(pci_dev);
-}
-
 /*
  * Default "suspend" method for devices that have no driver provided suspend,
  * or not even a driver at all (second part).
@@ -726,6 +713,18 @@ static void pci_pm_complete(struct device *dev)
 #endif /* !CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_SUSPEND
+static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
+{
+	/*
+	 * Some BIOSes forget to clear Root PME Status bits after system
+	 * wakeup, which breaks ACPI-based runtime wakeup on PCI Express.
+	 * Clear those bits now just in case (shouldn't hurt).
+	 */
+	if (pci_is_pcie(pci_dev) &&
+	    (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	     pci_pcie_type(pci_dev) == PCI_EXP_TYPE_RC_EC))
+		pcie_clear_root_pme_status(pci_dev);
+}
 
 static int pci_pm_suspend(struct device *dev)
 {
-- 
2.9.0
