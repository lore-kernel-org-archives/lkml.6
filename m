Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB96C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B20C206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfAGNeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:34:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:1763 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfAGNep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:34:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 05:34:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="123957850"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 07 Jan 2019 05:34:41 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 07 Jan 2019 15:34:40 +0200
Date:   Mon, 7 Jan 2019 15:34:40 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Daniel Kamil Kozar <dkk089@gmail.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, azhar.shaikh@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: "flip_done timed out" messages causing huge increase in boot time
Message-ID: <20190107133440.GO20097@intel.com>
References: <CANMdSOztZu2bsG+g=T-pThiHK9cNaMVq=tvTJ6kn2Tvu4CXJCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANMdSOztZu2bsG+g=T-pThiHK9cNaMVq=tvTJ6kn2Tvu4CXJCQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 12:47:12AM +0100, Daniel Kamil Kozar wrote:
> Hello.
> After upgrading the kernel to 4.20, I noticed that the boot time
> increased from about 5 seconds to 25 seconds. My machine is an Asus
> K53SV with an Intel i7-2630QM, i.e. Sandy Bridge. I have an external
> display connected to it via HDMI. If the display is unplugged when
> booting the machine, the boot time stays at its old value.
> The kernel log shows two messages like this :
> 
> [   15.747206] [drm:drm_atomic_helper_wait_for_flip_done
> [drm_kms_helper]] *ERROR* [CRTC:39:pipe A] flip_done timed out
> [   26.198968] [drm:drm_atomic_helper_wait_for_dependencies
> [drm_kms_helper]] *ERROR* [CRTC:39:pipe A] flip_done timed out

Hrm. With SNB I would be tempted to blame the LP3 watermarks, but
4.20 already has commit 21556350ade3 ("drm/i915: Disable LP3 watermarks
on all SNB machines").

Can you file a bug at
https://bugs.freedesktop.org/enter_bug.cgi?product=DRI&component=DRM/Intel
and attach the full dmesg from the boot with drm.debug=0xe passed to the
kernel cmdline?

-- 
Ville Syrjälä
Intel
