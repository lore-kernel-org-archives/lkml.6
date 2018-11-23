Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076C6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A855520820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXDxZZ5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A855520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409728AbeKWWws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:52:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35635 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388282AbeKWWwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:52:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so10103468edx.2;
        Fri, 23 Nov 2018 04:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4BqwdEdRbHS+28afKNJhOP5+LNbZlv9Ex4CnJQKhIng=;
        b=hXDxZZ5qEZ9drqOMslgVOKcjOPPh4M7i70ulV1q5kv5N/Y+ruX8J/LTaASphCPsxEL
         j/VfH7ICUx/n4fgTZiJ1NWks952O4Or7YsokEM4hTB1VHAFTPRiE3+NEB1PXdTvdR+3i
         AXu2425nhOxgs7uz7HTdoMV1ztD/a7IrEgLNhwLI1Kf+SYpbP4p1bklEFXyO1KMszqED
         xC4lau1bHLdeENwYfeFhdoHBjLxT4XYwYgDsAen/0SvgDMIbD1yCqY5aUpH5WDI0XSm9
         XT093UKvLOiG666Ide9ojGmFFzMTRDYMcIUuSDIN60mDUrAJOePvNnHGtNtiAbAcNYXo
         4zIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4BqwdEdRbHS+28afKNJhOP5+LNbZlv9Ex4CnJQKhIng=;
        b=L8LxhhjSpTqJZcSwTNX4kBO23UeL9cRAuf4ZKLNs3ByYKFYoGEibGycgTjZ9uyZQKf
         FSi28yeFDquRHDBsMcQzN0yA/HQNSxDTsJoQvPxhcGz5+XKTGdEtnnp9wAPshpwq5IBo
         UnYU86rRknmBYM0Fd+IXYS+2ddoP06g4nBvdE/tTjpoxjaowRlIFY06uF0sgH3fxqUtn
         O0gNxVY5Ldid9OjBw5KyzLxVmvYlM29YeDuFsZwkDPCv/JwIup1MLo7LZVxq5MCyKgqO
         EnyLRCINy9KB4lUd2PMRYyj4r6srByTPxPdoUf+FJ5tYnTGMzRSyHQk/kdPgHyHoolSI
         +aAw==
X-Gm-Message-State: AGRZ1gImYtal+iL1TKOEaO6zwGar2oUArWViMkDNNlCNfHP9PmvUQAJ3
        TIaCeRusR6QvTwxjaGTz/wc=
X-Google-Smtp-Source: AJdET5d1dHfIZcFQSt8t8Urs0G54Ib4u97Lkp28uWhxD0mYwtGfWo56CKvZsIZLpwZoaUZYvPIdz4g==
X-Received: by 2002:a17:906:790b:: with SMTP id b11-v6mr11300825ejo.228.1542974927928;
        Fri, 23 Nov 2018 04:08:47 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id o37sm1960941edc.32.2018.11.23.04.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 04:08:47 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: hwmon: lm90: Document ti,tmp451 compatible string
Date:   Fri, 23 Nov 2018 13:08:46 +0100
Message-Id: <20181123120846.16999-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The TI TMP451 temperature sensors are compatible with the National LM90
temperature sensors.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/devicetree/bindings/hwmon/lm90.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt b/Documentation/devicetree/bindings/hwmon/lm90.txt
index 97581266e329..c76a7ac47c34 100644
--- a/Documentation/devicetree/bindings/hwmon/lm90.txt
+++ b/Documentation/devicetree/bindings/hwmon/lm90.txt
@@ -23,6 +23,7 @@ Required node properties:
 		"onnn,nct1008"
 		"winbond,w83l771"
 		"nxp,sa56004"
+		"ti,tmp451"
 
 - reg: I2C bus address of the device
 
-- 
2.19.1

