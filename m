Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48ADC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED9C2170E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul48yglm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED9C2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933542AbeGDGq7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:46:59 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43975 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753620AbeGDGq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:46:58 -0400
Received: by mail-lf0-f66.google.com with SMTP id m12-v6so3484558lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 23:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=5+cNhIGav8sY6OrJoVxZQTKfTsQ5L/Q/6jTV4Ltltb4=;
        b=Ul48yglme0OMwI/ct+NaNwH9ISctlCFT+tuQvn2OL35D4alSWtBSGvYY4DBHDsyrkb
         Y799UdBPS20zHsrJnpXovo8pnTqMdEX/t4fFwSu5qsJIvmPPcvbwfDBHpz9rhgbYxHic
         5vw8K5Pb73kQrTGt/oa3AbR9pibTpTL10rIJrh5LCxiG4I5o/XRErVafATu8Ps6SHOfc
         C1AmVLJ6+4HaKlaOz7A1zqJ5xN934NE5gw25CPHIb1vIqoDnXI/aF2CB1GgDFsDip5XI
         DsxbfFwc8cPDuRqJ+aHF3rtrybvwbfM9KqKOElWGrBsBy828d9rcXFTmKVPkRfSLrdvL
         ty3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=5+cNhIGav8sY6OrJoVxZQTKfTsQ5L/Q/6jTV4Ltltb4=;
        b=S+M4FRu7CwFrnBpb9ziQAnVuEkAvbSLvVYl3AGsAgjgcRquaeDK/pXBkNbtI5qiKo4
         CidDPRChXmTir1uI4l0bHs6wtazbBgZU5vS01mI4cwBafCGWREnWP9gmAGNHlmDuFj2b
         cdB5QAC82dmcz0Bim27OMQ0gGfvNglijL4/D6Oxvkam0ZzQgDhjr3Eo4Hu+CgZCywrEH
         kVh5Zq8r/1CxBklxo1uuAx/JzWmBtRkLm8cQ0bhb0b8IciYtQXU5u4jtQ+MT4HoX+OLC
         IP4ErFeL+mlCg3wZUmTv9dq/FfsAay/p2UbmDjUb6IJuQDzp7Hn5fA679/1P5eNSKB//
         wLVw==
X-Gm-Message-State: APt69E0s9SuhrUtoVzLIbo5zTEFUBTY/OHX3Mm9RuvdsbRaPUxrlha4c
        0fwHZ1pDePwUggYKHQE/4oIc2rDN
X-Google-Smtp-Source: AAOMgpdgAC61TAaXLuZDRW2i4qvvt1oiRzoGurvnO3ACuFRRdfG8NnEv8q/DkyHQHnyDa1jQFx1IcQ==
X-Received: by 2002:a19:d7d1:: with SMTP id q78-v6mr573240lfi.40.1530686817169;
        Tue, 03 Jul 2018 23:46:57 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id s81-v6sm445231lja.1.2018.07.03.23.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 23:46:56 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fabYu-0000nB-7j; Wed, 04 Jul 2018 08:46:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH char-misc] dt-bindings: vendor-prefixes: fix bad merge
Date:   Wed,  4 Jul 2018 08:46:26 +0200
Message-Id: <20180704064626.3003-1-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the vendor-prefix reject file which was accidentally added when
merging the gnss sirfstar binding. The wi2wi prefix had already been
added by commit a593bff82cae2 ("dt-bindings: define vendor prefix for
Wi2Wi, Inc.").

Fixes: 176193b7dd6e ("dt-bindings: gnss: add sirfstar binding")
Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

This applies to the char-misc tree.


 .../devicetree/bindings/vendor-prefixes.txt.rej        | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/vendor-prefixes.txt.rej

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt.rej b/Documentation/devicetree/bindings/vendor-prefixes.txt.rej
deleted file mode 100644
index a32acd9ce2b2..000000000000
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt.rej
+++ /dev/null
@@ -1,10 +0,0 @@
---- Documentation/devicetree/bindings/vendor-prefixes.txt
-+++ Documentation/devicetree/bindings/vendor-prefixes.txt
-@@ -395,6 +397,7 @@ vot	Vision Optical Technology Co., Ltd.
- wd	Western Digital Corp.
- wetek	WeTek Electronics, limited.
- wexler	Wexler
-+wi2wi	Wi2Wi, Inc.
- winbond Winbond Electronics corp.
- winstar	Winstar Display Corp.
- wlf	Wolfson Microelectronics
-- 
2.18.0

