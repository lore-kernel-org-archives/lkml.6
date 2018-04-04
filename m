Return-Path: <decui@microsoft.com>
X-Google-Smtp-Source: AIpwx4/LGereJ6yM7y8fotZW4rvC/zzbTlhMibyuSqkDjifv27ETMncfHGhI8Gxs3VBy/RAeEK2D
ARC-Seal: i=1; a=rsa-sha256; t=1522884656; cv=none;
        d=google.com; s=arc-20160816;
        b=JWiMhIpNG2R3jhEHoVeDHnFtcSjpKf1be8vsgVExM9TeWLfPS+2ezj8CQeICCxkYum
         LbmnCTJz0h3ZiTkzRy1HLFg5PuhccrC+ulKN7sbzi0jyu2UxioheS9YEuFxVx4bsd2ky
         Xz01mopXv49W3qpsq7jWryZCkYmQaqPRFNFkbkD3EjkKGKbnV3VjQNvYZ182Rf0Vj+9f
         3Jtsm5WaJBWXcvAmLLQmkt846e5BppG8lJ9RldntCqCBZ0YMryL6246/ges3TJJbs2uY
         x39jxjN+mgBlZ3E6ISg1RuysWVOqhhWmuWVepuZBs+AYYCrZf1xbDBQkd/zpUYidfGLZ
         qiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:msip_labels:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=10cbPTmaks4v7McnLGwuSX4YNMW9wHkURWkC1z0S+ho=;
        b=rWLgsgrqBF3y9sQAh4QYBzlDunvw1z3lW6mdQCQg4gVKanG4Y9GyJropm4Yx3yONRB
         xnINyAWdyRiRHGXjK2MTqSjLgd/Ek9IueAERDpfIvmya+FxlZmx0RhAcUxo1DEOY3Z1C
         91bI1t9YrdquJ0RnmS8OrOa7b0a3o5PbPf4nVrGhrkR+UbHrfrrEHsjScnYNOF5Gbd7N
         KHdS1A9PVJ7hGIW1j0bdTBQOJw13z/biM9qb5d/4YzCDanjsZKuIgycdh+BVd4LQI/qK
         cMuOQw2vGB3lTQ/ZfftrS10eBEZ4mqhhwiXHduB30yWO+HOOEMtocPVT6mhIMW4ZkXdm
         ZRIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=eCn8TPj6;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.124.105 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=eCn8TPj6;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.124.105 as permitted sender) smtp.mailfrom=decui@microsoft.com;
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
Thread-Index: AdPMU2bePo5Nuk30RL6D7Rk31Sbv+QAD1caAAABy26A=
Date: Wed, 4 Apr 2018 23:30:38 +0000
Message-ID: <KL1P15301MB0006F72E1B341AA0F58613CBBFA40@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB000638051CC8DC7FD2A2E74BBFA40@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.21.1804050004230.1492@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1804050004230.1492@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-04T23:30:36.8557652Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:3::45a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0021;7:WhABs2aAwj+fGXDenKDs28S2z3jW3cboUcaxGFry47WACfd0a06wyfOY74U0j6nHZ5sYp6kO/IEaqZ2YcYtGFmuM/ApSDRmu67Hja0qUM9Cj0s/XR0Utn4r5Kn0xE3bXeTbi1pp0i/Jm/ahiaVfruZnYqjXtH4XyPTAnzKY0h15W3ufLh8Ux90XKuPD8d6ENz2WOTmOMWpYzLCdOg7i4dH14yFO1AVhMgUcl18/rBewgW2nbRt44KCenHEXEV3f9;20:RlXYZmwgCIIyVSerKdIowKtvnjoV5NU6KwR2H2BQaa33mswz9MsSX1XnQaPw+QyxSiGT8o6Iq8ahzESD8SzXHiGP74oNPUqh8QSINpVS4c7J3V+UthFHrTz+/8DmLwugGBgrIpm7NS13F5GQ5XXCkwv+FBwrm0KKEbmOe6hDSfs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 826c5773-76c3-40a7-cfa9-08d59a841379
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0021;
x-ms-traffictypediagnostic: KL1P15301MB0021:
x-microsoft-antispam-prvs: <KL1P15301MB0021A29CB7D964D0A931F614BFA40@KL1P15301MB0021.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:KL1P15301MB0021;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0021;
x-forefront-prvs: 0632519F33
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(51914003)(199004)(189003)(68736007)(54906003)(81156014)(8676002)(9686003)(6916009)(105586002)(478600001)(55016002)(106356001)(8936002)(97736004)(6506007)(33656002)(316002)(476003)(11346002)(99286004)(229853002)(446003)(81166006)(59450400001)(4326008)(7696005)(486006)(25786009)(76176011)(22452003)(186003)(14454004)(305945005)(77096007)(8990500004)(10090500001)(46003)(7736002)(102836004)(86362001)(6246003)(74316002)(2906002)(6116002)(10290500003)(53936002)(2900100001)(3280700002)(86612001)(3660700001)(6436002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0021;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SeJCr9wajFxpSt0YqNKvZY/W0jHFn6ASBYLeeRE7nLwaEFEOyrxgUB38ZR8nc86Jw+z6O2uzazTzPE5557+n/vf9pK41isUbA+AGHd/GxkYclauRJKmnT6AMQzxAQJJKZ5WPQPaOEaC6zDtH9TCQez7WShk/ZDpYJt0eQmFwAUKTMJOSusS3eZ5B4GC1xs2EMeq9zoNLgpfnTnupV4Ho5erRtnnqdYLvL/d6D8ZK5hp5N1K8oNXZEG7TaQoC03nGnizoJISB1FUs/0KfUJVXDThCdQZo5xggoltzdKGXZTmR+XAk+WQ9ROWgzf4E6MzWWf1NsKZg8Ksoa7QPL8IIXH58a6JBqfAoBW+vJdu7mquPOztPXQ8KHhAP7xqVyEr5zKRdvZcVux+cmhWnmZ2qssgPFVVS0bTH9MuOmGT1XwQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826c5773-76c3-40a7-cfa9-08d59a841379
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2018 23:30:39.0139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0021
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596849968280484666?=
X-GMAIL-MSGID: =?utf-8?q?1596860301224602443?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Thomas Gleixner
> > I'm wondering if there is such a standard kernel API on x86.
> > As I skimmed through the code, I haven't found it yet, if any.
> >
> We don't have a simple way to do such allocations because they involve ID=
T
> entry manipulation.

Hi tglx,
Thanks for the quick detailed reply!
=20
> If there is no hard requirement that this stuff runs through an direct
> vector, then we could simply make these interrupts go through the normal
> interrupt path. That means you have to request them like regular device
> interrupts and the handling path is slightly longer than the direct vecto=
r
> mode. You'd get virtual interrupt numbers per cpu which also show up in
> /proc/interrupts as separate lines.
>=20
> That needs a very simple and minimal virtual interrupt controller driver
> which is mostly a dummy implementation except for the activation function
> which would allow you to retrieve the vector number and store it in the
> MSR.

Can you please give a little more guidance? e.g. is there any similar drive=
r,
any pointer to the required APIs, etc.=20
I guess I need to dig into stuff like=20
struct irq_domain_ops x86_vector_domain_ops and request_percpu_irq().
Your quick pointer would help a lot!

> There are a few details to be hashed out vs. CPU hotplug, but we have all
> the infrastructure in place to deal with that.
Sounds great!

BTW, so far, Hyper-V doesn't support CPU hotplug, but it supports dynamic
CPU online/offline . I guess I must also consider CPU online/offline here.

Thanks
-- Dexuan
