Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0F3C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AFA21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbeLTIwH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:52:07 -0500
Received: from [38.106.11.25] ([38.106.11.25]:35018 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728585AbeLTIwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:52:02 -0500
X-ASG-Debug-ID: 1545294764-107606139f1f270001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net (localhost [10.128.0.15]) by barracuda02.hxt-semitech.com with ESMTP id HqDp4uIJr6BN1EEa (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 20 Dec 2018 16:32:44 +0800 (CST)
X-Barracuda-Envelope-From: yanjiang.jin@hxt-semitech.com
Received: from controller.hxtcorp.net (10.5.21.105) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 20 Dec 2018 16:31:46 +0800
From:   Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
To:     <don.brace@microsemi.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <yanjiang.jin@hxt-semitech.com>
CC:     <yu.zheng@hxt-semitech.com>, <jinyanjiang@gmail.com>,
        <esc.storagedev@microsemi.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] How to reproduce this issue
Date:   Thu, 20 Dec 2018 16:32:34 +0800
X-ASG-Orig-Subj: [PATCH] How to reproduce this issue
Message-ID: <1545294755-29565-1-git-send-email-yanjiang.jin@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.105]
X-ClientProxiedBy: HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
Content-Transfer-Encoding: 8BIT
X-Barracuda-Connect: localhost[10.128.0.15]
X-Barracuda-Start-Time: 1545294764
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 1112
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.64134
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This happens only in the following combinations:

1. smartpqi is built as module, not built-in;
2. We have a disk connected to smartpqi card;
3. Both kexec's 1st and 2nd kernels use this disk as Rootfs' mount point.

This issue can be found on my ARM64 board: QDF2400:

kexec -l /boot/vmlinuz-4.20.0-rc6+ --initrd=/boot/initramfs-4.20.0-rc6+.img --append="$(cat /proc/cmdline)"
kexec -e

Yanjiang Jin (1):
  scsi: smartpqi: call pqi_free_interrupts() in pqi_shutdown()

 drivers/scsi/smartpqi/smartpqi_init.c | 1 +
 1 file changed, 1 insertion(+)

--
1.8.3.1




This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.


