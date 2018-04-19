Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbeDSOjx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:39:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:42317 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753628AbeDSOjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:39:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,469,1517904000";
   d="scan'208";a="33159508"
Subject: Re: [i915] WARNING: CPU: 2 PID: 183 at
 drivers/gpu/drm/i915/intel_display.c:14584 intel_modeset_init+0x3be/0x1060
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Ben Widawsky <ben@bwidawsk.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lkp@01.org
References: <20180419025256.vtt37aljreb2wzrj@wfg-t540p.sh.intel.com>
 <0427eb0b-0382-db2c-72c5-0cbc867d4370@linux.intel.com>
 <20180419110505.wy47nheshalanxek@wfg-t540p.sh.intel.com>
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <e7cee8ae-f3b4-f342-f381-8ed48809148e@linux.intel.com>
Date: Thu, 19 Apr 2018 16:39:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419110505.wy47nheshalanxek@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 19-04-18 om 13:05 schreef Fengguang Wu:
> Hi Maarten,
>
>> What extra dmesg output do you get when you boot with drm.debug=0x1f ?
>
> Attached is the dmesg with drm.debug=0x1f.
>
> Thanks,
> Fengguang

Ah so we're inheriting the FB 2x, once with 1280x1024, other with 1366x768:

kern  :debug : [   74.880444] [drm:i9xx_get_initial_plane_config [i915]] pipe A/primary A with fb: size=1366x768@32, offset=61000, pitch 5504, size 0x408000
kern  :debug : [   74.881187] [drm:i915_gem_object_create_stolen_for_preallocated [i915]] creating preallocated stolen object: stolen_offset=0x0000000000061000, gtt_offset=0x0000000000061000, size=0x0000000000408000
kern  :debug : [   74.882197] [drm:intel_alloc_initial_plane_obj.isra.126 [i915]] initial plane fb obj 000000005efa24f9

kern  :debug : [   74.883532] [drm:i9xx_get_initial_plane_config [i915]] pipe B/primary B with fb: size=1280x1024@32, offset=61000, pitch 5504, size 0x560000
kern  :debug : [   74.884260] [drm:i915_gem_object_create_stolen_for_preallocated [i915]] creating preallocated stolen object: stolen_offset=0x0000000000061000, gtt_offset=0x0000000000061000, size=0x0000000000560000
kern  :debug : [   74.885295] [drm:i915_gem_object_create_stolen_for_preallocated [i915]] failed to allocate stolen space

Which of course fails, but should be an interesting case to handle right. :)

~Maarten
