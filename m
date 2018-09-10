Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87300C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394E120866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394E120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeIJRVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:21:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:54897 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbeIJRVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:21:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 05:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,355,1531810800"; 
   d="scan'208";a="71759025"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga007.jf.intel.com with SMTP; 10 Sep 2018 05:26:49 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 10 Sep 2018 15:26:49 +0300
Date:   Mon, 10 Sep 2018 15:26:49 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Ayan Kumar Halder <ayan.halder@arm.com>, liviu.dudau@arm.com,
        brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH v2 0/4] Add support for Arm Framebuffer Compression(AFBC)
Message-ID: <20180910122649.GO5565@intel.com>
References: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
 <0e22e63c-6981-9e5d-ed2d-2ad1dfbccd4f@baylibre.com>
 <20180909120357.GA19774@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180909120357.GA19774@phenom.ffwll.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 02:03:57PM +0200, Daniel Vetter wrote:
> On Sat, Sep 08, 2018 at 03:58:53PM +0200, Neil Armstrong wrote:
> > Hi Ayan,
> > 
> > On 10/07/2018 15:18, Ayan Kumar Halder wrote:
> > > In the current series of patches, we are trying to add support for AFBC
> > > modifiers in malidp. AFBC modifiers adds some constraints to framebuffer
> > > size, alignment, pitch, formats, etc. Here we are trying to add support
> > > for one combination of AFBC modifier ie AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 |
> > > AFBC_FORMAT_MOD_SPARSE | AFBC_FORMAT_MOD_YTR.
> > > In future, we intend to add support for more combination of AFBC modifiers.
> > > Currently, we are trying to enable a basic support of AFBC in malidp.
> > 
> > Thanks for pushing AFBC support, this will help supporting it on other SoCs implementing support
> > like Amlogic, Rockchip or Samsung.
> > 
> > I have one question, is there a way to generate such AFBC buffers without the Mali GPU ?
> > I mean, is there a way to generate some sample buffers with some of the modifier features
> > to validate it without having the complete Mali GPU -> DRM chain ?
> 
> An igt would be perfect. We've done that for i915 compressed buffers. Note
> that it just needs to be an afbc buffer, not actually compressed. Setting
> all the bits to indicate "uncompressed" for each block is what we did for
> the i915 test.

Actually no. The i915 test does try to put some compressed data into the
buffer.

I have also a pending patch series [1] that allows us to render to
compressed buffers with cairo by compressing the results using the
GPU.

[1] https://patchwork.freedesktop.org/series/46876/

-- 
Ville Syrjälä
Intel
