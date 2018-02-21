Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1047503-1519203445-2-7869815480132968936
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519203444; b=Wz6bgFXjJPYlMRsrJwmRVAqrgk4gqk/nNhmpjWdEdpYD1Zv
    y+dZJ1xvlIXFJ3mO7m/pXyo628AP0sP6a5iAj5lNuH57zI7ThBPLQumjNlW1wXx1
    ScayEL3Nr0J+JGAWYcdxs46iP4+y30+QwxMTbvkNVnf0xe+FrIUuEgIsS5RSgFmN
    buTk03KY363ti9UDHdqNpIMW4XtVCCU4DwWggslq7j09rXegCih3PDaUDlBp2h3k
    fmpJwRDC4JBUynd1/IyZ4wZUQUuLAOi/pQmuTNUAyjwX5wEbm6Zci9s1scttyiSU
    oKibt2Bc5wW65jkYA3TahtrSollWhsmGBoQq0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519203444;
    bh=BC4GkbyhaBawShvQfPj3gjCi+1BUn6cixSLjomJbNIg=; b=jbTTfifRjpX/
    Ig8B6AcACrBnXTocLkSpP9k1zFbjtMIQhZuIEDGB8PD0G+kS/2q61i/Y0IXs/IKm
    TwP0xiR+NzJXb2gH6pNcAkf/QB/LXsV1JMXIJGrk23f4U3KoqQh9ohtfJL0aCF8v
    zP8Y1kjugLUuX+fgQx2W8sW9J1XT+ug7TACK5mxibhbmoE7Yiwlrb4SIhcorUy6+
    EZ+XykAnc8noKIiLhPNCk3On0VB7sK424/VfeZ55+RAPSw5qSyGfwTnPCP6e1278
    EfDuFVhbbXmxkZAkRyfbn2UbirBg/McPbmLHLmZUcNUkMEoVh8dhRSHgPFH9R5gb
    59Iz7pFhuw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=qUUNPJ5p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=qUUNPJ5p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeBUI5J (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 03:57:09 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54345 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbeBUI4O (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 21 Feb 2018 03:56:14 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180221085611euoutp01b7471ae9dd818730256d838ad27d5662~VS2rmgNVu2444524445euoutp01a
X-AuditID: cbfec7f5-b5fff700000028a9-f7-5a8d342a28a8
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
Subject: [PATCH v4 6/6] drm/bridge/sii8620: use micro-USB cable detection
 logic to detect MHL
Date: Wed, 21 Feb 2018 09:55:41 +0100
Message-id: <20180221085541.14556-7-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
In-reply-to: <20180221085541.14556-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djP87paJr1RBveealjcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltljw8haLxdojd9ktll6/yGTRuvcIu4Ogx5p5axg9Lvf1MnnM7pjJ6rFpVSebx/3u40we
        m5fUe/RtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG9/PT2Areq1U03v3E2MDYq9DFyMkhIWAi
        sedIK0sXIxeHkMAKRom2uTvYIJzPjBIrJs5mgak6tW0BE0RiGaPEpub1UM5/RolDnXuYQarY
        BDQl/m6+yQZiiwjESry7tIsZpIhZ4BuLxLxZ85lAEsIC8RJf5qxhBbFZBFQlOs//AWvgFbCQ
        +P38OzPEOnmJw2+awGo4BSwlfu+dBDZIQuAxm8TGz0cZIYpcJJ5sesEKYQtLvDq+hR3ClpG4
        PLmbBaKhm1Hi1L5OqO4pjBLnX11mgqiyljh8/CJYN7MAn8SkbdOBijiA4rwSHW1CECUeEjMW
        X4W6yFHi7qprrBA/9wADYOIk1gmMUgsYGVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIE
        pofT/45/3cG470/SIUYBDkYlHl4LnZ4oIdbEsuLK3EOMEhzMSiK8lUK9UUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR54zTqooQE0hNLUrNTUwtSi2CyTBycUg2MG5x2Tt/5Pzt4Z4RYiZ3bvEeS
        MTuFGaetFj7vJMNadNvko1/G3NSClayrp/GvKmzKPH9N5c7xpKZvwSqbc9dtkf7I66QflPNp
        7dOuTA3rexe0Oub+XqG/YIEhm82BCV0K/r4/Vt6Z5lIlsu1Sw+I6xePtq9Y7ely8xLduH7vh
        P5u1Bna7RUJzlFiKMxINtZiLihMBo9MxPAsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t/xa7paJr1RBo9nMlvcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltljw8haLxdojd9ktll6/yGTRuvcIu4Ogx5p5axg9Lvf1MnnM7pjJ6rFpVSebx/3u40we
        m5fUe/RtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG9/PT2Areq1U03v3E2MDYq9DFyMkhIWAi
        cWrbAqYuRi4OIYEljBKrL/xnhHAamSSmT1jABlLFJqAp8XfzTTBbRCBW4u2pz8wgRcwCP1gk
        rp/cCZYQFoiXePhuFguIzSKgKtF5/g9YnFfAQuL38+/MEOvkJQ6/aWIFsTkFLCV+750EFhcC
        qvlw7iv7BEaeBYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLDd9uxn1t2MHa9Cz7EKMDB
        qMTDa6HTEyXEmlhWXJl7iFGCg1lJhLdSqDdKiDclsbIqtSg/vqg0J7X4EKM0B4uSOO95g8oo
        IYH0xJLU7NTUgtQimCwTB6dUA6MGv0bn4ms5+38q/Z64iZd5fWxS+S9Op/bmEw+NhYuzag9k
        Ci+bWMYaf6rTx9Gghl//dv/UIpF+9smXPO+vPanNUlS+qXjxNf6Z17YJam8TLzWc1hpw4FRF
        hdFbg7TT8xfqvdZnOz1doDIt2GXZTdm8SXNuVq03vKA8S9Rbo+KF9rObllNuHFZiKc5INNRi
        LipOBADFS90CWwIAAA==
X-CMS-MailID: 20180221085610eucas1p162a5cf356642e8556f6bc72163c3a5db
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180221085610eucas1p162a5cf356642e8556f6bc72163c3a5db
X-RootMTR: 20180221085610eucas1p162a5cf356642e8556f6bc72163c3a5db
References: <20180221085541.14556-1-a.hajda@samsung.com>
        <CGME20180221085610eucas1p162a5cf356642e8556f6bc72163c3a5db@eucas1p1.samsung.com>
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

