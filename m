Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBD52082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwhGt9bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBD52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeKZIlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:41:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33083 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeKZIlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:41:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so11294346wrr.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 13:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lGSpVQJ9r+cfKGbk9shPNJrYV2Gh3BOQgRux4ygar/w=;
        b=BwhGt9bp8zzkIv45wzki1bb5sN7DVm6XuhiaU10J1fDgGzcpdR0Yq2i9chZ6o/te+Q
         QxVPXR9eEHX+xecqzwPV8atNQ9s3jdxqkFZbVht23a8QXx1+OwbDge9Gsoi/XSfoUH9K
         7AncIuqat+/Mzn1VP9nD6BKinJolllGFn3alQF3ChNlcXejTRkDwnF5D/CQ8wac3NA4f
         3V4mDW13trmn+P9/CChuXF6d7qqVcpCyVI1841rqNRx7my8d0EgAHVyhddVDwTqXVwa2
         rTzIKcM1kRj04bHy9uom9dpDoD1FT7gtBEpG/Vgk2Y1KUwSQtJJ0lgoLIE2/vdshuIN+
         OJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lGSpVQJ9r+cfKGbk9shPNJrYV2Gh3BOQgRux4ygar/w=;
        b=g5ZTdjZ1N8evmd7v/sQQHkVoPxlbgJZFUgbhXJmK+i+aTd2+/vTFbgXj++fJ+jvGiU
         tWxVfbm/L6hEUySUUjH9JwQMV8eUVlTajRrZC6KkvSXALbOjGRyfPbVFhepJfP/fk7Uv
         0tWgPBCCx+I3y+WPnweMCcemeKYLM6Dyf1Lme4vxEP86anvcukkX3T1lmB7qhc6exU1v
         NIgco1cKK6fCEeergkXEdGvelWsAMf84eS0elS5SjJoowWHjlPD7g3jipMo49oWZpHVI
         D6LDv3W/J2+vO+z/DPz/OfLK4epnnKN1kNeRoRxkHjob4M3EuUphllHARi29Ud9sKqmc
         S/8A==
X-Gm-Message-State: AA+aEWYlG6pgYyD72ZC4Zdpbw+nw634E+W1hBSRd2cVRsMiLkvrhvZ4u
        GeaGA+vyGCfmiYDfb+xkQPmuJGDF1ks=
X-Google-Smtp-Source: AFSGD/UtSwS6FxvstpoictNWWqqIAnVga0J+0i5dkVmzxZbA7+WQzlwkfvitI5GfFvZZIC7sT97yDA==
X-Received: by 2002:adf:84a4:: with SMTP id 33-v6mr21471875wrg.191.1543182536942;
        Sun, 25 Nov 2018 13:48:56 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id z13sm20899704wrq.19.2018.11.25.13.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 13:48:56 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] parport: parport_pc: Mark expected switch fall-through
Date:   Sun, 25 Nov 2018 21:48:45 +0000
Message-Id: <20181125214845.19149-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114730 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 380916bff9e0..9c8249f74479 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -1667,7 +1667,7 @@ static int parport_ECP_supported(struct parport *pb)
 	default:
 		printk(KERN_WARNING "0x%lx: Unknown implementation ID\n",
 			pb->base);
-		/* Assume 1 */
+		/* Fall through - Assume 1 */
 	case 1:
 		pword = 1;
 	}
-- 
2.11.0

