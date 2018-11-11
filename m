Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3233EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD8020869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIOYZBND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD8020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389512AbeKLJOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:14:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387533AbeKLIUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:53 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F26521780;
        Sun, 11 Nov 2018 22:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975456;
        bh=nbVCad14Z3HrL6p3oXBS/PZhLwIgLuuRwtIjYLbp9+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIOYZBND/2/gQWPyqKz1PTHCalNJ7QQiUME1tDR6F59KEdKackwHSH+gpDjKAYI4m
         wuL9z0FN8ZKuVj0RVt6fETBgUVP8IbWjuoG27oivKBIJTd+fGUWyH+jCh1XTjN6ydg
         9qapr34eNcro2wk5qUdkZUaH65CKvgccGTbEJogw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.18 201/350] xen/pvh: increase early stack size
Date:   Sun, 11 Nov 2018 14:21:05 -0800
Message-Id: <20181111221716.449190527@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Pau Monne <roger.pau@citrix.com>

commit 7deecbda3026f5e2a8cc095d7ef7261a920efcf2 upstream.

While booting on an AMD EPYC box the stack canary would detect stack
overflows when using the current PVH early stack size (256). Switch to
using the value defined by BOOT_STACK_SIZE, which prevents the stack
overflow.

Cc: <stable@vger.kernel.org> # 4.11
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/xen-pvh.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -181,7 +181,7 @@ canary:
 	.fill 48, 1, 0
 
 early_stack:
-	.fill 256, 1, 0
+	.fill BOOT_STACK_SIZE, 1, 0
 early_stack_end:
 
 	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,


