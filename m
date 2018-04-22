Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406341-5-14011364477162992843
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406340; b=Z+V0teMMyZY4axDPbr1QoCsJHHxAh6wVp8VVhg65vyBTuNhgqi
    MxbLA+WX5rnq/0mmbeIOf9S01wKbd9pTAP0Hus6WoEHu3NVO5zVgzVq2ifSNPGYP
    v0TjSsXgaw96G8oAiIaTD6sQuR3301FFqQpk0S9iHjbBlw6liQKwUweLiKsMlozk
    t5Z/GNj9Rpfo9w7aftUP7wsIHblxNGS9gEQRx0pqitiygjmYPY51V7rcI23Dl7w8
    ttDn6SJPP5gN2Q8HiJmkur1eap87C/PF00+2sSvMXp+5TC5GLz98TdJcwasnpcOJ
    uRYzcL6MeGSXkw0xr9itce1ACaYj+mORyeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406340; bh=Qz/hJ9fGT15w76ppQaxZbPZ/4tF+/y
    0vcfZhI3F4Fq0=; b=GmXcbuFUbdYmC8ZVPIgBt8GJli+DYGFomdr93WQSsW1NFy
    Dw4jY8RXbixO2/JoYIenJKconVX4NXQn2ijzV7didLK8zrUgiedUOknO3TM+8N3N
    aRDjkR26MOaXxqzCm70fH3aiKbCc8dl2Uu7bOht1MlB6n3bWkh6oGJE8kBTpVg1Y
    i4fQrEMmIoi7FyUclJcfFEt06avK/m5DE9F/PVNub/lBo3EupkmNSZNPOTmDAIHs
    2x+rBWfNgXDjs2LZJydjBgbtiWSEBM8B1ByJVMd8ajrQ5+FNdAWsPjJwuD4lHh2I
    ErRBhyysMTuFC5Kpp41CTKYChqvPjzKbuCNjyjrg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCUAG4mFaN+8D2DDICt6EjOSql/DLiqdT8LVWtjNSh8q3QIGb8mJa9jugh/PZC4yGxY75szn+LZQOvFIa/uD+I5YEcKTW/Z7Tgrl/FsyL5Io+fO798P/
    enMHrP1mW5OICar5hY2iIcLRl/IHkhoL0Nwqql7QrFhtlBdWQN5gJTDYnev3pmKhU3/+T1cqdFo6A9QBQcuxblhfWR3GqtXKLT312bR1YnwgnCJ30o5Tit60
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=BTeA3XvPAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=HQYL0dNX9r2gA2wembEA:9
    a=QEXdDO2ut3YA:10 a=tafbbOV3vt1XuEhzTjGK:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756390AbeDVOMQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:12:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54904 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756624AbeDVOMN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:12:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Chen Feng <puck.chen@hisilicon.com>
Subject: [PATCH 4.9 33/95] random: use a tighter cap in credit_entropy_bits_safe()
Date: Sun, 22 Apr 2018 15:53:02 +0200
Message-Id: <20180422135211.789036774@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 9f886f4d1d292442b2f22a0a33321eae821bde40 upstream.

This fixes a harmless UBSAN where root could potentially end up
causing an overflow while bumping the entropy_total field (which is
ignored once the entropy pool has been initialized, and this generally
is completed during the boot sequence).

This is marginal for the stable kernel series, but it's a really
trivial patch, and it fixes UBSAN warning that might cause security
folks to get overly excited for no reason.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Chen Feng <puck.chen@hisilicon.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -741,7 +741,7 @@ retry:
 
 static int credit_entropy_bits_safe(struct entropy_store *r, int nbits)
 {
-	const int nbits_max = (int)(~0U >> (ENTROPY_SHIFT + 1));
+	const int nbits_max = r->poolinfo->poolwords * 32;
 
 	if (nbits < 0)
 		return -EINVAL;
