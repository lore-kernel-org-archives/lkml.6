Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377AAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB9920842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgdzPSUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB9920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933806AbeGIPvO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:51:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50880 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932862AbeGIPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:51:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so21704840wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JBwgUY9XdcpCLn7G5kisS4OJZTr+Q70KEHxWV48EJMw=;
        b=jgdzPSUTVl4CF8OC6xzmEOqy2g7rrN0WYE6f2SiMXs0yYVt3jMESi5DwqztU9mBoCV
         8lj5zavazNqV1a1hxfUd4cH83LVPztxWUg6huFU7aZRikrWPNpTRFsvktxZ8//u8CqX+
         UGLWo8OUcgjEwKaD/jmpbASlGVZPbT1DUJJjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JBwgUY9XdcpCLn7G5kisS4OJZTr+Q70KEHxWV48EJMw=;
        b=T/gftzM16uVqcBYdRyMhDcSd/wllDmC5ReU3VB/sid2456KkO3nhdJxZAgeLykPCqO
         Wm9psUJ5EEYDEObWLde3S6G0YFFNA2TWiXe64yvAb6qU4Bh1Raq+vMKAlDV48ZxJzt+3
         U1vO5RAQIzdXvuop7ZXqZ9KlQ12zZqW04grRaDfao6Si1VlJWFKThGAf6SSvO4kQ7dbY
         LljyRpWU5oWECvXc41oO2tlLSfLqihcMMtvKPugnfbpbtL8vmC38qyva3R/82UMmtcL9
         v1f3WkRjtqS1+SM71Yml2SDoHH2WrBFBxSQlSv9xdtHGhY2IbqlXvXaDoMPyQrgVG3lv
         njfA==
X-Gm-Message-State: APt69E0C73qnpMPvthc/i4zN3ewzhOKTDfUCdycQsSudDGonQ40CAu6K
        dz2inGbpqa42LHE3EKZpRqiZzw==
X-Google-Smtp-Source: AAOMgpcbQ7fCVAcheKZv+mppojpAdPxK9XGhDI5NtBEayxmhivRsBi0bgHzKW2TXgA7iu2YRQME19Q==
X-Received: by 2002:a1c:6bd5:: with SMTP id a82-v6mr12042425wmi.108.1531151467196;
        Mon, 09 Jul 2018 08:51:07 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o21-v6sm16229202wmg.28.2018.07.09.08.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 08:51:06 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, abailon@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v6 0/8] Introduce on-chip interconnect API
Date:   Mon,  9 Jul 2018 18:50:56 +0300
Message-Id: <20180709155104.25528-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern SoCs have multiple processors and various dedicated cores (video, gpu,
graphics, modem). These cores are talking to each other and can generate a
lot of data flowing through the on-chip interconnects. These interconnect
buses could form different topologies such as crossbar, point to point buses,
hierarchical buses or use the network-on-chip concept.

These buses have been sized usually to handle use cases with high data
throughput but it is not necessary all the time and consume a lot of power.
Furthermore, the priority between masters can vary depending on the running
use case like video playback or CPU intensive tasks.

Having an API to control the requirement of the system in terms of bandwidth
and QoS, so we can adapt the interconnect configuration to match those by
scaling the frequencies, setting link priority and tuning QoS parameters.
This configuration can be a static, one-time operation done at boot for some
platforms or a dynamic set of operations that happen at run-time.

This patchset introduce a new API to get the requirement and configure the
interconnect buses across the entire chipset to fit with the current demand.
The API is NOT for changing the performance of the endpoint devices, but only
the interconnect path in between them.

The API is using a consumer/provider-based model, where the providers are
the interconnect buses and the consumers could be various drivers.
The consumers request interconnect resources (path) to an endpoint and set
the desired constraints on this data flow path. The provider(s) receive
requests from consumers and aggregate these requests for all master-slave
pairs on that path. Then the providers configure each participating in the
topology node according to the requested data flow path, physical links and
constraints. The topology could be complicated and multi-tiered and is SoC
specific.

Below is a simplified diagram of a real-world SoC topology. The interconnect
providers are the NoCs.

+----------------+    +----------------+
| HW Accelerator |--->|      M NoC     |<---------------+
+----------------+    +----------------+                |
                        |      |                    +------------+
 +-----+  +-------------+      V       +------+     |            |
 | DDR |  |                +--------+  | PCIe |     |            |
 +-----+  |                | Slaves |  +------+     |            |
   ^ ^    |                +--------+     |         |   C NoC    |
   | |    V                               V         |            |
+------------------+   +------------------------+   |            |   +-----+
|                  |-->|                        |-->|            |-->| CPU |
|                  |-->|                        |<--|            |   +-----+
|     Mem NoC      |   |         S NoC          |   +------------+
|                  |<--|                        |---------+    |
|                  |<--|                        |<------+ |    |   +--------+
+------------------+   +------------------------+       | |    +-->| Slaves |
  ^  ^    ^    ^          ^                             | |        +--------+
  |  |    |    |          |                             | V
+------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
| CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
+------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
          |
      +-------+
      | Modem |
      +-------+

TODO:
 * Create icc_set_extended() to handle parameters such as latency and other
   QoS values.
 * Convert from using global node identifiers to local per provider ids.
 * Cache the path between the nodes instead of walking the graph on each get().
 * Sync interconnect requests with the idle state of the device.

