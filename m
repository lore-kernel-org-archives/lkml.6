Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C61C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDB326F35
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAy33REW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDB326F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754935AbeFZTTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:19:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40697 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeFZTTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:19:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so2985115wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 12:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0xcxM/8tnnO0b0krXYVIdU5WlM5lC9ytV4EZhx3BAyo=;
        b=nAy33REWp7j3KCZ5QYdohnlwZDsonAOvYbuVqBPp/4WdqsAJHztCjRjKGsbSv7zEiJ
         GBw/jXlZB75Z0+iYfFFmgfwbwmMfg9i7Jgkm7tgVyXcGCbDvxjwfzy9ZhXNMcYmfCVmU
         jY1eG+frUphVYMLZQ0nLZXV5Sd50rOzjOkPGctml+IiK3cfNMUOW3FlUiWK+Xxnx8ypP
         NtEYF5QiKnnJopL2KC4OGGFHAb6rx/XVDRxEE60r6jb9LzCT5Oi0US2sIIbq9s7g9NyP
         O24xpoyE1Pf8bmngKM++0TqbO3IuV/Q6GnfQebTV1vu9OYpSm0S5K/yZAAnje9/v35Gc
         VIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0xcxM/8tnnO0b0krXYVIdU5WlM5lC9ytV4EZhx3BAyo=;
        b=YSObFTp4nPxIBzP8javmEEj6XpUzsnCg6sxGqwnSYcy/xmj6im5GzUbLojc795TjtX
         jRj3JUT3l5HijOu55XOBwhsJtMZJ+nHdSbV4AzKOHdENZKGd6Lrcn5aVM3RRu16yLpM9
         3Klt5w7S9ppC24uUI+p/bDryzj4zXrwY71iTzKOD4AUkVfi6zqH35eQsTJgWi/Yfei6T
         IIVYqTBfoHjqkX/sXoDh8d1YjvI2D5opQyQN9lHgDyqMwL8xW847wsHCCzRX2KWjeAi+
         wFh9+rVMF2hZlur0xTOq8gN9MVJPdctTkBTObaWtgTIDLD96/Edb3AS4904dhyZzis1t
         XfFg==
X-Gm-Message-State: APt69E3ehHP3iJwQw7A6nosPIHloW01HgnaxVYkcOskh5Ypb83MLr71a
        1FclAkZeefqB51aPTOZrAY0=
X-Google-Smtp-Source: AAOMgpfZSHh+dkWniZW9zH6XVmNeZ9B2mC0M09LSr5LB1vMtf+yIwitCSvkeM5XfdiMq4fcJ/vYUYw==
X-Received: by 2002:a1c:b6c3:: with SMTP id g186-v6mr2636215wmf.40.1530040771958;
        Tue, 26 Jun 2018 12:19:31 -0700 (PDT)
Received: from [192.168.1.4] (x590c812a.dyn.telefonica.de. [89.12.129.42])
        by smtp.gmail.com with ESMTPSA id o13-v6sm1752908wmc.8.2018.06.26.12.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 12:19:31 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] staging: rtl8723bs: refactor rtw_macaddr_cfg()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20180626081409.9518-1-straube.linux@gmail.com>
 <20180626081409.9518-2-straube.linux@gmail.com>
 <CAHp75Ve7tKAQU9sfCUvWnwHaYkFXHiMS6PTbLdqh-AJOfYQpCw@mail.gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <91b18a3f-260b-44a6-466b-5074f78f3cbd@gmail.com>
Date:   Tue, 26 Jun 2018 21:19:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve7tKAQU9sfCUvWnwHaYkFXHiMS6PTbLdqh-AJOfYQpCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/18 19:29, Andy Shevchenko wrote:
> On Tue, Jun 26, 2018 at 11:14 AM, Michael Straube
> <straube.linux@gmail.com> wrote:
>> Using is_broadcast_ether_addr() and is_zero_ether_addr() instead of
>> testing each byte of the mac[] array for 0xff and 0x00 shortens the
>> code and improves readability.
>>
>> If np == NULL, of_get_property() returns NULL, hence the "np" check
>> is not needed.
>>
>> Instead of a fixed default mac address use a random one to reduce the
>> likelihood of mac address collision.
>>
> 
>> Thanks to Joe Perches and Dan Carpenter.
> 
> I guess you may use Suggested-by tag as well.
> 

Thanks for the hint, I will add it.

Regards
Michael
