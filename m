Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311ABC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB93B2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQVKi2Lk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB93B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeKIWkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:40:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40000 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeKIWkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:40:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id q19-v6so921499pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 04:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=VZzIrsI5sgJJ7xKx6yIyQLPR8ly9OjEEiHhg2GEIiTY=;
        b=UQVKi2LkOPkmRenfgvtq1ZsBm0nuOwbh//N9a9ypBmGIxWAQjsQFoqbpA6Nxdb58Cc
         bXV5WIm6KhJt6vBknRAJzQOkJzklNMl1MvJxzKkL4MlwRF6xY6Wj6Zs/AMR0ugtmkNZC
         ToywN3uzrvxvrzMEBZtbR7Vcisobatuk8Es+RbkxnkYYxUEFKamD/pOZt7Ryerapx2uA
         ruK6J7EulkPoaCuOuVCTGLTUkOPRrWGvVuQzhza6iishO9JSPrpW2rM5+ykAi+YKKjYo
         7w3/L+cSOj0mhP7NJz7RlVSmeEQ6MUaYxtfYwhhfdvRGrgRdwS6i4h/vJwgpnS+QvPuU
         C/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=VZzIrsI5sgJJ7xKx6yIyQLPR8ly9OjEEiHhg2GEIiTY=;
        b=MmAP31rwD4t1lKrREdOtWvZNFwO8b4egKdjaYhgqD6sPow4jJ9Y+0/u5Ummyses2P4
         1VcOZ0kC1jv1RaeTDpIoO70Q/3+NxwwPIvD6V/2nUjDH4QIdDxGSxe3if+asrcYMTYIk
         JrDl2Z8q39XnX3xA7QpdZTTJAfYsj3rwJcC5heTfcH0ycYQQX3Qo8j6xvNwLawACLE2z
         HJ+xhlRoDN9w6HOIf6g0a3FVRv6T3SpxZXowqHeKE7Kw/EaCLM69iMNI7ZaVDTAHLXcG
         vqNxlTZevT39pYrYvW6t3HTDmkBRaf/CPMaiiYFskPts2Q3tZTf3lej4GMaboqjyCBtz
         he8A==
X-Gm-Message-State: AGRZ1gKgO3Nx0KGQwY2Ldd8PZ4WCOFjk9Y2FuXNYigZAjkXjb51KXf5A
        BZtkumlSkjekYKOADmig08mq8VoKu/P1sg==
X-Google-Smtp-Source: AJdET5eBj4P/UfFdqj789A4GlhgjPmn7Wakt+pMl27CBOclFCX5zMPSc+IHZYT6KtZZm1g8kBfFYkA==
X-Received: by 2002:a17:902:a587:: with SMTP id az7-v6mr9063360plb.151.1541768389813;
        Fri, 09 Nov 2018 04:59:49 -0800 (PST)
Received: from raspberrypi ([45.76.192.69])
        by smtp.gmail.com with ESMTPSA id s30-v6sm6076578pga.57.2018.11.09.04.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 04:59:49 -0800 (PST)
Date:   Fri, 9 Nov 2018 20:59:36 +0800
From:   He Yangxuan <yangxuan8282@gmail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com, carlo@caione.org, khilman@baylibre.com
Subject: [PATCH] ARM64: dts: meson: p230: disable advertisement EEE for GbE.
Message-ID: <20181109125936.3siduqtjmj6vv5ur@raspberrypi>
Mail-Followup-To: linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com, carlo@caione.org, khilman@baylibre.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch disable EEE advertisement for P230 board (DWMAC + RTL8211F).
If not disable it, the network connection is not stable, will got issues
like throughput drop or broken link.

Signed-off-by: He Yangxuan <yangxuan8282@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
index 15014faa2..0c8e8305b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
@@ -86,6 +86,7 @@
 		max-speed = <1000>;
 		interrupt-parent = <&gpio_intc>;
 		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+		eee-broken-1000t;
 	};
 };
 
-- 
2.11.0

