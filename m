Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834991-2-3904989521851739944
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
    t=1519834990; b=Yq4yvR8RaZPeTdnBigW/OQ7+DdelJ6m4oGz9KqKBwHrDbLG
    efNAV1AxTtTNEao6wPI20jHKzN/uRz/+lFxTcEmeIOaJIp7DjVNBkY3sY/+boR6V
    0c43k2znWHMuBDKTqe97trYn9x+wnMMAdayLPcG0ijQhJAL7OKEBj1/E4EpYQy+t
    zA0YzyuQPMOvwYq46HwIeZyakXiAp3VP9vJICMqzQdvDhmQO+eJEn3KzgMhAq9AN
    Zqkxgc+jzusirdtEZPw2XeqVDUbXhhPagtlrfX+ywx6+GhB/4MTAITSNztJBgq5F
    sipWdZqHZw50rdhWhLN8iHa1Up++jUW/pXHre2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834990; bh=sfrpRTgefygs2+rLTsC
    UGdq57ZVimiV+WbGU4W3szJ0=; b=BdKCdBqVSC/Bn93XCdMLaqtpH5lEXu44KW0
    bNSxYQAMaBjz5PrYNsu2STwrsEQJbgoqG1DIFX0V5RqEuTj8R3ieN3x9s4MzNpwB
    9NYLF0RDU4ECTffE9RrQe9Gu6gSh0oqBqgUnin9d39svv9iJ7RNcMk1pZIdW9wJ6
    Pn/84PsLCg2XyXEAnzXWHvypdT41lbQNmUkzQncbmFPaSZOoiffYHdiqFhyXYSua
    XB60HOd/GG04njN9or1UD8aakiw0NDCtmrIMtsS3NDZ1zokQsd4puoFv3bk1lH2R
    DDI4xGWFrlRlMuFXV3Kd9wxfAR26P6707SYdP6XuiaupESY0GsA==
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
        id S935218AbeB1QUu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:20:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35391 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935207AbeB1QUt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:49 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        "Alexander Potapenko" <glider@google.com>,
        "David Howells" <dhowells@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.988532443@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 071/254] ASN.1: fix out-of-bounds read when parsing
 indefinite length item
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

From: Eric Biggers <ebiggers@google.com>

commit e0058f3a874ebb48b25be7ff79bc3b4e59929f90 upstream.

In asn1_ber_decoder(), indefinitely-sized ASN.1 items were being passed
to the action functions before their lengths had been computed, using
the bogus length of 0x80 (ASN1_INDEFINITE_LENGTH).  This resulted in
reading data past the end of the input buffer, when given a specially
crafted message.

Fix it by rearranging the code so that the indefinite length is resolved
before the action is called.

This bug was originally found by fuzzing the X.509 parser in userspace
using libFuzzer from the LLVM project.

KASAN report (cleaned up slightly):

    BUG: KASAN: slab-out-of-bounds in memcpy ./include/linux/string.h:341 [inline]
    BUG: KASAN: slab-out-of-bounds in x509_fabricate_name.constprop.1+0x1a4/0x940 crypto/asymmetric_keys/x509_cert_parser.c:366
    Read of size 128 at addr ffff880035dd9eaf by task keyctl/195

    CPU: 1 PID: 195 Comm: keyctl Not tainted 4.14.0-09238-g1d3b78bbc6e9 #26
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
    Call Trace:
     __dump_stack lib/dump_stack.c:17 [inline]
     dump_stack+0xd1/0x175 lib/dump_stack.c:53
     print_address_description+0x78/0x260 mm/kasan/report.c:252
     kasan_report_error mm/kasan/report.c:351 [inline]
     kasan_report+0x23f/0x350 mm/kasan/report.c:409
     memcpy+0x1f/0x50 mm/kasan/kasan.c:302
     memcpy ./include/linux/string.h:341 [inline]
     x509_fabricate_name.constprop.1+0x1a4/0x940 crypto/asymmetric_keys/x509_cert_parser.c:366
     asn1_ber_decoder+0xb4a/0x1fd0 lib/asn1_decoder.c:447
     x509_cert_parse+0x1c7/0x620 crypto/asymmetric_keys/x509_cert_parser.c:89
     x509_key_preparse+0x61/0x750 crypto/asymmetric_keys/x509_public_key.c:174
     asymmetric_key_preparse+0xa4/0x150 crypto/asymmetric_keys/asymmetric_type.c:388
     key_create_or_update+0x4d4/0x10a0 security/keys/key.c:850
     SYSC_add_key security/keys/keyctl.c:122 [inline]
     SyS_add_key+0xe8/0x290 security/keys/keyctl.c:62
     entry_SYSCALL_64_fastpath+0x1f/0x96

    Allocated by task 195:
     __do_kmalloc_node mm/slab.c:3675 [inline]
     __kmalloc_node+0x47/0x60 mm/slab.c:3682
     kvmalloc ./include/linux/mm.h:540 [inline]
     SYSC_add_key security/keys/keyctl.c:104 [inline]
     SyS_add_key+0x19e/0x290 security/keys/keyctl.c:62
     entry_SYSCALL_64_fastpath+0x1f/0x96

