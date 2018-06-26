Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAB9C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607552677A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="juEHu1rD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607552677A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933753AbeFZJW3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:22:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38359 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933473AbeFZJW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:22:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so993732wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j878xcA2GRojyrOxkE9HR8+aKidYc9OUFiOMcCW6g3Q=;
        b=juEHu1rD6OC3FIhFVS6xJMhpqMoTbOP77J8VKOwW3tl1ivAuD9FoRg2kvq6gXpsfjx
         UNgIbSBJFctSBah2/AVGl3zGNw1US9B+jcHDoOXPrcHGSEw3rNEQK3ak4lUa2+3FMerv
         TCdQv093ejZBuF3WWxkounE1zrL/NiZ9dDWAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j878xcA2GRojyrOxkE9HR8+aKidYc9OUFiOMcCW6g3Q=;
        b=I1TPHvClZ4jPlkrN9fQjINaNOkthNqW3H+HPW+s2gWDGJhIBJoevd4i9EYLeK+0wmR
         vVlTw9G/wy0mwmV6x6e/nL6Vm+lQgi5fiLjJtJHyN+AwFuGFDR53Eu+zsbsVWm/nGQUZ
         7rXTMR0ML0U9N9ebmcLUu61lwu/F8T3QKDhXUNokFCGEN6SggYF556aKPIcdffkhw5vZ
         QqVQ4hN1IB9QNtw8rzVc4w1w9ATMIYZ7UDrDWUpEqWRoHisHrIZ+TfSMgNxv4AaVN7q8
         3kO2Kq2C7RRMBoBtOaJE1kPZZJKvlB0yRt9Fek95DLelWnH7Ga11wSstzcZR/tL9FAAT
         Q4XQ==
X-Gm-Message-State: APt69E3NyXc+4et6IMRDnQ3KaKkOZcZD4/YeZYX+J7qakF9awJoLkLOJ
        k1ir4qlpEqRBSSBk8AvJaa/urw==
X-Google-Smtp-Source: AAOMgpcBLoQ+j2ckd6VV2/LshlEVLtF2RqKQNDGaW6bvkpKzN0cCb8cLaE4cMNxf74mcvQsfBOur1w==
X-Received: by 2002:a1c:7506:: with SMTP id o6-v6mr942371wmc.60.1530004944031;
        Tue, 26 Jun 2018 02:22:24 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1438456wrr.3.2018.06.26.02.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 02:22:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 01/12] ASoC: q6adm: dt-bindings: add compatible string to routing
Date:   Tue, 26 Jun 2018 10:20:05 +0100
Message-Id: <20180626092016.9296-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string to routing so that it can support DT based module
autoloading.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,q6adm.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
index cb709e5dbc44..bbae426cdfb1 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
@@ -18,6 +18,11 @@ used by the apr service device.
 = ADM routing
 "routing" subnode of the ADM node represents adm routing specific configuration
 
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6adm-routing".
+
 - #sound-dai-cells
 	Usage: required
 	Value type: <u32>
@@ -28,6 +33,7 @@ q6adm@8 {
 	compatible = "qcom,q6adm";
 	reg = <APR_SVC_ADM>;
 	q6routing: routing {
+		compatible = "qcom,q6adm-routing";
 		#sound-dai-cells = <0>;
 	};
 };
-- 
2.16.2

