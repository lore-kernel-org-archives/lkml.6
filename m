Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B620AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A935214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfAKJA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:00:27 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:35523 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbfAKJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:00:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TI.KgAr_1547197174;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TI.KgAr_1547197174)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Jan 2019 16:59:34 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     jarkko.sakkinen@linux.intel.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        tweek@google.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang.jia@linux.alibaba.com
Subject: [PATCH v2 0/2] tpm/eventlog/tpm1: Small fixes
Date:   Fri, 11 Jan 2019 16:59:31 +0800
Message-Id: <1547197173-52826-1-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since V1:

- Add test results with LTP.
- Rewrite patch 1's commit header.

Here is the test result with LTP testcase ima_tpm.sh which is used
to verify binary_bios_measurements.

ima_tpm 1 TINFO: timeout per run is 0h 5m 0s
ima_tpm 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-5.0.0-rc1+ root=UUID=c665e92c-736d-4b08-9143-a57396f935f3 ro rootwait crashkernel=auto console=tty0 console=ttyS0,115200 reboot=efi ima_hash=sha1
ima_tpm 1 TINFO: verify boot aggregate
ima_tpm 1 TPASS: bios aggregate matches IMA boot aggregate
ima_tpm 2 TINFO: verify PCR values
ima_tpm 2 TINFO: evmctl version: evmctl 1.1
ima_tpm 2 TCONF: TPM Hardware Support not enabled in kernel or no TPM chip found

Summary:
passed   1
failed   0   
skipped  1   
warnings 0

Note:
The 2nd test in ima_tpm requires /sys/class/tpm/tpm0/device/pcrs but this
interface is not available if TPM2 device used. So the test result showed
above is expected.

Jia
