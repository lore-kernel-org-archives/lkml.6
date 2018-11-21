Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FF7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1F021479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW0qh2JH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1F021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbeKVBmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:42:12 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35426 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731206AbeKVBmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:42:12 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so9325527itj.0;
        Wed, 21 Nov 2018 07:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QFuPudjSrxZYE1Kmf5A0gFPOSUAwgVOUUF5f4/v/a4=;
        b=aW0qh2JHpUbTzQwZ9CLC9GWNIg2GSboh0GNPsXBzWWkwD7syC7RaXMtODB8ggKKbb1
         BfloNqyXBhHoCoAgWbRppiO6ignnHlg4t1b9bMyG3BsIyWLc+jWPx8HVjdZ2xlYw8euc
         MRIS56KV8s1wizKT3GLScDcG8a4gazMgwOE1v4vgI7oD/7MLmrq+w6Ww3MjdTgkkQ/rd
         qZUIeq8F1U0oH1aSCfrVhI77oKZ4jkbvE5WxVdAQ+QmA79o+k6KdVrwHIczoaBhMD1Ur
         xg9Dn1cwxkZmkY5jMpTCEog/peQxfFlcLjw2PPb7IqjspHC7ajYKpST/yvCdKgCLTdol
         XPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QFuPudjSrxZYE1Kmf5A0gFPOSUAwgVOUUF5f4/v/a4=;
        b=hG5UMUvZhKMrfvje6phTO45j2MPJlySUc2br9MeFT5JgSpUGsj2x+wIH6mUIlwTIvE
         OkQnHacjRd/DE1g3bmDaBfA0GBRu9Hhhe4TfPeyDfCpRXvaygyUE8JG4fFFRSl3y/pLG
         elaz2RQ2FRDOSPLl0qehnlAwAOeGzEI/TEZ2ivE2klH0iTMyiFuo4xymgIh8+d08fsEQ
         0MzkgR5uiz4OqnRl1Vf50YqWX88UVUG57ZshKGwg0vcKkOA10RBf96f9v+Wb9w/RVnKb
         KTjL9o0+KaRnQf/qFnCXppzAFtEDXRf3iJRzefT7vgmEk+8r9iKjGh8HMVyas1C8CQ/u
         Q8bQ==
X-Gm-Message-State: AA+aEWa/fNSSSt3ohIeGPIVTkoWJjxdoKnWERF1J6rLVyTlh8oYOSqRg
        ZvsNQrcCQUFkZTsIVHAI3A8=
X-Google-Smtp-Source: AJdET5ebNfhxhU8sCSJ2aC4FSgkfT+62UOCzOsvQawC539T0iqHxRyICgKEjbwGOfqTwlTKdIi0xcQ==
X-Received: by 2002:a24:8302:: with SMTP id d2mr6615010ite.78.1542812843202;
        Wed, 21 Nov 2018 07:07:23 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id c3sm5113119ioi.2.2018.11.21.07.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 07:07:21 -0800 (PST)
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
Subject: [PATCH anybus v4 3/7] dt-bindings: Add vendor prefix for arcx / Archronix
Date:   Wed, 21 Nov 2018 10:07:05 -0500
Message-Id: <20181121150709.6030-4-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121150709.6030-1-TheSven73@googlemail.com>
References: <20181121150709.6030-1-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arcx Inc. is an engineering company which provides advanced
embedded systems and consulting services.

Archronix is a technology design and product engineering firm
specializing in hardware control systems and enabling software.
Clients include OEM's in the transportation, aerospace,
medical and commercial sectors.

Websites:
	http://www.arcx.com/
	http://www.archronix.com/

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andreas Färber <afaerber@suse.de>
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

