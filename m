Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156239-2-10256350036694566925
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156238; b=igtWshqKZt7cF/qeXdU5WR5N0zz4UEpLGEzlMGD0sLE3MYpO8e
    Uj5IYDsW98fQclkUCUkd9TvfgAr4VJLvlSt81bfYR40Vgx5Fs8jHPWAaBpNNzSej
    FVR+fn2dLqtu+TG3HoN3Bsdm9a0qb0vZo1DmZeGOZtSRVF1Vd8zKOiW1ipeNTMwj
    TRCBC5UFOAJHewFbvkPcVcwsFZq/0vfiinKYwuDNEZtIHyhd7EmZgFxihKoTC8qK
    bL3BY260AbWwlzxtk3tG2SLxbP+LWw6U/q3g53o9Ug5qxf+zzthTUSiqb5MSIdut
    yxm6goQlyniScala7Y0o5y7/k8qoFealLf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156238; bh=q3pvW9VhOGlo2WC5X5l9N9pm/glb5r
    Bm0K1mNrkxL8c=; b=jAUC5RWJRK9CoExEsM/ZofOCZeSODNcziHb+oz72W7J6qa
    Nk/mtXzx6Qp4N1+fyqg9mHLWPdzfVU94TSaSDHam5PP8Qkb0S4sfV+4czY49dIpY
    +OxRhV1WCOHhayASCr34/jg1vUNAopjNLWuVUZFuEV535ee0CGQVtYF7p0yolAFI
    LYyq2fc7VxtM32vkoaL69XBILPlj6KuVTagQSaLIzTDJ8pcZX2Fz/AOys/GWwxW5
    AwLzygV/ELkzq4AW1Gtvt9LAEaqKrh/KXkjcCMVfXEFOgnegE6SW3HWqP7qewgT5
    xookkdPQNnG7Xk+c9Hlxi0OpaqHb1ezIt9Ny6tPQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=du8KpxGI x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=du8KpxGI x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM9vXqNCo4di6K6dC5BUhiuTy45fB5dNVHExWkjf6Lex4rnLNdILjVe0gDm0ihxdi55RVCQvbTlkPAns3ZMfep88cNESlWLlf40jXZLSkC2oU9xsRKsu
    KpNuCjNvnu+Gqoau8+WiAvijOQiteK8ExNFjjkW9LLBweUlScaNWIbJClxC3oN4HupJ25N2C1CwBzhq6+MUNVLVTXiwQNIXsqHBPuYdTwMBLzN/FpjW5Ep8U
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=NOA20dJV2Ji-L_nyVyQA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031343AbeEXKDx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030922AbeEXKDt (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:03:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wilfried Weissmann <wilfried.weissmann@gmx.at>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 111/161] scsi: mvsas: fix wrong endianness of sgpio api
Date: Thu, 24 May 2018 11:38:56 +0200
Message-Id: <20180524093031.669148631@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wilfried Weissmann <wilfried.weissmann@gmx.at>

[ Upstream commit e75fba9c0668b3767f608ea07485f48d33c270cf ]

This patch fixes the byte order of the SGPIO api and brings it back in
sync with ledmon v0.80 and above.

[mkp: added missing SoB and fixed whitespace]

Signed-off-by: Wilfried Weissmann <wilfried.weissmann@gmx.at>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mvsas/mv_94xx.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/drivers/scsi/mvsas/mv_94xx.c
+++ b/drivers/scsi/mvsas/mv_94xx.c
@@ -1080,16 +1080,16 @@ static int mvs_94xx_gpio_write(struct mv
 			void __iomem *regs = mvi->regs_ex - 0x10200;
 
 			int drive = (i/3) & (4-1); /* drive number on host */
-			u32 block = mr32(MVS_SGPIO_DCTRL +
+			int driveshift = drive * 8; /* bit offset of drive */
+			u32 block = ioread32be(regs + MVS_SGPIO_DCTRL +
 				MVS_SGPIO_HOST_OFFSET * mvi->id);
 
-
 			/*
 			* if bit is set then create a mask with the first
 			* bit of the drive set in the mask ...
 			*/
-			u32 bit = (write_data[i/8] & (1 << (i&(8-1)))) ?
-				1<<(24-drive*8) : 0;
+			u32 bit = get_unaligned_be32(write_data) & (1 << i) ?
+				1 << driveshift : 0;
 
 			/*
 			* ... and then shift it to the right position based
@@ -1098,26 +1098,27 @@ static int mvs_94xx_gpio_write(struct mv
 			switch (i%3) {
 			case 0: /* activity */
 				block &= ~((0x7 << MVS_SGPIO_DCTRL_ACT_SHIFT)
-					<< (24-drive*8));
+					<< driveshift);
 					/* hardwire activity bit to SOF */
 				block |= LED_BLINKA_SOF << (
 					MVS_SGPIO_DCTRL_ACT_SHIFT +
-					(24-drive*8));
+					driveshift);
 				break;
 			case 1: /* id */
 				block &= ~((0x3 << MVS_SGPIO_DCTRL_LOC_SHIFT)
-					<< (24-drive*8));
+					<< driveshift);
 				block |= bit << MVS_SGPIO_DCTRL_LOC_SHIFT;
 				break;
 			case 2: /* fail */
 				block &= ~((0x7 << MVS_SGPIO_DCTRL_ERR_SHIFT)
-					<< (24-drive*8));
+					<< driveshift);
 				block |= bit << MVS_SGPIO_DCTRL_ERR_SHIFT;
 				break;
 			}
 
-			mw32(MVS_SGPIO_DCTRL + MVS_SGPIO_HOST_OFFSET * mvi->id,
-				block);
+			iowrite32be(block,
+				regs + MVS_SGPIO_DCTRL +
+				MVS_SGPIO_HOST_OFFSET * mvi->id);
 
 		}
 
@@ -1132,7 +1133,7 @@ static int mvs_94xx_gpio_write(struct mv
 			void __iomem *regs = mvi->regs_ex - 0x10200;
 
 			mw32(MVS_SGPIO_DCTRL + MVS_SGPIO_HOST_OFFSET * mvi->id,
-				be32_to_cpu(((u32 *) write_data)[i]));
+				((u32 *) write_data)[i]);
 		}
 		return reg_count;
 	}
