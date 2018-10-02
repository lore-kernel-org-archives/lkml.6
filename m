Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CE5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A16A206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A16A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeJBUKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:10:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeJBUKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:44 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9EBA5C2A;
        Tue,  2 Oct 2018 13:27:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 056/228] s390/sysinfo: add missing #ifdef CONFIG_PROC_FS
Date:   Tue,  2 Oct 2018 06:22:33 -0700
Message-Id: <20181002132503.063210757@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[ Upstream commit 9f35b818a2f90fb6cb291aa0c9f835d4f0974a9a ]

Get rid of this compile warning for !PROC_FS:

  CC      arch/s390/kernel/sysinfo.o
arch/s390/kernel/sysinfo.c:275:12: warning: 'sysinfo_show' defined but not used [-Wunused-function]
 static int sysinfo_show(struct seq_file *m, void *v)

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/sysinfo.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -59,6 +59,8 @@ int stsi(void *sysinfo, int fc, int sel1
 }
 EXPORT_SYMBOL(stsi);
 
+#ifdef CONFIG_PROC_FS
+
 static bool convert_ext_name(unsigned char encoding, char *name, size_t len)
 {
 	switch (encoding) {
@@ -301,6 +303,8 @@ static int __init sysinfo_create_proc(vo
 }
 device_initcall(sysinfo_create_proc);
 
+#endif /* CONFIG_PROC_FS */
+
 /*
  * Service levels interface.
  */


