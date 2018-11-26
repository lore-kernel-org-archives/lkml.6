Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D10AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E771C2147D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jao9msDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E771C2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeKZVwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:52:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbeKZVwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:52:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E43D2146F;
        Mon, 26 Nov 2018 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229898;
        bh=zEMlwzXhDOCRzCUfVwbqxGG0BEH9ywp1o6zFPO/abrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jao9msDwvw3q4jgcPMwerU/Atw9wgXLeVKNfG1BUgDGBAcwFNwIVyqNuN46SpJOnF
         bU9EGPJd160fHAbEjZsUD8C86KwjZp8ilvXHEQCZZTvHrKGKZXExg8zUgMrt4gFVq0
         rA8gkiC2BYOW90eNHZvkA0c75DIwu/ujvzFWlQHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 44/46] new helper: uaccess_kernel()
Date:   Mon, 26 Nov 2018 11:51:33 +0100
Message-Id: <20181126105050.249803744@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
 #include <linux/sched.h>
+
+#define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
+
 #include <asm/uaccess.h>
 
 static __always_inline void pagefault_disabled_inc(void)


