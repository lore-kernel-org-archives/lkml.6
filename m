Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F42ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7A420989
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QE6aJuXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7A420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbeKIHfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:35:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbeKIHf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:35:29 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AB4F20892;
        Thu,  8 Nov 2018 21:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714281;
        bh=BnffgEVphlQIutGz8kqu22Ce8LdtqorKqnwq/EaFHOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QE6aJuXAn6ZuRjYU8VG2x1CTc/89rT2LQwly9rnPTWLJ73sQUITtke2Lgnubt9OFY
         XzwKqTyg+dUgFhk72Wy0y1D1s/e//DnNlcM4WRCpNJI4vNsBI85xDpYeSBlaj1Slzv
         LXElYX03A75qEvDeFZg4eysTDpCAoBZxdc1YGZTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 124/144] net: fix warnings in make htmldocs by moving macro definition out of field declaration
Date:   Thu,  8 Nov 2018 13:51:35 -0800
Message-Id: <20181108215107.050996082@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



