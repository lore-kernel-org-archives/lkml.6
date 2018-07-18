Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE1DECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE8720673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aDSthZTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE8720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeGRRL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:11:57 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34454 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731314AbeGRRL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:11:57 -0400
Received: by mail-it0-f66.google.com with SMTP id d70-v6so1350908ith.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4zMX4aMswhPipQ6b/Kzn3AMVk3gE3aZ67GkH+akNITA=;
        b=aDSthZTpjT31MurLSGt6Sayil5gclS6Pp/Y7KdAdPUBlhuyqPg8Fd+OEALbaj8oenm
         grxddqROnJIoZcWZfUEKz2n8/EEtjVl5jbHoZtd48/jHtu+EXq44WnIUOcxvsUgy08xb
         0Q3bLZtSGjjXurIBrdt2lTAjQpB2D42hZ/e3/jhO+Lka1BDtqbYtAdoVEDTmaVSZsig6
         iLK1k0NH5ghfiTg1kLQLnu3iolbZZ36mRSKx9Sk/m/1KmuDjCXZOCRhQkxyt5tcq8kFJ
         oPsXE1PRsB/I7Fn6CxfvpTReTEwjpP2uAWgDFvug4o67Ls1P3XNan/xZmkRxS7XJ5rUm
         gB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4zMX4aMswhPipQ6b/Kzn3AMVk3gE3aZ67GkH+akNITA=;
        b=qHUO3tGHzviAcG3x1dsCtH2QX31nQM8xTpz66+gzMkGRd/P17T9nqtA3gWloXGapJs
         X9F+RrdVCAkj5dFKspTQPp/ZSLDib7ouTrJjfGfZdhvmGLqUjr2NVIZhu2kOcMWEja/E
         soTbu2ZHjTOKozVXE5jClVPzr1BQU6sjBxxheFJ/+wI3MKK37Zgz0wfmWAqKJWTmdwmB
         O0G87sl6ITOiGS5GKZg2mSo2Ynk881PwvN+quyEMAPC9Fe3wdSbtf3rSDYEjUvV09+R9
         0ZTvlsRtzKCDx1X3wnfO8Rn9Gp++6SyzDn9BlUvX3twtPIBEj2tLZ+eyvxj4bySplxF1
         yRJw==
X-Gm-Message-State: AOUpUlFaAgrakBrOB88jOCJ/lgwjugKNAqJT9AeHgWeQX25bYE6V2xz1
        5NocVzauG+tLgpjQsSsDYCo3O6lNVU4Egec3bEOkeA==
X-Google-Smtp-Source: AAOMgpejP5w4XXHKGQfr2GDtc5f+XzBLqGld2YDpQJG8Ybg+AA5rpY6ZlBKJ95yoBaIeZOP0Hx8ElMs0tyrRjHChuwE=
X-Received: by 2002:a02:b70b:: with SMTP id g11-v6mr6282458jam.34.1531931595176;
 Wed, 18 Jul 2018 09:33:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 09:33:14
 -0700 (PDT)
In-Reply-To: <20180718163109.GB12477@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl> <20180718161035.7005-3-brgl@bgdev.pl>
 <20180718163109.GB12477@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 18 Jul 2018 18:33:14 +0200
Message-ID: <CAMRc=MdiathiQjh2AuwU2X8DuinCpEhHxix050qXqBLfrX2A_w@mail.gmail.com>
Subject: Re: [PATCH 2/5] net: add an info message to eth_platform_get_mac_address()
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-18 18:31 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, Jul 18, 2018 at 06:10:32PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Many drivers that read the MAC address from EEPROM or MTD emit a log
>> message when they succeed. Since this function is meant to be reused
>> in those drivers instead of reimplementing the same operation
>> everywhere, add an info message when we successfully read the MAC
>> address.
>
> Hi Bartosz
>
> This makes eth_platform_get_mac_address() generally more verbose,
> which i guess people won't like. To keep it backwards compatible, it
> would be better to issue the message just when EEPROM to MTD is used.
>
>       Andrew

This function should be used at most once per interface - I guess it's
not like it's a huge impact on verbosity.

Bart
