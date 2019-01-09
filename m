Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D97DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5D420821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfAICVc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:21:32 -0500
Received: from [223.203.96.18] ([223.203.96.18]:24153 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728403AbfAICVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:21:32 -0500
X-Greylist: delayed 665 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 21:21:26 EST
X-ASG-Debug-ID: 1546999814-107606139f166050001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda02.hxt-semitech.com with ESMTP id xJ5qzBrsFgVJJzdm (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 09 Jan 2019 10:10:14 +0800 (CST)
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Jan 2019 10:10:08 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Wed, 9 Jan 2019 10:10:08 +0800
From:   "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sinan Kaya <okaya@kernel.org>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Cercueil <paul@crapouillou.net>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        "Chunyan Zhang" <chunyan.zhang@unisoc.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Alex Smith <alex.smith@imgtec.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>,
        Philip Elcan <pelcan@codeaurora.org>
Subject: Re: [PATCH v6 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
Thread-Topic: [PATCH v6 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
X-ASG-Orig-Subj: Re: [PATCH v6 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
Thread-Index: AQHUpoamtDDrGkzszECfCCh3iabD7g==
Date:   Wed, 9 Jan 2019 02:10:08 +0000
Message-ID: <532b0481985641138516730fe01290d9@HXTBJIDCEMVIW02.hxtcorp.net>
References: <20190105100606.6673-1-okaya@kernel.org>
 <20190105100606.6673-10-okaya@kernel.org>
 <CAJZ5v0gXM3d0uuaQPyeafVS3S1tNbo0gY5TMskpQptNGvmVKzA@mail.gmail.com>
 <39fa9438-8928-5a1b-2a86-617df39e4c73@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.208]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1546999814
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 1437
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4800 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65355
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/7 20:43, Adrian Hunter wrote:
> On 7/01/19 1:17 PM, Rafael J. Wysocki wrote:
>> On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:
>>> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
>>> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
>>> satisfied implicitly through dependencies on CONFIG_ACPI have to be
>>> specified directly. This driver relies on IOSF_MBI and IOSF_MBI depends
>>> on PCI. For this reason, add a direct dependency to CONFIG_PCI here.
>>>
>>> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
>>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>>> ---
>>>  drivers/mmc/host/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>> index e26b8145efb3..1b9401fe94c0 100644
>>> --- a/drivers/mmc/host/Kconfig
>>> +++ b/drivers/mmc/host/Kconfig
>>> @@ -116,7 +116,7 @@ config MMC_RICOH_MMC
>>>
>>>  config MMC_SDHCI_ACPI
>>>         tristate "SDHCI support for ACPI enumerated SDHCI controllers"
>>> -       depends on MMC_SDHCI && ACPI
>>> +       depends on MMC_SDHCI && ACPI && PCI
>>>         select IOSF_MBI if X86
>>>         help
>>>           This selects support for ACPI enumerated SDHCI controllers,
>>> --
>> Any objections against this one from anyone?
> + QCOM and AMD contributors
>
No issue with QCOM.

Cheers
Dongsheng

