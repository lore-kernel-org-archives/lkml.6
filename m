Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AIpwx4+1V3P6OdNVaPFbCiCZ4p1zmJNlUXtutqhZaMhn1DXZByCTnX7ex9T8zzU6qzfncgY8Ai/E
ARC-Seal: i=1; a=rsa-sha256; t=1524145525; cv=none;
        d=google.com; s=arc-20160816;
        b=k52FGfitlljxaNvWXklEUydW8PlqB/+z5veVQxzPEHl2zB5RlAxiRYyaOaGA3nS1dH
         RfswtF18FskISRCyK6gxQyp1r6Hy26zuiKbcE/QqJ+/IuGVbHizG1AhlLVOs2jm7OJ8z
         pXlbK4io9lQZ5HW8VMPasaUtE6d1fkvEVPGvtTKJevjMVcrFEOHJNbibTg6vOTQuEMUN
         /BG/QRGTSjrAsUUgHod96WSUo16id0hxOAw1xNpR1/RL1YMUEG7cyjuCl9oU10kcupWl
         /CgB8+ymBEVpal1VAkq6kcBnpEvFnBHRnPaRCTBsN5e4wzVgYshDvbqBBjtFu5PZ2f47
         MuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=rOhcoz5i0xXRvFQrqga2+D0Hn6vUwn56Ts49Eiui0bE=;
        b=nkbrBo927U0IfYLsPPjciwZJ0tsPQIV8+EPrA1UGal/A0+yTeLagrCs2VhR0PNh8+l
         phsUhHJ84x1Uo4WVRa58MkOXXq67lQEl8u7r7a3s72IVBkynRmyJg9YpIUlJbEGRgw3W
         Ywj+SSpKUKxHcdNWLrP7oMJhShTsyhqkO3oe9TcoSd1/nw3LCM4a6Fs33YFd0ROT3J3E
         t9foKf5uscH2M5wpKsDzsgjSkcd7lKU+wbziMtkEJskC7Dbvw1owMBeyWF6iSjMAX2EH
         h1fuuBwur4JxjD8lSJ4MVDdEkx6NlQoWo5/oehs/A6ctXxCJm5NB4U0mqY0B3anyds2g
         +A6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Subject: Re: [PATCH] HISI LPC: Add Kconfig MFD_CORE dependency
To: Arnd Bergmann <arnd@arndb.de>
References: <1524138946-136701-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a1nen_EoyZ63p_EfSu51wUAbLigzbrv3K4byS2gUo9CjQ@mail.gmail.com>
 <026e9f13-7201-57a5-a4b3-8c48a89bf134@huawei.com>
 <CAK8P3a2rfFvQdSaGjqtk=kz75tW9JNFdqeUiX6JBWJdM658T2Q@mail.gmail.com>
CC: "xuwei (O)" <xuwei5@huawei.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, gregkh
	<gregkh@linuxfoundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>,
	Robin Murphy <robin.murphy@arm.com>, Sebastien Bourdelin
	<sebastien.bourdelin@savoirfairelinux.com>, <bogdan.purcareata@nxp.com>,
	"Tony Lindgren" <tony@atomide.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, Bjorn Helgaas
	<helgaas@kernel.org>, Olof Johansson <olof@lixom.net>, Kevin Hilman
	<khilman@kernel.org>, <tanxiaojun@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <4b7f5a22-e820-2918-aa91-b41da1f03451@huawei.com>
Date: Thu, 19 Apr 2018 14:42:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2rfFvQdSaGjqtk=kz75tW9JNFdqeUiX6JBWJdM658T2Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598175575431248949?=
X-GMAIL-MSGID: =?utf-8?q?1598182418929720476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 19/04/2018 14:29, Arnd Bergmann wrote:
> On Thu, Apr 19, 2018 at 3:08 PM, John Garry <john.garry@huawei.com> wrote:
>> On 19/04/2018 13:00, Arnd Bergmann wrote:
>>>
>>> On Thu, Apr 19, 2018 at 1:55 PM, John Garry <john.garry@huawei.com> wrote:
>>>>
>>>> For ACPI support of the HiSilicon LPC driver we depend
>>>> on MFD_CORE config.
>>>>
>>>> Currently the HiSi LPC Kconfig entry does not define this
>>>> dependency, so add it.
>>>>
>>>> Fixes: e0aa1563f894 ("HISI LPC: Add ACPI support")
>>>> Reported-and-tested-by: Tan Xiaojun <tanxiaojun@huawei.com>
>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>
>>>
>>> Can you explain the specific dependency? Normally MFD_CORE gets
>>> selected by an MFD driver but not other drivers.
>>>
>>
>> For each device on the LPC bus we create an MFD.
>>
>> The reason we do this is that we need to set the resources of the derived
>> MFD, as we should not modify the original ACPI device created in ACPI scan.
>> Details are in the log for e0aa1563f894.
>>
>> Shall I update commit message updated with this info? Or were you just
>> interested in the motivation for using MFD?
>
> I think it would be good to update the description. I had missed the part
> where an LPC device becomes a platform_device through an mfd_cell
> rather than becoming a device with bus_type=&isa_bus_type as I think
> was the case in earlier versions of your patch series.
>

OK, fine. FYI, this was originally discussed here: 
https://lkml.org/lkml/2017/6/13/602

BTW, as for merging patches for this driver, it would seem the right 
place for it to go through arm/soc tree (obviously depending on 
dependencies). Since xuwei is away this week, could you kindly pick up 
v2 for fixes?

Thanks,
John


>      Arnd
>
> .
>
