Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19758C6369F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF78E2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdjqUq9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfASTJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:09:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33767 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbfASTJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:09:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so7858863plo.0;
        Sat, 19 Jan 2019 11:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g573yFdUR1QNOETBR14gICrLdrm+mrhO4U/KSc359pE=;
        b=bdjqUq9YJ2AhXplULFqO3qM4/9qV9N2c/kplMqW9qnfzFGXHOAH1gPOq1AnvArNCBR
         ECvf+7zsiJImkMR4lWD52RU4HOb9+BVLghdaoQXK/U6zmMEXH/TMEFkaxoRFBalvoSyB
         sYATkWvKcYpuyNiwoiXsK0IJERGdl6loNSDmQNs8s+93jhTGsL8W7mSG4UglHnlpxEPd
         HxH7odynuu6n0ldomtx/tECU8U0UfEs01N9YHfRrBV3yrCNmMVy18AcfA1QqnmmA2fPg
         AZ7QbDbJNwZvmSIUahGAa9mE0svNW4lJoirRyyOlVg3TMsvpn27E6buJbRtVRuHneQ0h
         gbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g573yFdUR1QNOETBR14gICrLdrm+mrhO4U/KSc359pE=;
        b=bx3NVgryZxpAgxqF/8onvyXgWZKXKNU8ZQ1NwYs91/pxY3YDpCWNuH6v3InkVGGs15
         +JqEDkLD3tkUtA+FZgmI+fzLKzTGDD70MZVSE1hJHg74ZZMSL+yBupcxdTbIs0sW2Rna
         ufklX7Y/QTgsgCaqUo88ePEIpiJPfwPbb5T1KpddtAwg7bomc0rIQk2+mbApKQEi+b/p
         wSY9lHApdVzz2jVxJTgutWnxh+OJRImlMuV3Lchgoj2Ntb0NtWejGq9aOnaGOcXU+RIM
         +l4vTLvQTsBZL9UjK8KJT7YYWqOe35ESBSmjWxIAzrYSo5rjxzSmi063Yv7zMyMgS26F
         XikA==
X-Gm-Message-State: AJcUukd3ev0R4nlEoSNikoUjgB9vuogpt3VpScSu4UM8PdzTHfNAuI0w
        E9NMXenF3zWvEs+6nlAJK38=
X-Google-Smtp-Source: ALg8bN5AcI7YFFPd1MPvZQYTUu7oZoSnHBBoFtDySdqswi8colUhavQJFRXNFNmYL+jGjf6xKgwcgA==
X-Received: by 2002:a17:902:42e4:: with SMTP id h91mr24263235pld.18.1547924964929;
        Sat, 19 Jan 2019 11:09:24 -0800 (PST)
Received: from Shreeya-Patel ([49.33.214.52])
        by smtp.googlemail.com with ESMTPSA id x127sm14997857pfd.156.2019.01.19.11.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 11:09:24 -0800 (PST)
Message-ID: <6996e2140ecff930497469dbf0d8b35098b94f4f.camel@gmail.com>
Subject: Re: [PATCH v2 0/3] adt7316 regmap implementation
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 20 Jan 2019 00:39:18 +0530
In-Reply-To: <20190119190440.71dd0dd9@archlinux>
References: <20190119183932.14321-1-shreeya.patel23498@gmail.com>
         <20190119190440.71dd0dd9@archlinux>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-01-19 at 19:04 +0000, Jonathan Cameron wrote:
> On Sun, 20 Jan 2019 00:09:29 +0530
> Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> 
> > This patchset consist of some initial patches for heading
> > towards the regmap implementation and also the final patch
> > which enables the driver to use regmap API thus removing
> > the redundant and common code.
> > 
> > Shreeya Patel (3):
> >   Staging: iio: adt7316: Remove irq from bus structure
> >   Staging: iio: adt7316: Remove multi read and write functions
> >   Staging: iio: adt7316: Add regmap support
> > 
> >  drivers/staging/iio/addac/adt7316-i2c.c | 101 ++--------------
> >  drivers/staging/iio/addac/adt7316-spi.c |  95 +++------------
> >  drivers/staging/iio/addac/adt7316.c     | 147 ++++++++++++------
> > ------
> >  drivers/staging/iio/addac/adt7316.h     |  15 +--
> >  4 files changed, 103 insertions(+), 255 deletions(-)
> > 
> 
> Hi Shreeya,
> 
> I'm not seeing a change log for any of these. Please make sure to
> add one so we know what changed since V1.  Saves a lot of trying
> to remember things from a while back!
> 

Sorry, I forgot to add it. I remembered it when I had already sent the
patches. 
I'll also cc Jeremy in V3.

Thanks

> Thanks,
> 
> Jonathan

