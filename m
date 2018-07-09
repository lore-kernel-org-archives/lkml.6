Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3756C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E67F2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="jhHejUV+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oMSfhc4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E67F2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbeGIHdP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:33:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36297 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932231AbeGIHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:33:12 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 21D7421873;
        Mon,  9 Jul 2018 03:33:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 09 Jul 2018 03:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=x6t5REStG+NhhQ06Q1H6M/aiENtFgIRmVjGK7s6nDy0=; b=jhHejUV+
        XnWce0G7CXrjiHDWO0baM+t8W+sdo14v+RXRoAS2xhnXRSipPWNydDW4txmwAT3H
        OwMYBJQPRgN0dDVOTWh92WhAoELsaeaYdOcyLYyvCOuVJG8GjubdeDbdCt5oRQB3
        yvbKi/vDgZ67B0Esg6cJlXccoTcl0ejFiQIyYBg/WOsawcVb+TlpmSqdAlruTvI6
        amSXukjDtNfP8zNGZUy/oMPgENUDa/ptuvPLWw+YNw1RTEUQFQofEgoJYBlE1O1i
        0qb8Q7TsZCWVxjJv7xXQ6x1iWJTP54Ox8XSJXh1oRpj3cQSuZl0P9Sc5aH8ue4ch
        7nnQkFhsqpCwkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=x6t5REStG+NhhQ06Q1H6M/aiENtFg
        IRmVjGK7s6nDy0=; b=oMSfhc4oCRHFIR1ed1lu1kpxxvjFJvN3QBBYGLh+gjb92
        8k2cL3ZvPPdzB/vi0itoPuO347tpQu/hKSWLVYVdyMXhZ/4qiU/j+2ALYWWXN0uS
        as+uEW/66IBRMPj5Bj6tIxgX8xRq/6sEkBiujsKwT0qAkpV34IBQHdC5j94m6UgY
        MROetn5XgIii0hJ3OVXFiUwmNdilX5PtqH2HXwy9G5uQE7TsKJm/OQpn/BZVCfex
        KOWwKwQ1MdSslfpHEeZ4H7n5MbmGJleoTS3N6ua100lAFqE23G4nSoldjJ8+kE+N
        FNiL6VUCaSz57lyutSfsFXgVd+y4TkT6yvK6hsBRQ==
X-ME-Proxy: <xmx:tw9DWzBxoPulskmcCFkgeZrlKT-wz3BEgaKx3IX0HQw41O5FmRTaCw>
    <xmx:tw9DWwE_aNEK8CM49eHTf5XDLruPgTU7Oi2x4FUSRCTN5XPcCJttvw>
    <xmx:tw9DW7VO7bQukdHmA9DhSHH3L4cuZoSJKhegpGppEx7lykfgZ3PP_A>
    <xmx:tw9DW-YLAGUfY5lrKRcABK2GirCdlVRUws0wIXSGktKnOB0j3l6Nbw>
    <xmx:tw9DW9B6Pwnd_SxjAEG0_zWsD_AEv0fwTHcOI8zhpq1_WhuV06NZcA>
    <xmx:uA9DW8VTyVxh3h2bAY5QW7W3xLIMEMrnf8cFMYSB6HQhw4dowTM1-A>
X-ME-Sender: <xms:tw9DW9PhXqrIXzDO08oQ62V5onx3ZvvJDbDt7oPwSQfPB51Ko-L5dw>
Received: from localhost (unknown [46.44.180.42])
        by mail.messagingengine.com (Postfix) with ESMTPA id 66FB5102B2;
        Mon,  9 Jul 2018 03:33:11 -0400 (EDT)
Date:   Mon, 9 Jul 2018 09:33:10 +0200
From:   "greg@kroah.com" <greg@kroah.com>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Message-ID: <20180709073310.GA9448@kroah.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
 <20180709054842.GB7618@kroah.com>
 <1d34b6addd98c3219f902e0dc0c2922309e1de93.camel@synopsys.com>
 <20180709070635.GB13285@kroah.com>
 <e1f959eb900b0c825842b0c28340bef9d1d2cf3e.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1f959eb900b0c825842b0c28340bef9d1d2cf3e.camel@synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 07:17:11AM +0000, Alexey Brodkin wrote:
> Hi Greg,
> 
> On Mon, 2018-07-09 at 09:06 +0200, greg@kroah.com wrote:
> > On Mon, Jul 09, 2018 at 06:46:50AM +0000, Alexey Brodkin wrote:
> > > Hi Greg,
> > > 
> > > On Mon, 2018-07-09 at 07:48 +0200, Greg KH wrote:
> > > > On Mon, Jul 09, 2018 at 07:44:44AM +0300, Alexey Brodkin wrote:
> > > > > Depending on ABI "long long" type of a particular 32-bit CPU
> > > > > might be aligned by either word (32-bits) or double word (64-bits).
> > > > > Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> > > > > 
> > > > > At least for 32-bit ARC cores ABI requires "long long" types
> > > > > to be aligned by normal 32-bit word. This makes "data" field aligned to
> > > > > 12 bytes. Which is still OK as long as we use 32-bit data only.
> > > > > 
> > > > > But once we want to use native atomic64_t type (i.e. when we use special
> > > > > instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> > > > > misaligned access exception.
> > > > 
> > > > So is this something you hit today?  If not, why is this needed for
> > > > stable kernels?
> > > 
> > > Indeed we hit that problem recently when Etnaviv driver was switched to
> > > DRM GPU scheduler, see
> > > commit e93b6deeb45a ("drm/etnaviv: hook up DRM GPU scheduler").
> > > The most important part of DRM GPU scheduler is "job_id_count" member of
> > > "drm_gpu_scheduler" structure of type "atomic64_t". This structure is put
> > > in a buffer allocated by devm_kzalloc() and if "job_id_count" is not 64-bit
> > > aligned atomic instruction fails with an exception.
> > > 
> > > As for stable requirements - mentioned commit was a part of 4.17 kernel
> > > which broke GPU driver for one of our HSDK board so I guess back-porting
> > > to 4.17 is a no-brainer.
> > 
> > Ok, so 4.17 is as far back as you need?  Please try to be specific when
> > asking for stable backports.
> 
> Well in that particular case I really wanted to get this fix back-ported
> starting from v4.8 so I guess that's what I need to add in Cc tag, right?
> ----------------------------->8---------------------
> Cc: <stable@vger.kernel.org> # 4.8+
> ----------------------------->8---------------------

Yes.

