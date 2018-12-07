Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B69C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF86C2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF86C2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbeLGRBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:01:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:19759 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeLGRBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:01:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 09:01:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,326,1539673200"; 
   d="scan'208";a="123923789"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 07 Dec 2018 09:01:09 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 07 Dec 2018 19:01:08 +0200
Date:   Fri, 7 Dec 2018 19:01:08 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH 4.19 044/110] drm/i915: Disable LP3 watermarks on all SNB
 machines
Message-ID: <20181207170108.GX9144@intel.com>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135923.048859299@linuxfoundation.org>
 <20181205213905.GW9144@intel.com>
 <20181206072807.GA21314@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181206072807.GA21314@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 08:28:07AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 05, 2018 at 11:39:05PM +0200, Ville Syrjälä wrote:
> > On Thu, Nov 29, 2018 at 03:12:15PM +0100, Greg Kroah-Hartman wrote:
> > > 4.19-stable review patch.  If anyone has any objections, please let me know.
> > 
> > This one apparently introduces some annoying dmesg errors:
> > [    3.487895] [drm:intel_print_wm_latency [i915]] *ERROR* Primary WM3 latency not provided
> > [    3.487926] [drm:intel_print_wm_latency [i915]] *ERROR* Sprite WM3 latency not provided
> > [    3.487955] [drm:intel_print_wm_latency [i915]] *ERROR* Cursor WM3 latency not provided
> > 
> > To silence those please also backport
> > commit 274dba1ae8ff ("drm/i915: Downgrade Gen9 Plane WM latency error")
> 
> That commit id is not in Linus's tree, are you sure it is correct?

Sorry. Picked the wrong sha by accident.

86c1c87d0e62 ("drm/i915: Downgrade Gen9 Plane WM latency error")

-- 
Ville Syrjälä
Intel
