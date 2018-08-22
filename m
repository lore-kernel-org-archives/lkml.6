Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE380C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8939420C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2Td5Emy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8939420C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeHVOVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:21:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40721 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbeHVOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:21:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so1090418ljc.7;
        Wed, 22 Aug 2018 03:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CuZhS29CizLHRj72dECccuoO8xehBq/kwrGUDuDwEow=;
        b=B2Td5Emyd1A053PAweUOqYNRzYHxwQPeKL4vZ1KEp2AmsJvzz8IwfkseyFfa+R4g7N
         NmKiNTF7TCya+0DgGTGCzVQnPZQilecrzVU7zp2l8Au68u9V2HCncRtvUauaghKOrlRJ
         WrnxwlVEKYvYXxuWQlDT4cOWR0qCdNBzORJW2p1LrRNDXmUfd2rMnIfV6Ox4nPifcDtP
         9s+TKaHffFTmBHfD6sXDLptsbwdynSpwHtypQ54aoQKDL24V6xlmfAqTxYR8ijMRPG/7
         3qaOFIVdb+A0kSscuzCA/GX3M9GRwDM89+lVXLfJLNKrnIe6VC7OeGYoyUuKvE2C+YYE
         raJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=CuZhS29CizLHRj72dECccuoO8xehBq/kwrGUDuDwEow=;
        b=tv0nmWu1ESFTQsARgd5VvXHMwMlYau7YZPcMWuoFI6UpaddW8hjJ5l+uomQO6GM5yM
         +HcX1TEPjx8/m6q2ZXEvcgoLTUjaGXekL3CL3eLuMv71H5+8VtmVcMNMy67AngUK7Qyd
         EJWuCnyKr480Ek3KKfbRdsAa0QnU+dgQFA/67GizvH12mYXn2an+00Qs14N37L7ILeqR
         M+D0pGYbNizi4mJ6bCzBfiRRpdGDI4DFUQyz9tBF+iaG0Sj0O8n55SJ3C6yC2mYKhmZo
         Bs6/++KBG14LrvwO+B/AWn/TsHRYmfCMqwczS55YA0uak61UqQu1QrxNv9dUvHxLJuWN
         7AlQ==
X-Gm-Message-State: AOUpUlFjTZHqo4MGJ+70w8OX4+EuqRVf1aa/hsY8T1am73r5KYs2jjTD
        c7jgrm3waFNp1RMqU3g1CfA=
X-Google-Smtp-Source: AA+uWPyQP3ODjGk2LPgUUexbS24vTV62xCTN1rmOem6g9cSL4ucO9r0uywSMgVYHBRa8KhFhh4ubeA==
X-Received: by 2002:a2e:9dc7:: with SMTP id x7-v6mr13327864ljj.142.1534935438436;
        Wed, 22 Aug 2018 03:57:18 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u86-v6sm257192lfi.90.2018.08.22.03.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 03:57:16 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fsQpC-0002XJ-N5; Wed, 22 Aug 2018 12:57:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>, Jie Qiu <jie.qiu@mediatek.com>,
        Junzhi Zhao <junzhi.zhao@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        CK Hu <ck.hu@mediatek.com>, David Airlie <airlied@linux.ie>
Subject: [PATCH 2/9] drm/mediatek: fix OF sibling-node lookup
Date:   Wed, 22 Aug 2018 12:55:40 +0200
Message-Id: <20180822105547.9634-3-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180822105547.9634-1-johan@kernel.org>
References: <20180822105547.9634-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the sibling
instead of using of_find_compatible_node(), which searches the entire
tree and thus can return an unrelated (i.e. non-sibling) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the parent device node).

While at it, also fix the related cec-node reference leak.

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
Cc: stable <stable@vger.kernel.org>     # 4.8
Cc: Jie Qiu <jie.qiu@mediatek.com>
Cc: Junzhi Zhao <junzhi.zhao@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: CK Hu <ck.hu@mediatek.com>
Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 2d45d1dd9554..643f5edd68fe 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1446,8 +1446,7 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	}
 
 	/* The CEC module handles HDMI hotplug detection */
-	cec_np = of_find_compatible_node(np->parent, NULL,
-					 "mediatek,mt8173-cec");
+	cec_np = of_get_compatible_child(np->parent, "mediatek,mt8173-cec");
 	if (!cec_np) {
 		dev_err(dev, "Failed to find CEC node\n");
 		return -EINVAL;
@@ -1457,8 +1456,10 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	if (!cec_pdev) {
 		dev_err(hdmi->dev, "Waiting for CEC device %pOF\n",
 			cec_np);
+		of_node_put(cec_np);
 		return -EPROBE_DEFER;
 	}
+	of_node_put(cec_np);
 	hdmi->cec_dev = &cec_pdev->dev;
 
 	/*
-- 
2.18.0

