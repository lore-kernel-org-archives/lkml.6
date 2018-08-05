Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F360EC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E322156B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCVphwyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E322156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbeHEWOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42133 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbeHEWOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so5210626pgp.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAHTTr2rDpx6CHFJsMUcjY6kHEZWWAp0/bXwG1WwJ2c=;
        b=iCVphwyC4bMhL4hSG1panrm56heoyQ4LyB4SHau/4+2xjMwpCIRF+OewoTyNacjAft
         Oo0r0x6lhFdmr73ZGg+hwQRC4WhweoiXkblcqZnH+wBi06gyZledPpg+/AruDQ3geLim
         l676lBjNYKz+lGwuJ7OYtIaf4BhtNMtn/YXr30lnQ/hQOrbBM7p2ZAlYf9qYHPqIESIN
         9XwBMb2tBxCGkD0U9ONAgbNmPpURQtijwsu6KEG6mVJTPBhzGb0idnfWGxVUPVYt/XC3
         HiGAXGlSWPbTy5l4a8f93/WgeU/18wwXh7/IEWH0tH0SeIzy41WtjWWU2FfjaHeY2NRh
         ZWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAHTTr2rDpx6CHFJsMUcjY6kHEZWWAp0/bXwG1WwJ2c=;
        b=oUTClvJme8xMsGNjIoae3t/HKpdo4Id5hmQjySrkga31JGSrhBgYSCi8di+1H5LuAx
         PHApjmMmvdnEdpVBjdabgwzMEtHZYlOlqjv/IfWrrh6y6iKZg1vySERkOJv1mwS+EiLN
         FQM5xHV4gnsvZ3gjdDwvq3Zzj0Rbi4zA3qrshVQnavZddirMzy7Zz0w4nb0ovxbEcbq5
         x1WxmUVn36A9pnHfIvlKRUAMveKSWis1J6+KvsbWdtOS/mppzBWp2U2O62/Cwbm3mp2x
         QLiQsbbpDjGxeUQAqCbcCMePN+9JnFT8HPJvcEFVNrRQlJon82pi1DknX6wogHahCWhs
         0KPA==
X-Gm-Message-State: AOUpUlHZhKX/GuLSqkSU+oYT5DkyulNAkH5vE6Z3jZfhjIBj8914TwLo
        Qk68R2jqhBbS9aAt2KE5B7s=
X-Google-Smtp-Source: AAOMgpc14TrP+oTQEeW7Da9btbzuI3peeFRQMqVa0Tro/w+bKhfQzzPezSli593F2wmTdpcF2bqJLw==
X-Received: by 2002:a63:9f0a:: with SMTP id g10-v6mr11979633pge.324.1533499718638;
        Sun, 05 Aug 2018 13:08:38 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:38 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 15/15] staging: gasket: core: remove incorrect extraneous comment
Date:   Sun,  5 Aug 2018 13:07:49 -0700
Message-Id: <20180805200749.116693-16-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180805200749.116693-1-toddpoynor@gmail.com>
References: <20180805200749.116693-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

A copy-and-pasted comment from another code sequence is removed from
gasket core init sequence.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index a6462b6d702f1..d12ab560411f7 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1792,7 +1792,6 @@ static int __init gasket_init(void)
 	int i;
 
 	pr_debug("%s\n", __func__);
-	/* Check for duplicates and find a free slot. */
 	mutex_lock(&g_mutex);
 	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
 		g_descs[i].driver_desc = NULL;
-- 
2.18.0.597.ga71716f1ad-goog

