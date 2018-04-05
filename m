Return-Path: <laurentiu.tudor@nxp.com>
X-Google-Smtp-Source: AIpwx49EJY59lzq8XNb+aXsb29M16aExC7X+wjWTNjcXi45HdFzvC6Z6YIIBMquYWLGxCpNK8Apb
ARC-Seal: i=1; a=rsa-sha256; t=1522939414; cv=none;
        d=google.com; s=arc-20160816;
        b=o2PekDPLXTaCqw17Yb9TmKeGSU6PqUMtNWsmxz8LHrDMpW3cULrj6MkHWD6NoRYTCp
         qP0d786oVpwfBHUka7YeUUiFKuj3d9vTCRpQjjdXJdpvbvQBxcVphdN6HvBXsKM32Hjf
         /6cKzVpWidjoqmWnGLOxKh4KQ7rPcZ9uqHg0T6hG60p5z8/PXs6KsmO7KgARdcSqchKw
         k3hSyMHl4B4Aqg/MOWwt76/F8WQHs3oGDr+4uCJzhFEMk6cDrd/6s8qQoec9fzM844nD
         txbqG26F0rKO5QT3O6foMiqGVAm/uylvOHCkMk4i5klYHjFJYeZbrPiCk0TubP4lKUUH
         KiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=h5ElBt9HcqWT+LLS7XckBi1+I1+rAfVh56XjJXSzmkY=;
        b=xx/gGRHa/iGtTb18dtroL+JelLb7ZEMovP6yBhBo0EO4gjYN2LEyUBhpzzmw8116LQ
         GsdA+f2ZC9oR0eplVxyoQVOkgdfI4//gjlkM1w+nd/HChwyzNkfRI8W8nGZ80pxyMp4W
         FqR/dJqwJ3XQY8visP+Zy4a2vCYzHfUjGt7idVcy5Y6lQ2dCl1gEcWjVDESFVHxmXp0q
         21xOY3tlm/J/in89maab2ys2WctYxcvOAJ6/taieqXE89LWt+PLQSRb6OfsIzjOtH/7m
         00tArseWTy9RD5SD5KuSKgLFzHVhUHk/D+duvWK+IhFMf4B2M9CPq1VG5LlkdgZvhugR
         3cVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=sgYPDbu8;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 104.47.2.82 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=sgYPDbu8;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 104.47.2.82 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Stuart Yoder <stuyoder@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, gregkh <gregkh@linuxfoundation.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Ruxandra Ioana Ciocoi
 Radulescu <ruxandra.radulescu@nxp.com>, Razvan Stefanescu
	<razvan.stefanescu@nxp.com>, Roy Pledge <roy.pledge@nxp.com>, Networking
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Topic: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Index: AQHTwr0s//RURDTyGEKsLhU+ZuPm16PfBFwAgAa39ICAABVLAIAJ+AgAgAATBYCAACYwgIAAnIoAgAFtPQCAABWuAIAACAaAgAAI5gCAACA3AA==
Date: Thu, 5 Apr 2018 14:43:29 +0000
Message-ID: <5AC63610.4000504@nxp.com>
References: <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
 <20180404010549.GA12443@lunn.ch>
 <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
 <20180404124246.GA20869@lunn.ch> <5AC5FAA8.80409@nxp.com>
 <20180405114736.GA12178@lunn.ch> <5AC61393.7090509@nxp.com>
 <20180405124810.GE12178@lunn.ch>
