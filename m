Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeDYHyE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:54:04 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40353 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751069AbeDYHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:54:02 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH v2 0/2] drm/bridge: sii902x: add optional power supplies
Date: Wed, 25 Apr 2018 09:53:12 +0200
Message-ID: <20180425075314.19137-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.5.66]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds optional power supplies to the sii902x
drm bridge driver.

Version 2:
- merge avcc12 & cvcc12 to a single vcc12 supply as suggested by
  Laurent Pinchart (see discussion details in
  https://patchwork.freedesktop.org/patch/216058/)
- improve error messages following Laurent Pinchart comments.
- note about power consumption: as sii902x input IOs are not "io safe",
  it is important to enable/disable voltage regulators during
  probe/remove phases to avoid damages. Then, the only way to improve
  the power consumption is to add the sii902x standy mode. My actual
  platform is not an handheld device so power consumption is not
  critical. But in the future, it could be nice to add the standby
  mode, paying attention to wake-up events (hdmi cable plug)...

Version 1:
- Initial commit

Philippe Cornu (2):
  dt-bindings/display/bridge: sii902x: add optional power supplies
  drm/bridge: sii902x: add optional power supplies

 .../devicetree/bindings/display/bridge/sii902x.txt |  2 ++
 drivers/gpu/drm/bridge/sii902x.c                   | 38 +++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.15.1
