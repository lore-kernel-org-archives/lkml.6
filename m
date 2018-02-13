Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964833AbeBMM7T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:59:19 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6766 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935077AbeBMM7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:59:18 -0500
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Rob Herring <rob.herring@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 10/12] ARM: dts: STi: Add fake reg property for clocks
Thread-Topic: [PATCH v2 10/12] ARM: dts: STi: Add fake reg property for clocks
Thread-Index: AQHTpA/VYWz7ZbGWUUiNKMJpjfZgi6Og0dKAgAFqFIA=
Date: Tue, 13 Feb 2018 12:58:52 +0000
Message-ID: <ce036283-586b-0603-2c85-a502ed656e72@st.com>
References: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
 <1518446590-16800-11-git-send-email-patrice.chotard@st.com>
 <CABGGisxgejFHj0xQq-aBQETt9CX3OzLc3ER_Y9nyrw7FeLdt6g@mail.gmail.com>
In-Reply-To: <CABGGisxgejFHj0xQq-aBQETt9CX3OzLc3ER_Y9nyrw7FeLdt6g@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B25772FB022A346B0B37143D353A66F@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1DCxPdJ021279

Hi Rob

On 02/12/2018 04:22 PM, Rob Herring wrote:
> On Mon, Feb 12, 2018 at 8:43 AM,  <patrice.chotard@st.com> wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> For all clock's element inside SoC, add a fake reg property,
>> this allows to fix the following warnings when compiling
>> dtb with W=1 option :
>>
>> arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
>> Node /clocks/clk-m-a9-periphs missing or empty reg/ranges property
>> arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
>> Node /clocks/clk-m-a9-ext2f-div2s missing or empty reg/ranges property
>> arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
>> Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property
>>
>> arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
>> Node /clocks/clk-m-a9-periphs missing or empty reg/ranges property
>> arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
>> Node /clocks/clk-m-a9-ext2f-div2s missing or empty reg/ranges property
>> arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
>> Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property
>>
>> arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
>> Node /clocks/clk-m-a9-periphs missing or empty reg/ranges property
>> arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
>> Node /clocks/clk-m-a9-ext2f-div2s missing or empty reg/ranges property
>> arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
>> Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> ---
>>
>> v2: _ add a fake reg property to node without reg property.
>>
>>   arch/arm/boot/dts/stih407-clock.dtsi | 9 ++++++---
>>   arch/arm/boot/dts/stih410-clock.dtsi | 9 ++++++---
>>   arch/arm/boot/dts/stih418-clock.dtsi | 9 ++++++---
>>   3 files changed, 18 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
>> index b882dcf3a649..1bba47e06ebe 100644
>> --- a/arch/arm/boot/dts/stih407-clock.dtsi
>> +++ b/arch/arm/boot/dts/stih407-clock.dtsi
>> @@ -24,9 +24,10 @@
>>                  /*
>>                   * ARM Peripheral clock for timers
>>                   */
>> -               arm_periph_clk: clk-m-a9-periphs {
>> +               arm_periph_clk: clk-m-a9-periphs@0 {
>>                          #clock-cells = <0>;
>>                          compatible = "fixed-factor-clock";
>> +                       reg = <0 0>;
> 
> Don't do this. The correct fix is change the location of these nodes
> to be under whatever controls them.
> 
Ok i will put this node as a child of clockgen-a9@92b0000

Thanks

Patrice

> Rob
> 
