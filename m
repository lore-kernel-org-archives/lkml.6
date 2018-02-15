Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1146594-1518691232-2-7921452186765891643
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518691231; b=VIuxk2f+fxNx0DH9JbJD3MBdfyNujAK7DuH9v94GG3cy8xD
    ako5I6eGF4fDeqM9RFQIeRzf4KTPWmKwhixXhnYm9UuB+BrPH4T1tV6F1a/+LB+B
    OZb78eXeMKm+lgBWGAFYvittC+ntVbeKW0yWUrZt0LYVzRQFcGLiLmY+LYMxxqt5
    93gBH5M4Bdtp117PflrYHdAceo6CyThOuNBMCvvgt7KcQfMwy0WYXglv9x2pC+Gv
    GRX/S8PxmPxwHlliUvd7f5HSqcgGnVk27G7PLFLMd++kpwxXDlkoo8giUbN36YXD
    EuCDdj04jesvE7GTgC6RDaMYoiSswdfnhnBKAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518691231;
    bh=BC4GkbyhaBawShvQfPj3gjCi+1BUn6cixSLjomJbNIg=; b=Rc6ESoURQ9U6
    CXem4kM7vTEAqZzjabdKWMBQ74rQk6yMH2evbycfdIdU+aBTbMJ/kxTnDUm1o/GE
    JQjxOPcOnF5DtPHQSx1M+9f+0K5q264Nn1jkZFBr6GxYsDl5tDO6/pnMzozng3x5
    EWiB56VQpO3wIWiRmJp0z+emAHoTs5qcYPHnRZaO225SGLqHd6bUHf5BmLzMjPNp
    QxfOYx3KXHj5IDGFoZF/vc8Z6soOqVlbPN9cgaCmLho0qv3gpIgYuHZNQUSUfxgl
    m3JcyjrypOI3nxLZ325H4wq2fR4kO91/Kb4oasdJmsWgfr5vSmFZKPB2AIf8G1g9
    kwcZmQ5v7g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=VJZia74E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=VJZia74E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755497AbeBOKkN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 05:40:13 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47570 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755446AbeBOKjh (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 05:39:37 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180215103935euoutp01bf85612dd0d6225fb1b464347ffae589~TeZPxNUCf1203312033euoutp01P
X-AuditID: cbfec7f4-b4fc79c0000043e4-de-5a85636236d1
From: Andrzej Hajda <a.hajda@samsung.com>
To: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Cc: Maciej Purski <m.purski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH v2 6/6] drm/bridge/sii8620: use micro-USB cable
 detection logic to detect MHL
