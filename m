Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84EFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FB6218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yy7Q/kCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfBANLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:11:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53333 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBANLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:11:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so6078773wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 05:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ii/yIFzorgv8lkQFo9ZE4bXTzg8Ln5fex3jmkqOo5gc=;
        b=Yy7Q/kCW5mCuskNdBU79fGTLZr4b2xKeft7piZcPu11809VGXO84AogqAWeFOLudZc
         AVL4QLUFQxwWH0oauMZ/TnTzYxwLA4dSr3nP1xDaOM9bzCcWco+3mnT70VBlptpOermG
         7Z2Ds7lmjNYpl1Nq/i7P336ihexxNcgUjf2LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ii/yIFzorgv8lkQFo9ZE4bXTzg8Ln5fex3jmkqOo5gc=;
        b=cOcZNAJxHm8YRM6Sj/RtrPWMuCFo3JJKZlA7WksSR6eOFGjXsq3SfBbfEZEB//lXHp
         sAE2r1K7lVDXy9kSuBbR+qWv8QBH4vYqJvdM42nOJ1gE4sVz/1bR1Ay90vwEHnHNx29U
         6yyvz0aKH3cOZbkKi0Og9Teh2xRrtzB2v/zqpsx+r2/SAhiENgXMir/zXRpKKjjzBo0w
         E4ULcdwhS9IrI/rMUKNG7Trspu2CXYzG1vpiNEB79yn7IDhM7sGPUS+7dw+6exExnNvS
         N61LetckHoZRSz3z6FymaSUf+PArusCVuqJ2dg5ZEeIaTef+76n8s2GkFeThpxgHSx+J
         in7A==
X-Gm-Message-State: AHQUAuatzAo7dOtD0nlcTlcIo0HrV+TtdHnH0RsTjnHVKGnKAR9JQWHr
        1jLlyEVOnpaf0TJfC2SR2SfYcw==
X-Google-Smtp-Source: AHgI3IYRdFpO8JFcQQmrFmya3my2B+zXoaUS/Hg4U5nHSUkRzpSED9M79wBbxMN/zoWgpVkpRWFUuQ==
X-Received: by 2002:a1c:f509:: with SMTP id t9mr2560911wmh.76.1549026662944;
        Fri, 01 Feb 2019 05:11:02 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id a12sm12563461wro.18.2019.02.01.05.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 05:11:02 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 0/5] misc: Add support to Qualcomm FastRPC driver
Date:   Fri,  1 Feb 2019 13:09:20 +0000
Message-Id: <20190201130925.27066-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the v4, here is new version addressing the
comments from v4.
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

Changes since v4(https://patchwork.kernel.org/cover/10779341/) :
- collected acks for DT from Rob.
- Removed unnecessary list safe iteration spotted by Greg KH.
- Removed unnecessary syslog spams.
- Added more checks to input validity.

Srinivas Kandagatla (5):
  misc: dt-bindings: Add Qualcomm Fastrpc bindings
  misc: fastrpc: Add Qualcomm fastrpc basic driver model
  misc: fastrpc: Add support for context Invoke method
  misc: fastrpc: Add support for create remote init process
  misc: fastrpc: Add support for dmabuf exporter

 .../devicetree/bindings/misc/qcom,fastrpc.txt |   78 +
 drivers/misc/Kconfig                          |   10 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/fastrpc.c                        | 1366 +++++++++++++++++
 include/uapi/misc/fastrpc.h                   |   41 +
 5 files changed, 1496 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
 create mode 100644 drivers/misc/fastrpc.c
 create mode 100644 include/uapi/misc/fastrpc.h

-- 
2.20.1

