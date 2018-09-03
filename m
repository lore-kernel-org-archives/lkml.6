Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FA0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F1D2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F1D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbeICVj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:39:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43146 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbeICVj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:39:59 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BC36BD09;
        Mon,  3 Sep 2018 17:18:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 070/165] sparc: use asm-generic version of msi.h
Date:   Mon,  3 Sep 2018 18:55:56 +0200
Message-Id: <20180903165658.610843044@linuxfoundation.org>
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

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

[ Upstream commit 12be1036c536f849ad6f9bba73cffa708aa965c3 ]

This is necessary to be able to include <linux/msi.h> when
CONFIG_GENERIC_MSI_IRQ_DOMAIN is enabled. Without this, a build with
CONFIG_GENERIC_MSI_IRQ_DOMAIN fails with:

   In file included from drivers//ata/ahci.c:45:0:
>> include/linux/msi.h:226:10: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
             msi_alloc_info_t *arg);
             ^~~~~~~~~~~~~~~~
             sg_alloc_fn
   include/linux/msi.h:230:9: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
            msi_alloc_info_t *arg);
            ^~~~~~~~~~~~~~~~
            sg_alloc_fn
   include/linux/msi.h:239:12: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
               msi_alloc_info_t *arg);
               ^~~~~~~~~~~~~~~~
               sg_alloc_fn
   include/linux/msi.h:240:22: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
     void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
                         ^~~~~~~~~~~~~~~~
                         sg_alloc_fn
   include/linux/msi.h:241:20: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
     void  (*set_desc)(msi_alloc_info_t *arg,
                       ^~~~~~~~~~~~~~~~
                       sg_alloc_fn
   include/linux/msi.h:316:18: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
           int nvec, msi_alloc_info_t *args);
                     ^~~~~~~~~~~~~~~~
                     sg_alloc_fn
   include/linux/msi.h:318:29: error: unknown type name 'msi_alloc_info_t'; did you mean 'sg_alloc_fn'?
            int virq, int nvec, msi_alloc_info_t *args);
                                ^~~~~~~~~~~~~~~~
                                sg_alloc_fn

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/include/asm/Kbuild |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -14,6 +14,7 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += module.h
+generic-y += msi.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += serial.h


