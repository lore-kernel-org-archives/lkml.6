Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73C3C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C28420870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jcx86OD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C28420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeLJKXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:23:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35668 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeLJKXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:23:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so9877425wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E55urFktBVJM2wfmpqkyl6MfKSKGPuDf2s6mSVnoNUc=;
        b=Jcx86OD2ELVvtx/VPQ232dBAHgalgu4FyjPIoPyXLfXMTFyQB1S38RmLrFaEA2NRK3
         mdq8eTu4hFOzn9eIpVqCx6s0F4fvTl35sjRjR/YAf0Bti7TXv9i6u44DX+2eHgzpt/B3
         uLR7HlBDxaHR+eEJB7SxjyRzcxDi3ZihWET78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E55urFktBVJM2wfmpqkyl6MfKSKGPuDf2s6mSVnoNUc=;
        b=hOUkNtFPj+C1LbnWNKrU6OQVCBUXER0dcBaf4MMDL6M/Dlrr835LBLT4/jPko6RIFI
         LrBOadck9S4zB0C9tx7+SU6A+i4DzgVOzLnDdGcX1NU/FT9sA83qAcnh6l/3EhW9zBrH
         kKjWhC+1hKyIW+w6wElbRIB00CQi8wP6/eAufBAjJbV/C4DeP1AGtxhpPOhFWyni8vKA
         SUG+ByuU+UtZfeNfcD7S9hJTbibDXLpqzUosAjzH1vFnYww7ZxX4WHOoyZ1Vz1fUhhns
         L3xnU63CVj1/K5iUc3QpQW91yFYbIb93jcvitOpIlHGEvJZxCvsuyUxrpHyWCEAhClKb
         KbgA==
X-Gm-Message-State: AA+aEWYV8RmEq3RMQIcmb7vTctWruFk2ngtznATcvhq0H+vLhfKnFDYp
        uJN/f4eVSfhXTaa84vvcFh2TaA==
X-Google-Smtp-Source: AFSGD/VgKl63jhsjccIH3wISI9ia/Uw8UGwflFh9LXYiI1UehAA4WUM/cK18dQCZOqT42lK8SB8dgw==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr9247898wrp.61.1544437394612;
        Mon, 10 Dec 2018 02:23:14 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id r64sm12266664wmg.5.2018.12.10.02.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 02:23:14 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/4] irqchip/gic-v3: Add support to DT based quirk for msm8996
Date:   Mon, 10 Dec 2018 10:23:05 +0000
Message-Id: <20181210102309.8207-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to GICR_WAKER is restricted on msm8996 SoC in Hypervisor.
There are many devices out there with this restriction in place
and there has been no update to this firmware since last few years,
making those devices totally unusable for upstream development.

My previous attempts to add quirk based on IIDR register value seems to be
flawed by the fact that the value conflicted with other SoCs.
Last Suggestion by Marc Z using compatible seems to be the only way to apply
quirks required for msm8996 based SoCs.

Here is the patchset which add new compatible for msm8996 gicv3 and add
support gic_enable_of_quirks() followed by the actual quirk required for msm8996.

Without this quirk many qcom SoCs (atleast 3 that I know) are
unable to boot mainline.

Changes since v3:
- removed __maybe unused annotation
- moved enabling quirks to gic_of_init() as suggested by Marc
- fixed quick comment as suggest by Marc

Thanks,
Srini

Srinivas Kandagatla (4):
  dt-bindings/gic-v3: Add msm8996 compatible string
  irqchip/gic: common: add support to device tree based quirks
  irqchip: gic-v3: Add quirk for msm8996 secured registers
  arm64: dts: add msm8996 compatible to gicv3

 .../interrupt-controller/arm,gic-v3.txt       |  4 ++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  2 +-
 drivers/irqchip/irq-gic-common.c              | 12 +++++++++
 drivers/irqchip/irq-gic-common.h              |  3 +++
 drivers/irqchip/irq-gic-v3.c                  | 25 +++++++++++++++++++
 5 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.19.2

