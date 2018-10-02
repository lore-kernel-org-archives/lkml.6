Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D98EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72522064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWMptOoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72522064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeJBXvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:51:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36276 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeJBXvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:51:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id n23-v6so2939031wmc.1;
        Tue, 02 Oct 2018 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fbinjb12SuECNlp6FCMnpLMpAcQ/l7HutTrqwjPhD4k=;
        b=lWMptOoz3KBcqlC/gV2UwScCB0x++cEwYutBen8qylf65dTz7GUhBfJ9RCuu8EpmiE
         F+AeEhXsfkqz95VkP03rQbFaV9QxfeIEKdlAV1qbeNnGW+LcLRHNOzsP6eu7l0DWBVqA
         exHiWEN4EsuoFSe5XtbW4KM4tBuF7ggnR72GsoPoCF4aoYmhkhUqwwO97D6PZ2lIx+ua
         V3kEqjJ1YKJl+Rk03Ll4sO2Brg3EbhR6NDdbK1/jUB+M9RfPcGGTLjtqRHiz8/HqaMjC
         CKiDGlBDR1GVd+n1wByG6J28nd4aLXUPr3+r1S/WkDPofmj5IRUtLdlMJNqKwaa9gaOu
         MwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fbinjb12SuECNlp6FCMnpLMpAcQ/l7HutTrqwjPhD4k=;
        b=MZVLj9Twgf69mjJy0cbPjoFHycfObCPESNJGYJ6Y1/2TLPAJG0zkrA7l36q0C8GJe5
         gZyK1rQqk97kAJJf5CKNKySGD6F8ME0+a8J+VL+ebtAC3rHMkNAJD2XWgKqIb0vaG7dZ
         7YlLLk3zHsOfZVl1UEYyC10hjzB+cC43t/tp/8a6XETG5ZJGYBttk/oPDOFMomidSb9A
         pHIuUc7EuK6KQJN7W2wlcCrtnjofRuvbH+G1lZtnAw2aB3NQ32Xjetq0KsHnHuRtPVsu
         1/LgcOowucJh5n28WSiRdRmbJyEshoGKO3ftUbdfhbwWs4oQ8FDP25NNAVRlcW/QL3XM
         AiYQ==
X-Gm-Message-State: ABuFfohEyC5FrkYleBRL/SJA0i37kkomnn/v9VDCucBz4FnOfSeQXAc9
        60gsauQ0NlpzH6lp+gxwBhw=
X-Google-Smtp-Source: ACcGV60O9lRbrnCHNwlx50agLoIW4bmsmlev8UEK7ZICppBe/7LS6UtWnhs0K2kGn4qUptpLqPmshg==
X-Received: by 2002:a1c:c64c:: with SMTP id w73-v6mr2344753wmf.21.1538500009061;
        Tue, 02 Oct 2018 10:06:49 -0700 (PDT)
Received: from localhost.localdomain (generic-nat1.unisi.it. [193.205.5.2])
        by smtp.gmail.com with ESMTPSA id c19-v6sm16799508wre.86.2018.10.02.10.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 10:06:47 -0700 (PDT)
From:   ektor5 <ek5.chimenti@gmail.com>
Cc:     hverkuil@xs4all.nl, luca.pisani@udoo.org, jose.abreu@synopsys.com,
        sean@mess.org, sakari.ailus@linux.intel.com,
        ektor5 <ek5.chimenti@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 0/2] Add SECO Boards CEC device driver
Date:   Tue,  2 Oct 2018 18:59:54 +0200
Message-Id: <cover.1538474121.git.ek5.chimenti@gmail.com>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches aims to add CEC functionalities to SECO
devices, in particular UDOO X86.

The communication is achieved via Braswell SMBus (i2c-i801) to the
onboard STM32 microcontroller that handles the CEC signals. The driver
use direct access to the PCI addresses, due to the limitations of the
specific driver in presence of ACPI calls.

The basic functionalities are tested with success with cec-ctl and
cec-compliance.

Ettore Chimenti (2):
  media: add SECO cec driver
  seco-cec: add Consumer-IR support

 MAINTAINERS                                |   6 +
 drivers/media/platform/Kconfig             |  21 +
 drivers/media/platform/Makefile            |   4 +
 drivers/media/platform/seco-cec/Makefile   |   1 +
 drivers/media/platform/seco-cec/seco-cec.c | 859 +++++++++++++++++++++
 drivers/media/platform/seco-cec/seco-cec.h | 143 ++++
 6 files changed, 1034 insertions(+)
 create mode 100644 drivers/media/platform/seco-cec/Makefile
 create mode 100644 drivers/media/platform/seco-cec/seco-cec.c
 create mode 100644 drivers/media/platform/seco-cec/seco-cec.h

-- 
2.18.0