Changes since patchset v5 (https://lkml.org/lkml/2018/6/20/453)
* Fix the modular build, make rpm-smd driver a module.
* Optimize locking and move to higher level. (Evan)
* Code cleanups. Fix typos. (Evan, Matthias)
* Add the source node to the path. (Evan)
* Rename path_allocate() to path_init() with minor refactoring. (Evan)
* Rename *_remove() functions to *_destroy().
* Return fixed errors in icc_link_destroy(). (Evan)
* Fix krealloc() usage in icc_link_destroy(). (Evan)
* Add missing kfree() in icc_node_create(). (Matthias)
* Make icc_node_add() return void. (Matthias)
* Change mutex_init to mutex_lock in icc_provider_add(). (Matthias)
* Add new icc_node_del() function to delete nodes from provider.
* Fix the header guard to reflect the path in smd-rpm.h. (Evan)
* Check for errors returned by qcom_icc_rpm_smd_send(). (Evan)
* Propagate the error of icc_provider_del(). (Evan)

Changes since patchset v4 (https://lkml.org/lkml/2018/3/9/856)
* Simplified locking by using a single global mutex. (Evan)
* Changed the aggregation function interface.
* Implemented functions for node, link, provider removal. (Evan)
* Naming changes on variables and functions, removed redundant code. (Evan)
* Fixes and clarifications in the docs. (Matthias, Evan, Amit, Alexandre)
* Removed mandatory reg DT property, made interconnect-names optional. (Bjorn)
* Made interconnect-cells property required to align with other bindings. (Neil)
* Moved msm8916 specific bindings into a separate file and patch. (Bjorn)
* Use the names, instead of the hardcoded ids for topology. (Matthias)
* Init the node before creating the links. (Evan)
* Added icc_units_to_bps macro. (Amit)

Changes since patchset v3 (https://lkml.org/lkml/2017/9/8/544)
* Refactored the constraints aggregation.
* Use the IDR API.
* Split the provider and consumer bindings into separate patches and propose
  new bindings for consumers, which allows to specify the local source port.
* Adopted the icc_ prefix for API functions.
* Introduced separate API functions for creating interconnect nodes and links.
* Added DT lookup support in addition to platform data.
* Dropped the event tracing patch for now.
* Added a patch to provide summary via debugfs.
* Use macro for the list of topology definitions in the platform driver.
* Various minor changes.

Changes since patchset v2 (https://lkml.org/lkml/2017/7/20/825)
* Split the aggregation into per node and per provider. Cache the
  aggregated values.
* Various small refactorings and cleanups in the framework.
* Added a patch introducing basic tracepoint support for monitoring
  the time required to update the interconnect nodes.

Changes since patchset v1 (https://lkml.org/lkml/2017/6/27/890)
* Updates in the documentation.
* Changes in request aggregation, locking.
* Dropped the aggregate() callback and use the default as it currently
  sufficient for the single vendor driver. Will add it later when needed.
* Dropped the dt-bindings draft patch for now.

Changes since RFC v2 (https://lkml.org/lkml/2017/6/12/316)
* Converted documentation to rst format.
* Fixed an incorrect call to mutex_lock. Renamed max_bw to peak_bw.

Changes since RFC v1 (https://lkml.org/lkml/2017/5/15/605)
* Refactored code into shorter functions.
* Added a new aggregate() API function.
* Rearranged some structs to reduce padding bytes.

Changes since RFC v0 (https://lkml.org/lkml/2017/3/1/599)
* Removed DT support and added optional Patch 3 with new bindings proposal.
* Converted the topology into internal driver data.
* Made the framework modular.
* interconnect_get() now takes (src and dst ports as arguments).
* Removed public declarations of some structs.
* Now passing prev/next nodes to the vendor driver.
* Properly remove requests on _put().
* Added refcounting.
* Updated documentation.
* Changed struct interconnect_path to use array instead of linked list.

Georgi Djakov (8):
  interconnect: Add generic on-chip interconnect API
  dt-bindings: Introduce interconnect provider bindings
  interconnect: Add debugfs support
  interconnect: qcom: Add RPM communication
  dt-bindings: interconnect: Document qcom,msm8916 NoC bindings
  interconnect: qcom: Add msm8916 interconnect provider driver
  dt-bindings: Introduce interconnect consumers bindings
  interconnect: Allow endpoints translation via DT

 .../bindings/interconnect/interconnect.txt    |  60 ++
 .../bindings/interconnect/qcom-msm8916.txt    |  39 +
 .../bindings/interconnect/qcom-smd.txt        |  32 +
 Documentation/interconnect/interconnect.rst   |  96 +++
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/interconnect/Kconfig                  |  15 +
 drivers/interconnect/Makefile                 |   3 +
 drivers/interconnect/core.c                   | 737 ++++++++++++++++++
 drivers/interconnect/qcom/Kconfig             |  21 +
 drivers/interconnect/qcom/Makefile            |   4 +
 drivers/interconnect/qcom/msm8916.c           | 499 ++++++++++++
 drivers/interconnect/qcom/smd-rpm.c           |  91 +++
 drivers/interconnect/qcom/smd-rpm.h           |  15 +
 include/dt-bindings/interconnect/qcom.h       | 350 +++++++++
 include/linux/interconnect-provider.h         | 130 +++
 include/linux/interconnect.h                  |  49 ++
 17 files changed, 2144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-smd.txt
 create mode 100644 Documentation/interconnect/interconnect.rst
 create mode 100644 drivers/interconnect/Kconfig
 create mode 100644 drivers/interconnect/Makefile
 create mode 100644 drivers/interconnect/core.c
 create mode 100644 drivers/interconnect/qcom/Kconfig
 create mode 100644 drivers/interconnect/qcom/Makefile
 create mode 100644 drivers/interconnect/qcom/msm8916.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.h
 create mode 100644 include/dt-bindings/interconnect/qcom.h
 create mode 100644 include/linux/interconnect-provider.h
 create mode 100644 include/linux/interconnect.h

