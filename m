Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3721122-1525017708-5-13382130729999183719
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525017707; b=iinNNgPKDlcNAbfCrYhKQ+g6kxpikzrNzuKr3LZVh/SaEJJNPQ
    F5JAH7x6z8yvfXYB7/TJEEoqBanzbpmjMHHqGeZw4Y3I3T4vWwUqlXERtt4PU7Rc
    O0G0JzdBl3LZpwmbyL/H9+OcPJoQDxUqmt+lJkedzbDY2doTZSVpEHn8KSPyOMkt
    6iautGNvcWXRPlNdUj2tJf/Mtt6IYod3KS/qgZX+khwy9RqmTboUDnwe5E5Th47U
    99VCXmvUpBe+ts3MsK0CMUzyXG+0gZrKRkNiCbxbGGn+0om96b54vD2LQprRDyEE
    aBAIPpMUx/ZZ/sow0E+zreAkND50BO05gXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525017707; bh=ADO+APEPxkeDTFuMDXFLDRN4Kp5k5U
    YUlxYyldz60nQ=; b=m2pFmvpZn4Pg0hbP8R/MRKXPLPpa2HnlcNssG/mWyYlyLA
    9kGhP2gpElnPEK9a3sRaGU3y5j1eTrj5LYvwdAO9DDNMar+rdazWvReoAJHOIBde
    kpcjUWxkOiXpZzAtzE+DiGNG8wXCJb3RSG0qgMLDuWu9njVGNYeTKyti1xlNwIsK
    GfYChT89mnzCxTYT9WmFvVgYjf091FPCsWefemZOaouJg3pMZMH5AtPkItgSEvUV
    QjfpBGWPF8zcqIj58lUxyqJqFKJNhFY40k3rNgB2chi+6MR4R45EGSN2DJSpROKw
    h2o5XCO+vhd01ale8RGwuVmSnZqhKLYdxJU+Q0pQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HukniSqb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KpJ26cqk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HukniSqb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KpJ26cqk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHSzA5ZYBa2VZjT1pDnaEyfsQiHZW3lytJk934lXwmqOzu/1bNqw3dE4ePrf/U2x2dRQrFzbVQsM4va4anqVDUke4DheU2Wm4OOL6kuRb5wLqF1+1OvS
    0WpMbQDW/PJVfeGnVieax9tFNM/g6f2mPsJP/SNy5ImDzHUQ0OoiLZh2RNdmSJon/DjUt59zc9iqCLHM/cQnayDaYrQvaqSX8sQNo+vNj6bsb806Jbrrz4GC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=zLncjWLdyN0A:10
    a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
    a=BSTGaPtrplHwReIcmCQA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeD2QBp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 29 Apr 2018 12:01:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46637 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753584AbeD2QBo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 29 Apr 2018 12:01:44 -0400
X-Google-Smtp-Source: AB8JxZoR6JujgMnxPDZaPpnyO3xUfanT3sN50nHtVPoOu4JRoDqSH/cH6M6sDGPh/nTa8NAleDW5FQ==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
X-Google-Original-From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        stable@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2] libata: blacklist Micron SSD
Date: Sun, 29 Apr 2018 17:01:38 +0100
Message-Id: <20180429160138.11091-1-sudip.mukherjee@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

While whitelisting Micron M500DC drives, the tweaked blacklist entry
enabled queued TRIM for M500IT variants also. But these do not support
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

We know that M500IT MG02 and M500DC support this feature, Martin asked
Micron for a list of SSDs which have support for this feature. But there
was no reply. It is best to blacklst all Micron SSDs for now, except the
known two variants, to prevent corrupting other Micron SSDs which do not
support this.

Fixes: 243918be6393 ("libata: Do not blacklist Micron M500DC")
Cc: stable@vger.kernel.org
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

v1: Only M500IT MU01 was blacklisted.

v2: Whitelist M500IT BG02 and M500DC and then blacklist all other Micron. 

 drivers/ata/libata-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8bc71ca61e7f..df5d716c0a07 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4550,7 +4550,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
-	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	{ "Micron_M500DC*",		NULL,	0},
+	{ "Micron_M500IT_*",		"MG02",	0},
+	{ "Micron_M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-- 
2.11.0
