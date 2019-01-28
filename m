Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C702C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE8321773
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QST1QHTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfA1LpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:45:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43774 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1LpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:45:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so17642754wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 03:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XXP3hIFo09qbYxDEZ84UjroMfNXRwbZdmDEOnudwpmA=;
        b=QST1QHTo+SnjfGWbtje9MmvxvXe4/o/N50DokM5mJxKpXFb63tUU1x/mmlOjswaquL
         x/B9ltLTidkjQvB8ltU33qlfqwIxGvVVLsfIHFn55bKZF287AeDlb6uuaC5f7M+g6XBd
         0wU+H6OCt7OAaazBWp9kitFWKCJEp6s4QFmzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XXP3hIFo09qbYxDEZ84UjroMfNXRwbZdmDEOnudwpmA=;
        b=SABz6wIx8h5vSLG8+BWZo82wLXeKS3837dTAXGxX2nodAnCkWQwS0eabwMXDJgDLNq
         USSCvYAeJmRBG+h/1GSitay8jM63C6eibhP9LT0U5B2h2rjq85GG6qdH4Z9RhqYYZVk5
         0HB3+ghNCjMCnGmQk8oUSWQ3ajCrA5ywkM6lkFz/K+1uWZvzysJWy8N9uIPXH8o1m6cg
         KtI/57U8+f6MkBa0+HsQ0xqyar6ybWc0WNKL+vhhHZBX75uQjmrcve26UXO9m5SSpVlO
         AC8/e0B4MINrDKnHv/P7N/hUw2PwxBfaqw/Sb2H6fdaZ9+w/J9d5qemZUHNWYK/Byufj
         vZ2g==
X-Gm-Message-State: AJcUukfLWWumAMn7ll6VItDmLQIZpDmFcb6iDCjAqGVA9JeiQxOmN/EE
        g35KoTewrwj6OQ6qsJT4MyJvWQ==
X-Google-Smtp-Source: ALg8bN4EHw6SpI3q7wRaHuK0UXmG8c7NqpCc59mw5ZFdAx5u6QilmJUB2vTbnMbhKqBMYELKaKRDdA==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr22526419wrw.304.1548675913628;
        Mon, 28 Jan 2019 03:45:13 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id z9sm122968775wrs.63.2019.01.28.03.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 03:45:13 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, vinod.koul@linaro.org,
        niklas.cassel@linaro.org, khasim.mohammed@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/3] qcom: add PMS405 SPMI regulator
Date:   Mon, 28 Jan 2019 12:45:01 +0100
Message-Id: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset applies cleanly on linux 5.0-rc2.

It adds support for the pms405 spmi regulators and configures s3 as a
supply.

The dts modifications required to enable voltage scaling will be
posted after the currently pending cpufreq patches are merged.

Jorge Ramirez-Ortiz (3):
  dt-bindings: qcom_spmi: Document pms405 support
  drivers: regulator: qcom: add PMS405 SPMI regulator
  arm64: dts: qcom: pms405: add spmi regulators

 .../bindings/regulator/qcom,spmi-regulator.txt     |  24 +++
 arch/arm64/boot/dts/qcom/pms405.dtsi               |  20 +++
 drivers/regulator/qcom_spmi-regulator.c            | 197 +++++++++++++++++++--
 3 files changed, 224 insertions(+), 17 deletions(-)

-- 
2.7.4

