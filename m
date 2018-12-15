Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A15C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C4120645
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cBMsA5ys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbeLOFWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 00:22:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34777 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbeLOFWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 00:22:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so2415797pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 21:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lrkjhn+VGgEYsGRmcDheJi7s4ycITorGPJHMYu67u84=;
        b=cBMsA5ysBO/Xr4lUDjIAnzwIBnhFQTynifBQRqmU4s8Tq0GcE7Qyntf3PSavrDPPNm
         8YLVhddr0/kibitabU+A1mFQo9cMcfZaHA9/sxXPWuTPEoW6wYL+rxxgU/2vCSgidxgo
         GUfCtQzMRYn11tGHSG31UtwddtAjqu1/ZkFFJh/ZsviHzrvsxVISKiVz2avuJIdd/UDx
         3oZADcP7Znc9Xzua8HMUHKfFdERjjWJaE0GAUACrkgmHkCnfMkyp0wMzXwNLe08/s1JM
         zfpMdbqd2FQYo1+BNmTem5exWnzlj+L8gNil0JKUloZj395rO0g7JrylfYNxZ9tgQuHV
         biEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lrkjhn+VGgEYsGRmcDheJi7s4ycITorGPJHMYu67u84=;
        b=Fk2SVgEmEbH6jgSq7yYVEG7ev/z04cZh9NDWxcIxyc0znRJY/vNbjP58OaOZNLdayX
         O0piLza1/rZ+8aYOdv2D29Fw0J7LLgE1wXK8ZbcmkcLyg5yjMKW6DsN98ws2qv5TP2p5
         PlATlwhDCyr0cNwemWN1pARSsmveOrasEhYHgQtsyVOaI/dqKXo5/9NJe7crB0wDwDsx
         VPJmVNdJZIYJogzuerpvq+T2jLA9Ofjsjh9i++JUt0w4HjTYTlv/tEpysGLCNOawxQgB
         74mN6G5OwrIlmRHLUuQg+K+H/0BC0/5W2/Wus/akNxUUHYYbOVx0bKyIP4mme/bAit5i
         xt2Q==
X-Gm-Message-State: AA+aEWbYpvF/+qhYJDRVVBafvTTd+lqyWmAIj3W7SutRgZ1s61XtXhCn
        M+dMl/IlNf+7CnbHXQHsO9UV3jwcCY8=
X-Google-Smtp-Source: AFSGD/W/O58QF1bUp4utha4Fq6oCo7f2ghWpbVnDhbBoL7fVnkuYMcZBn5mIzpv0hiiZ/HnmrlQUug==
X-Received: by 2002:a63:d747:: with SMTP id w7mr5057144pgi.360.1544851352098;
        Fri, 14 Dec 2018 21:22:32 -0800 (PST)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z127sm11351282pfb.80.2018.12.14.21.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 21:22:31 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/7] dt-bindings: riscv: cpus: add U54 cores to the list of documented CPUs
Date:   Fri, 14 Dec 2018 21:21:51 -0800
Message-Id: <20181215052154.24347-5-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181215052154.24347-1-paul.walmsley@sifive.com>
References: <20181215052154.24347-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings for the SiFive U54 family of CPU cores to the
RISC-V CPU compatible string documentation.  The U54 CPU cores are
described in:

https://static.dev.sifive.com/FU540-C000-v1.0.pdf


Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 Documentation/devicetree/bindings/riscv/cpus.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
index fb9d4f86f41f..d8d99b6b5386 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.txt
+++ b/Documentation/devicetree/bindings/riscv/cpus.txt
@@ -70,7 +70,8 @@ described below.
                 Value type: <stringlist>
                 Definition: must contain "riscv", may contain one or
 			    more of "sifive,rocket0", "sifive,e51",
-			    "sifive,e5"
+			    "sifive,e5", "sifive,u54-mc", "sifive,u54",
+			    "sifive,u5"
         - mmu-type:
                 Usage: optional
                 Value type: <string>
-- 
2.20.0

