Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034603AbeE1Pfj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:35:39 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:34397 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031483AbeE1Pfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:35:33 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Alexandre Bailon <abailon@baylibre.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: musb: remove an unused variable
Date: Mon, 28 May 2018 17:34:35 +0200
Message-Id: <20180528153522.2150105-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:iEcfDBHmXZV8yipv68egwjPhKa851b3P9rpPgLeA9bhH4j9TAQV
 /a08cY7Ij78F8j1X3n5XZ6On+Ph4igS4tQPopU0e4EXJ/5b4piDUgACkgZEikUlFCAUkY6Y
 3gic6AjKjV7O/RM5DpEmw89nl2kfGlEhzMNOqsVL4tzjkeSGTkYDw4GJ6ig4O1nPI5rOiri
 2tbzb+2eaLB9XZjK3YVIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qW2uhwxB/XQ=:bOMF6H6gm4o2jYJ45Vr37C
 ZeAJgv5LcvKl0pakDSZcc1BC3rA8Jw9kyWpNannqHqUhGSjquYxC4v7SCYU89pEi9+fNfvSvQ
 AboH1pF6llXUxKdMFkM5MS4a0zFZh7OJtrhXcqDhph56cA0s18sI3cHMUafGUAcmKKiHWj10C
 JSOu51R9AEMCKDVJ6MV2L7a0pWN0e8h1E9IE9d6w10QhlJAM9bJW7bxpQi8kt4XsAcUOq4i8t
 jTCC3lc8LWsVHR1XATz1Dsb8WNeH3AxBYsPYF6/4gWTntT9Z+7ODbrherB4m43uNIJGfRJBct
 Q2G7SOrU02JuIWErE+hCdc0jCtuyORSMXSPpB1jwJ7GmEdTUurObFa/cVYPYt13AFbAKeLYZG
 I/jvFP1snCDDiHFeUm+L8nNV4IZcd+miRcA/HlfvD/PRaABPqG8SIah7eF5QEMBFROS9oBcr5
 8ab6DKr6m5Bvoip/4hN2TMFolnDYT9J6Hiw3mJAFlRAEzRzteRUe/zfcJqf8E5hr9qkNAh+/f
 F9pYXUOunN9eUPqKV7fw2T0TUOyrnk5DiESEPX/SD9X5ZJzpq9Ru+9K+r3B/q+JouONZNrE5K
 dJRC1pAsLikxz/6y1Zw5YxXtHW/amoCbjetrQny4lNvVmf6hyW52uL83OlKmZSy87TRIsi89c
 3YZL5TxrWpq7zNuFvML2Je0LDjAVykqCXIN/PRukZKlJT6hsTybmA4waJXHSl0+nfAi4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the only users of this variable got removed, we now get a
warning about 'otg' being unused:

drivers/usb/musb/da8xx.c: In function 'da8xx_musb_interrupt':
drivers/usb/musb/da8xx.c:226:19: error: unused variable 'otg' [-Werror=unused-variable]

Fixes: d2852f2d3e6d ("usb: musb: remove references to default_a of struct usb_otg")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/musb/da8xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 0e5929e81d26..1c023c0091c4 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -223,7 +223,6 @@ static irqreturn_t da8xx_musb_interrupt(int irq, void *hci)
 {
 	struct musb		*musb = hci;
 	void __iomem		*reg_base = musb->ctrl_base;
-	struct usb_otg		*otg = musb->xceiv->otg;
 	unsigned long		flags;
 	irqreturn_t		ret = IRQ_NONE;
 	u32			status;
-- 
2.9.0
