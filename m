Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeDEIcm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 04:32:42 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:43034 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeDEIcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 04:32:39 -0400
X-Google-Smtp-Source: AIpwx4/qpiPuapnL9A+rcoIv+b82raYM2pGCTGJMSk4j47+y8ABNXVtdWNpZxf9QgTgdGyqgy9+RWJUm5J4NY4rP3fM=
MIME-Version: 1.0
In-Reply-To: <878ta24uyy.fsf@belgarion.home>
References: <20180404114706.15856-1-brgl@bgdev.pl> <878ta24uyy.fsf@belgarion.home>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 5 Apr 2018 10:32:38 +0200
Message-ID: <CAMRc=MfD659sqbwRJs2tti-VcSShLWU-yB8=SR7zhv8Pz6XQcA@mail.gmail.com>
Subject: Re: [RESEND PATCH] ARM: pxa: stargate2: use device properties for
 at24 eeprom
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-04 21:44 GMT+02:00 Robert Jarzmik <robert.jarzmik@free.fr>:
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
>> We want to work towards phasing out the at24_platform_data structure.
>> There are few users and its contents can be represented using generic
>> device properties. Using device properties only will allow us to
>> significantly simplify the at24 configuration code.
>>
>> Remove the at24_platform_data structure and replace it with an array
>> of property entries. Drop the byte_len/size property, as the model name
>> already implies the EEPROM's size.
> Hi Bartosz,
>
> I'd like a little explanation for the last sentence. Are you implying that
> ac24.c is using the "type" field, and if so could you point me to the correct
> line, because I was under the impression a property called "size" is used for
> byte_len value ... ?
>

Yes, it does use the type field from i2c_board_info implicitly over
i2c-core. The type field is copied over to client->name and then is
matched against the i2c ID table from which we get the associated chip
data (unless the type is "at24") containing the size and flags.

Hope that helps.

Bartosz
