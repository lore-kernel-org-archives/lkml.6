Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8176C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F7220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XC40RIRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfANTmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:42:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38817 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfANTmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:42:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so265095wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wiZisbbakRt+Z0PHj0nHYS0qlLXlPgH++E8Oy4B0iQo=;
        b=XC40RIRDL4TBODvCy35jmiqNYAU1iglGEDX2oeg8Xw8ChxFe01C5CqonzpktbcwJyh
         f+GopzIum5Ttn1BNegG3Ov2gpQrglDNa2FoidTFxWeOBgEplx9gu5cYr+e/dkXSGL70L
         6mZ8Pa2702ZyEURgxXVyzfsB/hsCwgOpuRo3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wiZisbbakRt+Z0PHj0nHYS0qlLXlPgH++E8Oy4B0iQo=;
        b=Nis7YekonVvpmR6XoTR+UsMhRSFPFxDMtTnor+jFbPh+vZjU8d4HQVLbF1lUmtZl/V
         SfOrVOYxqZhvcLKkzq9iFdTY72FfZ8UrtW5KanRP+qegCvAVBOo9nP8i8wZbjxQeGtay
         PavTgZxr7XsLUh9aB/xrPPgNewHwdF4C0sW6aV6zgOlBvp2Du7O4vkMeuIIpsjKiINZh
         6qf5GR9cBYLM+L4yw7I3w0KTviVEQ2M1xSqAmk1p+HhL7G9hIQf7K2fNyoh4AGTMWqU+
         7IG2STBG+GmJdOJI2DQvEAFo5Rzpur+VUeZMnBdgXUqoFOET7bjSgNT2q8GbupSFMAT4
         OvVw==
X-Gm-Message-State: AJcUukewF+C0+kzMEiP/EhCyNS+lLt0xUR/sRiQWNSBRBV7g/BoBEwXs
        ES26eYT8m0GpT0FE7zaFu9oMog==
X-Google-Smtp-Source: ALg8bN4/DbDdQpp4u8ElbhbNP3ERTJ6xcfvOJ4l15up7w0j0/6FRPVmTokfSCkftbQpsRv6BRHNLTw==
X-Received: by 2002:adf:a357:: with SMTP id d23mr50868wrb.195.1547494932606;
        Mon, 14 Jan 2019 11:42:12 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b7sm66779996wrs.47.2019.01.14.11.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 11:42:11 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/5] misc: Add support to Qualcomm FastRPC driver
Date:   Mon, 14 Jan 2019 19:41:07 +0000
Message-Id: <20190114194112.32567-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the v2, here is new version addressing the
comments from v2.
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

Changes since v2 (https://lkml.org/lkml/2018/12/7/550) :
- removed compat_ioctl specific structures and various cleanups as
  suggested by Greg KH
- replace reg property with label property as suggested by Bjorn
- minor content cleanup in bindings as suggested by Mark Rutland

Srinivas Kandagatla (5):
  misc: dt-bindings: Add Qualcomm Fastrpc bindings
  misc: fastrpc: Add Qualcomm fastrpc basic driver model
  misc: fastrpc: Add support for context Invoke method
  misc: fastrpc: Add support for create remote init process
  misc: fastrpc: Add support for dmabuf exporter

 .../devicetree/bindings/misc/qcom,fastrpc.txt |   84 +
 drivers/misc/Kconfig                          |   10 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/fastrpc.c                        | 1356 +++++++++++++++++
 include/uapi/misc/fastrpc.h                   |   41 +
 5 files changed, 1492 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
 create mode 100644 drivers/misc/fastrpc.c
 create mode 100644 include/uapi/misc/fastrpc.h

-- 
2.20.1

