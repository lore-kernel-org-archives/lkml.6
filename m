Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id p4+5FcqGHluQNgAAmS7hNA
	; Mon, 11 Jun 2018 14:27:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 40007607A4; Mon, 11 Jun 2018 14:27:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFwp1g+A"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B466160791;
	Mon, 11 Jun 2018 14:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B466160791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934443AbeFKO1U (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:27:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35789 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933209AbeFKO1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:27:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id j15-v6so16999402wme.0;
        Mon, 11 Jun 2018 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IvkqSysyFqt2EdmJr2l36YgrF3ue78Jl3q9X5FhPBbo=;
        b=PFwp1g+AHpplIq2tKG2yI/HCgTBa3HwbXz/6YrB8IVcvHh1AO9QkVD2J4mXBtDMi3N
         mkFH0gurE/vGy0VVgh0TweLjzG2133Rlh2yXs3DF+RynRCM883OqOO6aH2nAywAKzoDI
         4xSuDVF+8pnHxSn4S6LufH62k/rsPEKt+47FjRtySHihFkdht1yOIlQkA1w+qCu1PTzF
         wkl1R7QFGuyeZSBlqufZCm1QqWLVKaKqGecICbbIGU5zdS6d8HtjziTz9PWcQN7iNFc5
         y2ga9DNBm01+JLtHMc/KeT9RO5nvzSjqPks2N4zIL7hvBCkf6CMnQm8mp0UDhQUvYcwA
         AFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IvkqSysyFqt2EdmJr2l36YgrF3ue78Jl3q9X5FhPBbo=;
        b=pOrQpXOhxO6wYjTQyCm6FazOEbLoEzmjy7KvBa1P2OBIMTSrxBTZGEtRbK2DQnNNQw
         t8iF88eUraz7w7217TyVRDbpmdAAYFkA3nb8FECdrN112E3aJaH8SOQzRJRnrvzaWbR4
         TAmvn31ck7nr/y7tfGabrNP/rocAJ1UzB2ZOmLMJP3fgfUUb5WeKBpwcjJtsZ0hCbZEz
         7ttebAo3rwncFssByJ6CidZCa9m9h5jUFQHXDn0+hp6KoMDx/Scnp+MSD950rhqPz7PA
         GpgyxAhG++a3AJn7E1h+uSWTfG8iFbzmiO4G66HfxYbJHVvRY1/yhAhqyRhgPngSLSBb
         m+zw==
X-Gm-Message-State: APt69E1KzzFnkH9Vu8ia4Qoh/8c6dXRrReRjKegbx0jQGenB7m2bgkJo
        v1UIUU9uig5yTtX+84KQsbs=
X-Google-Smtp-Source: ADUXVKIu37cfIiS4AibS82vcurCJJ3IPE9/YaHbXykBP63BHDbKfQvCnfVTv8ve0ObQ5s/qmaxKNcw==
X-Received: by 2002:a1c:540c:: with SMTP id i12-v6mr8674748wmb.131.1528727235439;
        Mon, 11 Jun 2018 07:27:15 -0700 (PDT)
Received: from localhost.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id s2-v6sm42689387wrn.75.2018.06.11.07.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 07:27:14 -0700 (PDT)
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
To: davem@davemloft.net
Cc: tobin@apporbit.com, Andrea Greco <a.greco@4sigma.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arcnet: com20020: bindings for smsc com20020
Date: Mon, 11 Jun 2018 16:27:01 +0200
Message-Id: <20180611142705.20849-1-andrea.greco.gapmilano@gmail.com>
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
