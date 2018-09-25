Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FD1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB0A21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMv35Vgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB0A21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeIYMZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:25:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34346 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeIYMZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:25:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id j25-v6so11665295wmc.1;
        Mon, 24 Sep 2018 23:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsCkDoI+BR5dCZmZjQNLxznogp2OYBQtOhYWZiyLzKQ=;
        b=DMv35VgkO6b1mEWUeOcraDsxRqriFN1sqjHt+WN3EeIcmAgcsydZAUVBmAqvYY8XGX
         kTAeczWp1L981QNj5d+GcTnBEsL8SU9gMU2UrtuylPxtDslsZF6KmI8nEerWUffQdx19
         YGj/w6MsxOT2UvRQJ81xEfs0AGUmkr0seuarH+hdzagunPZSWTnodm038kaIMrL66mXv
         +6rLukLr4PNz3IOkS44C8ZUqCfnSyXVdc0+EZImR7kyWmKBh3yJynYFSkjolBU12p8Qq
         cQzSpAZXk2MJq67DpzGSknARHzdGnjgGDAnFF05KVDxqurJX07XkL410MC77zqY78Jka
         eX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsCkDoI+BR5dCZmZjQNLxznogp2OYBQtOhYWZiyLzKQ=;
        b=OTff2rRphppY1wkgcJkCzw7FIR7YjBiEBFKu6HkweUGu+0KRY+7U9EYLOjir401cKf
         TAdOKC232W3oKW1iEhTvckuDyaydtDIa9dHqwlKPNmvxNtC+wyF0j4d+Q+7G1IpFTzeq
         iIFctfqzJM5yaqTZmCWeFCkN+kjhkpKJO1Q2mHRVVBxvEcV4kUk0fEvnzXrgEfpjZG0B
         fiGNRpq44dfmRQqaGPExkw9qb4M3rF+1PNVes2T8rss5Gnp9aHDS1OqN5BR/vtVOfwdc
         w6MgOF2DsQf5IVlaTH1fXTKV6TF/lwf/FrT8e8woS1XzMj9ZuRZiwTWeMpnKAaBqS99L
         67kg==
X-Gm-Message-State: ABuFfohObXiMcXWzoVHZjeBYefGX1y8He4glGw9HgTzOnCAFds8mcxXP
        0mUESv9n2mHVBpam8ylMPWuqM9C72KsKQA==
X-Google-Smtp-Source: ACcGV603rPVMQOlda95B5totWjMEhV5P+Noyao+1c4vbihJkO8+ARWJ3KEeDaEQ/cwwc2CEYAgmEIg==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr625056wmf.109.1537856347181;
        Mon, 24 Sep 2018 23:19:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h8-v6sm1479998wre.15.2018.09.24.23.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 23:19:06 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] pinctrl: generic: Avoid several implicit enum conversions
Date:   Mon, 24 Sep 2018 23:18:55 -0700
Message-Id: <20180925061855.19557-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another,
which happens several times in the pinctrl drivers for a few reasons:

* The PCONFDUMP macro, which sets the param member in pin_config_item.
* The pinconf_generic_params structure, which is used by drivers to
  configure their bindings, which has a param member like pin_config_item.
* The pinconf_to_config_packed, which takes either the generic enum
  pin_config_param or a specialized one.

Drivers are allowed to extend this enumerated type because of the gap
betweem PIN_CONFIG_END and PIN_CONFIG_MAX. Make it clear to Clang that
this is allowed by changing param's type in all of these instances to
int so no conversion needs to happen.

Link: https://github.com/ClangBuiltLinux/linux/issues/138
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 include/linux/pinctrl/pinconf-generic.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index 6c0680641108..13076ae7acfb 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -150,7 +150,7 @@ static inline u32 pinconf_to_config_argument(unsigned long config)
 	return (u32) ((config >> 8) & 0xffffffUL);
 }
 
-static inline unsigned long pinconf_to_config_packed(enum pin_config_param param,
+static inline unsigned long pinconf_to_config_packed(int param,
 						     u32 argument)
 {
 	return PIN_CONF_PACKED(param, argument);
@@ -164,7 +164,7 @@ static inline unsigned long pinconf_to_config_packed(enum pin_config_param param
 	}
 
 struct pin_config_item {
-	const enum pin_config_param param;
+	const int param;
 	const char * const display;
 	const char * const format;
 	bool has_arg;
@@ -180,7 +180,7 @@ struct pinctrl_map;
 
 struct pinconf_generic_params {
 	const char * const property;
-	enum pin_config_param param;
+	int param;
 	u32 default_value;
 };
 
-- 
2.19.0

