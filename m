Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B39C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA95218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GOvXdVBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfAWWIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:08:53 -0500
Received: from mail-eopbgr820099.outbound.protection.outlook.com ([40.107.82.99]:54328
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbfAWWIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vkrOyL4EDtAbIMQ8jGkcbQM7Mn0qTN7kZsNaL0QFgE=;
 b=GOvXdVBFrTa6xB5WRd6enbXHbCs1ZEB1PU+PRskIS3I4XveX/ZzWuaDTqvyk1hpDV6XNgK8mYHYwNM0aBwJ3OUUCitKdgByMil/p7266U1V6XFMv0aowa6PfXxbYv6qjKwN0adZqipv/1pr37p34DgBZiR1UTuIZOmi84kn46Qo=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.2; Wed, 23 Jan 2019 22:08:08 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::8105:4560:a8e4:d18]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::8105:4560:a8e4:d18%3]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 22:08:08 +0000
From:   Rui Zhao <ruizhao@microsoft.com>
To:     James Morse <james.morse@arm.com>
CC:     Sasha Levin <sashal@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kernel <linux-kernel@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "okaya@kernel.org" <okaya@kernel.org>
Subject: RE: [PATCH] EDAC, dmc520:: add DMC520 EDAC driver
Thread-Topic: [PATCH] EDAC, dmc520:: add DMC520 EDAC driver
Thread-Index: AQHUr0oncrkPcrT8ZkiCJkyHP8fACaW5+YsAgAIO9dSAAS4AgIAAJNag
Date:   Wed, 23 Jan 2019 22:08:08 +0000
Message-ID: <MW2PR2101MB09708B7F11BDEE6755CC9F03B3990@MW2PR2101MB0970.namprd21.prod.outlook.com>
References: <20190118162324.17123-1-sashal@kernel.org>
 <0866a996-49f7-1498-4653-20232bef2f46@arm.com>
 <MW2PR2101MB09701C705250DAC025AFC251B3990@MW2PR2101MB0970.namprd21.prod.outlook.com>
 <7d404c61-a916-5d5e-35cc-0f6f016cd8a9@arm.com>
