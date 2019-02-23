Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CF4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE19206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="kD8F70P4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfBWMzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 07:55:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41735 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfBWMzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 07:55:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id n2so5155687wrw.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 04:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=If1EW02IMyYRK8Qqq7I2S3/zZAH0ob5WSW7je21GfAs=;
        b=kD8F70P4rBiVCZ8IwysPtKXNJ2l5LpggetxtPP3YsgHgHbEuZjQ6QOnVVEPeh+K8lc
         lmMqjHsfPiOUQ5985T5npSAnTJqvPI+92oZMQAdcxz1+ngodcfv5UVRYAQFu+AyUlO+c
         QFNoVwxAa655ifdNh6ys08GkycDv6NhO1bJUyM1NH4m2jiKNMZ83yz8RpO4eMngR9KuN
         aulolYnCAXsUKR/cZjkNU8eN1lhTEb7UJQHJWYOe9NXYHNTfdVU8MAn1DJpRDHR2ZzR+
         jyTkdk14V1oAaRucac9Iard5uSiRMcvXxfn+6Be+wF4P5AkB3+E3OpRB7H2tTGyEOJ08
         g7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=If1EW02IMyYRK8Qqq7I2S3/zZAH0ob5WSW7je21GfAs=;
        b=Oes33myziP2/f1or1yN25PcQZ5SoPGN6soN8ZjolFNJ6D5uOLV9LgYHbn33FCrr1CR
         ZmNdkqR5K26rcNUpSV2FLbagscDqYzBzpcESmVQE8dZuphSjjpIZGgwD2dK5HGtaJk+O
         p/JdYLOO/Mu49GCE8phAueerZt39dDYJx/1+yAXeSuyGM915/i4XBB4LwPFutDDw9B79
         VFlD/TPA7/w47Ip3uGe/LCYPEQuvB9dUQp6pFEv+2NJPmPRfp3qZiiGCKO69IawYGaGN
         68P1JYLiB+sEuATzZPWBAQmt006EQDQ4kvZzyibDgktYXKNz4AnYvNW3umjhMoD2TXBu
         unDA==
X-Gm-Message-State: AHQUAuYcoxJAYQeYC0HKxO56d6XjLg+lgeDQsdmWlq3wBvxMPEwmHAa5
        w7bRe2H3z6nJeDxNnmI6W37JFvYkZswNjujqOVyPuw==
X-Google-Smtp-Source: AHgI3IYoGSv5wiCjSxaT0uCB0DkRpgVtwjU83ZOdHJFWl/pWdTD2qCCUBLALBwU8AV/qvWOiE55EsS38GaroXQg9IZ4=
X-Received: by 2002:adf:eac2:: with SMTP id o2mr6388092wrn.0.1550926505583;
 Sat, 23 Feb 2019 04:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20190220165013.12774-1-axel.lin@ingics.com> <24E35288-677D-4223-B94A-52A4F37792A8@schinagl.nl>
 <CAFRkauAPGEBxj7k2GvmFwhyc7ZuofhXou17b75F3G-mUWVaf9A@mail.gmail.com>
 <20190221094237.GA5970@sirena.org.uk> <d52c2711-71f3-9e72-f01b-e761f4a92a07@schinagl.nl>
In-Reply-To: <d52c2711-71f3-9e72-f01b-e761f4a92a07@schinagl.nl>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Sat, 23 Feb 2019 20:54:54 +0800
Message-ID: <CAFRkauDdx00VmqhmzohdCyWbPkctCU2D03JqkpSw2x7n-bDzHA@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: Get rid of AXP20X_xxx_START/END/STEPS defines
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Priit Laes <plaes@plaes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I will not disagree that it may be extra work to look up the define
> (especially if there is no tool tip or split view in the editor) but
> reading the whole lot of code, with only the magic values, you still
> have to look up the meaning of each magic value, have to guess which one
> has the same meaning etc.
>
> Further more, I do believe far more people reading will find an define
> to be more descriptive to read. Whoever needs to actually go in and
> fix/change things.

I disagree.
The reason I sent this patch is because these defines reduce readability.
I do care about readability, but in this case these defines make
readability worsen.

At the context of REGULATOR_LINEAR_RANGE, each fields has well known meaning.
When I look at the table with values (I don't care if it's hex or decimal),
it tells everything I need to know.
I can easily check if any linear ranger cover other ranges.
I can easily check if any gap between linar ranges, (probably due to
reserved bits).
I can easily count the number of entries in each range.
I can easily calculate the min/max voltage of each range and double
check with datasheet.
i.e. If there are something wrong, it's eash to detect it.

When you change the values to DEFINES, I have to check the value of
each define *one-by-one*.
There is no benefit in this case.

I don't mean adding DEFINES is wrong. Just in this case it does not
help and actually has downside.
I only remove AXP20X_xxx_START/END/STEPS defines, not all defines.

BTW, just show you an example (from drivers/regulator/88pm8607.c)
I don't think change all below values to DEFINES help in readability.
static const unsigned int BUCK1_table[] = {
         725000,  750000,  775000,  800000,  825000,  850000,  875000,  900000,
         925000,  950000,  975000, 1000000, 1025000, 1050000, 1075000, 1100000,
        1125000, 1150000, 1175000, 1200000, 1225000, 1250000, 1275000, 1300000,
        1325000, 1350000, 1375000, 1400000, 1425000, 1450000, 1475000, 1500000,
              0,   25000,   50000,   75000,  100000,  125000,  150000,  175000,
         200000,  225000,  250000,  275000,  300000,  325000,  350000,  375000,
         400000,  425000,  450000,  475000,  500000,  525000,  550000,  575000,
         600000,  625000,  650000,  675000,  700000,  725000,  750000,  775000,
};


Regards,
Axel