Fixes: 42d5ec27f873 ("X.509: Add an ASN.1 decoder")
Reported-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
[bwh: Backported to 3.16: drop ASN1_OP_{COND_,}MATCH_ANY_{ACT_,}OR_SKIP cases]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 lib/asn1_decoder.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

--- a/lib/asn1_decoder.c
+++ b/lib/asn1_decoder.c
@@ -305,38 +305,43 @@ next_op:
 
 	/* Decide how to handle the operation */
 	switch (op) {
-	case ASN1_OP_MATCH_ANY_ACT:
-	case ASN1_OP_COND_MATCH_ANY_ACT:
-		ret = actions[machine[pc + 1]](context, hdr, tag, data + dp, len);
-		if (ret < 0)
-			return ret;
-		goto skip_data;
-
-	case ASN1_OP_MATCH_ACT:
-	case ASN1_OP_MATCH_ACT_OR_SKIP:
-	case ASN1_OP_COND_MATCH_ACT_OR_SKIP:
-		ret = actions[machine[pc + 2]](context, hdr, tag, data + dp, len);
-		if (ret < 0)
-			return ret;
-		goto skip_data;
-
 	case ASN1_OP_MATCH:
 	case ASN1_OP_MATCH_OR_SKIP:
+	case ASN1_OP_MATCH_ACT:
+	case ASN1_OP_MATCH_ACT_OR_SKIP:
 	case ASN1_OP_MATCH_ANY:
+	case ASN1_OP_MATCH_ANY_ACT:
 	case ASN1_OP_COND_MATCH_OR_SKIP:
+	case ASN1_OP_COND_MATCH_ACT_OR_SKIP:
 	case ASN1_OP_COND_MATCH_ANY:
-	skip_data:
+	case ASN1_OP_COND_MATCH_ANY_ACT:
+
 		if (!(flags & FLAG_CONS)) {
 			if (flags & FLAG_INDEFINITE_LENGTH) {
+				size_t tmp = dp;
+
 				ret = asn1_find_indefinite_length(
-					data, datalen, &dp, &len, &errmsg);
+					data, datalen, &tmp, &len, &errmsg);
 				if (ret < 0)
 					goto error;
-			} else {
-				dp += len;
 			}
 			pr_debug("- LEAF: %zu\n", len);
 		}
+
+		if (op & ASN1_OP_MATCH__ACT) {
+			unsigned char act;
+
+			if (op & ASN1_OP_MATCH__ANY)
+				act = machine[pc + 1];
+			else
+				act = machine[pc + 2];
+			ret = actions[act](context, hdr, tag, data + dp, len);
+			if (ret < 0)
+				return ret;
+		}
+
+		if (!(flags & FLAG_CONS))
+			dp += len;
 		pc += asn1_op_lengths[op];
 		goto next_op;
 
