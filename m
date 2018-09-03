Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CE3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E29020779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E29020779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeICVMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:12:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36404 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbeICVMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:12:50 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 54EC6CEE;
        Mon,  3 Sep 2018 16:51:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rian Hunter <rian@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bpetkov@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dmitry Safonov <dima@arista.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 3.18 42/56] x86/process: Re-export start_thread()
Date:   Mon,  3 Sep 2018 18:49:32 +0200
Message-Id: <20180903164926.148130367@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rian Hunter <rian@alum.mit.edu>

commit dc76803e57cc86589c4efcb5362918f9b0c0436f upstream.

The consolidation of the start_thread() functions removed the export
unintentionally. This breaks binfmt handlers built as a module.

Add it back.

Fixes: e634d8fc792c ("x86-64: merge the standard and compat start_thread() functions")
Signed-off-by: Rian Hunter <rian@alum.mit.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180819230854.7275-1-rian@alum.mit.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/process_64.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -438,6 +438,7 @@ __switch_to(struct task_struct *prev_p,
 
 	return prev_p;
 }
+EXPORT_SYMBOL_GPL(start_thread);
 
 void set_personality_64bit(void)
 {


