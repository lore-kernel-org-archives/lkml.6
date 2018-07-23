Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC63ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0B720671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsAUaKsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0B720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbeGXAGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 20:06:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40852 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbeGXAGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 20:06:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so382290pff.7;
        Mon, 23 Jul 2018 16:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8YuSo8l5T0fzw3MoG2HKB9cgL+OBJDSqtsLt/ZgULRE=;
        b=DsAUaKsquKClUMeZmy01P1pjm9UgFBdcZZyFCThPvpHW+tUwmTOLow5PxBzEiq0sna
         04VLlteC2DWCPzR7KepMUbbEf0DmkaGFsR+SSbo4xtwlCWi/WpLsMpxp3GP/v1ukUjxg
         FOlhomtPzlghcizxgpuIPmT/9zlaLbjnSQX2fIkMW1xqA3HNueswgUakotYTdMVKXJVI
         5qWa9NLVXewOtIEC9OWwLNUDif0b4jcf9N6fZzMFJvFZWTN9A/NF6v3xUJNG4gBNeX9l
         7WJox8MGujipV7vtU2l9l4EDyE3iegYFtWmECYNYGLGlh8DAPglcJ/zWiXyHPzyKDphv
         xRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8YuSo8l5T0fzw3MoG2HKB9cgL+OBJDSqtsLt/ZgULRE=;
        b=N7JyR9qZVxdv4NVabiHlpkr9kc2MwktysvIkNaHuRLqy1TNgU4+0gylAVNywdLUpX5
         /1gw4Yd4AAd8oCM6UoI7NQ5hpbA7m+MWGEHXJSc5SXfI2/Cj5J75nP+G0Pe+qzgq3Mao
         xSUDAU2aEalAP6c/oprTOEgLiLN1OsOru2jjbY2H101TEd4RgeRAmjgQD34OwqtJ1jB7
         oOetAFUR1HynJgZ6YngUR6kdJtAR686mtJ9DKOFw3ft/ZuEzLh/kWQVTVQlT+/PPKOvA
         H4kRRivuztDpNU0dTlVKUdsUMJp32deA6j9XTKBcNOwZVQL4Nuo5PGIV8AqdcQTI/h5y
         CPIw==
X-Gm-Message-State: AOUpUlGe13MPlbVJL7w0etTuXN3vRJHjMZKx00o8DhsQD4BYGA2rUQ8r
        tdxncpiAzjVmnI0OUVedBqQ=
X-Google-Smtp-Source: AAOMgpep085fH2pRiH1WnhzdrO19xs4rXD4Vc0UBMnP7PjVAJvVaxgqVkyIafqMK68fZjIRC4Vu5QQ==
X-Received: by 2002:a65:498c:: with SMTP id r12-v6mr14250684pgs.112.1532386965071;
        Mon, 23 Jul 2018 16:02:45 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id 77-v6sm13255381pga.40.2018.07.23.16.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 16:02:44 -0700 (PDT)
Date:   Tue, 24 Jul 2018 04:32:37 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     David Frey <dfrey@sierrawireless.com>
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4] iio: chemical: Add support for Bosch BME680 sensor
Message-ID: <20180723230237.GA2653@himanshu-Vostro-3559>
References: <1532122284-19602-1-git-send-email-himanshujha199640@gmail.com>
 <20180721161934.75066d97@archlinux>
 <20180721153607.GA11127@himanshu-Vostro-3559>
 <CAHp75VegzWr8Q2idzAWpc5Nw3T5n=vWkMvspe0YGRwEQ_h0p+A@mail.gmail.com>
 <CAEnQRZC80FWN9EADvE9geu773=vwRmE0JEwSfy_DMjig0d=qqw@mail.gmail.com>
 <20180722222153.GA10066@himanshu-Vostro-3559>
 <a1c8c770-18b4-1722-2672-ee0e8abab611@sierrawireless.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c8c770-18b4-1722-2672-ee0e8abab611@sierrawireless.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 03:16:10PM -0700, David Frey wrote:
