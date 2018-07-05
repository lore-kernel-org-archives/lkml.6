Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D10EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3770121A83
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3770121A83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeGEI7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:59:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:61946 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753357AbeGEI7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:59:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 01:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,311,1526367600"; 
   d="scan'208";a="69805136"
Received: from jnikula-mobl2.fi.intel.com (HELO localhost) ([10.237.72.62])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2018 01:59:12 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Chris Chiu <chiu@endlessm.com>, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>
Cc:     intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [BUG] i915 HDMI connector status is connected after disconnection
In-Reply-To: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com>
Date:   Thu, 05 Jul 2018 11:58:57 +0300
Message-ID: <87efgioy7i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul 2018, Chris Chiu <chiu@endlessm.com> wrote:
> Hi,
>     We have few ASUS laptops X705FD (The new WiskyLake), X560UD (intel
> i5-8250U), X530UN (intel i7-8550U) share the same problem, which is
> the HDMI connector status stays connected even the HDMI cable has been
> unplugged. Look into the "/sys/class/drm/card0-HDMI-A-1/status" for
> checking the status while plug/unplug the HDMI, it shows
> "disconnected" before plug in HDMI cable, then switch to "connected"
> after plugin, and still stay "connected" after unplug. This would
> cause the audio output path cannot correctly switch from HDMI to
> internal speaker after unplugging the HDMI.
>
> I then try to verify with the latest kernel 4.18.0-rc3+, the bug still
> present. The full "dmesg" log is here.
> https://gist.github.com/mschiu77/d761d7c5cf191b7868d4d7788ae087f1
>
> The HDMI cable is plugged in at ~26th second.
> "[ 26.214371] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
> audio support"
> then unplug the HDMI at ~73th second.
> "[ 73.328361] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
> audio support"
>
> Please advise what I can do to fix this. Thanks

Seems rather odd. Please file a bug report at [1]. Attach the dmesg on
the bug. Please attach 'xrandr --verbose' output before and after
unplugging on the bug.

Please also try drm-tip branch of [2].

BR,
Jani.


[1] https://bugs.freedesktop.org/enter_bug.cgi?product=DRI&component=DRM/Intel
[2] https://cgit.freedesktop.org/drm/drm-tip


-- 
Jani Nikula, Intel Open Source Graphics Center
