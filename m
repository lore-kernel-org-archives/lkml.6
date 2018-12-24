Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C62EC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557062173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="eTYVuqPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbeLXP3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:29:19 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:45166 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbeLXP3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:29:19 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 0FE54938
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 15:29:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fC_BcMUfuZAI for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 09:29:16 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id D7A4A9A7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 09:29:16 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id l10so977827iok.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 07:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Vc1r3nUkSsEHofy6wG/QWMwv6RdlZ4kscbXuxXJyNmQ=;
        b=eTYVuqPhfCbGPo1Z2wiGJBuimJYPcbdjmnxsBaQZjLHUKA2pEOMXpZa/JVJXGYX9zM
         3PdO8O6VkJwok0878aGxv46O6RDdhL/k3NDSM84qxeic1XUrA+XwQeASeRnuKV/hLTva
         wT03cV9VJWDJnchfejV4/wwqxo4AAJIgueipld+Sbl1ZxXIgdNnt4cPFhhbxle/hpJ9T
         m67jYWGXi5QtHnLewImx1Pdqkh2YzGUl9Bm5SPwH/iduiF7cNmMWSNucUdSBRZAPiMrE
         KOdDT0ffNCOWAIYW+0bcvE9zd1eskVs7pMoZG+ZhWnTwQL0KHDT7/5wut3DLZZYAMOgy
         oiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vc1r3nUkSsEHofy6wG/QWMwv6RdlZ4kscbXuxXJyNmQ=;
        b=Lk2V1pF0QBZ7B+rfXwCC3Ijwr90xtDmK1JFjRp6aSj2Bp49Zfjz78Sp4ZqsDIHXxnM
         61rL7OTBnGLTtwLnSk736V9JNEdPns9ZRKU9/XXEtEBcnhe7CDTDrAp1X260BjcC6dDj
         SLPrm6/qbfed9zeae9BjilmvlpZ0t1ROF5T+ynlEJ2XI6p1Sk+wNboLOrRRb6zmS1vNE
         WE5vxttuEjw4Ef90V1HHUDAHEpOTyXZAZcgnxRK3RvhLj+vw//tpFY7lnO83mO7v7MPE
         oIlBRg0NbYqour6Mr18m54nd14M2uxKriLanwP7IVSnWYImX+mKn7tUkmRX10P49mTYm
         nBww==
X-Gm-Message-State: AA+aEWYHw2oTYueP7/aG2JWC2XIpLdj8/km5AmAST2d9Wl7MG/QEFsl/
        dJxdubJkWCuHAw+KsbPdvZ/VFApAvVS1j4HyEjXCbzZ/75Z2E2DL58gIxNbvje9OcH5UNgeULl0
        t+EfyXv9D/F5zFDZry0WmMIJTMygE
X-Received: by 2002:a24:a542:: with SMTP id w2mr7512828iti.64.1545665356433;
        Mon, 24 Dec 2018 07:29:16 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UJzzU7SLrf+tW7IQmgT/bXOQA0YM+mE0+S/OnAXYYmnCYHdL6kF8KTh486YrC8FtAeWTvAtw==
X-Received: by 2002:a24:a542:: with SMTP id w2mr7512817iti.64.1545665356198;
        Mon, 24 Dec 2018 07:29:16 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id k4sm13526267ion.61.2018.12.24.07.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 07:29:15 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Brad Love <brad@nextdimension.cc>,
        Michael Ira Krufky <mkrufky@linuxtv.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media/lgdt3306a: Add a missing return value check.
Date:   Mon, 24 Dec 2018 09:29:01 -0600
Message-Id: <20181224152903.15828-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In lgdt3306a.c, lgdt3306a_read_signal_strength() can fail while reading
the registers via lgdt3306a_read_reg(). The function can return an error
from i2c_transfer(). The fix checks the return value for this failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/media/dvb-frontends/lgdt3306a.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/lgdt3306a.c b/drivers/media/dvb-frontends/lgdt3306a.c
index 0e1f5daaf20c..b79f652d05e1 100644
--- a/drivers/media/dvb-frontends/lgdt3306a.c
+++ b/drivers/media/dvb-frontends/lgdt3306a.c
@@ -1685,7 +1685,10 @@ static int lgdt3306a_read_signal_strength(struct dvb_frontend *fe,
 	case QAM_256:
 	case QAM_AUTO:
 		/* need to know actual modulation to set proper SNR baseline */
-		lgdt3306a_read_reg(state, 0x00a6, &val);
+		ret = lgdt3306a_read_reg(state, 0x00a6, &val);
+		if (lg_chkerr(ret))
+			goto fail;
+
 		if(val & 0x04)
 			ref_snr = 2800; /* QAM-256 28dB */
 		else
-- 
2.17.1

