Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518323863-2-2148869159430683175
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518323863; b=VDyXiCxQWuC7KkWsKjVtFP56hnWDIlt9XKcec9WfHBhr74b
    RY9boo9XhoygJTZNDwrJWCDBxAlCN8zFyzB5F8cE1o7avO5u9ZhsgcKExwddFM9D
    mnHpYGeWcvqa+lIKENzUV7DRpNkNesv7iEVQviO6kwbdxXSSQHdc6xx2ac3FyOL2
    UaURJdOKO6agsF17tUbogHa3voJTeOG533uZya+3FnQ+aMQPPv7F8nNQFq7mOb33
    AkvF5ElR2CnaeSvQLmaPtT0lCzuzOdNWNorhrcPDs43WMA4n1mb+vF3omDnzVSlS
    +1/FyeQrsDHHl2hwwiRdWX/nvgfaWVxc1Mzgpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323863; bh=m5cDEkNbIwaRdxJn2yr
    5Zz2ke7jBXlECgb3Iu8/t548=; b=uBDDI048ebwcUVy06QyQOz8RN3A9PjcqNb0
    Qxo0jMM/rSTcdk5kDeMqIsDfwANdYqIjduNP3JJffUP1lkqokI8fkZJ29sHcKWHy
    V5UBJDlaIaJaE4H7q3flKmqVE1Z6tMZTZHrwRgPDbFihVkboLR8UiSyeSDNYGvo4
    Cuk25cIn7/+ywQyTz9vshhSp4e33SM3Z8hyyPEOOHPg3qQukwpkLBbDTYa4Oq7BM
    DBML+8JfWITCTkMtZYBy8Tq7/h7fUiKOCHCdf/xE+U7d109PqhXmONlL5f+8INXW
    I6wamwLN8C9cwzmxqMNukXAsp0sGVkS2gZddgEkwiRnXR6iX+hw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeBKEfA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:35:00 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41781 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753008AbeBKEeO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Vasily Gorbik" <gor@linux.vnet.ibm.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.722374926@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 082/136] s390/disassembler: increase show_code buffer
 size
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Gorbik <gor@linux.vnet.ibm.com>

commit b192571d1ae375e0bbe0aa3ccfa1a3c3704454b9 upstream.

Current buffer size of 64 is too small. objdump shows that there are
instructions which would require up to 75 bytes buffer (with current
formating). 128 bytes "ought to be enough for anybody".

Also replaces 8 spaces with a single tab to reduce the memory footprint.

Fixes the following KASAN finding:

BUG: KASAN: stack-out-of-bounds in number+0x3fe/0x538
Write of size 1 at addr 000000005a4a75a0 by task bash/1282

CPU: 1 PID: 1282 Comm: bash Not tainted 4.14.0+ #215
Hardware name: IBM 2964 N96 702 (z/VM 6.4.0)
Call Trace:
([<000000000011eeb6>] show_stack+0x56/0x88)
 [<0000000000e1ce1a>] dump_stack+0x15a/0x1b0
 [<00000000004e2994>] print_address_description+0xf4/0x288
 [<00000000004e2cf2>] kasan_report+0x13a/0x230
 [<0000000000e38ae6>] number+0x3fe/0x538
 [<0000000000e3dfe4>] vsnprintf+0x194/0x948
 [<0000000000e3ea42>] sprintf+0xa2/0xb8
 [<00000000001198dc>] print_insn+0x374/0x500
 [<0000000000119346>] show_code+0x4ee/0x538
 [<000000000011f234>] show_registers+0x34c/0x388
 [<000000000011f2ae>] show_regs+0x3e/0xa8
 [<000000000011f502>] die+0x1ea/0x2e8
 [<0000000000138f0e>] do_no_context+0x106/0x168
 [<0000000000139a1a>] do_protection_exception+0x4da/0x7d0
 [<0000000000e55914>] pgm_check_handler+0x16c/0x1c0
 [<000000000090639e>] sysrq_handle_crash+0x46/0x58
([<0000000000000007>] 0x7)
 [<00000000009073fa>] __handle_sysrq+0x102/0x218
 [<0000000000907c06>] write_sysrq_trigger+0xd6/0x100
 [<000000000061d67a>] proc_reg_write+0xb2/0x128
 [<0000000000520be6>] __vfs_write+0xee/0x368
 [<0000000000521222>] vfs_write+0x21a/0x278
 [<000000000052156a>] SyS_write+0xda/0x178
 [<0000000000e555cc>] system_call+0xc4/0x270

The buggy address belongs to the page:
page:000003d1016929c0 count:0 mapcount:0 mapping:          (null) index:0x0
flags: 0x0()
raw: 0000000000000000 0000000000000000 0000000000000000 ffffffff00000000
raw: 0000000000000100 0000000000000200 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 000000005a4a7480: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
 000000005a4a7500: 00 00 00 00 00 00 00 00 f2 f2 f2 f2 00 00 00 00
>000000005a4a7580: 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00 00 00
                               ^
 000000005a4a7600: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 f8 f8
 000000005a4a7680: f2 f2 f2 f2 f2 f2 f8 f8 f2 f2 f3 f3 f3 f3 00 00
==================================================================

Signed-off-by: Vasily Gorbik <gor@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/kernel/dis.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -1765,7 +1765,7 @@ void show_code(struct pt_regs *regs)
 {
 	char *mode = user_mode(regs) ? "User" : "Krnl";
 	unsigned char code[64];
-	char buffer[64], *ptr;
+	char buffer[128], *ptr;
 	mm_segment_t old_fs;
 	unsigned long addr;
 	int start, end, opsize, hops, i;
@@ -1828,7 +1828,7 @@ void show_code(struct pt_regs *regs)
 		start += opsize;
 		printk(buffer);
 		ptr = buffer;
-		ptr += sprintf(ptr, "\n          ");
+		ptr += sprintf(ptr, "\n\t  ");
 		hops++;
 	}
 	printk("\n");
