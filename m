Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C68EC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5687F20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf99g8To"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5687F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeHaCkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37403 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHaCkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so8571465ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Ao4i6KYatxBvADAMyrk6Yki9DjA9BZBgUj/62Uj8N8=;
        b=Zf99g8TocQXWmANewIlW+56oYmzQKia1opwKsM86FZFUbWZcF3O6Y15TUJ5E9ixdO/
         9475yOYUG83XbYMiJyYDvJFs2Jkh73r3I06+tyl7LSGGB01VVF078jUmFEWP/mCIZzFe
         iE/AaKXIudY0puFyrw5L4ZRu3xgC1QreJKVXNOTGTGWsU7vzKOPk/ALpgqo3yeIgfQij
         5Ahcv6Qtx7pJrR38sW58/XmX+iWN4ZBY5FmfgkZuE+78DESk5y+JZohwM67rbjB3FFax
         OjvcMzyTRG5T7mtzq7hlI7OrK7Gkpb8FV1xWpRWg7ybfczp3GLtm41aT5nDvAg32SMYs
         iFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Ao4i6KYatxBvADAMyrk6Yki9DjA9BZBgUj/62Uj8N8=;
        b=XwJ2OXAZgQG9Eir93XgMQcbeBB6P7/hJBcY6dA8esh28Km9CEowA6jiS5weLeC83BN
         ZjkAjwx04t++0dzh9XExPvkuB2HA1u99n7tS+/w47qeASC0ZjDjfRBkQ4oOqEiNMZ8O8
         DZNH3Fl23ZBwBFOICCS2udohO3kzRBbBCbd5TXcti6cx0Gz6QBrefFg6Zo0lhqthPSK2
         u2mBDpENjE+YnjA8LU7Z9bdmY+AK5ZnEGl8REyQqgQBRLmq0vb5UlN7Fajv+JeLqNN3N
         sKlLI1EiZ57zLOdV7MaSGdVxN5/M7rjyz0d15s6JcMdl5PJ152P7qgcisHp3ssRa0+gO
         YBQw==
X-Gm-Message-State: APzg51DFlR7vMMxNZY9NWdEeBCwF3fVFBRZJmJKN7S7MSl+Rnh/eCbIJ
        XBTTdkcjBtaxfLTr+aSsm8qg3Hlrrbw=
X-Google-Smtp-Source: ANB0VdZarRn8yR7f4pKae4SRzhWW2iW8wGpQtnwEz8LoFCLefX0Z/BcHehnvXA2OJls2f8HGjkmMMg==
X-Received: by 2002:a2e:1290:: with SMTP id 16-v6mr8919517ljs.94.1535668547571;
        Thu, 30 Aug 2018 15:35:47 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:46 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 17/23] usb: octeon-hcd: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:23 +0300
Message-Id: <20180830223429.30051-18-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cff5e790b196..1a6431879201 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -2768,7 +2768,7 @@ static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 	    (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT))
 		pipe->flags |= CVMX_USB_PIPE_FLAGS_NEED_PING;
 
-	if (unlikely(WARN_ON_ONCE(bytes_this_transfer < 0))) {
+	if (WARN_ON_ONCE(bytes_this_transfer < 0)) {
 		/*
 		 * In some rare cases the DMA engine seems to get stuck and
 		 * keeps substracting same byte count over and over again. In
-- 
2.17.1

