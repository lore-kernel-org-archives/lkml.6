Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B752EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E9A20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xExxGK3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E9A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeIJMrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:47:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46984 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJMrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:47:18 -0400
Received: by mail-io1-f66.google.com with SMTP id y12-v6so6266851ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oHNjFEShMy06oeHy63dMj0Y0ej/1JsVPNH6DzjfNg98=;
        b=xExxGK3/+V42oAbskQ8KABkUb6fgkJ+xX+pMo9YjV9yjaWn0lzooBuqMtMEvvqCUai
         EM/A+FyjHq3zVI5qZI5fGeUXjUqEwcXv+PYwBtHVV0WqQQC3oWJSCsNZaBUp+jH3cOn0
         tteKVPt4mBlRF8DB+Pjz2FxCFv6QeAyE2eqqP05tLt5QxLRpOrqQ8YgILJIl9qwGX7id
         DPcFScFK2XMhBMGSBR6nNnT6H8AeoUxuJ/Ks0vaQnC+8xH6fXg11IHdhWTBog/MujZVq
         7hFAJeaMX1Fxbyovj9bUUDgeC1QN6yB4mqHfCIHRBXe+yyWkOZWewAKLHKxDviVh/9oq
         Kh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oHNjFEShMy06oeHy63dMj0Y0ej/1JsVPNH6DzjfNg98=;
        b=pFHQc7b/7hly5YPRZpwiXOQpKH0I7f+JxBkYVlCkexzSWeSQJW+F+KqmjMWD/fxx+u
         0bThnSChI3RGszf8NNF5yS4TCrVGBY5PxolocBesKIT1gzzQy3zGdv7+Kpnd7faNAzLA
         o20HLo4YszwuTyonDp3x9E+5LSOw0TcpTGutkeTSnrF1lYuUBVsBq4BAnQSmhIUtgGwX
         +wgeCX/3H8LbeV6t1yx0RAtslJL4GiPArhye+fAbid06NMdVm6opxR2dgxwRqnFvxJQY
         Y4wKpT492GRKPWJkisYv/mkfPDLrLAItEHaSh+cgixxexw1QBn8eUFRI5LJTpzfaZxMn
         sUsQ==
X-Gm-Message-State: APzg51CzHUZmPhsNcHp4ifCZEjEaIe4uHPfONOfUfoKdhZNhznYBNKLv
        h16ewJq6ttbGhmGAN2Q08UbaPKncEq9OpS5zqfG6upE+
X-Google-Smtp-Source: ANB0VdbhCckQ/b77wApspjrMQ5nr56rVlJZqu+qfn/ybUlzb8AGLaNPQrneOL2qJdmu+rIo9yqgUu31Bx3GJdlFcIic=
X-Received: by 2002:a6b:6401:: with SMTP id t1-v6mr16579259iog.111.1536566073435;
 Mon, 10 Sep 2018 00:54:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 00:54:33
 -0700 (PDT)
In-Reply-To: <a25ef4b9-18cf-ab08-af8f-72b6eaa32602@linaro.org>
References: <20180910074404.8041-1-brgl@bgdev.pl> <a25ef4b9-18cf-ab08-af8f-72b6eaa32602@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Sep 2018 09:54:33 +0200
Message-ID: <CAMRc=Md+Cr8cBQGJuy0UL+oQjatH+mLV28279-qccgvyy18CAA@mail.gmail.com>
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

2018-09-10 9:50 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
>
> On 10/09/18 08:44, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> While working on the nvmem framework recently I noticed that there are
>> many providers that don't use the devm variant of nvmem_register().
>> This series contains relevant updates for eeprom drivers.
>>
>> Bartosz Golaszewski (2):
>>    eeprom: eeprom_93xx46: use resource management
>>    eeprom: at25: use devm_nvmem_register()
>>
>>   drivers/misc/eeprom/at25.c          | 3 +--
>>   drivers/misc/eeprom/eeprom_93xx46.c | 7 ++-----
>
>
> Can you please consider consolidating the devm related changes in a single
> series, to easy the review!
>
>
>>   2 files changed, 3 insertions(+), 7 deletions(-)
>>
>

Are you referring to the devm part of the bigger nvmem series? If so:
no, because the nvmem patches are required by the later patches in
that series. These two patches are independent and should probably go
through Greg's tree directly.

Best regards,
Bartosz Golaszewski
