Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933269AbeBLJkB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:40:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:29033 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753849AbeBLJj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:39:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,501,1511856000";
   d="scan'208";a="30061053"
From: Jani Nikula <jani.nikula@intel.com>
To: Lubomir Rintel <lkundrak@v3.sk>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH] drm/edid: drop the dcc probe before drm_do_get_edid
In-Reply-To: <1518346607.8520.1.camel@v3.sk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180210180355.2284-1-lkundrak@v3.sk> <1518346607.8520.1.camel@v3.sk>
Date: Mon, 12 Feb 2018 11:39:51 +0200
Message-ID: <87tvum7di0.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2018, Lubomir Rintel <lkundrak@v3.sk> wrote:
> On Sat, 2018-02-10 at 19:03 +0100, Lubomir Rintel wrote:
>> Now that drm_do_get_edid() handles override and firmware EDIDs it makes
>> no sense to conditionalize it with a DCC probe. On the contrary -- the
>> overrides are useful specifically when DCC is not functioning.
>> 
>> drm_do_get_edid() already bails out when DCC fails, there's no need for
>> an extra check. It seems entirely safe to just drop this.
>> 
>> Working around the issue by forcing the connector on is not a good
>> solution because that way the desktop shell can't tell when a monitor is
>> plugged in or removed.
>> 
>> Cc: Jani Nikula <jani.nikula@intel.com>
>> Fixes: 53fd40a ("drm: handle override and firmware EDID at drm_do_get_edid() level")
>
> Please disregard this, should have given it more thought. Sorry.
>
> It removes a symbol other modules use, and typoes DDC/DCC in the commit
> message. Moreover it doesn't actually seem to solve my problem -- will
> try to follow up with a better fix.

I think the ddc probe was originally added for a reason. What that
reason was, I have no idea. I suggest you go on a bit of git blame/log
history digging to find what it was before removing.

Anyway, as you can see from the code, you can still use connector
forcing to bypass the ddc check.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
