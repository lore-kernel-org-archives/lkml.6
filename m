Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE822C6786F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F2E2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="IKzFaOPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F2E2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeJ2Lv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:51:26 -0400
Received: from nag.0l.de ([207.154.252.120]:44462 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbeJ2LvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:51:24 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9iO9+NP8rI7nOko3iV/lqR5SLFCrdHoE3Hzlc6iaGkw=;
        b=IKzFaOPdzazjU83nz/ryQDug2Cj2T4o0MpwdfVctsevnep9v6R1QupJhNhK27u2buiE585
        dexfqnTZC8NkGCc3NjiXa/HfEcW9PLUAExGjN0QhFZwGoCm0FaZdHru6dvbJkXLl1h8pFv
        fIRc8SUytBf9zvZj/ku0mEPYz8FZPZ6y1tNXZIQeo7rdpYRyq/msRmSHsqKj17UQrZwIzi
        wbJGKTpKg6lgz2OX8wb3JVeFQIDBM4mRhcjK5ts0NlWxN3Gd/qjHZVVQSw22cnEanzVTun
        TULXWuVBnXt0q5xmm1NTDB2V6SJ1APyaSmkYl/URC8BMyRQgVmjgv+rTF70etA==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH v2 11/12] w1: replace non-standard %LX format-string by %llX
Date:   Mon, 29 Oct 2018 04:03:41 +0100
Message-Id: <9225ee7be1aa2a70b220d23efa3d6b61747df7f8.1540782140.git.post@steffenvogel.de>
In-Reply-To: <cover.1540782140.git.post@steffenvogel.de>
References: <cover.1540782140.git.post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9iO9+NP8rI7nOko3iV/lqR5SLFCrdHoE3Hzlc6iaGkw=;
        b=m34akt1w65Jk3ld4+W9s+QQRxIi+AS5F/0jDVdezp5a2imq+1q59u2Nb7o74jKt6g0RYiI
        SUK1Y1DaBqzQpoMFMCBHMPLN2D8Y0Wc3WukqMl/mMpp+mVxIXyY9yflTwD5cmn6SYWNHoP
        NeHyYMOn5h/+gH95/YEe3J+wu5t7p+w6oLbkG54bRS2QCe0ilYw+K1arXjuZsVJCEmxEfR
        7CRghTCsiCLCWVNC4P7k9seH5ckZqGOFIdjbhzY2Uyvg6LXBIu5N3H2yxa1Qjx2f6y+fBv
        YnL35y8TvJKJiiqBqTlpYMRd9vq8/LTpA6g4pGHKO99yl3uyVCmNep6nxitPUg==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540782276; a=rsa-sha256;
        cv=none;
        b=Dh1SvYKWCS6xS16xGm3R+5QKwFvKsd1bWTXjl3jxHlkDZt4TAnBeTdZkjr+jVCiUJUBObYMfMytyB3Ix9HMGe0+IJA+YzDJT9Asj8ebYcMA1xloCJOI8U1rACzWsIRTKWdTwJ4A01BR1YUpO8TraOwf0ujP12EKxceD/wJw8xC14/LwATBe1GBWuQPogrIeZbAwus5Sbxy6lpqOnrFH6aSsNxS12Pf7SLwoITXHvzPBLRhGfspgJQ2vERC2rcYyH7ttR5QDNf6pDI4NEpShnDRG+hPCE6A+Zb/v07usW3TSn55gVbylpOemOduaZ8MuF7MIzAJpzFlCrItUlaompPw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As indicated by checkpatch.pl script.

Signed-off-by: Steffen Vogel <post@steffenvogel.de>
---
 drivers/w1/w1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 87094d99ccbe..1326bd52888a 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -636,7 +636,7 @@ static int w1_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (err)
 		goto end;
 
-	err = add_uevent_var(env, "W1_SLAVE_ID=%024LX",
+	err = add_uevent_var(env, "W1_SLAVE_ID=%024llX",
 			     (unsigned long long)sl->reg_num.id);
 end:
 	return err;
-- 
2.11.0

