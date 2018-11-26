Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE5FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C276E20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R8v/JUL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C276E20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeK0F5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:57:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41656 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeK0F5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:57:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so14317535plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=OVp5h6hiWa5viWYNBzxoxu5Tt47L+PYW4lVWplLHQ2s=;
        b=R8v/JUL4kbq3vbtJLbOwQ65Lnv9cPIqMzefPeScfLel9qtZivlFuIVTg4lRl8jKyBy
         zw8t517enCnR5QNVPjOreimXhv9y394P3a+CsmpOoydJ0BIxrcsnMdZw7E+RyCCfeFH1
         ziCfJmMcpvCd1+2zGu1lCMYp1ziAlHhaFPaGXXsDJosdLr9Fo0XxXTmDMc0bc5byYMrP
         oq/8CQeYZp/Uu2HjOIJYCEzgTbYjiBPraxphFmX4BteUd13Ga8tR51EJS3yYiZWlaraP
         plDSJ5Qzk2tlAFXAz5WkzcBozIsnIilYlVTm5iXNxtAIj+WANNRruxae1IQxVdNva57B
         5L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=OVp5h6hiWa5viWYNBzxoxu5Tt47L+PYW4lVWplLHQ2s=;
        b=ETTPrHvCasoUlIaFSy+HaiN87QeklQ5J1PQQUQEG9yaB271dh+2PQ6/0ICxYkqmsWl
         o8DMCG5rd9AhOqGJyGFDMwUwJE5g/i5xbJE4xs2zclj6Q3y3Xer8abqTGmb3RsoorWz3
         N5k4NRGiY/VWdTHIi296BQVjXCx0kQU8Tu+bAgg+FtZe2lpXS/Zh34D0kKQ0LAdnRhpD
         hF4LR7J6zi22mQzzvvpwuTc9yQtx4BldsX4gk79uLTVWsL39SdYfKq0CQBo0MqFx3Sbe
         fuye/FfANJcolXw1ekoaadwgxp7/MFlxWm70QVjs+5/1UmayRBellKMepzE4Z1IFAm9y
         PBKw==
X-Gm-Message-State: AA+aEWYvUM+FF56XwKW+l2Pjagzq8CX9fyljZywBZ3Ns6mSiuEw5sQdX
        j7O0XYkmsP7mfYEQO+5WKRM4iA==
X-Google-Smtp-Source: AFSGD/W1iUOMLycLrn29VaCZnwHjxqXpiFfEeRTtHWcVKBYdcx2W9Qtr6JfZZrbGCVuaLNjviEMsmQ==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr29865894plf.202.1543258969829;
        Mon, 26 Nov 2018 11:02:49 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id t66sm1467295pfd.54.2018.11.26.11.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 11:02:48 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:02:48 -0800 (PST)
X-Google-Original-Date: Mon, 26 Nov 2018 10:27:42 PST (-0800)
Subject:     Re: [PATCH] dt-bindings: sifive: describe sifive-blocks versioning
In-Reply-To: <alpine.DEB.2.21.9999.1811211704520.16271@viisi.sifive.com>
CC:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        Megan Wachs <megan@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul@pwsan.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-197c28a9-6763-40df-988b-3494dfe124d4@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 17:06:56 PST (-0800), Paul Walmsley wrote:
>
> For IP blocks that are generated from the public, open-source
> sifive-blocks repository, describe the version numbering policy
> that its maintainers intend to use, upon request from Rob
> Herring <robh@kernel.org>.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Megan Wachs <megan@sifive.com>
> Cc: Wesley Terpstra <wesley@sifive.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>
> Hi Rob, please let me know if this document works with your
> requirements, or if some changes are needed.  - Paul
>
>  .../sifive/sifive-blocks-ip-versioning.txt    | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
>
> diff --git a/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt b/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> new file mode 100644
> index 000000000000..b899e5c6e00c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> @@ -0,0 +1,38 @@
> +DT compatible string versioning for SiFive open-source IP blocks
> +
> +This document describes the version specification for DT "compatible"
> +strings for open-source SiFive IP blocks.  HDL for these IP blocks
> +can be found in this public repository:
> +
> +https://github.com/sifive/sifive-blocks
> +
> +IP block-specific DT compatible strings are contained within the HDL,
> +in the form "sifive,<ip-block-name><integer version number>".
> +
> +An example is "sifive,uart0" from:
> +
> +https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43
> +
> +Until these IP blocks (or IP integration) support version
> +autodiscovery, the maintainers of these IP blocks intend to increment
> +the suffixed number in the compatible string whenever the software
> +interface to these IP blocks changes, or when the functionality of the
> +underlying IP blocks changes in a way that software should be aware of.
> +
> +Driver developers can use compatible string "match" values such as
> +"sifive,uart0" to indicate that their driver is compatible with the
> +register interface and functionality associated with the relevant
> +upstream sifive-blocks commits.  It is expected that most drivers will
> +match on these IP block-specific compatible strings.
> +
> +DT data authors, when writing data for a particular SoC, should
> +continue to specify an SoC-specific compatible string value, such as
> +"sifive,fu540-c000-uart".  This way, if SoC-specific
> +integration-specific bug fixes or workarounds are needed, the kernel
> +or other system software can match on this string to apply them.  The
> +IP block-specific compatible string (such as "sifive,uart0") should
> +then be specified as a subsequent value.
> +
> +An example of this style:
> +
> +    compatible = "sifive,fu540-c000-uart", "sifive,uart0";

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
