Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCC0C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5BD208B6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfOhgw9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5BD208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934702AbeGFSfA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:35:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42834 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934410AbeGFSdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:33:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id 1-v6so9795230ljv.9;
        Fri, 06 Jul 2018 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLEK8xZtvtMV86QkS7VyX9ir6Qn72Y5mJ1xdkDdSc1w=;
        b=hfOhgw9IQ8HVJVsnSlQdG0CCmZtbMz+YODF2XA5FsONv091lYBtoCfg65zhrSSomKH
         VkoS2lbQJ4EFC/iJKG1zuPRuwaFVxLUTSyZE8L4yWnXb2wWv3jwXnzTB1HVSBvaGHnQY
         5kTZAkA0uKe/83cn2aO244m7wLEBlZ3sJU/Jy5wEq+VGqZgg0rqZtxuSCPnI1EPy0XPC
         w9Ba87GNMILzZ9eH+cEr0hvXYXvedEORZdUDNdpBTPz+pXmAIQth8hn97nkjsl8IV/fr
         /UWtnbWk5FlJHjQMpY7TqZ14PnbyxUSpLZ/+MehYyzmjatqsvzrpnu1dJCyK0MDvk4Tj
         gJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLEK8xZtvtMV86QkS7VyX9ir6Qn72Y5mJ1xdkDdSc1w=;
        b=Os6CRWxERnhEzQEu9I0g5qmIXz2TIfm6KxxSN6ij/ejjTS3YFhbs5GK7recWPBmsdK
         BFIPsxl491wq/bGOaxTRGwcHLwId/XaEX8tj9KrxkN5Nv3nA2v7tcfN2D7hbFs/8SX3e
         2nbIJrB6s37gyeeVQLUAauc86ZTUAmtQ/Qe59fsajFNR+FT9UdvfcprmK1kiJKE5bQSv
         5yX3JiXMqLPua+z+cwsVHD6ZLnwAQr+lwzleZheGYec1XE5bjRmZnLpFXCjuNaG3ttNJ
         3Kp7lFcRaaUFlyAZRW/P5pfq5umlEGenWATDZ2eCgQYR1jigxUKad+qAsEfiYnz7zo2K
         Ezyg==
X-Gm-Message-State: APt69E1Yg9GF6j2rdsbmGUHbAHlo41Vt8d6R57dP2t2XKuYaTGHm9bOy
        l9x9VIvYwqrtaUSzgnsZHY8=
X-Google-Smtp-Source: AAOMgpcZRmwBB3/yDzT5FBJ+wXLzS1Mx3e/iu9J/rjNCG5hm4hVfYEN3XUpSKUtCra3tWcGzH8v8fQ==
X-Received: by 2002:a2e:2ac3:: with SMTP id q186-v6mr6985936ljq.123.1530902009578;
        Fri, 06 Jul 2018 11:33:29 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id l82-v6sm2314697lfb.8.2018.07.06.11.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 11:33:28 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v3 5/9] dt-bindings: samsung: Document bindings for Samsung aries boards
Date:   Fri,  6 Jul 2018 20:32:46 +0200
Message-Id: <1530901970-14972-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the binding for Samsung Galaxy S (i9000) phone
and whole Samsung Aries devices family (based on S5PV210).

Also because this is first not Exynos-based devices, document this information
at beginning of file.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
--
Changes from v2:
  - Squashed with patch which was documenting existence
    of non Exynos-based boards
  - Added reviewed-by

Changes from v1:
  - Added missing commit msg.
--
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 14510b215480..3fa287a86300 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -1,7 +1,9 @@
-* Samsung's Exynos SoC based boards
+* Samsung's Exynos and S5P SoC based boards
 
 Required root node properties:
     - compatible = should be one or more of the following.
+	- "samsung,aries"	- for S5PV210-based Samsung Aries board.
+	- "samsung,galaxys"	- for S5PV210-based Samsung Galaxy S (i9000)  board.
 	- "samsung,artik5"	- for Exynos3250-based Samsung ARTIK5 module.
 	- "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eval board.
 	- "samsung,monk"	- for Exynos3250-based Samsung Simband board.
-- 
2.7.4

