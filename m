Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E0EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA88C205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWAhmCQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA88C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeIABBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:01:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41699 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIABBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:01:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so12328313wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LFaXeC2Evd+DuiB5BQjy+jnfA9tN+/uH8Nu3cT+zAnw=;
        b=UWAhmCQgMm/puX4vhN8WFvN8sLKez0w4aDfF1gQeVxVXxl/pbuZ25gNl4oGBKWfa8g
         o3as7YkCKXgtPdGsut7Ym5b675w8f8MjhecIrEeFJ88zH66zSzSXlRUHYM+79Vup4ERs
         Z3z5bWDdh9hflFp6HMc9R3Vu1qbOQX5S7SnM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LFaXeC2Evd+DuiB5BQjy+jnfA9tN+/uH8Nu3cT+zAnw=;
        b=ZlsEg0ndGIfXuDZ5GmcL+CdY4x/lstUaFYoIRv8LlRwzVHXvrIDtrHokeSl2j+jaHA
         zjJ9rfMCsu0RCLgkT4GlTIRNIJB2V3N8QQWq7wcectVQpnWKOe72TDaN/+Sjd9gzK/tQ
         UUD2pXpvXBqWC3pyQXDbEPz72EuydmDsLG0YgkOnJDSUIpQhfebTg2nGilqo+GLKErkv
         sr/uWFJbBGHu3aMtjTbSUeN7Q7lNzSrxS6Rk1DMuGLMRq5kKC3L967POfriXrGb9k3n+
         XOHNCCWVZ9Vmit4BfUDA2jO4zWcmK23hrhMEnctWk4yBUpJImxUj7ujMlmN+vh3q1WKN
         vtzg==
X-Gm-Message-State: APzg51BbKDSVI4R0MC2BvaDDjfyL9K3FQIVUNuXLLNBg/D2fa1jgAUPV
        XQLFAfVKXJndDyx7w+ypKar5Tw==
X-Google-Smtp-Source: ANB0VdZ1SDbAM8r/SmaYtxqLtwonYoylLFOLV89JnQL79LGX+Sppq5t/G+URUogD5AB5MSFqj6IcGg==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr12578275wrc.93.1535748756069;
        Fri, 31 Aug 2018 13:52:36 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u4-v6sm7659356wro.47.2018.08.31.13.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 13:52:35 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH 5/5] kdb: Tweak escape handling for vi users
Date:   Fri, 31 Aug 2018 21:51:42 +0100
Message-Id: <20180831205142.23609-6-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831205142.23609-1-daniel.thompson@linaro.org>
References: <20180831205142.23609-1-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if sequences such as "\ehelp\r" are delivered to the console then
the h gets eaten by the escape handling code. Since pressing escape
becomes something of a nervous twitch for vi users (and that escape doesn't
have much effect at a shell prompt) it is more helpful to emit the 'h' than
the '\e'.

We don't simply choose to emit the final character for all escape sequences
since that will do odd things for unsupported escape sequences (in
other words we retain the existing behaviour once we see '\e[').

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 8f2470016250..6ee8f812d656 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -154,8 +154,8 @@ static int kdb_getchar(void)
 
 		*pbuf++ = key;
 		key = kdb_read_handle_escape(buf, pbuf - buf);
-		if (key < 0) /* no escape sequence; return first character */
-			return buf[0];
+		if (key < 0) /* no escape sequence; return best character */
+			return buf[pbuf - buf != 2 ? 0 : 1];
 		if (key > 0)
 			return key;
 	}
-- 
2.17.1

