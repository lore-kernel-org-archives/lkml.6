Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA47C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ABF2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxG2dNMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfANUSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:18:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33308 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfANUSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:18:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so425757wrr.0;
        Mon, 14 Jan 2019 12:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p49bt+1SmEsGxWoH/rsPYLV7MdXyFzHn36341naqvhE=;
        b=fxG2dNMaBcuL+wiI9sLYrL9YwVKKPZDmaMky6NEAWB+u+jvp0s3MTZW6hUkkbcKOHZ
         8h8TJaab3a937THp1sQN+PCGHrVk4ZTdvth6KAstkkxPHtJ/Xn7qUPRiA6qcbE9nnPp2
         CKEgzyXWKPL2nYYEvT1mVjf66TgPdiL7ftUwlaG311QmqfW1liq4xXLDI9pLXf1gyZz2
         Lp62Vqnpxjfq31VP2xXU1cS6/v01w25a3tWV3LCnBLyXbEew0Z8dagQHf5nPGdMpaEnN
         uExaDB4lc2kko42i1wjC+ehF6QntNYNEeJhT2oeo1/BEGVAJM6fivWQ1mb1ArktCZjQR
         /nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=p49bt+1SmEsGxWoH/rsPYLV7MdXyFzHn36341naqvhE=;
        b=tobCZ9mPHJM/waGN+rdijMD2bHnbl/AhuXhOwgu8oTqB2hhatCAmiyFW8Owibl1Gr8
         L51x+EjZqwaZ3r4QWdhYNQIpj1T6oKj0MqNORi6FwK1La3uuX2AUShItSCOherNKm2pG
         nfAwumdz5bqeM2ZdjjnonaRSV6jUoKmcTHKqmnMhHMBG2Rh67ZqOAUJjA4h+Z1KrDC2A
         iom5bhlrN8o8kHDAPbyOHOy7NLQR39N5pFCS6RYl2RSjrIzFBuXOUTRYdlrb2pCdjLbS
         1IYQ9wFXkhq8ry5jw4EzekZDn1npWrPLXyFA6cuWi7n4R5mH0Ct0Rp/JAEy3zL4qyQ0r
         eDqg==
X-Gm-Message-State: AJcUukd4EGyOVXMtAyIfVyAA0Jj5D0SXK0pgMFiTjohrGRGjZ8d+3l1C
        1DwX0l26SlDnskev9HWnyh4=
X-Google-Smtp-Source: ALg8bN4W1GOaN2mtvE5eUSkbVrLb/uehIz5qqi2v6zoBqs3xpbxrJFkGbvgGyMLYjVM/8ASyDO427w==
X-Received: by 2002:adf:ee46:: with SMTP id w6mr146671wro.261.1547497087853;
        Mon, 14 Jan 2019 12:18:07 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id u204sm50535787wmu.30.2019.01.14.12.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:18:07 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 2767C11422AD; Mon, 14 Jan 2019 21:18:06 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] security: keys: annotate implicit fall throughs
Date:   Mon, 14 Jan 2019 21:17:25 +0100
Message-Id: <20190114201725.13289-3-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190114201725.13289-1-malat@debian.org>
References: <20190114201725.13289-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1). Fix them up.

This commit remove the following warnings:

  security/keys/request_key.c:293:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
  security/keys/request_key.c:298:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
  security/keys/request_key.c:307:7: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 security/keys/request_key.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 301f0e300dbd..af8816ffb6ce 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -287,16 +287,19 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
 				}
 			}
 
+			/* fall through */
 		case KEY_REQKEY_DEFL_THREAD_KEYRING:
 			dest_keyring = key_get(cred->thread_keyring);
 			if (dest_keyring)
 				break;
 
+			/* fall through */
 		case KEY_REQKEY_DEFL_PROCESS_KEYRING:
 			dest_keyring = key_get(cred->process_keyring);
 			if (dest_keyring)
 				break;
 
+			/* fall through */
 		case KEY_REQKEY_DEFL_SESSION_KEYRING:
 			rcu_read_lock();
 			dest_keyring = key_get(
@@ -306,6 +309,7 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
 			if (dest_keyring)
 				break;
 
+			/* fall through */
 		case KEY_REQKEY_DEFL_USER_SESSION_KEYRING:
 			dest_keyring =
 				key_get(cred->user->session_keyring);
-- 
2.19.2

