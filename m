Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450D8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E918D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dl15Dl1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E918D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeIJNAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:00:55 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37962 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeIJNAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:00:54 -0400
Received: by mail-it0-f67.google.com with SMTP id p129-v6so27514141ite.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XIdPMJhmh+LMeKFD0+SWYOXl8kuTA3I/4wpzbVA9Dmg=;
        b=dl15Dl1+iEKxAmH3GZ4pDRmSePKmYHN3p+DOYXUwyQYz/h/nlzkiPWpnQQ6MP1d9Zo
         iiZuLQrI5RaOfajxINVukLdqFqta9tIF6o1IHClWPi3BTLSn7qw4MnQswV7thd/8zcH/
         Kn0JGF122FF5uMUUboFZQiQ4apZL0+Fx1YpMvw3PTiBvklaSusqLAXRMYM2JLaSwRk+F
         MysrPnCGRV6ifE0WavXuP6dGtP+IDF9TTSZZdFNo2s2aVFkdSFtSf6nlUvW7lhDa2uX3
         OZCx7inspiWe9pIj1KzvbG0LtvMUoki3bwhPtN8XxOIe72sMB0idnc1nog+T7+tQ7+Pe
         Bnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XIdPMJhmh+LMeKFD0+SWYOXl8kuTA3I/4wpzbVA9Dmg=;
        b=h9nnzDILot/B7mrKPhMr6V+1BCo4uTR5hzhPPSeZlcTxDw1iIcOQ2MepdwowcXNX+1
         ebuWGUPq8Jnh4BQzs6P+fzM9hEZYIDn8IAMmcugbBE2SMHwZefTR/wUlH9maLFYRMmIK
         +gXwHpoyka6Qiqn0u2K+MDR4/LZtVGBkI2Ig3Aep8ik0HR8Nd4f9qOQ9jTaT+Tzba/js
         7x7AaYhf4ucN+M9pr0DAdLyGkrToJeJNoLjjPXMUc+rNZKlu27nSYDcb9LppfPdi9EuH
         y5dTrJi8IIuXxvj735+qRaY6f71dOSsAgUznTklO5CbyrpopUXnoojqAKT0gjLS01+21
         a22A==
X-Gm-Message-State: APzg51B6IRaUGuuFZKcsSkMNXsX78sHQ80o4TQ1l27K3opKHAdUlO/I9
        YUg/owNo8ccLbMSwa0ji45smfGdaPc/XOwhsc3aNr3xXZ+E=
X-Google-Smtp-Source: ANB0VdbAtmNqz9qkElkqkZtZJINEGjDBvnUFP7QtNtalVxJYNCN1xzACpq6S2D0US+MpxCLle1FXWI2xO7hIm110IQ8=
X-Received: by 2002:a24:41cd:: with SMTP id b74-v6mr16224380itd.85.1536566887184;
 Mon, 10 Sep 2018 01:08:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 01:08:06
 -0700 (PDT)
In-Reply-To: <13424edc-ce9e-7785-4550-cc224ec58a9e@linaro.org>
References: <20180910074404.8041-1-brgl@bgdev.pl> <a25ef4b9-18cf-ab08-af8f-72b6eaa32602@linaro.org>
 <CAMRc=Md+Cr8cBQGJuy0UL+oQjatH+mLV28279-qccgvyy18CAA@mail.gmail.com> <13424edc-ce9e-7785-4550-cc224ec58a9e@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Sep 2018 10:08:06 +0200
Message-ID: <CAMRc=McCe0t1gb6BPkN=tU1zgT5tPwzhz_-WzvFhXXQS041nNw@mail.gmail.com>
Subject: Re: [PATCH 0/2] eeprom: use devres for nvmem providers
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Devang Panchal <devang.panchal@softnautics.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-10 9:59 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
>
> On 10/09/18 08:54, Bartosz Golaszewski wrote:
>>
>> 2018-09-10 9:50 GMT+02:00 Srinivas Kandagatla
>> <srinivas.kandagatla@linaro.org>:
>>>
>>>
>>>
>>> On 10/09/18 08:44, Bartosz Golaszewski wrote:
>>>>
>>>>
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> While working on the nvmem framework recently I noticed that there are
>>>> many providers that don't use the devm variant of nvmem_register().
>>>> This series contains relevant updates for eeprom drivers.
>>>>
>>>> Bartosz Golaszewski (2):
>>>>     eeprom: eeprom_93xx46: use resource management
>>>>     eeprom: at25: use devm_nvmem_register()
>>>>
>>>>    drivers/misc/eeprom/at25.c          | 3 +--
>>>>    drivers/misc/eeprom/eeprom_93xx46.c | 7 ++-----
>>>
>>>
>>>
>>> Can you please consider consolidating the devm related changes in a
>>> single
>>> series, to easy the review!
>>>
>>>
>>>>    2 files changed, 3 insertions(+), 7 deletions(-)
>>>>
>>>
>>
>> Are you referring to the devm part of the bigger nvmem series? If so:
>> no, because the nvmem patches are required by the later patches in
>
> Yes, am referring to that series.
> I dont see any reason why lpc and sunxi changes should not be in this
> series? Or there is no implicit reasoning or change log that suggests that
> these have to be part of that series!
>
>

Patch ("nvmem: change the signature of nvmem_unregister()") depends on
those three patches in the other series. We need to change them first
because they were still checking the return value of
nvmem_unregister(). And this patch results from the earlier kref
patch. I think that although this nvmem series is pretty big, it
contains mostly related changes and it will be hard to submit them
separately.

Bart


> --srini
>
>
>> that series. These two patches are independent and should probably go
>> through Greg's tree directly.
>>
>> Best regards,
>> Bartosz Golaszewski
>>
>
