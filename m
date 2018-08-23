Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5688AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC2B206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EGb8rmqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC2B206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbeHWSEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:04:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHWSEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PR+wcPJskNfR1EAymPGP5LsKDIP//2yxf1uFMHMFqSs=; b=EGb8rmqqdYKZ2yz73rp6DjCHH
        4Bv1NaQQIcxs0bDV6N57kcBooQ2vmuIBz18K7G5+VlVgO7p2FwLPevtuVR1WbBqsdV1cE0jr2sihf
        21Y+MlXcQGKeAFj0rx/U6lKUO9P5LcTFoxWbwkea058Z1PCEkgdfsTu/g/ZbpxZJhbnngTBdKE/N6
        +rrwxDatzQeVm7fEa+XfS9i8yx6qbsHYkOGcblvhpxl1FIy9yxSXS8jCoGV7dhkQweJ0bzJaF7siE
        7zsO3BM4e//zvWF/sic4LHPDyUdX8RlI67CtoNj5KxRZHeSMaKbSN0hPZaCfjB3ELDMdpVCkey8bL
        3V85zVFKw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsqhB-0007SU-LH; Thu, 23 Aug 2018 14:34:45 +0000
Date:   Thu, 23 Aug 2018 07:34:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Starkey <brian.starkey@arm.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Eric Engestrom <eric.engestrom@intel.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Airlie <airlied@linux.ie>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Ayan Kumar Halder <ayan.halder@arm.com>
Subject: Re: [PATCH] drm/fourcc: Add DOC: overview comment
Message-ID: <20180823143445.GA26109@bombadil.infradead.org>
References: <20180821161611.10424-1-brian.starkey@arm.com>
 <20180821162639.GA21697@bombadil.infradead.org>
 <20180821164416.GA11553@e107564-lin.cambridge.arm.com>
 <20180822145924.GA13763@intel.com>
 <CAKMK7uHxPDfxJaA+1esSW8L2HAjMD6xgF0cMH-nkTjA=6S5+CA@mail.gmail.com>
 <20180822155732.GA39066@e107564-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822155732.GA39066@e107564-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 04:57:33PM +0100, Brian Starkey wrote:
> On Wed, Aug 22, 2018 at 05:11:55PM +0200, Daniel Vetter wrote:
> > On Wed, Aug 22, 2018 at 4:59 PM, Eric Engestrom
> > <eric.engestrom@intel.com> wrote:
> > > On Tuesday, 2018-08-21 17:44:17 +0100, Brian Starkey wrote:
> > > > On Tue, Aug 21, 2018 at 09:26:39AM -0700, Matthew Wilcox wrote:
> > > > > Can you turn them into enums?  This seems to work ok:
> 
> I'm not sure that swapping out explicit 32-bit unsigned integers for
> enums (unspecified width, signed integers) is necessarily a good idea,
> it seems like Bad Things could happen.
> 
> The C spec says:
> 
>   "the value of an enumeration constant shall be an integer constant
>   expression that has a value representable as an int"
> 
> Which likely gives us 4 bytes to play with on all machines
> that run Linux, but if drm_fourcc.h is ever going to be some kind of
> standard reference, making it non-portable seems like a fail.
>
> And even if you do have 4 bytes in an enum, signed integers act
> differently from unsigned ones, and compilers do love to invoke the UB
> clause...

I think you're exaggerating how much latitude C compilers have here.
Further down in 6.7.2.2, it says:

  Each enumerated type shall be compatible with char, a signed
  integer type, or an unsigned integer type.  The choice of type is
  implementation-defined, but shall be capable of representing the values
  of all the members of the enumeration.

So if we include an integer which isn't representable in a plain int,
then the compiler _must_ choose a larger type.  It could choose a
signed-64-bit type rather than an unsigned-32-bit type, but I can't
imagine any compiler being quite so insane.
