Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61537C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1CD2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544077409;
	bh=bopWFCbcVR1dxy6C/Ga8OFeKgh3kUfpeZJZ1npMOq6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LO16VRu1dyaqEHjEdDUEB0Vv7TjJ/6Igx2h5y7FQfs1hwUJ9a8fTjdtiEmhsfOvjW
	 GCCEvz0cPR+D0ZhuvGw9b0POLRdT98K0Yx4SGEwKXnscNBRaPx4jADSs3BRa1eMKHf
	 ixwlSURWWd9pIFtHbxQel5TeHeVpdegm4tGWBaMg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1CD2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbeLFGX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:23:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34178 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbeLFGX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:23:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so20618654ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 22:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/lAO156zLX/DoQyF5TgEBMBE3SeWlWqyU+kjTZGgOnA=;
        b=Kz9eXUgrOiebi2bOlZq/lSmLP86hw8mdI+Iv4z8lQUxB//LD6T7n8XyEyMlVAlVOvj
         Tv16RwjG5nZoZH3Qz23aG3Kkyqa39fCapwdPgzLBb2asBQ5iBA8o9XW1kYj6dRzmnBt6
         ytXuZ58iMnZWeVadjGDMbQqnVAdlBYBj9/ffXlcRNIj9KaoocUeeFZ+dnJHrgh0Bd8PO
         ROi4PqcjYUahKDPrVHEx7xht4fUDHJuXHdag2d73cwI8gBLbEOmGHPenKMd/OOeljKqh
         p8w8q7DWa6Iev1ClwnK35gzueD5FYOHYS1cWmJMafNKbWl2NyCa6IM7rEVvZg1JEjmAp
         /WgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/lAO156zLX/DoQyF5TgEBMBE3SeWlWqyU+kjTZGgOnA=;
        b=nnabQ/fJD05vSviiM/BrKNVfK33F2sw6IVGpANwsRIgBlfTEnEk+vwMTgYdxrQdrAW
         7XYRqGJM+WkX4U0Albqhhbcd1jZsuMCXAH8Tjapa6Yp0XPsEyXGNtOuhrYywFIV7hOBU
         14oH1NN9HfY6aWFOuErl3qviyYXqeL/1gS/ZdFi6Nmm/Mg027SMIfjkQ+Y8fPS/xmGi0
         hL3hfLJX8aai2doY6ejKxnEqR6oVvXeBgq2f+BzwKIzLeqgl3En2zH8OEaFJarQiiQvE
         jJHepyKXo9jKkgfSg8CCqaO5k+MuvTk/BbboXLwepFI2oqCukqVwbKpidNg6cyzQn/p2
         TZ7w==
X-Gm-Message-State: AA+aEWYGuFYvghJArgiYROI1tJ/RszDc9i9/uZToNOCvJFYtjl+pJxeS
        yFTcSxG+zv+SqpFbiHT2p/XimM0W
X-Google-Smtp-Source: AFSGD/Ug3oe7kcYC6S6yO2UznSfVI1e2hGJperxMOfRNJ7OZ6t6HeKc4TeGnMWKEGHW882MegLMzvA==
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr17155530ljb.126.1544077404789;
        Wed, 05 Dec 2018 22:23:24 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r4sm3983737lfe.60.2018.12.05.22.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 22:23:24 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gUn4K-0006gS-VC; Thu, 06 Dec 2018 07:23:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>, Barry Song <baohua@kernel.org>
Subject: [PATCH 2/2] MAINTAINERS: exclude gnss from SIRFPRIMA2 regex matching
Date:   Thu,  6 Dec 2018 07:23:18 +0100
Message-Id: <20181206062318.25648-2-johan@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206062318.25648-1-johan@kernel.org>
References: <20181206062318.25648-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exclude the gnss subsystem from SIRMPRIMA2 regex matching, which would
otherwise match the unrelated gnss sirf driver.

Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03766ddf95a3..0f083103d625 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1472,6 +1472,7 @@ F:	drivers/clk/sirf/
 F:	drivers/clocksource/timer-prima2.c
 F:	drivers/clocksource/timer-atlas7.c
 N:	[^a-z]sirf
+X:	drivers/gnss
 
 ARM/EBSA110 MACHINE SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
-- 
2.19.2

