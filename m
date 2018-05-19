Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1975806-1526765395-2-8313676983630885256
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526765394; b=Cu3CCFjcXHSMGyoh7KUxgkPCfnEvu3F19PsDaVPSlZbvNaZhdO
    sHuDmz5rOepaR11/gPWPZmLBILTK2xQU8yUPQa0RAt8S555T0UWjyWyV5kM5gBCt
    9UTuGQV5V7qkE8CSLRRY9b2h5i8Uf0UeyhQA6fPm9qNGhQO2FtElHkq+3GpLmD8e
    khJOuwP7Fj0pw4fvLssfeJbiCnLjKWZPpaAmLsZVJCHzhEXp47Oq+LOQ7J60zWyd
    SdRR4m6HJbln/S+MJNdlV2cLLow0Zt7nnr4FLSzatEowSAMIQiW3it7mEXOJgQCB
    k9CQOhWdN9cgzduySgOnJ29hodQjV8wyafBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526765394; bh=SyfqNYIxu8sV/hzMGTngwy0tjUDtoA
    4hVGT/q6vDBx0=; b=G38aPITz3ZIE9UQWfQHYKfAinCPmLhLwSmDctuEuAwEIL0
    tXIsVZ1jRALplH7RGOjQr6UAgu8R/IwWVgUMECHtJeT++vENuYKCbXB5w0kQ2YYo
    RTPGdzxr0nDJbh6dbPwXwODhQsSbwvHWDYXh05kp+kkLWSLLA3xi/lCtZT0Mhzo7
    z+rwXJ9GirXbaPCfgb9K25z9p/277mRS3PNu4xKE33l8R5ue2NYRsUvsKx5R6I2Q
    E2Dw6hXQin7D6NahlIvq8NqT6+03w2gv53nzIjZabKjtEoCZSOwwp91ucpbqTMZh
    ZrUeZ5IactHNim60IaGtkectrEtu7heyjTp8RWZA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=fV/gMo33 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=TeH4zVyx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=fV/gMo33 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=TeH4zVyx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBxIZvQI5gS6cBLBcWd/Ekl441rPCQQOHKG5TYV29APkLAzMZUQIyddtC8ygLpOZ1di82t2934DIIApuYpzgHNpSHb0Ku+MQQT7sGxIpIXJQyweLPIh/
    tuBDdrmOdsQihIigTLRXTqYxEV/mVmi9W48Qvjtp1qgz4byzcOJOtMZNjBtK2m8DjzcsmC6myKEbXfyI2YgvXco/lnq2IJLHrldxmXhWhutkm6eCaJCZPuhq
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=zLncjWLdyN0A:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
    a=BSTGaPtrplHwReIcmCQA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeESV3r (ORCPT <rfc822;greg@kroah.com>);
        Sat, 19 May 2018 17:29:47 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35403 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbeESV3q (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 19 May 2018 17:29:46 -0400
X-Google-Smtp-Source: AB8JxZp6DdvV/F5Qvxm+3BTiYNgGrr38hamZ2MBD6PHvHUYGK7g9QMwK/GOHl9L6bRfh4+a06zTTpA==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
X-Google-Original-From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH resend] libata: blacklist Micron 500IT SSD with MU01 firmware
Date: Sat, 19 May 2018 22:29:36 +0100
Message-Id: <20180519212936.3155-1-sudip.mukherjee@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

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
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

This is a resend of v1.
v2 was blacklisting all Micron SSDs but Martin has confirmed that
only M500IT with MU01 firmware is affected.

 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index eaf0f42f6f28..cdcd55cb2a9a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4554,6 +4554,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
+	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.11.0
