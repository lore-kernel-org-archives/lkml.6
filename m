Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3B4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 06:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEC0208CE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 06:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpXckZKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEC0208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeGNGWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:22:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37935 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeGNGWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:22:15 -0400
Received: by mail-pf0-f195.google.com with SMTP id v15-v6so3752945pff.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 23:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zhMTVp3OlrTplgG72jGZCAnZwN9QFUauNTq7vIuMd2o=;
        b=qpXckZKX6HaldH3KajcuSAnZaA+24Lp+R4ckAvTlqxqGLtyj1+CT/4rjiP405iYhtM
         /RhZmCkRXS1YNAkDR713WbpOf/H5zC0Sib00Ic+E4zt347krdNOLM9rhMNEeZ8r0c6pr
         ckHecF4vpc12RhVFvM2IZ6c/DIdQD+CCg2NXLerzscXjm9BMfUgUeZT9JElPY4+zH40l
         GzXjN3jXVDJ1NtEnbkCFQBSO61hO0sOxXo+Suaf0bAFPmMnsXxuta5A3aKtUVR/BhTLT
         bKlCaV0758srhqhwcSBaNKozytOpKa39cGBU8orhu/YGC9qM/PxeikadlLeSF0rAi++w
         a3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zhMTVp3OlrTplgG72jGZCAnZwN9QFUauNTq7vIuMd2o=;
        b=ZYkGMDKvqCCFJ5JRIPxvRFWxoYSjbA2Qehd7ice2iWs5BVpl/+s+GQF678m8+sCzVG
         i3dqFmmvbVW5CDw+p5KnrLQinYd1B9s2JVaabwsMZjTwj1kLJYRWaTng3ly/Mw0pcVHn
         F/RNihdGkc/Q+6cYIeJzHDzw1XAzH4rXn/MGMhUMfuF2LgrWek5WmZzNPSIpCLjkUt4n
         ui/xm0lZAlZiDPocHheJ8jEKdQnbqsvk054svDhDbZq+eYfvs521pWh3s12svuStkDTp
         IcK7e/JWte9UhE5hhazxR/fr/ZXu4/TIYH2NhpFI1WFsXWkFXAdCQ0C2AFirzMTfox8a
         30WA==
X-Gm-Message-State: AOUpUlGtCr2bZY7dFroryfAIhKG8NPADX5/FOHk4FHFHCjTRnytWbgjq
        H0LFoWJnv1WpfNl118LWP3Q=
X-Google-Smtp-Source: AAOMgpfg2f2dfFj65PSn3nmDHbq6frqIv4oVWRzdW5TqZDAxLFp6t6jOC8UJOCA6T0ZEFr32+DncKQ==
X-Received: by 2002:a63:2b15:: with SMTP id r21-v6mr8724817pgr.262.1531548264475;
        Fri, 13 Jul 2018 23:04:24 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id g15-v6sm42924040pfg.98.2018.07.13.23.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 23:04:23 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 02/18 v2] MAINTAINERS: Add maintainer for drivers/staging/gasket
Date:   Fri, 13 Jul 2018 23:04:07 -0700
Message-Id: <20180714060407.224569-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Todd Poynor <toddpoynor@google.com> will be a maintainer of the Gasket
and Apex drivers.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 562ee1e1cfd6..8f44e7bed49e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5968,7 +5968,7 @@ GASKET DRIVER FRAMEWORK
 M:	Rob Springer <rspringer@google.com>
 M:	John Joseph <jnjoseph@google.com>
 M:	Ben Chan <benchan@chromium.org>
+M:	Todd Poynor <toddpoynor@gmail.com>
 S:	Maintained
 F:	drivers/staging/gasket/
 
-- 
2.18.0.203.gfac676dfb9-goog

