Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F97CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCDD218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W96qr3HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbfBARzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:55:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41629 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbfBARzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:55:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id m66so1191836qke.8;
        Fri, 01 Feb 2019 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mJ7jNsfeOz0MY1JlVhpOEDzDLyvdTgVqAvz5ywe12Ok=;
        b=W96qr3HU5wW7Gw0J5ArhtS6msR9h5pTpwtfiZH5exkuHqLZusdeI68H84nUlwzCF76
         XQO7Ib8p3RTGxOfTqzvJFKkt9d/tiPmoQLkkC24s7XD18CasxH6Az6TOLMTwv7VRBFg3
         8GQamZZL+mV7AGr3GbLypiD0Q76R/lIJCqvu4VZTbU2Lf4zgdTzI0cY82ZuGqtZal5PR
         1Ckkps1mIt5C3FC12dALcT4OmkjPdm85GiSiar1ztt94tj9I2eYcu3jPDbpYr3Pb+Vvh
         TrbFclFzeTEB49tDjjHIuon5mN25HYjV4jgse7aXU6r4KSkfoMlHOgUD9t/m+UKXLbMk
         8v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mJ7jNsfeOz0MY1JlVhpOEDzDLyvdTgVqAvz5ywe12Ok=;
        b=hUgRQMC3K/GsFdslNZpPGh2afjK7t16Gl/rqO+yQdm/PxVdmbdRO5PNfnfdUgfnx6u
         oRL9JU635omjGbVn9pkSbuUPPgKklJmsZll5U536BzukO2nbTJ2Exf9xg9Vay0Rke+OX
         6O28uecLnTWtGzk7orZCbDKsHgd/3LM9KsvD0mBcZgT5pyPtE6MD1WtBjZKv2eY2fPDS
         gKxX9qfN63Uj4Dn0n1A0LrUICqhiUQ1kwrtYtBYPy4AP5YCEXK3agVlWMG/FiJx8rUdx
         Vkt9WTlwMu3TUfq1MebPIS/q84JhR+T34+I3knEd3fECJyWoiAUVWFnLnYtlkggW8VtK
         3JDw==
X-Gm-Message-State: AHQUAuZvooVdRoh5W7q9t+sgmb0oCjvhVpxDGqTBhqycgttIONxS7Xr2
        w9+bKGnaLLxrOI3EGYbq19c=
X-Google-Smtp-Source: AHgI3Ibl+gBuRsqRz5uuAOi2ssX6eRVHqugag++ARzCNolT38qaL2L6ilseAf42t/Cl1TXWeZkntSA==
X-Received: by 2002:ae9:e90e:: with SMTP id x14mr3740603qkf.242.1549043721829;
        Fri, 01 Feb 2019 09:55:21 -0800 (PST)
Received: from renatolg ([191.180.131.98])
        by smtp.gmail.com with ESMTPSA id k62sm6133035qte.86.2019.02.01.09.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 09:55:21 -0800 (PST)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Fri, 1 Feb 2019 15:55:16 -0200
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Cc:     "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: add gain & filter gpio
 support
Message-ID: <20190201175514.7kerqvuln4mrhinp@renatolg>
References: <20190127203044.yytctplecwey4an4@renatolg>
 <1548850985.9460.23.camel@analog.com>
 <20190201145459.ukfzo6s4rvg4c5ri@renatolg>
 <1549036667.9460.41.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549036667.9460.41.camel@analog.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01, Popa, Stefan Serban wrote:
>
>Adding support for gpios, normally doesn't have anything to do with
>the information stored in the iio_chan_spec struct.
>Also, we need to try to work with the already defined attributes. In your
>case, setting the gain GPIO is equivalent to modifying the scale, while
>setting the filter GPIO results in a change in sampling frequency.
>Therefore, we need use a macro which has the IIO_CHAN_INFO_SCALE and
>IIO_CHAN_INFO_FREQUENCY flags set. I think AD_SD_CHANNEL should do just
>fine.
>I hope this answers your question.
>-Stefan

It does. Thank you. :)
