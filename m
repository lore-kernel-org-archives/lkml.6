Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12809C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD1C20854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDS3bvvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD1C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbeGKHqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:46:11 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42384 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeGKHqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:46:10 -0400
Received: by mail-pl0-f68.google.com with SMTP id f4-v6so4607119plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udBD3FA/hkAWhAoznOJdhSIXwaGNnm+w3oMPbyzv9VI=;
        b=DDS3bvvNhkJvcyqdwc1EFKAG41UgqJWBEUWNzUomCGlSVBYybxbPWOYB6U/HJkrtI+
         JO922kw8K9fFwwQ7Xx4GUuIiEBLkFOp97E/qUZUTrMLS2ZvIya6FSNsz3wkun19dQeD2
         7ktTYhWtLCQlRYy6zi3kfQtakAzPYqwr24TQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=udBD3FA/hkAWhAoznOJdhSIXwaGNnm+w3oMPbyzv9VI=;
        b=ZEHhVLSQLph3xV3uuRjbBA8tEowSZ/+Hcxx790Ly224q6+cVMKthvKURY/8u6CDXdB
         dnFbBOjjSrUhHwcZpGTAZJSonaYhWuQrucD0Oj4J+4lcO+w2zeGJizr4phkhhxgiXR0B
         IRHOvDKJstkpYCyXK4IO16+RuNDg/0a43WpsasEzFlIHOXlfGstsaDehU3B1D1zbWOgp
         8DF4YCrhBLNg2dVpSMrYkzgGOZo4yDPpn2HtfUWhEPC0bV6ZBV1wAAMbnIxI8iK2TNeF
         NmMOFaUZPKfsNSnNnIQ0MnHNKvQ5CBgUtCOok7BvZXC3rMUq2g7kJw1DMEmt3XVfdqy6
         j+dg==
X-Gm-Message-State: APt69E2E2tZMtxhT/Xz5EVGoLxsQO1YS/jOebCXAQ0UcNVAUKw1CwWBl
        EEEaFXdzIWs5XE7ypZ7R9bX8Gg==
X-Google-Smtp-Source: AAOMgpcIiQzkNN2sPH73iGSzD9wIJCjaSX4E2S5JJt7vzPU+eHD3xPGyLijloMkOKU5fK4NLVv7V3A==
X-Received: by 2002:a17:902:8ecb:: with SMTP id x11-v6mr28387294plo.308.1531294994256;
        Wed, 11 Jul 2018 00:43:14 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id m86-v6sm40464859pfi.47.2018.07.11.00.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 00:43:13 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v11 13/15] include: pe.h: remove message[] from mz header definition
Date:   Wed, 11 Jul 2018 16:42:01 +0900
Message-Id: <20180711074203.3019-14-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180711074203.3019-1-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

message[] field won't be part of the definition of mz header.

This change is crucial for enabling kexec_file_load on arm64 because
arm64's "Image" binary, as in PE format, doesn't have any data for it and
accordingly the following check in pefile_parse_binary() will fail:

	chkaddr(cursor, mz->peaddr, sizeof(*pe));

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
---
 include/linux/pe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pe.h b/include/linux/pe.h
index 143ce75be5f0..3482b18a48b5 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -166,7 +166,7 @@ struct mz_hdr {
 	uint16_t oem_info;	/* oem specific */
 	uint16_t reserved1[10];	/* reserved */
 	uint32_t peaddr;	/* address of pe header */
-	char     message[64];	/* message to print */
+	char     message[];	/* message to print */
 };
 
 struct mz_reloc {
-- 
2.17.0

