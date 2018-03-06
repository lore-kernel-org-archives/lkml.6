Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELuk3gC8XY1rvlkQgqzBOlMIVHALm78YbE9wpPFCYaTZIVseJ0KNshWjtwcWKi397iegbuZt
ARC-Seal: i=1; a=rsa-sha256; t=1520333309; cv=none;
        d=google.com; s=arc-20160816;
        b=Im+VEMuRqF6/gOxEq8ezLSi5OMNuQH3YRzxqpjTlg2ww51TW6JcwISXX06gSNSvNVb
         RYsSAarGhbt2KiPxnFr96q/CVETUsX7W7xDIA2g/v04KXFKsk42r72KwaF0jiB889HUT
         rrEQYoOor4J/6dsi3hhRL3SXE/E3Lk8t2jWAQB3v5Rkl+Dg/UZ2j5PJU5O9VswjvSYmS
         +it+RhQjMxCqX6EuPnE3fSda9TpfCJgZjSjQCSW2GbzMHNFl66SpywsMHGNMUWdO+0rW
         E/j3ex+97xE3pyOs0R3hIabfKzfF3AH8mhXu1tMo1oHJQ06RslSVhgmrQpK1JB/vU/xs
         5ZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=N2pWP9N2ook620oBtwdAxvf3HmhAmACKGOLfNUkJs7U=;
        b=TZfPnwe6Z11qF6mJ02lYgu79ZydY6GscpoXXnQ7/0qN+CTLXdsXVUENeD4rgheEnp6
         Grh5xmUTwiUEKWPDHaXa2OZltV4kbEEvloHnOZtu/4CD7bg3p6sCeVMFbPNTbW0h4B9V
         Fg3ji5vVD4zaCxV1xkd7z5T2fy1hzPoT+CYfPGuFvBdx0TMsH4a0ol7CrwOG8yes+QAe
         sS07k9q0R8sypKWZ7V4H/k3lr1MhykIsccQ4SBjbYcetIjUuNKc7ZJy1Yho19sGfu5W5
         JRt9eE9ew4YdasPSYzSu/4chsNSETjZH47RGQs6zlJ+DFpPrP5qvrAYQ5GMwP8V1lp17
         mTMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
	<lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>, <hanjun.guo@linaro.org>,
	<robh+dt@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<mark.rutland@arm.com>, <olof@lixom.net>, <dann.frazier@canonical.com>,
	<andy.shevchenko@gmail.com>, <robh@kernel.org>,
	<andriy.shevchenko@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>, <minyard@acm.org>,
	<devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<rdunlap@infradead.org>, <gregkh@linuxfoundation.org>,
	<akpm@linux-foundation.org>, <frowand.list@gmail.com>, <agraf@suse.de>
Subject: [PATCH v16 2/9] PCI: Remove unused __weak attribute in pci_register_io_range()
Date: Tue, 6 Mar 2018 18:47:41 +0800
Message-ID: <1520333268-82754-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
References: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594185020026047272?=
X-GMAIL-MSGID: =?utf-8?q?1594185020026047272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Currently pci_register_io_range() has only one definition;
therefore there is no use of the __weak attribute.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: dann frazier <dann.frazier@canonical.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ae654e2..ff41a64 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3451,7 +3451,7 @@ struct io_range {
  * Record the PCI IO range (expressed as CPU physical address + size).
  * Return a negative value if an error has occured, zero otherwise
  */
-int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
+int pci_register_io_range(phys_addr_t addr, resource_size_t size)
 {
 	int err = 0;
 
-- 
1.9.1
