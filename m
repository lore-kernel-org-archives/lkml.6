Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0602C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDE6218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ9QFSD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfBQTWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 14:22:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41558 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfBQTWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 14:22:45 -0500
Received: by mail-lj1-f194.google.com with SMTP id z25so4646428ljk.8;
        Sun, 17 Feb 2019 11:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVlAb1nlnwMUT9ENbqmaXwTU9ISgXl4wbcvuVZUrWqM=;
        b=iQ9QFSD8PyCCnIzy5ZXWCXPVvsPW/HFzXqti7GWj4QtuEXdX/S/uvjE9xfBZJZd3cQ
         AVer6m5qMIPSLOcZekOcCiFD5eyHrFLoMJ35NaP6yJ/lUTjHj1uuwGNIsZLiAn+xnfsJ
         HV6r+ibGLbsjFGjHDla4ZGbyaGdi1yr3m5GL1wWaMs1VK1pR/O9o/BeyE64yvZDoWDWf
         yOBw5cQLj853sRyJTKOtWibc3ZRvWOWae0wACCoxj/98YC1tqbarfJh1ws0dEkf7QIho
         7GKyPPcoYCv0p8x0slZryMHBYf9fov1g9/Bx2gcnYR6SuG/Xppir6pwnV/nuZ6Unvd92
         QRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVlAb1nlnwMUT9ENbqmaXwTU9ISgXl4wbcvuVZUrWqM=;
        b=ZrdCa8lYF309/5BPT3kZ6YV5FTUz3UszmjRxdI4h4QI2uwDyTPsCHjMjbn8N831HnS
         PjzYz+PmoYGVsM16Yc8K/6yo/RRI55LXiIlCd2oLPYTJVJ745IYe19x8b6Oc7Axshotl
         LhBv2abI5AtAMFcf6WtzdShNIOBDS+zBiyOTVSRqF1yKSvdr0gzKBhMDde8OBni3UDHv
         ZCIEbaJBLqm69OEPQ6L+G4FVg2k/mj+pUhFa1q4oq94e74NPa74MRq/3lEizZt+8f0yx
         7ZoopnoXpeswHnIfLhk2mGCB0jjXQ05VvMlaAqyaHN7KbUN/09I/Sa2TgivkyZHiaTDp
         cEaQ==
X-Gm-Message-State: AHQUAuYF1KlxDpk64GNGbaCUQBBMke12XXSq19IZdKoYDQK91Qr3rw9Z
        1fFVm6XaYFUOvdLIVHqCDg+uga8o
X-Google-Smtp-Source: AHgI3IZI9hT1YxGFqKabzlVtYFwmgjtr0eN7na1fHp1BoR2Nsh28G7W1tcKJfxUPmohkOWi6brlT5g==
X-Received: by 2002:a2e:3319:: with SMTP id d25-v6mr11599810ljc.187.1550431362465;
        Sun, 17 Feb 2019 11:22:42 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id j14sm2916766lji.32.2019.02.17.11.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 11:22:41 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 2/2] dt-bindings: iio: chemical: pms7003: extend supported sensors list
Date:   Sun, 17 Feb 2019 20:22:13 +0100
Message-Id: <20190217192213.15803-3-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190217192213.15803-1-tduszyns@gmail.com>
References: <20190217192213.15803-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add other sensors to the compatible list.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../bindings/iio/chemical/plantower,pms7003.txt           | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
index 7b5f06f324c8..c52ea2126eaa 100644
--- a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
+++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
@@ -1,7 +1,13 @@
 * Plantower PMS7003 particulate matter sensor
 
 Required properties:
-- compatible: must be "plantower,pms7003"
+- compatible: must one of:
+   "plantower,pms1003"
+   "plantower,pms3003"
+   "plantower,pms5003"
+   "plantower,pms6003"
+   "plantower,pms7003"
+   "plantower,pmsa003"
 - vcc-supply: phandle to the regulator that provides power to the sensor
 
 Optional properties:
-- 
2.20.1

