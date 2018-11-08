Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D481EECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB5020825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax1Ji7/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB5020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeKIBKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:10:17 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36026 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeKIBKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:10:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so27151914qkf.3;
        Thu, 08 Nov 2018 07:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rKpJ8MREJeGaU2EIaNuMGQWYoX5x2H9bTb61cIDiTa0=;
        b=ax1Ji7/Qy8V5aIJ+SBUkQ67N1wYtL1vPFBzaDnaCWmL8TZvPJajdhjo9jLCjrxPstX
         Vb1CgedEIGXMT+nxDBpj6vQE1C8GLyymOAJlRaODwRfMDMpRbX/Ll2YcrFcDgCVKRCgB
         bHpIzQ9Y252s1TBrig4L88zbmkI/CDxQCU9Z2ja3dGFkK0BXITGyVq1TfukmWWil18cS
         UBJ2rY+afN/8V0EdMrS/MjB36eTNz6lAhUDOo2hvRjpMuwWS6k4y9uynxVjabYHKeKk/
         tZh7vQz5nyL2QKzxBRjvm5Idd9LbS5nEXmNTNe/gz2Tmtuf2/PD5CxL0J+rxRDJQTpr0
         bcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rKpJ8MREJeGaU2EIaNuMGQWYoX5x2H9bTb61cIDiTa0=;
        b=LO1E7DXZAtQeSv05J8MwiaCP5BZu+UKqudqO05EhPwHXsPLYTHkMfumP1p95j6al2f
         uVeVu5Sx0TFDk814G8zu+BS2W07bjbMoIn0/6IQHweji+E6QOccCs0jiTZ9bB/djK+pU
         3s/EiNTXXFtCSngcV9EkuV+nJXYEtMPSuWVaHDkDcwff6Ww+eIOrdpCKS0OBORFofPpG
         Ol7VqnS6S8K2eXPcPr+9bryR5MFWBpqxY2KcV5saLI8JTDLIBGGK7NpgI/9MDQo7/c7w
         X6FFbSxFW/sTNZJw3VKfqLKxGRivZBmBjygRkqtAn+EyWT0QJPO4RWm5XDVXI4l2pXZx
         VMzQ==
X-Gm-Message-State: AGRZ1gK6RdlsMgx1AJyybFE7OZQOuV9Y3mZMzXjTKRGvcG/q5RchAOkW
        dmmceh5rxvQpHKpsvrqgGz4=
X-Google-Smtp-Source: AJdET5c+5XnfG0UfRg/RtPKs1XGKF4tQJ5c5w66s1lrvDeONAE8AlPszyXt5pRBwq+5Mj48IyTchgw==
X-Received: by 2002:a37:b2c2:: with SMTP id b185mr4515789qkf.194.1541691254515;
        Thu, 08 Nov 2018 07:34:14 -0800 (PST)
Received: from localhost.localdomain ([50.224.228.202])
        by smtp.gmail.com with ESMTPSA id u90sm2407127qki.39.2018.11.08.07.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 07:34:14 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: Add vendor prefix for Smartlabs
Date:   Thu,  8 Nov 2018 19:33:20 +0400
Message-Id: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smartlabs are a professional integrator of Interactive TV solutions
and IPTV/VOD devices.

[1] (https://www.smartlabs.tv/en/about/)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8..4e087f9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -357,6 +357,7 @@ sirf	SiRF Technology, Inc.
 sis	Silicon Integrated Systems Corp.
 sitronix	Sitronix Technology Corporation
 skyworks	Skyworks Solutions, Inc.
+smartlabs	Smartlabs
 smsc	Standard Microsystems Corporation
 snps	Synopsys, Inc.
 socionext	Socionext Inc.
-- 
2.7.4

