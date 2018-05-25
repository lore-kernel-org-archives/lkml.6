Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeEYEee (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 00:34:34 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36968 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeEYEed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 00:34:33 -0400
X-Google-Smtp-Source: ADUXVKI5jPaa4lG4x16pSGmeybaVNWADIstZSEfJPT5CQE04Qcs/Ulr3AHGpzpUvNu4oRT6LGswxJOMCV69ZcivDqqU=
MIME-Version: 1.0
In-Reply-To: <9231baaf-e77c-c517-bca2-083070a53342@linux.intel.com>
References: <1520399090-2455-1-git-send-email-haiyue.wang@linux.intel.com> <9231baaf-e77c-c517-bca2-083070a53342@linux.intel.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 25 May 2018 14:04:11 +0930
X-Google-Sender-Auth: bq7LhkVQvbOW32tVHyS_1sjxhuk
Message-ID: <CACPK8Xdhmrwfj6tGZ_o_JeoxdOii_5OD5oz80FJFRasvGd1L9w@mail.gmail.com>
Subject: Re: [PATCH dts/arm/aspeed-g5 v1] ARM: dts: aspeed-g5: Add IPMI KCS node
To: "Wang, Haiyue" <haiyue.wang@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On 16 March 2018 at 11:17, Wang, Haiyue <haiyue.wang@linux.intel.com> wrote:
> Hi Joel and Andrew,
>
> Have time to review this patch ? Hope for your comments. :-)
>
> BR,
> Haiyue
>
>
> On 2018-03-07 13:04, Haiyue Wang wrote:
>>
>> The IPMI KCS device part of the LPC interface and is used for
>> communication with the host processor.
>>
>> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>

Do you have time to take a look at these? The device tree doesn't make
sense to me.

Cheers,

Joel

>> ---
>>   arch/arm/boot/dts/aspeed-g5.dtsi | 43
>> +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi
>> b/arch/arm/boot/dts/aspeed-g5.dtsi
>> index 8eac57c..f443169 100644
>> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
>> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
>> @@ -267,8 +267,40 @@
>>                                 ranges = <0x0 0x1e789000 0x1000>;
>>                                 lpc_bmc: lpc-bmc@0 {
>> -                                       compatible =
>> "aspeed,ast2500-lpc-bmc";
>> +                                       compatible =
>> "aspeed,ast2500-lpc-bmc", "simple-mfd", "syscon";
>>                                         reg = <0x0 0x80>;
>> +                                       reg-io-width = <4>;
>> +
>> +                                       #address-cells = <1>;
>> +                                       #size-cells = <1>;
>> +                                       ranges = <0x0 0x0 0x80>;
>> +
>> +                                       kcs1: kcs1@0 {
>> +                                               compatible =
>> "aspeed,ast2500-kcs-bmc";
>> +                                               reg = <0x0 0x80>;
>> +                                               interrupts = <8>;
>> +                                               kcs_chan = <1>;
>> +                                               kcs_addr = <0x0>;
>> +                                               status = "disabled";
>> +                                       };
>> +
>> +                                       kcs2: kcs2@0 {
>> +                                               compatible =
>> "aspeed,ast2500-kcs-bmc";
>> +                                               reg = <0x0 0x80>;
>> +                                               interrupts = <8>;
>> +                                               kcs_chan = <2>;
>> +                                               kcs_addr = <0x0>;
>> +                                               status = "disabled";
>> +                                       };
>> +
>> +                                       kcs3: kcs3@0 {
>> +                                               compatible =
>> "aspeed,ast2500-kcs-bmc";
>> +                                               reg = <0x0 0x80>;
>> +                                               interrupts = <8>;
>> +                                               kcs_chan = <3>;
>> +                                               kcs_addr = <0x0>;
>> +                                               status = "disabled";
>> +                                       };
>>                                 };
>>                                 lpc_host: lpc-host@80 {
>> @@ -294,6 +326,15 @@
>>                                                 status = "disabled";
>>                                         };
>>   +                                     kcs4: kcs4@0 {
>> +                                               compatible =
>> "aspeed,ast2500-kcs-bmc";
>> +                                               reg = <0x0 0xa0>;
>> +                                               interrupts = <8>;
>> +                                               kcs_chan = <4>;
>> +                                               kcs_addr = <0x0>;
>> +                                               status = "disabled";
>> +                                       };
>> +
>>                                         lhc: lhc@20 {
>>                                                 compatible =
>> "aspeed,ast2500-lhc";
>>                                                 reg = <0x20 0x24 0x48
>> 0x8>;
>
>
