Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yxVEKtyGHltiOAAAmS7hNA
	; Mon, 11 Jun 2018 14:29:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C1781607A4; Mon, 11 Jun 2018 14:29:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtjUc+Vy"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3BC0D60541;
	Mon, 11 Jun 2018 14:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3BC0D60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934642AbeFKO3I (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:29:08 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43780 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933173AbeFKO3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:29:05 -0400
Received: by mail-wr0-f195.google.com with SMTP id d2-v6so20621951wrm.10;
        Mon, 11 Jun 2018 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IvkqSysyFqt2EdmJr2l36YgrF3ue78Jl3q9X5FhPBbo=;
        b=mtjUc+Vy341hZCr9GRzHuqqwBy/vTDSqP5WS0tj1jpPWo6QmkLcn5ic8REYMRMzrPl
         yrYEtTTMzej8LcvkmIdDg+mpaFdn1NkICz22tmBRHGMJH6u0uj0FI4Fb32D02yHTxnsG
         4LbKlAtzpmhFZA+Is+BwWR+Zbfv5zpt7PMEGvNXSjaqc9V+7HZH0+0N2oFC2aqQLqY+j
         f7wzXprrCXDQ/T6B0GuCArII4R1IGB4Y/McOF+oxbvPXxk6ylRP4uFsuJaI4cY0Y4ioa
         kMjjx4x973Nd6Gfte39p75h3uDLLBvg+lcpNFrRCyq9CrGLNIcYCNThnFxH6AA00ouIZ
         7QHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IvkqSysyFqt2EdmJr2l36YgrF3ue78Jl3q9X5FhPBbo=;
        b=pwIh5G7/ILAEVmIxQSHbO7b3gT7KbYi/VXiFmSpCc4m9RaEbVABnUzZSUIuLnuxNAu
         RqmYTG5YqvmLDst4GND9Snggsna7HyvDQc99Awnk5RudMocN2buGY1yGFIGqpamdUEW8
         ApZa6bSCu4clfzjBbhmwSJnhzHww18a6olGu+11Q9lDDUHlkuPkl7toNvtO/2fVvUqIt
         cf5RhLA+yTrNOf4tKwby6Uq5vBotCE1GXhAOEi7uoxOXV7Hu/hHiB1qCtHNKZIWaw2bT
         fjWF3L/MeNEr3FUQrIlPJSc+RnwdsFNhGn702kNborKtEBWLDxweiaY6Ft01torFesa5
         L2XA==
X-Gm-Message-State: APt69E03Rp670CaMsd2oxLlGrYOl/mMZDDeSIb99xSZ0W44KWTiKQgDu
        CBj6+5m6Ud7/KihPzUbV8BQ=
X-Google-Smtp-Source: ADUXVKKS2W6v2iZNKPpvE+JByYfFDzcA7qj5IF88B1fGpTzNKqFXFICQO7h+U36gT1I9/bJkjaMhAA==
X-Received: by 2002:adf:deca:: with SMTP id i10-v6mr13737519wrn.37.1528727344128;
        Mon, 11 Jun 2018 07:29:04 -0700 (PDT)
Received: from localhost.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id b74-v6sm15770726wmi.13.2018.06.11.07.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 07:29:02 -0700 (PDT)
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
To: davem@davemloft.net
Cc: tobin@apporbit.com, Andrea Greco <a.greco@4sigma.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arcnet: com20020: bindings for smsc com20020
Date: Mon, 11 Jun 2018 16:28:53 +0200
Message-Id: <20180611142856.21307-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Greco <a.greco@4sigma.it>

Add devicetree bindings for smsc com20020

Signed-off-by: Andrea Greco <a.greco@4sigma.it>
---
 .../devicetree/bindings/net/smsc-com20020.txt       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/smsc-com20020.txt

diff --git a/Documentation/devicetree/bindings/net/smsc-com20020.txt b/Documentation/devicetree/bindings/net/smsc-com20020.txt
new file mode 100644
index 000000000000..660a4a751f29
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/smsc-com20020.txt
@@ -0,0 +1,21 @@
+SMSC com20020 Arcnet network controller
+
+Required property:
+- timeout-ns: Arcnet bus timeout, Idle Time (328000 - 20500)
+- bus-speed-bps: Arcnet bus speed (10000000 - 156250)
+- smsc,xtal-mhz: External oscillator frequency
+- smsc,backplane-enabled: Controller use backplane mode
+- reset-gpios: Chip reset pin
+- interrupts: Should contain controller interrupt
+
+arcnet@28000000 {
+	compatible = "smsc,com20020";
+
+	timeout-ns = <20500>;
+	bus-speed-hz = <10000000>;
+	smsc,xtal-mhz = <20>;
+	smsc,backplane-enabled;
+
+	reset-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
+	interrupts = <&gpio2 10 GPIO_ACTIVE_LOW>;
+};
-- 
2.14.4
