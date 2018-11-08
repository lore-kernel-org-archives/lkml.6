Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893F5ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E4F20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWxU5qvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E4F20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeKICLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:11:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeKICLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:11:17 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2B920883;
        Thu,  8 Nov 2018 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541694899;
        bh=KSZIXB3aOIiCbL+xaMf82z67Mc86QzXOT9zlcuh7K34=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IWxU5qvPvJ6XDSdcB+PbjL/R8C47SlcoRf0l+3QKU4OWDL1+j7A0d3LZS1CaA5Rlp
         PVSDpRHWlDYYfnVkh8acAgfOryCnytk2Ff63ySDgVzLNkJloo6+S0I+P+pOSNeOfuA
         SdmBPeNii4iRmp/sYsTKLydTU3GMkEfyIQXJfFSQ=
Received: by mail-qk1-f170.google.com with SMTP id e4so27524830qkh.6;
        Thu, 08 Nov 2018 08:34:59 -0800 (PST)
X-Gm-Message-State: AGRZ1gJUTpJv1T2bpa/JX9hd4b6JGl5w5fRLmxW5k7RoYx07jNBaoV2D
        kugGTD1skLAA4l/P+FQmARrSu90nuuM2AINe2g==
X-Google-Smtp-Source: AJdET5exF52lfJgUYsxdgoTnnk8IUP7guryTZFdKV+D1VpqcCu3paVCu1rohs9bT9IuYz63HpDsIs8ML2RFxtaqvyT0=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr4857472qkg.147.1541694898286;
 Thu, 08 Nov 2018 08:34:58 -0800 (PST)
MIME-Version: 1.0
References: <1540831111-3040-1-git-send-email-stefan.popa@analog.com>
 <20181103121606.2fc461ec@archlinux> <1541687328.2091.2.camel@analog.com>
In-Reply-To: <1541687328.2091.2.camel@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 8 Nov 2018 10:34:45 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+zc2RGWgkwXNk8qjJqjo+FpdPZUOOxd44mb8Cu7+EsaQ@mail.gmail.com>
Message-ID: <CAL_Jsq+zc2RGWgkwXNk8qjJqjo+FpdPZUOOxd44mb8Cu7+EsaQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: Add ad7124 support
To:     StefanSerban.Popa@analog.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 9:02 AM Popa, Stefan Serban
<StefanSerban.Popa@analog.com> wrote:
>
> On Sb, 2018-11-03 at 12:16 +0000, Jonathan Cameron wrote:
> > On Mon, 29 Oct 2018 18:38:31 +0200
> > Stefan Popa <stefan.popa@analog.com> wrote:
> >
> > >
> > > The ad7124-4 and ad7124-8 are a family of 4 and 8 channel sigma-delta
> > > ADCs
> > > with 24-bit precision and reference.
> > >
> > > Three power modes are available which in turn affect the output data
> > > rate:
> > >  * Full power: 9.38 SPS to 19,200 SPS
> > >  * Mid power: 2.34 SPS to 4800 SPS
> > >  * Low power: 1.17 SPS to 2400 SPS
> > >
> > > The ad7124-4 can be configured to have four differential inputs, while
> > > ad7124-8 can have 8. Moreover, ad7124 also supports per channel
> > > configuration. Each configuration consists of gain, reference source,
> > > output data rate and bipolar/unipolar configuration.
> > >
> > > Datasheets:
> > > Link: http://www.analog.com/media/en/technical-documentation/data-sheet
> > > s/AD7124-4.pdf
> > > Link: http://www.analog.com/media/en/technical-documentation/data-sheet
> > > s/ad7124-8.pdf
> > >
> > > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > Hi Stefan,
> >
> > The discussion around the DT binding has gotten me looking at bit
> > more closely at that for this version.
> >
> > Some most comments in that section.  Also a really minor ordering issue
> > in
> > remove which I'd just have fixed if we weren't going around again for
> > the binding.
> >
> > Main binding thing is I don't think the odr value belongs in DT.
> > Gain is more marginal (unless the part can actually be damaged by
> > a wrong value - which I hope it can't!).  I'm not that fussed
> > as there are definitely reasons to specify a default scale to
> > cover the reasonable range on a pin.
> >
> > Thanks,
> >
> > Jonathan
>
> Hi Jonathan,
>
> Thank you for the review! So, how should I proceed?
>
> First, we need an adc.txt file where "bipolar" and something like "diff-
> channels" should be documented. Should the file be placed under
> Documentation/devicetree/bindings/iio/adc?

Yes.

> Regarding the "odr-hz" property, it totally makes sense to remove it from
> the DT. How about the "gain"? Should we leave it in the DT and also add the
> possibility to be configured from user space?

Look at other bindings. I think there are others having gain. If not,
then it probably should only be user space configurable. If so, then
can it be a common property too.

Rob
