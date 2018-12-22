Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B68C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D226F219FD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdY9Zt05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392372AbeLVQ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:56:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39648 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392361AbeLVQ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:56:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so8137402wra.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 08:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tn/DV1yhb2eFQ4F2wecrIoks8LGX6t1BaCME7ChSTxs=;
        b=GdY9Zt05H2OErv6KIbRBUkkxdVF7s/hqomja0afPSuinWwq/qWy1v08noX/r6If/BG
         x+1vKZGIqXv+hdJuWQM1xccxq0OlN8JiH5zoYNcL47qpDUV8jIbhI4B0blNN5QshZWrf
         s3jOaG8AvV6aAk9c+CIfmHAfdh+ums57sblF15hJugudenuT0TXpcvqYMFeYBp4vdOS+
         DU2q0BYEyHl/DNj40G3NJVycC5FeHzM01mzfvEVn1VXbhDDDgMa0NgqILGdfDqrpgtFp
         6t8t3Bb5c9m+VLDsnB/5rSig0+k2rHXJF7drH9L9QmoRh1AcKlMb5O4ob4mQURCeD3KN
         bGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tn/DV1yhb2eFQ4F2wecrIoks8LGX6t1BaCME7ChSTxs=;
        b=GKCNNYWT6ITgkwsH4NjmBr9aJN7Mgoi0XTyhjhMoefqaExo8PheHZQ0MXJkzNyjfpv
         3JD3PiqrivUIg9vdbJb4WsvYId9bQf7VdrkdydevTzoooQP8+DM1/F70z0kivM0akswK
         HAIV1lvE/E7spwVJwaexAtuYkNWdl4ZQGsgs/kh6lYHp8dj75LLPuI8EvzJpYCmH6ZP3
         kACJyDIdwPZnmj9rfC7bz3XejQoSKfC0K830vD1zeMM8qN/unlXJWoBCqI0HuakXuVKX
         IU0QZcV5o542n0iT/c2T4N0B7+25y4MP7ql/9N7cpRAXSja7TQO5/m/mIX+bkjM1VWSB
         gIxw==
X-Gm-Message-State: AJcUuke/S/s28Xl5yXGn5QP4WYEJRnaRZcgSwNgKpsWMLsdpnMRbBDUY
        N5cy+GIEw3hQ7pCjScb1BaiY8Rce
X-Google-Smtp-Source: ALg8bN7r0ZqnQnw1YLg/kLIHqOQYICIa3AndxPzBK19z3o7Z78U4PxaS1thdj1nokRm+X5JuOcG4WA==
X-Received: by 2002:adf:c108:: with SMTP id r8mr5881793wre.233.1545471996767;
        Sat, 22 Dec 2018 01:46:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id t70sm17632687wmd.36.2018.12.22.01.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 01:46:36 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     insop.song@gainspeed.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: gs_fpgaboot: cleanup alignment issue - style
Date:   Sat, 22 Dec 2018 10:46:24 +0100
Message-Id: <20181222094624.2194-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181222094624.2194-1-straube.linux@gmail.com>
References: <20181222094624.2194-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup alignment issue reported by checkpatch.
CHECK: Alignment should match open parenthesis

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/gs_fpgaboot/io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/gs_fpgaboot/io.c b/drivers/staging/gs_fpgaboot/io.c
index 3d17ca557611..80903ec36b76 100644
--- a/drivers/staging/gs_fpgaboot/io.c
+++ b/drivers/staging/gs_fpgaboot/io.c
@@ -39,8 +39,7 @@ int xl_supported_prog_bus_width(enum wbus bus_bytes)
 	case bus_2byte:
 		break;
 	default:
-		pr_err("unsupported program bus width %d\n",
-				bus_bytes);
+		pr_err("unsupported program bus width %d\n", bus_bytes);
 		return 0;
 	}
 
-- 
2.20.1

