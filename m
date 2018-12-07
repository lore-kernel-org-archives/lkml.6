Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D60C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D03F208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZEK/WcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D03F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLGKVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:21:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44384 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeLGKVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:21:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so1525591pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 02:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9CEoDCK9uvYi1mDJnsc77baMLzVJKXRnuN8Z4r2UU20=;
        b=BZEK/WcR3D+eC3AmJjwfYTzfIp3I6pG9Xy/xFo1Tda5XP/k34o+h4qmDHGX7RDgirb
         IHp2vcPlFLFB3G/7qfZbprj52OoqjMZ3mh33N7tZcMNu5bXUlHUGJuMc6Xn05C3esSoz
         CS3Hgq1rUSA30PXqEG5DqkXqBoJKUz9cGbwU7pBIIkOTBdaL/RZ/IcvVItldvTTK2tBg
         NwPJCGG3gTRT0DYH/hPpdRFATOR3lt1ETss44WUONdTEiLFWaZ5/g/kKTrg8IkMfI4OJ
         6C9H6b9O8AtZTivaczAOmVAZ4z9BhrGvARSdNbi06TuIFtUIVPYaFkB/YiG0++t0IjO4
         O0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9CEoDCK9uvYi1mDJnsc77baMLzVJKXRnuN8Z4r2UU20=;
        b=c6fo3t/32MuT7EcxapWW3QO/cmgN1L4/exuR0zzETDCzWRRMl6i0lNZxe6dZiUVfJ0
         d+Y7xPH11NTI9YRKYJHptu6I9IqvtVH5OYVw7HE+ycs4BuuGVCkjK6s9YhJQGuKOX/Sr
         mZbPsBhR5tXs5TVnxseV0ABAjrZ5pJXfzmUMOnJ1m5TWifXxPskuUVZCYPfJg4scGQ7W
         YgEGBoUduy0gTAKIF20MNgn2BwuqgeEh3HvpZEaCOzypdU8QUx/4PpqJFou1Twnjljg/
         7N7tp4SW5x4aIznTIXEWYffQRmjl5PGl/qn8MYjd8ljaahz/wpaqd7oJ7O8GY7MPn9Rj
         No8g==
X-Gm-Message-State: AA+aEWaMyBI/Roj+vrrq5RIvKTlCcyFRr15Nx22byDjrq7TvWC1D3s/9
        Lfr/qXOtPBE/QroBYJBJfdY=
X-Google-Smtp-Source: AFSGD/VmHkM3+GU8jAlXfPr6SEEHMNaWG+TrglcK8xgl89ZV3YOc865YXa7mR91jauyv7sfjoo7IVA==
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr1368093pgc.366.1544178096295;
        Fri, 07 Dec 2018 02:21:36 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id w88sm7363186pfk.11.2018.12.07.02.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 02:21:35 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, linux-kernel@vger.kernel.org,
        joe@perches.com, yuzibode@126.com
Subject: [PATCH v3 1/2] kobject: use pr_warn to replace printk
Date:   Fri,  7 Dec 2018 05:21:28 -0500
Message-Id: <662efd36ef9a3394f0c4ea64d3bb3715b7390458.1544175417.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544175417.git.tsu.yubo@gmail.com>
References: <cover.1544175417.git.tsu.yubo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix to replace printk with pr_warn

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 lib/kobject_uevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 63d0816ab23b..b7c088c902a2 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 out:
 	if (r) {
 		devpath = kobject_get_path(kobj, GFP_KERNEL);
-		printk(KERN_WARNING "synth uevent: %s: %s",
+		pr_warn("synth uevent: %s: %s",
 		       devpath ?: "unknown device",
 		       msg ?: "failed to send uevent");
 		kfree(devpath);
-- 
2.11.0

