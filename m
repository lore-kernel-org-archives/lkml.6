Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20A2C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8200B20850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEuDl/Iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8200B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbeGVXUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:20:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37572 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbeGVXUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:20:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so10798429pgq.4;
        Sun, 22 Jul 2018 15:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iGbxgpKxfnU8cJSwCv4nptNKXdwEn4jlf+Gx5UStL+A=;
        b=cEuDl/IyNib5BEY2wJEV3YQzD05TOlmtGZ/PF56Ez0scSmLJ6a78wL1uMIhKonr7kJ
         vNiqphRQ8zLvIPsyv8NGfH2dtuyfersyxyxQFiRHxKd0Xcm2ATzyycOmEShwwx7bW15R
         q5YccfsASnpGcJuqUO6qn1+G3BYznW+f7CSnEYTxsVCnBU76+XoR6EGNxja35a/blVGx
         Oj/ubdg0r9FvKkB8K06yNC3v5UpDuGGumRgSF6ZUdebCUPHWvYCaNtvKRdDqF669I3Jr
         46fLtQ5tmmIrDKoQm/NzGQxv1nNLyv0IugRVn1zVbB0rk4GFJNBgNBDo3v/1EAv+9Cpb
         aAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iGbxgpKxfnU8cJSwCv4nptNKXdwEn4jlf+Gx5UStL+A=;
        b=Kxhm7Pi5jGE42FInnU25D8kBXQiA4ckOPQh0pZHN+Mr5zyvoajHdpDmNCg/nRwLVbg
         0G9dsO8mMY6O4ERWs5S3ca0xOM2PHcUDH2LHZwNZEvFfr41+KT6fO0sjVCMSHH9b6EDW
         F1J8c0f1lfwAYn/nxX80BEi3K1HAwwOVZcnD3YxsGlfBpWaEs/GSbVrOhE7fqIAQLePZ
         Y/rv+/NbAh0M7mdntPLs5G6NE2DW85nIeNWBu7oafQPEBLLyqonqDhneB5H9C0IatX4g
         uc+CfUKajQgapBYzpgK/5OIYPfP098+db90XYGXR71TMsS30GZJ+OjnbzXVDyEeW3YNI
         2OnQ==
X-Gm-Message-State: AOUpUlH4O16/z4Rhdz+Ml/WdiMpfU/rjLy/2QkxLtYiXJWAY2yr0oRvT
        PIfXEQqr9aBvZhFOCMaShSE=
X-Google-Smtp-Source: AAOMgpdMpu7HYOfsLLgDelPJRjiJElCR7KIGCEyNKzOk+vpZ2XgpITBFBor1DDNYkNU7A7rLw4D/bA==
X-Received: by 2002:a62:9f16:: with SMTP id g22-v6mr10546666pfe.207.1532298121617;
        Sun, 22 Jul 2018 15:22:01 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id i25-v6sm3705084pfi.150.2018.07.22.15.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:22:01 -0700 (PDT)
Date:   Mon, 23 Jul 2018 03:51:54 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>, dfrey@sierrawireless.com
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4] iio: chemical: Add support for Bosch BME680 sensor
Message-ID: <20180722222153.GA10066@himanshu-Vostro-3559>
References: <1532122284-19602-1-git-send-email-himanshujha199640@gmail.com>
 <20180721161934.75066d97@archlinux>
 <20180721153607.GA11127@himanshu-Vostro-3559>
 <CAHp75VegzWr8Q2idzAWpc5Nw3T5n=vWkMvspe0YGRwEQ_h0p+A@mail.gmail.com>
 <CAEnQRZC80FWN9EADvE9geu773=vwRmE0JEwSfy_DMjig0d=qqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZC80FWN9EADvE9geu773=vwRmE0JEwSfy_DMjig0d=qqw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 08:45:34PM +0300, Daniel Baluta wrote:
> On Sat, Jul 21, 2018 at 6:43 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Jul 21, 2018 at 6:36 PM, Himanshu Jha
> > <himanshujha199640@gmail.com> wrote:
> >
> >>> > +   /* Look up table 1 for the possible gas range values */
> >>> > +   u32 lookupTable1[16] = {2147483647u, 2147483647u, 2147483647u,
> >>> > +                           2147483647u, 2147483647u, 2126008810u,
> >>> > +                           2147483647u, 2130303777u, 2147483647u,
> >>> > +                           2147483647u, 2143188679u, 2136746228u,
> >>> > +                           2147483647u, 2126008810u, 2147483647u,
> >>> > +                           2147483647u};
> >
> > This one needs perhaps a bit of though, but...
> >
> >>> > +   /* Look up table 2 for the possible gas range values */
> >>> > +   u32 lookupTable2[16] = {4096000000u, 2048000000u, 1024000000u,
> >>> > +                           512000000u, 255744255u, 127110228u, 64000000u,
> >>> > +                           32258064u, 16016016u, 8000000u, 4000000u,
> >>> > +                           2000000u, 1000000u, 500000u, 250000u, 125000u};
> >
> > ...this one obviously just a not needed one. You may replace it with a
> > one constant and simple calculation to get either value (index from
> > value, or value from index).
> 
> Indeed this can be reduce to:
> 
> 125.000 << (15 - idx).
> 
> The real question here is if we approximate 255.744.255u to 256.00.00u how
> much different is the result. Being a gas sensor I think it is very
> hard to appreciate.
> 
> We can go with this formula + adding a comment with the table with the
> exact coefficients.

So, I have planned to use this 125000 << (15 - idx) equation with
approximating the array members.

About the difference in results we would get after approximating isn't
much of a problem IMHO because gas sensor is primarily used for IAQ, and
IAQ is relative to the resistance reading.

For eg: 

Resistance(ohm)			IAQ
value < 30K			Very bad
30k < value < 50k		worse
50k < value < 70k		bad
... 
..			
so on..

So, what I simply imply is the scale will be adjusted and nothing else
changes, unlike if it had been pressure, temperature, humidity.

The IAQ implementation is userspace application suggesting
good/bad/ugly air quality.

And since we know David Frey is planning to use this sensor in his
product mangOH board.

So, David, how are you planning to use the gas sensing part in your
product ? RGB leds, buzzer, alarm ?

Thanks Andy for the suggestion :)
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
