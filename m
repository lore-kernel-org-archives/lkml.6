Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeDMOc7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:32:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54580 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeDMOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:32:58 -0400
X-Google-Smtp-Source: AIpwx4+YmgnYhTwfVqVPgVjfrz5y1MUxZWLYIcqQXBwBi9Pbs6AU7/tbo2zJpdFN+0C2ygWEYyD0DFcHhc61COFuio0=
MIME-Version: 1.0
X-Originating-IP: [212.51.149.109]
In-Reply-To: <1523612456-14827-1-git-send-email-thuth@redhat.com>
References: <1523612456-14827-1-git-send-email-thuth@redhat.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 13 Apr 2018 16:32:56 +0200
X-Google-Sender-Auth: LZ8A2CJ40BKpxqjTVPlCBLL0pr4
Message-ID: <CAKMK7uEB6L0-EQOH04Ktk5gr61VW_ED4eA+cZzM6Op-_0ZVqfg@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm: Make it compilable without CONFIG_HDMI and CONFIG_I2C
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>, borntraeger@de.ibm.com,
        Farhan Ali <alifm@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 11:40 AM, Thomas Huth <thuth@redhat.com> wrote:
> By enabling the DRM code for virtio-gpu on S390, you currently also get
> all the code that is enabled by CONFIG_HDMI and CONFIG_I2C automatically.
> This is quite ugly, since on S390, there is no HDMI and no I2C. Thus it
> would be great if the DRM code could also be compiled without CONFIG_HDMI
> and CONFIG_I2C. These two patches now refactor the DRM code a little bit
> so that we can compile it also without CONFIG_HDMI and CONFIG_I2C.
>
> Thomas Huth (2):
>   drivers/gpu/drm: Move CONFIG_HDMI-dependent code to a separate file
>   drivers/gpu/drm: Make the DRM code compilable without CONFIG_I2C

What's the benefit? Why does I2C/HDMI hurt you?

Note that you still can't compile out DP code, and the DRM legacy
code, and that's much bigger ...
-Daniel

>
>  drivers/gpu/drm/Kconfig             |   6 +-
>  drivers/gpu/drm/Makefile            |  17 ++--
>  drivers/gpu/drm/drm_crtc_internal.h |   2 +
>  drivers/gpu/drm/drm_edid.c          | 173 ++--------------------------------
>  drivers/gpu/drm/drm_hdmi.c          | 182 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 206 insertions(+), 174 deletions(-)
>  create mode 100644 drivers/gpu/drm/drm_hdmi.c
>
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
