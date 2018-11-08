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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8B0ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79AA206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8bJyUsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79AA206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeKIFVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:21:54 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36510 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeKIFVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:21:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id o125so28664971qkf.3;
        Thu, 08 Nov 2018 11:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1eYh4NK2z1qfcwmUlO/tJdvXFDGZTwQASuAePKx32ZA=;
        b=a8bJyUsiMftc8/9vXC5MES9wEZSosOMixRErPThBRcy9iOXPXsCJJUEKpz06mgmeUs
         qGivEtempMl71jvVLg1nl4Vlo4PQMMkSdqHT8SH8GwD8U/fTjUPeJzMNxxsmdQvXdpTT
         NVY1vGdFQK3b6ua55PcL1zmlq9STCYL3dn0IPcV/u+DwneEcho4UcFTD9JTJISG0eVMo
         4D4GKJgK9+mKuC33Wz2AR4LUzcJcGISNuTrKgPJ9e5iLuP8S4AqLIEGzzJdSUiuU/86G
         cMX1hCYgMJbtDCNx4QwL0xeZqqZJFs7HB++QSYoGUS0qzAwEitGesYIojKrzhFZzG0F1
         CAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1eYh4NK2z1qfcwmUlO/tJdvXFDGZTwQASuAePKx32ZA=;
        b=FKtr2kaaMOPVzxlUOKGXVQK58mGQOZySFKDfJ29JqO9GxGzuWsh4DVXzjs44sENuKn
         ab28Xc91jDQ2YS6pjUsB2Lz3VyzlQyKsa5Aw7XBwi4p/oCjJw3in2vkneGs5HIqt6PZO
         VQnxBumiDUPVQKM/e+5uCUi6+7mxhWtAmMTb1O85FEQ2LRub/mxNI27ysRcPNKYwpoJd
         3AsNT8WJzp66yLIkEqZsPP50uNkg57LYz/GmPKGlyihL1RpDzPipu2MVlBavZnNrh6m5
         PfrUXIaGVMrb9wq69uTnn/8JHy2qsd+Nts9enzd8mrWO5yCC/NiBO4JUTKhVyvF4dW6t
         0GCw==
X-Gm-Message-State: AGRZ1gIU3bVLLzbveGiFy07xMcCNNryMu4h1c+0vg8xxpU8cTYW4+z0v
        /WXztHZx/MfYJ8Hem7NZ768=
X-Google-Smtp-Source: AJdET5dTYNq5wzuWXFFnY12DDkmcKO1nGFeeOR/LRhL6TwWXSUcaDfDnjgTpT+aJmnfwhAdOwzQgOQ==
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr5399081qkg.184.1541706295771;
        Thu, 08 Nov 2018 11:44:55 -0800 (PST)
Received: from localhost.localdomain ([50.224.228.202])
        by smtp.gmail.com with ESMTPSA id w52sm3406414qtc.51.2018.11.08.11.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 11:44:55 -0800 (PST)
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
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v3 1/3] dt-bindings: Add vendor prefix for Smartlabs LLC
Date:   Thu,  8 Nov 2018 23:43:51 +0400
Message-Id: <1541706240-30036-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541706240-30036-1-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-1-git-send-email-christianshewitt@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smartlabs LLC are a professional integrator of Interactive TV solutions
and IPTV/VOD devices (https://www.smartlabs.tv/en/about/).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8..c424fe0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -357,6 +357,7 @@ sirf	SiRF Technology, Inc.
 sis	Silicon Integrated Systems Corp.
 sitronix	Sitronix Technology Corporation
 skyworks	Skyworks Solutions, Inc.
+smartlabs	Smartlabs LLC
 smsc	Standard Microsystems Corporation
 snps	Synopsys, Inc.
 socionext	Socionext Inc.
-- 
2.7.4

