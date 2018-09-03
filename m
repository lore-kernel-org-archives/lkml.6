Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B54FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F9020661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F9020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbeICVqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:46:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbeICVqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:46:18 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DFE61D38;
        Mon,  3 Sep 2018 17:25:10 +0000 (UTC)
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
Subject: [PATCH 4.14 115/165] x86/process: Re-export start_thread()
Date:   Mon,  3 Sep 2018 18:56:41 +0200
Message-Id: <20180903165701.310870470@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -370,6 +370,7 @@ start_thread(struct pt_regs *regs, unsig
 	start_thread_common(regs, new_ip, new_sp,
 			    __USER_CS, __USER_DS, 0);
 }
+EXPORT_SYMBOL_GPL(start_thread);
 
 #ifdef CONFIG_COMPAT
 void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp)


