Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427055AbeCBQLL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:11:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1424002AbeCBQLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:11:09 -0500
Subject: Re: [PATCH v2 1/8] dt-bindings: scsi: hisi_sas: add an property of
 signal attenuation
To: Rob Herring <robh+dt@kernel.org>
References: <1520003182-26277-1-git-send-email-john.garry@huawei.com>
 <1520003182-26277-2-git-send-email-john.garry@huawei.com>
 <CAL_JsqJNxxyBDk_u=Wf2vGbgwa7act2NNc+zmxP7Ne80bFGqRA@mail.gmail.com>
CC: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <7f62130c-723a-c9ab-533b-48e8addf3dba@huawei.com>
Date: Fri, 2 Mar 2018 16:10:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJNxxyBDk_u=Wf2vGbgwa7act2NNc+zmxP7Ne80bFGqRA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2018 15:57, Rob Herring wrote:
> On Fri, Mar 2, 2018 at 9:06 AM, John Garry <john.garry@huawei.com> wrote:
>> > From: Xiaofei Tan <tanxiaofei@huawei.com>
>> >
>> > For some new boards with hip07 chipset we are required to
>> > set PHY config registers differently. The hw property which
>> > determines how to set these registers is in the PHY signal
>> > attenuation readings.
>> >
>> > This patch add an devicetree property, hisi-signal-attenuation,
>> > which is used to describe the signal attenuation of an board.
>> >
>> > Cc: Rob Herring <robh+dt@kernel.org>
>> > Cc: Mark Rutland <mark.rutland@arm.com>
>> > Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> > Signed-off-by: John Garry <john.garry@huawei.com>
>> > ---
>> >  Documentation/devicetree/bindings/scsi/hisilicon-sas.txt | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt b/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
>> > index df3bef7..6f6876a 100644
>> > --- a/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
>> > +++ b/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
>> > @@ -53,6 +53,13 @@ Main node required properties:
>> >  Optional main node properties:
>> >   - hip06-sas-v2-quirk-amt : when set, indicates that the v2 controller has the
>> >                             "am-max-transmissions" limitation.
>> > + - hisi-signal-attenuation : array of 3 32-bit values, containing de-emphasis,
> The format for vendor prefixes is: <vendor prefix>,property-name
>
> And should only be ones defined in vendor-prefixes.txt

Hi Rob,

To save a v4, that would be "hisilicon,signal-attenuation", right?

Thanks,
John

>
>> > +               preshoot, and boost attenuation readings for the board. They
>> > +               are used to describe the signal attenuation of the board. These
