Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E283CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A951B214C1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Inwj2dY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A951B214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeJEWhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:37:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33445 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbeJEWhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:37:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id z21-v6so12009647ljz.0;
        Fri, 05 Oct 2018 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZCf33qrb2hqSKhelVYfNZnVvCL42nB6oHuNJ9Gt3DlY=;
        b=Inwj2dY8vBnJ7AB0yZfh5SuMkvaxZSJxN35QsgmULFycrWqf/+fh7/DObQj390h6/p
         MeI4pw+Co65EXAdyRDktVyTbYB7f8u12/LvejFpKbSpACJZHydYPV2qj7SrYoAIqln20
         I7zl6bv/pOFZK6AD+0WYh+VNuF2bMLH+/SGRET3oHL8NogUZGIeSywa+/5E0IPgavcFr
         cQpjGSfVq4dUW636yICoB+2wfJ/KbD54w2KGnuoXl30oVD0Loy6hB1zeFOwazOVgHogs
         HBq7WudpYZoYAzEwFBxF0mtflnshR9WW1rYlXOzLVwg0elwCa99YCLJ4Co0sMeuSRSd8
         iIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZCf33qrb2hqSKhelVYfNZnVvCL42nB6oHuNJ9Gt3DlY=;
        b=d6uOLHLQ4aNcuYmLmKhs6bBsV8fFKCwQTCqZerwzE3VRbIZ5VYXe/73hJatknMQ1J+
         9xlNTDJ1A6kWCGvABbSNrviyoS75m+NqO8iAbFDwRJ5ADQ8Un+gHU1Icb3iCbEygXwPP
         lw9AUDpiN2rN5ZL06O5DNviafKSKPQZGRz9k71AqWkBjXIeFweebuSBF0s819lYZutJm
         oNvZnyGUDQ1oESzIrrzvyJIKu9eaUnN4/wy+jhrI4qWzzx2pzKYiTEUfEF0lBTmBUd5R
         7kFm8uqta83wgcQ5+9vGECSv7xLzeMFKDpmkfApPDXVZyElkYemaVqohVELdsJghKPrF
         RN0Q==
X-Gm-Message-State: ABuFfojPuUr1O8O/Wvcghv2HeK53OSk0zn6nkqQ1sYTdizvoGxpgxIAf
        btGbjOCiuJpe+PaabK7HvF8=
X-Google-Smtp-Source: ACcGV62LLdVf2OiI+pv6on5I3HDCTFZPqb9sYIy8ScFrhBNYyUv1v16dLXXLRpG46LGEWHCB7BZvFw==
X-Received: by 2002:a2e:9549:: with SMTP id t9-v6mr7667499ljh.94.1538753880575;
        Fri, 05 Oct 2018 08:38:00 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1879373lfd.72.2018.10.05.08.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:37:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v1 06/11] regulator: core: Limit regulators coupling to a single couple
Date:   Fri,  5 Oct 2018 18:36:33 +0300
Message-Id: <20181005153638.1886-7-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree binding was changed in a way that now max-spread values must
be defied per regulator pair. Limit number of pairs in order to adapt to
the new binding without changing regulators code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/regulator/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index a9c030192147..a05d37d0efa1 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -15,7 +15,7 @@
 #ifndef __LINUX_REGULATOR_DRIVER_H_
 #define __LINUX_REGULATOR_DRIVER_H_
 
-#define MAX_COUPLED		4
+#define MAX_COUPLED		2
 
 #include <linux/device.h>
 #include <linux/notifier.h>
-- 
2.19.0

