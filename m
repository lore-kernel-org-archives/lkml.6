Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F710C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D379D2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDSPNDLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D379D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeLDWCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:02:39 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:42844 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeLDWCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:02:36 -0500
Received: by mail-io1-f46.google.com with SMTP id x6so14949707ioa.9;
        Tue, 04 Dec 2018 14:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOcuRqI41luGLVRjk+Jd+Gc49vBwUan7R90pGRhuwbI=;
        b=JDSPNDLUSI9ABvHVos/PDADJqtuNDEFoTSaR1bOaQA/zpEM5HKpJLGXX2rMhMseOff
         eyt2+37DZHOgM68FOZNdRw96Jlu9IP2wY0b/3alBhp2nguv/MxD/qLUFFUIwJerULPqP
         T8AbLlTHAXj59UhLdbq2eT4ocXkuZeX3LZlRcwovZnXRUxA0cxW6xW1lnUoHdLFg+o7P
         1g7uX0iat07QLFWjPYjgBndhcnLDrWJvdM/f3srRoLQgZXON6fwUlpUzKdjNlPtsXBc8
         4KvbILzkLoR/i0QunzYVxwbzW7RrhgRSFQ6g0ILqMLDCGXrN8VKfXd3AV97APrNFok4q
         D1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOcuRqI41luGLVRjk+Jd+Gc49vBwUan7R90pGRhuwbI=;
        b=pAXAdNZTmr15Yh5ytw1+9nFqen4vfHNSUzZxSz0oTznhv2zE5EMzyN5V6gmvAMZh31
         7NUYd3ErdCjSOrzapbOr3VuXizZ10N13F+vzhSPPKDn3NJ4dpdv+pTEK0GabHoA/LC21
         ZP+dgiwWKMYEi5wbSBZkosKdE70TiBtGrn7YnMKmgHAgxepNfl7fVpcxIo7NwnZwtZjr
         5iAt9AlK3R8MNl+cZJ62JzlGmjLHfwdDDCEv/VmkWuoZgho3fsufsbQXAdtxDaBO4mh9
         7O2Ate0cOK3XKIHsTs1PJ0x35R5X1l5Iye4UP1bUziRDMQSZTdi5c5ZjDqNrLIMx027f
         tNYw==
X-Gm-Message-State: AA+aEWYLBctG92v8z7uccCUi8TW1kQaYceEuRWvVt3dyhMS/HcFpRdLm
        DEogKDFIxdCL7MGywDlodhIuNNYW
X-Google-Smtp-Source: AFSGD/U795YV/LC6wRbu0C3BdVo3cyqISEaW1OrvmqgMF60Xmlk2eZ5lzyc1Nkgw3MBt8FowoW4/iQ==
X-Received: by 2002:a5e:a619:: with SMTP id q25mr19356209ioi.82.1543960955531;
        Tue, 04 Dec 2018 14:02:35 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id m2sm4962544iol.75.2018.12.04.14.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:02:35 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
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
Subject: [PATCH v5 5/6] dt-bindings: Add vendor prefix for arcx / Archronix
Date:   Tue,  4 Dec 2018 17:02:23 -0500
Message-Id: <20181204220224.27324-6-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204220224.27324-1-TheSven73@googlemail.com>
References: <20181204220224.27324-1-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