In-Reply-To: <7d404c61-a916-5d5e-35cc-0f6f016cd8a9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=ruizhao@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-23T22:08:02.0691718Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c346fed7-417e-4fae-a7dc-bd2786c9fb55;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:2:4135:ab3e:d000:a61c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;6:EHvn8y1aWbHB928RE+5WRFNmlkSRtMaUHq3B6WkV/YqlAh3E2cW0hBHJrxxgGdHWWm4zN8+k0dEmabJidqaRCkvcuoNLD2ztm5cBPBnDNAPhuWkdY1PJ/wRxv6Xjdn1xtU3lStf8N+yYRaaaYW+dTcV148hWnGxOEGgDpkm3pVbj3mCdjRREcevuROWLWQxdQrSo82C4V0lYppqoktoj5MMxWCOMok8IJrs+up5Q/557eBQnAhxVFr5X/9mWkTTp9J61CATgYjgpvylz136nBliqXkXIMvoZ/rnNQi2wxKDzcxDafcc/Luf3uizbSKpNw8FBrxm9jN1t1MO0j9QzhfOYzUzCDUO37tw32I+epGdQXKWuUIY8Z1doULooRhsDSV3c87hM2ImQv6PPe6kbqjw3ADdrg8sGqFZqQ7R0xxSaEgCqzLo+yzfX274gdjf024lYkQhtji7qdOpEVqEWVg==;5:9f60PNrc/Xqx0cnAa5h5j99hyB3IrYF02cAUMevc8bObL5a45nnEXRhX5wY061OMsNJqEuLdRJFf+dixhvqXaXNIg9MzicdVjxPP/l6RY8Quge9UUS9VnQFzvodhQ4SSDe85L6GNtQgtueFDnx6vJh/GRxmYty7k13XBrfuR3iaJx1zMw9IA9YUkjR1qFzaFvoKQb01+oOzH1K4RrDIE/g==;7:n0W519U34PDa+EN7+Tg24/0XsrZmZ76dHQmc3IyOeDVc++naCW/Ed0hYzFg3mdyjNZNU6GFVRDvlcmvH0EOohMPdHZGl3PjuO6rH90j1sNG9Jt59l86RHherutXxtSUesIGfctkJyyjB3nAkmIpVsw==
x-ms-office365-filtering-correlation-id: b50f3b1c-4b35-4713-e414-08d6817f41cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
x-ms-exchange-purlcount: -3
x-microsoft-antispam-prvs: <MW2PR2101MB102016FE5DBD4318AA7EB878B3990@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(22452003)(99286004)(74316002)(14454004)(71200400001)(71190400001)(7736002)(81156014)(81166006)(305945005)(8676002)(446003)(11346002)(86612001)(8936002)(106356001)(316002)(10290500003)(486006)(478600001)(46003)(33656002)(25786009)(476003)(6436002)(55016002)(54906003)(6916009)(229853002)(7696005)(76176011)(93886005)(68736007)(4326008)(10090500001)(6506007)(6346003)(102836004)(105586002)(8990500004)(6246003)(186003)(53546011)(256004)(86362001)(14444005)(9686003)(97736004)(2906002)(6116002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruizhao@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6KlXE26gbcC8rdZhcYcvIjpE65CvkdNbJ+cHWdH7uVakU//IzRHu4lrUpa8DHKtfN3prS7CR8AddR/zhJAF56lLvuC6ExbdgKQwzpZpCs4HsqsrtPa77ojvze3icgUT+M0uZ+OHb/TcqFXjEoqOw4pfm3WrLO2nWCP0bbvZaqYouyk7Z/TqOCao5nfu6ynV9YqG8sJ6T3chy3w9XHm5t2upVbyIwedF2OkB/XQ5EbS4oHg7KpIRqR2BUXlaUEzjXTa0mgbknPn+dJqEk+w68Xsh0QQoql8oDH6SLXU0iV3divo0kf0NfdYMP1B25eRpuvHLO6IJDZMar12p5AvTiBqnjnIDXbhDzxNguDDnUwQ5e5z0WGo/9667QTsJ5V6q4SfrHlajWYsAtcFDXHl7taKQ0Q+Cn2BwkBLEDjuP2gMo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50f3b1c-4b35-4713-e414-08d6817f41cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 22:08:08.2135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Wednesday, January 23, 2019 10:36 AM, James Morse wrote:
> When the time comes, could you post a dt-binding as the first patch? Thes=
e add the documentation under Documentation/device-tree/bindings, and need =
to be CC'd to the DT folks.

Sure, will do.

>> Will change scrub_mode to HW.

> Do we know its enabled? This is something firmware has to set up, someone=
 else's platform may do it differently.
> I think should read one of the scrub control registers to find out if its=
 turned on.
> But, I can't find what uses this value ...

Looks like if scrub_mode is set to SCRUB_SW_SRC, the MC core will do arch s=
pecific sw scrub on the page with ce error.=20
We can config the mode base on register settings.

>>>> +     /* Enable interrupts */
>>>> +     dmc520_write_reg(edac,
>>>> +                      DRAM_ECC_INT_CE_MASK | DRAM_ECC_INT_UE_MASK,
>>>> +                      REG_OFFSET_INTERRUPT_CONTROL);

>>> What if they were enabled before? (e.g. enabled by firmware, the=20
>>> bootloader or kdump). If they're already enabled, can we race with=20
>>> the interrupt handler on another CPU and get double reporting of the er=
ror counter?

>> We don't expect interrupts to be enabled by firmware or bootloader if=20
>> this driver is enabled.

> What about a previous instance of this driver? Linux supports kexec, kdum=
p and hibernate, all of which cause us to inherit a slightly used platform.

Agreed. We shouldn't make assumption on the register value when driver star=
ts.

>> If firmware enables it, they're suppose to handle the interrupt.

> Ah, so you still have resident firmware!
> How come your firmware trusts linux not to turn off the memory controller=
?!
> These things are usually protected by trust zone so the OS can't pull the=
 memory from under firmware's feet.

We have firmware to config the memory controller and want to have an EDAC d=
river to report ECC status.
Could you please elaborate a bit on the security concern on this approach? =
Like some malicious app/driver can access
memory controller registers can cause issue?=20

What's the recommend approach if Linux won't be able to access memory contr=
oller registers? Have firmware do the ECC=20
status monitoring and some sort of driver to query ECC status from firmware=
?

Appreciate your insights on this.

Thanks,
Rui
