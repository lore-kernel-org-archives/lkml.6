Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACCEC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAC0206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctGa9a/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfBIRg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:36:58 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46755 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbfBIRgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:36:43 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so4793533lfc.13;
        Sat, 09 Feb 2019 09:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4K07+PMA9omMHyycWXsghoi13jqHOsNkg22kq8mIMI=;
        b=ctGa9a/UoANzMwFauz2xiF9In1v8Ye7VXD3jPjx8643TK5ZOkd0GCuqgqRnsfMPYuT
         f480AM29Bo74N9KA2pLD3HFwpzJvoTCuQOqcMapP/HlsrrjsyEX1mqsFX2DyXkOsYDXt
         qOQ1gSC5d8wuYvQxJ4fx0p7DUsUXOmOJMSOIghZHsFO+t9ifNihcIdXZH2B9fj9XzjQe
         glU8Wsb040wFLp9wq5ukmlTqypNf2tVhIxIvPTKSWxVb9WNUpuXh2ngHq2S+E4OE/5hH
         nDtd4E9K+LAFpfBIQroFPNMBuzDYxsl6WKpjM/8uti6IGNaSUFS5Yz+wnA0VirFOpxRp
         P6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4K07+PMA9omMHyycWXsghoi13jqHOsNkg22kq8mIMI=;
        b=LsczxSQ7EmlfS3Lg4VT0g2mFFi6/Y6BIQnH1y8zKZIcI+1ItMiwGXGf/zyln0aQFba
         49Mu1HuksRTuTwlslpOnkjhlJkcjP4163fkdDMAtQvWWA80yHgFnmjGu71lLNvMWKjBm
         WcN5NAmw+hb3/m142zGfaV9lPnPS87OAaJ0bycALUFc1sUNpC6XUTOY0JcQrJxUgnHFv
         n+MUOrYrESzql0MO97mxMNSQUZDbUtF4NOVE2gOZZVVRg35/YWY17RnVcFctkwoeiQt7
         HDFYo8XBNDat283o5ogVVPOJ9SngmEbRylHkIN/L5gySbbC8RD6X0vZEkoEORJ+/eA5z
         w0NA==
X-Gm-Message-State: AHQUAuY8CbiLkIKl4tlAH+lLS4FVSD8h8ixr1UJ9xGMCQ2mddDVsQhn/
        vWVvMpOKI+T2zIVzBkXeU28GVW78GGM=
X-Google-Smtp-Source: AHgI3IbDvph/PVy4KEs78Ihu5fube0fq/KDhjHeyyMFvxz//0Bw6iqwxSTodcyFdGNQ2t05AbcPDUA==
X-Received: by 2002:a19:6f0a:: with SMTP id k10mr17268364lfc.119.1549733801083;
        Sat, 09 Feb 2019 09:36:41 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id n12-v6sm1080508ljj.32.2019.02.09.09.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 09:36:40 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk, pmeerw@pmeerw.net,
        johan@kernel.org, Tomasz Duszynski <tduszyns@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: add Plantower to the vendor prefixes
Date:   Sat,  9 Feb 2019 18:36:08 +0100
Message-Id: <20190209173609.13220-3-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190209173609.13220-1-tduszyns@gmail.com>
References: <20190209173609.13220-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Plantower to the vendor prefixes.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 3cfe0c8b8250..fa391a650f3a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -300,6 +300,7 @@ phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
 pine64	Pine64
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
+plantower Plantower Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
 plx	Broadcom Corporation (formerly PLX Technology)
-- 
2.20.1