> On 7/22/2018 3:21 PM, Himanshu Jha wrote:
> >On Sat, Jul 21, 2018 at 08:45:34PM +0300, Daniel Baluta wrote:
> >>On Sat, Jul 21, 2018 at 6:43 PM, Andy Shevchenko
> >><andy.shevchenko@gmail.com> wrote:
> >>>On Sat, Jul 21, 2018 at 6:36 PM, Himanshu Jha
> >>><himanshujha199640@gmail.com> wrote:
> >>>
> >>>>>>+   /* Look up table 1 for the possible gas range values */
> >>>>>>+   u32 lookupTable1[16] = {2147483647u, 2147483647u, 2147483647u,
> >>>>>>+                           2147483647u, 2147483647u, 2126008810u,
> >>>>>>+                           2147483647u, 2130303777u, 2147483647u,
> >>>>>>+                           2147483647u, 2143188679u, 2136746228u,
> >>>>>>+                           2147483647u, 2126008810u, 2147483647u,
> >>>>>>+                           2147483647u};
> >>>
> >>>This one needs perhaps a bit of though, but...
> >>>
> >>>>>>+   /* Look up table 2 for the possible gas range values */
> >>>>>>+   u32 lookupTable2[16] = {4096000000u, 2048000000u, 1024000000u,
> >>>>>>+                           512000000u, 255744255u, 127110228u, 64000000u,
> >>>>>>+                           32258064u, 16016016u, 8000000u, 4000000u,
> >>>>>>+                           2000000u, 1000000u, 500000u, 250000u, 125000u};
> >>>
> >>>...this one obviously just a not needed one. You may replace it with a
> >>>one constant and simple calculation to get either value (index from
> >>>value, or value from index).
> >>
> >>Indeed this can be reduce to:
> >>
> >>125.000 << (15 - idx).
> >>
> >>The real question here is if we approximate 255.744.255u to 256.00.00u how
> >>much different is the result. Being a gas sensor I think it is very
> >>hard to appreciate.
> >>
> >>We can go with this formula + adding a comment with the table with the
> >>exact coefficients.
> >
> >So, I have planned to use this 125000 << (15 - idx) equation with
> >approximating the array members.
> >
> >About the difference in results we would get after approximating isn't
> >much of a problem IMHO because gas sensor is primarily used for IAQ, and
> >IAQ is relative to the resistance reading.
> >
> >For eg:
> >
> >Resistance(ohm)			IAQ
> >value < 30K			Very bad
> >30k < value < 50k		worse
> >50k < value < 70k		bad
> >...
> >..			
> >so on..
> >
> >So, what I simply imply is the scale will be adjusted and nothing else
> >changes, unlike if it had been pressure, temperature, humidity.
> >
> >The IAQ implementation is userspace application suggesting
> >good/bad/ugly air quality.
> >
> >And since we know David Frey is planning to use this sensor in his
> >product mangOH board.
> >
> >So, David, how are you planning to use the gas sensing part in your
> >product ? RGB leds, buzzer, alarm ?
> >
> >Thanks Andy for the suggestion :)
> >
> 
> My understanding is that the Bosch BSEC (Bosch Sensortec Environmental
> Cluster - https://www.bosch-sensortec.com/bst/products/all_products/bsec)
> software calculates the indoor air quality (IAQ) which is presented in
> the range of 0 to 500.  BSEC is proprietary, pre-compiled static
> library.  I don't know how they derive the IAQ, but it seems that it
> could be based on smoothing outlying gas resistance values and integrating
> other values such as temperature, humidity and pressure.
> Unless this driver can somehow produce IAQ values of equal or greater
> reliability to the BSEC library, then I would prefer that it just
> present the raw gas resistance value so that a user can write a program
> to feed the sensor data into BSEC.
> 
> mangOH isn't really a traditional product.  It's an open hardware board
> designed around Sierra Wireless cellular modules that run Linux.  So I
> don't have any specific use case in mind, but I want to enable our users
> (and thus future products) to make use of air quality measurements.

I tested the gas sensor with the new bitshifting equation and didn't find any
discrepancy in the resistance readings.

Even I don't know how Bosch implements IAQ algorithm, but one thing I
got around testing the sensor was that the air quality is inversely
proportional to resistance value.

[You can try it yourself, by spraying deodrant/aerosol sprays around the sensor ;)]

But we shouldn't be worried about such issues since these should be handled
fine with the userspace application and depends on the implementation.
We only need to focus on exporting data.

Anyway, thanks again for your time!

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
