Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836058-2-13688471282186916646
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836057; b=vSr4FEjThAyjS8ct7AEaTmZk9xT45/VqBcD3FyHn8aULtxX
    3x6N/X2hmAcnuScVyVVDXlX6lxTusIaUcGgImKY1bA8eUyeUN4x7M65aU1A4Y4iE
    /Gzr9Z8tWfvoIzbFPX7L0DU1c+50jrBWjH4rY+aronfyCoSJgtIjdFmHvW5duWqj
    BLVkIXYHQoL3Rx/cPrPYv33F88j/jyDcLGVrkP1ordQ+6F1xvnNHYrmYNlPr5HhJ
    gFnsq5OCX3atMgc27/PLZGeltZq1CVXFYMUzpkkYqbvpV6d0vTvTC0mWCD9XQMwX
    7/hKpk1iG+br163KCKq6KMje3VnY4h/URMiqwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836057; bh=XnBzcxXIeP4X/vRMf6e
    4+jUv84yEJ1ohNRSsyVBIQU0=; b=RRuDa+GBy/YxFmOAgN4dKmFuXX9cfaT2XMT
    pe743aBeXIHPeYuWakuI5pB2D9TA9ApKZqMMJsmCXkxR66OcVzgyPk+HlRHsARWH
    lBAf61och4NBv997iyWSXroWUQgs+T/767S/+QOI7l3doyeUTTrAfRWDKS3U0pWZ
    oyYo1pNvTm5kjgah0ogsxd6ua1lp2IGo6kgsYWvu+I4DznhVdK0Ua2G+4j3Uprvs
    fxIACuLeelKmh7kYyDG49px4pm5K7lLTUx/7FNC3/ow97AIKKIQb0OMC4ohZ5VCR
    wmSuL9HdCQ5Evgyp90OKD2TJxixl3fboroz9w8wPhzY3Tg2Qvjw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934058AbeB1QDu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:03:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34786 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932290AbeB1QDs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:03:48 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Wolfram Sang" <wsa@the-dreams.de>,
        "Jeremy Compostella" <jeremy.compostella@intel.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.761268775@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 217/254] i2c: core-smbus: prevent stack corruption on
 read I2C_BLOCK_DATA
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Compostella <jeremy.compostella@intel.com>

commit 89c6efa61f5709327ecfa24bff18e57a4e80c7fa upstream.

On a I2C_SMBUS_I2C_BLOCK_DATA read request, if data->block[0] is
greater than I2C_SMBUS_BLOCK_MAX + 1, the underlying I2C driver writes
data out of the msgbuf1 array boundary.

It is possible from a user application to run into that issue by
calling the I2C_SMBUS ioctl with data.block[0] greater than
I2C_SMBUS_BLOCK_MAX + 1.

This patch makes the code compliant with
Documentation/i2c/dev-interface by raising an error when the requested
size is larger than 32 bytes.

Call Trace:
 [<ffffffff8139f695>] dump_stack+0x67/0x92
 [<ffffffff811802a4>] panic+0xc5/0x1eb
 [<ffffffff810ecb5f>] ? vprintk_default+0x1f/0x30
 [<ffffffff817456d3>] ? i2cdev_ioctl_smbus+0x303/0x320
 [<ffffffff8109a68b>] __stack_chk_fail+0x1b/0x20
 [<ffffffff817456d3>] i2cdev_ioctl_smbus+0x303/0x320
 [<ffffffff81745aed>] i2cdev_ioctl+0x4d/0x1e0
 [<ffffffff811f761a>] do_vfs_ioctl+0x2ba/0x490
 [<ffffffff81336e43>] ? security_file_ioctl+0x43/0x60
 [<ffffffff811f7869>] SyS_ioctl+0x79/0x90
 [<ffffffff81a22e97>] entry_SYSCALL_64_fastpath+0x12/0x6a

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/i2c/i2c-core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2481,16 +2481,17 @@ static s32 i2c_smbus_xfer_emulated(struc
 				   the underlying bus driver */
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
+			dev_err(&adapter->dev, "Invalid block %s size %d\n",
+				read_write == I2C_SMBUS_READ ? "read" : "write",
+				data->block[0]);
+			return -EINVAL;
+		}
+
 		if (read_write == I2C_SMBUS_READ) {
 			msg[1].len = data->block[0];
 		} else {
 			msg[0].len = data->block[0] + 1;
-			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 1) {
-				dev_err(&adapter->dev,
-					"Invalid block write size %d\n",
-					data->block[0]);
-				return -EINVAL;
-			}
 			for (i = 1; i <= data->block[0]; i++)
 				msgbuf0[i] = data->block[i];
 		}
