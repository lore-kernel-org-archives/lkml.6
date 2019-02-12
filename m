Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FEBC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38114222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf09Ybjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbfBLTwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:52:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37440 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbfBLTwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:52:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so4113106wrs.4;
        Tue, 12 Feb 2019 11:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7zDh03p36NNslnWH2Bes5adwYxOMryUqvQK/ZcrSJTk=;
        b=gf09YbjhwP/QW5i1xWLQHosgMVXujb53uta/4YKFWwOu/CuwfnIR4LiQFkov9j02hH
         deJXkqHkeFdUkrP6gb9ZML3Do/88qPA08xAGuOlJ+cbwsMk+s5ZzCnkbeTgQzIsyR6lH
         +eIBwJEqOZ389dhB68HmfP4HW5rcko9V++wkVYNtpQb+LX9jb3oViKzZKQZLVo7W4pa6
         ndnEFPQO5h5zuij/T2E+ZVZjkTKTB8xA3uVs/NaSyVWJIKtYZORUxKnI2KS+KjB1Hijf
         +HC/u4zm/pYADJuqqRWskfPmewz9vZIJ6t8RaDSjMXKZH2nbfNP1jVYluwA79RsUvbG2
         tD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7zDh03p36NNslnWH2Bes5adwYxOMryUqvQK/ZcrSJTk=;
        b=IIn6DD9PnBfKKhiS4NwrfINTBrQWF2F0XVLP3zbhcQUX2QSTOm7JSaqKM4Xf+d/fXY
         pzgiaNLbZF+YV5fRFGJ5ZLO7imwDsJjAE0y7RgNULGJ+PQbhQ1RgErZcOkXCPiqGXKL1
         DObtTeByp1Jka5d4/ZEjOKaLJEUYDdYplclvEft0/IbdrZ6mtSe84Llt5DZ1r3N/aE9O
         A5I+pJZ3vwPwnb2hbVPmTGupQMouCJfoGZqMLrh7cRyhvEf0Bn5sZ6x5ICLpiDjkc2Zx
         ZuW5ZzhIzoKURIc7PvqSVVlfzdX57EmzFGmCMAmNuQejWoueAHn9eJmsZS8OoQEJopeB
         rVKw==
X-Gm-Message-State: AHQUAua/oHHTzhsdYkQXDVKeBEitdA/SMQ32b814spy57Eu7lLCyJ9Vi
        DrUAQposJbdFFRD4M++ivTTACpd1
X-Google-Smtp-Source: AHgI3IY8Djh0shq6uVtL0uGyPXZhPrL1DmWDaby40uBpBEzX2KyWfdHXdl7P41+9To+GN09iZfqa+w==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr4056152wrm.96.1550001143549;
        Tue, 12 Feb 2019 11:52:23 -0800 (PST)
Received: from localhost.localdomain ([46.216.128.70])
        by smtp.gmail.com with ESMTPSA id f187sm4518222wma.4.2019.02.12.11.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 11:52:22 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gte6P-0002LR-H1; Tue, 12 Feb 2019 22:52:21 +0300
Date:   Tue, 12 Feb 2019 22:52:21 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: Add leds MFD cell for intel_soc_pmic_chtwc
Message-ID: <20190212195221.GC5213@jeknote.loshitsa1.net>
References: <20190209221213.24052-1-jekhor@gmail.com>
 <20190209221213.24052-3-jekhor@gmail.com>
 <20190212081409.GN20638@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212081409.GN20638@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 08:14:09AM +0000, Lee Jones wrote:
> On Sun, 10 Feb 2019, Yauhen Kharuzhy wrote:
> 
> > Add MFD cell for LEDs driver to the Intel Cherry Trail Whiskey Cove PMIC
> > mfd device driver.
> > 
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > ---
> >  drivers/mfd/intel_soc_pmic_chtwc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
> > index 64a3aece9c5e..68b54173edd8 100644
> > --- a/drivers/mfd/intel_soc_pmic_chtwc.c
> > +++ b/drivers/mfd/intel_soc_pmic_chtwc.c
> > @@ -60,6 +60,8 @@ static struct mfd_cell cht_wc_dev[] = {
> >  		.resources = cht_wc_ext_charger_resources,
> >  	},
> >  	{	.name = "cht_wcove_region", },
> > +
> 
> Nit: No need for the blank line, please remove it.

Agree.

> 
> > +	{	.name = "cht_wcove_leds", },
> >  };

-- 
Yauhen Kharuzhy
