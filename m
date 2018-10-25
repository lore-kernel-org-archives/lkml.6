Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5B1ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678C220873
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1ufgk6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678C220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbeJYWyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731475AbeJYWyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:20 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7052420873;
        Thu, 25 Oct 2018 14:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477282;
        bh=veIabBdWyQRA/PPfr7XzmZ2LQ9CVEY4rfOqa+bkpI3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1ufgk6irMtl3AgwPhjgysEu+/cDRIBYRmCm4RRp9RWe6QB3ujX7WMQeemhJiGvd5
         /ArA0Vz9UCRkX9/M0vrf8snhbal9ncwNBx2yCJ5Jm0HzcXDO7uW9TUZo/r6UhNyem5
         XPhNr4PASCAoZ03JsA52oezBQzL0aMFLL6hsn7BA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 96/98] net: fix warnings in 'make htmldocs' by moving macro definition out of field declaration
Date:   Thu, 25 Oct 2018 10:18:51 -0400
Message-Id: <20181025141853.214051-96-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Frederic Sowa <hannes@stressinduktion.org>

[ Upstream commit 7bbadd2d1009575dad675afc16650ebb5aa10612 ]

Docbook does not like the definition of macros inside a field declaration
and adds a warning. Move the definition out.

Fixes: 79462ad02e86180 ("net: add validation for the socket syscall protocol argument")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index a40bc8c0af4b..76afe92a0f4a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -379,8 +379,8 @@ struct sock {
 				sk_no_check_rx : 1,
 				sk_userlocks : 4,
 				sk_protocol  : 8,
-#define SK_PROTOCOL_MAX U8_MAX
 				sk_type      : 16;
+#define SK_PROTOCOL_MAX U8_MAX
 	kmemcheck_bitfield_end(flags);
 	int			sk_wmem_queued;
 	gfp_t			sk_allocation;
-- 
2.17.1

