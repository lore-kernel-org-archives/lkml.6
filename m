Return-Path: <decui@microsoft.com>
X-Google-Smtp-Source: AIpwx4+48a9LOuvCih9ySuHV48DYdhHXGDGi6KA87Pvh/3BQOPCGKS4KUwyMZxQ8n+72TCp27MW4
ARC-Seal: i=1; a=rsa-sha256; t=1522950767; cv=none;
        d=google.com; s=arc-20160816;
        b=mL0NbAwwU1FZf15/UjIkOUVvrYpqfEOznnI1EPOvB2FCltuaD5p0QhPYohuYeGWD6G
         5GcLhkTdYEqMoxB3CNIva/sQocBumXBVP4FOihRgEOBllFMhIT74saHD3gzFpwlzz8ln
         tsBgPJphDU3E/7NwTTE5D5m4x5T0NGkbsNprAbPLt6Cj15gGNj2y1gQUKn3HP34u4PEE
         TVoX6LlLuM1j/IhF+n+nMFAujLL3vTrg3Kc065XkWZvxi2W9Gd81/kaaXskDRUry9qwX
         1XqvrB6q2IfwWwePa7rCdTgW0SecmPRecB9F1q39C6zTStafLd5ZVOdhIbKRY+lhfB8M
         EPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:msip_labels:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=br7dqXt1/PO6J1zn839UYJW0nw87TfLZVwESksMhxY4=;
        b=QmQ7uq8rYlcvK7YBQHUq7dkI3CTOUMZPd48dtR6uxwTMV1uGWUYBTtgo+wSmkWGKVQ
         lql9ykScYSRmgKBRM7WsGjPKzBcF53apNtUnNZSjz8G5Qm+gbOCi36ZPItOA1R9VohyY
         z/sQoW1vnxUAU37iEnRDv/gBa4xuQ7lSJvd+0bT9oiX2fbpjRTdhMJLYLPrqjp/g5Rkh
         45gL5gAriqH+9rsE/Km2dUGEY9fdzij3ptHxlOAjPNmUzowxZV9DOmX9Py32FrCGVAkX
         pbvF8AHe15elJQo+ZXcmhitIol+Fz6122RtHBqHSe5ZEm0LghrVXbJOaAp1vPRcXl7hu
         Ga/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=KezihCmk;
       spf=pass (google.com: domain of decui@microsoft.com designates 40.107.128.94 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=KezihCmk;
       spf=pass (google.com: domain of decui@microsoft.com designates 40.107.128.94 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Dexuan Cui <decui@microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: 'Greg KH' <gregkh@linuxfoundation.org>, "Michael Kelley (EOSG)"
	<Michael.H.Kelley@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: RE: Any standard kernel API to dynamically allocate/free per-cpu
 vectors on x86?
Thread-Topic: Any standard kernel API to dynamically allocate/free per-cpu
 vectors on x86?
Thread-Index: AdPMU2bePo5Nuk30RL6D7Rk31Sbv+QAD1caAAABy26AAHVFNgAALBUkA
Date: Thu, 5 Apr 2018 17:52:38 +0000
Message-ID: <PS1P15301MB001165D1D2CB4335D79F14CABFBB0@PS1P15301MB0011.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB000638051CC8DC7FD2A2E74BBFA40@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.21.1804050004230.1492@nanos.tec.linutronix.de>
 <KL1P15301MB0006F72E1B341AA0F58613CBBFA40@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.21.1804051215110.2204@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1804051215110.2204@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-05T17:52:36.8484151Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8::6e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PS1P15301MB0011;7:a9W4FuY5oKhSrzL1wslFrPn/pgtmZbrRugmdp0ivMcYbhRw0LdFieAVLMmbcANriCD4ww3to+lgYqE1jbc9MYmDrZDFHSYZoSX8HzomtL2J3Q2bVTslf7lu5ObUl4QhvCw60/I/gUOojD2dzzUbbGKrU7RCjH+ZVvbs/ErNeD70fGz8bi3AZfLHTi97ieti/3bzKAdy007EFVKZODvpN8u1HU/tVqHjfJ69MnhyYMBe5OoL7I3+5oH2IZjYGQ2oA;20:ue29SnZfl+eCt1E0qy8w0Wq9tEksuCkiZ8I2lF7qySRExKdtW1BhG9VPKKYBxK5rHi0t9epMGwlsPxq6ZmpjsNoB0JueTMlQju+U7HYZW+y0eGE2+cDbg7qER/UqRHZZmhEmOyUzlyuVrjeEhcLF7+bwZtEeC+0v3yXjiSFghnk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32114d7b-8a42-4acd-d3de-08d59b1e058d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:PS1P15301MB0011;
x-ms-traffictypediagnostic: PS1P15301MB0011:
x-microsoft-antispam-prvs: <PS1P15301MB0011FD548E5381BCEC344C2ABFBB0@PS1P15301MB0011.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:PS1P15301MB0011;BCL:0;PCL:0;RULEID:;SRVR:PS1P15301MB0011;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(376002)(39850400004)(346002)(189003)(199004)(51914003)(7696005)(3280700002)(9686003)(6116002)(68736007)(97736004)(53936002)(229853002)(86362001)(8990500004)(81166006)(81156014)(14454004)(316002)(6916009)(2906002)(478600001)(22452003)(8676002)(93886005)(5250100002)(6246003)(3660700001)(33656002)(106356001)(8936002)(105586002)(4326008)(76176011)(46003)(86612001)(10090500001)(6506007)(186003)(2900100001)(59450400001)(74316002)(10290500003)(305945005)(5660300001)(99286004)(54906003)(25786009)(7736002)(486006)(6436002)(446003)(11346002)(55016002)(102836004)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:PS1P15301MB0011;H:PS1P15301MB0011.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4i/QltlgKftXKxO3jgt9tFPIxwY4/swYicciwBZsEMGOZdAzG3c/TEZDP6uPble3T7hGe8hySC7WzOh2h1JFt2rfgnNktI3rslScWFRmeoM5nIonN5ZxVrtSFFl6mlBdQyIUWimPkJNmxoJljUN2J1PNmzuYnSRmVlxiddGEYPImo0jMAjYrx/ZB4NCwKNmUCZXCoHGioMAGI1O2Fq/qrI81FfiI+m2HOoEB8v7QO6tPdyytThvRQw/HRk8+QhScBlReDf32KQQBNRVYPO4AVVNDFW1G84xUJ4NGqhH4vVoeO8FUy4TYx+ld7GpZnZAUoUOTEVz8G2oQd38wXxbsmFmO3l7buVgSGAQQ2WLiJ5VM+lGdSXOC7BqYsNTKSJEi6Wai85jhuEVYF+KwClJlukRcSRTRFJznLeZccPQkLWM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32114d7b-8a42-4acd-d3de-08d59b1e058d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 17:52:38.3765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1P15301MB0011
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596849968280484666?=
X-GMAIL-MSGID: =?utf-8?q?1596929623693776172?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Thomas Gleixner
> > Can you please give a little more guidance? e.g. is there any similar d=
river,
> > any pointer to the required APIs, etc.
> > Your quick pointer would help a lot!
> >
> > BTW, so far, Hyper-V doesn't support CPU hotplug, but it supports dynam=
ic
> > CPU online/offline . I guess I must also consider CPU online/offline he=
re.
>=20
> Yes, that's all covered. The trick is to use the affinity managed interru=
pt
> facility for these per cpu interrupts and then the cpu online/offline cas=
e
> including physical(virtual) hotplug is dealt with automagically. You
> request the irqs once with request_irq() and they stay requested for the
> life time. No action required on the driver side for CPU online/offline
> events vs. the interrupt.

Thanks for the guidance!
=20
> Find below a hastily cobbled together minimal starting point. You need to
> fill in the gaps by looking at similar implementations: ioapic for some
> stuff and the way simpler UV code in x86/platform/uv/uv_irq.c for most of
> it.
>=20
> Hope that helps. If you have questions or run into limitations, feel free
> to ask.

This definitely helps a lot!!! I didn't expect you would write a lot of sam=
ple
Code here! I think I have a very good starting point now. :-)

Thanks again!

Thanks,
-- Dexuan
