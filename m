Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66C2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E1F20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="te2qvT/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E1F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeK2Q6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 11:58:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32826 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeK2Q6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 11:58:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so891944wmh.0;
        Wed, 28 Nov 2018 21:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=97pu6whjjdvk1hkLCtiCufvJb9NqVxmq5cc0yJgVl1Q=;
        b=te2qvT/Y27xZt/eXU4TnUaxyZT4inBbx6Q5iWDxIUks8lWK3y6uUnKtSeDYA5Zno0Y
         ffOiVGOQ/NMw/PIChhk59Q03n/RgcQSMa1hfMMueowKIXyRkoCU8eTU5bxsIILVX+Alt
         QWpVKhyBw1wG4XKSiHuvyClnXxQ2KnC99qrr6MLMqRkwWlrurXECSZSfN2OHA9p5/kQe
         4VcLl6XdP1cf7x+ecnKIoW1LNr5HR6KTvlXnkXRP7zzlZ8CIa5uRJF0wenturJIf48Bs
         kGLopaV358j6hgoa4LspQVx6ZiyLV6aEBOEHFTDu+swA4TnfEfpyzONgHuA+Z0IM+Wxs
         L5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=97pu6whjjdvk1hkLCtiCufvJb9NqVxmq5cc0yJgVl1Q=;
        b=tqmigm7FuWBalKa08VucMoJYa2AQ/2rmBOOGTTHRFnyKjuGpdRxG4Vjj5mTF2PnSgb
         T8Yfq5WRVE9BQNb8bNxdLOjwhqsIdnFfpyN7EcMFfwf+N07HUvT+N82vJQ6makK5/3u5
         f8VzmoDyxAo2Yfu3YOdmd9eHWBHpSgsA6c1hiVjisSouU24MMwenWzNOrQkjyLmhuARq
         uaK/iZfqjhdGDmIG82CThkh5sM25mSwFSlFPhYeknBHd5hF5ctyA5Tc793+wsVmmrLyO
         p7yhfbW3RZ56fytFGcqmTMBuNBoHjxalOkPWKFtnyyJ40HYgvbwb+gD7Ihf+qietgdk8
         IDVw==
X-Gm-Message-State: AA+aEWb8bjURrpzm03DMLoIpd54bA91IyNOW5Sj5NCBTdLl8u2sNmrnq
        TKgYUTOD2teM0Z+1dPUoL1g=
X-Google-Smtp-Source: AFSGD/Vnxs3O6mMoTTqVTTKSPJvmHn/zwkveNfXtuKgA0w2LFJlVOLblWoh9LfyqdkpixJkHzXUusQ==
X-Received: by 2002:a1c:a9d6:: with SMTP id s205mr372956wme.131.1543470883178;
        Wed, 28 Nov 2018 21:54:43 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id n8sm582841wrw.59.2018.11.28.21.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 21:54:42 -0800 (PST)
Date:   Wed, 28 Nov 2018 22:54:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     dmitry.bezrukov@aquantia.com, igor.russkikh@aquantia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: aqc111: Properly initialize wol_cfg in
 aqc111_suspend
Message-ID: <20181129055440.GA2882@flashbox>
References: <20181129051808.30015-1-natechancellor@gmail.com>
 <20181128.215241.702406654469517539.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128.215241.702406654469517539.davem@davemloft.net>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 09:52:41PM -0800, David Miller wrote:
> From: Nathan Chancellor <natechancellor@gmail.com>
> Date: Wed, 28 Nov 2018 22:18:09 -0700
> 
> > Clang warns:
> > 
> > drivers/net/usb/aqc111.c:1326:37: warning: suggest braces around
> > initialization of subobject [-Wmissing-braces]
> >                 struct aqc111_wol_cfg wol_cfg = { 0 };
> >                                                   ^
> >                                                   {}
> > 1 warning generated.
> > 
> > Add another set of braces to initialize the char subobjects as well.
> > 
> > Fixes: e58ba4544c77 ("net: usb: aqc111: Add support for wake on LAN by MAGIC packet")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> This will in turn make some versions of gcc warn.
> 
> Please just memset() this object, thanks.

I thought this was the form that all compilers seemed to agree on but
sure, I will send a v2.

Thanks for the quick response,
Nathan
