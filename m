Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9A8C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 16:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A39E2081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 16:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCRNm/WY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A39E2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeKDBSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 21:18:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42503 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeKDBSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 21:18:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id u68so7982194qkg.9;
        Sat, 03 Nov 2018 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GeKwfLs38klEKXjhoDuszkgAjwsJgbnD3io++Ugyuv4=;
        b=tCRNm/WYv7iYW44isNbADjn33rr2QtMjFDD6NJFVZtMAiTAvbs9+3oZ0BzMbTdOYP2
         iTfjYE78G4ylRmwogFYGDt8cAbFp+tIwkcySOwO6CQ5X6Fz/jL4UhYrP+rUdVcOSNCNa
         HBkSjRrNsjGyaPGVNXWS1ChvBF8LRLNRTSrtfxslGNGrlz9/WO4aAnwqc1Lsf6rPbcBk
         6yU8PxxrJokcaC0EiZ+DD1hDl8WdtEpHS0wqIvxYsvyuxkdEgurYIFMv8h0DsTY7/azD
         /PDE0vBjQ3R6cUoYY1Yrhj4S+QNgdPw6yicok/2Kms2OETMH2Q1xcei79AC+P7E8gHpw
         AUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GeKwfLs38klEKXjhoDuszkgAjwsJgbnD3io++Ugyuv4=;
        b=XkU5oDlt9RwXqw72vf5SjOvir3sEuJDdBbeOEHBrrc2Pxd02jqb+7++/KUHeRFoRKM
         JTf+tXCX/bHLxSFdQgkMQudtGT1yVUZAgqeuhnhCUimNjcoYEXkQxfMQ99nbKNHLqNYz
         svbHsKK1TTOsziQLkbHn+pM+x5bS6a3Bo5gw75Gd2Gb4n8QungCLS+hgdZBUw1nMSA0i
         AI1ms5avEUqCt8nmGY6PPJVj09GUHbvy+37xjxGA6fnpcRfJqj9u5DLBmt0QsjTtTjrJ
         K9OfNkQ+P36RrXT0tmRuM3KCHtGXux1lUEwT61fHZ9Ar1jv6fPlGC5zSK2vW6GtOMJNw
         2rcw==
X-Gm-Message-State: AGRZ1gKRBTXMuug9PRKGmoNps1HN6Klo8FAxYx0hPOsK8ZvCrAQ9b3iw
        JTGaV8U87fZMDzASPltNnYU=
X-Google-Smtp-Source: AJdET5dplJxJKePEJAWs8tzD8rgM3fxuM/OIElo6qTSOG/XRi9nEFa/nkEznqImUp6uw6b2sfNa0bA==
X-Received: by 2002:ac8:6b8a:: with SMTP id z10mr4963094qts.248.1541261184874;
        Sat, 03 Nov 2018 09:06:24 -0700 (PDT)
Received: from renatolg ([186.220.24.65])
        by smtp.gmail.com with ESMTPSA id a68sm33106016qkj.63.2018.11.03.09.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 09:06:24 -0700 (PDT)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Sat, 3 Nov 2018 13:06:19 -0300
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v3 2/3] staging: iio: ad7780: update voltage on read
Message-ID: <20181103160618.wioq7jbdh4z5yqdw@renatolg>
References: <cover.1541082656.git.renatogeh@gmail.com>
 <1bc4bdf6342d4bc0c2fea17fb3bcd79fabf0e1d1.1541082656.git.renatogeh@gmail.com>
 <b0c6d0356b83259e1adad3bf74cca3a56ae33847.camel@analog.com>
 <20181103131002.7956a08b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20181103131002.7956a08b@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 15:20:55 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
>
> This looks wrong.
> I admit this was done in the same way in the probe function, but that looks
> a bit wrong as well.
>
> Typically, the return value of `regulator_get_voltage()` would get checked
> with:
>
> ret = regulator_get_voltage(st->reg);
> if (ret < 0)
>    return ret;
> *val = ret / 1000;
>
> So, negative values are errors and zero & positive values are valid voltage
> values.

I see. So -EINVAL is only used when sent the wrong info type?
