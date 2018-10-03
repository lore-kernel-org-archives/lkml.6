Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EECC65BA7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D055F205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6r6Bbsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D055F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeJCM1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:27:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34111 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeJCM1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:27:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so1038157pgs.1;
        Tue, 02 Oct 2018 22:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=byJ8AL+OyL3/ECrNFu7CrcIuzdZe6o08gH2o2a57pfs=;
        b=Y6r6BbsjRMWVeh92LOUKinxS79rm8SBPMErwSMXiiXzHhjPFpKrDTDUSW2y88RxGkf
         Wqn9C+HeNEEjhtiLhwp4os4wQs/ZGdVYZovAwpRqQ8083uoODo60oL9MqkdEDIWGTYl7
         2pJlqI62NSBNc0SgFEyAG9zxaKMi7A2/VGcIJPL/8Xrps9Ic8Ns9nA6ZAGE3E/L2CBNX
         4IcBdIWPf/5zUdtYGZGn4w8rCXLJdai99XGzqsfihQcMrVH4SMqrOBbLnnUgUbhmz/bj
         8AUMsQzQiXdJv+uNPxK8vg6qEC+lVTBqYvj78fKyiy5EJjk2PIgnlsnHcT6/y4xvDjVK
         7jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=byJ8AL+OyL3/ECrNFu7CrcIuzdZe6o08gH2o2a57pfs=;
        b=r2TCGw1AzyQ1qpKebdtxJrqVoCE5MVjiUAX7Y8zQ2tbeMEDOy7KUn2tcY6VkRHLpoI
         SEJ1eVumet7aV52MuUR70zdM0MHmVWp/iVgNPCiO96TCwfCBkvtw8oL6uxojU7xcEb8l
         lpqaY5AHx3py+7QYCRUG1IgJj/7LR637Ou8hmm9PpyTzfcxDoO6WUqH+FfGnHMRTiz46
         nTP/1VLiqque9GBC8ZUbgcxoRQ0cQLoWQQUhoNq4GAZEQgKqmQczhSqwRc8GyoSKD9CK
         MhPGvarxES7tBAG7fs1ipxHYzAymaG3xJ4UfkE3weIOiTNushBGDF1lRJgnTwQhqV/VC
         h3rQ==
X-Gm-Message-State: ABuFfojwE6GyAIsvsxwahIit/ptWjJYctnoR1DQMmYtbnooeRxsRk9OZ
        RWRww9Mb4GwT/pdnHPdtAZs=
X-Google-Smtp-Source: ACcGV63N/1/VABw/Yfer/Hek9B4eEYcG/xIRbP3uLlozIhkRzdPGpazAKCrPOz9MY6Ivm8GzvfyYyA==
X-Received: by 2002:a65:5083:: with SMTP id r3-v6mr16843103pgp.355.1538545219775;
        Tue, 02 Oct 2018 22:40:19 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id g12-v6sm548219pfo.50.2018.10.02.22.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:40:19 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 83E441643D0; Tue,  2 Oct 2018 22:40:18 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH 15/16] apparmor: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:39:01 -0700
Message-Id: <20181003053902.6910-16-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003053902.6910-1-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
Reply-To: Lance Roy <ldr709@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep_assert_held() is better suited to checking locking requirements,
since it won't get confused when someone else holds the lock. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: <linux-security-module@vger.kernel.org>
---
 security/apparmor/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 4285943f7260..d0afed9ebd0e 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -496,7 +496,7 @@ static void update_file_ctx(struct aa_file_ctx *fctx, struct aa_label *label,
 	/* update caching of label on file_ctx */
 	spin_lock(&fctx->lock);
 	old = rcu_dereference_protected(fctx->label,
-					spin_is_locked(&fctx->lock));
+					lockdep_is_held(&fctx->lock));
 	l = aa_label_merge(old, label, GFP_ATOMIC);
 	if (l) {
 		if (l != old) {
-- 
2.19.0

