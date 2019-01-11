Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A74DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594972146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S68dFzP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbfAKMZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:25:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45842 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbfAKMZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:25:32 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so10634169lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 04:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8s0iPyC3nM/rk7L/c68nMdHKZ/R/Cy2gudgTNhTVnE=;
        b=S68dFzP9pj3n5dHoJ0ra2uhg+Ei+0UiopJ6Ey0M2wq1BODvJLLrn+18QdQ51lvNXYc
         5ZVPlvqUJcpGwFJwXWlVYREI+BMnT2Lb1qud31JL8u2VdlteLNSSCsaSOV//5F70n/mH
         EUOwBVdnoOGpB+BCZboXYm4XXz3MZqYbNJb3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8s0iPyC3nM/rk7L/c68nMdHKZ/R/Cy2gudgTNhTVnE=;
        b=FHkvrg9c6fKRsETUhnlMLayM6PMVPhNq+5kNsaweell05hg3t/ye92iItf7WZzsBDY
         eW47Lt8JtlBdtBVdq+vOjUvN45ecDFPtwTJeERkm6KosjfJ3cvQgWmPtmFXNMgMMKpfW
         B83B2xxh3OP6zysuf0cZc+mhf0iiY2Exw4gabKYTdPOQBfyDpFtsptJIHwMZPlCmDtt8
         ancH1Kf9wj3HF9aKNEkIHIvb9ejylu3hotOXpR78PvwIb19dNsB09xLseyHNWAkN7Dj3
         rFK11mvdiDzgdehHR/N+bevzpPPhMSIi829la+Zh/RflDvEWmF4SvTnJMHLGzZBZuSPd
         03EA==
X-Gm-Message-State: AJcUuketHvH+ONe4nXEmhTMy5wMSy7j1WV3SxSBYSaNkMkz1Zs3ZZ9XT
        ABIYFusGVtymdNLrRiEZcfZZ4j2oeg5RGg==
X-Google-Smtp-Source: ALg8bN4Q9ageqUkz3b5cWlXLCGoycbhVsP+oFauNxBIrtnBSDnhB8XBGpfCKr9tb5nHmL34+Eh4tmg==
X-Received: by 2002:a19:645b:: with SMTP id b27mr7941995lfj.14.1547209529978;
        Fri, 11 Jan 2019 04:25:29 -0800 (PST)
Received: from localhost (185-130-167-110.kund.ip-osteraker.se. [185.130.167.110])
        by smtp.gmail.com with ESMTPSA id v19sm14618009lfe.69.2019.01.11.04.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 04:25:29 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] misc: pvpanic: fix warning implicit declaration
Date:   Fri, 11 Jan 2019 13:25:25 +0100
Message-Id: <20190111122525.21167-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building and have fragment CONFIG_NO_IOPORT_MAP enabled then the
following warning:

../drivers/misc/pvpanic.c: In function ‘pvpanic_walk_resources’:
../drivers/misc/pvpanic.c:73:10: error: implicit declaration of
 function ‘ioport_map’; did you mean ‘ioremap’?
 [-Werror=implicit-function-declaration]
   base = ioport_map(r.start, resource_size(&r));
          ^~~~~~~~~~

Since commmit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set"), its now possible to have ACPI enabled without haveing
PCI enabled. However, the pvpanic driver depends on HAS_IOPORT_MAP or
HAVE_IOREMAP_PROT when ACPI is enabled. It was fine until
commit 725eba2928ad ("misc/pvpanic: add MMIO support") got added.
Rework so that we do a extra check ifdef CONFIG_HAS_IOPORT_MAP.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/misc/pvpanic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 595ac065b401..95ff7c5a1dfb 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -70,8 +70,12 @@ pvpanic_walk_resources(struct acpi_resource *res, void *context)
 	struct resource r;
 
 	if (acpi_dev_resource_io(res, &r)) {
+#ifdef CONFIG_HAS_IOPORT_MAP
 		base = ioport_map(r.start, resource_size(&r));
 		return AE_OK;
+#else
+		return AE_ERROR;
+#endif
 	} else if (acpi_dev_resource_memory(res, &r)) {
 		base = ioremap(r.start, resource_size(&r));
 		return AE_OK;
-- 
2.19.2

