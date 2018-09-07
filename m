Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A347C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE3A20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3mwoCus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE3A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbeIGKNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:13:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36405 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeIGKNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:13:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so6412495pgo.3;
        Thu, 06 Sep 2018 22:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AScZNeHL1WE4l1ttHlmANYYJwxUgAD/FS1LeYiSdp2U=;
        b=s3mwoCus7JmyvyQkjpWF4B9slGHhPSa52w2xO7yA8FMFu8W9UHhB1fMrAz0OCWYKTm
         pVUniUKkGhwAGgYZrfI7xjsTPCUwMGM9RvLulOjQpNrgTuMX0nduYhRzjOwq1/k25UCW
         +4512Jfi4ifoXWICcVLL542P/RUBvNnKpRwhcjAl1yZVYtBWvUcj5TQpunUU4j/hcBD1
         ri09UKZ/PqpjVUnvV1wTRc0JnClBz5eXDj8TAqtTvrYhKYKi+bIqFiCyEJhNm73fn1ja
         ghQle3b+gyxVgM7ay7L5NDn2v37tiUEOUvvJ56yOmrBp9uh0/BYX5JhQUIUl4/tk48kM
         wskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AScZNeHL1WE4l1ttHlmANYYJwxUgAD/FS1LeYiSdp2U=;
        b=KHwts6kekcgjBL8r7E1YguxM/cayy8lxDjAFZ5AGpKYC+BSE/6PEyfqCIzkGemDg8I
         zK3FB57GkPfBhv5i/kTD55A/u6DXItTbav3iIvWv4I9nXnSPIq6CnteRE7Woj6B9JPCa
         HH9abShdjbO91yuP4PoXwyV6EjTOa+0hrilSBeTSA2BLa+aUSzs0NcXd9WWHqSXkfbZI
         hvMl8AqHGcxOaKO7OLXv3j/JxRgEaHNoO6QR0bMASU94QEFe6UOqRQLr8qSvLllRe1MO
         /0PmhaU5VU8FITBYg/ET3kTX/m3rdB2dMzCxeLTwAhqxcYMdJYckA5sjRO5fwFuXaoZ7
         k4dw==
X-Gm-Message-State: APzg51CniJ/C4xSDi8WIzzxKlyR7o0l8nz5310x2dqOaB/zunjEJec53
        +MDa/q0uZf0UqriJ7KmSeDbTfXnf
X-Google-Smtp-Source: ANB0VdYh7TdHcJH9QlrtbLLGNETYPdEzL9l7lwaCn9R7L6TmG7j8BJ1f56VyXsngAIsCwdU2hMmaVw==
X-Received: by 2002:a63:e60c:: with SMTP id g12-v6mr6512189pgh.308.1536298463121;
        Thu, 06 Sep 2018 22:34:23 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b203-v6sm9291581pfb.174.2018.09.06.22.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Sep 2018 22:34:22 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/6] ARM: dts: qcom-msm8974: change invalid flag IRQ NONE to valid value
Date:   Thu,  6 Sep 2018 22:33:08 -0700
Message-Id: <1536298394-5548-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

A boot time warning of devicetree interrupts types set to the invalid
value of none was added by 83a86fbb5b56 ("irqchip/gic: Loudly complain
about the use of IRQ_TYPE_NONE").  This patch series fixes the
devicetree source to replace IRQ_TYPE_NONE with the appropriate
value.

Some cosmetic changes are made by several patches.  The final patch
in the series replaces the IRQ_TYPE_NONE values with the proper
values.

The cosmetic changes are to change integer values in the third field
of the "interrupts" property to the correct named constant.

Bjorn suggested that I also change integer values in the first field
of the "interrupts" property to the correct named constant.

The series is split into several patches for ease of review.  Each
cosmetic patch addresses a single named constant.


Frank Rowand (6):
  ARM: dts: qcom-msm8974: use named constant for interrupt type GIC_PPI
  ARM: dts: qcom-msm8974: use named constant for interrupt type GIC_SPI
  ARM: dts: qcom-msm8974: use named constant for interrupt flag EDGE
    RISING
  ARM: dts: qcom-msm8974: use named constant for interrupt flag LEVEL
    HIGH
  ARM: dts: qcom-msm8974: use named constant for interrupt flag NONE
  ARM: dts: qcom-msm8974: change invalid flag IRQ NONE to valid value

 arch/arm/boot/dts/qcom-msm8974.dtsi | 72 +++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

