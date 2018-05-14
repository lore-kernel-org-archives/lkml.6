Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeENLnB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:43:01 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:59354 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeENLm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:42:59 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180514114257epoutp04eceb5d2302b1578a840c622a7b8a261f~ugBsEP8av0812508125epoutp04Y
X-AuditID: b6c32a38-70fff7000000105c-c7-5af976401af3
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 00/14] thermal: ti-soc-thermal: simplify the driver a bit
Date: Mon, 14 May 2018 13:42:07 +0200
Message-id: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCmrq5D2c8og3v71Sw2zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsEroyWjpssBf+EK+7+esXYwHhMoIuRk0NCwETiyfEdbF2MXBxCAjsY
        JXYe+Q7lfGeUmPDoOFMXIwdY1eF1HhDx3YwSF0/MZYdwfgF13L7LBjKKTcBKYmL7KkYQW0TA
        TWLWkj9gNrPAVEaJTRPqQWxhAU+JzS/PMIPYLAKqEn3zD4LZvAIeEjenH2SDOElO4uSxyawg
        CyQEvrJKLJq5kRki4SIxadYNJghbWOLV8S3sENdJS1w6agtR38wo8W3HHqj6CYwSe9YLQdjW
        EoePX2SFOIhP4t3XHlaIXl6JjjaoEg+J3Z8fskGEHSW+rPYECQsJxEo8vd/KMoFRcgEjwypG
        sdSC4tz01GLDAhO94sTc4tK8dL3k/NxNjODI07LYwbjnnM8hRgEORiUe3oDlP6KEWBPLiitz
        DzFKcDArifDuNvoZJcSbklhZlVqUH19UmpNafIhRmoNFSZx3jtLXKCGB9MSS1OzU1ILUIpgs
        EwenVAOjAI/SiUovhVs6PQ4FffMdmk8Vil1X2ug4RWHV3BWfHi6K1TKcuzxNPma5fO/jX34O
        T29XyvcryLO7nIkq1bb+1L74of8Cg7q5bsVvF2YdPaJ4eG6crvSe49r5rvtvZ2bevKXVnpZ8
        7Q3bvtToibPZTtqvm/Jyz0nD/todXq2tQqKzOG/O7vyoxFKckWioxVxUnAgA853BG7gCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCJMWRmVeSWpSXmKPExsVy+t9jAV37sp9RBrdum1hsnLGe1WL+lWus
        Fqe2NzFZXN41h81i9pJ+FovPvUcYLZ487GNzYPfYOesuu8fiPS+ZPPq2rGL0OH5jO5PH501y
        AaxRXDYpqTmZZalF+nYJXBktHTdZCv4JV9z99YqxgfGYQBcjB4eEgInE4XUeXYxcHEICOxkl
        rq2bzQjh/GKUePPuKFsXIycHm4CVxMT2VYwgtoiAm8SsJX/AipgFpjJKTP50CqxIWMBTYvPL
        M8wgNouAqkTf/INgNq+Ah8TN6QfBaiQE5CROHpvMOoGRawEjwypGydSC4tz03GKjAsO81HK9
        4sTc4tK8dL3k/NxNjMCw2HZYq28H4/0l8YcYBTgYlXh4V6z8ESXEmlhWXJl7iFGCg1lJhHe3
        0c8oId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ry3845FCgmkJ5akZqemFqQWwWSZODilGhjd1UL/
        OGcZzXEUWj7BzcQpSHFNyvKr1pvXvDG3m9d/V9yfi5VF+VmU9eRn11QXrmfZutSl60rYDCtm
        pQMi7/f0dBjfZf9i8W9CmvnUwpMfZYxO52za3eUk9MzmhfWNko23LianaDmu5F/B4Swkxqo2
        gdVv3nd+xcW8+T911hazRbq/VW7X/6/EUpyRaKjFXFScCAAu0OJjBwIAAA==
X-CMS-MailID: 20180514114255epcas1p438ea8d32c2b7fd40b86afb25c9c8f2cf
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180514114255epcas1p438ea8d32c2b7fd40b86afb25c9c8f2cf
X-RootMTR: 20180514114255epcas1p438ea8d32c2b7fd40b86afb25c9c8f2cf
References: <CGME20180514114255epcas1p438ea8d32c2b7fd40b86afb25c9c8f2cf@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset contains few fixups and cleanups for TI thermal driver
(this is the result of my attempt to understand the driver operation).

Highlights:
* Fix TALERT IRQ handling for DRA752 SoC.
* Reuse most of OMAP5 SoC code for DRA752 SoC.
* Reduce size of *_adc_to_temp[] conversion tables.
* Remove duplicated code.
* Remove SoC family config options.

The patchset is based on top of:
- "[PATCH v2] thermal: ti-soc-thermal: fix incorrect entry in
  omap5430_adc_to_temp[]" (https://lkml.org/lkml/2018/5/2/433)
- "[PATCH] thermal: ti-soc-thermal: remove dead code"
  (https://lkml.org/lkml/2018/5/2/367)

Please consider applying.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (14):
  thermal: ti-soc-thermal: fix TALERT IRQ handling for DRA752
  thermal: ti-soc-thermal: fix comment in omap5xxx-bandgap.h
  thermal: ti-soc-thermal: fix comments in omap4-thermal-data.c
  thermal: ti-soc-thermal: cleanup COUNTER feature handling for OMAP5
  thermal: ti-soc-thermal: remove redundant methods from struct
    ti_bandgap_data
  thermal: ti-soc-thermal: remove ->threshold_[thot,tcold]_mask fields
  thermal: ti-soc-thermal: remove ->tshut_[hot,cold]_mask fields
  thermal: ti-soc-thermal: use common struct temp_sensor_data for OMAP5
  thermal: ti-soc-thermal: use common struct temp_sensor_data for DRA752
  thermal: ti-soc-thermal: use OMAP5 defines for DRA752
  thermal: ti-soc-thermal: use OMAP5 register tables for DRA752
  thermal: ti-soc-thermal: add ->adc_to_mcelsius method
  thermal: ti-soc-thermal: use short int for *_adc_to_temp[] conversion
    tables
  thermal: ti-soc-thermal: remove SoC family config options

 drivers/thermal/ti-soc-thermal/Kconfig             |  63 +----
 drivers/thermal/ti-soc-thermal/Makefile            |   8 +-
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    | 109 +------
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   | 313 ++++-----------------
 .../thermal/ti-soc-thermal/omap3-thermal-data.c    |  70 +++--
 .../thermal/ti-soc-thermal/omap4-thermal-data.c    | 132 ++++-----
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h  |   8 -
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    | 171 ++++-------
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h  |  47 +---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  61 ++--
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  45 +--
 11 files changed, 265 insertions(+), 762 deletions(-)

-- 
1.9.1
