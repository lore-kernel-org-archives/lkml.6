Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154AAC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20D3206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iketsFyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20D3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeK3V4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:56:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38361 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeK3V4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:56:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so4812324wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 02:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jx7LbWVa5Ce2Es6m6aTsyTp+I82kqldODHcmjf78ls=;
        b=iketsFybB/O2dcvylgjf7WEpISOsctbaZPZAvfv0Rta1FqxGocixw2eRI7pKkcpOKd
         uhd2IxhcbwOLlGKfQIdVIioT8fB2djfU02yPWZWpgx3J6cwFDJwBiEeXKCNcd9mvSvZr
         sxOGPHBxEV3zfq/CoKxSAF1K9gcL4ZoiOPh1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jx7LbWVa5Ce2Es6m6aTsyTp+I82kqldODHcmjf78ls=;
        b=hapehJf0VgqXoMTX9kFTkFusSQiSROfnomhrgwPXnPHcscg5GcRlDEWWFwKTXcLsRD
         ynfaY/kMwG3WgvoXU7drZaydeT8tnHy4usS2zbZDcvExHhAAtT1K7ZdZ0HRpoRK5essR
         hywT+sgPs0rvdqseyqxYDJwVyXI8/2dz7Q5be1JQmjiAOJ4w43SrmlBXU99Qh0JsMabd
         Cr84UKdXsWIchWXzEQ0E20FlTOUyunUi2epox1oyWIgcCnI/yi3ocT0pdy612ZHx9jMP
         STGTmxS7AFInfLSGKcw4r3O/xLu9uAdiOElg9zjKUuy8aKWqQ7xlZn9UkjQLETimjcAk
         6jDw==
X-Gm-Message-State: AA+aEWYUJz5ZOeQPEFTyC3g24Bd7/Ozei6/pLbL4yXnQfKPcjJBatS9K
        gzMsXfiOW+TkOFlTjqoPrzHt1w==
X-Google-Smtp-Source: AFSGD/UqvuoVbXsYfnrYAp01sovn8r4WabMD+IMrXK9OayEBl/fNBlvKWpXLQO9uQK9yphbGvZFYHQ==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr4346863wrv.202.1543574877741;
        Fri, 30 Nov 2018 02:47:57 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id 18sm6964211wmm.32.2018.11.30.02.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 02:47:57 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 0/6] char: Add support to Qualcomm FastRPC driver
Date:   Fri, 30 Nov 2018 10:46:51 +0000
Message-Id: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Keeping the first version simple, below are few things are TODO:
 - Support INIT_STATIC process
 - Support remote mmap/unmap methods.
 - Handling secure compute context banks.
 - Add secure buffer support

This patchset has been tested on DB410c(msm8916), DB820c (msm8996), SDM845
Qualcomm SoCs with sample apps like matrix multiply, calculator
from Hexagon SDK.

Thanks,
srini

Srinivas Kandagatla (5):
  char: dt-bindings: Add Qualcomm Fastrpc bindings
  char: fastrpc: Add Qualcomm fastrpc basic driver model
  char: fastrpc: Add support for context Invoke method
  char: fastrpc: Add support for create remote init process
  char: fastrpc: Add support for dmabuf exporter

Thierry Escande (1):
  char: fastrpc: Add support for compat ioctls

 .../devicetree/bindings/char/qcom,fastrpc.txt |   73 +
 drivers/char/Kconfig                          |   10 +
 drivers/char/Makefile                         |    1 +
 drivers/char/fastrpc.c                        | 1749 +++++++++++++++++
 include/uapi/linux/fastrpc.h                  |   82 +
 5 files changed, 1915 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/char/qcom,fastrpc.txt
 create mode 100644 drivers/char/fastrpc.c
 create mode 100644 include/uapi/linux/fastrpc.h

-- 
2.19.2

