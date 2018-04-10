Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeDJHTo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:19:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:10955 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752415AbeDJHTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:19:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,431,1517904000";
   d="scan'208";a="42112010"
Date: Tue, 10 Apr 2018 10:19:35 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] firmware: dmi_scan: Fix UUID length safety check
Message-ID: <20180410071935.GW2173@lahna.fi.intel.com>
References: <20180409145143.4daa1706@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409145143.4daa1706@endymion>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 02:51:43PM +0200, Jean Delvare wrote:
> The test which ensures that the DMI type 1 structure is long enough
> to hold the UUID is off by one. It would fail if the structure is
> exactly 24 bytes long, while that's sufficient to hold the UUID.
> 
> I don't expect this bug to cause problem in practice because all
> implementations I have seen had length 8, 25 or 27 bytes, in line
> with the SMBIOS specifications. But let's fix it still.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: a814c3597a6b ("firmware: dmi_scan: Check DMI structure length")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
