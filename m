Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4994C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BA92146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfBYNjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:39:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:56797 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfBYNjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:39:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 05:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,411,1544515200"; 
   d="scan'208";a="149773251"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2019 05:39:51 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [Intel-gfx] BUG: KASAN: use-after-free in intel_hdmi_destroy+0x79/0x80
In-Reply-To: <dc22722f-a55c-6160-6485-a02f3bb91836@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <dc22722f-a55c-6160-6485-a02f3bb91836@infradead.org>
Date:   Mon, 25 Feb 2019 15:41:55 +0200
Message-ID: <87y364q924.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019, Randy Dunlap <rdunlap@infradead.org> wrote:
> This is 5.0-rc7 on an old Toshiba Portege laptop.
> No hdmi or other external video.
>
> Linux dragon.dunlab 5.0.0-rc7mod #3 SMP PREEMPT Wed Feb 20 00:05:17 PST 2019 x86_64 x86_64 x86_64 GNU/Linux
>
> on openSUSE LEAP 15.0 distro.
>
> Full boot log is attached.

On a hunch, caused by 9c229127aee2 ("drm/i915: hdmi: add CEC notifier to
intel_hdmi") referencing the encoder in connector destroy hook. We
should probably move the cec_notifier_put() call in the encoder destroy
hook.

BR,
Jani.




-- 
Jani Nikula, Intel Open Source Graphics Center
