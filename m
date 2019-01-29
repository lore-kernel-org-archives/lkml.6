Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71BBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BE321473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfA2OFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:05:10 -0500
Received: from mout.gmx.net ([212.227.15.15]:37871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfA2OFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:05:10 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lrviw-1hIp6b3gI2-013coq; Tue, 29
 Jan 2019 15:04:59 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     virtualization@lists.linux-foundation.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools/virtio/ringtest: Remove bogus definition of BUG_ON()
Date:   Tue, 29 Jan 2019 15:04:42 +0100
Message-Id: <20190129140443.31161-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:O4tH2Jvu8GNI54JYwR7AAyInn2uL7AQn8ej8rN7eEu7YD+4zVd1
 Uwe6Yy2zFWIjBRqr4rHmMDbvGGyELWgZEnPrM29tsGG5DwSUPddL32PxW8DC4IXccymj//W
 xZff0OJ2NRSb159Bx+L5osEhPx13kjuhTLZERXXJ24oEbIXBVOOZ/C1s1f6irek9hFkc9t2
 LPu2uptA7yN/KS+rIoJWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kfxA3/ft8EQ=:TMIfa5xpNyRwScuNgooU/3
 7Rypj+Ay7wPnxMl08aE7G723GKiA6/qsNLu6zlFrhTCRxsWBJomNJvWuWIJWlIzgxC+c0ECtR
 JgaJmlYSPhTr6WpWiNcoryD/ZlinYvgDvCkDdfQ+a1Wqr97vVDpfBW5h8hbH/ED2wxnfjeXbH
 /leVER8vFqMD66kbLA9SIPPSKlDTlKrR/xaZpUMjUFWgV93q1QmHeeZsav2oeWAtcjC8TVcZG
 cCzTzDhDmt+BGSMbHcixO9q/nWBY4mYG8+P+r8UKUTxiymdRNWAqF5CTk0HPEi2H02wNJ++GV
 IjoykseILbMbtTeUJV2J9PUNpFg5rfU42oUrK03N22u/4KQ+LCovqBbEvt2ECyNZsb45CLHu4
 XUyCR0sbRQomSWThHudt+SN4GxDtYPkuIrFGDLsRIOyQ6LYvK8bRHXoSPs5/Jtq/9WLI0oWn6
 BaaqHmevlqQQ5tDkdiez+/AI3KSeRoR38NUlSGOyB4zP6qkIPRwRH/tyx/IUO7eTPzaJHxqLh
 Wt+KVVVU52/FHsYWGIHygdyVRszi8EmQsHRjrv1hibhS1Oy76v+NVWpqxYA0YiIckKyzv+d9V
 Y4iERWNs+U+cZ/3oRIt7rjkhSNbHxTRufF6O8slb5cgcSQMOw5ffxomNDrdiV7dcMzS9hxKKS
 RV8S2ugnu6UxSaj7+h69zmU5Yob1+Azre/9csXnjE8kyJI5rX4DEYVad03uMhe4GsgmKaC+Tl
 9zwmmtljA3ohq98X9PDbuvLPWA0XkbhIU0YrcjTt1J8D9cryd55ocTQUfupa6h4qTZnsa1b9P
 di0xMa6CuGUa07Mk3TVbngDWUSF2/WPZbpmMtVSLthWKuZiqBTplCNfi8U2xYXXGEosqbaWBK
 q+tb5V7sR/Dzpf3Ta8ZQyCiJC9+uM9HDVehNNb9ieqgk5d7KceNzBetkTToyDFFWCPqBsv1kp
 PlGI25rLWBg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON(x) should raise an error if x is true, but assert(x) raises an
error if x is false. Remove this bogus definition of BUG_ON(), which
isn't used anyway.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 tools/virtio/ringtest/ptr_ring.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/virtio/ringtest/ptr_ring.c b/tools/virtio/ringtest/ptr_ring.c
index 2d566fbd236b..c9b26335f891 100644
--- a/tools/virtio/ringtest/ptr_ring.c
+++ b/tools/virtio/ringtest/ptr_ring.c
@@ -18,7 +18,6 @@
 #define ALIGN(x, a) (((x) + (a) - 1) / (a) * (a))
 #define SIZE_MAX        (~(size_t)0)
 #define KMALLOC_MAX_SIZE SIZE_MAX
-#define BUG_ON(x) assert(x)
 
 typedef pthread_spinlock_t  spinlock_t;
 
-- 
2.20.1

