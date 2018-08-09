Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927D8C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F80223A1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmbY3HyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F80223A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeHJB4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:56:49 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34385 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbeHJB4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:56:49 -0400
Received: by mail-qt0-f196.google.com with SMTP id m13-v6so8536450qth.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 16:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NVG1NaQ0l2l/gM+JknJiJuT9vpehtbMs4ssX+amsrr8=;
        b=tmbY3HyUfBT6XVGmmrogj35ixqurvq7C9/exTkMkqJCXNPXr+LdqFFjOve87MVLgyY
         bkK35ynyBh5iK6H2woWlTSdCNochqVHu2kXvsumG34cEio1EX+QAjbFdR70xyPvcj9vM
         SnCn4POKU7ViPRX3CIt24dg/BcdVVWKaf6RaIig4yyATOxFZU3/U76lGlSW4LxjRKwq3
         HOG4KXzyAli486iTltLAKLHXzcRnWARqg3KaKciQhHlDBcvNh3K8+k+XzYypwtxaDFGn
         mZSaca9cWsBOmIW9tM/elcYafP1kgI1hMN3OR7xxqmubFcqyivJzyhsML9JmOv0CM0cW
         3zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NVG1NaQ0l2l/gM+JknJiJuT9vpehtbMs4ssX+amsrr8=;
        b=uM5OFgOy6NVi/TnayvpZ2tjvNg4mjFo58wmaYaj8H2QbQzkQTi1wdap9y8h+otZWHO
         BVlf5YUwg775s7UtiId1X9B8ptFZM76v/BMXbL6J5u1rCqbdz58KXZRjoZbiqdUGQobN
         1/FCjFU4xdaj8Qzmp6ekSWjOJyw/BGJ5DVDw1yeFWhrD7wMvNH6N8BjquW7XH3yGgiKP
         JaUmRz9I/Sk5DZMvAGKcMXo2KXipWovOimduAhhHt2Ol+p0xA7YNpyPOKSLaqMpU5iEo
         4udz+CccX0b6XDyBw6wTqCtMvHsCF9f7fHNLjoR1DdwNXTJ6pqAjks3Z0f3Fu2te86rD
         dysQ==
X-Gm-Message-State: AOUpUlFfA0bWuikRQrpSIiodOAdVVRqjMTdYn4Ej6C72cFomaGCHsf+u
        l0WLZZr6dJEfKDMRtm+HWLTJxuzH
X-Google-Smtp-Source: AA+uWPxbwvUPWUa4mCpNQqZipkTFtG8Dr5fPIdjCdNqUWbznAeSSa5inqih1bSavNV2meVFv3FwpBw==
X-Received: by 2002:a0c:ab43:: with SMTP id i3-v6mr3801443qvb.87.1533857381527;
        Thu, 09 Aug 2018 16:29:41 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id r27-v6sm5938001qkr.17.2018.08.09.16.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 16:29:41 -0700 (PDT)
Date:   Thu, 9 Aug 2018 20:29:34 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: fbtft: Adds space around "/"
Message-ID: <fff917319d33d69e1005fa054567303631192cf1.1533857298.git.leobras.c@gmail.com>
References: <cover.1533857298.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533857298.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel coding style recommends a space char around "/".

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 798a8fe98e95..25302ffc4000 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -232,7 +232,7 @@ struct fbtft_par {
 	bool polarity;
 };
 
-#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__})/sizeof(int))
+#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
 
 #define write_reg(par, ...)                                            \
 	((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
-- 
2.18.0

