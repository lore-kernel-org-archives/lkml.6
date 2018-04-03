Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755206AbeDCIgS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:36:18 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:16982 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754985AbeDCIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:36:17 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w338aAIR000352
X-Nifty-SrcIP: [209.85.213.48]
X-Google-Smtp-Source: AIpwx4/Rhogv+Tc1cKJ3dhlFNQcFno0ExpUA7o9DCudXtjJ9q/0iF8KopvVvdDGbqUQHDq+YqF8h9TS3wSG5VsMws64=
MIME-Version: 1.0
In-Reply-To: <1522743506.5089.4.camel@pengutronix.de>
References: <1522403084-18780-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1522403084-18780-3-git-send-email-hayashi.kunihiko@socionext.com> <1522743506.5089.4.camel@pengutronix.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 3 Apr 2018 17:35:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR0emjbECwZq7zVygzFvhBs0iLNu--WqUQ2yZVvNUgSOw@mail.gmail.com>
Message-ID: <CAK7LNAR0emjbECwZq7zVygzFvhBs0iLNu--WqUQ2yZVvNUgSOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] reset: uniphier: add SATA reset control support and
 change SATA-PHY ID
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-03 17:18 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> On Fri, 2018-03-30 at 18:44 +0900, Kunihiko Hayashi wrote:
>> Add reset lines for SATA controller on UniPhier SoCs.
>> This adds support for Pro4 and PXs3 in addition to PXs2.
>>
>> And this changes the ID of the reset line for SATA-PHY on PXs2.
>> Since some SoCs have two controller instances with a common PHY, this moves
>> the ID of SATA-PHY for consistency.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>  drivers/reset/reset-uniphier.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
>> index 55ae0f1..90e6caf 100644
>> --- a/drivers/reset/reset-uniphier.c
>> +++ b/drivers/reset/reset-uniphier.c
>> @@ -63,6 +63,9 @@ static const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
>>       UNIPHIER_RESETX(12, 0x2000, 6),         /* GIO (Ether, SATA, USB3) */
>>       UNIPHIER_RESETX(14, 0x2000, 17),        /* USB30 */
>>       UNIPHIER_RESETX(15, 0x2004, 17),        /* USB31 */
>> +     UNIPHIER_RESETX(28, 0x2000, 18),        /* SATA0 */
>> +     UNIPHIER_RESETX(29, 0x2004, 18),        /* SATA1 */
>> +     UNIPHIER_RESETX(30, 0x2000, 19),        /* SATA-PHY */
>>       UNIPHIER_RESETX(40, 0x2000, 13),        /* AIO */
>>       UNIPHIER_RESET_END,
>>  };
>> @@ -90,7 +93,7 @@ static const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
>>       UNIPHIER_RESETX(20, 0x2014, 5),         /* USB31-PHY0 */
>>       UNIPHIER_RESETX(21, 0x2014, 1),         /* USB31-PHY1 */
>>       UNIPHIER_RESETX(28, 0x2014, 12),        /* SATA */
>> -     UNIPHIER_RESET(29, 0x2014, 8),          /* SATA-PHY (active high) */
>> +     UNIPHIER_RESET(30, 0x2014, 8),          /* SATA-PHY (active high) */
>
> This is a backwards incompatible change.
> There is no DT in use that relies on this being 29 ?


Right.  No user for this reset line ever.



-- 
Best Regards
Masahiro Yamada
