Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5C4C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F47520850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ulz79bg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F47520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbeLFACf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:02:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36859 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeLFACd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:02:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id u3so21459085wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 16:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NSFTQSZEayHkouMtOVDMYNOLbXr1bjPpdi/mDF9F+Qo=;
        b=Ulz79bg++xmJw0us1fP/5iobRbrXiGj4E2bazK6TBtWVSotAG0leHynY5ZEmxMwF02
         WieFxjPZnrbcQvlJKU2VGauIoQKawe6INuCAlnWNVBPlp8uI8l4V6utawdZ6bFDF6bX+
         sM8NCSvz8QJ+QKPtmd+wI8/uismItWGzQCrVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NSFTQSZEayHkouMtOVDMYNOLbXr1bjPpdi/mDF9F+Qo=;
        b=HiOQLp0VWPoaRhMLsNog9inOq3KutNr89AHrnBS6Y3qQAzmi8OlBUdpWLT/II1rTMP
         azsvaIx6yWvVvK6vbZd48rXrFCvAivQ7/NWvssPG8wtNjEWWE4wGrqKulecqF+nXY5V+
         grjM1yqm1xIFAwfdvCz++yOR+mqhUR4JadRrrU1w/FYlM0GaNtwSgHJiU8/WD0W9q5uS
         MRkVO4kdsa8cvcgftZUkFUm6RXOiPbIegrDsN0DCwlLznqizCOe072fWADMGU1/s1wpg
         xJ7o9HvUc784CQ/sSWzH7tvJfLtGzBQ4JBPMO2NhcFwQzeiGZLZ4nRpVf28F3AxWF/LH
         ZpoA==
X-Gm-Message-State: AA+aEWYULZOWu0F+xwm/5M5XTMOlIn0nlHlhBKEYJLe836oTdibhZsXV
        McZykRt5uPxH3oksdESTf5dmSw==
X-Google-Smtp-Source: AFSGD/UOXfHw2Cr/4pA4ikcp6r+AOcGEVJFHazqpXw14hbGIR+As/CsRwoC5Tn8pcuCk9SX+FsLYnw==
X-Received: by 2002:adf:e149:: with SMTP id f9mr25286999wri.42.1544054552174;
        Wed, 05 Dec 2018 16:02:32 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
        by smtp.gmail.com with ESMTPSA id i9sm23241184wrs.34.2018.12.05.16.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 16:02:31 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     mike.leach@linaro.org, linux@armlinux.org.uk,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Subject: [PATCH v3 0/2] Update AMBA driver for enhanced component ID spec.
Date:   Thu,  6 Dec 2018 00:02:24 +0000
Message-Id: <20181206000226.2507-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest ARM CoreSight specification updates the component identification
requirements for all components attached to an AMBA bus. (ARM IHI 0029E)

This specification defines bits 15:12 in the ComponentID (CID) value as the
device class. Identification requirements now depend on this class.
Class 0xF: Traditional components identified by Peripheral ID (PID) only.
Class 0x9: CoreSight components may be identified by a Universal Component
Identifier (UCI) consisting of the PID plus CoreSight DevType and DevArch
values.

Current and future ARM CoreSight IP will now use the same PID for
components on the same function - e.g. the ETM, CTI, PMU and Debug elements
associated with a core. The first core to use this UCI method is the A35,
which currently has binding entries in the ETMv4 driver.

This patchset prepares for the addition of the upcoming CTI driver, which
will need to correctly bind with A35 and future hardware, while overcoming
the limitation of binding by PID alone, which cannot now work.

The patchset updates the current AMBA Identification mechanism, which was
already differentiating between 0xF and 0x9 CIDs, to add
additional UCI compliant tests for the for the 0x9 device class.

Additional UCI structures are provided and added to the ETMv4 driver as
appropriate.

Changes since v2:
Simplification of amba_cs_uci_id_match().
Fix CID class bitfield comments.
Dropped RFC tag on patchset.

Mike Leach (2):
  drivers: amba: Updates to component identification for driver
    matching.
  coresight: etmv4: Update ID register table to add  UCI support

 drivers/amba/bus.c                            | 45 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.c | 18 +++++++-
 include/linux/amba/bus.h                      | 32 +++++++++++++
 3 files changed, 86 insertions(+), 9 deletions(-)

-- 
2.19.1

