Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ABEECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623072098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WX5sTl/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623072098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbeGPK0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:26:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34985 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbeGPK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:26:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id a3-v6so22011186wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3ruQbwQ+Sd1CDg6uzTDFMW5PeKDnmNiFGEM5A22XbmY=;
        b=WX5sTl/YGL1/d7XMLuo3F9XWV3KIWFYByptVfRAP/r8wXK+Ubww8hnBiK9/Hi23GZP
         3tBar/WTJfe9us0stgFmVzGUL3bbc+GbFkSh3/K9e2/eVM4VcPsrYOoPa7p7DmqA+i/y
         hVdBPVNLT+B8VUFLdDMy5Fd2fhR2AxN/BWneI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3ruQbwQ+Sd1CDg6uzTDFMW5PeKDnmNiFGEM5A22XbmY=;
        b=IYuYAFqEonxWOiQHYpsdpKD34q6RFDzOk4JFcBLcMRr08sHjABAlBOvQgzRH5ffeEK
         Xe+LOTwyozEwIQ4Zu8Rst6NdNHwrWT1Ic5xXkILYnkmfQHEH5vCETYemIAb7wIoLGfpe
         CdwhI/4afTmNxYZKXSL//8/09l2ZjcffZzOksg/oHFbp1Wutx09rzSuqsHBIJuuwXo7f
         tB+J+JM6Q2GZf9I+B8h1Rzp7pC1pwZwUDM387cHbzHG1vQtAfOEqQZ6kaYJM5dsKMC4/
         Oyq7i6P14Fyfjn4mAndDQwaQd+zEHv/JrzN/MnUi3isUlLFoDAqIoCDsGcF7lMfdAn9g
         bO+A==
X-Gm-Message-State: AOUpUlG601ib9IvuEEYQPwkY9M3rPcSAyiO/2vUV2HGLIGE/e72RjuuI
        PjtBis/aE7QfGSlwOC/Ov8MpwDcmlrs=
X-Google-Smtp-Source: AAOMgpeTukerr/QC8I8vuzpQn8ptSF3ZVz9uagOXe1oimKbwGeDx19sOzGpxRB+tdjvr2sug+Wrqnw==
X-Received: by 2002:adf:8276:: with SMTP id 109-v6mr11960691wrb.127.1531735204712;
        Mon, 16 Jul 2018 03:00:04 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([80.215.91.227])
        by smtp.gmail.com with ESMTPSA id o4-v6sm57071636wra.3.2018.07.16.03.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 03:00:04 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     gregkh@linuxfoundation.org, broonie@kernel.org, p.paillet@st.com,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
        rjw@rjwysocki.net
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2] base: core: Remove WARN_ON from link dependencies check
Date:   Mon, 16 Jul 2018 11:59:52 +0200
Message-Id: <20180716095952.22202-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases the link between between customer and supplier
already exist, for example when a device use it parent as supplier [1].
Do not warn about already existing dependencies because device_link_add()
take care of this case.

[1] https://lkml.org/lkml/2018/7/9/356

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

