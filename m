Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4514DC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8362075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8362075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935954AbeFRUiJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:38:09 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:57974 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935073AbeFRUiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:38:07 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fV0uc-0003Ao-0E; Mon, 18 Jun 2018 22:38:06 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 2/3] bitfield: add u8 helpers
Date:   Mon, 18 Jun 2018 22:37:49 +0200
Message-Id: <20180618203750.28658-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180618203750.28658-1-johannes@sipsolutions.net>
References: <20180618203750.28658-1-johannes@sipsolutions.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason why we shouldn't pack/unpack bits into/from
u8 values/registers/etc., so add u8 helpers.

Use the ____MAKE_OP() macro directly to avoid having nonsense
le8_encode_bits() and similar functions.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 include/linux/bitfield.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 147a7bb341dd..65a6981eef7b 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -143,6 +143,7 @@ static __always_inline base type##_get_bits(__##type v, base field)	\
 	____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu)	\
 	____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu)	\
 	____MAKE_OP(u##size,u##size,,)
+____MAKE_OP(u8,u8,,)
 __MAKE_OP(16)
 __MAKE_OP(32)
 __MAKE_OP(64)
-- 
2.14.4

