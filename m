Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93203C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32927208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuEPx1Qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32927208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbeGaWHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38015 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732496AbeGaWHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so9635655pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Z/Peh5RZW4vmW3pQwghCAlmxYEFlKA8+30MtRY0aVo=;
        b=iuEPx1Qm4vwymbxZS8WFD6YAtdPn1r3/T/p1HCLcZnbrLoULcOF39HOo9GVUP4MfuA
         zuu09/XI7dDUwgUWw5Yq/TdcGOYs7SAiNYDv8kaz0HVJrDfPVyEsV3025WjOqqf6MPkh
         yimv1NqTgYvLQuLwnxTOICDfTm6N9tsuAOHmOLiReRNU7XKkI9JcEgFDVLZBU1SB7DZt
         BNAc4TnPvDyeN1XPM9K566hpfXFySsfC0a6z65aKwW1ZqjDaxgohnNtyWRkETRukJIsB
         A1E/hxfSdmTgpcsXc7p6TfHFvqXBZyKPgdBt0gWossAmbAO1jw60qMEcRh/h0vYznlnL
         FYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Z/Peh5RZW4vmW3pQwghCAlmxYEFlKA8+30MtRY0aVo=;
        b=elXb8F8pNIXRa0y7UjtSVLEiIas7tfVTBoY7ryOd6m+Df3Co5T4RGMqpkydhzajar0
         imYH05kpHt0lLdbaOXF7aIEWuD48CqbqOXbP6fAjZ5nnFcVTnU4wsGK3bZ31cHah0TpK
         URBF9WGI162vynGxJeM6xHVUamXOkL7Qqhs8apYL3e4orrJcBcn0LRN2PKz5RMpbCaIO
         kmX4Itssq06BKdNFXhI3th3Q9nPmmUKhCFTphk2hqcrDG7wUqjz4kaNZw9WA0Fs8b2aA
         yLQ3F9W2pnXTnw1zk7d/1qf09xJI0/orrBc76RMdLs9SX0dF3ifwS7qUClPCG0cEM9of
         Iaig==
X-Gm-Message-State: AOUpUlHnaCBiYWE/FpWZ29Z5b7lofb+LltDq3StIMTAgfyzWS+edo2e8
        iO0Scyn4T8++FS633YuC51k=
X-Google-Smtp-Source: AAOMgpezMpyq4Ki0zsoIJtqDwsiapmTzeaLyQf+Ok3WuZafHIlu8xC5qYRn9dOGCRuCw71UnmBZluA==
X-Received: by 2002:a62:8b0f:: with SMTP id j15-v6mr24114651pfe.33.1533068716040;
        Tue, 31 Jul 2018 13:25:16 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:15 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 05/15] staging: gasket: TODO: remove entry for static function declarations
Date:   Tue, 31 Jul 2018 13:24:38 -0700
Message-Id: <20180731202448.229487-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731202448.229487-1-toddpoynor@gmail.com>
References: <20180731202448.229487-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The static function declarations are removed, remove the TODO file entry
for this.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/TODO | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gasket/TODO b/drivers/staging/gasket/TODO
index 7f4c13ce021b..6aa2a7f6bc4b 100644
--- a/drivers/staging/gasket/TODO
+++ b/drivers/staging/gasket/TODO
@@ -1,6 +1,5 @@
 This is a list of things that need to be done to get this driver out of the
 staging directory.
-- Remove static function declarations.
 - Document sysfs files with Documentation/ABI/ entries.
 - Use misc interface instead of major number for driver version description.
 - Add descriptions of module_param's
-- 
2.18.0.345.g5c9ce644c3-goog

