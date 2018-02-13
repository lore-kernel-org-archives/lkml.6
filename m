Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935299AbeBMMz4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:55:56 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:30322 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935118AbeBMMzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:55:54 -0500
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Rob Herring <robh@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 09/12] ARM: dts: STi: Add fake reg property for sound
 related nodes
Thread-Topic: [PATCH v2 09/12] ARM: dts: STi: Add fake reg property for sound
 related nodes
Thread-Index: AQHTpA/UMd5ls960EUyYZpJzRQk+hqOg1swAgAFkAYA=
Date: Tue, 13 Feb 2018 12:54:56 +0000
Message-ID: <99afc3f9-d0b4-b13c-ac97-4347f25aa000@st.com>
References: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
 <1518446590-16800-10-git-send-email-patrice.chotard@st.com>
 <CABGGiszvx=Nyeq+KTt9uHGwSabxsJuEfvG01H4NyrBtB40atoA@mail.gmail.com>
In-Reply-To: <CABGGiszvx=Nyeq+KTt9uHGwSabxsJuEfvG01H4NyrBtB40atoA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2D3A8AB06DC3247A5FAF39EC2F6E673@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1DCu0eB020209

Hi Rob

On 02/12/2018 04:40 PM, Rob Herring wrote:
> On Mon, Feb 12, 2018 at 8:43 AM,  <patrice.chotard@st.com> wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> Add fake reg property to sound, simple-audio-card, dai-link and
>> sti_sasg_codec nodes, this allows to fix the following warning
>> when compiling dtb with W=1 option:
>>
>> arch/arm/boot/dts/stih407-b2120.dtb: Warning (unit_address_vs_reg):
>> Node /soc/sound/simple-audio-card,dai-link@0 has a unit name, but no reg property
>> arch/arm/boot/dts/stih407-b2120.dtb: Warning (unit_address_vs_reg):
>> Node /soc/sound/simple-audio-card,dai-link@1 has a unit name, but no reg property
>> arch/arm/boot/dts/stih407-b2120.dtb: Warning (unit_address_vs_reg):
>> Node /soc/sound/simple-audio-card,dai-link@2 has a unit name, but no reg property
>> arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
>> Node /soc/sti-sasg-codec missing or empty reg/ranges property
>>
>> arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
>> Node /soc/sound/simple-audio-card,dai-link@0 has a unit name, but no reg property
>> arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
>> Node /soc/sound/simple-audio-card,dai-link@1 has a unit name, but no reg property
>> arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
>> Node /soc/sound/simple-audio-card,dai-link@2 has a unit name, but no reg property
>> arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
>> Node /soc/sound missing or empty reg/ranges property
>> arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
>> Node /soc/sti-sasg-codec missing or empty reg/ranges property
>>
>> arch/arm/boot/dts/stih410-b2260.dtb: Warning (unit_address_vs_reg):
>> Node /soc/sound/simple-audio-card,dai-link@0 has a unit name, but no reg property
>> arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
>> Node /soc/sti-sasg-codec missing or empty reg/ranges property
>> arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
>> Node /soc/sound missing or empty reg/ranges property
>>
>> arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
>> Node /soc/sti-sasg-codec missing or empty reg/ranges property
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> ---
>>
>> v2: _ add a fake reg property to node without reg property.
>>
>>   arch/arm/boot/dts/stih407-family.dtsi |  3 ++-
>>   arch/arm/boot/dts/stih410-b2260.dts   |  5 +++--
>>   arch/arm/boot/dts/stihxxx-b2120.dtsi  | 11 ++++++-----
>>   3 files changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
>> index 5df827b00eb6..df1a3f1dc5a7 100644
>> --- a/arch/arm/boot/dts/stih407-family.dtsi
>> +++ b/arch/arm/boot/dts/stih407-family.dtsi
>> @@ -894,8 +894,9 @@
>>                          status = "disabled";
>>                  };
>>
>> -               sti_sasg_codec: sti-sasg-codec {
>> +               sti_sasg_codec: sti-sasg-codec@0 {
>>                          compatible = "st,stih407-sas-codec";
>> +                       reg = <0 0>;
>>                          #sound-dai-cells = <1>;
>>                          status = "disabled";
>>                          st,syscfg = <&syscfg_core>;
> 
> This should probably be a child of syscfg to fix this. And if this
> block has a dedicated set of registers, then use reg to define those
> (even though regmap/syscon doesn't need it).

Ok, i will mode this node

> 
>> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
>> index 8bcd58118dba..03d05a98b7fc 100644
>> --- a/arch/arm/boot/dts/stih410-b2260.dts
>> +++ b/arch/arm/boot/dts/stih410-b2260.dts
>> @@ -181,12 +181,13 @@
>>                          status = "okay";
>>                  };
>>
>> -               sound {
>> +               sound: sound@0 {
> 
> I'd move this up to top level.

Ok

Thanks

Patrice



> 
> Rob
> 
