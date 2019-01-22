Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEA3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78088217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548177815;
	bh=uMK+VS7UIvB97Ige/4F96NV5zS97FGQ6vWpXaI9qohA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yCVJXr9TPeQ99P89y4OHlozGwAZXn0qk5S1kno1jbavcYsmFuS8iyS6hC3YPar8fb
	 10+nUmCzK489fBUjmFTxJzBg5KqgmssMhfIlsrqRCH7KkwVi7msbeuOx38TIionp+x
	 ZWJ/83sEohVamOPCvQWDLCT+pkj5CvQLDIpO+dmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfAVRXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:23:33 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42710 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfAVRXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:23:23 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so18658320lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 09:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1puWPv7ebnF2FGl/t8rl4XQEbSdSK0TuDtfOV7WuaAc=;
        b=hHbhHN1YrPDXYbMdazRSH7kTYADSmoxw/vkEd8gyUb3QcuEmo6CwmSj6Qmcnd8LxuC
         +u0D6+dE46935A42AQfAKCZ5DMDv2x0vLjcbqvcRjh6xFHwam3uWfBYBYCeiXwHsqzgl
         m0mcdHDFghyC9FrYPCNZOA+R1eByTaB/wKS2OSnGkdCtCbBMh8ZrCfxzjAlsRLvVZLv7
         MINqrGgH8W0cgyZ+aYdNLeMYU0Yz/VLCZbQmkCGNda00xUK6WnPotaOmEeOjYzbOQSuH
         jtl+E8b+QzCyV+5gtEI8PkY7KTLry9iaiWO905hnBunV228FqZCjxmhuxqR4DnUKHiJU
         Ulgw==
X-Gm-Message-State: AJcUukeasqoxpMoOO/MjG1daWCiqNr/ZS1eoaRyCI5hvhuA0Pm9L6cNm
        aKEZIz/t0hKXqjPn583v1uhsNoig
X-Google-Smtp-Source: ALg8bN4mb/S+ZqMvOaa6YnInwVF1TLK3JPFkUhqu5728DXDG5SOzHRtRAaKQmnAXbfwjaU0pv2ks+g==
X-Received: by 2002:a19:6f0a:: with SMTP id k10mr20752199lfc.119.1548177800299;
        Tue, 22 Jan 2019 09:23:20 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b21sm97735lfi.7.2019.01.22.09.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 09:23:18 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1glzlb-0004gN-1Q; Tue, 22 Jan 2019 18:23:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] gnss: sirf: drop redundant double negation
Date:   Tue, 22 Jan 2019 18:22:55 +0100
Message-Id: <20190122172255.17944-4-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122172255.17944-1-johan@kernel.org>
References: <20190122172255.17944-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The active flag is of type bool so drop the redundant double negation
when storing the gpio state.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/sirf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index f9a9d00dec98..59cde7e923b8 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -125,7 +125,7 @@ static irqreturn_t sirf_wakeup_handler(int irq, void *dev_id)
 	if (ret < 0)
 		goto out;
 
-	data->active = !!ret;
+	data->active = ret;
 	wake_up_interruptible(&data->power_wait);
 out:
 	return IRQ_HANDLED;
-- 
2.20.1

