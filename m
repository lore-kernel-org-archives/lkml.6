Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82420C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5225420C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfBTKEh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:04:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:26931 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfBTKEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:04:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 02:04:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,390,1544515200"; 
   d="scan'208";a="123835466"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.252.28.152])
  by fmsmga007.fm.intel.com with ESMTP; 20 Feb 2019 02:04:33 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg KH <gregkh@linuxfoundation.org>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20190219071619.GA11016@phenom.ffwll.local>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dim-tools@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20190219071619.GA11016@phenom.ffwll.local>
Message-ID: <155065707289.4668.13605429156792074869@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.7
Subject: Re: [PULL] topic/mei-hdcp
Date:   Wed, 20 Feb 2019 12:04:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Vetter (2019-02-19 09:55:27)
> Hi all,
> 
> topic/mei-hdcp-2019-02-19:
> Prep patches + headers for the mei-hdcp/i915 component interfaces
> 
> Also contains the prep work in the component helpers plus adjustements
> for the snd-hda/i915 component interface.
> 
> Plus one small static inline in the drm_hdcp.h header that both i915
> and mei_hdcp will need.
> 
> Joonas, please pull into drm-intel-next-queued so I can apply the i915
> hdcp patches.

This is now pulled.

Regards, Joonas

> 
> Greg/Arnd, I think there's two options to get the mei-hdcp patches landed
> into drivers-misc:
> - You pull this topic pull and then apply the mei-hdcp patches on top in
>   char-misc-next.
> - I also pull in char-misc-next to get at 32ea33a04484 ("mei: bus: export
>   to_mei_cl_device for mei client devices drivers") and then apply all the
>   mei-hdcp stuff into a new topic branch.
> 
> I think 2nd option would be better, allows us to integration test easier,
> and we'll have a topic branch in case we need a fixup spanning mei-hdcp
> and i915. Also would allow me to start merging the patches, since I think
> it's too late for 5.1.
> 
> Cheers, Daniel
> 
> The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:
> 
>   Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)
> 
> are available in the Git repository at:
> 
>   git://anongit.freedesktop.org/drm/drm-intel tags/topic/mei-hdcp-2019-02-19
> 
> for you to fetch changes up to 35c0272502cca0a1b461d310c23aac94a503983d:
> 
>   drm/audio: declaration of struct device (2019-02-18 20:19:28 +0100)
> 
> ----------------------------------------------------------------
> Prep patches + headers for the mei-hdcp/i915 component interfaces
> 
> Also contains the prep work in the component helpers plus adjustements
> for the snd-hda/i915 component interface.
> 
> Plus one small static inline in the drm_hdcp.h header that both i915
> and mei_hdcp will need.
> 
> ----------------------------------------------------------------
> Daniel Vetter (3):
>       component: Add documentation
>       components: multiple components for a device
>       i915/snd_hdac: I915 subcomponent for the snd_hdac
> 
> Ramalingam C (5):
>       drm/i915: enum port definition is moved into i915_drm.h
>       drm/i915: header for i915 - MEI_HDCP interface
>       drm/i915: MEI interface definition
>       drm: helper functions for hdcp2 seq_num to from u32
>       drm/audio: declaration of struct device
> 
>  Documentation/driver-api/component.rst   |  17 +++
>  Documentation/driver-api/device_link.rst |   3 +
>  Documentation/driver-api/index.rst       |   1 +
>  drivers/base/component.c                 | 206 +++++++++++++++++++++++++++++--
>  drivers/gpu/drm/i915/intel_audio.c       |   4 +-
>  drivers/gpu/drm/i915/intel_display.h     |  16 +--
>  include/drm/drm_audio_component.h        |   1 +
>  include/drm/drm_hdcp.h                   |  18 +++
>  include/drm/i915_component.h             |   5 +
>  include/drm/i915_drm.h                   |  15 +++
>  include/drm/i915_mei_hdcp_interface.h    | 149 ++++++++++++++++++++++
>  include/linux/component.h                |  76 ++++++++++++
>  include/sound/hda_component.h            |   5 +-
>  sound/hda/hdac_component.c               |   4 +-
>  sound/hda/hdac_i915.c                    |   6 +-
>  15 files changed, 493 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/driver-api/component.rst
>  create mode 100644 include/drm/i915_mei_hdcp_interface.h
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
