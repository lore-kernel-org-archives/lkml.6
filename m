Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB59C282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 05:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95FB218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 05:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj0eYWwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfAZFMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 00:12:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32991 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfAZFMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 00:12:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so5499818plo.0;
        Fri, 25 Jan 2019 21:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ZrrrjxjvdyMWHzY/yaX2Gh6a/3DQu7i56S2qd87Q1o=;
        b=Jj0eYWwzdcGJ6SkNgWWxlMNPUeuyAK5ct+vkcxFv9t5NujMilESEkl8gKsvIEkbrsk
         bc+Mq40OJWc3VqRA6QJX4Q7UE95m+h4Abl1XcsB2bwno3Kij4kqq57RXGdK1ufp3nO1p
         vH2Q/HDxtBCTdZdr66uigrTV76wpcIxZLMRQhCglV7k8tStXaXWuyWnkPREVRF0bHPWk
         RBHGyNFa2LMLPraB+JlT+YKFids4KYBMJzi9sJnxtktnowo9PrSTMwdiGPh08mwrGvdJ
         1qnRBmoQ0au32s1edcy/Okcn7fghy+Of/RmIxRIQZ2zaSsTnTlhOR5XryzRP5UmWl47/
         0WqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ZrrrjxjvdyMWHzY/yaX2Gh6a/3DQu7i56S2qd87Q1o=;
        b=qu6ghqeSCsiNpriW4Vfal7ZiOeaXseS3dM1Ega+LluS+3UiSm4ZDmMf7F7hLMzIOig
         uLxgdUDocuv2x0ZSA5g5ZL3b/F4Rv0A5vXt8rjOaJIzOaV+/UI1m2FvMdq3RiC8BEWyo
         lAtwwKN4P/AZzSSNj3K0bj7rm2je13WeqQXO1h41NPdc/MuSvSz16/6Zn1mYySllDjhw
         t69NtRCCibcIxXbazrqJbhUbdj866dhimBf3IerIijJWuI1GMZbOYAmCIiGIy+7pmCTj
         q6EG6cCW2dsmcAQCxoCFldmwmNc2zBYgLdzeHbobg2iWdGgSgrNKtGHUx0HRNX3d66fC
         HfSA==
X-Gm-Message-State: AJcUukexX/jxK/A6voOFedhC+So/v97uUNCw+SOD28gjSD5qpiQCI929
        iE+csx6fz58KH0j1rqfs9mw=
X-Google-Smtp-Source: ALg8bN4PX8XBE6PpBnUGEHrtbIhxPOUHY7fg81HtD221RE6YKYPk2V35hldjSUk9iXmi4sZqKEMrJQ==
X-Received: by 2002:a17:902:a586:: with SMTP id az6mr13827022plb.298.1548479553682;
        Fri, 25 Jan 2019 21:12:33 -0800 (PST)
Received: from Shreeya-Patel ([2405:204:2025:63cf:8193:9b01:86c4:8b4c])
        by smtp.googlemail.com with ESMTPSA id b2sm48692370pfm.3.2019.01.25.21.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 21:12:32 -0800 (PST)
Message-ID: <0ce4cd728a61ef2231d45f68e702708cf59cd781.camel@gmail.com>
Subject: Re: [PATCH v3 0/3] adt7316 regmap implementation
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 26 Jan 2019 10:42:23 +0530
In-Reply-To: <20190126012243.GA4762@r2700x.localdomain>
References: <20190120153633.18231-1-shreeya.patel23498@gmail.com>
         <20190126012243.GA4762@r2700x.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-25 at 18:22 -0700, Jeremy Fertic wrote:
> On Sun, Jan 20, 2019 at 09:06:30PM +0530, Shreeya Patel wrote:
> > This patchset consist of some initial patches for heading
> > towards the regmap implementation and also the final patch
> > which enables the driver to use regmap API thus removing
> > the redundant and common code.
> > 
> > Changes in v3
> >   -Fetch the changes from remote and rebase to have it in
> > the current working directory.
> > 
> > Changes in v2
> >   -Change the val_bits to 8 and add two more patches
> > having a different change before the final implemetation
> > of regmap.
> > 
> > Shreeya Patel (3):
> >   Staging: iio: adt7316: Remove irq from bus structure
> >   Staging: iio: adt7316: Remove multi read and write functions
> >   Staging: iio: adt7316: Add regmap support
> > 
> >  drivers/staging/iio/addac/adt7316-i2c.c |  97 ++--------------
> >  drivers/staging/iio/addac/adt7316-spi.c |  95 +++------------
> >  drivers/staging/iio/addac/adt7316.c     | 147 ++++++++++++------
> > ------
> >  drivers/staging/iio/addac/adt7316.h     |  15 +--
> >  4 files changed, 103 insertions(+), 251 deletions(-)
> > 
> > -- 
> > 2.17.1
> > 
> 
> The series doesn't apply to the current iio testing branch. If
> there's any
> value in a quick sanity testing, I can do that after a rebase. I
> wasn't
> planning to test everything the patch touches, but thought I could at
> least test a few register reads and writes to make sure we haven't
> missed
> anything obvious in the regmap implementation.

Hi Jeremy,

Is it still not applying? Jonathan told me that v2 of this series
wasn't applying so I rebased for this series.

I hope I didn't mess things up while rebasing :(

Thanks

> 
> Jeremy
> 

