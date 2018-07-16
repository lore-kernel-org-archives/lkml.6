Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C36ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700DF208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KXhqG2I1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700DF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbeGPMEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:04:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34236 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbeGPMEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:04:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so31509447wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DoHvK7B1TPVIp3+0qd1MQaEYt832YsDgc1ZBKYxMEdI=;
        b=KXhqG2I1Hsiop51F1X85t9bI+38J9/Taz05awzUwzyVDEWWD1/lZLXesgkm0mpMiW9
         a8t8hQfOJ+8GMrQoRoiVJYNxgiAbw4Dc+rGk/SNdYQwu2Dg0WLkbxhn/cmhsTDLKVl+U
         6w7tWAK8X6182GwRapLsCHWW6UaS5wnctD+Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DoHvK7B1TPVIp3+0qd1MQaEYt832YsDgc1ZBKYxMEdI=;
        b=edLdpRnvtb/7B6uBUU5qT7zFXzRZ06qaBJhe6M2kxVJzwXNjW0Jl6cHRaHVWw4T0Zj
         qIPzqrDZ9YRlttptb9l3qbeyc7DBIRmxm3w3G/1+xgKMoJ2yvlQJE5ioNOv0pYZfYOKf
         PuhZTrrl0PtqIHBFZhjHFbODL0vuS/Ik4sa5Rh/oONysxv2maC5B+wZWZ3YmwYNE7owm
         CjY7hB87+LS2nF9A+0NeweNJ9nd5qc1eg8ulWs6kTIXgzljN2OA04SAfzqm2Al7Mcqia
         BD4jwEwlYHMeIAF9raVDIKfhoudK86P2xpJCauGCuFXN4O8ubMcIHvNwlzmEymwp3AaJ
         J3aw==
X-Gm-Message-State: AOUpUlGm2QI/9/sTCRj1CS0CawCdBMpcEDngLY9RYdeaE5WWCnsuhZl9
        W2n6Y0hW03aG5W6AeEPlJme+Aw==
X-Google-Smtp-Source: AAOMgpdn+eDbNiMGwcnRWtDETwcBGIEMH1PHzZIm7lo5FWYYRSVPwfT267+FCTRaVqowEHp4pi758g==
X-Received: by 2002:a5d:69ca:: with SMTP id s10-v6mr9190355wrw.77.1531741068854;
        Mon, 16 Jul 2018 04:37:48 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([80.215.130.250])
        by smtp.gmail.com with ESMTPSA id h61-v6sm17332068wrh.18.2018.07.16.04.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 04:37:48 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     gregkh@linuxfoundation.org, broonie@kernel.org, p.paillet@st.com,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
        rjw@rjwysocki.net
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3] base: core: Remove WARN_ON from link dependencies check
Date:   Mon, 16 Jul 2018 13:37:44 +0200
Message-Id: <20180716113744.13300-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases the link between between customer and supplier
already exist, for example when a device use its parent as a supplier.
Do not warn about already existing dependencies because device_link_add()
takes care of this case.

Link: http://lkml.kernel.org/r/20180709111753eucas1p1f32e66fb2f7ea3216097cd72a132355d~-rzycA5Rg0378203782eucas1p1C@eucas1p1.samsung.com

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index df3e1a44707a..fcdc17f0f349 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -105,7 +105,7 @@ static int device_is_dependent(struct device *dev, void *target)
 	struct device_link *link;
 	int ret;
 
-	if (WARN_ON(dev == target))
+	if (dev == target)
 		return 1;
 
 	ret = device_for_each_child(dev, target, device_is_dependent);
@@ -113,7 +113,7 @@ static int device_is_dependent(struct device *dev, void *target)
 		return ret;
 
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
-		if (WARN_ON(link->consumer == target))
+		if (link->consumer == target)
 			return 1;
 
 		ret = device_is_dependent(link->consumer, target);
-- 
2.15.0

