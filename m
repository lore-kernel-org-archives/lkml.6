Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91977C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 05:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBF8208DA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 05:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="A0ECRi1M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="he0l+pr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBF8208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeHZJhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 05:37:05 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42533 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbeHZJhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 05:37:04 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 310182C8;
        Sun, 26 Aug 2018 01:55:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 26 Aug 2018 01:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=CTqSLvwUHy9E/Z2Xu5PfCmHnnO9BngeD8Qas5w0dCgo=; b=A0ECRi1M
        pQq3iVvgO/VW7i85BcHGMJ453vE4HlP7KEeOLT3I6bOqhtgm1Y5KTAFgnZq9z1YP
        apf1+mWjjAk3cjq8xwfue5OVAxboxPsdxYxd46Yu75mZQNzunhs1sqR8CXkK/JCT
        2Ppy0MpA2BVeHmtT66jIZqZJBFacR+HXsLbUyloOF1huWkl04si20NjF3F7kJaGa
        n6CzNWtcRH12ZkmU6rQv+InfUMrwNs8HaUobspgiEdc6B+4m9id9AzE95vlZWIEh
        Wvaybt9qmVVRLlhl80wo6YPAIProbPgtngUpTOKzwVMBgy7TmCR3p3so3CKkssZl
        gi6GGlY3TLNoDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=CTqSLvwUHy9E/Z2Xu5PfCmHnnO9Bn
        geD8Qas5w0dCgo=; b=he0l+pr+o/Cbxw9XrBJpu4D/9+IZbn0Yw2atQMax8Jeg3
        CGzWm5Z6lnUhFpPihz1WPbIN6CQ/f0iQYBnyqWBmn89Ceuj4W0wvceMMN27UZG0Z
        b3xK2dbYoNZrSTmDVCQ99GTwqBFgaMKgoQ/MrjMy99jTuqmoTlzNHrJqk458Gwik
        Au9NPIfUHNUXyH8qPBeJuk3cPtJdAiK1W43ThlCkS1RyxpmXVFs5uHehrMOFwx/i
        IXOYyYAUsNhSZysptBKAA/ZyHrq9oTZjUt1Zs8sXNHfB7fj9QrKO7FLMJi7kym1B
        BzgsFDSmzRqn33yUT0ndYyxDhuUibqaKB4/BC9ZuA==
X-ME-Proxy: <xmx:1UCCW7G-cQ_phU9op04SgCe8_tDESRwSw6-ndHZuuTA32v-WC1gJGg>
    <xmx:1UCCW_MdGilxs2R1C0NSg1YyXWmOntP2DvZy-FzqN5CePrDdqm_05A>
    <xmx:1UCCW1elHfCFq4-JyPq98rPFj3z24oczfC_IUZ9jSCd1InZ4nPpsvA>
    <xmx:1UCCW0u6AEMW0B2Yxb_K2sX8gwhAajujPckL6hJ7yrb7VCh3OPTKxg>
    <xmx:1UCCW-lw6CrPSegY31MOnxXX7gGUEsN9JGwRkWuBiwA1-SX1-l3ApQ>
    <xmx:1kCCW7SUrgLsqcSA-d8FPszAZ8TmxZQ9JqnABWs1JltT9uU03rPcCQ>
X-ME-Sender: <xms:1UCCW2AE_XvT1_aZeiZzsXdcAvOgXbDnxSdqDBDH_r7MZ3MpS_s0nw>
Received: from localhost (5355525a.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4DCF7E447F;
        Sun, 26 Aug 2018 01:55:33 -0400 (EDT)
Date:   Sun, 26 Aug 2018 07:55:31 +0200
From:   Greg KH <greg@kroah.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andi Kleen <andi@firstfloor.org>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        bernhard.kaindl@thalesgroup.com
Subject: Re: [PATCH] x86/mm/pat: Fix L1TF stable backport for CPA
Message-ID: <20180826055531.GA20871@kroah.com>
References: <20180825135015.33547-1-andi@firstfloor.org>
 <20180826044646.GA24782@roeck-us.net>
 <20180826050641.GT12066@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180826050641.GT12066@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 10:06:41PM -0700, Andi Kleen wrote:
> > > Cc: stable@vger.kernel.org # 4.4 and 4.9
> > 
> > LGTM for v4.4.y but ... are you sure that this patch applies to v4.9.y ?
> > Commit edc3b9129cec is 'native' in v4.9.y and has not been reverted there.
> 
> You're right. I thought it was needed for 4.9 too, but yes it has the CPA pfn
> patch. So for 4.9 the patch is not needed and in fact incorrect.
> 
> The original report was for 4.4.
> 
> Greg can you please revert/remove it again for 4.9?

Now dropped, thanks.

greg k-h
