Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4E5C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A899F2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+tRs3nR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfBAV6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:58:40 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44643 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfBAV6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:58:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so6158350lfe.11;
        Fri, 01 Feb 2019 13:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4K07+PMA9omMHyycWXsghoi13jqHOsNkg22kq8mIMI=;
        b=i+tRs3nRuY/ZGSjgH98LxtrzwFu9e4OyRul5zXQYR3eDWX7KyaqIW00StJ9lXFMq3E
         0EO6X/9T7aWP5Z2T/1QAS3g06PfBSfLYaDURqmu3qhv7tsoM1QhGOq7r3+l5n1bT8M9s
         vx/dktgr+Jw3iW1o/BOl+IMLLFCf71ydDN0kEXQNTBUMr5GQxZPftoSwEhr6d+/KQbmO
         RSFvw7dL6VbwnqFLeKcid2QZywagE2lsW0GUTzwOPSzeLVmkMH+/sGMcFWLsNAEz+uCT
         binYMJinUS/9KsS8b4RJojClaDZYS19YVyWiG/4lBuJtKaenlxLAP3QoR7SR6u2+7AvF
         eyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4K07+PMA9omMHyycWXsghoi13jqHOsNkg22kq8mIMI=;
        b=P0Bd7rW4LkURl44f0KmXQD4r9uQO4QvBibH873LOoeppcv2nW3ona5INorVwF79MHF
         Sc0y31iEQyj5aOtFUgiVynl+C8AgOuDWS/rGCqF2VwrjqdQtIK/a6ncqVDA8a9oVyPiN
         NQXAJNYVNtOYfqHkT9h45vbR+Yc1edE4GRDTBI8MGMzy95LkxuHfAfCf8NNHHiCG6YGi
         TUIIQTyvdJbkejZ8k7odkff90tNMH6ZAxpzA4te1zW8yr9sGkzhclbeLdrT39LPu2+CF
         XeSIVsQ4rtyWLJ3LMbocJnMy/m4E8oxlETQBbeP2HLtK43YGfXRhfWTEaGlwH2oNrb0x
         fw4w==
X-Gm-Message-State: AJcUukfytGkdyT3h/vuJ5Wyj84X4rjBPZLeQ44IAFlvgUbptFd0tx1bB
        WjZL5nCzl3OSTc45vhNYjDniJKU9MQc=
X-Google-Smtp-Source: ALg8bN6Y7YWDooKbPztllH89n7v5JIpX+Omd/U5lN1rpSlMg8Mx3kaQ4Mchor/suYZS1R6wj3Kc3xw==
X-Received: by 2002:a19:db54:: with SMTP id s81mr33689510lfg.102.1549058315379;
        Fri, 01 Feb 2019 13:58:35 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id s20sm1567630lfb.51.2019.02.01.13.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 13:58:34 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk, pmeerw@pmeerw.net,
        johan@kernel.org, Tomasz Duszynski <tduszyns@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: add Plantower to the vendor prefixes
Date:   Fri,  1 Feb 2019 22:57:58 +0100
Message-Id: <20190201215759.14569-3-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201215759.14569-1-tduszyns@gmail.com>
References: <20190201215759.14569-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Plantower to the vendor prefixes.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 3cfe0c8b8250..fa391a650f3a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -300,6 +300,7 @@ phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
 pine64	Pine64
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
+plantower Plantower Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
 plx	Broadcom Corporation (formerly PLX Technology)
-- 
2.20.1

