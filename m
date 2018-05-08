Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZoOZ8m2gWg/gr1OIMqOy2rTrNKSQTBQE6DFT5W61SQ0XUCMPXH1gI2S506pqcwhxymxM9qT
ARC-Seal: i=1; a=rsa-sha256; t=1525806391; cv=none;
        d=google.com; s=arc-20160816;
        b=LpkxmWqS/Nf31/gpZXcHcIgwWFaB7BrzbIJ/upLRibEB3KRpX6QIQsrewHeJ1AatnP
         +15xO332dXH1b8gJO4PHfFwhqjIefYCMbVOLz8s5G4cNYmSUwuU1K2TpfpkbEjV/wkK8
         gYx0fJ/K7+Q5ZBWhu2iNsWSX3Pep50o3DUvxnwd9v+hDjGceFHkretfBLVyXgiNMEHIN
         40TXRsL9pMtljyTA9UEbwkT+XHjJbC29etshYDYpMWnSYDj9HWEXDcWJtEKw3PFNHfci
         cB6LFN7xgjDyqCyC/I0UiEKCRS2fsnuhPAaIzPo+8OqlZn6lSwOw+lJU2euWrlD/FejI
         x7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=LIhtYwwPvnmngHBCsIts07w5IqqcIgFOnk5EGtWXIl4=;
        b=09N/yJF9wcryftclID1Htv1IyvNphKdFZvLlgNoPrFt0x+FRdLjX2lOICtt4s6fTRP
         VxvT071ltThujHugI20eEfkzfOjkWVT+UHt6ykIX+weXTOkeKJAIiBlorO8lOw08UZiR
         cSsJR9qTH+e1e7LaM0y6Un5959U94ju4JTEgE57UbW77BRhYFBhiD5fEE/0nbkMCx67f
         BXhRHInjx9YwMIVvKCwUKPmJxijVNZIlOwdJ4eaIWgVH0UMKSyDbJ/3mqdSOh/YIFjgQ
         tGtCEUlit2rs96IOjtHIBjpzZ7RUHZdMbI98FKKJPWigPSDfPky1ib3XGIR3oQfLeH9C
         dHsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Date: Tue, 8 May 2018 14:06:28 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Kim
 Phillips <kim.phillips@arm.com>, Kirill Tkhai <ktkhai@virtuozzo.com>, Mike
 Rapoport <rppt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Pavel
 Tatashin <pasha.tatashin@oracle.com>, Rik van Riel <riel@redhat.com>, Robin
 Murphy <robin.murphy@arm.com>, Russell King <linux@armlinux.org.uk>,
 Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] amba: Export amba_bustype
Message-Id: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923962072715113?=
X-GMAIL-MSGID: =?utf-8?q?1599923962072715113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch is provided in the context of allowing the Coresight driver
subsystem to be loaded as modules.  Coresight uses amba_bus in its call
to bus_find_device() in of_coresight_get_endpoint_device() when
searching for a configurable endpoint device.  This patch allows
Coresight to reference amba_bustype when built as a module.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Todd Kjos <tkjos@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
There was a prior patch submitted by Alex W. here:

https://lkml.org/lkml/2017/6/19/811

But I can't tell its fate - presume simply delayed?

Coresight uses amba_bus in its call to bus_find_device() here:

https://lxr.missinglinkelectronics.com/linux/drivers/hwtracing/coresight/of_coresight.c#L51

Grepping for bus_type and EXPORT shows other busses exporting their
type, so I don't think this is the wrong approach.  If, OTOH, Coresight
needs to do something differently, please comment.

 drivers/amba/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 594c228d2f02..12283bd06733 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -197,6 +197,7 @@ struct bus_type amba_bustype = {
 	.pm		= &amba_pm,
 	.force_dma	= true,
 };
+EXPORT_SYMBOL_GPL(amba_bustype);
 
 static int __init amba_init(void)
 {
-- 
2.16.2