In-Reply-To: <20180405124810.GE12178@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB2301;7:bBFYuAupCyAv7GJoXASEdsIP3ZW8cnfRnAkjz1vWgF2lKZzUBrkqtF5qHTkt/xOYeHAxtjS7iTzmMlyVV7wTFkBlKVfW6RaACHOElKkaxdHft/eupGX4HLutgXHWfWgY2w07LjGPRUU78ZnlrXLjHHRCCclIIYQ9OcjuZvEHH0OZAVqDcxXF056jf1UEI9Ys0iaXKSxLgcl2LKFOyXfbhuFWUpGVV+IkRkuSeQHsOUxPZpAU3vSsXakmHBfXPl0M
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d34ccd9-ccc7-4e03-015c-08d59b03994a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2301;
x-ms-traffictypediagnostic: VI1PR0401MB2301:
x-microsoft-antispam-prvs: <VI1PR0401MB2301CECAF8E0C6DF5C2135DDECBB0@VI1PR0401MB2301.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(84791874153150)(264314650089876);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0401MB2301;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2301;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(39860400002)(346002)(366004)(189003)(199004)(5250100002)(11346002)(2616005)(6246003)(6486002)(81156014)(53546011)(6506007)(25786009)(8676002)(476003)(305945005)(478600001)(486006)(33656002)(3660700001)(39060400002)(3280700002)(59896002)(53936002)(7736002)(106356001)(6916009)(2900100001)(102836004)(97736004)(8936002)(4326008)(105586002)(68736007)(59450400001)(229853002)(99286004)(3846002)(6116002)(80316001)(87266011)(2906002)(65816011)(14454004)(66066001)(316002)(76176011)(6512007)(6306002)(81166006)(966005)(446003)(5660300001)(36756003)(186003)(6436002)(54906003)(86362001)(26005)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2301;H:VI1PR0401MB1856.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: WY3xMoiMiLWf0rcoe6AFipAE5kcFIoYnzOxmjJhLEj4cF+QxXDXEYaWGCxEEWGGAGH/QttFAb4QPc7f8/9eWQMEwLf/VT8awtaKdXko8jwebmglnDrAdD4kQEteof/VAOpZLu/qWMXHxs0rBGp6cT/LDZZE+IaIkiRQhdN+Th+lqCUp0JpU7adZSosV3jYoq1LzuoSbiwVxJ07hq0wpPfedwDbchV/vuG5qMdi4sLT5i1r0Tr84jM33VR3OWrtneXvYdbQIXpRXWR9tQO3D/nbmS6fRhJ7KPHGyJI9yy618NgSknRhHDMDyIDVvK27NXcHO7tTJnX7Fp8Zd2/Fsfyv23V8gVjEeJz2EhvdeldRae4Iet9PWgqnk7155VCkRQ9+oxU+YXdX4cl2La9D+U+b04oZLHbqe8ZZpzlO4QNU4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2407361EDD61CF43A745DD47DA7541B0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d34ccd9-ccc7-4e03-015c-08d59b03994a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 14:43:30.0670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2301
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596917719119784799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andrew,

On 04/05/2018 03:48 PM, Andrew Lunn wrote:
>>> Hi Laurentiu
>>>
>>> So i can use switchdev without it? I can modprobe the switchdev
>>> driver, all the physical interfaces will appear, and i can use ip addr
>>> add etc. I do not need to use a user space tool at all in order to use
>>> the network functionality?
>>
>> Absolutely!
>
> Great.
>
> Then the easiest way forwards is to simply drop the IOCTL code for the
> moment. Get the basic support for the hardware into the kernel
> first. Then come back later to look at dynamic behaviour which needs
> some form of configuration.

Hmm, not sure I understand. We already have a fully functional ethernet=20
driver [1] and a switch driver [2] ...

>> In normal use cases the system designer, depending on the requirements,
>> configures the various devices that it desires through a firmware
>> configuration (think something like a device tree). The devices
>> configured are presented on the mc-bus and probed normally by the
>> kernel. The standard networking linux tools can be used as expected.
>
> So what you should probably do is start a discussion on what this
> device tree binding looks like. But you need to be careful even
> here. Device tree describes the hardware, not how you configure the
> hardware. So maybe DT does not actually fit.

It's not an actual device tree, but a configuration file that happens to=20
reuse the DTS format. I guess my analogy with a device tree was not the=20
best.
Detailed documentation on the syntax can be found here [3], chapter 22.

[1]=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/staging/fsl-dpaa2/ethernet
[2]=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/staging/fsl-dpaa2/ethsw
[3] https://www.nxp.com/docs/en/user-guide/DPAA2_UM.pdf

---
Best Regards, Laurentiu=
