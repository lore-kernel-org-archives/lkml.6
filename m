Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30513ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9E62081B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUdedeGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9E62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbeKEBKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:10:43 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34404 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730938AbeKEBKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:10:42 -0500
Received: by mail-io1-f65.google.com with SMTP id d80-v6so4756261iof.1;
        Sun, 04 Nov 2018 07:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nR4+Ij0ZTyyuKjjNBf+oc5oW/N9Po6IaOdJST4HlNaE=;
        b=lUdedeGrZLPFxUBv9Sqr31+7rcCXjpQgwNxkOmqilNC4j6FrtTh8vnnJOgsGQFTpdS
         GKuZZlxIi2IRCBp2BmSwFTsquuKpcUbw6Zm8Ul09JuBO0ZkObH4CLJXrvgrHL5G//LJR
         V4bKZ2nDOBiRx2x1uVkzw5/jzf7FMK9DNgt9iuGHbH0Lm5dNzSLeGo6DPw7O8dBHon7q
         hndVeOuJYZWHHFmj0RExfHB+kOpvENAp5S/de3+KwsXfZuLGq6UfOKYYSIwNfeFdxA+h
         IkUl+nuLV/p0aF/oP2QNFVWTBnTBk19jegtKI+U+osRoxnrh+/bFEdGg/Pa5ubk/Kna2
         QTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nR4+Ij0ZTyyuKjjNBf+oc5oW/N9Po6IaOdJST4HlNaE=;
        b=diIJROPOP2tNn+8K4aKj7PqnAL6h10PR0W9F66CZxav0t/FxldWUcixCNseGuStHb/
         HwtU5zfp9+/Z+qTO/4QdEUuFGC4IYXJHB488ez0SxobCbChLmLFyOkQ84ejZ4+wK7BGK
         pp0WgbjK2CgVVzh8+6BXnxn/ftSl3otjocW6JKHTjZiRNtdMXSH4Ty+mD7FC9QEYhlFP
         9j35LV/QpKRakCRHa/ELZCZj0oGgY+hdPpxxXwNY+m8lShmCAFtppb2wMrsW0sCA7eAP
         2II/SBr1xUayUUQB8JUUwz68s/ZqpYfa0QXrawWJI5yMzFiD7PZxmkDMt8PVb4CQhoQ7
         RVgg==
X-Gm-Message-State: AGRZ1gJWCL0PnEBI8ulqthuzS42dm2L5Iog7au8wbQYYNjoRUfNOSOlW
        yZLcRtdst7HCcMNo5HkHjw8=
X-Google-Smtp-Source: AJdET5chhnW5/AjfOEyC/XYHRiO1fgjZoN1urCVuySNAM89Ynhwm/OGixGXPQW54EINBFbK1cQCpqg==
X-Received: by 2002:a6b:fa13:: with SMTP id p19-v6mr5091038ioh.244.1541346915831;
        Sun, 04 Nov 2018 07:55:15 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id j13-v6sm2887482ita.27.2018.11.04.07.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 07:55:15 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH anybus v3 2/6] dt-bindings: Add vendor prefix for arcx / Archronix
Date:   Sun,  4 Nov 2018 10:54:57 -0500
Message-Id: <20181104155501.14767-3-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104155501.14767-1-TheSven73@googlemail.com>
References: <20181104155501.14767-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

arcx Inc. is an engineering company which provides advanced
embedded systems and consulting services.

Archronix is a technology design and product engineering firm
specializing in hardware control systems and enabling software.
Clients include OEM's in the transportation, aerospace,
medical and commercial sectors.

Websites:
	http://www.arcx.com/
	http://www.archronix.com/

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc512e746..2ad1128c4470 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -35,6 +35,7 @@ aptina	Aptina Imaging
 arasan	Arasan Chip Systems
 archermind ArcherMind Technology (Nanjing) Co., Ltd.
 arctic	Arctic Sand
+arcx	arcx Inc. / Archronix Inc.
 aries	Aries Embedded GmbH
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
-- 
2.17.1

