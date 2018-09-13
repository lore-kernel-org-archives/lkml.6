Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1869EC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87D920882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87D920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeIMRLH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:11:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727152AbeIMRLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:11:07 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8DBwjuZ059723
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 08:01:56 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mfp90u0u3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 08:01:55 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 13 Sep 2018 13:01:53 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Sep 2018 13:01:51 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8DC1owQ57933924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Sep 2018 12:01:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7DD711C066;
        Thu, 13 Sep 2018 15:01:38 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB45D11C05E;
        Thu, 13 Sep 2018 15:01:38 +0100 (BST)
Received: from mschwideX1 (unknown [9.152.212.164])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Sep 2018 15:01:38 +0100 (BST)
Date:   Thu, 13 Sep 2018 14:01:49 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.19 #3
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
X-TM-AS-GCONF: 00
x-cbid: 18091312-0016-0000-0000-00000204E4EB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091312-0017-0000-0000-0000325BB495
Message-Id: <20180913140149.3c39485c@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809130124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this is the first try to do a pull request for s390 with a signed tag.
I keep my fingers crossed that the setup works as intended.

I have used the 8A8FDAE0 signing sub-key of my 26AE5DD2 master key:

pub   rsa4096/26AE5DD2 2011-10-10 [SC]
uid         [ultimate] Martin Schwidefsky <schwidefsky@de.ibm.com>
sub   rsa4096/1F2A4B67 2011-10-10 [E]
sub   rsa2048/59DAAB8E 2018-09-11 [A]
sub   rsa2048/8A8FDAE0 2018-09-12 [S]

So here we go:

Please pull s390 fixes for 4.19-rc4

The following changes since commit 60c1f89241d49bacf71035470684a8d7b4bb46ea:

  Merge tag 'dma-mapping-4.19-2' of git://git.infradead.org/users/hch/dma-mapping (2018-09-02 20:09:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-4.19-3

for you to fetch changes up to fa108f95c6769ec15ea59b7db00454b82afc6121:

  s390/zcrypt: remove VLA usage from the AP bus (2018-09-12 11:33:37 +0200)

----------------------------------------------------------------
s390 fixes for 4.19-rc4

One fix for the zcrypt driver to correctly handle incomplete
encryption/decryption operations.

A cleanup for the aqmask/apmask parsing to avoid variable
length arrays on the stack.

----------------------------------------------------------------
Ingo Franzki (1):
      s390/crypto: Fix return code checking in cbc_paes_crypt()

