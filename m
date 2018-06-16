Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08DFC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 04:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439C020862
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 04:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aARU2o3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439C020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeFPESn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 00:18:43 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51925 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbeFPESl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 00:18:41 -0400
Received: by mail-it0-f68.google.com with SMTP id n7-v6so5427747itn.1;
        Fri, 15 Jun 2018 21:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N65+VfC9Ych37/UwJIYOfH6L+nsLEVu5b5iuvweFNcE=;
        b=aARU2o3ygVvQH+pfVc9HSnqbKyjG5LuUvrgazFSZtxv5Yc28gGKw8jyZ0JQo7qSgbv
         2tlbTtRgpX0N++eZ/LunljR1oavTVY0HV7aKucltEHzHSudS3R8BQ/MelwD3umrZekzx
         bg2HAvFn/YUvUayxc9WXp9EtmbsXMJ+r/PrMHGK4BSznBImsPkz3Bmg4G7as18ctjIyk
         FKdn6WdZH0cfNhBSTmTDA0V0qk/5MFoUmwCQ46HSnKvAnu0AKnEFumn+Lp+t9eCUdulG
         sizyyN40bJAmp8wlB/jlwrBv57JFoDcS7TX8tHlah86jAB2zatEFF1tEmLLaQzdfM77l
         osZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N65+VfC9Ych37/UwJIYOfH6L+nsLEVu5b5iuvweFNcE=;
        b=T5875xnFkrf+pRkfIBKiuIpzrbGK/rKF6b1qGhiOqLA7780pAhwGzupd02sfquA0or
         zTjiwLCqF3oUFT5ZI8bk+JkabWnvAJSWMPAZlaztwQPwuA9tfuOYD3eZNkK2u3xcBjbP
         aNYv+t1rBrk6xL51tOijLCMWoteDS/e2Ku4BWJncM+BIWZg6I8tq7w/rCvrSoVVfXRCg
         QerTXPAF+Rsn38umso1zG4BYk9FzS9Mui9grQZ0a1IS6KjCpoJOGBkSdCKwlaoqiSCBh
         8Edu5hiA4ah1htudDQgSEjXbB4TK65OvAsoxDrw7baMVazt7DEd7p2VF2uUQia+nab18
         7L2g==
X-Gm-Message-State: APt69E0lUiHVMxDp+pGzbiw01XRAKnP9adtdFOCin6Ecy73JhAgCI8zV
        3H21L+ND2iTSEFB/bttqCimzbcDgCzs9agJ+p9M=
X-Google-Smtp-Source: ADUXVKLOPR6uDQjkVB3t5bgk5bdYnMYWXKzygyWDYmzTPIZAHE1e/O2QH2cSeL3m+onUSHWDISPUayqBO0mF8VKrmd4=
X-Received: by 2002:a24:f007:: with SMTP id s7-v6mr3646666ith.15.1529122720507;
 Fri, 15 Jun 2018 21:18:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:c807:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 21:18:40
 -0700 (PDT)
In-Reply-To: <20180615110228.GA3107@kroah.com>
References: <1646985.m1Qjj59is2@joonhwan-virtualbox> <20180615110228.GA3107@kroah.com>
From:   =?UTF-8?B?6rmA7KSA7ZmY?= <spilit464@gmail.com>
Date:   Sat, 16 Jun 2018 13:18:40 +0900
Message-ID: <CAO-p-6Bw9N72TGvuF5vg34csZZHwjxN3i3DB4pxXDZLiAcFvGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: mt7621-spi: change indentation from space to tab
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Neil Brown <neil@brown.name>,
        christian@lkamp.de, blogic@openwrt.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi greg,

I didn't noticed that. :(
Thank you for your attention!

Sincerely,
JoonHwan

2018-06-15 20:02 GMT+09:00 Greg KH <gregkh@linuxfoundation.org>:
> On Sat, Jun 09, 2018 at 03:03:27PM +0900, JoonHwan.Kim wrote:
>> * fix checkpatch.pl error:
>>   ERROR: code indent should use tabs where possible
>>
>> Signed-off-by: Joonhwan Kim <spilit464@gmail.com>
>> ---
>>  drivers/staging/mt7621-spi/spi-mt7621.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Someone else sent this same fix before you did, sorry.  Same for your
> 2/2 patch :(
