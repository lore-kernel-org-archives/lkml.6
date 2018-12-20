Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E5DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B841621741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Io0V6Lrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeLTK7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:59:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36274 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbeLTK7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:59:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so1255855wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 02:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Gb1a4X0DGjBBi9NCh9cRqq9b+CydrwkAZZzWu/X2bjs=;
        b=Io0V6Lrtq7pSn5XH78Avubl6ZsikzVvdDKd3oQXV42HqMvQDz5QzeaVjxm970susRQ
         F1HwbrumPPs8gO6DmlCuvfd8Q7hFIpj0sUO19flioxBypjz1hxrieA57sP4pTBKbtelb
         iEwO0hF1f6hXvN1SFxCQSvPfmwQLBqkitMnzkPM0jcH28n8T2hPHbVx3z9PX2k3VBMAa
         sVXZy6Mfu3GUMNMzFaAiVDcPhTKQCnzkFUkEMMHnXLgqwrf1VGO0W8UTMzn+xEorXLIJ
         yjqRWHvP3Ki66SCj2x/1xU/6UvSAfnM+pDbUj2Jh04UG1uDY6oyGecfW236u3X7IWrMN
         NEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Gb1a4X0DGjBBi9NCh9cRqq9b+CydrwkAZZzWu/X2bjs=;
        b=XGp+7qLSfF1cyCsIxJFuPCSgxo8EDXhUHEA+/h+PYW/yJiAFlB5BYakPVrt/WTDQc+
         hgAKfuvtYIP484H4GCLE2OzPIAhpTgIcowRbFEDf6Y8HAk6nCb5eL3CyAZ/rmC1GLey+
         TST2Z1XPoW6wRU9AX5/fUyovYTWdQkzatRY+72hpPnhTvGvFJ7tLoetoNBt/y/+QZa1x
         Etj7hkQV+jFTJyxbJQqTID2tGUGMi5V7T5SmsOcWzk2ic2RT6fAWGbpWK0RF1JmSwTfQ
         B4IYbrA6QVO2vCiC8qsZphi8rg0QaXpriuCALyElYNDULvAYtcgBnDhgNVidqWwvakHK
         IEaw==
X-Gm-Message-State: AA+aEWY256HanFLNW+TrRd3RX/zYoiCxo+YH8IgsAPQeXW2y3IcrnOkP
        bj3IKJXXpBwzWsW0KiZlfh6zQA==
X-Google-Smtp-Source: AFSGD/Xx57+kzrlvLsTyKwdzkUXWuRmhYyOOo3dvFGB2aM4dvmxbhdleqI10F6rYfI1xW9cMr3fO3Q==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr23170143wrv.330.1545303561466;
        Thu, 20 Dec 2018 02:59:21 -0800 (PST)
Received: from [10.253.155.119] (x2f7fb77.dyn.telefonica.de. [2.247.251.119])
        by smtp.gmail.com with ESMTPSA id v132sm7248666wme.20.2018.12.20.02.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 02:59:20 -0800 (PST)
Date:   Thu, 20 Dec 2018 11:59:17 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20181220105444.GB8548@kroah.com>
References: <20181220104057.18628-1-christian@brauner.io> <20181220105444.GB8548@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: update Android binder
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     tkjos@google.com, linux-kernel@vger.kernel.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <B16ED4A7-5C64-4285-A076-1CBFEFE47DDB@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 20, 2018 11:54:44 AM GMT+01:00, Greg KH <gregkh@linuxfoundation=
=2Eorg> wrote:
>On Thu, Dec 20, 2018 at 11:40:57AM +0100, Christian Brauner wrote:
>> As briefly discussed with Greg and Todd, add Christian as maintainer
>for
>> binder{fs}=2E
>>=20
>> Signed-off-by: Christian Brauner <christian@brauner=2Eio>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3318f30903b2=2E=2E3c78cfa08c47 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -950,6 +950,7 @@ M:	Arve Hj=C3=B8nnev=C3=A5g <arve@android=2Ecom>
>>  M:	Todd Kjos <tkjos@android=2Ecom>
>>  M:	Martijn Coenen <maco@android=2Ecom>
>>  M:	Joel Fernandes <joel@joelfernandes=2Eorg>
>> +M:	Christian Brauner <christian@brauner=2Eio>
>
>Do you really want to be a maintainer for all of binder?  (which is
>fine
>with me, up to Todd and others), or do you just want to be responsible
>for the binderfs code?

As I mentioned off-list once: I'm fine with both=2E

Thanks!
Christian

>
>thanks,
>
>greg k-h