Date: Thu, 15 Feb 2018 11:39:20 +0100
Message-id: <20180215103920.32017-7-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
In-reply-to: <20180215103920.32017-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djP87pJya1RBj/v61vcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltljw8haLxdojd9ktll6/yGTRuvcIu4Ogx5p5axg9Lvf1MnnM7pjJ6rFpVSebx/3u40we
        m5fUe/RtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG9/PT2Areq1U03v3E2MDYq9DFyMkhIWAi
        0b64i6WLkYtDSGAFo8S9WZtYIZzPjBIHG7ewwlTN3XSNCSKxjFFi664PUM5/RolJb9exgVSx
        CWhK/N18E8wWEYiVeHdpFzNIEbPANxaJebPmM4EkhAWSJT4ub2AEsVkEVCUmHD/NAmLzClhI
        9LzuZYZYJy9x+E0T0GoODk4BS4kp8y1A5kgIPGaT+PRgMRtEjYvEidO72SFsYYlXx7dA2TIS
        lyd3s0A0dDNKnNrXyQzhTGGUOP/qMhNElbXE4eMXwZ5jFuCTmLRtOjPINgkBXomONiGIEg+J
        ny2HoP53lLjY+ZMN4uUeRonp3fuYJjBKLWBkWMUonlpanJueWmyUl1quV5yYW1yal66XnJ+7
        iRGYHE7/O/5lB+OuP0mHGAU4GJV4eA1sWqKEWBPLiitzDzFKcDArifB+jGqNEuJNSaysSi3K
        jy8qzUktPsQozcGiJM4bp1EXJSSQnliSmp2aWpBaBJNl4uCUamAMLGRSOc125tvRNXOTxEQy
        p/52Mj/gkhQUOWd1yPdnhSUHaqqe1r5svfOMbdk58YPiV7n0JSUM7j5K+3PvyG33fIVoGWXt
        GMlDSrcX+dcVWGuJHFmxcO2qv8u8u7hVHn+60h/AoPKR/01E6ZqwX783HslZKKe42vB0Or+P
        TD+31nYGB/3X7QlKLMUZiYZazEXFiQDECjuPCgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsVy+t/xq7qJya1RBp8VLW6tO8dq0dTxltVi
        44z1rBbXvzxntZh/BCh25et7NotJ9yewWJw/v4HdonPiEnaLTY+vsVpc3jWHzWLG+X1MFouW
        tTJbLHh5i8Vi7ZG77BZLr19ksmjde4TdQdBjzbw1jB6X+3qZPGZ3zGT12LSqk83jfvdxJo/N
        S+o9+rasYvT4vEkugCOKyyYlNSezLLVI3y6BK+P7+WlsBe/VKhrvfmJsYOxV6GLk5JAQMJGY
        u+kaUxcjF4eQwBJGidOfZjBDOI1MEvOOXmYGqWIT0JT4u/kmG4gtIhAr8fbUZ7AiZoEfLBLX
        T+4ESwgLJEu0Hv7LCGKzCKhKTDh+mgXE5hWwkOh53csMsU5e4vCbJtYuRg4OTgFLiSnzLUDC
        QkAlGyfPY53AyLOAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYOhuO/Zzyw7GrnfBhxgF
        OBiVeHgNbFqihFgTy4orcw8xSnAwK4nwfoxqjRLiTUmsrEotyo8vKs1JLT7EKM3BoiTOe96g
        MkpIID2xJDU7NbUgtQgmy8TBKdXAOLux3Y6L7YpuQKFR5rsD01z+/E1lO/W2NLmc86uZ84k9
        NnpVu4xF2njUT0okiX+ONTeRvBj+XVdf6pxLyCphS76626fXGPC/KI+a1rVU0Llz8rLjjtMK
        is+WKsxSX7onzFL12qap5Quyo14f8CmfL1ko6Xdo0Xmpz1N3Xz70442Zzuy85Op0JZbijERD
        Leai4kQA2SPhhFkCAAA=
X-CMS-MailID: 20180215103929eucas1p208a0b6b20e7b0c5ce1b99791b6707ab8
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180215103929eucas1p208a0b6b20e7b0c5ce1b99791b6707ab8
X-RootMTR: 20180215103929eucas1p208a0b6b20e7b0c5ce1b99791b6707ab8
References: <20180215103920.32017-1-a.hajda@samsung.com>
        <CGME20180215103929eucas1p208a0b6b20e7b0c5ce1b99791b6707ab8@eucas1p2.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maciej Purski <m.purski@samsung.com>

Currently MHL chip must be turned on permanently to detect MHL cable. It
duplicates micro-USB controller's (MUIC) functionality and consumes
unnecessary power. Lets use extcon attached to MUIC to enable MHL chip
only if it detects MHL cable.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
This is rework of the patch by Maciej with following changes:
- use micro-USB port bindings to get extcon, instead of extcon property,
- fixed remove sequence,
- fixed extcon get state logic.

