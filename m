Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C188FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652322075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CpMElXp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652322075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeIGTa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:30:57 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:39013 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbeIGTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:30:57 -0400
Received: by mail-lj1-f171.google.com with SMTP id l15-v6so12498269lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=KkL04uQ7tyqeWedAAB1AO3uIABla0DwHYkjcRQLfFCU=;
        b=CpMElXp7G+Avs8vEKrjuvRDIfnUDYgseJX+d0lbNTrlXZkRuW42GX1Htw4Hr4DuVs7
         6kovctupj1GzK28eGZwbCQsXSDQDSdqTrNpxcefBEJ2voyEGE3pQAl90iEoTq4CTmiQ5
         abdLPu0NBll33r85n4r67uSKWRPIeOE+30tXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=KkL04uQ7tyqeWedAAB1AO3uIABla0DwHYkjcRQLfFCU=;
        b=j3ygKqt+QO/uh/21fgdTHnEuIzNDRIaY4mAC3V320ykiut+hSqYETs3eWgsb3EERsn
         ELAEkBHT+1a4wRVyX5T2vOeU5dMfEjQYDlKm9E+HfG6181tWEUTQ0vOIrMATH9sh5IS0
         p0sx7BfRENGVOSZ49ki8OySjT6rhdPiMx+6WVh8rfj6OQknfFkYtqOsUiXHkR7/ZlozB
         goysMAAd9gaRQz8qm6DEe4Y0aOmUvQZea9gPpVcQDbS6nrilo4in0ZAdndFX4PljYH2P
         vKy4MhQGbf5J2YOCvT771tLV/UIKScUcbWGl0ZIS7dy3/0S+SSzSmBAo+LAeiEqzlmk3
         xjag==
X-Gm-Message-State: APzg51BwjSGSWMRwdU0QYMcDHoAFTZSrlvEoVk4wl/FAVZ2vEwELzEmc
        SFAOpkpZ6l/yqT9CvSgX1UWzWyOXSwJIO4M3wI9oIg==
X-Google-Smtp-Source: ANB0VdbenTIneYJBKPH26Nq+1HskgzbuTYPmv0oeQt0ObICUTli2ns7IZDUYjjqnTy1ZYGP3b3dYjlMLEvfpPItdz3I=
X-Received: by 2002:a2e:4557:: with SMTP id s84-v6mr5173210lja.47.1536331780028;
 Fri, 07 Sep 2018 07:49:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:8fd3:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 07:49:19 -0700 (PDT)
In-Reply-To: <20180906194330.GH5098@thunk.org>
References: <2e8e31f5-4db5-4907-2d09-f6444bc78ede@roeck-us.net>
 <20180906140413.GA5098@thunk.org> <CAH+k93Fgk2yZ3OzBOL2uxSVuOqEJB5wS1Zfny8bDkbuQ3sM6Jw@mail.gmail.com>
 <20180906194330.GH5098@thunk.org>
From:   Matt Hart <matthew.hart@linaro.org>
Date:   Fri, 7 Sep 2018 15:49:19 +0100
Message-ID: <CAH+k93HFi7njDrKDOXxZG0gfNUfATfKafwpF7Exjff925to3mw@mail.gmail.com>
Subject: Re: Widespread crashes in next-20180906
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matt Hart <matthew.hart@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 September 2018 at 20:43, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Thu, Sep 06, 2018 at 03:13:23PM +0100, Matt Hart wrote:
>> On 6 September 2018 at 15:04, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> > On Thu, Sep 06, 2018 at 06:45:15AM -0700, Guenter Roeck wrote:
>> >> Build results:
>> >>       total: 134 pass: 133 fail: 1
>>
>> Do you build arm64? Because KernelCI is seeing build failures in arm64
>> defconfig for next-20180906
>> Clearly it's a module build problem for sunxi but I'm not sure who to
>> CC about this.
>>
>> https://kernelci.org/build/next/branch/master/kernel/next-20180906/
>> https://storage.kernelci.org/next/master/next-20180906/arm64/defconfig/build.log
>
> At a guess, from the MAINTAINERS file
>
> ARM/Allwinner sunXi SoC support
> M:      Maxime Ripard <maxime.ripard@bootlin.com>
> M:      Chen-Yu Tsai <wens@csie.org>

Seems they are already on the case
https://www.spinics.net/lists/arm-kernel/msg675227.html

>
>                                                 - Ted
