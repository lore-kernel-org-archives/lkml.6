Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB82C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A90C21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ny88ub/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfAXPZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:25:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33368 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfAXPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:25:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id p7so6956732wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 07:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JoyjsP80og1yOrGL6oyDzogxzzxq7s9glS1eTUSPFvM=;
        b=Ny88ub/Kk9gq2I0y33cIDHXavVGaXwXpXygkodg4isngsNxhs3k+KA5pDp53Keeu7q
         luT5zRGWBSN0aeD6GePboaQYwhnQ57knFLp3ywW3m0BDaCKyBtqWrNsk15rMwYtLEUsP
         uJCCfjkBdMtU+e8BpD4bMv382fDFLIPJD8ZdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JoyjsP80og1yOrGL6oyDzogxzzxq7s9glS1eTUSPFvM=;
        b=dBflnW66/f9skmkuT+coLXl/aDOlo0cE6smAy+8iWapR7+SUJathtXbTM7p80JBKDi
         hz+QA2O1fmuqsjIKjPDPHHpcEuB2uI/La6RbacDwSe91kiBOnStu6SUefPOp0nFy1a24
         xAo0R05gUF0URbOfZaYHv+pMiIl/4taU1kbkq+UWfnA9ztClcMwP5mZBBluwXTtTr6n7
         3BsIdT9Qv7nKPy2l2ZeRTg+1mDluobjWlm5d6e/RO7SHxEdtlWNmEMLZgAo6V2heHezi
         q0im7s09aTJHm7yx7zFpZ8u2qJo8uOFHygAdjlPTh7MBbkRydJejxkxIpBeGACx3XaWG
         tQCw==
X-Gm-Message-State: AJcUukfrTzy1MiwQip+XZl4+Z4zyXU02wa3FRiDvdFMDeeLGslRJlGQe
        Aj1IzftahRJxD+EgThzXG2utOxABc+Y=
X-Google-Smtp-Source: ALg8bN73lWl3adckG87FkCc2kd8XNqw/oGu/OixYnC4hDK8WgPcWvquhD2zX2dGXJjTvakK7c+LBZA==
X-Received: by 2002:a05:6000:f:: with SMTP id h15mr7333955wrx.248.1548343547081;
        Thu, 24 Jan 2019 07:25:47 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z12sm80371157wrh.35.2019.01.24.07.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 07:25:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/5] misc: Add support to Qualcomm FastRPC driver
Date:   Thu, 24 Jan 2019 15:24:07 +0000
Message-Id: <20190124152412.10503-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the v3, here is new version addressing the
comments from v3.
This patchset adds support to Qualcomm FastRPC driver which implements
an IPC (Inter-Processor Communication) mechanism that allows for clients
to transparently make remote method invocations across processor boundaries.

The below diagram depicts invocation of a single method where the client
and objects reside on different processors. An object could expose
multiple methods which can be grouped together and referred to as an
interface.

: ,--------,        ,------,  ,-----------,  ,------,        ,--------,
: |        | method |      |  |           |  |      | method |        |
: | Client |------->| Stub |->| Transport |->| Skel |------->| Object |
: |        |        |      |  |           |  |      |        |        |
: `--------`        `------`  `-----------`  `------`        `--------`

Client:    Linux user mode process that initiates the remote invocation
Stub:      Auto generated code linked in with the user mode process that
           takes care of marshaling parameters

Transport: Involved in carrying an invocation from a client to an
           object. This involves two portions: 1) FastRPC Linux
           kernel driver that receives the remote invocation, queues
           them up and then waits for the response after signaling the
           remote side. 2) Service running on the remote side that
           dequeues the messages from the queue and dispatches them for
           processing.
Skel:      Auto generated code that takes care of un-marshaling
           parameters
Object:    Method implementation

Most of the work is derived from various downstream Qualcomm kernels.
Credits to various Qualcomm authors who have contributed to this code.
Specially Tharun Kumar Merugu <mtharu@codeaurora.org>

TODO:
 - Support INIT_STATIC process
 - Support remote mmap/unmap methods.
 - Handling secure compute context banks.
 - Add secure buffer support

This patchset has been tested on DB410c(msm8916), DB820c (msm8996), SDM845
and QCS404 Qualcomm SoCs with sample apps like matrix multiply, calculator
from Hexagon SDK. You can find more info on how to test this at:
https://github.com/96boards/documentation/wiki/Dragonboard-Hexagon-DSP

Changes since v3(https://patchwork.kernel.org/cover/10763343/) :
- removed secured property from dt binding, defer it till we add
	support to secure buffers.
- reword various bits in bindings suggested by Rob Herring

Srinivas Kandagatla (5):
  misc: dt-bindings: Add Qualcomm Fastrpc bindings
  misc: fastrpc: Add Qualcomm fastrpc basic driver model
  misc: fastrpc: Add support for context Invoke method
  misc: fastrpc: Add support for create remote init process
  misc: fastrpc: Add support for dmabuf exporter

 .../devicetree/bindings/misc/qcom,fastrpc.txt |   78 +
 drivers/misc/Kconfig                          |   10 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/fastrpc.c                        | 1354 +++++++++++++++++
 include/uapi/misc/fastrpc.h                   |   41 +
 5 files changed, 1484 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
 create mode 100644 drivers/misc/fastrpc.c
 create mode 100644 include/uapi/misc/fastrpc.h

-- 
2.20.1

