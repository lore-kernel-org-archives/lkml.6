Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C43C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696292086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsWM+s9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfBBPfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:35:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44502 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbfBBPfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:35:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id p4so1492962plq.11;
        Sat, 02 Feb 2019 07:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ckwOi8H7XMHL0j39bx1cfrNvIBcStL3na7OxHgknYlM=;
        b=bsWM+s9e+G8kT0/bm5XwPhho1N08QjCEpVcDDi3OCIS6ugED449WucFe6SLkr2K2da
         B+io3mwjbryGwq1jXOigQ52S3i9ydGjWiUSHNZZJauIhvZqcjvE7rqFp3po7OMnyudfF
         zvQk8GP0UA2ENw067XKJrqh+XgF0lP5xQwUI0xzQtkAU0lM4FFf5ZkMEdj+y7phATJYT
         XpJ1zO8etxvUXjf/pYw4N2lQ+zO/X1+NkhfJhR8adYg94qanUFsDxdcpRa+Eqs/LERT0
         pGcoUMZE/qz/gAKfX7Xc5EI42u3iLE7zAQicwhCSly3udjQdqpCxSYlTrpY+Us/r/V9t
         5ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ckwOi8H7XMHL0j39bx1cfrNvIBcStL3na7OxHgknYlM=;
        b=pqgUZzK9gXwgIpSGBSO6pNhL3rrTjWmV5cFKG1La/4mN3AxGMeKcVN/8ZUO5PNL1pE
         Gs75vIbs66Pa5VbHF/m5Vq8mIADglLd0RO5bkxT3o3OZQtna6hbjb8vVZ9noL7jNOwqR
         BCggyZOVzr+ueSXIkB15LWsm7DlWGv9axvQ1HZyuhiAiQRCkydnLhikfT4nLmqVcQfO8
         bO/2+nE/GI9Sb8zsho/k09zEvEm9D5IxvvViHHFU9uv1zFKCfmFydYnJQ86ZnfRihFOA
         SKXpSqZZIQhyRwGqGfMinCEcmkpkVAwjaS7VfFD1DYjsQjWsnkKyAO3H1xBVMbxCdmL8
         WUww==
X-Gm-Message-State: AJcUukdyc9deuhlMJ2Agp8tsnxr4FHCK//U+DCAf7NkRV8a637nvzM/G
        dMMTKz6/Xrmo3PDlFg5dCTI=
X-Google-Smtp-Source: ALg8bN7rHZ7NDKnoOvADPM/7QkUKwvJIRinsO9d+5T8/bL45ZOCmnBZWVwQ8DvJU+5Z4sSEcqls0xw==
X-Received: by 2002:a17:902:3124:: with SMTP id w33mr44700708plb.241.1549121744120;
        Sat, 02 Feb 2019 07:35:44 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id m20sm16221611pgb.56.2019.02.02.07.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:35:43 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH net-next v5 07/12] socket: Add struct __kernel_sock_timeval
Date:   Sat,  2 Feb 2019 07:34:49 -0800
Message-Id: <20190202153454.7121-8-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202153454.7121-1-deepa.kernel@gmail.com>
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new type is meant to be used as a y2038 safe structure
to be used as part of cmsg data.
Presently the SO_TIMESTAMP socket option uses struct timeval
for timestamps. This is not y2038 safe.
Subsequent patches in the series add new y2038 safe socket
option to be used in the place of SO_TIMESTAMP_OLD.
struct __kernel_sock_timeval will be used as the timestamp
format at that time.

struct __kernel_sock_timeval also maintains the same layout
across 32 bit and 64 bit ABIs.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Willem de Bruijn <willemb@google.com>
---
 include/uapi/linux/time.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 04d5587f30d3..b8ad1b86b942 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -70,6 +70,11 @@ struct __kernel_old_timeval {
 };
 #endif
 
+struct __kernel_sock_timeval {
+	__s64 tv_sec;
+	__s64 tv_usec;
+};
+
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
  */
-- 
2.17.1

