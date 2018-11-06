Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2E0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEC72083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfYCDH4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEC72083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbeKGItO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:49:14 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:53500 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeKGItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 03:49:14 -0500
Received: by mail-pl1-f201.google.com with SMTP id bb3-v6so14535349plb.20
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 15:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xo5G1bNTmgMBccdEV/3AjXg2C0Fxc2edqjMPLqnBids=;
        b=sfYCDH4k8HrzlyXYFJF1eQFSgOKaJQ4i4LK124kupINX05ajun6DE+LYJOu6WFcd9m
         MowOpi8RJxbFOEUy4ru/F85sd41zurJUXC8KTCUXQ/0d7bMLgEeeyOgUSW/NvyeceCn6
         6aHGMAkf9H7jRycpHU1KF0QGHM+M52idiTtHOhnsuEwMI1383HvzmrfsBLpchgsROpyU
         EaIdVSZC4UQFTav5AmBNim713UaiamS/grJLm0JPn2ZeIyrRUv+lLDKevqPi0jSZUx3O
         BZKp6kTGw1oM5x/pjmMKBDi0rXEW9k1LbX3tT5S7WmmAdJtu3T5b77lovVQByohdbY5A
         1Asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xo5G1bNTmgMBccdEV/3AjXg2C0Fxc2edqjMPLqnBids=;
        b=L56+Z5zsf8sWwHwi2z2i7tP4tWmvZQdiEBw7YSypxRDAlOVy2PENx3bCj0s1dypcku
         7760KHSyRbgmg8yTApPs1B2KvDSCCo7miEJGZTuYv4Z7LGpFXgKJAVzr4/PD7o7yOuWt
         J0P0cd3QzgllUTasO3Co7ie/ONUr6KxIiHysXM+0WlCxJoWb06JKjRU6SMow/8J3uT5w
         rZnnbpIXyHfqhrWh3uZ6Tgj7OlkIe6XPk5YVMgpd+SIAyvUz2W5dSwdWAs++wuhgznbH
         w8arIkspFMb/Or4IFaEjNPVe0XQpcVdmpxOpbrh9PnbsWyFM1q5ocEkFqFCyJyHDwjKb
         AN+Q==
X-Gm-Message-State: AGRZ1gIdxBOLoHNv7UJFsCD7hUxeToIp5R6oH7whAW0gIj/ALkBFyNR6
        /Z56PVYPKOIkqbDHQ6N3h47W+z9+BOI=
X-Google-Smtp-Source: AJdET5eeZBZZ8vOJWxlcqLxitFVGzFjy1vfl0oS+s8/uBfJlXhNJZTYO2PCJGycCTgXRA/VoUl0LziYyJpU=
X-Received: by 2002:a17:902:7281:: with SMTP id d1-v6mr431570pll.54.1541546495692;
 Tue, 06 Nov 2018 15:21:35 -0800 (PST)
Date:   Tue,  6 Nov 2018 15:21:30 -0800
In-Reply-To: <20181022222614.41016-1-mikewu@google.com>
Message-Id: <20181106232130.33932-1-mikewu@google.com>
Mime-Version: 1.0
References: <20181022222614.41016-1-mikewu@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH v2] modsign: use all trusted keys to verify module signature
From:   Ke Wu <mikewu@google.com>
To:     Jessica Yu <jeyu@kernel.org>, David Howells <dhowells@redhat.com>
Cc:     Ke Wu <mikewu@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make mod_verify_sig to use all trusted keys. This allows keys in
secondary_trusted_keys to be used to verify PKCS#7 signature on a
kernel module.

Signed-off-by: Ke Wu <mikewu@google.com>
---
Changelog since v1:
- Use VERIFY_USE_SECONDARY_KEYRING rather than (void *)1UL

 kernel/module_signing.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index f2075ce8e4b3..6b9a926fd86b 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -83,6 +83,7 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 	}
 
 	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
-				      NULL, VERIFYING_MODULE_SIGNATURE,
+				      VERIFY_USE_SECONDARY_KEYRING,
+				      VERIFYING_MODULE_SIGNATURE,
 				      NULL, NULL);
 }
-- 
2.19.1.930.g4563a0d9d0-goog

