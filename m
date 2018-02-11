Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeBKK46 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:56:58 -0500
Received: from shell.v3.sk ([92.60.52.57]:35513 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752812AbeBKK45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:56:57 -0500
Message-ID: <1518346607.8520.1.camel@v3.sk>
Subject: Re: [PATCH] drm/edid: drop the dcc probe before drm_do_get_edid
From: Lubomir Rintel <lkundrak@v3.sk>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sean Paul <seanpaul@chromium.org>, Jani Nikula <jani.nikula@intel.com>
Date: Sun, 11 Feb 2018 11:56:47 +0100
In-Reply-To: <20180210180355.2284-1-lkundrak@v3.sk>
References: <20180210180355.2284-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-02-10 at 19:03 +0100, Lubomir Rintel wrote:
> Now that drm_do_get_edid() handles override and firmware EDIDs it makes
> no sense to conditionalize it with a DCC probe. On the contrary -- the
> overrides are useful specifically when DCC is not functioning.
> 
> drm_do_get_edid() already bails out when DCC fails, there's no need for
> an extra check. It seems entirely safe to just drop this.
> 
> Working around the issue by forcing the connector on is not a good
> solution because that way the desktop shell can't tell when a monitor is
> plugged in or removed.
> 
> Cc: Jani Nikula <jani.nikula@intel.com>
> Fixes: 53fd40a ("drm: handle override and firmware EDID at drm_do_get_edid() level")

Please disregard this, should have given it more thought. Sorry.

It removes a symbol other modules use, and typoes DDC/DCC in the commit
message. Moreover it doesn't actually seem to solve my problem -- will
try to follow up with a better fix.

Lubo
