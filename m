Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875C6C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D46020864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D46020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964997AbeFRIU4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:20:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55176 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935702AbeFRIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:20:53 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 507F2C7F;
        Mon, 18 Jun 2018 08:20:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Thelen <gthelen@google.com>,
        Tarick Bedeir <tarick@google.com>,
        Long Li <longli@microsoft.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 123/279] cifs: smbd: depend on INFINIBAND_ADDR_TRANS
Date:   Mon, 18 Jun 2018 10:11:48 +0200
Message-Id: <20180618080613.925107500@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Thelen <gthelen@google.com>

[ Upstream commit 3c6b03d18df657d677808d7090b4d03bc6026efd ]

CIFS_SMB_DIRECT code depends on INFINIBAND_ADDR_TRANS provided symbols.
So declare the kconfig dependency.  This is necessary to allow for
enabling INFINIBAND without INFINIBAND_ADDR_TRANS.

Signed-off-by: Greg Thelen <gthelen@google.com>
Cc: Tarick Bedeir <tarick@google.com>
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -198,7 +198,7 @@ config CIFS_SMB311
 
 config CIFS_SMB_DIRECT
 	bool "SMB Direct support (Experimental)"
-	depends on CIFS=m && INFINIBAND || CIFS=y && INFINIBAND=y
+	depends on CIFS=m && INFINIBAND && INFINIBAND_ADDR_TRANS || CIFS=y && INFINIBAND=y && INFINIBAND_ADDR_TRANS=y
 	help
 	  Enables SMB Direct experimental support for SMB 3.0, 3.02 and 3.1.1.
 	  SMB Direct allows transferring SMB packets over RDMA. If unsure,


