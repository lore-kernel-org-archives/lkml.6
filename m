Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3171573-1521210826-2-12253671682022475928
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521210826; b=EQQfNIh3LxZTVAL2MXTGJgaF3TuPv/ZF6xUBsHDcGqKfb5O
    7m6rXjzpwlghQMD4jzqne6KkbFtsnLcAIDYt+nNjZaISu3yT8tKNzuyR9F9abxaB
    +ucofrZ0xw1b8r5IfDkh1lrKLlC02qlrG5Q/IbFjTfH1ntRRrJz/gZhQUXUtuut2
    CNvcos852xq5CGN9IiLLJLP5FFZU4uKIRuNpnghE+nbhjsh/OBjNKGgDWy9HQzQu
    pWOZBQKfeQpu13gUPTWLHt3Zrja8bYN4GjXZkSkckUeWcwvi3oZTU08uTtXqqmZc
    x5P7ma8XVtihIzeWrha0vEm8e6agGGXccU+DdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521210826; bh=dgnDlRevsVJT6ecN8NzL2+MtCH
    eTbp4xxWsoiontkTQ=; b=Mrs6vI9xktuTnUYnBqTGToKs5R2QIOA/kzYiMllttk
    0lG32FLWUOc8jPjvKiHSfcyCODwbji+qovzXFaiHger8/H0iV41ucJiKF40KKry9
    F88+QWoY8P4NrxIuoeiJGyU0Nm7gkh9MujbCePe0c3r0s9CCLB/Hj4aYXjGtcPIz
    MDGoTfOeGm2wO9TWO1azaHxacN9RAhIPkcQcIY3plbvx5G9ItEJBqt011i4tt2d0
    U/kGX9NPADKYF+OfbcTiuEasrgLY5SxBM8EIRF6mIdf8ughs3GUP7dk6pPLnKfjV
    TdMniHs5XumXQceFrn9+VW+8Dray34WhSb3pwo3403gA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=R1BR20f1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lTvkuQm7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=R1BR20f1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lTvkuQm7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeCPOdo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 10:33:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42435 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeCPOdn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 10:33:43 -0400
X-Google-Smtp-Source: AG47ELsJN83GzQCYzCfOUV9rTe3MAlQW9eQK0zcz9PnY5u3w2S3X1kR0Iqgut0ugXcny50+4EKAKng==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] libata: blacklist Micron 500IT SSD with MU01 firmware
Date: Fri, 16 Mar 2018 14:33:39 +0000
Message-Id: <1521210819-9225-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

While whitelisting Micron M500DC drives, the tweaked blacklist entry
enabled queued TRIM from M500IT variants also. But these do not support
queued TRIM. And while using those SSDs with the latest kernel we have
seen errors and even the partition table getting corrupted.

Some part from the dmesg:
[    6.727384] ata1.00: ATA-9: Micron_M500IT_MTFDDAK060MBD, MU01, max UDMA/133
[    6.727390] ata1.00: 117231408 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    6.741026] ata1.00: supports DRM functions and may not be fully accessible
[    6.759887] ata1.00: configured for UDMA/133
[    6.762256] scsi 0:0:0:0: Direct-Access     ATA      Micron_M500IT_MT MU01 PQ: 0 ANSI: 5

and then for the error:
[  120.860334] ata1.00: exception Emask 0x1 SAct 0x7ffc0007 SErr 0x0 action 0x6 frozen
[  120.860338] ata1.00: irq_stat 0x40000008
[  120.860342] ata1.00: failed command: SEND FPDMA QUEUED
[  120.860351] ata1.00: cmd 64/01:00:00:00:00/00:00:00:00:00/a0 tag 0 ncq dma 512 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x5 (timeout)
[  120.860353] ata1.00: status: { DRDY }
[  120.860543] ata1: hard resetting link
[  121.166128] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  121.166376] ata1.00: supports DRM functions and may not be fully accessible
[  121.186238] ata1.00: supports DRM functions and may not be fully accessible
[  121.204445] ata1.00: configured for UDMA/133
[  121.204454] ata1.00: device reported invalid CHS sector 0
[  121.204541] sd 0:0:0:0: [sda] tag#18 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte=0x08
[  121.204546] sd 0:0:0:0: [sda] tag#18 Sense Key : 0x5 [current] 
[  121.204550] sd 0:0:0:0: [sda] tag#18 ASC=0x21 ASCQ=0x4 
[  121.204555] sd 0:0:0:0: [sda] tag#18 CDB: opcode=0x93 93 08 00 00 00 00 00 04 28 80 00 00 00 30 00 00
[  121.204559] print_req_error: I/O error, dev sda, sector 272512

After few reboots with these errors, and the SSD is corrupted.
After blacklisting it, the errors are not seen and the SSD does not get
corrupted any more.

Fixes: 243918be6393 ("libata: Do not blacklist Micron M500DC")
Cc: stable@vger.kernel.org
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cb789f8..1fb96c6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4539,6 +4539,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
+	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.1.4
