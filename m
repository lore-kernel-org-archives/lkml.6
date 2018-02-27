Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-757978-1519715601-2-17123806370274481538
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
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
    t=1519715600; b=Ks7JeqRUNY1Uk/ER1OzNqKt0J15E2KN+KrwGYRWAGGVWSXN
    TlTcCofuAw3Ncm2z98G01q4r8CQPPiMIf16bsNZsZac7ZT/rLvCutOaxaW5rHr/J
    Oz3bhTb6dMvoUpK06ztSo1TY1zKkuvSUzlslXuxscg9rfu2w/oSpbL6RraIT7VhC
    A+oADzB1RDe97kDnyPbNuJ53ouhUb9x9mo7nwf5523QW+GKQ5HDx1KkfBmvce8BS
    xdCrqZXjvotdcz/xiV7paIf4pQ14pRXduB12i4eM2tjei+CbGLVIbK/p1/xRmR3Q
    BwJZ6DHcLsmv4q7GBC5MG+xGMBWX64uQxfMBxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519715600;
    bh=eTulijaJsYo03elKUDebtbop9tcUoRehCcTWLyU4sZE=; b=enp2RvUSl1P4
    V54xcyHZkVbeg6n7fMMDFKhIW68SpZ8fiHJvVxc6tFALCNBEkHrkNK7GIOW5bgTs
    J9b4LsQ+t16dLs6J6UOuQFtoi81Y5hte/a2w7du3UCUCcTKOyJD9FX7GAPLMPDk4
    R2B+uAmO0fTI+1Km1ArbxvOhwzM4Mvzbvbm6jBFATfi5pjUJczOTyctEpYc7VCWy
    MLbnpxVWkKekd2/Ebz2uWG44SOpgIDAqxOZVJOEAME+SIDq8AFP3c3ay8rmR9p8p
    +yi5sEhyxC+r16ENrSoy/ryYOH5I1083xRklO5Bf1QzYtPyZRh/HI2EC9Fi/qZDn
    XrC2kx/ENw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=VEzlrA/o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=VEzlrA/o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeB0HMj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 02:12:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50130 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeB0HLq (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 02:11:46 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180227071143euoutp0226ccdca888e87c6e04841bf87e98ef17~XHTLpKdCh2547425474euoutp020
X-AuditID: cbfec7f4-6f9ff700000043e4-85-5a9504ae17ac
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
Subject: [PATCH v5 6/6] drm/bridge/sii8620: use micro-USB cable detection
 logic to detect MHL
Date: Tue, 27 Feb 2018 08:11:34 +0100
Message-id: <20180227071134.28063-7-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.2
In-reply-to: <20180227071134.28063-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7djPc7rrWKZGGVzfpWRxa905Voumjres
        FhtnrGe1uP7lOavF/CNAsStf37NZTLo/gcXi/PkN7BadE5ewW2x6fI3V4vKuOWwWM87vY7JY
        tKyV2WLBy1ssFmuP3GW3WHr9IpNF694j7A6CHmvmrWH0uNzXy+Qxu2Mmq8emVZ1sHve7jzN5
        bF5S79G3ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZR9buYC5oV694MvEOSwPjPIUuRk4OCQET
        ic2nbjB2MXJxCAmsYJS4u2I3G4TzmVGi+cE+FpiqN8cuQyWWMUpcPfOFHcL5zyixZfsedpAq
        NgFNib+bb7KB2CICsRLvLu1iBiliFvjGIjFv1nwmkISwQLzE993vGUFsFgFViU2XGsAaeAUs
        JM5dncMMsU5eYuHZq2A2p4ClxP5pZ8BWSwg8ZpM4s+4MVJGLxL4zi6FsYYlXx7ewQ9gyEp0d
        B5kgGroZJU7t62SGcKYwSpx/dZkJospa4vDxi6wgNrMAn8SkbdOBijiA4rwSHW1CECUeEuc2
        PWWHCDtKnD8TDRIWEugBhtLJuAmMUgsYGVYxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIE
        pobT/45/2cG460/SIUYBDkYlHl4HmSlRQqyJZcWVuYcYJTiYlUR4Vy6eHCXEm5JYWZValB9f
        VJqTWnyIUZqDRUmcN06jLkpIID2xJDU7NbUgtQgmy8TBKdXAmG915UdXx5OidcxaT4/O+yKe
        HJXx07XNvPVDa4qC99ZajQUPZZYbs1XGCuo95S+Myjc/fVE041qCCkP+pR/mGTynj/Btrpoa
        9LjyjdCfh9y7Nx9gnKql9NyL/UKoyq9XJtvOH81edapv95yOvPB5sgfErfjLDnOWHy58c9bi
        96Rgy01PFwfaKLEUZyQaajEXFScCAOuOtmAJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsVy+t/xy7prWaZGGVy/amNxa905Voumjres
        FhtnrGe1uP7lOavF/CNAsStf37NZTLo/gcXi/PkN7BadE5ewW2x6fI3V4vKuOWwWM87vY7JY
        tKyV2WLBy1ssFmuP3GW3WHr9IpNF694j7A6CHmvmrWH0uNzXy+Qxu2Mmq8emVZ1sHve7jzN5
        bF5S79G3ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZR9buYC5oV694MvEOSwPjPIUuRk4OCQET
        iTfHLrOB2EICSxglLv9U7GLkArIbmSTetc1nBEmwCWhK/N18E6xIRCBW4u2pz8wgRcwCP1gk
        rp/cCZTg4BAWiJe41OgOUsMioCqx6VIDWD2vgIXEuatzmCGWyUssPHsVzOYUsJTYP+0M1GIL
        ifudx1gnMPIsYGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERi624793LyD8dLG4EOMAhyM
        Sjy8M+SmRAmxJpYVV+YeYpTgYFYS4V25eHKUEG9KYmVValF+fFFpTmrxIUZpDhYlcd7zBpVR
        QgLpiSWp2ampBalFMFkmDk6pBsaShstzDqh7GH3gC5XXeHNb7K7Y1Qyh/hf9f70kNn17GfEr
        3qDyYbhA5MP8I5f8eTK75h/8kMyq6tzg/eWJeV+129XZ+xkOnbF5qpgodZv7UT6j0dKtGTtO
        POhcfJfP8P62rvrJ5t4vJmR2Pdi1PbTBKe718wk3bW9fvLIz+vDkogmswp9PydxRYinOSDTU
        Yi4qTgQAEoG0sFkCAAA=
X-CMS-MailID: 20180227071142eucas1p10203dac2558db034a4a3287220213601
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071142eucas1p10203dac2558db034a4a3287220213601
X-RootMTR: 20180227071142eucas1p10203dac2558db034a4a3287220213601
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071142eucas1p10203dac2558db034a4a3287220213601@eucas1p1.samsung.com>
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
v5: updated extcon API

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
index 9e785b8e0ea2..62b0adabcac2 100644
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
+	edev = extcon_find_edev_by_node(muic);
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
2.16.2

