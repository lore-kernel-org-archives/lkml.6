Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13196C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7CA213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn6P6faZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7CA213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeJLPH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:07:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35364 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbeJLPH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:07:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id l17-v6so5756333pff.2;
        Fri, 12 Oct 2018 00:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CTGMRdJjJaMiYUDbtama3TS5jBIrJjL1fzXYXKoXmdw=;
        b=Yn6P6faZy+Tl6iA+AH6AGYLIUygXgY2HIjTolxngjCLto+JkHfddst0P9iW8EkH/5D
         EUc9NfE19qALZCHhiSUjQuiVwgH/TiT/Wbe4OUb6WlsQ6w70F+J+0afaERy6lvO30R0K
         mh9wsqbUlh6uIp9OoBrqPXh26gGdT7nyZ30SbQ+qxM+zubmyWpis7eRFSlBYjssFFZao
         y3PAlxcsaT7zZv2Epn4FI1rE01o3Dp9ckFjHwUbtGHFNnAB3QnVO/r58p9ejEaEYm+DN
         ge49kT0gDupoEPMkFvx8+KoJaMZc9Rwe7YOVYTumZUSFQj4tEkJL0YtveVFEJRbBFNLa
         u1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CTGMRdJjJaMiYUDbtama3TS5jBIrJjL1fzXYXKoXmdw=;
        b=h/8uxblNX8s3CBQjtDuaIIoqcqgbf+Sk9AJxaF0gkjUw85fGGJgaISJ5KZq62O4zlX
         tpEJxmsqnRPocHKDedEbGuiC9QqcvVnP0KKNEYcUrCClbCpK6eQSQggi3aCauns3g4Yc
         OJhksN26xxwhuTXkp87AMf6tuxscKt2vbIDrcLAmBNgqoGfMjV9h/DDkb7B40Jrdo8Oq
         FQGw0dfnNZKofJ4oIV2+hR92eCfUZ7FEnWGqPkiVQsvlXfmMu9DsfMZdqmEcrAs3nIuA
         GJMKVT+FjG1CZcP6HPz5W1UiThQ5VcYNTdI1I7fIpA8MyjAhUP+EkLllRquwqW1i140h
         iXkg==
X-Gm-Message-State: ABuFfojZRMQqxX25Nr2e3v9Fy+/AqcV1XSkSfIlI3qr0D4ZBbhHN3gij
        WR4sLnShX3hdGOSdGZ53QUY=
X-Google-Smtp-Source: ACcGV61cpV0NjmpgAiqpYfodS9uTB9kOpU3evoC/kyos9YxCmH/gaCqOGVNkOyfR35KK+ngW9uIgZw==
X-Received: by 2002:a65:52c1:: with SMTP id z1-v6mr4435685pgp.65.1539329780583;
        Fri, 12 Oct 2018 00:36:20 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id c24-v6sm2029956pgn.60.2018.10.12.00.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 00:36:20 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v4 1/3] dt-bindings: Add PNI to the vendor prefixes.
Date:   Fri, 12 Oct 2018 15:35:34 +0800
Message-Id: <20181012073536.20339-2-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181012073536.20339-1-songqiang1304521@gmail.com>
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
 <20181012073536.20339-1-songqiang1304521@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 41f0b97eb933..5b935f01e15b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -288,6 +288,7 @@ pine64	Pine64
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
+pni     PNI Sensor Corporation
 portwell	Portwell Inc.
 poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
-- 
2.17.1

