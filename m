Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F85C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49B5218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+JlmOmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfAXUYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:24:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45267 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbfAXUYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:24:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so3141587pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GeyXvvqE5bL0aSA9R8EemEtHWRM9NeMogHgyU1Syf0k=;
        b=M+JlmOmc/LnkQBrk4zKEhWNdWoEU/Y4v7cFdtCULVGF/PF+QLG6SjoR4oA242dO2lE
         8NmbqHtI5r2F26kbPhfl8N+t6z+XdYKw0dJHh07nUFhG9tuWYri5BwXufyknfnmepDeZ
         SfoIOhi8F9QOMjjQ/mW6ti8dkkfaMt8ghnBKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GeyXvvqE5bL0aSA9R8EemEtHWRM9NeMogHgyU1Syf0k=;
        b=lFfcM/0mBF/nnNqycLmq9Kzd2OKrddWVybIoUJXby8dJrtff5NYvKvqFQL0tWdB8KY
         uNkBgwL3tnOrvwNOgR29hBkPhgHl8xkMkDJy8wjgUetdUdpayoYKXnNYsyLCfILTMH0v
         IfVbgR+aWc5+mBli+YTfwxlJijBgCWZD3JzZh6R+BoRYJ32/ywqr1I7dwBYcQxEUTlq+
         SrlCS4M4c3YNVY5QEvCQfe8heyCCjLE5jygtX7Ylla8r5EtWuwqZBuKrZPsF6azdD+70
         JdhbnQUQFHpOUvsFQCSjh+CiTIdcua72BQpFPIFNbfy8x/OiQ9yu0YO7E0GLgvI3+Kri
         YPyg==
X-Gm-Message-State: AJcUukfRyvJ4Vswn+l+sWeYM5MuIZs5bj+MPiDmzxOIqVROc6VQsPwXV
        nl4APnKPBCFSLq86mXTU0/oUJNsc7s/jjA==
X-Google-Smtp-Source: ALg8bN7NxmW28CzSxr6mGZRUoeI1PmncF62x7Fww9Iwj3aqVoVxshnaJdTYreDMlYDrtwB+sU4OC6A==
X-Received: by 2002:a63:9041:: with SMTP id a62mr7112274pge.163.1548361469145;
        Thu, 24 Jan 2019 12:24:29 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c72sm45263309pfb.107.2019.01.24.12.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 12:24:28 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Youlin Wang <wwx575822@notesmail.huawei.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 1/8 v5] Documentation: bindings: k3dma: Extend the k3dma driver binding to support hisi-asp
Date:   Thu, 24 Jan 2019 12:24:16 -0800
Message-Id: <1548361463-28372-2-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

Extend the k3dma driver binding to support hisi-asp hardware
variants.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: dmaengine@vger.kernel.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Simplify patch, removing extranious examples
---
 Documentation/devicetree/bindings/dma/k3dma.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
index 4945aea..10a2f15 100644
--- a/Documentation/devicetree/bindings/dma/k3dma.txt
+++ b/Documentation/devicetree/bindings/dma/k3dma.txt
@@ -3,7 +3,9 @@
 See dma.txt first
 
 Required properties:
-- compatible: Should be "hisilicon,k3-dma-1.0"
+- compatible: Must be one of
+-              "hisilicon,k3-dma-1.0"
+-              "hisilicon,hisi-pcm-asp-dma-1.0"
 - reg: Should contain DMA registers location and length.
 - interrupts: Should contain one interrupt shared by all channel
 - #dma-cells: see dma.txt, should be 1, para number
-- 
2.7.4

