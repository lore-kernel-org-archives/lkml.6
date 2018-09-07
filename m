Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAB8C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686A52075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686A52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeIGXum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:50:42 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:49794 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725963AbeIGXum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:50:42 -0400
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w87J8NNE031744
        for <linux-kernel@vger.kernel.org>; Fri, 7 Sep 2018 15:08:23 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w87J8Iqu026411
        for <linux-kernel@vger.kernel.org>; Fri, 7 Sep 2018 15:08:23 -0400
Received: by mail-qk1-f197.google.com with SMTP id a70-v6so11367827qkb.16
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:date:message-id;
        bh=BaBiwh/BFED1yeqOiVlMc0LmGrtmCNlaQ8bMvOxfFdo=;
        b=KZiXsNTgF0Q1OZJZQdBl7H87jpa54sr5k5W9lCMzn2Fx/cz9EJozjv6XqzE1Wei2EE
         i/KH19vwxn4NWCIzliEiF1+nDtNAzl5wpcJVk9MoQcmCXw/Kp5nBqD9TX1b/8lq4QUfR
         Ox/LkUi4KRAW0njjljDZ+SF2cyk+DE8XUj64Rqbs6Xha7oROGZLezKk9QhCgIZ+dZ/q1
         tIkmPo0dOJQm7Y5w7e9sf9Sv+0f3CxzZplYOQZ3WcgCDkX5M4qcyhffmUP4eZH9l5KcX
         Fe+4QUMkDHHjq5hBJ/B279nqSH3QOjvrBSyq9QKn3RGdckfcUzLHZtMaleNHpeVHLowp
         Pp+w==
X-Gm-Message-State: APzg51DsmVzAa3t6j05jJwnzoDgoepQznVfDtk8BaK+SJ69OubYrw4ti
        UnJ/ilLDqIxoFcKltsmVh2WjpzCC0hB7SA7WU5D02CoB21hipyHTEdQ7NcJA5UenT+xn3hMeYhV
        KnYWiSc+f7F8/RqL378vrUn799cscOYayd7k=
X-Received: by 2002:ac8:42cf:: with SMTP id g15-v6mr7189085qtm.162.1536347297285;
        Fri, 07 Sep 2018 12:08:17 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdY2YEmwGJCYBBk7rLDkRgNyg4P/+GFCclHw2VAIe4pLm5fdv8adAwiQCFbc4L99BD5nc6BqSw==
X-Received: by 2002:ac8:42cf:: with SMTP id g15-v6mr7189012qtm.162.1536347295951;
        Fri, 07 Sep 2018 12:08:15 -0700 (PDT)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4647529qkk.7.2018.09.07.12.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 12:08:14 -0700 (PDT)
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: another missing 'select' in Kconfig
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 07 Sep 2018 15:08:13 -0400
Message-ID: <30971.1536347293@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b40b15e1521f7764ea8c68d5a00ecc971b673d21
Author: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Tue Jul 31 10:09:19 2018 +0200

    mt76: add usb support to mt76 layer

add a new mt76-usb.c for MT76x2U USB devices, but failed to wire
it up for MT76x0U USB devices.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index 6a270e759006..cec977b81305 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -17,6 +17,7 @@ config MT76x2_COMMON
 config MT76x0U
 	tristate "MediaTek MT76x0U (USB) support"
 	select MT76_CORE
+	select MT76_USB
 	depends on MAC80211
 	depends on USB
 	select MT76x02_LIB


