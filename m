Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DD2C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DDE208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqIeFL6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DDE208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933421AbeFUNm0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:42:26 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35581 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933002AbeFUNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:42:22 -0400
Received: by mail-wr0-f194.google.com with SMTP id l8-v6so3274377wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 06:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NfSv0nj1BuZ8P+/FSyMM6pwFQ6CZ25SaeF+dN18JqeM=;
        b=QqIeFL6qusIPLPBq9J6LZ7b/zfeb+s6727NxUovL5K0ZyLthP+qkVqjM9LVjJhkYu4
         E3MvornFPUC7xVxBAKGQ8EuwrbX9BNCECl9bdW/KHCF/VQWlULkzCCISaSqWF1GfgKbT
         mirXVVEfkA34fJY2o8eqstMtfPPQ+GdTi7AaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NfSv0nj1BuZ8P+/FSyMM6pwFQ6CZ25SaeF+dN18JqeM=;
        b=AGeR2hfYm4KytZvb1hB4XlUGl0vet4oMlMC13Pa6/o5oVQ9IqC+LJ2CgLiflnLb7eJ
         D53JsOi7WseUk4WYEVT9Rhu4fgYw+4cJGWWVeRurAsbcLYTGq+EqiFyBzuZHWbFznCor
         84AOkPQp/nmTVztKHGLUP5iprCwxzzg0b/gVhNjfANJW6KSa0AwFC8N7uYJcUy2z4BTe
         qahwSFMHMefYds+BbNWIkUTUSfQWiblxR9SZmb6tcNIdrnQZoLmBKwNvvZwuYT3JzxcC
         omgiIqzAwKKr39iegym6tZovOWPLEJvUFHm4yMZDgH3+xfbU4Xp0h4eecZ3tNP90yCew
         sUiw==
X-Gm-Message-State: APt69E1ao8j+LaleDBiGoRDDIBAFo2p81beLRrd4bQ1fXfLQ4QlkcKJY
        qVijwsYRF9QwmS7Imorm6GN5Sg==
X-Google-Smtp-Source: ADUXVKJ2YQzAInsqC8tTpRMc6jca1yx+Db8QPEAEqtdWbJHPPUuffE4OBBU9TgYGjZgjywgb5T8yqQ==
X-Received: by 2002:adf:9b01:: with SMTP id b1-v6mr5185155wrc.181.1529588541654;
        Thu, 21 Jun 2018 06:42:21 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r2-v6sm4797513wrq.55.2018.06.21.06.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jun 2018 06:42:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, broonie@kernel.org
Cc:     sdharia@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        ctatlor97@gmail.com, vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] slimbus: Add Stream Support
Date:   Thu, 21 Jun 2018 14:40:07 +0100
Message-Id: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds basic stream support for SLIMbus devices and
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

Tested this patchset with WCD9335 codec playback on DB820c on
top of 4.18-rc1 with qdsp6.

I have pushed my working branch to [1] incase someone want to try.

[1]:https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=slimbus-ngd


Thanks,
srini

Srinivas Kandagatla (2):
  slimbus: stream: add stream support
  slimbus: ngd: add stream support

 Documentation/driver-api/slimbus.rst |   5 +
 drivers/slimbus/Makefile             |   2 +-
 drivers/slimbus/core.c               |   2 +
 drivers/slimbus/qcom-ngd-ctrl.c      | 144 +++++++++-
 drivers/slimbus/slimbus.h            | 206 +++++++++++++++
 drivers/slimbus/stream.c             | 493 +++++++++++++++++++++++++++++++++++
 include/linux/slimbus.h              |  56 ++++
 7 files changed, 905 insertions(+), 3 deletions(-)
 create mode 100644 drivers/slimbus/stream.c

-- 
2.16.2

