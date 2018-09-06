Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5123DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AE22064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYtxpOEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AE22064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbeIFSNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:13:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38984 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:13:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id v77-v6so9095438lfa.6;
        Thu, 06 Sep 2018 06:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVPvpo3u/AdFOxsuq8hcRZoaMoN/vBXGtwVmkoZ9cVU=;
        b=XYtxpOEOjHvXOR3iRObzpt9oTLEfyn7Hom/1zS36Tk4BMmw+FaLZWyEy4tk3tw5phH
         p4BTAlQGEmM44x3SXvXRiViKMO7oHOShSHjWfAlfApG2JVRHR0MzKJXtnEpx36EUvc5E
         0UNOoIfI3d9Rz2/MnWzAteODGOp8LxW0Py3zULMrB4HASR2UDRxfcRgCXplMG8f1pNQ5
         iK9fShaxZouq+UQRdwJcrjaHwgzTfQNnqW23WLElVvTopr1dj2dsmV5W0qq8ypPzyxFH
         YyzpGEtx9czbv48WWPR++QZ0ycHNtDTC8T7xuJo/Ek+AjloOnlwfeBHSXlaxUu1BhCdc
         auaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVPvpo3u/AdFOxsuq8hcRZoaMoN/vBXGtwVmkoZ9cVU=;
        b=Q3kKOSfn+Ci1oiip3duwMEfVrCW1GELabQgQ4d3kEzbNNK8ZI35R//o/AT6W8Wmtce
         wchhWSjUfUxTUypPYEb2mHnG0joOzK7CzAA5q6BqIUbgUEpVszMa7oIn3/pAQ8Wris82
         HccRW5i8iRhOE89DO4K25BnDTjQZEI6KDbV9fCaCkzeJjWPsc5TcYGLKCGhuIj0PP/HR
         HtI5CvVpnX9dyiNxtdRqmNk0O2PUbxX/CGQm0Jmm9rVEbo+UvkbT2XFBZYwIDudjp3ql
         BH6Egd0+ufJw2CzhjPstExf28eQOzx4S5GsbTJ8Xz2MGesubLvBHZLQE6UPrL55xjc2S
         G2YA==
X-Gm-Message-State: APzg51AekHtxVHADUZP9URwI27kWiCykvaaCmKUieFbIdgEaTUSerkxP
        XtI4bsO6htgpDYBUMpCZDuq/RpPEA1S3tXmdRmE=
X-Google-Smtp-Source: ANB0Vdbq34rULhA+zVrsGJ6cf1gdUufWGXJQ6N/ppHT+5L66CRYwBlJ+tUBvz3Feil34bqm/i4h3OoBvPnVdFzSFRqQ=
X-Received: by 2002:a19:c38b:: with SMTP id t133-v6mr2109798lff.7.1536241062239;
 Thu, 06 Sep 2018 06:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
 <20180904194944.19721-1-simon.k.r.goldschmidt@gmail.com> <20180906110926.GF5360@sirena.org.uk>
 <CAAh8qsyMcL-acBf4nXq2RSE=Y43FMG8v+TuyvvmgGtkjHchAyQ@mail.gmail.com> <20180906132333.GG5360@sirena.org.uk>
In-Reply-To: <20180906132333.GG5360@sirena.org.uk>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date:   Thu, 6 Sep 2018 15:37:30 +0200
Message-ID: <CAAh8qsxKQF4ZPJACYy03z9LQzU0tBB9wv9ztZ3AC4kE_OHGH4g@mail.gmail.com>
Subject: Re: [PATCH v3] spi: dw: support 4-16 bits per word
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Trent Piepho <tpiepho@impinj.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 3:23 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Sep 06, 2018 at 01:23:34PM +0200, Simon Goldschmidt wrote:
> > On Thu, Sep 6, 2018 at 1:09 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > Please don't send new patches in reply to old patch serieses, it makes
> > > it harder to follow what the current version of things is and makes it
> > > much easier for the patches to get lost in the old threads.
>
> > Ok, no problem and thanks for the hint! Where does this requirement
> > come from? Patchwork or mail sorting habits?
>
> Mail sorting.  It can mean that you get things like someone deleting a
> thread and the new patch getting caught up in a thread delete command
> and hence missed.
>
> > Anyway, how does this continue, will you pick the patch or do I need
> > to somehow collect yet more reviews?
>
> You should've got a mail at about the same time saying it's been
> applied.

Right, got it. Thanks again.
