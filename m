Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD19EC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63B62085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mwVoTG32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63B62085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeKFRXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:23:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45417 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387542AbeKFRXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:23:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id k15-v6so9341208wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 23:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=No61VHsP7rC2rx8Yc4FNAwPi2vfRxlOG5U0z2rYBuBM=;
        b=mwVoTG32xcK6Qf+1YOMo8Q7zF19U7nC1oaVclMlGB4FfGMp5fr3e2Co1Jty63G9EQp
         vnB2+ngRW4UP9Ep2WruP9MNpD9jlXVbx04om//nUV7LgKaWnVF/hm3IKCD5YOOo9XTYu
         bFLEO6ECHAkHO0cRS1zIr+c3l0vquUNEyoVLZKuT316SLREaig8y3hgpTIgfiol0S8RS
         Ac9deXfI1vvC55bQnKHq9CSWgrFxsN/pP27SHEhtOAp0xpIjhmoAs0liIJGpaQIU3R8Z
         3QK22wcrZv4flUCtJ3ZdDQpJ2TUrAF61n04jgFRXg4GlXi5NBRjjLYFLmfTyMhjicKiN
         9kBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=No61VHsP7rC2rx8Yc4FNAwPi2vfRxlOG5U0z2rYBuBM=;
        b=Mcs8gU6PmNYLdv6BnhbE5WQnQhjiBKwv7m1EMJJIK/K58tz1QKT9yJRC0kEFYWxG0q
         cCS05bGU+PIwwFDQqZ+pEvdb3dIYypSiVMH3C9ERD15v+5myLMjiGnlCmwizPo5JYR2T
         rbKDyA/Qzn499F1Z8u7vXQTg38cM6fsipkTEJLr59mV+23EYyFEH4mcBpD30vku99j+I
         dPFSDCQFud1V8frkCW6iRqeH/p/scPfZU+uGWexYjyzTfesCoHHykI1BkkMTt7IZHeh6
         dCSWoFm+wjahziJHRk0G4MM1WV6CVbk6yY+D8pD17q4D4Dd8DUlWy2BVYDPhgLWVaAVN
         OxXw==
X-Gm-Message-State: AGRZ1gKksvuBhdBsHPf0hABxG0dI/0bBuAFE0sbrTjOnwZkUwVjljkSP
        shQa0AW9pNqiTu6M6I2nqYt6Rg==
X-Google-Smtp-Source: AJdET5dumTMUtVXIOnVtuWn3rzipq1U4Cbu78r2S2m1P3sQ80FnorqyUWfpGD/wvUAHXjtbmkFVvsw==
X-Received: by 2002:a5d:634f:: with SMTP id b15-v6mr11279229wrw.14.1541491183577;
        Mon, 05 Nov 2018 23:59:43 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id z16-v6sm918171wmc.0.2018.11.05.23.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 23:59:42 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v4 3/3] MAINTAINERS: Add meson video decoder
Date:   Tue,  6 Nov 2018 08:59:26 +0100
Message-Id: <20181106075926.19269-4-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181106075926.19269-1-mjourdan@baylibre.com>
References: <20181106075926.19269-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the meson video decoder for amlogic SoCs.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4855974f325..df013e7758b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9621,6 +9621,14 @@ F:	drivers/media/platform/meson/ao-cec.c
 F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
 T:	git git://linuxtv.org/media_tree.git
 
+MESON VIDEO DECODER DRIVER FOR AMLOGIC SOCS
+M:	Maxime Jourdan <mjourdan@baylibre.com>
+L:	linux-media@lists.freedesktop.org
+L:	linux-amlogic@lists.infradead.org
+S:	Supported
+F:	drivers/media/platform/meson/vdec/
+T:	git git://linuxtv.org/media_tree.git
+
 MICROBLAZE ARCHITECTURE
 M:	Michal Simek <monstr@monstr.eu>
 W:	http://www.monstr.eu/fdt/
-- 
2.19.1

