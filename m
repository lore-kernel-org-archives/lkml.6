Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834021-2-9259206703087575828
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
    t=1519834020; b=ilrA3GKxjE1+FOqjWIfWOpLWlzoOq6X14Nt7OxOejnyWH/L
    B4d04WaAL0gtvETenwAAlQMpNFoMsjdFpY1XVQx9ij66A+7daPLr3umzKGtN4Qiu
    FHTcgOv7QVO4bl7PWNyAZOje471a5EQAPk0MowpA4sY0frtkL6/AnYrTD8Hzb5VD
    QXBggyXwdcQXQPiMi6c7y8uj3Pcd7yueahuyAYUSl8VyT/f38sj4WN+DQ0MOiNdx
    5/4nJR89yE3N7rVPRWqMRah9dPuW9nqvC7lZysOSFG9PUvbcOeVImdejUkZ1hL1+
    JOqMfpdcsP7/yXp1RNtOvi3SITKtQ86z1f1B3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834020; bh=AHs3I7CE7Qm6TrTkFaM
    0p1l3Wk8n/h0NVP22lMBVrrw=; b=qMHwGcTooDy8naYmyTc0aRfqPeYOpW2KF5n
    6rGhPSWmtlLzJB7QPtiqcF/ipK2Rs+eHLaFG1wZ/04Ddd0EClPEfcJps/eMsGqVo
    2t6zrQLJPLB1tTMyJF8VZxkoaB1fxdfEa/wkPVCWV+GHXToNYHEmu43g9lSi7gLW
    /Owz/PllAf/h2HxTgnNLJabWy2KKVJyxQ0M+EZYofOayvgdsIrPd4Vd9T7sh/exA
    Q1MCxeWHYXz5XTuH+yMVA7h/H4kExJgGRnLIAbR5jPLH11PWVyIaL3Qvl9ctQI6I
    fMVTtsoGviW8AvhDkkcNRQ2yH+adWogcHWHn8nUAWXlEUb4PjDA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932241AbeB1QF1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:05:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34887 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934501AbeB1QF0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:05:26 -0500
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
Message-ID: <lsq.1519831218.433839646@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 072/254] ASN.1: check for error from ASN1_OP_END__ACT
 actions
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

commit 81a7be2cd69b412ab6aeacfe5ebf1bb6e5bce955 upstream.

asn1_ber_decoder() was ignoring errors from actions associated with the
opcodes ASN1_OP_END_SEQ_ACT, ASN1_OP_END_SET_ACT,
ASN1_OP_END_SEQ_OF_ACT, and ASN1_OP_END_SET_OF_ACT.  In practice, this
meant the pkcs7_note_signed_info() action (since that was the only user
of those opcodes).  Fix it by checking for the error, just like the
decoder does for actions associated with the other opcodes.

This bug allowed users to leak slab memory by repeatedly trying to add a
specially crafted "pkcs7_test" key (requires CONFIG_PKCS7_TEST_KEY).

In theory, this bug could also be used to bypass module signature
verification, by providing a PKCS#7 message that is misparsed such that
a signature's ->authattrs do not contain its ->msgdigest.  But it
doesn't seem practical in normal cases, due to restrictions on the
format of the ->authattrs.

Fixes: 42d5ec27f873 ("X.509: Add an ASN.1 decoder")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 lib/asn1_decoder.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/lib/asn1_decoder.c
+++ b/lib/asn1_decoder.c
@@ -427,6 +427,8 @@ next_op:
 			else
 				act = machine[pc + 1];
 			ret = actions[act](context, hdr, 0, data + tdp, len);
+			if (ret < 0)
+				return ret;
 		}
 		pc += asn1_op_lengths[op];
 		goto next_op;
