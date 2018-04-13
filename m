Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754028AbeDMJlB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:41:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751380AbeDMJk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:40:59 -0400
From: Thomas Huth <thuth@redhat.com>
To: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Farhan Ali <alifm@linux.ibm.com>, borntraeger@de.ibm.com
Subject: [PATCH 0/2] drm: Make it compilable without CONFIG_HDMI and CONFIG_I2C
Date: Fri, 13 Apr 2018 11:40:54 +0200
Message-Id: <1523612456-14827-1-git-send-email-thuth@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By enabling the DRM code for virtio-gpu on S390, you currently also get
all the code that is enabled by CONFIG_HDMI and CONFIG_I2C automatically.
This is quite ugly, since on S390, there is no HDMI and no I2C. Thus it
would be great if the DRM code could also be compiled without CONFIG_HDMI
and CONFIG_I2C. These two patches now refactor the DRM code a little bit
so that we can compile it also without CONFIG_HDMI and CONFIG_I2C.

Thomas Huth (2):
  drivers/gpu/drm: Move CONFIG_HDMI-dependent code to a separate file
  drivers/gpu/drm: Make the DRM code compilable without CONFIG_I2C

 drivers/gpu/drm/Kconfig             |   6 +-
 drivers/gpu/drm/Makefile            |  17 ++--
 drivers/gpu/drm/drm_crtc_internal.h |   2 +
 drivers/gpu/drm/drm_edid.c          | 173 ++--------------------------------
 drivers/gpu/drm/drm_hdmi.c          | 182 ++++++++++++++++++++++++++++++++++++
 5 files changed, 206 insertions(+), 174 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_hdmi.c

-- 
1.8.3.1
