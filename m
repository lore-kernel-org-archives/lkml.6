Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40091C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D54A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ck+hEc32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D54A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbeJWGrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:47:10 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:49517 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeJWGrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:47:10 -0400
Received: by mail-oi1-f201.google.com with SMTP id h21-v6so29820391oib.16
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Q3CGUFLzNo51687OV1C9z6aLVTCBFRy+ju+5mzsjgro=;
        b=Ck+hEc32DgszDuKxUKOmTV7epqtkDo1G0Ey6UFrP1353G79PQyGqDNblINcAtscFRY
         27P0KmUoc1D+jyKLBsyHFNdZWkisF70bZtn4mOlflunGIZpmPbOstEuAALhr09zIJwiC
         1d2DNwrNzaMNken7rzDu9J0fpe17alS7ee5LL23Q/hbHHrQjRicRx7j7pbSD0oMEDtnJ
         h29vRMYwfkwfNyTaR4ZyJuB7Js6uS99NTZt4qq+DORKrQGZ3PWnb9LtY6GvxgKcwc6tY
         nYkq7Dy8zMr+UYT/q/GyIbKpzIT+EM8wpRL7phg7+Tu0vE3iIOWQ6MqTwjXDEz3LgQ88
         KbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Q3CGUFLzNo51687OV1C9z6aLVTCBFRy+ju+5mzsjgro=;
        b=LLnDvkZebFvA7QH8y6w3C1qrY/mZK/kcOoOwWPQcsu4gQv55Zch/ePwgiTxY5scZrP
         TlPvHR1hQltDVijU2XMqLASHKdgE274epg2JnnVRyyPV2TPgt9iUB3gwpfgccCKtI4CD
         LDhXNEUyUaHBUgnJRsy1AQOWF+0NUy1vIai8wWLPur54Yr96AOH9N5nZ9CF20d7FdnAm
         jnq8N3Wl+XU/aUUnr+Ei4p76nB4VFKizIVe1CnXP1LSGhCCAtOwm6KI1S7C0xKmIf95W
         X5V2zhcpTsU8GoHtrIp8O0bJ9kYJqM+Ee/N+a1+ANaLRBCs9PvFczhVSCeNP89yp7OuC
         yDtA==
X-Gm-Message-State: ABuFfogHRTQRxJAdzO+4zySvwSJobdp5Aqm1IydI+HcV3poXMhO4p6nS
        wx/bgeFPEoFftfGlErkufDOw17+/r6o=
X-Google-Smtp-Source: ACcGV626QR7zuhoZKJKy0Pe2dAsJT3PLzR/b4CsgdK0ykCC8DstZTG0FtIjrRInTBEPeOVqACqiLIZvx3VM=
X-Received: by 2002:a9d:70d6:: with SMTP id w22mr37443358otj.46.1540247204155;
 Mon, 22 Oct 2018 15:26:44 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:26:14 -0700
Message-Id: <20181022222614.41016-1-mikewu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH] modsign: use all trusted keys to verify module signature
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
 kernel/module_signing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index f2075ce8e4b3..a8b923ba1a39 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -83,6 +83,6 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 	}
 
 	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
-				      NULL, VERIFYING_MODULE_SIGNATURE,
+				      (void *)1UL, VERIFYING_MODULE_SIGNATURE,
 				      NULL, NULL);
 }
-- 
2.19.1.568.g152ad8e336-goog

