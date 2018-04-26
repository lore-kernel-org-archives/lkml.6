Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755922AbeDZLwI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:52:08 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:48543 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755063AbeDZLwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:52:02 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180426115200epoutp0232f9f1dbe5de53ad99ffeb2531f51ad2~o_ic2y_jK1528215282epoutp02l
X-AuditID: b6c32a46-145ff70000001024-96-5ae1bd5faa3f
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 00/18] thermal: exynos: further fixes and cleanups
Date: Thu, 26 Apr 2018 13:51:15 +0200
Message-id: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCmqW7C3odRBg0eFhtnrGe1mH/lGqvF
        5V1z2Cw+9x5htJhxfh+TxZOHfWwObB47Z91l91i85yWTR9+WVYwenzfJBbBEcdmkpOZklqUW
        6dslcGVcbbrGVPBdoOLBimNsDYw9fF2MnBwSAiYSmz9PYOti5OIQEtjBKHFpyWtmCOc7o8S2
        1f+ZYaqaFx5ngkhsYJSYe/0CC4Tzi1Hi9P/zrCBVbAJWEhPbVzGC2CICWhInLm0H62AWmMMo
        MathNwtIQljASeLtzytsIDaLgKrEgte3wZp5BTwkJn/byASxTk7i5LHJrBD2Q1aJSfN5IWwX
        iZuPvjFC2MISr45vYYewpSWerdrICLJMQqCZUeLbjj1Qd09glNizXgjCtpY4fPwi2FBmAT6J
        jsN/gZo5gOK8Eh1tQhCmh8SGPVwQ1Y4StzYuZwIJCwnESry8Fj2BUXIBI8MqRrHUguLc9NRi
        owIjveLE3OLSvHS95PzcTYzgKNNy28G45JzPIUYBDkYlHt6AhQ+ihFgTy4orcw8xSnAwK4nw
        xrc+jBLiTUmsrEotyo8vKs1JLT7EKM3BoiTO2+B7JkpIID2xJDU7NbUgtQgmy8TBKdXA2Ow2
        72KQeAjj5H3R99POBS7rXiwmcPr45vdPvu090Rn/TMiZk6fz5gaNGAehcPWqn4f3b58p8l1g
        zpHS/EnzMk6watV1u+1cvayu2cuUw69n04zXQdYZJZf2/2jqW3Z78vdvF9xli9n5lCMqTzQ/
        Xjfl59/eA06cvyboMU49lNYcksZml9YzS4mlOCPRUIu5qDgRAIRfAPquAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJMWRmVeSWpSXmKPExsVy+t9jQd34vQ+jDI4t4LHYOGM9q8X8K9dY
        LS7vmsNm8bn3CKPFjPP7mCyePOxjc2Dz2DnrLrvH4j0vmTz6tqxi9Pi8SS6AJYrLJiU1J7Ms
        tUjfLoEr42rTNaaC7wIVD1YcY2tg7OHrYuTkkBAwkWheeJwJxBYSWMco8esQexcjF5D9i1Gi
        Z8EcsASbgJXExPZVjCC2iICWxIlL25lAipgF5jBKPF8BUSQs4CTx9ucVNhCbRUBVYsHr26wg
        Nq+Ah8TkbxuZILbJSZw8Npl1AiPXAkaGVYySqQXFuem5xUYFRnmp5XrFibnFpXnpesn5uZsY
        gSGw7bBW/w7Gx0viDzEKcDAq8fAGLHwQJcSaWFZcmXuIUYKDWUmEN771YZQQb0piZVVqUX58
        UWlOavEhRmkOFiVxXv78Y5FCAumJJanZqakFqUUwWSYOTqkGxlM6Gt5zA/MFeAObbx3/0M50
        9+GVxg89ntzhawKtHkYWFsx2uJWZFbfGU/GBI5vG35ZDU/4ytl/3CogJCxfv/sy/wLy9mKX7
        wrOm+7E8L1dslAzfaXy1j0Xyyps9FVfZBct812Sn8/A7Ftw6WyWmJBeZ2WOm/epwy19ngZaE
        hqflKczBK2YqsRRnJBpqMRcVJwIAkKXTeP0BAAA=
X-CMS-MailID: 20180426115159epcas2p3b8d995ba552b403b5052f74970fdef0f
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180426115159epcas2p3b8d995ba552b403b5052f74970fdef0f
X-RootMTR: 20180426115159epcas2p3b8d995ba552b403b5052f74970fdef0f
References: <CGME20180426115159epcas2p3b8d995ba552b403b5052f74970fdef0f@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset contains Exynos thermal driver fixes and cleanups.

Highlights:
* Move code valid for all SoCs from ->tmu_initialize method
  to exynos_tmu_initialize().
* Add ->set_trip_[temp,hyst] methods and convert ->tmu_initialize
  method implementations to use them.
* Remove bogus trip reporting to user-space.

The patchset is based on top of:
- "[PATCH 00/14] thermal: exynos: pending fixes and cleanups"
  (https://lkml.org/lkml/2018/4/16/256))
- "[PATCH] thermal: samsung: Remove support for Exynos5440"
  (https://lkml.org/lkml/2018/4/26/405)

Tested on Exynos4210 based Trats board and Exynos5422 based Odroid-XU3
Lite board.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (18):
  thermal: exynos: fix setting rising_threshold for Exynos5433
  thermal: exynos: always check for trips points existence
  thermal: exynos: always check for critical trip points existence
  thermal: exynos: check STATUS register in exynos_tmu_initialize()
  thermal: exynos: use sanitize_temp_error() in exynos7_tmu_initialize()
  thermal: exynos: fix trips limit checking in get_th_reg()
  thermal: exynos: remove threshold_code checking from
    exynos4210_tmu_initialize()
  thermal: exynos: make ->tmu_initialize method void
  thermal: exynos: clear IRQs later in exynos4412_tmu_initialize()
  thermal: exynos: move IRQs clearing to exynos_tmu_initialize()
  thermal: exynos: add exynos*_tmu_set_[trip,hyst]() helpers
  thermal: exynos: do not use trips structure directly in
    ->tmu_initialize
  thermal: exynos: set trips in ascending order in
    exynos7_tmu_initialize()
  thermal: exynos: move trips setting to exynos_tmu_initialize()
  thermal: exynos: check return values of ->get_trip_[temp,hyst] methods
  thermal: exynos: cleanup code for enabling threshold interrupts
  thermal: exynos: remove unused defines for Exynos5433
  thermal: exynos: remove trip reporting to user-space

 drivers/thermal/samsung/exynos_tmu.c | 548 ++++++++++++++---------------------
 1 file changed, 215 insertions(+), 333 deletions(-)

-- 
1.9.1