Martin Schwidefsky (1):
      s390/zcrypt: remove VLA usage from the AP bus

 arch/s390/crypto/paes_s390.c |  2 +-
 drivers/s390/crypto/ap_bus.c | 86 +++++++++++++++++---------------------------
 2 files changed, 34 insertions(+), 54 deletions(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 80b2729..ab9a0eb 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -208,7 +208,7 @@ static int cbc_paes_crypt(struct blkcipher_desc *desc, unsigned long modifier,
 			      walk->dst.virt.addr, walk->src.virt.addr, n);
 		if (k)
 			ret = blkcipher_walk_done(desc, walk, nbytes - k);
-		if (n < k) {
+		if (k < n) {
 			if (__cbc_paes_set_key(ctx) != 0)
 				return blkcipher_walk_done(desc, walk, -EIO);
 			memcpy(param.key, ctx->pk.protkey, MAXPROTKEYSIZE);
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index ec891bc..f039266 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -872,8 +872,6 @@ static int hex2bitmap(const char *str, unsigned long *bitmap, int bits)
 	if (bits & 0x07)
 		return -EINVAL;
 
-	memset(bitmap, 0, bits / 8);
-
 	if (str[0] == '0' && str[1] == 'x')
 		str++;
 	if (*str == 'x')
@@ -895,25 +893,23 @@ static int hex2bitmap(const char *str, unsigned long *bitmap, int bits)
 }
 
 /*
- * str2clrsetmasks() - parse bitmask argument and set the clear and
- * the set bitmap mask. A concatenation (done with ',') of these terms
- * is recognized:
+ * modify_bitmap() - parse bitmask argument and modify an existing
+ * bit mask accordingly. A concatenation (done with ',') of these
+ * terms is recognized:
  *   +<bitnr>[-<bitnr>] or -<bitnr>[-<bitnr>]
  * <bitnr> may be any valid number (hex, decimal or octal) in the range
  * 0...bits-1; the leading + or - is required. Here are some examples:
  *   +0-15,+32,-128,-0xFF
  *   -0-255,+1-16,+0x128
  *   +1,+2,+3,+4,-5,-7-10
- * Returns a clear and a set bitmask. Every positive value in the string
- * results in a bit set in the set mask and every negative value in the
- * string results in a bit SET in the clear mask. As a bit may be touched
- * more than once, the last 'operation' wins: +0-255,-128 = all but bit
- * 128 set in the set mask, only bit 128 set in the clear mask.
+ * Returns the new bitmap after all changes have been applied. Every
+ * positive value in the string will set a bit and every negative value
+ * in the string will clear a bit. As a bit may be touched more than once,
+ * the last 'operation' wins:
+ * +0-255,-128 = first bits 0-255 will be set, then bit 128 will be
+ * cleared again. All other bits are unmodified.
  */
-static int str2clrsetmasks(const char *str,
-			   unsigned long *clrmap,
-			   unsigned long *setmap,
-			   int bits)
+static int modify_bitmap(const char *str, unsigned long *bitmap, int bits)
 {
 	int a, i, z;
 	char *np, sign;
@@ -922,9 +918,6 @@ static int str2clrsetmasks(const char *str,
 	if (bits & 0x07)
 		return -EINVAL;
 
-	memset(clrmap, 0, bits / 8);
-	memset(setmap, 0, bits / 8);
-
 	while (*str) {
 		sign = *str++;
 		if (sign != '+' && sign != '-')
@@ -940,13 +933,10 @@ static int str2clrsetmasks(const char *str,
 			str = np;
 		}
 		for (i = a; i <= z; i++)
-			if (sign == '+') {
-				set_bit_inv(i, setmap);
-				clear_bit_inv(i, clrmap);
-			} else {
-				clear_bit_inv(i, setmap);
-				set_bit_inv(i, clrmap);
-			}
+			if (sign == '+')
+				set_bit_inv(i, bitmap);
+			else
+				clear_bit_inv(i, bitmap);
 		while (*str == ',' || *str == '\n')
 			str++;
 	}
@@ -970,44 +960,34 @@ static int process_mask_arg(const char *str,
 			    unsigned long *bitmap, int bits,
 			    struct mutex *lock)
 {
-	int i;
+	unsigned long *newmap, size;
+	int rc;
 
 	/* bits needs to be a multiple of 8 */
 	if (bits & 0x07)
 		return -EINVAL;
 
+	size = BITS_TO_LONGS(bits)*sizeof(unsigned long);
+	newmap = kmalloc(size, GFP_KERNEL);
+	if (!newmap)
+		return -ENOMEM;
+	if (mutex_lock_interruptible(lock)) {
+		kfree(newmap);
+		return -ERESTARTSYS;
+	}
+
 	if (*str == '+' || *str == '-') {
-		DECLARE_BITMAP(clrm, bits);
-		DECLARE_BITMAP(setm, bits);
-
-		i = str2clrsetmasks(str, clrm, setm, bits);
-		if (i)
-			return i;
-		if (mutex_lock_interruptible(lock))
-			return -ERESTARTSYS;
-		for (i = 0; i < bits; i++) {
-			if (test_bit_inv(i, clrm))
-				clear_bit_inv(i, bitmap);
-			if (test_bit_inv(i, setm))
-				set_bit_inv(i, bitmap);
-		}
+		memcpy(newmap, bitmap, size);
+		rc = modify_bitmap(str, newmap, bits);
 	} else {
-		DECLARE_BITMAP(setm, bits);
-
-		i = hex2bitmap(str, setm, bits);
-		if (i)
-			return i;
-		if (mutex_lock_interruptible(lock))
-			return -ERESTARTSYS;
-		for (i = 0; i < bits; i++)
-			if (test_bit_inv(i, setm))
-				set_bit_inv(i, bitmap);
-			else
-				clear_bit_inv(i, bitmap);
+		memset(newmap, 0, size);
+		rc = hex2bitmap(str, newmap, bits);
 	}
+	if (rc == 0)
+		memcpy(bitmap, newmap, size);
 	mutex_unlock(lock);
-
-	return 0;
+	kfree(newmap);
+	return rc;
 }
 
 /*

