Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA397C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B5A20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="plnwvXB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B5A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeLFAmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:42:08 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44104 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeLFAmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jaSkozHUw/dwkYCjiTkZ3k+qTUq6bxZ2Po9BDHSXDoQ=; b=plnwvXB3VKq2cIUKoMUDiyRqwU
        tQPeueF/b2moFrvMnwJAfCAGSxbrvB133f98vZQ8Wowupceqs0DKQsUrlUlGUs3r7oySGPJ4oPh6B
        8hDboVsGG7nm+pQviI/c0CmRLzWI/qTXho8oghPCxJ5wn2qlTpHbJMDmS24EY4khY0UI2UKA8o2lE
        4TaD2OC+W+YavRfHHSSiVC7D0GzDJ2reI+QUgxpxusF0+RUZAt8XNJww4OA71sHtnfjlhdzmFE8qp
        3h7F+4hFr7UWO3GsuyRjQsZUNaCci7ywKJoU5EVaLW/XmhVOa9piOlpIOC5atHIHmWIPYX7oxgJrk
        sqYrzFig==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUhjy-0002xh-US; Thu, 06 Dec 2018 00:42:07 +0000
Subject: Re: [PATCH v2] Fonts: New Terminus large console font
To:     Amanoel Dawod <amanoeladawod@gmail.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20181205110204.GA17143@kroah.com>
 <20181205235637.1079-1-amanoeladawod@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ccfa900f-114a-0a4d-1d20-22f8d390ce84@infradead.org>
Date:   Wed, 5 Dec 2018 16:42:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205235637.1079-1-amanoeladawod@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 3:56 PM, Amanoel Dawod wrote:
> This patch adds an option to compile-in a high resolution
> and large Terminus (ter16x32) bitmap console font for use with
> HiDPI and Retina screens.
> 
> The font was convereted from standard Terminus ter-i32b.psf

               converted

Where does "ter-i32b.psf" come from?
I.e., where can I find it?

> (size 16x32) with the help of psftools and minor hand editing
> deleting useless characters.
> 
> This patch is non-intrusive, no options are enabled by default so most
> users won't notice a thing.
> 
> I am placing my changes under the GPL 2.0 just as source Terminus font.
> 
> Signed-off-by: Amanoel Dawod <amanoeladawod@gmail.com>
> ---


> +const struct font_desc font_ter_16x32 = {
> +	.idx	= TER16x32_IDX,
> +	.name	= "TER16x32",
> +	.width	= 16,
> +	.height = 32,
> +	.data	= fontdata_ter16x32,

Please update Documentation/fb/fbcon.txt with the addition of that font name
if that is applicable.

thanks,
-- 
~Randy
