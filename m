Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DCBC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 23:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FD62184C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 23:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKUWZwf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfAZXV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 18:21:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46457 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbfAZXV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 18:21:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so9343425lfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 15:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JD5WRLDcyAIMKxtCkk72zkUgX48bEbI0nw5VReqxjFY=;
        b=VKUWZwf2LNamxely4xTz8tTKaNArJ/N6ehopZq3s1WH/oFnqH3xOiXcnRRbYE8rrZP
         cD3/sKD6xGXvD9eMKAxfpUSxlTUET2rrbgr+xcU/irNcMR+dNw11Vecui2ZZYLavp5nO
         63gKA0//1xeR9kWdZVUy5OHs9zKAgy2JW18RNRYao4wp5P3sWeRkh2oyk+sCBNhXGdL+
         O6oV8KaAIYjGL34Vgb4sIzEVHlkZDvW5rXtsyt6uuLs84EFQb/jAMP8qKQ1eGV/goj1D
         KeNCaDXbIC2Wb9ZMC5C+5/HBX4S/H1kpM61TuHFGdrv7U4VCEW8TpyTHqA6/mOhPzKxY
         U09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JD5WRLDcyAIMKxtCkk72zkUgX48bEbI0nw5VReqxjFY=;
        b=U2yxlH/s4CGfzOg+uDxUB8byiAyKyhAXUUBSfNYPVOclCxH2IufbrZ3dIh6ivKlET4
         3TFY8QBoNi2Jsz4JT+w2tViEU33fTwahrkHxX69QRFJj/pJT6aat7QgAzkqJfjLoXzHB
         d9dD9NHd+NyI7Pmjq5zINsjJ0T70uyTYc0vqDBnwQ+nqBnopdzSNGSRx0CIImDIfMpvI
         qsZ7/FW6Etyh3hP7ZXojRVpL99rlXRznrZVX6Rzs8OaptbgBZ+D19tfgYRNX+fmyFNA6
         YyNaApwUvtK6kobtOT0RnyfLbD++1bsjoDpHsTl8lkAp48/7XiRFOFDPJe4BdMTwpyzZ
         kgtg==
X-Gm-Message-State: AJcUukfcgE5Y3Pksp57xkZoQS6YJd496Td0gWs/Bv+XQlFg565lqleNP
        4IiX8w6tKTRvaWBxpS3xz3gc5hJI3mY=
X-Google-Smtp-Source: ALg8bN5K0VaKnCFio/r3+CimXjjYs+U2kGTTaFy2iPK5IF8Zj9YQN2a1HY14tuybp56sLEIhLXUX8A==
X-Received: by 2002:a19:4287:: with SMTP id p129mr12783593lfa.135.1548544885945;
        Sat, 26 Jan 2019 15:21:25 -0800 (PST)
Received: from localhost ([2a02:a311:825b:e300:2c63:f9e2:fcfa:cc46])
        by smtp.gmail.com with ESMTPSA id t23sm2249333lfl.59.2019.01.26.15.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 15:21:25 -0800 (PST)
Date:   Sun, 27 Jan 2019 00:21:30 +0000
From:   Cezary Kierzyk <virdipravum.n008d3v@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        clabbe@baylibre.com
Subject: [PATCH] staging: rtlwifi: replace ---help--- with help in Kconfig
Message-ID: <20190127002130.GA7106@pravumPC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: prefer 'help' over '---help---' for new help texts

Signed-off-by: Cezary Kierzyk <virdipravum.n008d3v@gmail.com>
---
 drivers/staging/rtlwifi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/Kconfig b/drivers/staging/rtlwifi/Kconfig
index 7b4276f5c41f..28286a87a601 100644
--- a/drivers/staging/rtlwifi/Kconfig
+++ b/drivers/staging/rtlwifi/Kconfig
@@ -2,7 +2,7 @@ config R8822BE
 	tristate "Realtek RTL8822BE Wireless Network Adapter"
 	depends on PCI && MAC80211 && m
 	select FW_LOADER
-	---help---
+	help
 	This is the staging driver for Realtek RTL8822BE 802.11ac PCIe
 	wireless network adapters.
 
-- 
2.20.1

