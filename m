Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965544AbeBMSe0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:34:26 -0500
Received: from mout.web.de ([212.227.17.11]:38127 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965421AbeBMSeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:34:24 -0500
Subject: [PATCH 1/2] firewire: nosy: Delete an error message for a failed
 memory allocation in add_card()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c4e817a2-1554-2480-9469-9d06543b1eee@users.sourceforge.net>
Message-ID: <0b5d64ea-8305-de22-7fa7-e878045104ec@users.sourceforge.net>
Date: Tue, 13 Feb 2018 19:33:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c4e817a2-1554-2480-9469-9d06543b1eee@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:rnHOFi+hkDIdjOYUEyotVHMwhZdw4lBKE7+jOCKsQIkPoIL4qSm
 fZHieg9Tcazo4F688TeiAc5i8VYmuEw1jFKb9/s27pPfZNvq0bSTCExuTlodSizf84Y6FaV
 RoWnF/At/3BftfIsuwxcBmAVjnpLQWtEeXvIczRZZx9e/s1WZIl2hcYOKQ/0qGbnV9y4KW7
 d4hMmoDnwILDR6GEoJ0AQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ameg6prXNio=:qcd9pGxiTqdchW9jCo4aBy
 3Wkbb77D1PiKaP6oTL4hd8VvEbX1SMzYBInhFCGFf9khhjTnnXQOwLvTeHnYeQQb/6x4MQVKg
 YqfelCNGM0/z+qqoJBdjfv5CBG+78XJ2642lHISdwv7JiIWZCpdTwSpItN2pT5YfPrmUZFD9i
 dRdgxEpfHusMOOBI9RQVzhHhTFg1/loQ6fcxlfdNekG0Sa8exozERX3eslkvWWuhXyHqgzoGQ
 5WKJ+vOo6s+rlHm34Z2E1pDwHoig+9h1IXNQTm7ULfiom4OUqWYuN0iLPG8kiWeF25Pqd/aLw
 1C1aJSs9XlwOJMzvGsc7+lYYQrf5yax1ThnIwJkiaMyKfD0TqQWg7P9z44HhBHFlB+jdN+1Je
 6q4PPBGvpWfhj/fWOOocv6LXD5tUw9JCAfmO1ymIXFhoUw3D02JYyqqh57KY4iAjqsU63IRM6
 r85pHrgGvcE0LGqbj8CazyJSCkXzIirkGm79aijGkY8TagHQzUbwChWgcvxjbH46YGvNX/fr9
 UL00PgEMtOLT3Yc1N1vckQ6jBrRoAhapdWZMHM0jMKmK5MK/CcOl7er/s8RbLisdgcazxbxPc
 FuIW/FaZnoR9RmMlIantz03Vgp2f1M7xs2m4JFAsRomkCvQDHKZrDdEBYvH+2Nk96oMcP8FKT
 bMMvYF3gUUl+RdQaXJ6nEwINYPycslZjYZM9VGff8oLGpJbvVGTPZ0jGmOScRKQOAuDZmcmxa
 uiQxsnXDA4KpwtwdRKm7aWf+Lmay8GjnG8uNdpsOhyftiePUH5Ca6a+5bh/BtkjepacvYIjII
 2UYGqyBP+KqBx7qG5FxvISPswY92CYIv1ZhFv62EkimbBHXW+0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Feb 2018 18:33:45 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/firewire/nosy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firewire/nosy.c b/drivers/firewire/nosy.c
index fee2e9e7ea20..6192f0718bf2 100644
--- a/drivers/firewire/nosy.c
+++ b/drivers/firewire/nosy.c
@@ -553,7 +553,6 @@ add_card(struct pci_dev *dev, const struct pci_device_id *unused)
 
 	lynx = kzalloc(sizeof *lynx, GFP_KERNEL);
 	if (lynx == NULL) {
-		dev_err(&dev->dev, "Failed to allocate control structure\n");
 		ret = -ENOMEM;
 		goto fail_disable;
 	}
-- 
2.16.1
