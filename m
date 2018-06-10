Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NO4vMjcyHVsDNwAAmS7hNA
	; Sun, 10 Jun 2018 14:16:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 98A26607A4; Sun, 10 Jun 2018 14:16:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnWAJsvR"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 230A76074D;
	Sun, 10 Jun 2018 14:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 230A76074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbeFJOQX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 10:16:23 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43662 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753671AbeFJOQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 10:16:21 -0400
Received: by mail-lf0-f68.google.com with SMTP id n15-v6so26701732lfn.10;
        Sun, 10 Jun 2018 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+jRrk3v/ZhzVrxb7TQ2GkxIBsjVoZVhqkGGdLt1XhA=;
        b=DnWAJsvRCLwK8z3lahtlHm0tlb9Zqgq2InK7KoQjx2Oi+PIpcZMhR/ukyxLLORJb2t
         gECZvMVQHVEdaSP9qO1UPd5a5e26JkvFAcSno4Ru5fmY28IOSWyEzkDbmAIa/5ZmvKFi
         8VjqRgHqUi7ONDhaj0VZ5fpqpVucddCkdwSgt08c3qKUWnXVmX9po9E3EmC1i7NeSZT9
         5WJse7Fs8N3hyR7yPMcsEGhWJbVv7Zv78eKAeLkxpnnR+qeWg1HjRHB2asQUAHwSo6R4
         PWgz0k87yuJn3imWOMAbRKKqF4QCksgDpiyg6sexV5QeWKtRvrY1y2wYzJjPfHelsnz5
         w8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+jRrk3v/ZhzVrxb7TQ2GkxIBsjVoZVhqkGGdLt1XhA=;
        b=YxgwPzCuDYuALvmlwBjKopBdD/eSInAMdsoXNoQ/m4V8CGuO22TeBT0lqWYKRUAgrk
         3Mug+RUJMBjMRVmPtMqqElmQm4ZBaLxulHbvUsoafiHSGC9rmqMW4B4/h1sb4EHiEGy/
         5t+rqYnjpKqksvGB5fPoV1x+izUtwRUdkmXVtdAGX5uQ7O7q33KGv/SddPxULYJMd3J2
         wGO+Y0OVXev3/7pZ0P9n9pywhs5TZO4NPQQwbu42fMzmtHKGeNskQQzMaV37joR563Qo
         JdmEenzvooKyk/brV7HkeT7YqFEYmKCjkElwdd5E7K3H8ZwoDNuHZGH6zhRifXPX7xEz
         pDrw==
X-Gm-Message-State: APt69E0cUwkkLN85ES2rKM+Xp5qp4qqa9pt9yx6QL2qplo++jGuBB2Ck
        pQIebqFg71MR/sJevKC4XVs=
X-Google-Smtp-Source: ADUXVKLcFRwOrlmpIPKlCMG5EKqPfGymrTDGOoG5T60hlSPr7Ifrb6pl61JTiTmuc50PesK7ijTP9Q==
X-Received: by 2002:a2e:cf:: with SMTP id e76-v6mr9178046lji.82.1528640179957;
        Sun, 10 Jun 2018 07:16:19 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-173-75.play-internet.pl. [94.254.173.75])
        by smtp.googlemail.com with ESMTPSA id t12-v6sm1769243ljb.7.2018.06.10.07.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Jun 2018 07:16:19 -0700 (PDT)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 1/1] ARM: dts: s5pv210: Add missing interrupt-controller property to gph2
Date: Sun, 10 Jun 2018 16:15:49 +0200
Message-Id: <1528640149-2195-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds missing interrupt-controller property to gph2 block,
to silence following warnings during build
  /soc/pinctrl@e0200000/gph2: Missing interrupt-controller or interrupt-map property

Observed on not yet mainlined, an S5PV210 based
Samsung Galaxy S (i9000) phone.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index 3a79feab11c3..7f0c9d447871 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -258,6 +258,8 @@
 	gph2: gph2 {
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-- 
2.7.4
