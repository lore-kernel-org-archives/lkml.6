Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932908AbeBVPOO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:14:14 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14106 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932837AbeBVPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:14:10 -0500
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/6] Introduce STMicroelectronics MultiFunction eXpander
Thread-Topic: [PATCH 0/6] Introduce STMicroelectronics MultiFunction eXpander
Thread-Index: AQHToOkBSqFdxP/8skO5JmeBz349jqOwaVuAgAAjcIA=
Date: Thu, 22 Feb 2018 15:13:30 +0000
Message-ID: <276d5f97-55c2-406e-92c7-0d03c7f7a49d@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <CACRpkdZYnQC5BusLyK5aAcA2q0NmvHu=TaLhFCfu2M0bgBcjrQ@mail.gmail.com>
In-Reply-To: <CACRpkdZYnQC5BusLyK5aAcA2q0NmvHu=TaLhFCfu2M0bgBcjrQ@mail.gmail.com>
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
Content-ID: <CC33488A7E6801469D12F0B3DDDD9228@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MFEHjE004397

Hi Linus,

Thanks for your review on the whole series.

On 02/22/2018 02:06 PM, Linus Walleij wrote:
> Hi Amelie,
> 
> thanks a lot for your patches!
> 
> On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:
> 
>> This series adds support for STMicroelectronics MultiFunction eXpander
>> (ST MFX), used on some STM32 discovery and evaluation boards.
> 
> So I take it that the department creating the STMPE
> "ST MPE" or "ST Microelectronics MultiPurpose Expander"
> Now created a new set of circuits?
> 

ST MFX is based on a STM32L152 with a firmware offering features similar 
to the STMPE (GPIO and TS controller) but also IDD measurement to 
measure the power consumption of the MCU to which MFX is connected to.

> Can we first establish whether this new family is really so
> different from STMPE that it really needs a new driver in
> MFD and GPIO (and I guess pin control as well)?
> 

ST MFX is different from STMPE as far as the HW is completely different.
IDD is a new feature.
TS management is completely different.
GPIO management looks like but is also rather different.
ST MFX counts a first level of 8 interrupts (acked by writing in the ACK 
register), then a second level of 24 interrupts for GPIOs. GPIO IRQ can 
be triggered on low level, falling edge, high level, rising edge. GPIO 
IRQ have to be acked by writing in the GPI_ACK register, GPIO can be 
output open-drain with/without internal pull-up, output push-pull, input 
with pull-up/down, input floating or analog.

> I would be annoyed to see later that it is just a few bytes
> separating it from the STMPE, in that case I think it is
> better to just reuse/improve the good old stmpe driver
> and take it from there.
> 

Sure, but if it was a new STMPE variant, it would be called STMPE24xx or 
something like that (24 GPIOs maximum, 20 if IDD or TS is enabled, 16 if 
IDD and TS are enabled).

Regards,
Amelie

> Yours,
> Linus Walleij
> 
