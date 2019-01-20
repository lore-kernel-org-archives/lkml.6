Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B2C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED602084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt7KNE5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfAUI7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:59:34 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:44788 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbfAUI7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:59:34 -0500
Received: by mail-pg1-f180.google.com with SMTP id t13so9174711pgr.11;
        Mon, 21 Jan 2019 00:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=360KHxZXyrTLVhq9rI49yKk+gFWgJhflRUdyBDHATps=;
        b=Dt7KNE5m0EnSQH2cqxOtTu715VMCLHpo8XNEaFdJ6VvZeeHmPuHB1JRqJ1p43shtp2
         o3PcBm0aP+9zb/zz4a+hW97R2ZNTMFea/O62yxYlXmy1Jq3G6qrG5IzfdAspucXoio8Z
         C1koosofe8H/A0GOPYCYtjB1SHJwAAdq7hpozZcMgZ20lE5HqqHv/a15XbgqFM1FdrsT
         Ft/zLunpM9Bs9lXO/P4U5EUE5/b55tTtU9ac/wOiBfRIba+A7Y9bN1mI5j2ufyuBmtOo
         jQYpJgdBvhjjtLy3Fwphru1o15UhDiF0XD6UcDXbWEZIPvBzrX7zYyCrZTs1yaJBWxyO
         q0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=360KHxZXyrTLVhq9rI49yKk+gFWgJhflRUdyBDHATps=;
        b=etNOB9dsge+8OdAr3KdXsErwfscoqZSwPVqQ2s8tk6U0eOL8ToEUIYijVOpNtp+AgX
         55UQNGw3EaO8j8eLyTBum3zeZqzc4bggnzUmOU8zYKDGL7FGLya2+Yj0rHsIJaG+DzTz
         77/x7q/2HJJYhAAJWMIzTb94FaHkCt1sZEezg38E+m+oEt5YpzpW1DfwVkunha9A9B77
         e0/CE7tJlKD0xo0aG+DW80anZoEuCruYgT8jUOdSky9BfuWNNVrV8M7V4KZM4BC1sFr5
         VzpaGs8ajTPoIbmLOXW3GsF302seprL4odAx3hulCdvUps7Rz6W+7w5S2oor3mlJAyRa
         MrCw==
X-Gm-Message-State: AJcUukcj+tayRG2ZSaQQ3rZE+E/BZgk+yneuxYDSxMV+xKzbrb2j2u/3
        kMmjl+Wy+IJgkc9DdTu9pOGOYqFohnE=
X-Google-Smtp-Source: ALg8bN6OxuoJm+JQ7Xxbatupmmre+GK6Rh1C7SDY2uMc12KvIT/cX5bhfIp/oEUA0vX0zf68Mk1gNg==
X-Received: by 2002:a63:db48:: with SMTP id x8mr25079775pgi.365.1548024292189;
        Sun, 20 Jan 2019 14:44:52 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:54d2:28aa:5e03:3a9a? ([2001:df0:0:200c:54d2:28aa:5e03:3a9a])
        by smtp.gmail.com with ESMTPSA id s9sm16412450pgl.88.2019.01.20.14.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 14:44:51 -0800 (PST)
Subject: Re: [v4,1/9] net-next: phy: new Asix Electronics PHY driver
To:     Andrew Lunn <andrew@lunn.ch>, Thomas Gleixner <tglx@linutronix.de>
Cc:     netdev@vger.kernel.org, fthain@telegraphics.com.au,
        geert@linux-m68k.org, f.fainelli@gmail.com,
        linux-m68k@vger.kernel.org, Michael.Karcher@fu-berlin.de,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <1524103526-12240-2-git-send-email-schmitzmic@gmail.com>
 <alpine.DEB.2.21.1901181121101.1647@nanos.tec.linutronix.de>
 <20190120174312.GC15048@lunn.ch>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <68512084-2ba5-9b58-38b5-0052fddce734@gmail.com>
Date:   Mon, 21 Jan 2019 11:44:45 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190120174312.GC15048@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

no objection for you to pick this up as part as a larger cleanup. I've 
tried to reconstruct how this happened (i.e. what other phy driver file 
I used as a 'template' for asix.c) - all I can say is that the 2.0+ 
boiler plate text was in my initial commit, and the incorrect SPDX tag 
was added in response to checkpath complaints. So 2.0+ would be correct.

Thomas: does that suit your purpose?

Cheers,

     Michael


On 21/01/19 6:43 AM, Andrew Lunn wrote:
> On Fri, Jan 18, 2019 at 11:22:39AM +0100, Thomas Gleixner wrote:
>> Michael,
>>
>> On Thu, 19 Apr 2018, Michael Schmitz wrote:
>>
>>> --- /dev/null
>>> +++ b/drivers/net/phy/asix.c
>>> @@ -0,0 +1,63 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Driver for Asix PHYs
>>> + *
>>> + * Author: Michael Schmitz <schmitzmic@gmail.com>
>>> + *
>>> + * This program is free software; you can redistribute  it and/or modify it
>>> + * under  the terms of  the GNU General  Public License as published by the
>>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>>> + * option) any later version.
>>> + *
>>> + */
>> This license information is broken. The SPDX license identifier and the
>> boiler plate text are contradicting. The SPDX id is GPL v2 only and the
>> boiler plate says v2 or later.
> Hi Thomas
>
> Please see:
>
> https://www.spinics.net/lists/netdev/msg544312.html
>
> The first two patches are simple SPDX converstions. Then it gets
> interesting trying to sort out license inconsistencies.
>
> 	Andrew
