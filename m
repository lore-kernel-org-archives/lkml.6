Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767C9C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D9E21473
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LcEikyD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D9E21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeLBCak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:30:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38329 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbeLBCaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:30:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so7977276wrw.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+uc0CQJwcttduqsonucjxD/sSZykRQ6+JEeGQ7Ro2M=;
        b=LcEikyD7iUx/vTbTyJ0cBln7RZQtesi+WRvDUMNmIoKwK9VfRbmjCWp6ZGEJDY/2iB
         qN/kDTHaGlPS7uN56YC8dfC3crP5wUMS+YLSMJI8Wa15ZKte9XcPOLXxUxvkfp7ZRCFT
         cn8BpXfUyPxkEUZsdf4pSjK7JB3iD4VDFWkhhh66kB6Ev1iDRJTaLsEPSxDylQA1vQTN
         4UEm2t8dSfH54jknGyuCp2u0PA5dZyaDPtpTX4Zg+qwfe8+gTWEhmmIb4ArjqG8amb7T
         3yVOGAj9ElO/+qOQ3qqO0LX0+cfzKlzmxd3QluAOiMYQEox4gJ4BZVAcmnW+AOSvFgoq
         GfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+uc0CQJwcttduqsonucjxD/sSZykRQ6+JEeGQ7Ro2M=;
        b=ClVwG2VzMZtV1BWz2pIKB0hZPOEjE8u6P96I3/xDX+3m8jub56zoxHmi3EYBLlzp8Y
         d+6c5Dt6UrnJr9t6RcVNnbCfICzyGOYpl0R4k69zV2wj96JhkeUE9fGSlxLmexZT8TIz
         dqqdgMB0m29YlOOTj0FFYpWm6ufJ75wWWxSTMXa7Q9o2bksP/3Frdh0NyxEUSaEgSPkM
         /YtyOSolzLScPpNAKrAsphNF/EoOPUa0RAT2mlIUvozgz6igX12tU1MnKNwWUgX8KnUL
         NP5eRpekGNsHBHBFixxqiGfeqR4GeBgNUkFvSlqlXASu6bidMopozKYt6wSV4hcyXpeA
         Uv+Q==
X-Gm-Message-State: AA+aEWYdq7vjvtJJtru2Jw/4nl6Hw1zRJ07Syfra1o9JNHTB5mj95glb
        aQ95dhYx982aORVy6M++EEVKDymAks+JbwQq
X-Google-Smtp-Source: AFSGD/VhTmlHV4gqJ1FLY4LR/Y7yODovB+xdiLX4KUzAz342eFm8IanP+104spVi7aygC+eCg6cCJg==
X-Received: by 2002:a5d:4dc8:: with SMTP id f8mr8641729wru.45.1543677474224;
        Sat, 01 Dec 2018 07:17:54 -0800 (PST)
Received: from localhost.localdomain ([104.207.76.73])
        by smtp.gmail.com with ESMTPSA id m4sm5712663wmi.3.2018.12.01.07.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 07:17:53 -0800 (PST)
From:   Carlo Caione <ccaione@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        khilman@baylibre.com
Cc:     Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH] MAINTAINERS: Remove myself from the list
Date:   Sat,  1 Dec 2018 15:17:49 +0000
Message-Id: <20181201151749.10932-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin is basically doing all the work. Remove my name as co-maintainer.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01645edc2388..63a2ad093524 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1297,7 +1297,6 @@ F:	include/dt-bindings/clock/gxbb*
 F:	Documentation/devicetree/bindings/clock/amlogic*
 
 ARM/Amlogic Meson SoC support
-M:	Carlo Caione <carlo@caione.org>
 M:	Kevin Hilman <khilman@baylibre.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-amlogic@lists.infradead.org
-- 
2.19.1

