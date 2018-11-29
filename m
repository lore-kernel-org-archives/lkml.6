Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE16C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A982081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBHCV+dF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A982081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeK2PuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 10:50:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39277 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbeK2PuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 10:50:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id c72so397581pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 20:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/R74h8rp78HGLdw2BWKROW5d8ewk9KsmzZ8gDi4rZyY=;
        b=eBHCV+dFXATz8mdv6TqJ97LFjzJLg7rAl+0bZj2Y2d9rDQpyjRaOGsz+ZboXrb5ITI
         PSLmVEvOcYyy9P78j2ufTApVxMgMV1vriUgoioGWe2dvikIHIPTfA5GfJGaHu1TjVHjl
         QgCVO4rYCqlrUpXGB2l1jHb4SCkmsZtFNdcTJMdNP2tKNIHuVSnhnktLu1IYwqZwycFT
         nqDfd7h2WjrfzDCJpPK/gtZo2PkjLdEum3p94e/l0s05gI7V1nPp8gd6HLz5AQjAe5vm
         SenH5hjt6eqb8isY9CaBSx/s/ef5Pb2Ho1NCvGotPUy2UwqqEUTsAFm541L/hN928fbH
         5QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/R74h8rp78HGLdw2BWKROW5d8ewk9KsmzZ8gDi4rZyY=;
        b=Xj8Y7FweBzrczoHEELcalQbdnO0uVgd+wOybAwXgLNFY7wkSajDJMBrnfrKeZres8O
         VecVO3t88x2TqECOatsRkoqppNh2DupwoYzi3ccFeYciMCqPR8XEzXKepk2ZoCPSyckS
         WtIupN4Ivx26GshTNgS9+7Iqgu19dSNnGlqg5AIxO3Zrk/4nZRXINK7TFYVyU1QLckzJ
         i0igvKH3+HuCTeGn/vCGCuQ5QuTW7HESHHK5PoQjtdUr0hCkL+ofKqeuaq/8Icr1CfC4
         qnPGbKCDT5Sbo5G8kmMagI8bkOcuqr2y7mtfc/jfnNowZyvI0OLnTEwM4QhyXxBbwpcm
         QOYA==
X-Gm-Message-State: AA+aEWZrkkNMM96/in38s+zw5zSPDioYJIgahfSIdtmfm8zxnIGDNUo3
        OpJHfeaC8Jh3gdqmOTS+SA2P/JKR
X-Google-Smtp-Source: AFSGD/XJ6r5toV3fbwPBevAnIJ3fvBVH9pAB1mqBk3b7/jJXZQcqn0B+XLkdlaf+ipjMxR2wcIIJTQ==
X-Received: by 2002:a65:5a8e:: with SMTP id c14mr15390pgt.137.1543466770745;
        Wed, 28 Nov 2018 20:46:10 -0800 (PST)
Received: from localhost ([175.223.15.27])
        by smtp.gmail.com with ESMTPSA id v76sm950544pfj.145.2018.11.28.20.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 20:46:09 -0800 (PST)
Date:   Thu, 29 Nov 2018 13:46:06 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dave Rodgman <dave.rodgman@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/7] lib/lzo: performance improvements
Message-ID: <20181129044606.GI6379@jagdpanzerIV>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127161913.23863-1-dave.rodgman@arm.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/27/18 16:19), Dave Rodgman wrote:
> > Right. The number is data dependent. Not all swapped out pages can be
> > compressed; compressed pages that end up being >= zs_huge_class_size() are
> > considered incompressible and stored as it.
> > 
> > I'd say that on my setups around 50-60% of pages are incompressible.
> 
> So, just to give a bit more detail: the test setup was a Samsung
> Chromebook Pro, cycling through 80 tabs in Chrome. With lzo-rle, only
> 5% of pages increased in size, and 90% of pages compress to 75% of
> original size (or better). Mean compression ratio was 41%. Importantly
> for lzo-rle, there are a lot of low-entropy pages where it can do well:
> in total about 20% of the data is zeros forming part of a run of 4 or
> more bytes.
> 
> As a quick summary of the impact of these patches on bigger chunks of
> data, I've compared the performance of four different variants of lzo
> on two large (~40 MB) files. The numbers show round-trip throughput
> in MB/s:
> 
> Variant         | Low-entropy | High-entropy
> Current lzo     |  242        | 157
> Arm opts        |  290        | 159
> RLE             |  876        | 151
> Arm opts + RLE  | 1150        | 181
> 
> So both the Arm optimisations (8,16-byte copy & CTZ patches), and the
> RLE implementation make a significant contribution to the overall
> performance uplift.

Cool!

	-ss
