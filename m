Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418DEC282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F81D218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="f/6ZWKqM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LFxA7GxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfAaIw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:52:57 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45771 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbfAaIw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:52:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BF6512015;
        Thu, 31 Jan 2019 03:52:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 31 Jan 2019 03:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=B4i8qu8Fhn3wH5KYylYCfJYRSoB
        WJG1mc5WVkWS3Sv0=; b=f/6ZWKqMpfmzi8BggP+kG7UclJd3TcKUp6aykC11Zlk
        GuqTgTsaWBkm7/GShzosW+kiXEvjmNfDJLVARPleDfWsXtY0937zj1lQS6VjtAQs
        s+ows7N3cR1tpkiqcjUDKp86n3XqQpwTMckQQwBtnDcc5OGTQWlHS6Ib28RUxbiy
        4TmMeCrBo4wyU1BJ6dKk2DKlTEZJ3ehVjbAYwUVWst/rJEXbaA1ZdiCsykWEvnLq
        oGXG4iuvI84q/JmZXciorj8vuVffeALbxIvgKRyJLY7vgvsigBtsoy8oxnlR9KrD
        a3JmwxH4Serrpf1bvXu8sD32ckHZUWABPLA4gTpmhjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=B4i8qu
        8Fhn3wH5KYylYCfJYRSoBWJG1mc5WVkWS3Sv0=; b=LFxA7GxUQGCo/l67XrOaZB
        j/AAxKqZhm0P7JsNO6J7+OGvIrfi4l0zMDA6OaWe6dWfXBavJqd1dFO1omVlRSGB
        YFSsPPRdgCSsncXqIKFf1Owhfc+Za2qFJuF8xELS4xr5Lg2dFGo91WlzIowk+LMk
        DTMa7UavBDh6OkaaWEu5t8rgJdRNXfff5WkuW9Xzy6sHAZb36Q4u51NHv+Cym/tc
        ff9ze7GSG/xifQsiRJdzmRNVxGupCj22aww7cxiWBvbjUbl7/Qfd269p/rF1lmuf
        goTPK1ehec5uvj3+HoNari2rjZZuRgXErqOIoVknT84Lg9r0x9z+6qNcWeoD6kGQ
        ==
X-ME-Sender: <xms:Z7dSXAel76isXfZW20rwCv9tR4kmKiNP2Sy-4sINVRIdbCY_1QdhEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeehgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdeftd
    dmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdforedvnecuhfhrohhmpedf
    vfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosghinhdrtggtqeenucfkph
    epuddukedrvdduuddrvddufedruddvvdenucfrrghrrghmpehmrghilhhfrhhomhepmhgv
    sehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:Z7dSXOOLeVGNKHitqM-b2LiSRTL5g3tkzLCfLXJvYUeytV_wOSiJ_g>
    <xmx:Z7dSXDvSdTbEiE6iLyJtEb8UqMSTYqtrkEesdCABBvLN0XmWZ9E7KQ>
    <xmx:Z7dSXHBlIzaPbVbRRrNPAIZe9vPN_Jwcc8fLvPXjN6DEf5yVFRZXbw>
    <xmx:Z7dSXJh0XY8j1K8Pkx3rHg3YAjnwf8-FpygCmlNUz2vT614UJEdWSw>
Received: from localhost (ppp118-211-213-122.bras1.syd2.internode.on.net [118.211.213.122])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5EF431030F;
        Thu, 31 Jan 2019 03:52:54 -0500 (EST)
Date:   Thu, 31 Jan 2019 19:52:49 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Pekka Enberg <penberg@iki.fi>
Cc:     Christopher Lameter <cl@linux.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] slub: Do trivial comments fixes
Message-ID: <20190131085249.GC23538@eros.localdomain>
References: <20190131041003.15772-1-me@tobin.cc>
 <01ec2c57-4ece-5ee1-4d0d-d2f24695f482@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ec2c57-4ece-5ee1-4d0d-d2f24695f482@iki.fi>
X-Mailer: Mutt 1.11.2 (2019-01-07)
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 08:06:31AM +0200, Pekka Enberg wrote:
> On 31/01/2019 6.10, Tobin C. Harding wrote:
> > From: "Tobin C. Harding" <tobin@kernel.org>
> > 
> > Hi Christopher,
> > 
> > Here is a trivial patchset to wet my toes. This is my first patchset to
> > mm, if there are some mm specific nuances in relation to when in the dev
> > cycle (if ever) that minor (*cough* trivial) pathsets are acceptable
> > please say so
> > 
> > This patchset fixes comments strings in the SLUB subsystem.
> > 
> > As per discussion at LCA I am working on getting my head around the SLUB
> > allocator.  If you specifically do *not* want me to do minor clean up
> > while I'm reading please say so, I will not be offended.
> 
> For the series:
> 
> Reviewed-by: Pekka Enberg <penberg@kernel.org>

Thanks for the review Pekka.


	Tobin
