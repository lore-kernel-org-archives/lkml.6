Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634AAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143302089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ6N5s/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143302089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933825AbeGJOrZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:47:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35487 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933256AbeGJOrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:47:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so16766933edi.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eWOgQ3u6RP53EHKuTFjvNMyHDdixqLbI5tkfhxNWOEM=;
        b=VJ6N5s/+NOn9NmyP2wkED1Pewq8cXUfAXh0sIVZ9oFzybLgtIW/HRvEqUXY5o6MtRw
         Z9YGKBGd/qTQ2LymJeE1GLwBE7hUNO3QF030FfF2wUV7Nwuus7sQ9yKe0R9LkuhURPnZ
         bgMrVSiaIJl7GADykKHQLeJSQIIOapHzoOL/gnEqo/W6umkIoStkjfms4r1c0lUOkFqz
         3ktu4ZWEL1+ZAQhmwTOy16Lpvn1Mb4yPc0isXGx+3sc/xri8BoFAWUPjxTqFtfA7tjpK
         ErXbg7SjGrS4m1gHr5OlBYte3HgvJGHkwrtaI7Z0M/Z7zwbPXfYFJGQ9gjoJefzox8tz
         vcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eWOgQ3u6RP53EHKuTFjvNMyHDdixqLbI5tkfhxNWOEM=;
        b=HC/VOXjz/4N1eA3//RXnHPeZKqq0CL/UeCs6Wo98LFCoEo3DiV9/fRNhms06inRtMZ
         IPATfzAigkh8fPOwxWbV3atA0RMcXORslki08naBV1y96WGf183EyEyr9YBikedGU3lL
         g44oDsEZZBsQ8nx7ccayp1FpiofitUSe2pUDMfm3Fz/OBNY5T1DJ5np1sovX0NVzFQzN
         Wb/dtollxVqvqp8NPSr7VPjf7NyBd2a/l+F/RRaZTIxosCoc2kDj6FhvNMcDWyBmBCfa
         Mzaxgyi0IHGv4KK3JPeXGVLP3sR38vMKtAqONiV9y9KMCXg+PQ6YCcmqS438xqMVKidL
         BMRQ==
X-Gm-Message-State: APt69E0t1LW/vkuC4xa9Rhm+g8o084VVdsg7cmsXbrZow/OvLqDslDSk
        DEIudFxQhsGv6F7Z/SgrY80=
X-Google-Smtp-Source: AAOMgpfQ88o9VX8QCe6MEKFh+GYH4UJ25cJYdKSXdAjL0Oob6+PSRnW7qDqYyD2WyCwHmg6Tbe9wbA==
X-Received: by 2002:a50:fb91:: with SMTP id e17-v6mr27959357edq.308.1531234042847;
        Tue, 10 Jul 2018 07:47:22 -0700 (PDT)
Received: from freedom7.home ([2a02:121e:38ef:0:811f:2ca4:747d:afd])
        by smtp.gmail.com with ESMTPSA id g9-v6sm6292433edq.34.2018.07.10.07.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 07:47:22 -0700 (PDT)
From:   Peter Senna Tschudin <peter.senna@gmail.com>
To:     davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        martin.donnelly@ge.com, martyn.welch@collabora.co.uk
Cc:     Peter Senna Tschudin <peter.senna@gmail.com>
Subject: [PATCH] MAINTAINERS: Update E-mail address
Date:   Tue, 10 Jul 2018 16:47:02 +0200
Message-Id: <20180710144702.1308-1-peter.senna@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my E-mail address on MAINTAINERS file.

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a29d10f25e27..3204ea8c2a8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9133,7 +9133,7 @@ S:	Maintained
 F:	drivers/usb/mtu3/
 
 MEGACHIPS STDPXXXX-GE-B850V3-FW LVDS/DP++ BRIDGES
-M:	Peter Senna Tschudin <peter.senna@collabora.com>
+M:	Peter Senna Tschudin <peter.senna@gmail.com>
 M:	Martin Donnelly <martin.donnelly@ge.com>
 M:	Martyn Welch <martyn.welch@collabora.co.uk>
 S:	Maintained
-- 
2.17.1

