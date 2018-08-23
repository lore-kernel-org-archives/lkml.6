Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EFEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49592147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49592147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbeHWMBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:01:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731700AbeHWMBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:01:13 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6975A8B1;
        Thu, 23 Aug 2018 08:32:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 186/217] net/ethernet/freescale/fman: fix cross-build error
Date:   Thu, 23 Aug 2018 09:54:59 +0200
Message-Id: <20180823075513.988513575@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit c133459765fae249ba482f62e12f987aec4376f0 ]

  CC [M]  drivers/net/ethernet/freescale/fman/fman.o
In file included from ../drivers/net/ethernet/freescale/fman/fman.c:35:
../include/linux/fsl/guts.h: In function 'guts_set_dmacr':
../include/linux/fsl/guts.h:165:2: error: implicit declaration of function 'clrsetbits_be32' [-Werror=implicit-function-declaration]
  clrsetbits_be32(&guts->dmacr, 3 << shift, device << shift);
  ^~~~~~~~~~~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Madalin Bucur <madalin.bucur@nxp.com>
Cc: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/fsl/guts.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/fsl/guts.h
+++ b/include/linux/fsl/guts.h
@@ -16,6 +16,7 @@
 #define __FSL_GUTS_H__
 
 #include <linux/types.h>
+#include <linux/io.h>
 
 /**
  * Global Utility Registers.


