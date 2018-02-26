Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AH8x227WLRDW7IpVsrwhZ0PSxygC6xdg+zhBFN0dS7tnpdRW34gqR7OthIyX0OSBkuvRPN+J6yY9
ARC-Seal: i=1; a=rsa-sha256; t=1519660214; cv=none;
        d=google.com; s=arc-20160816;
        b=hA/wywKRVPFabjuNtFR5NZXF88j6l+Atpc7YyWyx1g4SQvQ5oPiMlIAN61eiG9dXXt
         AIs03MnFx7OnAa9M+5F5t3CtoLeQjUwAqYhDitGwEf1g1B67RvYZMhiPuDslO0h6zoQ0
         TLx8gGTjWjHwI0t/fHr4wOEmw7NT68yTHyREX5R//wGkNorazamZ1XwNrl0ZwJqLFBEY
         Rbpwwn5MsG16piafRCoYQiaqL6uLBWGXSfhn3k+l7MLoF7/9dK6ikDDFA/KQ0yxGnsbD
         zwgP08nKyBSzOhWU4Izt3IvtupG7b/isIS2C2roi+C5TUIxlORt6Y83uDcVfbmVyizMu
         CgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=ta9LhXn85vb1XFnsfKaEKeCXMIG68OSksyEOb27OeKY=;
        b=CPHif8ngXkW+fZx57yTKiDdihL2AZ1AO3Mt3zus5eFy0H/TL2zSaqDGlMO9GHUwYVZ
         QCYI4fCz27loGB48oP7W0kt9jYg3zncJdMz34DrjYktnZWQbsUaYbSnFgZx1Wppi7ywF
         VS84uuljoARrWR54a+VkRFD7yDxdTtaMLI26n/dZ1D0syMBNpKk64IIX4QScwG3SDvot
         gXUygjIFKzRkIj4xwqZczzS1Bo5Fe/5VoJlX4qfQDYS2cEzWe/GJGiIoTi5DVE33Bqwh
         cjB3VSbBeRa2W6OVguQbVVve+TCSxWL/VKgU91+e5Vxxd2LuQYeCo7NboDmt2SYZ6ff6
         IhXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=john.garry@huawei.com
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
Subject: [PATCH v15 2/9] PCI: Remove unused __weak attribute in pci_register_io_range()
Date: Tue, 27 Feb 2018 00:40:42 +0800
Message-ID: <1519663249-9850-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593479228599256466?=
X-GMAIL-MSGID: =?utf-8?q?1593479228599256466?=
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
index f6a4dd1..4666a01 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3455,7 +3455,7 @@ struct io_range {
  * Record the PCI IO range (expressed as CPU physical address + size).
  * Return a negative value if an error has occured, zero otherwise
  */
-int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
+int pci_register_io_range(phys_addr_t addr, resource_size_t size)
 {
 	int err = 0;
 
-- 
1.9.1
