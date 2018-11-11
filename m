Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13B3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793982084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNLxJVo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793982084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeKLKHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730039AbeKLIRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:01 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10E8921104;
        Sun, 11 Nov 2018 22:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975226;
        bh=IKP7ZDEvpA/E7zt2b+tyD2cfnFd19HNOMrd6yqGlCHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNLxJVo5XdYdkRGtFEYMJv/gJfDQm3DV44+ujby6sXBdJuNxiWPaXyxm4XEMYAW80
         3bI94wK/FvG+SEeGjDS9RCU8E/2qHz2dsDxojkWZndecpxfYaHaIw3CUww3HNlB30u
         j94c+fUgFLMibcHVfv8X5FvETyHd5Jr3cbdkM7Mw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        boris.ostrovsky@oracle.com, bp@alien8.de, corbet@lwn.net,
        linux-doc@vger.kernel.org, xen-devel@lists.xenproject.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 042/361] x86/xen: Fix boot loader version reported for PVH guests
Date:   Sun, 11 Nov 2018 14:16:29 -0800
Message-Id: <20181111221625.728414024@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 357d291ce035d1b757568058f3c9898c60d125b1 upstream.

The boot loader version reported via sysfs is wrong in case of the
kernel being booted via the Xen PVH boot entry. it should be 2.12
(0x020c), but it is reported to be 2.18 (0x0212).

As the current way to set the version is error prone use the more
readable variant (2 << 8) | 12.

Signed-off-by: Juergen Gross <jgross@suse.com>
Cc: <stable@vger.kernel.org> # 4.12
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boris.ostrovsky@oracle.com
Cc: bp@alien8.de
Cc: corbet@lwn.net
Cc: linux-doc@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Link: http://lkml.kernel.org/r/20181010061456.22238-2-jgross@suse.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/enlighten_pvh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -75,7 +75,7 @@ static void __init init_pvh_bootparams(v
 	 * Version 2.12 supports Xen entry point but we will use default x86/PC
 	 * environment (i.e. hardware_subarch 0).
 	 */
-	pvh_bootparams.hdr.version = 0x212;
+	pvh_bootparams.hdr.version = (2 << 8) | 12;
 	pvh_bootparams.hdr.type_of_loader = (9 << 4) | 0; /* Xen loader */
 
 	x86_init.acpi.get_root_pointer = pvh_get_root_pointer;


