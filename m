Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELvzAU9Oy5vCCaZhirYCq224B9dRn/mupAC7T5bgdd7TV38zmG5lUvx7WZA6LFIBdp7S7LJx
ARC-Seal: i=1; a=rsa-sha256; t=1521051425; cv=none;
        d=google.com; s=arc-20160816;
        b=lu56UHrdjq5U2HRRvq22FCiPVOQKCVByEZz3F3WJPjApE4V3EDDbgf5btf2sj31l6B
         NTV89HHh/bHaXoxOXMcECiJzddyHxJKmeKZE1ZG1ioNlT83UuSwQYbZBV3OsgwZTiCyU
         r7yNWCmEmcN0UTODKHLjtevbDUAfWHWCqFROfc0xE/CEYF1+57vl3PQaZ4pttLW0H9TG
         p+qI5E2VXDk/Fe13eKiiRWCA9Y3O4W5O2GFTzK5NuOIee/vGzbbw4ane4y0FeotwU/lV
         S+FQiIiYaJr5U3v2Fu+2rKgl/oxQEkxiKHPsMb3rMn2KrkwPA15H9cqYzYRbiXDiUATT
         ZYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=N2pWP9N2ook620oBtwdAxvf3HmhAmACKGOLfNUkJs7U=;
        b=kuu9vFGvnrBEk3ibjfvjbBYYpRLVeMhyF6g4BiTWheyxFifdzyICkTsBXgcCriPL9g
         OsoLNcKxyaikJSZuFIRZ/Wa2t2NPKEwOcioDqWRqaERVdJkZET5IDL6dkjgSbuz36+j3
         PljrytNbHvcOfRZ7i+KwUMFixpV06s5FegAhM+DlyS6OaPsZwHqAnofiUFzfhTnsdjNa
         IbnsjuVc2jcta9k+msibM8jaIBZQMG7c1LGwkdwIXe6pwCfPv5AP4vPD6ILgONJqgXU/
         LsDGplu+RGLw2fAD45kX/NjUySkqJj2XQ6io/mcteQu2qOkJueUriJFgkwpwSt5YGM/1
         Zseg==
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
Subject: [PATCH v17 02/10] PCI: Remove unused __weak attribute in pci_register_io_range()
Date: Thu, 15 Mar 2018 02:15:51 +0800
Message-ID: <1521051359-34473-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594938018838822319?=
X-GMAIL-MSGID: =?utf-8?q?1594938018838822319?=
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
