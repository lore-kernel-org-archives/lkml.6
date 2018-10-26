Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62792C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5C1207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/ZvAVbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5C1207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeJZTxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:53:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43868 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeJZTx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:53:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id t10-v6so926260wrn.10;
        Fri, 26 Oct 2018 04:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0uobgskPDvtt66nH74oPn5cyeTQ7D3Fue2q+TPC/RI=;
        b=R/ZvAVbKKjzEyXKDcuIoPSUbZlb64PmJP5Naps83k0gxN57CvefYm+1qquIfwTS8i2
         W8H9gANo9kO4V6O67WOpkm9QvfAgBnShl9VBaxuOybFMskaWAVwX1dt5jtJxv8nJVEJN
         zl3qmmBp6kyVVqOYJ4gRexm6PdU/foMWzR5RPLy/guAFTThanJlUxxHyw51ZyghIBUVX
         Uo5tLZcv15ZWmQE6IFgEwkd9rXy02p3aoaQpO+A77ZoHdUK0s6R0+wUABrV2UYKBQPBs
         6npaCTrqv1ROOcp47qcLFpdowTI7gP7pF+nJ/CwjMsVu3o+5jkZYcsMbRuAM+0ltHowN
         7/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0uobgskPDvtt66nH74oPn5cyeTQ7D3Fue2q+TPC/RI=;
        b=GX2/uBkNhaMgHG2xwv5aSkxQ2wtiE+TZlp5gZpETVPs8CB7p0puakme80BUzOdlUvQ
         rEfOYr8RP1/pDsOb45VO4Euato579phEoMh1g+bkcunBQLr7uZkBgVPps7xvPjTVNKlI
         lc97FSlfJlk3be93jUzUthBHRCjURZ+dS0pMwGTmPT2ykOl0suPiVXozHFM4vQLdatOY
         Fz3HJJM4zNZkCOURUUNnILI53CY42n7lxFId00a5clVLIYniV/ge6Xxh40vNnVdqGec3
         pqqCMPzKx6PLCMKBG+ZfY8SPINu1lf1OCOZRMAe6BMb98JF9XtcFIUtclKzvb2bJlG6+
         qV6w==
X-Gm-Message-State: AGRZ1gIv31d7ex0OhYFmYawRRkhUk9w04ATSGYz7GDmVw591HVBe4k8M
        yrpCHmRW64ACpv/Y9c6Qcgo=
X-Google-Smtp-Source: AJdET5eOHFyQj8UmAXpplwL1Em0ZaVpUifoVxqZ9A5CL92MTbsFiA7WAxsrESAcB6En11O7Acd2jWg==
X-Received: by 2002:adf:b6a8:: with SMTP id j40-v6mr4971221wre.55.1540552606624;
        Fri, 26 Oct 2018 04:16:46 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id j6-v6sm5348687wmd.29.2018.10.26.04.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 04:16:46 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] dt-bindings: tegra186-hsp: Add shared interrupts
Date:   Fri, 26 Oct 2018 13:16:32 +0200
Message-Id: <20181026111638.10759-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

HSP interrupts can be routed through exposed "shared interrupts". These
interrupts can be mapped to various internal interrupt lines. Add
interrupt properties for shared interrupts to the tegra186-hsp device
tree bindings.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
index b99d25fc2f26..620c249363ca 100644
--- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
@@ -15,12 +15,15 @@ Required properties:
     Array of strings.
     one of:
     - "nvidia,tegra186-hsp"
+    - "nvidia,tegra194-hsp", "nvidia,tegra186-hsp"
 - reg : Offset and length of the register set for the device.
 - interrupt-names
     Array of strings.
     Contains a list of names for the interrupts described by the interrupt
     property. May contain the following entries, in any order:
     - "doorbell"
+    - "sharedN", where 'N' is a number from zero up to the number of
+      external interrupts supported by the HSP instance minus one.
     Users of this binding MUST look up entries in the interrupt property
     by name, using this interrupt-names property to do so.
 - interrupts
-- 
2.19.1

