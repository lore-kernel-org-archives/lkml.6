Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbeB1SOW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:14:22 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50545 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeB1SOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:14:20 -0500
X-Google-Smtp-Source: AH8x227Q5W8nOGFUS4LRrt07Xex2ASMPXkvoKLqUUoPIaUHZp65KWoNow6He+EERbrpJFSecKxCFnNmf5ynjReoB7Mw=
MIME-Version: 1.0
In-Reply-To: <d9e14058-6ffb-e54a-1565-f228342ee1f0@sholland.org>
References: <20180228022714.30068-1-samuel@sholland.org> <20180228022714.30068-4-samuel@sholland.org>
 <CABb+yY2uueAK9kzXzU9DT2a4NtV3kK2dc_wtyFWTBn8=Z6Vi7Q@mail.gmail.com> <d9e14058-6ffb-e54a-1565-f228342ee1f0@sholland.org>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 28 Feb 2018 23:44:18 +0530
Message-ID: <CABb+yY3nfVxoA9wy1ym4mtCTKCZtJjepUTr7OP1uUPmzOEzniA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
To: Samuel Holland <samuel@sholland.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <", linux-arm-kernel"@lists.infradead.org>,
        ", linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream"
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 11:21 PM, Samuel Holland <samuel@sholland.org> wrote:
> Hi,
>
> On 02/28/18 03:16, Jassi Brar wrote:
>> On Wed, Feb 28, 2018 at 7:57 AM, Samuel Holland <samuel@sholland.org> wrote:
>> ....
>>
>>> +/*
>>> + * The message box hardware provides 8 unidirectional channels. As the mailbox
>>> + * framework expects them to be bidirectional
>>>
>> That is incorrect. Mailbox framework does not require a channel to be
>> TX and RX capable.
>
> Sorry, it would be more accurate to say that the intended mailbox _client_
> expects the channels to be bidirectional.
>
Mailbox clients are very mailbox provider specific. Your client driver
is unlikely to be reuseable over another controller+remote combo.
Your client has to know already what a physical channel can do (RX, TX
or RXTX). There is no api to provide that info.

thanks
