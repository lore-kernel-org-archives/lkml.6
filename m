Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61704C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D1C208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCkVZuN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D1C208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbeK3BUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbeK3BUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:20:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E250621019;
        Thu, 29 Nov 2018 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500881;
        bh=ZUcUqniG3Lto89Ipthur91JEAEzmpXR0qWZ+lZOLVcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCkVZuN/1mfjJGuzf+1jl2gvsrw/HYMYBSn8FAcqjju5YB0KU0JLke1o+ZeRqYD6o
         dokjxEl1YpXbZRwfymSIEQOCLFsCIRhy4jDxsaHHWxMAfanlTSo02MeDWiWqvTaYb2
         Eld9TOvMrusY7PfuDdYlE7kgyHlmDzqS/DvhPtGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Y.C. Chen" <yc_chen@aspeedtech.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 3.18 07/83] drm/ast: fixed cursor may disappear sometimes
Date:   Thu, 29 Nov 2018 15:11:25 +0100
Message-Id: <20181129140138.455308866@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
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

From: Y.C. Chen <yc_chen@aspeedtech.com>

commit 7989b9ee8bafe5cc625381dd0c3c4586de27ca26 upstream.

Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/ast/ast_mode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -1246,7 +1246,7 @@ static int ast_cursor_move(struct drm_cr
 	ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xc7, ((y >> 8) & 0x07));
 
 	/* dummy write to fire HWC */
-	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xCB, 0xFF, 0x00);
+	ast_show_cursor(crtc);
 
 	return 0;
 }


