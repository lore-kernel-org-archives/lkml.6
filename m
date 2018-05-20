Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeETRXS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 13:23:18 -0400
Received: from kozue.soulik.info ([108.61.200.231]:37400 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbeETRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 13:23:14 -0400
From: Randy Li <ayaka@soulik.info>
To: dri-devel@lists.freedesktop.org
Cc: Randy Li <ayaka@soulik.info>, hjc@rock-chips.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.dufresne@collabora.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie
Subject: [PATCH 0/2] Add support for a YUV 10bits pixel format
Date: Mon, 21 May 2018 01:17:03 +0800
Message-Id: <20180520171705.29690-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pixel format is current used in the rockchip platform. I think any model
higher than rk322x would support this pixel format. Xilinx may support
it but I am not sure.

More than a year ago, I post the patch Add pixel formats for 10/16 bits
YUV video to the mail list, it has been update to version 8, but they
are not merged yet. So I decide to submit these independent patches,
I hope that they would be reviewed and merged in a short time.

I have added a patch to Gstreamer and it is merged now.
Any future information can be found on the bugzilla of the Gstreamer:
https://bugzilla.gnome.org/show_bug.cgi?id=795462

I have verified this patch on the rk3288, with the following command:
gst-launch-1.0  filesrc location=conv_3840_2160.nv12_10le40 ! \
 rawvideoparse format=81 width=3840 height=2160 ! imagefreeze ! kmssink

Also you can find video sample video on above page, but you may need to
set the plane offset and stride when you are using the other files.

Randy Li (2):
  drm/fourcc: add a 10bits fully packed variant of NV12
  drm/rockchip: Support 10 bits yuv format in vop

 drivers/gpu/drm/drm_fourcc.c                |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 27 +++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  2 ++
 include/uapi/drm/drm_fourcc.h               |  3 +++
 5 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.14.3
