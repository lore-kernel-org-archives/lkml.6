Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A19C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2042A2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeLNWLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:11:46 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:41047 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730909AbeLNWLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:11:45 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MC2k1-1gi49T0OBZ-00CULw; Fri, 14 Dec 2018 23:10:30 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andrew Jeffery <andrew@aj.id.au>,
        Andy Gross <andy.gross@linaro.org>, bp@alien8.de,
        Daniel Drake <dsd@laptop.org>,
        David Brown <david.brown@linaro.org>, dou_liyang@163.com,
        Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Rutland <mark.rutland@arm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-scsi@vger.kernel.org
Subject: [PATCH 0/7] v4.19-stable randconfig fixes
Date:   Fri, 14 Dec 2018 23:10:05 +0100
Message-Id: <20181214221023.3878670-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BKx/+9tKlDqKBm3yFlKyDrtyhjifcH89zpw/TA+BR1GI/IXjxE6
 KW3z0cr3XpETC3xoJ++EI0JW/9H2NRFMq8Y3aElZvA6zHQ1dimmqunWZOdZRf2FdvenY89X
 epnrSbbPZtbAO/NqN+srg4Ed+NnCDdUj8NUJ692QEDM4t+lEjW01nHd+x+771FBFOo8eXhB
 cw3vt1ukEotp9faZny6Hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j6sqQ1IHvig=:EGZaD64AG1QjIGAMVS1LWp
 pau5ae+Vpo+7rA/nWWbNjif5wSfffObDxmXd3m+uc/7Iv5UwrFwWWGmuP35+XDbX8YmdnYgaY
 TjDhPsrEMImNJR2yV8d2+3cZmLxKWxbDTYWUOLr2bKA6+4hTvabv1L86tX7q6hEJ0wd7I3zVO
 Euz76m5vVG32KDE8UTouhvFvkeH+/vX5iKFo0nmyro1yAqISLmI68x/sIbOZbEvqmxQ1i8kkj
 zyGst2GNmuaOZDha4i8twtncCtW2cOG8hRA7lzAdmEOJPPXRgsfEQsrqrXovV1jlEYB0yLZ6S
 4g+JmdCb5ew9aGzQvBSrZKKF5OM5bvKJ2wQhlKBiOGG7r2gqOVbk3DGS0/+yJvZfjCv9M4LUF
 R5oLaLMVhcxs+aJFGl/tNbBYtrUWn6PDKKj2hVHXLgyCL/MrwwfYkAE/j4tVOc0IBR4Pal2II
 TDYnAh0JYkDF+FXKLoHyyq8jdLKEAfRMLIkTG5cv4q6mzL3Yal+/0JZ3y6pntEkQXz1bSdq+d
 VoLvpxGaKD8+eXDQGofVFhKDaiBXez7Cfs6ceRl3gpNiPcFxFAA8fsF4aR4EFk4vizcnWfIDj
 mhc2mM3u1mC3IMfTix2u15NvAKPCzQT/L59X5OlowOj5d2e3bkAb1nTpKqsQvLlrOZEFSTgSi
 dcVTn7TmQGepKRmxqZ5T+imZ4v8dVSYj2l4W9nPVxpvlCFijFCd0ozlMMMTb8JoXvTxkYj3eh
 UHVV6a2gutBOsCvCWSamPsygsW9LG0rDueiMDQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I did some randconfig testing on linux-4.19 arm/arm64/x86. So far I needed
27 patches, most of which are also still needed in mainline Linux. I
had submitted some before, and others were not submitted previously
for some reason. I'll try to get those fixed in mainline and then
make sure we get them into 4.19 as well.

This series for now contains four patches that did make it into mainline:

2e6ae11dd0d1 ("slimbus: ngd: mark PM functions as __maybe_unused")
33f49571d750 ("staging: olpc_dcon: add a missing dependency")
0eeec01488da ("scsi: raid_attrs: fix unused variable warning")
11d4afd4ff66 ("sched/pelt: Fix warning and clean up IRQ PELT config")

Feel free to either cherry-pick those from mainline or apply the
patch from this series, whichever works best for you.

The other three patches are for warnings in code that got removed in
mainline kernels:

3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events properly")
972910948fb6 ("ARM: dts: qcom: Remove Arrow SD600 eval board")
effec874792f ("drm/msm/dpu: Remove dpu_dbg")

My feeling was that it's safer to just address the warning by fixing
the code correctly in each of these cases, but if you disagree,
applying the mainline change should work equally well, so decide
for yourself.

      Arnd

Arnd Bergmann (5):
  scsi: raid_attrs: fix unused variable warning
  slimbus: ngd: mark PM functions as __maybe_unused
  [stable-4.19] i2c: aspeed: fix build warning
  [stable-4.19] ARM: dts: qcom-apq8064-arrow-sd-600eval fix
    graph_endpoint warning
  [stable-4.19] drm/msm:  fix address space warning

Lubomir Rintel (1):
  staging: olpc_dcon: add a missing dependency

Vincent Guittot (1):
  sched/pelt: Fix warning and clean up IRQ PELT config

 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts | 5 +++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c             | 8 ++++----
 drivers/i2c/busses/i2c-aspeed.c                     | 4 +++-
 drivers/scsi/raid_class.c                           | 4 +---
 drivers/slimbus/qcom-ngd-ctrl.c                     | 6 ++----
 drivers/staging/olpc_dcon/Kconfig                   | 1 +
 init/Kconfig                                        | 5 +++++
 kernel/sched/core.c                                 | 7 +++----
 kernel/sched/fair.c                                 | 2 +-
 kernel/sched/pelt.c                                 | 2 +-
 kernel/sched/pelt.h                                 | 2 +-
 kernel/sched/sched.h                                | 5 ++---
 12 files changed, 29 insertions(+), 22 deletions(-)

Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: bp@alien8.de
Cc: Daniel Drake <dsd@laptop.org>
Cc: David Brown <david.brown@linaro.org>
Cc: dou_liyang@163.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: Jens Frederich <jfrederich@gmail.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-i2c@vger.kernel.org
Cc: openbmc@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-aspeed@lists.ozlabs.org
Cc: linux-scsi@vger.kernel.org


-- 
2.20.0

