Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E37C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDED206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X976QnPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDED206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391235AbeKVLnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:43:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39780 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388633AbeKVLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:43:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so1596306pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=mmYitqJ/Zox8bJAkxiDoh3xH7YY9MHO4cNepwjP4x0A=;
        b=X976QnPFfIpL3DIJAb1vzf1c+/eGCHKL1ONtI2Dgrx2PVp6HM1SZcwBc36D3vl0CBo
         F5OpdQX653N1Wzhr/4JHMYdwEOvL8/uunqLGuA21TeV4P34+ySZvpKTu5aAKLEtbzb6+
         pm2pFhk+n9vUDUr1fX9plh0Ado/+VIHgACeMG/EpfXH6e3K1JZ3ZrignwzQcr3WFUhpv
         +Yi9jJgLARznTcps0O8PlhFrnuHSGMeIfzfrnPTOd1oT8Tr3eGiUG8z0P7qFTNK53+kP
         WASIU38xRVMDECc0Kwaxi9CkqiNOzsvQFev2AYwA7zdg/eYWI/2MVi5uLsHDalopolSr
         E8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=mmYitqJ/Zox8bJAkxiDoh3xH7YY9MHO4cNepwjP4x0A=;
        b=sijEtoNYO3l82IkrZcxazUucARidoBJtdcExNlcDxlXpa83rZjbP+9UA9smtZJjGtv
         +ongaSOHTUGxpsPjUFg7fXojb674Wq8BlD3WdeE42uNamSVHuNhJpVK2W2g1SJPl7wXc
         TTkDOAoESx1p8ZjqteVUbxGXBrWbC9qS/+C0FIg0cIRTQfsSE/7jJC4XvHx34bodQOjO
         f9xqd+a37SaIcBf7u6nKrnkaVD8+RT+blU8v2UCe5Z3Rj6rfhT/40kygxFXlobqeElzH
         E35c9xYDVPfTZO0pff9PND6YG1Hpbx+3CuWOtpHEw5QJ2yFVoy2LhO2Al9WZUy2zHx9M
         bJjg==
X-Gm-Message-State: AA+aEWZ0PL4WcLWGXPAKUb5ZkyU1dTomD7pII9vL57aVomfiq/ozKRkP
        r9tr6JRQMxMyMEsaIxyqjpEAMw==
X-Google-Smtp-Source: AFSGD/Xqt6mZlf4jp353uPu8viMDnnN9heXTh6lHKIrscPrGtlQDaXICdn6Lj3mz9tYli5ps5sETNw==
X-Received: by 2002:a17:902:4c08:: with SMTP id a8mr9219265ple.74.1542848818261;
        Wed, 21 Nov 2018 17:06:58 -0800 (PST)
Received: from localhost (97-120-243-143.ptld.qwest.net. [97.120.243.143])
        by smtp.gmail.com with ESMTPSA id m9sm43230248pgd.32.2018.11.21.17.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 17:06:57 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Wed, 21 Nov 2018 17:06:56 -0800 (PST)
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
cc:     Palmer Dabbelt <palmer@sifive.com>, Megan Wachs <megan@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul@pwsan.com
Subject: [PATCH] dt-bindings: sifive: describe sifive-blocks versioning
Message-ID: <alpine.DEB.2.21.9999.1811211704520.16271@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


For IP blocks that are generated from the public, open-source
sifive-blocks repository, describe the version numbering policy
that its maintainers intend to use, upon request from Rob
Herring <robh@kernel.org>.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Megan Wachs <megan@sifive.com>
Cc: Wesley Terpstra <wesley@sifive.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

Hi Rob, please let me know if this document works with your
requirements, or if some changes are needed.  - Paul

 .../sifive/sifive-blocks-ip-versioning.txt    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt

diff --git a/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt b/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
new file mode 100644
index 000000000000..b899e5c6e00c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
@@ -0,0 +1,38 @@
+DT compatible string versioning for SiFive open-source IP blocks
+
+This document describes the version specification for DT "compatible"
+strings for open-source SiFive IP blocks.  HDL for these IP blocks
+can be found in this public repository:
+
+https://github.com/sifive/sifive-blocks
+
+IP block-specific DT compatible strings are contained within the HDL,
+in the form "sifive,<ip-block-name><integer version number>".
+
+An example is "sifive,uart0" from:
+
+https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43
+
+Until these IP blocks (or IP integration) support version
+autodiscovery, the maintainers of these IP blocks intend to increment
+the suffixed number in the compatible string whenever the software
+interface to these IP blocks changes, or when the functionality of the
+underlying IP blocks changes in a way that software should be aware of.
+
+Driver developers can use compatible string "match" values such as
+"sifive,uart0" to indicate that their driver is compatible with the
+register interface and functionality associated with the relevant
+upstream sifive-blocks commits.  It is expected that most drivers will
+match on these IP block-specific compatible strings.
+
+DT data authors, when writing data for a particular SoC, should
+continue to specify an SoC-specific compatible string value, such as
+"sifive,fu540-c000-uart".  This way, if SoC-specific
+integration-specific bug fixes or workarounds are needed, the kernel
+or other system software can match on this string to apply them.  The
+IP block-specific compatible string (such as "sifive,uart0") should
+then be specified as a subsequent value.
+
+An example of this style:
+
+    compatible = "sifive,fu540-c000-uart", "sifive,uart0";
-- 
2.19.1

