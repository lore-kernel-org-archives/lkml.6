Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0E1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3DE20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evf/OkRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3DE20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeGUNuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42493 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbeGUNuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so9015566pgp.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rTvpsayB2DxU8Uni61LcJB23ixJ+37hOawg0SdINgSc=;
        b=evf/OkRS+oLyO+ufqc46AgqD0G1sQIfzrBr1KCD7Se45NnIz6Y+o1SjAhRfOPEqotQ
         7pBzuJhSciIRPvLAuaoGwtpNO60QmQIlMEsaDXFBIBQQ9uahRBJDQt0qWHCbxjcFAMyd
         UnSuaduCZTL6HqcH9Vjdlofg6tlWMNnSoQ20s0lv97SXCRY55AfRiLuIyySMyAD2adfB
         JAfiNhSzPMc/mxZitVJKqsc3N1xds4CDfl5YIeU+5wK+bZtuQjvNx1/9ZtSi5M/6gXnw
         lf5i6YtITTlIA4z1xu7tz0JzF3fB1ags+xQaT1CBH+vPq9cZXNu6FvhbtpKaaAlrMJA8
         6nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rTvpsayB2DxU8Uni61LcJB23ixJ+37hOawg0SdINgSc=;
        b=MNpsH66alBPRcDCcYs970wie4VLdgXasGbViICgdjBPXmogNqtsIclPP+ZbDKvPV/D
         wAHM0LiW/2zAedM0o9jJ7PZCtJ1G3oLr/wcpiVpwSU7FHd0/ed5iZ1g9XZrtPE+k2MxA
         ho5qyVn4ET37ir06y5V+tu1EQicO9rOYKO05wvreMGZzTGUBhzHE1qhcRY6F0vCBV7P8
         xTlACN9n6AYAsmapeX2ZW3yWWlQcU18nXgNPMuTzu/zGosD4uHnawNrhEQEZZtn9EVJI
         x+WJwBG1Osk7oS03prsZUX9S6qGaGO9GVNOpw1lHsMXpdvaAWGFa/rTta7PEElSfJz2L
         38xw==
X-Gm-Message-State: AOUpUlEpYWa9SvJGoWO7C+ZuIkoipH75gibgYhMK9QiGqn9XNJJ/bnLr
        KoQA1Iiitx0QQ6KMvqk7Y5c=
X-Google-Smtp-Source: AAOMgpf8qJS9kI3tK/TuO68Ry7FQU/oDQ33zx+ylDIh7jMKdHkiX0suwsLUsUTXqlkVxM3YkJesHHA==
X-Received: by 2002:a62:6b44:: with SMTP id g65-v6mr5964752pfc.226.1532177860587;
        Sat, 21 Jul 2018 05:57:40 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:40 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 04/20] staging: gasket: fix class create bug handling
Date:   Sat, 21 Jul 2018 05:56:47 -0700
Message-Id: <20180721125713.88501-9-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

class_create() never returns NULL, and this driver should never return
PTR_ERR(NULL) anyway.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 18cc8e3283b39..53236e1ba4e48 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -321,7 +321,7 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	internal->class =
 		class_create(driver_desc->module, driver_desc->name);
 
-	if (IS_ERR_OR_NULL(internal->class)) {
+	if (IS_ERR(internal->class)) {
 		gasket_nodev_error("Cannot register %s class [ret=%ld]",
 				   driver_desc->name, PTR_ERR(internal->class));
 		ret = PTR_ERR(internal->class);
-- 
2.18.0.233.g985f88cf7e-goog

