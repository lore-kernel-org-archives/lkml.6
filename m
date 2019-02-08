Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF47BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFF1218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvx1Kqgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfBHNXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:23:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44693 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBHNXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:23:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id v16so3511879wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gF3HRrnToBNb9Vm3Va2jq+6CBn36T82L5pS+JyLAmHc=;
        b=kvx1KqggRS41/8ecBa+FvibNHlIMvmQZu95hG5hj6LrnqD2m5z7JbjBqpMcoz3it9U
         BksAI822SxVBtJZsh+aLWi+JH/j3Ng09MrP73yvyKWLZyBzjf2RSyFPDskTQxkchvxkJ
         q03NKFq4AlI4/aYGQiZpxfVbFB8LGdwv5sbnSo0ES4MW1xL+ddGKxoW/xkD5E6bzWksR
         0yTOTGElt64j4uZSX4qDeQvxrOXvtNtom9QGERHwJcXdvd9wyOwlBJWVK9my9lvXGWF/
         l1uVLBCisyLMsXJVQCowscjEVWOGgc8YwZBmk/Gvs0lmvt1KDDnwLjZ18sBtOXpa9MwH
         ZxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gF3HRrnToBNb9Vm3Va2jq+6CBn36T82L5pS+JyLAmHc=;
        b=VKnbsoFoNmtBkNp7AQ/wAFT2X1UjHOCydZGHLF7wDr/FEEzZynEabd/5BBLDjXUsr4
         DcOG5kZQpRGdy52T1m/nZY+T34QB4SIgnhpqgil/ZzDUzP+GLxpwMONYDDs1rLQ1P8gN
         ETWfLfxEBf5OFFI8on8ZgqMIET1WAo+V+ABRBMIYxeiBTOKE5Av7Sc8BxgOHbzKE3kHZ
         IklFZDEpuxV/Ps/IJt7gIk/cX3Xnm1Ygk5ozwzvtCq6zxxwPAlUHDp/iqCDEQdgzH80f
         hdDiTX/0tZByBJrSnTGvnkwymxrvKYuLTXuaIh/dyvex1llJGF73R0z/bw+72PlbSKzr
         1dLg==
X-Gm-Message-State: AHQUAuaA+t4uXqkbZvS3VRZuaOpd6GheNQt4ZPkyLo8iJfsc+lHyMFvz
        RbPD5flZoLxaCpicRh0VcHn2AQ==
X-Google-Smtp-Source: AHgI3IbdjUG2fPN+4RXK3LgiYBYNLZfWJkQ3rrn47FhqzERp4eeSbOm8sWhWEcc6GK+3ZMOPe2CfNA==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr17115689wrw.123.1549632201760;
        Fri, 08 Feb 2019 05:23:21 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id m21sm3033007wmi.43.2019.02.08.05.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Feb 2019 05:23:20 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 0/5] misc: Add support to Qualcomm FastRPC driver
Date:   Fri,  8 Feb 2019 13:23:01 +0000
Message-Id: <20190208132306.12571-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the v5 here is new version addressing the
comments from v6.
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

Change since v5 (https://patchwork.kernel.org/cover/10792749/) :
- Fix domain id range check spotted by Thierry
- Add missing dma_unmap_sg spotted by Thierry
- Add refcounting to invoke context, to make sure that we do not free/unmap 
	buffers when dsp is actively using it.
- Rebased on top of char-misc-next branch

Changes since v4(https://patchwork.kernel.org/cover/10779341/) :
- collected acks for DT from Rob.
- Removed unnecessary list safe iteration spotted by Greg KH.
- Removed unnecessary syslog spams.
- Added more checks to input validity.

Changes since v3(https://patchwork.kernel.org/cover/10763343/) :
- removed secured property from dt binding, defer it till we add
	support to secure buffers.
- reword various bits in bindings suggested by Rob Herring

Changes since v2 (https://lkml.org/lkml/2018/12/7/550) :
- removed compat_ioctl specific structures and various cleanups as
  suggested by Greg KH
- replace reg property with label property as suggested by Bjorn
- minor content cleanup in bindings as suggested by Mark Rutland

Changes since RFC:
- moved from char to misc driver as suggested by Greg KH
- updated ioctl data structures as suggested by Arnd.
- cleaned up and reorganized most of the code from RFC review comments.


Srinivas Kandagatla (5):
  misc: dt-bindings: Add Qualcomm Fastrpc bindings
  misc: fastrpc: Add Qualcomm fastrpc basic driver model
  misc: fastrpc: Add support for context Invoke method
  misc: fastrpc: Add support for create remote init process
  misc: fastrpc: Add support for dmabuf exporter

 .../devicetree/bindings/misc/qcom,fastrpc.txt |   78 +
 drivers/misc/Kconfig                          |   10 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/fastrpc.c                        | 1386 +++++++++++++++++
 include/uapi/misc/fastrpc.h                   |   41 +
 5 files changed, 1516 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
 create mode 100644 drivers/misc/fastrpc.c
 create mode 100644 include/uapi/misc/fastrpc.h

-- 
2.20.1

