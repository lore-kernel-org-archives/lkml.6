Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F53C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E77420881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E77420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbeIMSzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:55:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60806 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbeIMSzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:55:40 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 68596D10;
        Thu, 13 Sep 2018 13:46:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 074/115] powerpc/platforms/85xx: fix t1042rdb_diu.c build errors & warning
Date:   Thu, 13 Sep 2018 15:31:34 +0200
Message-Id: <20180913131828.220709249@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit f5daf77a55ef0e695cc90c440ed6503073ac5e07 ]

Fix build errors and warnings in t1042rdb_diu.c by adding header files
and MODULE_LICENSE().

../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: warning: data definition has no type or storage class
 early_initcall(t1042rdb_diu_init);
../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: error: type defaults to 'int' in declaration of 'early_initcall' [-Werror=implicit-int]
../arch/powerpc/platforms/85xx/t1042rdb_diu.c:152:1: warning: parameter names (without types) in function declaration

and
WARNING: modpost: missing MODULE_LICENSE() in arch/powerpc/platforms/85xx/t1042rdb_diu.o

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/85xx/t1042rdb_diu.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/platforms/85xx/t1042rdb_diu.c
+++ b/arch/powerpc/platforms/85xx/t1042rdb_diu.c
@@ -9,8 +9,10 @@
  * option) any later version.
  */
 
+#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
@@ -150,3 +152,5 @@ static int __init t1042rdb_diu_init(void
 }
 
 early_initcall(t1042rdb_diu_init);
+
+MODULE_LICENSE("GPL");


