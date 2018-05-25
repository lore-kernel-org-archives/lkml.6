Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966481AbeEYLdq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:33:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:64148 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965907AbeEYLdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:33:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,440,1520924400";
   d="scan'208";a="231756686"
Subject: Re: [PATCH dts/arm/aspeed-g5 v1] ARM: dts: aspeed-g5: Add IPMI KCS
 node
To: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1520399090-2455-1-git-send-email-haiyue.wang@linux.intel.com>
 <9231baaf-e77c-c517-bca2-083070a53342@linux.intel.com>
 <CACPK8Xdhmrwfj6tGZ_o_JeoxdOii_5OD5oz80FJFRasvGd1L9w@mail.gmail.com>
From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <d9f9bd48-7b2c-9f48-0515-50e0a5e55259@linux.intel.com>
Date: Fri, 25 May 2018 19:33:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACPK8Xdhmrwfj6tGZ_o_JeoxdOii_5OD5oz80FJFRasvGd1L9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel & Andrew

This patch is out of date. ;-)

New: https://patchwork.ozlabs.org/patch/893720/


On 2018-05-25 12:34, Joel Stanley wrote:
> Hello Andrew,
>
> On 16 March 2018 at 11:17, Wang, Haiyue <haiyue.wang@linux.intel.com> wrote:
>> Hi Joel and Andrew,
>>
>> Have time to review this patch ? Hope for your comments. :-)
>>
>> BR,
>> Haiyue
>>
>>
>> On 2018-03-07 13:04, Haiyue Wang wrote:
>>> The IPMI KCS device part of the LPC interface and is used for
>>> communication with the host processor.
>>>
>>> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> Do you have time to take a look at these? The device tree doesn't make
> sense to me.
>
> Cheers,
>
> Joel
>
>>> ---
>>>    arch/arm/boot/dts/aspeed-g5.dtsi | 43
>>> +++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 42 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi
>>> b/arch/arm/boot/dts/aspeed-g5.dtsi
>>> index 8eac57c..f443169 100644
>>> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
>>> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
>>> @@ -267,8 +267,40 @@
>>>                                  ranges = <0x0 0x1e789000 0x1000>;
>>>                                  lpc_bmc: lpc-bmc@0 {
>>> -                                       compatible =
>>> "aspeed,ast2500-lpc-bmc";
>>> +                                       compatible =
>>> "aspeed,ast2500-lpc-bmc", "simple-mfd", "syscon";
>>>                                          reg = <0x0 0x80>;
>>> +                                       reg-io-width = <4>;
>>> +
>>> +                                       #address-cells = <1>;
>>> +                                       #size-cells = <1>;
>>> +                                       ranges = <0x0 0x0 0x80>;
>>> +
>>> +                                       kcs1: kcs1@0 {
>>> +                                               compatible =
>>> "aspeed,ast2500-kcs-bmc";
>>> +                                               reg = <0x0 0x80>;
>>> +                                               interrupts = <8>;
>>> +                                               kcs_chan = <1>;
>>> +                                               kcs_addr = <0x0>;
>>> +                                               status = "disabled";
>>> +                                       };
>>> +
>>> +                                       kcs2: kcs2@0 {
>>> +                                               compatible =
>>> "aspeed,ast2500-kcs-bmc";
>>> +                                               reg = <0x0 0x80>;
>>> +                                               interrupts = <8>;
>>> +                                               kcs_chan = <2>;
>>> +                                               kcs_addr = <0x0>;
>>> +                                               status = "disabled";
>>> +                                       };
>>> +
>>> +                                       kcs3: kcs3@0 {
>>> +                                               compatible =
>>> "aspeed,ast2500-kcs-bmc";
>>> +                                               reg = <0x0 0x80>;
>>> +                                               interrupts = <8>;
>>> +                                               kcs_chan = <3>;
>>> +                                               kcs_addr = <0x0>;
>>> +                                               status = "disabled";
>>> +                                       };
>>>                                  };
>>>                                  lpc_host: lpc-host@80 {
>>> @@ -294,6 +326,15 @@
>>>                                                  status = "disabled";
>>>                                          };
>>>    +                                     kcs4: kcs4@0 {
>>> +                                               compatible =
>>> "aspeed,ast2500-kcs-bmc";
>>> +                                               reg = <0x0 0xa0>;
>>> +                                               interrupts = <8>;
>>> +                                               kcs_chan = <4>;
>>> +                                               kcs_addr = <0x0>;
>>> +                                               status = "disabled";
>>> +                                       };
>>> +
>>>                                          lhc: lhc@20 {
>>>                                                  compatible =
>>> "aspeed,ast2500-lhc";
>>>                                                  reg = <0x20 0x24 0x48
>>> 0x8>;
>>
