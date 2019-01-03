Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84380C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A3920883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CyI2N+OV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfACIzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:55:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45353 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfACIzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:55:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so15717665pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 00:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OENeZoKfZJsb/gIrBxN0ZEkZ+Q8TNlo3ohrEaRlf710=;
        b=CyI2N+OVjQi5uWlSQLVAgdyFsmvrhXGxYZqff+Ov0D5ZksF0ofN/iyDkSvekUMclc6
         qL4J3rsfFGB1sSdA3zfCHWw7OrTdMRstE7883hzTkad7opSlHvykGhD4F8NZ4thNgNBf
         jzogYGm7+1splVBpJFQnQVMeUwaWJa1pV6PEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OENeZoKfZJsb/gIrBxN0ZEkZ+Q8TNlo3ohrEaRlf710=;
        b=Kb8Ig5vQmKneewsB4C93sfYcADmF4ttLhY5ClYqR909YWoqJRo0Q66JPnXxAkoTBSl
         OZXBV2j9JJhrw5GOMxuSi+ntZb4qX5+FQEyEwp0Zb/dqmuQ2tTJEVJU/7eA9C66mJ7m+
         TBBNlE5m5/F0awXCRWxnXjDoYg0IuXAM1SJ61WBLuyPQZlOhTFuyDvahzEUceR1QMzRD
         6YoL4UgXIUCwlAvZJqWPMmuk/eWUuuoK33CWjo3KE0mNEmyyBSyNQQQmAqnPsB8aygf/
         bIPhca09osdjPh+4S6x+BOT74B1/TsPv6L6J1tHJMaG3uAc97AN9fWCnO6g36WRhcydQ
         H8oA==
X-Gm-Message-State: AJcUukeWDLlM4VaY8OgYBMzSe8Sw3BvW32NwzXLE1rNXg580WO1BD31k
        tIgfAPOnIzAMr1rSC3xJ4yiBLw==
X-Google-Smtp-Source: ALg8bN4T1KHmqiRlk+c6TrGr4RVac5RDUU8HwT2+IsOAtEu6O2TtYTjLmWoPH9O28bR92B7ERqUFfA==
X-Received: by 2002:a63:1b48:: with SMTP id b8mr16443274pgm.187.1546505748850;
        Thu, 03 Jan 2019 00:55:48 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s190sm78189727pfb.103.2019.01.03.00.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jan 2019 00:55:48 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v6 0/3] Stingray thermal driver support
Date:   Thu,  3 Jan 2019 14:25:31 +0530
Message-Id: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches adds the stingray thermal driver and its
corresponding DT nodes with documentation.

Changes from v5
  - Addressed Eduardo Valentin comments.

Changes from v4
  - Addressed Rob Herring comments on DT parameters and
    thermal driver architecture.
  - Removed brcm,max-crit-temp DT parameter
  - Changed driver to thermal sensor registration model.
  - Added trip DT properties.

Changes from v3
  - Addressed Daniel lezcano comments.
  - Elaborated commit description of thermal driver patch.
  - Added brcm,max-crit-temp DT parameter.

Changes from v2:
  - All stingray TMON DT nodes are combine together into single.
    Temperature registers are combined into one mem resource.
    brcm,tmon-mask parameter has available TMONs mask value.
  - All available TMONs are initialized together in single
    instance of driver probe call.

Changes from v1:
  - Fixed auto build sparce warning.

Pramod Kumar (3):
  dt-bindings: thermal: Add binding document for SR thermal
  thermal: broadcom: Add Stingray thermal driver
  arm64: dts: stingray: Add Stingray Thermal DT support.

 .../bindings/thermal/brcm,sr-thermal.txt           | 105 ++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89 +++++++++++++++
 drivers/thermal/Kconfig                            |   3 +-
 drivers/thermal/broadcom/Kconfig                   |   9 ++
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/sr-thermal.c              | 122 +++++++++++++++++++++
 6 files changed, 328 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
 create mode 100644 drivers/thermal/broadcom/sr-thermal.c

-- 
2.7.4

