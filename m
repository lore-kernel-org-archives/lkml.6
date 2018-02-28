Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835984-2-8664343746578298133
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
    t=1519835984; b=eytgdcyyrgnC6bjOGhBnNfgIIJn5sLBGNMCRMtS0ojTHxNu
    Kz6WpZjltROluJSFH7hTjAI3HDr67n3l3l1T3v+5D4p0GP0lDAUWomLmf2MevEbd
    luKuAqd6rwZ7YExs4DNw5pI6BfbkigyV2g5yWPpitLTyqlrIXP2cQYXOkxd13dDO
    kSR2aIjsq9SqwJITI4qIj7DLMN1SIuEAP2Z4fbsvQ/eLhx1yjxsRVJZZHEPB/Du+
    0ZewX49RNsI1s6MWheIJg42LOGvPIC0Cdg8cIVcwMoCiWgscAodK+vFr2eKYbko8
    ZyISjh/fcxyi6pvAyRRo8/aodmjldjKF018KRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835984; bh=Z2N5ziq/eEV3p7ANGl0
    E4QWqJiWc/4Ygn9Qxuc2/Z2k=; b=t9OzB7mTPhTexzZyqBE39lbEzlSqRSOWoeQ
    ZqYLVdoufGJDBraAFIT3Ku/ogtkGemJZu092UFLLlJ/X5ssf1msoOgGzIy6hCoGS
    QVNnG0DSaht0+bBpijA7QYStjmEkuhgCDAusWvWim3Ma0dvGCd3z7gwOl4RgOYdL
    OywmwRfwmKPxs7Zyt4WyugMvyrLMgcr9PH9I+2k7H293oYKYgxOX9u+DUdwDLsDS
    HpU8ULWsuEAn4o3ctxHrB+/n/xyATZ/2BTQM4FT4Dv/LE8WCatVTb/V6dgHihHns
    ncxl55SehpDf9xmERaeSraIM10cKS3XvDMcZk1Wgh0XGqotYZlw==
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
        id S932218AbeB1QEC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:04:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34797 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932290AbeB1QEA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:04:00 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        "David Howells" <dhowells@redhat.com>,
        "James Morris" <james.l.morris@oracle.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.592746522@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 074/254] X.509: reject invalid BIT STRING for
 subjectPublicKey
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

commit 0f30cbea005bd3077bd98cd29277d7fc2699c1da upstream.

Adding a specially crafted X.509 certificate whose subjectPublicKey
ASN.1 value is zero-length caused x509_extract_key_data() to set the
public key size to SIZE_MAX, as it subtracted the nonexistent BIT STRING
metadata byte.  Then, x509_cert_parse() called kmemdup() with that bogus
size, triggering the WARN_ON_ONCE() in kmalloc_slab().

This appears to be harmless, but it still must be fixed since WARNs are
never supposed to be user-triggerable.

Fix it by updating x509_cert_parse() to validate that the value has a
BIT STRING metadata byte, and that the byte is 0 which indicates that
the number of bits in the bitstring is a multiple of 8.

It would be nice to handle the metadata byte in asn1_ber_decoder()
instead.  But that would be tricky because in the general case a BIT
STRING could be implicitly tagged, and/or could legitimately have a
length that is not a whole number of bytes.

Here was the WARN (cleaned up slightly):

    WARNING: CPU: 1 PID: 202 at mm/slab_common.c:971 kmalloc_slab+0x5d/0x70 mm/slab_common.c:971
    Modules linked in:
    CPU: 1 PID: 202 Comm: keyctl Tainted: G    B            4.14.0-09238-g1d3b78bbc6e9 #26
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
    task: ffff880033014180 task.stack: ffff8800305c8000
    Call Trace:
     __do_kmalloc mm/slab.c:3706 [inline]
     __kmalloc_track_caller+0x22/0x2e0 mm/slab.c:3726
     kmemdup+0x17/0x40 mm/util.c:118
     kmemdup include/linux/string.h:414 [inline]
     x509_cert_parse+0x2cb/0x620 crypto/asymmetric_keys/x509_cert_parser.c:106
     x509_key_preparse+0x61/0x750 crypto/asymmetric_keys/x509_public_key.c:174
     asymmetric_key_preparse+0xa4/0x150 crypto/asymmetric_keys/asymmetric_type.c:388
     key_create_or_update+0x4d4/0x10a0 security/keys/key.c:850
     SYSC_add_key security/keys/keyctl.c:122 [inline]
     SyS_add_key+0xe8/0x290 security/keys/keyctl.c:62
     entry_SYSCALL_64_fastpath+0x1f/0x96

Fixes: 42d5ec27f873 ("X.509: Add an ASN.1 decoder")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -348,6 +348,8 @@ int x509_extract_key_data(void *context,
 	ctx->cert->pub->pkey_algo = PKEY_ALGO_RSA;
 
 	/* Discard the BIT STRING metadata */
+	if (vlen < 1 || *(const u8 *)value != 0)
+		return -EBADMSG;
 	ctx->key = value + 1;
 	ctx->key_size = vlen - 1;
 	return 0;
