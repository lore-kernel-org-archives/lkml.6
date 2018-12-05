Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC47FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D3B208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="D22OYI0x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JKy65mpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D3B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeLEXDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:03:46 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50551 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727337AbeLEXDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:03:46 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 60C4920BBE;
        Wed,  5 Dec 2018 18:03:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 05 Dec 2018 18:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:mime-version:content-type; s=
        fm1; bh=3pujw0YiLkkBa9tOiVNUExfYthelZKw1I32srKIEGCk=; b=D22OYI0x
        E5xAdJjl4Ah+AVukTRG43IReyjY94M5Sj175NqnjiVGV8CrGdEW+c6qG2MhAEIEr
        ViXELDZolrrQi8H00DuK8ZpXp0UV3jfnnzj+zNRoOORFHkQI15HcOCuRhu6Zxyi7
        hrnMBYVd9v19BfxsGxHP53GYg7gTEP9j39NgEw+LF6RhsjY4XT2xyGzcReSy01KQ
        bCCtK4pxtdwtXXy6uKMWZySViUEDiJ2zALpPDbY4kf+9QaH4JsU4dGRCTZu+b3mE
        RoVgMJWbPhPkMR8rQel4q0cgFsZU0if3J4M9PwyR0RUMxUh9C3VBuxJO3pdVqUP/
        u0zsXuOksSx1BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=3pujw0YiLkkBa9tOiVNUExfYthelZ
        Kw1I32srKIEGCk=; b=JKy65mpbmiSem2V3B4vto6I0Ir7eM4Oa6SObPI6UQIzR0
        vwcY9yjL+/Q91TeaiyQ3abiMJArgRC+59s829pkH0RlWKg3/F+I0+dEcOpFwWw9s
        UikpXzLFBvlaZXtB8ottk2XPpCOhMfTJRKDcdS/niA72WE4BbLXF21bM3V/M+VUW
        yUE5xYUVdAmlmD1KsHUvTu2HfLEWQRCAheFL4NVuuxfwwBjtb4eCS8axMJRQPWqf
        Nd5fS3qwXWs1Frz9MaLq+LM3aEEZR1qpQEcfpeTXwZjsIBkXP61FMRIde3btVRhR
        WZV7w+MzzkXDml63freYRQKdLwFQ0G6in7l/jKqfw==
X-ME-Sender: <xms:TlkIXIxoNgKZL-raapRiY9OVOFhrK6QR1eQ03jDoOhP5MqBQBg2VNg>
X-ME-Proxy: <xmx:TlkIXESBQsx64CnlCUWKMwnMry3sEeNGw2mU2pbyUX3PgYz0yNgKcw>
    <xmx:TlkIXObEZXSgDkHyMvc1ROcytV5FzprwJaxDXoIHBaQQ7uPJ5GiE3g>
    <xmx:TlkIXNlnPuW8gVynaF692DKPOH71PLlv5d14CyXf8Q4t6jrqEsbu_g>
    <xmx:TlkIXL3jiRFQ6N-W5R3DBj_zUA2ETBNeZ0BUZ_Lz45P8t_vYunBI5g>
    <xmx:TlkIXPTHkQ63eWueSy0VnZhW8ETyypsA4QiEYsc8fXNqeV7YMW4PzA>
    <xmx:T1kIXOmlR4Dpsuk6gjAYoUHWpqdErSrU3qu5IyKyzxsz3mbeHhnPqA>
Received: from jelly (unknown [66.187.239.16])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2156E10324;
        Wed,  5 Dec 2018 18:03:40 -0500 (EST)
Date:   Thu, 6 Dec 2018 09:03:36 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: restore EV_ABS ABS_RESERVED
Message-ID: <20181205230336.GA23462@jelly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ABS_RESERVED was added in d9ca1c990a7 and accidentally removed as part of
ffe0e7cf290f5c9 when the high-resolution scrolling code was removed.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 include/uapi/linux/input-event-codes.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 3eb5a4c3d60a..ae366b87426a 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -752,6 +752,15 @@
 
 #define ABS_MISC		0x28
 
+/*
+ * 0x2e is reserved and should not be used in input drivers.
+ * It was used by HID as ABS_MISC+6 and userspace needs to detect if
+ * the next ABS_* event is correct or is just ABS_MISC + n.
+ * We define here ABS_RESERVED so userspace can rely on it and detect
+ * the situation described above.
+ */
+#define ABS_RESERVED		0x2e
+
 #define ABS_MT_SLOT		0x2f	/* MT slot being modified */
 #define ABS_MT_TOUCH_MAJOR	0x30	/* Major axis of touching ellipse */
 #define ABS_MT_TOUCH_MINOR	0x31	/* Minor axis (omit if circular) */
-- 
2.19.2

