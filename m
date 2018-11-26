Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CAEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AAA20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N67SXR0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AAA20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeKZVrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:47:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeKZVrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:47:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7D7B2146F;
        Mon, 26 Nov 2018 10:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229597;
        bh=aDIdflKWOZv3ZeYsB70E6KEJCMvK/g44oi6IHydppK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N67SXR0UX8hgaFTOMKADmDRd1ziylXrWihGMybD88AoiMuMLUG/JPkJwgpB6NdVek
         OkDZqB8BUhx4NEKDbsgE+57jHkhq87QaWKDm6O/N9xh+OzhJyvy8+DvmGpV3Sf2FK1
         7F2BuBU/sFFOJe7dIzisxEPEU21VHzyIBjYZn8SY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3.18 23/24] new helper: uaccess_kernel()
Date:   Mon, 26 Nov 2018 11:51:17 +0100
Message-Id: <20181126105032.821148742@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
References: <20181126105029.790599475@linuxfoundation.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

commit db68ce10c4f0a27c1ff9fa0e789e5c41f8c4ea63 upstream.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[only take the include/linux/uaccess.h portion - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/uaccess.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -2,6 +2,9 @@
 #define __LINUX_UACCESS_H__
 
 #include <linux/preempt.h>
+
+#define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
+
 #include <asm/uaccess.h>
 
 /*


