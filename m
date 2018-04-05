Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeDEMyV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:54:21 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42251 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:54:19 -0400
X-Google-Smtp-Source: AIpwx48RBlOlU985RFUECFD939shttCAnH8FxOaDvWYntc2miasAqtbRrNyOIQ0d4i/l88w4PYrqDs7o00fFjoTv0lg=
MIME-Version: 1.0
In-Reply-To: <CAP6Zq1jvCvM+uG8kU_JAYzm9e3BG28AS80ANmn_0a0HmiVBm3A@mail.gmail.com>
References: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com>
 <1521155412-29229-3-git-send-email-tmaimon77@gmail.com> <CAFd5g44NOFRmQbDJfRLw_SwsHwVB-hxsUYMYSmkqeyRKmXqSqQ@mail.gmail.com>
 <CAP6Zq1jvCvM+uG8kU_JAYzm9e3BG28AS80ANmn_0a0HmiVBm3A@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 14:54:18 +0200
X-Google-Sender-Auth: 6Z_XjyCz879wd07McNwlYYYJpMY
Message-ID: <CAK8P3a3HBkqgas-QkAr_J767ffBMXJTJeqqVY9fFxw2Yexi27g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] arm: npcm: Enable L2 Cache in NPCM7xx
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: Brendan Higgins <brendanhiggins@google.com>,
        Patrick Venture <venture@google.com>,
        Avi Fishman <avifishman70@gmail.com>, Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nancy Yuen <yuenn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 10:51 PM, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
>
> On 16 March 2018 at 07:52, Brendan Higgins <brendanhiggins@google.com>
> wrote:
>>
>> On Thu, Mar 15, 2018 at 4:16 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>>
>> > Enable L2 Cache in Nuvoton NPCM7xx BMC.
>>
>> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>> > ---
>> >   arch/arm/mach-npcm/npcm7xx.c | 2 ++
>> >   1 file changed, 2 insertions(+)
>>
>> > diff --git a/arch/arm/mach-npcm/npcm7xx.c b/arch/arm/mach-npcm/npcm7xx.c
>> > index 5f7cd88103ef..c5f77d854c4f 100644
>> > --- a/arch/arm/mach-npcm/npcm7xx.c
>> > +++ b/arch/arm/mach-npcm/npcm7xx.c
>> > @@ -17,4 +17,6 @@ static const char *const npcm7xx_dt_match[] = {
>> >   DT_MACHINE_START(NPCM7XX_DT, "NPCM7XX Chip family")
>> >          .atag_offset    = 0x100,
>> >          .dt_compat      = npcm7xx_dt_match,
>> > +       .l2c_aux_val    = 0x0,
>> > +       .l2c_aux_mask   = ~0x0,
>>
>> You need to limit this to the specific bit(s) you want to set and verify
>> that
>> the l2c driver does not already manage that bit appropriately and that it
>> can
>> not be specified via the dtsi.
>
>
> Do you mean that I need to specify it the same as been done in V7?
> because when I run with the above l2c_aux_val and  l2c_aux_mask parameters I
> get the same result.
>
> Also if I am not adding the l2c_aux_val and  l2c_aux_mask parameters to the
> DT_MACHINE_START
> the L2C cache does not initialize.
>>
>>
>> We discussed this a little while ago with Rob here:
>> https://www.spinics.net/lists/arm-kernel/msg613372.html
>
>
> Sorry in this link I see only Russel king comment regarding the L2C

I'm not sure what the outcome is, and the patch changelog doesn't
explain what the patch is for, so I've not applied it. If you need the
patch for correct operation, please resend it with a proper changelog
comment explaining why it's needed and why you ended up not setting
any of the bits.

The last email in that thread mentions
L310_AUX_CTRL_CACHE_REPLACE_RR, is that required after all?

     Arnd
