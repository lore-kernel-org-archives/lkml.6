Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCF6C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D8324E7E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbYQq6+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D8324E7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeFXJ6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 05:58:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33312 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbeFXJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 05:58:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so9885297wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rp5kBGz2JQ0AA5DGZ0Foha2HOV4O5QryOzcXsCU30mk=;
        b=PbYQq6+toIPFsfeuz1epmjS6+7kQtFd5WZ2oZ1jdKjsUOr7x/y10G+CuF9amiSVSwQ
         OlLfoIIBsUMVtrxo4i4VBRi65vJu5HGbUNg3MnONnH3IkHqYy+YXTi1ZvH+nJ/36XTPQ
         aUQHlhOiPNHaIL3UleTYGapW6st4QVKXf/rO87CnQGhN2DzPJrwMVmtpjqs5IgHWIccb
         nI8iuGe4C6AfYR7vzc8dFelAweCeKXVwmZKQel6TQVICkPkyaT13TLULqTwnF6iRarfQ
         dsf76qpZsGDVpmOaKUoe7nN6iU4worYLNnlB74yJZkogTxtUajcLc1MivAHaeJraGlnr
         iZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rp5kBGz2JQ0AA5DGZ0Foha2HOV4O5QryOzcXsCU30mk=;
        b=cAS1qOgJX9Bc/jq0wQXz0snvpzt3ESjmH25KtwS8EfkiJEHD2iIphGrG6v5giMlykX
         IQ7ADM5Ynl6hjqc2szg8WpOiiecPAF5SYAQVi2WioK8Fflxm4Akfida4FkQCX4JZ+bC0
         /5iDkuEBOTiLTIYvi7QR34UIanEYgn03hYnMqVwITvOiw4uTP0WewGJdeHGVBeaknJhK
         IjLXBrxmuaoLxhyRep6NLRwcCZvjbNod8jGnbx6UgiYjJ5BmDWmoM8/Y5ercCJ4omBoI
         xwo9js2aKQ0ycadLiTSAbcXGAVzmR88fZhttScwIuL9rT5gZ3scgRYZFmVofmio2XJfX
         eQfA==
X-Gm-Message-State: APt69E0wWAOX+2t26nRPSPOIyuOHet1/TX/1tlE98513ke8ny1DmMr7E
        /GmWCn31O6N7WP8PdHMiF8T70w==
X-Google-Smtp-Source: ADUXVKLtdjUa25rtLcZXpt1XxTFxISaznh4jjvfD0bIq9Jtr6rMb5FsSmT8yefpZgQtTHD+uCyuBAA==
X-Received: by 2002:a1c:9788:: with SMTP id z130-v6mr6735089wmd.88.1529834302444;
        Sun, 24 Jun 2018 02:58:22 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id u4-v6sm4468328wmc.1.2018.06.24.02.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 02:58:21 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 7/8] staging: rtl8192u: Correct if statement - Coding Style
Date:   Sun, 24 Jun 2018 10:57:31 +0100
Message-Id: <20180624095732.12082-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624095732.12082-1-johnfwhitmore@gmail.com>
References: <20180624095732.12082-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected the coding style of if statement.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 03ec7e6373c6..2643312625dd 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -732,7 +732,7 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 	   section of code.
 	if(IS_UNDER_11N_AES_MODE(Adapter))
 	{
-		posRT2RTAgg->Octet[5] |=RT_HT_CAP_USE_AMPDU;
+		posRT2RTAgg->Octet[5] |= RT_HT_CAP_USE_AMPDU;
 	}else
 	{
 		posRT2RTAgg->Octet[5] &= 0xfb;
-- 
2.17.1

