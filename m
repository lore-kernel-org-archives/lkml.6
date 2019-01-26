Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AC5C282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE25D218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM9wJXUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfAZGS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 01:18:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40387 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfAZGS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 01:18:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so5080952pgp.7;
        Fri, 25 Jan 2019 22:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DRwifb4mSZ+paxxIQN74boKUCYU/zt297aJLV9mI2mM=;
        b=QM9wJXUdZlqk4/xCK6lLcRjh6DFthq9OMiVx8cTgXroz7JQNexT8G/yYsDw/0AqbCV
         egev5Y6xFEK6IUeShLMXli6N1GThiLSsqKTIVG42Ng6AKwYXvBlVJd9TFUXdmLgsj2ZY
         UIaniJrmb98+97y7Uo5ZGHcJPX/xuAiVhDkm8g2v8TkDE0Dr6p+Jp+WGZzYsiJpvCWlg
         uDslBTxIQuMN3Mbcu5XGnyjXOHWZtpGpGJpmqoo+xkXZ6OpMKiGGS3wybP6XwbhLoJBU
         JZkfPcYSw3yKRGu0MzWvHncosaf/vUYVAJO2gngzd3qa6pCdwLdjVyL/dWfUvZxqX89x
         Mowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DRwifb4mSZ+paxxIQN74boKUCYU/zt297aJLV9mI2mM=;
        b=awXirKXIwunIL+R4HMb3ZN5EVL6EN4G21LQ8Fg6j4kfpP5qtWtqHX6yEXm2zpq43+5
         0ki8Pzjv2PyyNkpNR5bRkVoqFEM9eG2uqXH7Sa/jVq8c7mIl+WUqojX/2DLIzpeMy+Iy
         MxBpZc6b1uaJJ49dWpMXJTGTsRI3EPtgK04IQVfqhT2dd+OJJXtuATWmet945551j5RG
         HrEVqoXBqgEPNlfxCWl0ESkBj9QhYXsyYBzFY88HJvNYIST5m7UyMZVqS3Ez0VaWT4UD
         cnJ00cUNrfDo+d7FLsIyAie3G7V7QW4OxMRvKAKakZnVKiqrJvoy8L8P6h7UbflPgP9Z
         Ga+g==
X-Gm-Message-State: AJcUukdd7RGc5i2qFAeptXLoAoubljs2SPGvZPLwRfAS/7MukTLGVWgh
        9bEKfMIjy6+S7PjxuRKUqLk=
X-Google-Smtp-Source: ALg8bN7rztBFTuzeqllaLS0SMhpG4L3EYAjLCJgoKnOHzXv8ZTn4B4HZlZpCe9vgxUHvptNZcgVSfw==
X-Received: by 2002:a62:be0c:: with SMTP id l12mr13578883pff.51.1548483535854;
        Fri, 25 Jan 2019 22:18:55 -0800 (PST)
Received: from Shreeya-Patel ([2405:204:2025:63cf:8193:9b01:86c4:8b4c])
        by smtp.googlemail.com with ESMTPSA id 6sm55413187pfv.30.2019.01.25.22.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 22:18:55 -0800 (PST)
Message-ID: <3356f9251a02eceee65ebf860e0ccec4e497e5df.camel@gmail.com>
Subject: Re: [PATCH v3 0/3] adt7316 regmap implementation
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 26 Jan 2019 11:48:46 +0530
In-Reply-To: <0ce4cd728a61ef2231d45f68e702708cf59cd781.camel@gmail.com>
References: <20190120153633.18231-1-shreeya.patel23498@gmail.com>
         <20190126012243.GA4762@r2700x.localdomain>
         <0ce4cd728a61ef2231d45f68e702708cf59cd781.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-01-26 at 10:42 +0530, Shreeya Patel wrote:
> On Fri, 2019-01-25 at 18:22 -0700, Jeremy Fertic wrote:
> > On Sun, Jan 20, 2019 at 09:06:30PM +0530, Shreeya Patel wrote:
> > > This patchset consist of some initial patches for heading
> > > towards the regmap implementation and also the final patch
> > > which enables the driver to use regmap API thus removing
> > > the redundant and common code.
> > > 
> > > Changes in v3
> > >   -Fetch the changes from remote and rebase to have it in
> > > the current working directory.
> > > 
> > > Changes in v2
> > >   -Change the val_bits to 8 and add two more patches
> > > having a different change before the final implemetation
> > > of regmap.
> > > 
> > > Shreeya Patel (3):
> > >   Staging: iio: adt7316: Remove irq from bus structure
> > >   Staging: iio: adt7316: Remove multi read and write functions
> > >   Staging: iio: adt7316: Add regmap support
> > > 
> > >  drivers/staging/iio/addac/adt7316-i2c.c |  97 ++--------------
> > >  drivers/staging/iio/addac/adt7316-spi.c |  95 +++------------
> > >  drivers/staging/iio/addac/adt7316.c     | 147 ++++++++++++------
> > > ------
> > >  drivers/staging/iio/addac/adt7316.h     |  15 +--
> > >  4 files changed, 103 insertions(+), 251 deletions(-)
> > > 
> > > -- 
> > > 2.17.1
> > > 
> > 
> > The series doesn't apply to the current iio testing branch. If
> > there's any
> > value in a quick sanity testing, I can do that after a rebase. I
> > wasn't
> > planning to test everything the patch touches, but thought I could
> > at
> > least test a few register reads and writes to make sure we haven't
> > missed
> > anything obvious in the regmap implementation.
> 
> Hi Jeremy,
> 
> Is it still not applying? Jonathan told me that v2 of this series
> wasn't applying so I rebased for this series.
> 
> I hope I didn't mess things up while rebasing :(
> 
> Thanks

Yes it is my mistake. I've rebased against greg's staging tree.
I will soon send a v4 for the series.

Thanks

> 
> > 
> > Jeremy
> > 
> 
> 

