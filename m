Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC15C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1907420863
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9v+LN8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfA3FzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:55:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36463 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfA3FzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:55:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so20178379wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 21:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bxG1jsbCAvDb2G+7mh+61CiKZy1Hkeq0wdB2KS1FVYs=;
        b=H9v+LN8MHHeOYdhO+cqenNlJUlzi/DzhWqGMdU4WlDZdLkgV4mLgQOP0OFI0mEyVtn
         NeBESs1OnMl0D/M89kwhCKtTNPLwZvTBYgk06L1Q46Dl0AnNanIUT004A9e8g2ab9pxK
         6EGCYNw4cyCqfgofAXaxEF1/2m69v2X6tMZ+V0vmXLftcAA/rtaUIHDJwqwgzuSyNlWR
         a9hW1JaFbiAXO7cPBW0rmvpRije6AEilphmH5N7ZmjXNT1z/xkz5yaqCcbzaIf924cAS
         BJ0Z0Cjadna0QPctbp18vcxvdYzaPTKuCkaC9HB1yBQ8MxcFTjPcCVNFTjEf8qQ/SYKX
         dwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bxG1jsbCAvDb2G+7mh+61CiKZy1Hkeq0wdB2KS1FVYs=;
        b=L2jCXAxAkEx9VphnHMPbUVwD+GyfGHJb8N2GdpXiscb7Y9hq4GxAHXtVT5EUGCILbm
         CSjf42a4+6L8vgrAR+TurYaX7ccbI8rZMP1fYnkc4PceKn/qwRN2iTQgB/ydT8rzlrdV
         ZS3IHYLczPtUZs25hh9zzqT1ljlT5hM3DRp3GLz7OrlozHGYTFLh/6CgaAeoI0XZPlLy
         FdSrmMgqQgrWgySFTzccpU0+hQvJo/7nCIO010nHOtyNIsXU4ZNqi1bQ1lL6+qMP0L8e
         CcQpsFYDDlGFxu/5N0WiXjm3vebwcC/B99eiK1o79KdCXYuVRfgT67CSwqgD8xmkaeHb
         Yy1g==
X-Gm-Message-State: AJcUukfALTSNjbM08w8mnyptOnlTmzUo2S1WCeBcBMoU9RP4q6Fyl7Ac
        ZSlByAGN/ft4OvGXnAMS9xBvn+g=
X-Google-Smtp-Source: ALg8bN5yRm0+RDVFy0H2VnEta6POR9+70xZpYP7Asxo9WoN3LTGJau/X9cr5Qw4LKRZlpUUO6WTK/g==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr24333705wmu.52.1548827704410;
        Tue, 29 Jan 2019 21:55:04 -0800 (PST)
Received: from avx2 ([46.53.246.247])
        by smtp.gmail.com with ESMTPSA id c14sm516353wme.13.2019.01.29.21.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 21:55:03 -0800 (PST)
Date:   Wed, 30 Jan 2019 08:55:01 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: calculate end pointer for /proc/*/* lookup at
 compile time
Message-ID: <20190130055501.GA2115@avx2>
References: <20190114200422.GB9680@avx2>
 <20190129141848.5f3d2d1aa125c8ec45ee091d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129141848.5f3d2d1aa125c8ec45ee091d@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 02:18:48PM -0800, Andrew Morton wrote:
> On Mon, 14 Jan 2019 23:04:23 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Compilers like to transform loops like
> > 
> > 	for (i = 0; i < n; i++) {
> > 		[use p[i]]
> > 	}
> > 
> > into
> > 	for (p = p0; p < end; p++) {
> > 		...
> > 	}
> > 
> > Do it by hand, so that it results in overall simpler loop
> > and smaller code.
> > 
> > Space savings:
> > 
> > 	$ ./scripts/bloat-o-meter ../vmlinux-001 ../obj/vmlinux
> > 	add/remove: 0/0 grow/shrink: 2/1 up/down: 4/-9 (-5)
> > 	Function                                     old     new   delta
> > 	proc_tid_base_lookup                          17      19      +2
> > 	proc_tgid_base_lookup                         17      19      +2
> > 	proc_pident_lookup                           179     170      -9
> > 
> > Note: this trick bloats readdir, so don't do it :-\
> 
> I don't understand the Note:.  Can you please expand?

The same could be done to proc_pident_readdir(), but the code becomes
bigger for some reason.
