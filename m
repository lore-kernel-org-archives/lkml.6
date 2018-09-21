Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63520ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDC42154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN55W/fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDC42154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391331AbeIVBVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:21:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46530 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbeIVBVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:21:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id z3-v6so2044235wrr.13;
        Fri, 21 Sep 2018 12:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GaoQEBM0/NgheinJ3VNXukjVC7Y9JtJWWy/HBwpOflo=;
        b=BN55W/fsbBJ6BYnrkXS65uxKgRnFK7IaFSbAVhNO1vu0NvXD2wad09SfHecdk3SyGU
         QUhRKYy6rdn35UxLDV7a5ZwkKCeXAoweS1NtZXGWhf0eSSI/e5jzVxWrwSZa/iSTuwNe
         SUCyXrc58JQizr3ieVhiM4ABp8eoop+wqdYbDEyVWi3a2KOTvjs9SUd+y0cMsq9g11f5
         gUH+sDrCqeoa3WSiNefETAAM1yv1mk+FjYFJNbRZQFPCfSUowHTttkWW0mvUZp922JcY
         on/PUVdTp/OmKdZKpeJzUggo2/TeoMFQwE58+Lv/o2Ci6g3pDsuNp8tAqGreqY1eh83S
         8emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GaoQEBM0/NgheinJ3VNXukjVC7Y9JtJWWy/HBwpOflo=;
        b=s5m45Xc7uGkL6NaluwatGsAD/MH6lM71igfvToCdPa7P1gtusN7jADzAmmrdlD8mDf
         3DGpAEtN9Bo+ByJWiU5OQL15ATz0aHsQXh3hBk+UqpXwt9YzJTPnB0wX1MVH75eLO1L3
         WdtKjuJxvQvxjPXFMgnKYYte5sU4fGtNPXVFSDOOulaCQvc9iMz3c8U2iFgsu5YwgF+h
         Tn8lLwX/9TAwudl1rAkYRbccVUxF0UCateRnLOoNMSzGscrJWs8n+UOnQygMa+QcsX5Z
         /5aEowYR272lR44PPd+iWlIptv36yUvBx9FeoXXbnzNubaJSw34AMlGeXx74oYt3SYG2
         Ww1Q==
X-Gm-Message-State: APzg51AI67qSwf5R7TjJfeh6lfEn+TwZF5YX59vKrmkNqFrVtGBS/uXk
        QLxNFzY1N71y3OakgHLj7WM=
X-Google-Smtp-Source: ANB0VdaZObVIkmoFmIvAovQm7WC96IfKo/ZGbv3pqkbXgRkTePh9R65s4/zLi15fvfekWRmCVO+WVQ==
X-Received: by 2002:adf:cc8d:: with SMTP id p13-v6mr40173255wrj.67.1537558249797;
        Fri, 21 Sep 2018 12:30:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j44-v6sm47625570wre.40.2018.09.21.12.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 12:30:48 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] decnet: Remove unnecessary check for dev->name
Date:   Fri, 21 Sep 2018 12:30:34 -0700
Message-Id: <20180921193034.808-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the address of a pointer will always evaluated as true
in a boolean context.

net/decnet/dn_dev.c:1366:10: warning: address of array 'dev->name' will
always evaluate to 'true' [-Wpointer-bool-conversion]
                                dev->name ? dev->name : "???",
                                ~~~~~^~~~ ~
1 warning generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/116
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 net/decnet/dn_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/decnet/dn_dev.c b/net/decnet/dn_dev.c
index bfd43e8f2c06..d0b3e69c6b39 100644
--- a/net/decnet/dn_dev.c
+++ b/net/decnet/dn_dev.c
@@ -1363,7 +1363,7 @@ static int dn_dev_seq_show(struct seq_file *seq, void *v)
 
 		seq_printf(seq, "%-8s %1s     %04u %04u   %04lu %04lu"
 				"   %04hu    %03d %02x    %-10s %-7s %-7s\n",
-				dev->name ? dev->name : "???",
+				dev->name,
 				dn_type2asc(dn_db->parms.mode),
 				0, 0,
 				dn_db->t3, dn_db->parms.t3,
-- 
2.19.0

