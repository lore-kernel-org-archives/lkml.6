Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567B1C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 15:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116EA21766
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 15:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="fL/QU3Uu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a/x2R8Vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116EA21766
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeHYSrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 14:47:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58961 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbeHYSrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 14:47:06 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4A92621C5C;
        Sat, 25 Aug 2018 11:07:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 25 Aug 2018 11:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=w4v1YfJ2aZ1A7zKMxSTh+VLRBIaTfwupqSD2E+AODOA=; b=fL/QU3Uu
        sOkPt0RN8Y46iwxF7oaJAcq5AVmaWwG9ibFKLiUiWFHi5GbFU/N2bgSdewEyOhRW
        fw8Na10sPQ9KbvB212EBNVynOAVxAKoqKoOZvKDa6r0YPGL98P/z9EjHXRGFyiss
        pLDv1FlvMCOCfHFeQsxNm9yZQDdH6/uieO/aJ7HmUl/+7jeLL85AVExa90Jucsms
        8EmULj6nwmUhRdMjV46tKu3b1RcSqc2uzveJHnBy5tgLWaHxAwMIBLdTcqaSfFwy
        w2pgehoS0P2C7q1CN8kLmR2g/7U7ZtONcwHPS718oN5iV35Tn148B79WsxpRLrZB
        fwFYDGnrTsF1WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=w4v1YfJ2aZ1A7zKMxSTh+VLRBIaTf
        wupqSD2E+AODOA=; b=a/x2R8VyZSx/rLhBNUovv6MyYuwkKrGvLvT3kqzLBHMwq
        OJVh+Kv4DuYLvjltkMCFy17PPvTBrOpQyao6r4G49Z/678KCRh5Ge1E6LWFm5OTP
        ZJBwtfRFqjKfTSKLB84D+LRRHF8DIbEjggCl2WP4dHLNfz8NphDTL/bbS6r0waTL
        f15DGQOX/VOKQApl9wXhHDnEuv81Nzeg7BZ+4hekxuLODyl0SjWAHzErx+lwfxWn
        8MDOu6iYIVQM2jKLHVoheHJRB89Wkt4/i+o2UfUXb1YEQis7nKsZ5asJLKV9Zmy7
        21lGxEry7TNMYQmywhIPP8S2yd4asLyquzpuoNIwA==
X-ME-Proxy: <xmx:xHCBW5vv0wXSrTU_SyGFGeTkgmDSjEGWBRUIQ9mHyIjK9NyFlT-eRQ>
    <xmx:xHCBWyo9r2UEMQ3tRGZ4tinmtVKzEqbtm8npnm8RntRLz8Wp6RPcQw>
    <xmx:xHCBW-kPI7MZT0QyLqKO2UP2DcGQuDDjWDTyehfPFd96KSLePK91VA>
    <xmx:xHCBW-yZy2hsV8IoV_kM6oJ_1yoZW9hGG3um-e_KwPH89twt8boxjg>
    <xmx:xHCBW-l8IrbtypcuTUc9-njuEishKwzaolBluive8NgF5CiseXFU0g>
    <xmx:xXCBW3n799e_CebDx5RqNJLCEIR_eJHcVWIqYNVgg486umxk2ODwIA>
X-ME-Sender: <xms:xHCBW1aqbsIPaPFqUIKuGGJ4sUjMyOomzL7bPne8VdEEwa44HOirvw>
Received: from localhost (5355525a.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4D42FE464C;
        Sat, 25 Aug 2018 11:07:48 -0400 (EDT)
Date:   Sat, 25 Aug 2018 17:07:45 +0200
From:   Greg KH <greg@kroah.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bernhard.kaindl@thalesgroup.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/mm/pat: Fix L1TF stable backport for CPA
Message-ID: <20180825150745.GB10230@kroah.com>
References: <20180825135015.33547-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180825135015.33547-1-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 06:50:15AM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Patch for stable only to fix boot resets caused by the L1TF patches.
> 
> Stable trees reverted the following patch
> 
> Revert "x86/mm/pat: Ensure cpa->pfn only contains page frame numbers"
> 
>     This reverts commit 87e2bd898d3a79a8c609f183180adac47879a2a4 which is
>     commit edc3b9129cecd0f0857112136f5b8b1bc1d45918 upstream.
> 
> but the L1TF patch backported here
> 
>    x86/mm/pat: Make set_memory_np() L1TF safe
> 
>     commit 958f79b9ee55dfaf00c8106ed1c22a2919e0028b upstream
> 
>     set_memory_np() is used to mark kernel mappings not present, but it has
>     it's own open coded mechanism which does not have the L1TF protection of
>     inverting the address bits.
> 
> assumed that cpa->pfn contains a PFN. With the above patch reverted
> it does not, which causes the PMD to be set to an incorrect address
> shifted by 12 bits, which can cause early boot reset on some
> systems, like an Apollo Lake embedded system.
> 
> Convert the address to a PFN before passing it to pmd_pfn()
> 
> Thanks to Bernhard for bisecting and testing.
> 
> Cc: stable@vger.kernel.org # 4.4 and 4.9
> Reported-by: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
> Tested-by: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/mm/pageattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for this, now queued up.

greg k-h