Code finding extcon node is hacky IMO, I guess ultimately it should be done
via some framework (maybe even extcon), or at least via helper, I hope it
can stay as is until the proper solution will be merged.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 97 ++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 9e785b8e0ea2..565cc352ca81 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -17,6 +17,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/extcon.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -25,6 +26,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -81,6 +83,10 @@ struct sii8620 {
 	struct edid *edid;
 	unsigned int gen2_write_burst:1;
 	enum sii8620_mt_state mt_state;
+	struct extcon_dev *extcon;
+	struct notifier_block extcon_nb;
+	struct work_struct extcon_wq;
+	int cable_state;
 	struct list_head mt_queue;
 	struct {
 		int r_size;
@@ -2175,6 +2181,77 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
 	ctx->rc_dev = rc_dev;
 }
 
+static void sii8620_cable_out(struct sii8620 *ctx)
+{
+	disable_irq(to_i2c_client(ctx->dev)->irq);
+	sii8620_hw_off(ctx);
+}
+
+static void sii8620_extcon_work(struct work_struct *work)
+{
+	struct sii8620 *ctx =
+		container_of(work, struct sii8620, extcon_wq);
+	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
+
+	if (state == ctx->cable_state)
+		return;
+
+	ctx->cable_state = state;
+
+	if (state > 0)
+		sii8620_cable_in(ctx);
+	else
+		sii8620_cable_out(ctx);
+}
+
+static int sii8620_extcon_notifier(struct notifier_block *self,
+			unsigned long event, void *ptr)
+{
+	struct sii8620 *ctx =
+		container_of(self, struct sii8620, extcon_nb);
+
+	schedule_work(&ctx->extcon_wq);
+
+	return NOTIFY_DONE;
+}
+
+static int sii8620_extcon_init(struct sii8620 *ctx)
+{
+	struct extcon_dev *edev;
+	struct device_node *musb, *muic;
+	int ret;
+
+	/* get micro-USB connector node */
+	musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
+	/* next get micro-USB Interface Controller node */
+	muic = of_get_next_parent(musb);
+
+	if (!muic) {
+		dev_info(ctx->dev, "no extcon found, switching to 'always on' mode\n");
+		return 0;
+	}
+
+	edev = extcon_get_edev_by_of_node(muic);
+	of_node_put(muic);
+	if (IS_ERR(edev)) {
+		if (PTR_ERR(edev) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_err(ctx->dev, "Invalid or missing extcon\n");
+		return PTR_ERR(edev);
+	}
+
+	ctx->extcon = edev;
+	ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
+	INIT_WORK(&ctx->extcon_wq, sii8620_extcon_work);
+	ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
+	if (ret) {
+		dev_err(ctx->dev, "failed to register notifier for MHL\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static inline struct sii8620 *bridge_to_sii8620(struct drm_bridge *bridge)
 {
 	return container_of(bridge, struct sii8620, bridge);
@@ -2307,13 +2384,20 @@ static int sii8620_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	ret = sii8620_extcon_init(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "failed to initialize EXTCON\n");
+		return ret;
+	}
+
 	i2c_set_clientdata(client, ctx);
 
 	ctx->bridge.funcs = &sii8620_bridge_funcs;
 	ctx->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ctx->bridge);
 
-	sii8620_cable_in(ctx);
+	if (!ctx->extcon)
+		sii8620_cable_in(ctx);
 
 	return 0;
 }
@@ -2322,8 +2406,15 @@ static int sii8620_remove(struct i2c_client *client)
 {
 	struct sii8620 *ctx = i2c_get_clientdata(client);
 
-	disable_irq(to_i2c_client(ctx->dev)->irq);
-	sii8620_hw_off(ctx);
+	if (ctx->extcon) {
+		extcon_unregister_notifier(ctx->extcon, EXTCON_DISP_MHL,
+					   &ctx->extcon_nb);
+		flush_work(&ctx->extcon_wq);
+		if (ctx->cable_state > 0)
+			sii8620_cable_out(ctx);
+	} else {
+		sii8620_cable_out(ctx);
+	}
 	drm_bridge_remove(&ctx->bridge);
 
 	return 0;
-- 
2.16.1

