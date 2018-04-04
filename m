Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752490AbeDDXUU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 19:20:20 -0400
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:50416 "EHLO
        godking.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752390AbeDDXUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 19:20:18 -0400
Subject: Re: [PATCH] Add Second Fan Support for Thinkpad P50
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1522693621-3124-1-git-send-email-agk@godking.net>
 <CAHp75Vc1KV3i6Jp-t=cD5DjYDMPHA0Zz77RkN0kmrvb1WLj6gA@mail.gmail.com>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Alexander Kappner <agk@godking.net>
Message-ID: <5cbdc251-6aa2-3fc2-3bb8-6f95cac11838@godking.net>
Date: Wed, 4 Apr 2018 16:20:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc1KV3i6Jp-t=cD5DjYDMPHA0Zz77RkN0kmrvb1WLj6gA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy: Thanks for pushing, and for the pointers regarding formalities; I'll keep those in mind. 

Also, it would be great if someone could test the fan reporting on a P70 Thinkpad (which has the same fan configuration as my P50 and thus likely needs the same quirk).

Best
Alexander Kappner
 
> On Mon, Apr 2, 2018 at 9:27 PM, Alexander Kappner <agk@...> wrote:
>> The Thinkpad P50 has 2 fans. Add the 2FAN quirk so the tpacpi driver
>> properly reports both fan speeds.
>> Because the P50 doesn't report the version of its EC controller, we need to
>> identify it by BIOS version (N1).
> 
> I have pushed it with changes discussed to my review and testing queue, thanks!
> 
> I'm not sure if you were about to send a new version (no need
> anymore), though for the next time, please be familiar with
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst
> (in particular, section 8).
> 
> And additional information, we are using special prefixes for our
> subsystem, i.e.
> "platform/x86: $DRIVER_NAME: ".
> 
>> Signed-off-by: Alexander Kappner <agk@...>
>> ---
>>  drivers/platform/x86/thinkpad_acpi.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>> index d5eaf3b1..ebdc300 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -8699,16 +8699,24 @@ static const struct attribute_group fan_attr_group = {
>>           .ec = TPID(__id1, __id2),             \
>>           .quirks = __quirks }
>>
>> +#define TPACPI_FAN_QL_BIOS(__id1, __id2, __quirks)     \
>> +       { .vendor = PCI_VENDOR_ID_LENOVO,       \
>> +         .bios = TPID(__id1, __id2),           \
>> +         .ec = TPACPI_MATCH_ANY,               \
>> +         .quirks = __quirks }
>> +
>>  static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>>         TPACPI_FAN_QI('1', 'Y', TPACPI_FAN_Q1),
>>         TPACPI_FAN_QI('7', '8', TPACPI_FAN_Q1),
>>         TPACPI_FAN_QI('7', '6', TPACPI_FAN_Q1),
>>         TPACPI_FAN_QI('7', '0', TPACPI_FAN_Q1),
>>         TPACPI_FAN_QL('7', 'M', TPACPI_FAN_2FAN),
>> +       TPACPI_FAN_QL_BIOS('N', '1', TPACPI_FAN_2FAN) // Thinkpad P50 has 2 fans
>>  };
>>
>>  #undef TPACPI_FAN_QL
>>  #undef TPACPI_FAN_QI
>> +#undef TPACPI_FAN_QL_BIOS
>>
>>  static int __init fan_init(struct ibm_init_struct *iibm)
>>  {
>> --
>> 2.1.4
>>
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
