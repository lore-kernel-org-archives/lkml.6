Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39708C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F0220892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXAuPkwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F0220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeKIPqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:46:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45744 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbeKIPqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:46:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id o19-v6so435368pll.12;
        Thu, 08 Nov 2018 22:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jF7CtwoKyOCOUUznnCb9oRyK4jRjdXLVVX13D8F3sAE=;
        b=uXAuPkwpjK5d2wkFBfA15bHp5YEAdco3syQlybhjVOk6eRc6PqYfuwOvIikYU7Sduz
         J9hoFai92icnDyMiQ8R4UwmH1tzI9O3gftndo8Uosv1QtcKrhXRJziT6ZFnK/Kf+bBs6
         WRmuoCWCOs1Y3Bk1wKOYP5FYbbH2puwFDmn1Gf3TZ2OLKBOBAK8PS/5P8L0DnWDw11Ar
         Gexpgzt5EZ8W+c+AbOhNpSUCJ7jJNlig6eesNXolZ4PlJjTDIhLubBnHA+UKoFMFY+3l
         K0Gmlt2Gw/sjUvIaDxl/6wamCeWdabwB8KjbFRPlgzt4CacgXFfR2CdIw9UjdeB6AES1
         hYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jF7CtwoKyOCOUUznnCb9oRyK4jRjdXLVVX13D8F3sAE=;
        b=YsXGY7wnP6ZTfocs1QS8VCuy66BYwc5WE3e7a6PljKFbQ8cn0HzxpFKwbGecNAJY+K
         SoL2mAh7hcIThj3LEW5MHMLLc6soTzFI+9casnin0LZiyelQ4BGVoBRWVXGMngpGs9We
         gtYEwqrKTGZV2/KK/5bTHpmdpHmtY4y4MnNlZGsAqcLgEyEZ8CaAmU9KUj/Z75s/e7b6
         YRhVbt6/CEh7jE/G7ClfzcfnKp1iJctsLCvZ/vA0XcrPSakUv8A3RzWEYAiZDk4D2Gy6
         3FwD9/Op2rsfZ2B6amzapBfjPXdkk+5XLFtszmBKNWejpw4mAcBpQE7tEV9sBETMTEmb
         GnzA==
X-Gm-Message-State: AGRZ1gIhcsOqgVwp9YI0qm6Nyb3fW68iiLtsL2cnZpzrRL+0rtqRRMBQ
        SeTpuoxfbFw2sRC1JZ1MAKmWTV6P
X-Google-Smtp-Source: AJdET5eBIxc+UbyHaV3Ux578DGKF4+kfse3jltkLRGCS4puaAnncK61U7RApJJ2GBt90dXVKS5NrRQ==
X-Received: by 2002:a17:902:ab83:: with SMTP id f3-v6mr7368701plr.122.1541743673139;
        Thu, 08 Nov 2018 22:07:53 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 22:07:52 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v7 07/17] of: overlay: reorder fields in struct fragment
Date:   Thu,  8 Nov 2018 22:05:55 -0800
Message-Id: <1541743565-23163-8-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Order the fields of struct fragment in the same order as
struct of_overlay_notify_data.  The order in struct fragment is
not significant.  If both structs are ordered the same then when
examining the data in a debugger or dump the human involved does
not have to remember which context they are examining.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 9808aae4621a..15be3da34fef 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -49,8 +49,8 @@ struct target {
  * @overlay:	pointer to the __overlay__ node
  */
 struct fragment {
-	struct device_node *target;
 	struct device_node *overlay;
+	struct device_node *target;
 };
 
 /**
-- 
Frank Rowand <frank.rowand@sony.com>

