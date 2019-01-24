Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463A4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E53217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3VELo6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfAXUNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:13:20 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40344 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfAXUNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:13:04 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so6409855ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zdw8UPVdfG3/Kwvp8nIa34/XhSgFhH0hqh0UmtcW3KY=;
        b=R3VELo6rgeKgEIMhDtY33kCtxayOTIBRDxjL4Fzuq+CYqFR7yBQU87UCBcRVbZdRml
         ocMp6TAFPtqlu87aWjv0mtq+YxLlw3z+heywLbG4YUUvzxgyTMh8ZWM4ZMoqfITR0jZd
         ep1+bUH5r4c9WnbBSPbg/kVnDbDlDE4Q2iyJGmI5WkSH4ESI0IcsQoXVNR+GNSQXegD0
         FUdDX3jafH4aSPZnGmjngFG6kl1tajkcXDBHjYbFhrkTC5+u3Em08VaNFY7DzGgw6MmV
         VldWQlpGO15tC0P2HXZdIq/yGAAhWJ7D45sg1kaYfDVDPhXvc6VflB0CFz+/p8p8hoQ6
         hlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zdw8UPVdfG3/Kwvp8nIa34/XhSgFhH0hqh0UmtcW3KY=;
        b=X24OnUzJs3u3u50OfFlBqwVCVwlQsICiRppdrInhEe7sMeg5Jz0KzCiKBn5u1c84os
         mcxDNVP/bj3tgc3QWNqYlleRaz2jMUP17Bk78uWiphPqLAGwXxWgxGRje86Iv0k5ei+o
         5+Jzi81umF4SfxlpWjDQGkOZPQE0luKmPzxVi0bCY8JgEbRRcjGY03TaxlkNgCaPtOya
         FYOnDn5l+geGxsCOYhslbv1qkjJ1LFzZn4e1GMd7c0KkoX8Y7+8I0/L/LpT64exn3n73
         fAxZBOUH5Sh/dHjoC52THkezpb9ci8Df03sX80SMcn9Cnpff4vBziH2WCa6GT/ySKn5g
         4tew==
X-Gm-Message-State: AJcUukd4ScAqb3vTjsKM+yLMdJial9DYiFAUXTHk7qobtGnKqXX1Qdyj
        NF9IHI8NcfyDEoUclWu0G3g=
X-Google-Smtp-Source: ALg8bN5Pw4UUV42cE7XbjW5loDlqzRRL+FI3rdpWHYcmu9JaHNyoMR9ZupSDrBMuLiOgJvXLjUYcUw==
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr2441201itk.70.1548360783468;
        Thu, 24 Jan 2019 12:13:03 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id 79sm12417456itx.11.2019.01.24.12.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:13:02 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 5/6] dt-bindings: Add vendor prefix for arcx / Archronix
Date:   Thu, 24 Jan 2019 15:12:50 -0500
Message-Id: <20190124201251.15159-6-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190124201251.15159-1-TheSven73@googlemail.com>
References: <20190124201251.15159-1-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

arcx Inc. is an engineering company which provides advanced
embedded systems and consulting services.

Archronix is a technology design and product engineering firm
specializing in hardware control systems and enabling software.
Clients include OEM's in the transportation, aerospace,
medical and commercial sectors.

Websites:
	http://www.arcx.com/
	http://www.archronix.com/

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..7c84df526018 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -35,6 +35,7 @@ aptina	Aptina Imaging
 arasan	Arasan Chip Systems
 archermind ArcherMind Technology (Nanjing) Co., Ltd.
 arctic	Arctic Sand
+arcx	arcx Inc. / Archronix Inc.
 aries	Aries Embedded GmbH
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
-- 
2.17.1

