Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA965C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB928206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7KauB6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfANUSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:18:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40782 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfANUSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:18:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so372052wrt.7;
        Mon, 14 Jan 2019 12:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kcEOqmGANd3qw9mtfjaEDrtSnlCvqw/F1drfq3baqQ8=;
        b=U7KauB6TKPp9oyLa4fFmF71VRK9DaFXB8/AjE97Wb6BHL69zADOSrkUDY+UUEiyPPr
         e2tpFoJ2DimoWUKIpYP6NbNj/vbxcnUFFE/Js9LWp0Lh2w5gAmNOgOck43ADlTTI3JQf
         P6Ro9a8j8UqhRPTY0G/dkMoLnJzfsrsIdEmpe0oQaWFlK/lmXVi1ZVdn6jjq2ldcgNgU
         ErXuIt0s3r1IVgJcF0fnoHL1myAoO7A3XKMiRSYq5EdfNWnSAhbLK8KfXkyrncRtmuaJ
         tTxDRNA3yYozBHfS9CpwM0G1+5ABV1CMdLEvDybtOnFS7xWS3q4VAw5dcIjjj4xWc32X
         SnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kcEOqmGANd3qw9mtfjaEDrtSnlCvqw/F1drfq3baqQ8=;
        b=YJgEgwoMYht+YefXbShhxRBW3ZDA/m/mVeTSK51BuAbYvMr9zfZ8QvZo1SquQBDztG
         UyQhnhZlWHuvqZKBqcbV3YYwoBx9A6OoTvLOVMLO47MUZu3KzOudHltYdobQz8Vl+ATU
         sGAB2P1UHBkR9JG1AHEOCyia8i9N9dcDTkc+QQnZxepsNpDdThK7e4Tdp7+ftgz/y7Ua
         Fb5tEFEpFXx/5JXQ3wxJ1XA1S4kefWNsAcmenNVtXrN9xuf7F784QUPim++4OvJuzjn3
         2tfLwQIDJ8h9ZM4MHVrJRVGEha9ol/Qm/sh/ye1YX6gsJo8aRSOqNFwJCIeTkzCYSoSD
         dvnw==
X-Gm-Message-State: AJcUukdT6fappRRsaQw/v3io5Z9NJgMiLV9qnmkcv798bZXOHJiuQ9Fz
        nRUsj5hBsfpmgF3cYN4uGO5adTIJ
X-Google-Smtp-Source: ALg8bN7KcivWoKJjbLJwxMgpuV9q6JryzAzdXpx0JueUbEGhOnwUQgKVZsUmWzLnnqiKSfYyFVtKtQ==
X-Received: by 2002:adf:f390:: with SMTP id m16mr152176wro.71.1547497086220;
        Mon, 14 Jan 2019 12:18:06 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id h17sm71063695wrt.59.2019.01.14.12.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:18:05 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 87BA211422D0; Mon, 14 Jan 2019 21:18:04 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] security: keys: annotate implicit fall throughs
Date:   Mon, 14 Jan 2019 21:17:24 +0100
Message-Id: <20190114201725.13289-2-malat@debian.org>
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

This commit remove the following warning:

  security/keys/process_keys.c:380:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
  security/keys/process_keys.c:404:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
  security/keys/process_keys.c:424:7: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 security/keys/process_keys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 02c77e928f68..3308d738734c 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -379,6 +379,7 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 		case -EAGAIN: /* no key */
 			if (ret)
 				break;
+			/* fall through */
 		case -ENOKEY: /* negative key */
 			ret = key_ref;
 			break;
@@ -403,6 +404,7 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 		case -EAGAIN: /* no key */
 			if (ret)
 				break;
+			/* fall through */
 		case -ENOKEY: /* negative key */
 			ret = key_ref;
 			break;
@@ -423,6 +425,7 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 		case -EAGAIN: /* no key */
 			if (ret)
 				break;
+			/* fall through */
 		case -ENOKEY: /* negative key */
 			ret = key_ref;
 			break;
-- 
2.19.2

