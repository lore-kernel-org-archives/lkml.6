Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B31ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF6E2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KgKOtHzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF6E2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbeIULsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:48:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45219 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388826AbeIULsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:48:32 -0400
Received: by mail-io1-f67.google.com with SMTP id e12-v6so11037920iok.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 23:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9DAVV7xx/W/F8Ed6sQhJxCtQYesZ2gsYjenfh0hVDIg=;
        b=KgKOtHzFTGs8V4wuo/yCj/doXUspnOTDu3chf5PaNnfXrF/gXB3E9dWwnEaYkyEXqb
         vNf+YdwJyqFczBleTgxjq1H7S4Lroyn6AsOw3Lm177l2Q7R2ajafFZxxANxyzGHHNYKk
         WFH3GnXC1Fe/Vi3tBFQy/a+k/hR/2sv+PQPbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9DAVV7xx/W/F8Ed6sQhJxCtQYesZ2gsYjenfh0hVDIg=;
        b=eG0dsHELYwP4YdxlQ+YKic7hCntdcgtm22rh3enuKDUAJOUpzp3dpqZHAAjug7vDkz
         3VywrKGn2DBsM8OHtbM3QgIfLkhFV48U/vp8i54+3jwQ/sEFjKzFk5WpM97NjfgK0SGw
         mH5h3A5cFFlt9Zab8XUmmcQ8xom0IbnH/QyQArh+iG1tdOYCckpqjwIUNEpNUqhVz79p
         uKlzCeBK6VUIGlBoJhE/JeFAnGXsRGJX0VztsWLGjd5BTvsVLHh38uT73bavZ3dSYW7g
         b0fpXV5j4qGb4FJCJDm8UbNlsl24W4x2UgRb3co38/xdtChzP+WMz0AjaWq7aquvRpK6
         QPCQ==
X-Gm-Message-State: APzg51CtQA7dVjfPCOm+WCUkCjRq/zt3Uyh7oSuL56I4pbcOL5rpKH4u
        gKOD4A+YnpZbv1+QCV/T7eCR
X-Google-Smtp-Source: ANB0VdYXtecl0LpsxmONkrsNPwtbKPyZ9pqbfMZw+wsl+AG8mT0HRrfZlGDfUMXu4cUWbPzCi+fKEA==
X-Received: by 2002:a5e:cb48:: with SMTP id h8-v6mr35872691iok.178.1537509675019;
        Thu, 20 Sep 2018 23:01:15 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id b195-v6sm1973875itc.42.2018.09.20.23.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 23:01:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        xuwei5@hisilicon.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/4] Add clock support for Hi3670 SoC
Date:   Thu, 20 Sep 2018 23:00:59 -0700
Message-Id: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds clock support for Hi3670 SoC from HiSilicon utilizing
the HiSi common clock code. While adding clock support, let's remove the
fixed clock for UART and source SoC clock on HiKey970 board.

This patchset has been verified on HiKey970 board.

Thanks,
Mani

Manivannan Sadhasivam (4):
  dt-bindings: clk: hisilicon: Add bindings for Hi3670 clk
  arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
  arm64: dts: hisilicon: Source SoC clock for UART6
  clk: hisilicon: Add clock driver for Hi3670 SoC

 .../bindings/clock/hi3670-clock.txt           |   43 +
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |   48 +-
 drivers/clk/hisilicon/Kconfig                 |    7 +
 drivers/clk/hisilicon/Makefile                |    1 +
 drivers/clk/hisilicon/clk-hi3670.c            | 1016 +++++++++++++++++
 include/dt-bindings/clock/hi3670-clock.h      |  348 ++++++
 6 files changed, 1458 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hi3670-clock.txt
 create mode 100644 drivers/clk/hisilicon/clk-hi3670.c
 create mode 100644 include/dt-bindings/clock/hi3670-clock.h

-- 
2.17.1

