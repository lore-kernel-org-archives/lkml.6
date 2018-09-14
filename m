Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98612FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB2D2147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=az8.co header.i=afonsobordado@az8.co header.b="cK7l9acd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB2D2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=az8.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeINUmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:42:19 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21447 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINUmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:42:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1536938811; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=fY3SukZrduNRG/cDYdN9ly+P/3ZCJlzpvo0OO4tCZt/sLZX8oJJB4aQUZdKUoKm5ebsbnNAIFrWIxlxf9A2hI7/mNSGyFaTWNCKjqg/p+8QikOMa9EMBSkJ/89kgMuKNFzHOQ55sQqSR3nJm6FIOg8tELnZmstbddRFRUV5A970=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1536938811; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=GffmJL4ug1bbgMOriT1yrq5qGaWnYnM7NZH4UB+IXVc=; 
        b=gMWpqeXXtKX9Ts+GHMVkfZNjV3sfGfrxfpiq2hpoTqp07NQj45qGRS0MzmEYP2QUKGWyiYFfna3tWqtx2LY/P4HP7UVb0CE+ArPRfvC5w8NDbLJVktS2Gbrd8HyP9ZMRnidvEZ0N32Fk4CWvT+XFGt0OIV/5KhGJ5ndmNmlVDF4=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=az8.co;
        spf=pass  smtp.mailfrom=afonsobordado@az8.co;
        dmarc=pass header.from=<afonsobordado@az8.co> header.from=<afonsobordado@az8.co>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1536938811;
        s=dkimmail; d=az8.co; i=afonsobordado@az8.co;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:Mime-Version:Content-Transfer-Encoding;
        l=1080; bh=GffmJL4ug1bbgMOriT1yrq5qGaWnYnM7NZH4UB+IXVc=;
        b=cK7l9acdBWKONt27E/G2NJZCjD+ghpq44u/+yMQyeuXD0R9IAiFdEJO47dra1xsU
        B9Gw1dupgsIHwGogR0o3HYPYZMlLsi9tsp/nP3D8LL+uZHstlyCY/X3aX83hH4lN7WO
        yl+rMnEZeAr6vPPloXPQkhURmmv4yVtOVxRA4S04=
Received: from AYYLMAO (bl9-77-228.dsl.telepac.pt [85.242.77.228]) by mx.zohomail.com
        with SMTPS id 1536938809664252.82219194395782; Fri, 14 Sep 2018 08:26:49 -0700 (PDT)
Message-ID: <2cd9b1674ae88f153a5afe65c151cabf308e4fe7.camel@az8.co>
Subject: Re: [PATCH v4 4/5] iio: fxas21002c: add ODR/Scale support
From:   Afonso Bordado <afonsobordado@az8.co>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     kbuild-all@01.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Fri, 14 Sep 2018 16:26:44 +0100
In-Reply-To: <20180912182350.GA13032@himanshu-Vostro-3559>
References: <20180911150011.31964-4-afonsobordado@az8.co>
         <201809121715.5Babt1QC%fengguang.wu@intel.com>
         <20180912182350.GA13032@himanshu-Vostro-3559>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your help with this.

> And I suspect it may be originating from your code snippet:
> 
> #define FXAS21002C_SCALE(scale) (IIO_DEGREE_TO_RAD(62500U >>
> (scale)))
> 
> and looking at the implementation:
> 
> include/linux/iio/iio.h
> /**
>  * IIO_DEGREE_TO_RAD() - Convert degree to rad
>  * @deg: A value in degree
>  *
>  * Returns the given value converted from degree to rad
>  */
> #define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) /
> 18000000ULL)
> 
> This '/' operator might be the culprit!
> 
> Just for checking that the error, remove the macro declaration
> `FXAS21002C_SCALE`
> plus its usage and re-cross compile using `make ARCH=i386`.
> 
> In my case I used the `div64_s64` function handles builds for both
> 32/64
> arch accordingly.

Yes, this is indeed the culprit. If `div64_s64` works the same way, I
wonder if the best option is to change the macro definition.

I can provide a patch for this along with changing the rest of the
definitions. However i would like some confirmation before starting
this.


