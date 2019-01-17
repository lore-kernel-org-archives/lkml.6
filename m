Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F628C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593E220868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pieTo06O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfAQWid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:38:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35372 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfAQWid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:38:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so5539024pfi.2;
        Thu, 17 Jan 2019 14:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5E+2/GYKKTCBX9PRkJwki/ltO0/DQBbf8wDLJlA+F/Q=;
        b=pieTo06OI+5DFqKZqLxhU8R3x4ayvukvWFTzcX8qvrIOJcqc/EmRKifExP7A3vcXP9
         oR0oEgtrAL5GrYTJHQPfZSONj9vo+jl5qhVJ2J2Xde/YDKzrcLSpA752NLeeLiiV3myD
         xiw+vyE+bFtBBYqrePFnR28vr8OVryziv2PE10VWeNg3dZSTDn1kDwx3SdsVZ/UvD946
         XWxVqTcG8Ga01KS0kfx9kkwTzUMwHv6M2Jq/lb4oEAzI1oCGLuAZysvEygCx2v5Sioqv
         +OQrYGxUyfRdDLY+hy/D0TQSsVQwi9COqMkuCJz6MzSvnx4duX6zChKfjby5M7qeBPhZ
         sq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5E+2/GYKKTCBX9PRkJwki/ltO0/DQBbf8wDLJlA+F/Q=;
        b=CRejyfdShD4UlMsaG8CHuDtNxXiswIcy8xnvUFRPvGZJn80Nhxr8YQPe48kk0kj59p
         dYaQQ/B6STHZOsbmsWvVqy1LAeRD3kbWdBpxKk/eya4bphO/u/husX2XZimWnUD93TDS
         4UUn38D8JzAfFPx3Kk5nDFWya/GzJ5l27iOB7Ws4Jg3Y+woYwDwPSlOGU//sgH7UhivP
         M7Gzdc4MO9lPLKAgd1cXV4dmygZ5zKO79YESoMWvqxBnyW1Ee/FmbkglPDGIPvq06+JL
         nCbg7m4JgimqeMb9oVFsXN4GQSSn5q76ub2nOtf9LRstPEAMxMC0bsnfVlMHUmpB0ZN0
         YdYQ==
X-Gm-Message-State: AJcUukdU5B32etQ9cWswq/pNkJHFiy8XjSXalwKOZxwr6DeN3S4fkUTi
        CpdGyygrl15QtdKblKVjpyHEBGc+
X-Google-Smtp-Source: ALg8bN7SDaq7ILk+XQTCSwaeR3+pavwAm9Tv0uV8GdAkf8HeqBotDVqJfmpk2C4dz5cbV1W2xaFUWA==
X-Received: by 2002:a62:29c3:: with SMTP id p186mr17002451pfp.117.1547764711697;
        Thu, 17 Jan 2019 14:38:31 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id b26sm4032861pfe.91.2019.01.17.14.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 14:38:31 -0800 (PST)
Date:   Thu, 17 Jan 2019 14:38:28 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     =?iso-8859-1?B?QnL8bnMs?= Stefan <Stefan.Bruens@rwth-aachen.de>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [RFC][PATCH] hwmon: (ina2xx) Improve current and power reading
 precision
Message-ID: <20190117223828.GI16918@Asurada-Nvidia.nvidia.com>
References: <20181121012629.5432-1-nicoleotsuka@gmail.com>
 <2863036.QIPGp1Eqjm@sbruens-linux.lcs.intern>
 <20181121194051.GA8902@Asurada-Nvidia.nvidia.com>
 <1717545.GXSegKtrMu@sbruens-linux.lcs.intern>
 <20190105012642.GA18025@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190105012642.GA18025@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 05:26:42PM -0800, Nicolin Chen wrote:
> Hi Stefan,
> 
> Sorry for a super late reply. I took a long vacation.
> 
> On Wed, Nov 21, 2018 at 10:16:09PM +0000, Brüns, Stefan wrote:
> > > > Another concern may be voltage drop over the shunt, but for this case you
> > > > have a nominal voltage of 1.8V, so 30uV are 0.001%.
> > > > 
> > > > > When measuring a 1.8v voltage running a small current (e.g. 33 mA),
> > > > > the power value (that's supposed to be 59.4 mW) becomes inaccurate
> > > > > due to the larger scale (25mA for method A; 62.5 mA for method B).
> > > 
> > > Just found out that I have typos here: 25mW and 62.5mW.
> > > 
> > > > Another look into the datasheet reveals, even at full gain (PGA=1), the
> > > > LSB is 40mV / 2^12 = 40mV / 4096 ~ 10uV. So when the current ADC reads
> > > > out as 3*LSB, this anything between 25mA and 35mA. This is the best case
> > > > figure.
> > > Current read doesn't get affected a lot actually, since hwmon ABI
> > > also reports current value in unit mA. However, the power read is
> > > the matter here. With a 62.5mW power_lsb, power results are kinda
> > > useless on my system.
> > 
> > The reported current does not matter here, actually. Internally, the ADC value 
> > will have an uncertainty of 10mA (at PGA=1). At 1.8V, your uncertainty is 
> > 18mW. And thats *only* the quantization noise. It wont get better than that.
> 
> The fact is that I do get better power results after setting the
> calibration value to 0x7ff. That's the necessity of this change.
> 
> > Also note, you are apparently using the ina2xx hwmon driver - I strongly 
> > advise against it, you should either use the ina2xx driver from the IIO 
> > subsystem directly, or use the IIO driver via iio-hwmon.
> 
> The IIO version is also using the minimum calibration value. It
> will not solve my problem here.
> 
> > There is also always the possibility to read the bus and shunt voltage 
> > registers and calculate the power manually.
> 
> Won't that be a waste since the hardware could have provided a
> better accuracy? It would need more I2C bus reads and cpu cycles
> for calculation.
> 
> I don't get why you're against a setting for calibration value.
> This is how the hardware got designed to cover different cases.
> Since we do have such a case that needs some accuracy, it'd be
> fair to add it into the driver. Plus, the feature won't change
> the minimum calibration value at all -- everyone would be happy.

Stefan,

Would you please kindly give an ack to this intention so that
we can at least move forward for patch review?

Neither changing hardware resistor values nor simply ignoring
the inaccuracy is acceptable for us. Since configuring that
calibration register value can help our use cases, we really
need this setting to be available in the driver.

Guenter,

Do you have any input regarding this change? I would like to
hear an opinion from you.

Thank you
