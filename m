Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C83C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D56E24ACC
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvVauCGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D56E24ACC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934894AbeFWCVs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:21:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43354 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934856AbeFWCVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:21:45 -0400
Received: by mail-pl0-f67.google.com with SMTP id c41-v6so4258088plj.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 19:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udBD3FA/hkAWhAoznOJdhSIXwaGNnm+w3oMPbyzv9VI=;
        b=bvVauCGB9Hm2Bb0o1aB8Aacw6uucFZsvKbEX40YEelruZ9bsDMWVSFzU7q8KVzh6NK
         ZIUrL/AqvCo7e6U9KIBvyZO3TyCShQqcwFEjWn7DEEpkHHp59J4fs72agpqIzcwCrsbp
         IG733DPRpl6omveHC3bFGjMRrQrdCgFHDdR5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=udBD3FA/hkAWhAoznOJdhSIXwaGNnm+w3oMPbyzv9VI=;
        b=RXW+zAkSVhOMI7F54NPqlLMuHPyYp01J/oE3xZ0xJWx8dfmQCQSM+ckOrcFSVfaBrS
         SGyA7VX8RTD67nVkrtP3UjJxetbgx3mUT81kItL498w3e76KWDNcr75aCUT4RvbQ0+ZM
         hLlmaAswCSjrElzb/W8nfvHghuzYsUfjuakYUVbdL7tsy7Crz2yqS4ShqciMFyoabiJn
         xE/7UEawKePqdejEZ71nE7BVyOBRaoRAFfUE7AwpiVnSEHP3E9wUn22wYjdKLWTyBKHt
         keoi8/q3PZ2V31y1TiFYhRbRpPMBoSkwYjcr/CQ2f3rKbG8Eg/0MBiJo52EhFSbxzY9d
         m4bw==
X-Gm-Message-State: APt69E2PuyhbYnIuxzdXRtDridTbXzHmC0s+2VvyRyq8ySCvBZc29fBb
        H2W6qyiCQ3sC47TwJ6cfl//NRA==
X-Google-Smtp-Source: ADUXVKI9xHTpeAcETYQcPVZd7lCtAYglUFtJQT6tbKt1vJyfoTjewMW8duSQtrdMuQhKLwGSpTkykQ==
X-Received: by 2002:a17:902:8a4:: with SMTP id 33-v6mr3812654pll.343.1529720504602;
        Fri, 22 Jun 2018 19:21:44 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id d88-v6sm20012850pfb.43.2018.06.22.19.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 19:21:44 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v10 12/14] include: pe.h: remove message[] from mz header definition
Date:   Sat, 23 Jun 2018 11:20:56 +0900
Message-Id: <20180623022058.10935-13-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623022058.10935-1-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
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

