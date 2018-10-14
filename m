Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF73C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2411A20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dntF81Gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2411A20876
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeJNR6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 13:58:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42589 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeJNR6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 13:58:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id b7-v6so15158639edd.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 03:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uCE7PnYWwVrkVYQANCS8/euoQ0pQ/V0n8F9pWUDc+8c=;
        b=dntF81GrmQkLqvkDlMVAn22j+vxbrSUu6CU2eH9gZYdOP6BdeB85tUfqWI9TuDWwF9
         eJSwoHp2eENc1IP4CBMtNjGzDBjuoNKIwNUSKBZ1TDS1lxG6UAjI3r6881hMXPc+62Aq
         CjAH1e3YvImRoLioieMgXHwPKu3X92oAwbF/CVhWy+4An6HgLrSqWfNK5gktD2n5bpNB
         3Gkm8KZ9sJm7MwQQ8qewXTOF700f2408oRHFeKdtv/CMm+W8PmPIpoIfITR6SSoXP+w4
         ApDcIVp/n6v0XioOHkTZQszY6n2eSbrTq4DPRLNbsbYe9CeGKxwf0bSmvYjmzflonY9N
         vILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uCE7PnYWwVrkVYQANCS8/euoQ0pQ/V0n8F9pWUDc+8c=;
        b=HI16ae9OZCyEqxAYyFvXfCYFTqDkKwNMjY5bn6fRemPuqYmkkPQKI4Jsbrax2Sc/wb
         jk6Jk6Hg+cVdOhgQFF3mPfG2o4jsFUFe6u7xJzlPmlxS+GLhUwaFuINAZ3FFjfNgB2Jp
         COPp74U1QIwyXgrnBdPVA2h90nbzqlDtjCnA+wAPxW0Kz6MnkIPaU7zNh0hNemQUkxx0
         ZDgMz3aMVwM3tVI+DX2BdQKCg4TRI3a5VOeMXEbmpewbI5GKTwPI5+d4uXY1ixz9eZlC
         EYhWFIfaVoIIGfTLD/Yim0NEzqRS/jYHQypPMXClGKmb7nKyRfjp8vRt1EvJueu7QrEK
         Cu+Q==
X-Gm-Message-State: ABuFfogShgtTSK9CWO7KuUfLUh78Lja/TG1fYmDgGsLxBu+Y5BwyJIB4
        wK5J49WbliKirD2YBgs/019B9E7k
X-Google-Smtp-Source: ACcGV62N8piUHHoDXuGU4NIgRmymoIpZF5gQ0COSl/sv0w/cLxgCbBxF3mNs0OAGfycuuP9IiCT+Rw==
X-Received: by 2002:a50:a643:: with SMTP id d61-v6mr18918949edc.281.1539512284505;
        Sun, 14 Oct 2018 03:18:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id o13-v6sm1475630ejb.34.2018.10.14.03.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 03:18:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/8] staging: rtl8188eu: rename parameters of Hal_MappingOutPipe() - style
Date:   Sun, 14 Oct 2018 12:17:40 +0200
Message-Id: <20181014101742.10952-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181014101742.10952-1-straube.linux@gmail.com>
References: <20181014101742.10952-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename parameters of Hal_MappingOutPipe() in header to avoid CamelCase
and match the names used in the function definition in hal_com.c.
pAdapter -> adapter
NumOutPipe -> numoutpipe

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/hal_com.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/hal_com.h b/drivers/staging/rtl8188eu/include/hal_com.h
index 613aa35ce10d..a2d8108f9ef1 100644
--- a/drivers/staging/rtl8188eu/include/hal_com.h
+++ b/drivers/staging/rtl8188eu/include/hal_com.h
@@ -146,7 +146,7 @@ u8 MRateToHwRate(u8 rate);
 
 void hal_set_brate_cfg(u8 *brates, u16 *rate_cfg);
 
-bool Hal_MappingOutPipe(struct adapter *pAdapter, u8 NumOutPipe);
+bool Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe);
 
 void hal_init_macaddr(struct adapter *adapter);
 #endif /* __HAL_COMMON_H__ */
-- 
2.19.1

