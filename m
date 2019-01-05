Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C077AC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAB621871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW/9IznH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfAEB0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 20:26:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34118 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAEB0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 20:26:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so18163781plz.1;
        Fri, 04 Jan 2019 17:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vYqZdkMKi7Jgfl1eWfMElua+x0asDiHZJv3Enjj0O0Q=;
        b=UW/9IznH+QOWJor/WFFVUVP4d61GoX9y0KuoXyro0Ul/QcwVX3ybV1YLVECryjTPZW
         1lFziFne3QN+lLuAuMGX5maioi3SkT0UNsJiW/HF7PW+roqEHiTpgcECkxauNpawFTUS
         M72yrO/61vReoVIKjmqYu4Ey76Xf3u5vgFHYKUfLDrm/IG7DqhYcs9x5ncwkRU4YV2k3
         8KuPw8bBLBZWdgC76x0FgwT77B2OqvX5LN2GBo/yQ0HGD4V48pfO4EeOt5lAJVf1ytUi
         eSpvCP8oHdXhmV21KbeIaVCGfWGZoLRitXB88zTUUh2FOSxD2AHCKkLQrzimvg0wg3hI
         vgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vYqZdkMKi7Jgfl1eWfMElua+x0asDiHZJv3Enjj0O0Q=;
        b=HEyi/XoQHo2KNg/ECRQCb2Aybg8mdCEU+b1JBWenFnurRz0jHlsBQRYVXBLFMHDrcn
         HBIM9R4ouX0vyyGMT5H+dtJylbXqtOV7onTsLObz0FDU3Z8lKOO9g9LsCsebRH0ycppJ
         aC2Bt3iVcV+61stnTNybL3LqQb1oyyOKCzIVog5/8H4Md0il6a4gkwzbKRgcsALm12LG
         2OWxtq4pN1Szv5n6p1ZpxjhFve3VQUJWy5F28VovOUtml7jPKwFZUJXxab6E33eQlEo3
         /rW0vtFEHyWdKjz73mS35Al/x/L4bXEnD7qzUFiO8FTSgSjhCdA/aIPQyNXN+wz6DwKw
         /fOQ==
X-Gm-Message-State: AJcUukdVzi9cerr2PHZUr+6oEmeX56DnR3POY2yYnRxGffU8UJlaXqiE
        loKDYfYVmpzkovGkYWMQBus=
X-Google-Smtp-Source: ALg8bN6GoUmq8erY41K7ewa9DpdAVF1qLJOHRoFH5rn2zhqeJxKxrV+7Gg+VudilCgPD1Ul1IHxf2A==
X-Received: by 2002:a17:902:9b87:: with SMTP id y7mr36564554plp.336.1546651608245;
        Fri, 04 Jan 2019 17:26:48 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c67sm77148549pfg.170.2019.01.04.17.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 17:26:47 -0800 (PST)
Date:   Fri, 4 Jan 2019 17:26:43 -0800
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
Message-ID: <20190105012642.GA18025@Asurada-Nvidia.nvidia.com>
References: <20181121012629.5432-1-nicoleotsuka@gmail.com>
 <2863036.QIPGp1Eqjm@sbruens-linux.lcs.intern>
 <20181121194051.GA8902@Asurada-Nvidia.nvidia.com>
 <1717545.GXSegKtrMu@sbruens-linux.lcs.intern>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1717545.GXSegKtrMu@sbruens-linux.lcs.intern>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Sorry for a super late reply. I took a long vacation.

On Wed, Nov 21, 2018 at 10:16:09PM +0000, Brüns, Stefan wrote:
> > > Another concern may be voltage drop over the shunt, but for this case you
> > > have a nominal voltage of 1.8V, so 30uV are 0.001%.
> > > 
> > > > When measuring a 1.8v voltage running a small current (e.g. 33 mA),
> > > > the power value (that's supposed to be 59.4 mW) becomes inaccurate
> > > > due to the larger scale (25mA for method A; 62.5 mA for method B).
> > 
> > Just found out that I have typos here: 25mW and 62.5mW.
> > 
> > > Another look into the datasheet reveals, even at full gain (PGA=1), the
> > > LSB is 40mV / 2^12 = 40mV / 4096 ~ 10uV. So when the current ADC reads
> > > out as 3*LSB, this anything between 25mA and 35mA. This is the best case
> > > figure.
> > Current read doesn't get affected a lot actually, since hwmon ABI
> > also reports current value in unit mA. However, the power read is
> > the matter here. With a 62.5mW power_lsb, power results are kinda
> > useless on my system.
> 
> The reported current does not matter here, actually. Internally, the ADC value 
> will have an uncertainty of 10mA (at PGA=1). At 1.8V, your uncertainty is 
> 18mW. And thats *only* the quantization noise. It wont get better than that.

The fact is that I do get better power results after setting the
calibration value to 0x7ff. That's the necessity of this change.

> Also note, you are apparently using the ina2xx hwmon driver - I strongly 
> advise against it, you should either use the ina2xx driver from the IIO 
> subsystem directly, or use the IIO driver via iio-hwmon.

The IIO version is also using the minimum calibration value. It
will not solve my problem here.

> There is also always the possibility to read the bus and shunt voltage 
> registers and calculate the power manually.

Won't that be a waste since the hardware could have provided a
better accuracy? It would need more I2C bus reads and cpu cycles
for calculation.

I don't get why you're against a setting for calibration value.
This is how the hardware got designed to cover different cases.
Since we do have such a case that needs some accuracy, it'd be
fair to add it into the driver. Plus, the feature won't change
the minimum calibration value at all -- everyone would be happy.

Thanks
Nicolin
