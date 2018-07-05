Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8EBC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F9824053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVHAtAxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F9824053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbeGEN4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:56:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35658 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753290AbeGEN4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:56:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id v3-v6so7388292wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gZ8G7/M4bQb3y24SbSR4gjMJyuSqhWWhxZM34dYau0k=;
        b=HVHAtAxRe1ElkJk7Klw+cj4UJOcHkEq4m33sAZ+81t8ScZQYfadfvFfnm/pM4ZDXTe
         08SwhmexYoOAE8hkhOO1hxxOJxE+oNMu30/0s7alPKdV03SxD46e0I5HaQZBI5hZX+lu
         1wGH6IaSj/ObAAZqTgK31ZNsS3moRZ1J1dUXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gZ8G7/M4bQb3y24SbSR4gjMJyuSqhWWhxZM34dYau0k=;
        b=d8QA5BB0UhQ1swjJ90ddVDYdxkku0AWshDqItvGxVJJGNwVB6E5KT0NuX6TQl5PTw+
         IFFJ7b/oTtJovIL5xDAgY9cvbQ9raxOwWfifnCJDrKSPkZVhcKuzfymCmaC6oj+v5SpZ
         9F5MdU/nTQC2bOcAweC4kUov4ypFfymS6L9CHahJiiLZ/2IkOtrNxe3Q8VqqfpVPfcBV
         cDw206bL3ConO7JsRL98CSJaU4EgBH4SrcQosa8DKd2LtXmHrqF4wVlTVTkJT1SZ0et2
         5D21+I0KVHBC+wcxJROoH3Z18bkxirVGPcAmHJqdss21+xr/kiqTcOnIdcr7Nf/ivaJe
         KPdg==
X-Gm-Message-State: APt69E2E3FVwuZTi/j6ITcCvBNX7XswvERc/Il9IFeu/SjpC/4xuCq30
        YTC1/L1/OYqvMuCO3g0Z+YGD1w==
X-Google-Smtp-Source: AAOMgpf5n3+C55ScI3YxCpcXsgBXIxI291etq6G+z96jRo/QtUhZWZtsoatiSXkmKleKGc7ZnDSAVg==
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr4113909wmi.16.1530799004414;
        Thu, 05 Jul 2018 06:56:44 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id l17-v6sm11003297wrh.45.2018.07.05.06.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 06:56:43 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, broonie@kernel.org
Cc:     vkoul@kernel.org, ctatlor97@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sdharia@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/2] slimbus: Add Stream Support
Date:   Thu,  5 Jul 2018 14:54:24 +0100
Message-Id: <20180705135426.20748-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Vinod and Stephen for reviewing v1 patchset

This v2 patchset adds basic stream support for SLIMbus devices and
controllers. Mostly inspired by soundwire stream patches. But slimbus
stream is much simpler compared to soundwire

From slim_device side, we have below 6 new apis.
slim_stream_allocate() - allocating runtime slim stream
slim_stream_prepare() - to configure runtime stream with config
slim_stream_enable() - enable channels/ports for data
slim_stream_disable() - disable channels/ports.
slim_stream_unprepare() - un configure runtime stream
slim_stream_free() - free all associated memory.

From Controller side:
Data channel Management and reconfiguration messages are applicable for
all the controllers which are inline with SLIMbus specs. However light
weight controller like NGD which have user specific implementation of
some messages need to be invoked instead of standard message commands.
For usecases like this simple enable/disable stream apis are provided.

Assumptions:
1> Current design assumes that the channel and ports are statically allocated
to the device during SoC integration, which is the case with all the
Qualcomm SoCs.
2> One-to-One mapping between Port and Channel, SLIMBus versions earlier
than 2.0 has only one endpoint per port. Current patchset can be extended
to support more than one endpoints per port.
3> Only audio usecase, This patchset only supports Isochronous and Push/Pull
transport protocols, which are sufficient for audio use cases.
4> DSP does all the data handling for the allocated channels. Which is true
for Qcom SoCs.

TODO:
	Bandwidth management.

Dependency:
	This patchset has dependency on the NGD driver
	https://patchwork.kernel.org/patch/10474959/

Tested this patchset with WCD9335 codec playback and capture on DB820c 
using 4.18-rc1 with qdsp6 + slim tx patches merged in sound.git.

I have pushed my working branch to [1] incase someone want to try.

[1]:https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=slimbus-ngd

Changes since v1 (https://lwn.net/Articles/758100/):
	- removed redundant state machine checks for audio usecases, suggested by Vinod.
	- fixed few typos.
	- removed irqsave/restore spinlock variant spotted by Vinod.
	- general cleanups suggested by Stephen and Vinod.
thanks,
srini


Srinivas Kandagatla (2):
  slimbus: stream: add stream support
  slimbus: ngd: add stream support

 Documentation/driver-api/slimbus.rst |   5 +
 drivers/slimbus/Makefile             |   2 +-
 drivers/slimbus/core.c               |   2 +
 drivers/slimbus/qcom-ngd-ctrl.c      | 149 ++++++++++-
 drivers/slimbus/slimbus.h            | 189 ++++++++++++++
 drivers/slimbus/stream.c             | 477 +++++++++++++++++++++++++++++++++++
 include/linux/slimbus.h              |  46 ++++
 7 files changed, 867 insertions(+), 3 deletions(-)
 create mode 100644 drivers/slimbus/stream.c

-- 
2.16.2

