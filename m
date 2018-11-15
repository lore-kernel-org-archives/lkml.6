Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520BBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164DE206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gluegarage.com header.i=@gluegarage.com header.b="j0XXfzZt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f9c0pr9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164DE206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gluegarage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389136AbeKPI17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:27:59 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37569 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbeKPI16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:27:58 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CBF1E22F25;
        Thu, 15 Nov 2018 17:18:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Nov 2018 17:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gluegarage.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=mesmtp; bh=ONICivwTMT
        ENz178nXjnq+JH0phQ4XP7eTBS8xMMsgo=; b=j0XXfzZteFoXlAzrIAQVQPWZ+p
        /P1msFrgPInflhKXWGL00BJBgq/90SJ3o44YakRE1FsoVersFzbvDN8L6eScBmdH
        c4GjXRgi5X7ieJ644a0qXgqCVmlg5N/Rb5KhTqeC6LAtCejtz2n+YrKmNtbVuh4i
        TaWCpx77IQ1k9Uj8I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ONICivwTMTENz178nXjnq+JH0phQ4XP7eTBS8xMMsgo=; b=f9c0pr9O
        jZPW7HdVJiFadeyNHbAYXBWTu4a3Jb4x/YcqoOBNnemnfGjn3J7/RiFpUlBOjhyM
        c4X83SPbMm1VcZnyuo9xhygHLx22t0Rpg+ZRyfOW54sKTvpz73bS8ZHPaY/ER3vv
        8ko01m2zrV02uNgha2ih+xtub44f505sLmJHVqNwLb4BRUCA87xZmtpvoC8eDUDi
        4hNS81IjDfGCFamKPEDa2Df1xiKlMVXU4aZgRt64Fy+/m4qJF68Leo2kpiZs/RNS
        ylJlv0iG641MUMCXMwWnxWjcYziIFB0ZxGf6vFPNgmDqDXl2+9NQyJAuEcjL2jpc
        W7nh8bjfmMFogA==
X-ME-Sender: <xms:qPDtW5JFldXh20GL88EcR4HdSkPWzZl2YPGPBzjrvPWn-GrKuOr4kQ>
X-ME-Proxy: <xmx:qPDtW63VboRASe8qLjnbsfFULsaPyYhu5rAnv8vkObqPTvJE3fzMow>
    <xmx:qPDtW0NvQybNtmMg6toUd4yW6EQB9nLvKh3cYAv6ijdd6HFzdd-6Tw>
    <xmx:qPDtW1NoCFCrdLdZJZu6DrM5biKOAVkBD7vSgEkuy19PhOkPB3iO2A>
    <xmx:qPDtW0mgFGEEZNkQHwyK-QV7_UveCwjsoVQwgFK8Pbj3Lzl4VK2yWw>
    <xmx:qPDtWwDDEN5yKsjgUhSSqjVc_0UFN2MNj3qU27g9Mw_YWg9S_diP5w>
    <xmx:qPDtW-RQn5FsI15JAcoll9w0QGPgyiY8aBpY4FZGZssPJrUmBLY_TQ>
Received: from zaca_x230.localdomain (unknown [109.205.143.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 24315E4307;
        Thu, 15 Nov 2018 17:18:12 -0500 (EST)
From:   Fernando Ramos <greenfoo@gluegarage.com>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        etnaviv@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [PATCH 9/9] docs: drm: remove no longer relevant TODO entry
Date:   Thu, 15 Nov 2018 23:16:29 +0100
Message-Id: <20181115221634.22715-10-greenfoo@gluegarage.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This entry asked to rename all drm core "*_reference/_unrefence"
functions to "*_get/_put".

Now that this task is complete, we can remove this entry from the TODO
list.

Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
---
 Documentation/gpu/todo.rst | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 77c2b3c25565..85433af65442 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -28,23 +28,6 @@ them, but also all the virtual ones used by KVM, so everyone qualifies).
 
 Contact: Daniel Vetter, Thierry Reding, respective driver maintainers
 
-Switch from reference/unreference to get/put
---------------------------------------------
-
-For some reason DRM core uses ``reference``/``unreference`` suffixes for
-refcounting functions, but kernel uses ``get``/``put`` (e.g.
-``kref_get``/``put()``). It would be good to switch over for consistency, and
-it's shorter. Needs to be done in 3 steps for each pair of functions:
-
-* Create new ``get``/``put`` functions, define the old names as compatibility
-  wrappers
-* Switch over each file/driver using a cocci-generated spatch.
-* Once all users of the old names are gone, remove them.
-
-This way drivers/patches in the progress of getting merged won't break.
-
-Contact: Daniel Vetter
-
 Convert existing KMS drivers to atomic modesetting
 --------------------------------------------------
 
-- 
2.19.1

