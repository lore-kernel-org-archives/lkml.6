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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ADAECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86FE20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmRIaWJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86FE20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeKICif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:38:35 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40098 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKICif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:38:35 -0500
Received: by mail-qk1-f195.google.com with SMTP id y16so26492586qki.7;
        Thu, 08 Nov 2018 09:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rKpJ8MREJeGaU2EIaNuMGQWYoX5x2H9bTb61cIDiTa0=;
        b=tmRIaWJJ4HkbVeHPsq4BN/AryDBfWxXMcPupYNRiKG3Csqs6oxM3Bi7KAZuxntKrsT
         wHMiKSSfnHwvsyYmrD/RziC123VI2/PTS2qAuWZe9J1Jf/WLUX6qWkXWo7NqvYph6SgT
         NThUqRMQZedSRzYnZcVA1r1nZ9mjomAX3tXPnIGGNdZyjpzYozv29wARQ8YgcFj6yUrh
         GmML+lz61QfLGb6fWMt+yaSVoHtdXIyEwBl9f0MyDUc2b5jGSp/wA5J8QvDof4CuCKRa
         gRbWx+DTPp4BOLt2wm8g2SQORxHv/QdIHSwj/FB8ZJzvULz87ZSccR3Oir38dkapS7Vf
         WOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rKpJ8MREJeGaU2EIaNuMGQWYoX5x2H9bTb61cIDiTa0=;
        b=hSMO+mFHBeshXpX0Awz+6EXuDYsatD+SPP9RjdNOUXEtUcDwe06oy+LwWD3VQDtBRm
         drlz2ExX/2+bGZqbT96qklI4FdTzBOkh99M/oaW8Kz2xRVy1PjNwxZHwV8ngDl2TgKM2
         qaW16JlmVuNzStJglc8uLkgyot09OaO0g2qxUFRigZrZokn8tl0ziDW4btiYphxKGOqP
         PfO8ilWTHuQsKvfHJGCmrbnipPUZecaT6ylimAWnUDHJNK0ufRFRWaNCPCLIq1xMxQvw
         +FzRzheRZBLmSUp3YDbUIy8uWsIBkZhpcspmHFUR7GFQs+nsHUHqHoDpsHds0QuyAug5
         PaQQ==
X-Gm-Message-State: AGRZ1gJlUGKanFdAsYF2r6jc6P84a7Q1zLE8QwdmS1G+Yk0wJd9ulML9
        +U+slkT1uK6CWeJNcsF/Pus=
X-Google-Smtp-Source: AJdET5fGTZX4rGDEt13YcN+qBAs/cjD55o6xmfU/RVfaqrKGSK0R3e77DM2I1BQiBKnPvPmvdFbsEQ==
X-Received: by 2002:a0c:bfd4:: with SMTP id u20mr5246855qvj.113.1541696531121;
        Thu, 08 Nov 2018 09:02:11 -0800 (PST)
Received: from localhost.localdomain ([50.224.228.202])
        by smtp.gmail.com with ESMTPSA id 53-v6sm3172243qtw.52.2018.11.08.09.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 09:02:10 -0800 (PST)
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
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 1/3] dt-bindings: Add vendor prefix for Smartlabs
Date:   Thu,  8 Nov 2018 21:01:07 +0400
Message-Id: <1541696475-27454-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541696475-27454-1-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
 <1541696475-27454-1-git-send-email-christianshewitt@gmail.com>
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

