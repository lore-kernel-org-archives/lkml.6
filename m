Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559FDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2489F20868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLXvPzaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfAQXQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:16:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41932 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfAQXQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:16:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so5563730pfi.8;
        Thu, 17 Jan 2019 15:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z2Qiq0Ed588WGoXnC05hwrw0bSJ0AT21Dhu9rJ7m6Xo=;
        b=sLXvPzaEhjKQfTb9+vpI/ouwGnfbEkqvdmUaVSgtOBqBud546z2SBrKkj3ZIB8eCjK
         qFMWnDu/JRVEKjBqWycfD9d8eOuPQs7nQortz2QdluO5dqCJa07e8Z4CohOLuVa0j4NE
         578RA6TS/I0R4vT2sm6OXewIbWN7G0dcQVApEuy8YtgWWsgMV8nfecyKNVj88ERr7Hut
         HYb+hgjtwsZV/a5p2ih1fTc9j1dMWYzVMaKW++dpoI7XM5SLOpRV7N1FcCyzlf8vuH6W
         ggfsJPT7FRAfixAXA8JLT6XKWSQfTrctEAKR9MiWRcskqkm5ehLOCRdSgsxIFsVyKYBJ
         YwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2Qiq0Ed588WGoXnC05hwrw0bSJ0AT21Dhu9rJ7m6Xo=;
        b=caaOEqOwRb7WDIcmKlxZ+k2OnNCmpJ7IUs9kVdUXR2taAm45lhqn7CLOeixUgdT844
         G0E0cR0ulinUuCjHDHvwuVfQNhZ+wxk/2bdYP9GI+Y/BjqPat4DEODtGE/ogS3+4c6uq
         ExTs+p8TvaWFnJBzQQS6uuZjV1eTBICQ9VohoVoTZIewSHPuibf0CWpIAnmAaEG5MRmI
         MAaAPakhtJjvb62YRsZetk0sSZY8UdXqhQ0U85QgndmcwLlws+fin5zP2AomViFn0Eyq
         C1TNqFSb+m/JY3adh4VtFBko9uY9NOj9O2vVdpUK8DdU4/wXrLpUTG37I0VfoFXQxTQh
         IoLA==
X-Gm-Message-State: AJcUukdDK16XBt7OjqBkGKP4O6mOlATPqyiX1eMSUi8JNcJfnIUUxYJg
        pI5AkCYAeEjji3GNAoGj5Uc=
X-Google-Smtp-Source: ALg8bN4leVLb42zsC8U0ccMYFCDWtoLfSKM/fX3V4FAF2HoRLYrIvdDiZ8iMZDvioiEPmeauQaWXVQ==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr15142445pgh.265.1547766987223;
        Thu, 17 Jan 2019 15:16:27 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id y6sm5685597pfd.104.2019.01.17.15.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 15:16:27 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:16:22 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     =?iso-8859-1?B?QnL8bnMs?= Stefan <Stefan.Bruens@rwth-aachen.de>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [RFC][PATCH] hwmon: (ina2xx) Improve current and power reading
 precision
Message-ID: <20190117231622.GA9310@Asurada-Nvidia.nvidia.com>
References: <20181121012629.5432-1-nicoleotsuka@gmail.com>
 <2863036.QIPGp1Eqjm@sbruens-linux.lcs.intern>
 <20181121194051.GA8902@Asurada-Nvidia.nvidia.com>
 <1717545.GXSegKtrMu@sbruens-linux.lcs.intern>
 <20190105012642.GA18025@Asurada-Nvidia.nvidia.com>
 <20190117223828.GI16918@Asurada-Nvidia.nvidia.com>
 <20190117231323.GB23511@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117231323.GB23511@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Thu, Jan 17, 2019 at 03:13:23PM -0800, Guenter Roeck wrote:

> I have one claim stating that your change won't make a difference,
> and your claim that it would. That leaves me with no choice but to
> spend a large amount of time with the datasheet, and possibly with
> my evaluation boards, trying to find out who is correct. Unfortunately,
> time is scarce to come by those days. I would very much prefer for
> you folks to sort out your differences and present me with a single
> opinion.
> 
> Long term the best solution would really be to replace the hwmon
> driver with the iio driver and use the iio-hwmon bridge. The ina2xx
> driver doesn't support limits, so there is no real benefit of using
> the hwmon driver over the iio driver, at least assuming that the
> iio driver supports all the attributes. So maybe you should make your
> case for the changes in the iio driver.

Thanks for the input. Let's drop this hwmon change then.
