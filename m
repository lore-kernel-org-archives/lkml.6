Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AC9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2C420840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2C420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbeHAUT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:19:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404197AbeHATDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 53AA7103A;
        Wed,  1 Aug 2018 17:00:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Luis R. Rodriguez" <mcgrof@suse.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 143/336] ima: based on policy verify firmware signatures (pre-allocated buffer)
Date:   Wed,  1 Aug 2018 18:47:58 +0200
Message-Id: <20180801165034.610410799@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

[ Upstream commit fd90bc559bfba743ae8de87ff23b92a5e4668062 ]

Don't differentiate, for now, between kernel_read_file_id READING_FIRMWARE
and READING_FIRMWARE_PREALLOC_BUFFER enumerations.

Fixes: a098ecd firmware: support loading into a pre-allocated buffer (since 4.8)
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/integrity/ima/ima_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -449,6 +449,7 @@ int ima_read_file(struct file *file, enu
 
 static int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
+	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,


