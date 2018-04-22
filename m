Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406067-2-2116103928985144281
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
    1524406067; b=jD83YVe/jIv2yCnOTYf7ghzVz8figtCkq8nSKANrsDiW0LJiJ0
    o3ojlEOZC9cSHgkJxU1K7ctZBlzfyTL6vKmQkcGMs7BW5fOCKQoYA5bf/0GMoHmj
    AcL6+heRk0XBoFpxBFj5YcILwSfUz54P9rPD6nzapdweF3MeSZX1jhgiUKv3UKdw
    W3xHdMYBYvJOpJ4sK6jCc+CLam19ejkHqINyYUXNZkRAUnirQgau25nLZhOu78DT
    +evnHJa5ocIobyAJSYeor9D5mhCX1UkuNEX3bTF6Scieu0RNI6Q7x35ilykV55OZ
    JJApP4kXZ5ZwVfLEUaV0gB+oji1/eXxECKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406067; bh=Gp9r2wu50qmwqBXmAQkhlUQtTVaxi/
    T5K+jPYID35hI=; b=eA4IFLRLAjxJuK4Gjh9j8mnPv9AO3s5CxQWQvV2Og2kEAH
    IwCV85A7027vzysfcJJn1dQxaskVuR3/TV9ehpkowpn2n+wQpIfOnYPWsd6uWz5J
    yRbXAFByJsNUjggW19lZCooCe/QwwFaQUwm0gGahxtf+oVsH8O3sJ9arHokdHDbh
    KJAKoqQoSY2d1k7Y9n0Nx7np1DfG5B4fvhnTdXtPRuEZJImcC8DQciIaV6HD1SYN
    uvaaO6/13VRuX1myQcI9m5kAwh12Fn9JxX3fWihzEIwMJmZWcyQmA57vANT9rxWQ
    s9NhJwypeyWIZ1OaS4ibYXM/39T6j/lJsetX+Sjg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfBb2z3ypA19j2ccxMDeOHV22jqu7BjEvJjTKL+6JfNtV2MTIPGgSy4pth+y5FS4OBEKGcoHOaQzpubTHcQGd7JI5sNWlp9ebU1MFJcVFxvMCrtAzIDar
    0JBXqRv3CGRudm1XMVU8CF9UYn7sw5w+Bh5ZJ5ZMOm/rcaQ3lwh7O0rfMlUrLPRXbJSGLo6wC8l0ffmdQPEmMogl3jvVl+Vqbirxd2nL+mnbpcQlloqiGUbq
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=P-iJ9YrVpKHmO2kfVUcA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755842AbeDVOHo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:07:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755120AbeDVOHj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:07:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 070/164] block: use 32-bit blk_status_t on Alpha
Date: Sun, 22 Apr 2018 15:52:17 +0200
Message-Id: <20180422135138.327588563@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 6e2fb22103b99c26ae30a46512abe75526d8e4c9 upstream.

Early alpha processors cannot write a single byte or word; they read 8
bytes, modify the value in registers and write back 8 bytes.

The type blk_status_t is defined as one byte, it is often written
asynchronously by I/O completion routines, this asynchronous modification
can corrupt content of nearby bytes if these nearby bytes can be written
simultaneously by another CPU.

- one example of such corruption is the structure dm_io where
  "blk_status_t status" is written by an asynchronous completion routine
  and "atomic_t io_count" is modified synchronously
- another example is the structure dm_buffer where "unsigned hold_count"
  is modified synchronously from process context and "blk_status_t
  write_error" is modified asynchronously from bio completion routine

This patch fixes the bug by changing the type blk_status_t to 32 bits if
we are on Alpha and if we are compiling for a processor that doesn't have
the byte-word-extension.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org	# 4.13+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/blk_types.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -20,8 +20,13 @@ typedef void (bio_end_io_t) (struct bio
 
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
+ * Alpha cannot write a byte atomically, so we need to use 32-bit value.
  */
+#if defined(CONFIG_ALPHA) && !defined(__alpha_bwx__)
+typedef u32 __bitwise blk_status_t;
+#else
 typedef u8 __bitwise blk_status_t;
+#endif
 #define	BLK_STS_OK 0
 #define BLK_STS_NOTSUPP		((__force blk_status_t)1)
 #define BLK_STS_TIMEOUT		((__force blk_status_t)2)
