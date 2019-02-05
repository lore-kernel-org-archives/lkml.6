Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6ABC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E212080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOBdxdJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfBEU1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:27:20 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43784 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbfBEU1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:27:20 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so4001028eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 12:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KV41r0ySdRCIWvH57UF0asBkzn1ocmazBDZUTljHxpY=;
        b=bOBdxdJ0bx+DMdoSOTMFmkrPvTIX9MAvWHpYSq+Ne9sHuWa226w4iGAEFt3OaWZPCd
         A9GeRuuiG9iNK3MUHIJdzzWKJq61J5RR5CQSk/qWqWR1+Hs8RCxpVlUEXujbA0l5is/B
         vHazNEm7hgl32OWFHhhw3MZzA13G5uLo9+Y3H0nDXYE8tn711nwh8sO359q2Y3MFOjMv
         Yl9ETxdkhBTlV0P/gDGTyLfToMwTPpm+uQNnaqse0f3QAGmvxvkbxCi60EZd41bM1Lgs
         g4r2ZGec1QWpJoJHxxNKcLRUxp5aIN1HqcgszXG8ZgB90fKychoJOiza7k1XVlAKC1ET
         4wPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KV41r0ySdRCIWvH57UF0asBkzn1ocmazBDZUTljHxpY=;
        b=Okk9ycJJL1xrTvXoRrkL2mPet0t/p9FcijyfE5xse/awvjbkS2UO5F+0Rrq8txDFZ1
         nsb3uDdZ09wtITuzVsPKJT1zhuGgKmpMtj6kwQ/JCCBZNXVckRALVv7FCspwL9xPxdvU
         aj0s/jnD3JSTeaLB+pJ/H5B/0i7b2fz/sAVGj274mttlm1SEcpIctKUy1f4ZoZQyoMnG
         ROyVl+h1FUOnrHNdF8dwhg9uHSYN1C37aUGCc9zGRr/Nb3cvB3wv8nitH68bnV9pzda/
         QgDHXKBp9rxz+RflXe4TymdYYyPVHaLcyA5HvT9uwIQ8PP3uvYBanDPGce9TrsOwxvE0
         rwCw==
X-Gm-Message-State: AHQUAubSwjeqVCSOJcbLEtUjGvD81AK3MayNDBsbwbTf0E3PI2D3eJZ+
        r9+j/aN0CJRsjLTVUjrVcb4=
X-Google-Smtp-Source: AHgI3IZ/ctkVYxuSpuRUahWJc45Ms/PgIu5xGz3aquKWOIRo1ZI7f//ZQtdm4ZEAQv/pvW2K+l5ERg==
X-Received: by 2002:a50:f284:: with SMTP id f4mr5361041edm.77.1549398438662;
        Tue, 05 Feb 2019 12:27:18 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40eb:400:f595:6cb4:537e:4c4b])
        by smtp.gmail.com with ESMTPSA id m10sm3149165eja.38.2019.02.05.12.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 12:27:17 -0800 (PST)
Date:   Tue, 5 Feb 2019 21:27:15 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] build_bug.h: add wrapper for _Static_assert
Message-ID: <20190205202714.7jeuvso4hyjrjy77@ltop.local>
References: <20190203192401.29170-1-linux@rasmusvillemoes.dk>
 <20190204150916.f29d782b27f096e6c4c6d6cf@linux-foundation.org>
 <20190204151209.d6fae2c6466cb5c9c5814fd9@linux-foundation.org>
 <e819dbc8-5d7a-2f7b-35c5-e70754ba28e4@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e819dbc8-5d7a-2f7b-35c5-e70754ba28e4@rasmusvillemoes.dk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 10:53:31AM +0100, Rasmus Villemoes wrote:
> On 05/02/2019 00.12, Andrew Morton wrote:
> >>
> >> It would be (very) nice to actually use this macro in a few places so
> >> it gets its build testing while in -next.
> > 
> > ie, just about every BUILD_BUG_ON in mm/ could use this.  Let's switch
> > a few?
> > 
> 
> Perhaps, but some make sense where they are, e.g. when iterating over
> two arrays using one iterator variable, it's fine to assert they have
> the same size just above the loop. And, unfortunately, static_assert()
> is not quite a drop-in replacement for BUILD_BUG_ON even when the
> argument is an ICE due to -Wdeclaration-after-statement.

Yes, unfortunately.

-- Luc
