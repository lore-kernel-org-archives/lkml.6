Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC96C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4D820645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4D820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeIHB6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:58:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42564 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeIHB6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:58:20 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 51F5CFA4;
        Fri,  7 Sep 2018 21:15:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luke Dashjr <luke-jr+git@utopios.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 036/145] powerpc64/ftrace: Include ftrace.h needed for enable/disable calls
Date:   Fri,  7 Sep 2018 23:08:22 +0200
Message-Id: <20180907210907.429505356@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luke Dashjr <luke@dashjr.org>

commit d6ee76d3d37d156c479348821574b6f99d6472a1 upstream.

this_cpu_disable_ftrace and this_cpu_enable_ftrace are inlines in
ftrace.h Without it included, the build fails.

Fixes: a4bc64d305af ("powerpc64/ftrace: Disable ftrace during kvm entry/exit")
Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
Acked-by: Naveen N. Rao <naveen.n.rao at linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_hv.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -46,6 +46,7 @@
 #include <linux/compiler.h>
 #include <linux/of.h>
 
+#include <asm/ftrace.h>
 #include <asm/reg.h>
 #include <asm/ppc-opcode.h>
 #include <asm/asm-prototypes.h>


