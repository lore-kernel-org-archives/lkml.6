Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269FCC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D9C20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D9C20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeGYFaX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 01:30:23 -0400
Received: from ozlabs.org ([203.11.71.1]:46929 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeGYFaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 01:30:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41b2896SZ7z9ryn;
        Wed, 25 Jul 2018 14:20:25 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH 1/4] treewide: convert ISO_8859-1 text comments to utf-8
In-Reply-To: <20180724111600.4158975-1-arnd@arndb.de>
References: <20180724111600.4158975-1-arnd@arndb.de>
Date:   Wed, 25 Jul 2018 14:20:25 +1000
Message-ID: <87o9ewx7xy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> Almost all files in the kernel are either plain text or UTF-8
> encoded. A couple however are ISO_8859-1, usually just a few
> characters in a C comments, for historic reasons.
>
> This converts them all to UTF-8 for consistency.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
...
>  drivers/crypto/vmx/ghashp8-ppc.pl             |  12 +-
...
> diff --git a/drivers/crypto/vmx/ghashp8-ppc.pl b/drivers/crypto/vmx/ghashp8-ppc.pl
> index f746af271460..38b06503ede0 100644
> --- a/drivers/crypto/vmx/ghashp8-ppc.pl
> +++ b/drivers/crypto/vmx/ghashp8-ppc.pl
> @@ -129,9 +129,9 @@ $code=<<___;
>  	 le?vperm	$IN,$IN,$IN,$lemask
>  	vxor		$zero,$zero,$zero
>  
> -	vpmsumd		$Xl,$IN,$Hl		# H.loXi.lo
> -	vpmsumd		$Xm,$IN,$H		# H.hiXi.lo+H.loXi.hi
> -	vpmsumd		$Xh,$IN,$Hh		# H.hiXi.hi
> +	vpmsumd		$Xl,$IN,$Hl		# H.lo·Xi.lo
> +	vpmsumd		$Xm,$IN,$H		# H.hi·Xi.lo+H.lo·Xi.hi
> +	vpmsumd		$Xh,$IN,$Hh		# H.hi·Xi.hi
>  
>  	vpmsumd		$t2,$Xl,$xC2		# 1st phase
>  
> @@ -187,11 +187,11 @@ $code=<<___;
>  .align	5
>  Loop:
>  	 subic		$len,$len,16
> -	vpmsumd		$Xl,$IN,$Hl		# H.loXi.lo
> +	vpmsumd		$Xl,$IN,$Hl		# H.lo·Xi.lo
>  	 subfe.		r0,r0,r0		# borrow?-1:0
> -	vpmsumd		$Xm,$IN,$H		# H.hiXi.lo+H.loXi.hi
> +	vpmsumd		$Xm,$IN,$H		# H.hi·Xi.lo+H.lo·Xi.hi
>  	 and		r0,r0,$len
> -	vpmsumd		$Xh,$IN,$Hh		# H.hiXi.hi
> +	vpmsumd		$Xh,$IN,$Hh		# H.hi·Xi.hi
>  	 add		$inp,$inp,r0
>  
>  	vpmsumd		$t2,$Xl,$xC2		# 1st phase

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
