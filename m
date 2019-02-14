Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33DEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE4520835
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="QIQ6ZVzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502093AbfBNP3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:29:00 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:53748 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbfBNP27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:28:59 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id B4/25-13147-639856C5; Thu, 14 Feb 2019 15:28:54 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSWUwTURSGuTPT6UAYGQqGQwUTm/gg0Erjwui
  Tog9V48oDiUFlgKFtUgq2RdFEw9aguC8YJUBbQFRAMDVRREVj3OpeJUpEFGVwgWBAMaiosdMp
  Lm9fzvffe869ORSu6CSVFF9g4y1mzqQiQwjDTHKWes5OPi2xZ3Ae213hwdiSulaSLW+6QLAdI
  y0Y+6S9imRrG+w4K7juYQvkOqc7X1fjWa27Ut0s110YK5TrPrunrpKtlRnNGbkF6TJDY69Lnl
  emLPhV9AIrRLsjy1EIRTCtOFR2lmPlKJhSMBUY7OhNFYWC6UNgbz7nFyTDwqHbvaTIkcw6GDr
  XSoghnHFgcNrxEokiglkCR0YEJIWWwoehfkLiVPh585i/TjDTQbCX+i+lGQ4+n2/CpG6fMDhY
  5PGLYEYDJXs7/YyYWBgtasJFxpkoeC44/HVgGKi/9BCXeDJ86Pslk/I8eIq7kFRPgPvPhACro
  Kb6eoBj4bFjV4CXg7fqqX8IYPoRnP94VzZx+E3P8UCIhfpddkJiJdz23pBJBwZpOPhkNBDKA2
  /7uFziGHh62EVKoREZDLytIaUfzoTh6vuB0FRo3POa2I/iK/95ncQJ4Lz4iZQ4Hhpcg3il/8v
  CwXNMIJyIaETzMixGvcGWwxlNam1iolqrnaXWqrVJrIbbquY0fL46kzfbLJzParjNVo11S06m
  KUtj5m1u5NuwrI3I3YYOn9BfQ9EUpppM6xbzaYpJGblZWwyc1bDBkm/irddQDEWpgF6xw+fCL
  byeL8g2mnxrOqGBClVF0rNFTVvzuByrUS+pO0hNXa19XY0rCHOumVdG0c4yX4gRQ4Z8858rJp
  b9MYpVRtAoKChIEZrHW3KMtv/9AIqikCqCzhZbhRrNtj+dBnxDYL4h+iOzxCFs3F+lLERnwkJ
  KZTHpWFtadKmJVnpThvq2OUaqFq/MTVj/arsrTEj++kCX1POu7nJt1bezRzfBrYyylSlFicHD
  mdnjM5YJXtOKtA5n9Fh9fPr7lrC5yXGKU4tmfhe+fU3aPTzlwMkWYnSD3n13//fBHzX2R/O7w
  xZOW7Ov+IuzpK23ovRoFzesIqwGThuHW6zcb6FMvonnAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-33.tower-223.messagelabs.com!1550158133!1195723!1
X-Originating-IP: [104.47.6.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16393 invoked from network); 14 Feb 2019 15:28:53 -0000
Received: from mail-ve1eur02lp2051.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.51)
  by server-33.tower-223.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 14 Feb 2019 15:28:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e+I/N5xnSLSl/AvDPObl+O0qRqicCCVD5bElAjTrUA=;
 b=QIQ6ZVzRfWBpLucuC0MKpSeMadlR8FtfmO400jT0fasr1oXgfAb0UOipe/kKh+qYzsdMrLMxiXr7o3CxU5drT2CzCpx45gcUschjc26rkI4tnANAfcmn6MjzO67O/cmhBNuq6sYO0FjbSmhV9Qafzp9F0KRBylj8x24lV+BQRa4=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB1204.EURPRD10.PROD.OUTLOOK.COM (10.169.155.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 14 Feb 2019 15:28:33 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10f2:a1bd:4f0d:f118]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10f2:a1bd:4f0d:f118%8]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 15:28:33 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Guenter Roeck <linux@roeck-us.net>, Kyle Tso <kyletso@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: typec: tcpm: Export partner Source Capabilities
Thread-Topic: [PATCH] usb: typec: tcpm: Export partner Source Capabilities
Thread-Index: AQHUuRincvQr57cnO02hlC0TTWv4QKXI87UAgBMc1ciAAFraAIADAWPwgAAEpwCAAA/60A==
Date:   Thu, 14 Feb 2019 15:28:32 +0000
Message-ID: <AM5PR1001MB0994DEBED217CC12C4F1001580670@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190131035411.53576-1-kyletso@google.com>
 <20190131070238.GA4500@kroah.com>
 <CAGZ6i=07EOHqd3r9y1MpYn_e1nFeYGt_wp9arhMZWWeTBm-udA@mail.gmail.com>
 <20190212105421.GA23271@kroah.com>
 <c838e214-4888-c708-6a7c-a8de6ecb5282@roeck-us.net>
 <AM5PR1001MB0994B54049DDCF2CE376263A80670@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190214143020.GA1317@kroah.com>
In-Reply-To: <20190214143020.GA1317@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34008633-5fce-4e08-79de-08d692911470
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB1204;
x-ms-traffictypediagnostic: AM5PR1001MB1204:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM5PR1001MB1204;23:6vTRzKbI4rE/58BuDCV5UWHIoN0EkLdDTzTjLPN?=
 =?us-ascii?Q?jq96fZn1hzDBv7QROZajB6t+HB1joOdlkIDV+Ad6e9cI8JsngLD/4DrOqLGp?=
 =?us-ascii?Q?GIrQEfaKqbW+pYgQcO4xdP7WfSyTcaAhaT0saChMbAJ/cvheY7bYvW/Qd3KU?=
 =?us-ascii?Q?9/u/jcrkjrckFZGPG1UvzCe4QyVyNgc1ZiuEZ1JM/H4p0T7jns+hnTkiV+e5?=
 =?us-ascii?Q?nwVLozP/LvqZ9lyGX5kMgkT8MKAdLE89JEUFiI0sI8OxA5i0uKjAOZCVYW6g?=
 =?us-ascii?Q?MCjwZN+ffPzoSKDppyl2CgbnlEsP0C/wdH9ZpKKIysU3SFmG7moN+XawNmAO?=
 =?us-ascii?Q?HEd/+v7qC2cY/rI/DtoYHzUrfy5RkYXsniFlkknRKiUE6rM1GkV7UrjMgPLU?=
 =?us-ascii?Q?nxDOKVHDI5HaAp5s/eoRY/APg29S0x/7F7RmJXeLl6m3dsp20be6ptT10p7n?=
 =?us-ascii?Q?o6NNXAi/iihh+ojGi6y7NuDzLvSf+OfJArL11ohvPkaU/l26XZLeD0q0qaTL?=
 =?us-ascii?Q?etoABVLRJOlMF7eKD9fhD+glgJVe5a5jpVcpTd3osneIp7vdiNO5lszGv3vh?=
 =?us-ascii?Q?6jwQZRACBeSkgADv//AG+RTYugkUxNuyaL+04GaGC436r1m1NFVnOh0YgWyu?=
 =?us-ascii?Q?LdMSyKggBPyl2/+jN80nFXKJw8YUQaed5qDcoolAr1rqxzEbXR9blUM2TRVZ?=
 =?us-ascii?Q?nBoZeuYpAEqTlizM4jU8sNzsjD5i2bLyNdigoB6XyfR63efsJkSEjlr49K/f?=
 =?us-ascii?Q?GeQJqo3Zw1InaMZXXmdgcYjibIEle24XpqIiN6emLD7kvA0HA0uCL2INizRL?=
 =?us-ascii?Q?AkPHO/0M6oJDpi2unYj/WVx4TctC3zH7O4diOu6bG30zOvpypxaVnatDr6se?=
 =?us-ascii?Q?owMcJIUtdRfIjXAVl7sALL3Bf5rnpORYdxtzqk8+afSuSWIUQVxhFTogWgKW?=
 =?us-ascii?Q?thspc7XKFZ3pgUaohSnkJSEBO56GnRwPrIhYuNPk5WtSMsdmh6vKyZiOPtqp?=
 =?us-ascii?Q?r1aEFhyJWtvjrBAsNYwujbZRGIxhL1WG3JczPqI77EcJc+pu/u74QMvE9opr?=
 =?us-ascii?Q?21+RNbVKYMzlKzyy+zFPdMAh7nhO6mkRj/ieFKVy0bvM4r5PshypYl5jHID/?=
 =?us-ascii?Q?sHfKG+RTjY6kXh0TfrY1+I94P5RYDrJaxE9ic4dUxKFoIJembnPg3bLwSVbZ?=
 =?us-ascii?Q?ZGedFhFKRhi6PK+r4SyOMEUtqmtMVLLE/Ne2SSamSi39Dd0/BC9Uw+9nWoVf?=
 =?us-ascii?Q?yu17zMoOcKUIfb/S35NvP+9rRPDC4wNHVS/J61YcZAg+1UcujHfhE7SwJi7P?=
 =?us-ascii?Q?7RA0dMGMPPn/WbqRdmIoA+DU=3D?=
x-microsoft-antispam-prvs: <AM5PR1001MB1204CDD687F820AFA8D9F93BA7670@AM5PR1001MB1204.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(396003)(136003)(189003)(199004)(7736002)(68736007)(305945005)(14444005)(55236004)(71200400001)(71190400001)(93886005)(66066001)(2906002)(97736004)(74316002)(6116002)(256004)(486006)(8676002)(86362001)(3846002)(8936002)(102836004)(110136005)(186003)(316002)(26005)(106356001)(9686003)(105586002)(55016002)(54906003)(81166006)(81156014)(446003)(11346002)(476003)(7696005)(76176011)(6506007)(53546011)(99286004)(4326008)(53936002)(6246003)(966005)(229853002)(72206003)(33656002)(478600001)(6306002)(6436002)(14454004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1204;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rTHr1Ze++Mgiu+Um0ZHs+95KUd+wlBAJ7tZgMJCQe8d8F4D0OHCfhZ/6FoBz6QHPfTGYOO3nO2Q6nROCPGJDrGM357Fp+8ABTToYJ2R3t2eXbTvkd1CDhuS4KISp0YcQs9vKBtZxAjiqlauCm6FBs0IdXC04P5uKnfbEVTN1knBXevWLzBzrcu1jQVLcE40/My9TMWDctW+xkDTJdyrmtJJ0DCzlQiVKD9dCAFDKDYoraz0JvoGLG2oETktIdB3CIdIoh1nbkNAAU19Uqh1LB3GQnVtZXTCxfn0LsVXPv1gMGNx90WWP8NrZznugeBmZ0XLm7BtQl8Ha/IFoo95BxXKn8vJTFFexvCxEZiKDPvdyfVEzhF8wd1ORAcjVvWGgQpOqvmU4+bOaZPv/s88a/EtFZFFOHnug2pT3CJ2S8ew=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34008633-5fce-4e08-79de-08d692911470
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:28:32.9822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 February 2019 14:30, Greg KH wrote:

> On Thu, Feb 14, 2019 at 02:17:14PM +0000, Adam Thomson wrote:
> > On 12 February 2019 16:20, Guenter Roeck wrote:
> >
> > > On 2/12/19 2:54 AM, Greg KH wrote:
> > > > On Tue, Feb 12, 2019 at 06:29:39PM +0800, Kyle Tso wrote:
> > > >> On Thu, Jan 31, 2019 at 3:02 PM Greg KH
> > > >> <gregkh@linuxfoundation.org>
> > > wrote:
> > > >>
> > > >>> On Thu, Jan 31, 2019 at 11:54:11AM +0800, Kyle Tso wrote:
> > > >>>> Provide a function to get the partner Source Capabilities.
> > > >>>>
> > > >>>> Signed-off-by: Kyle Tso <kyletso@google.com>
> > > >>>> ---
> > > >>>>   drivers/usb/typec/tcpm/tcpm.c | 23 +++++++++++++++++++++++
> > > >>>>   include/linux/usb/tcpm.h      |  1 +
> > > >>>>   2 files changed, 24 insertions(+)
> > > >>>>
> > > >>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c
> > > >>> b/drivers/usb/typec/tcpm/tcpm.c
> > > >>>> index f1d3e54210df..29cd84ba9960 100644
> > > >>>> --- a/drivers/usb/typec/tcpm/tcpm.c
> > > >>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > >>>> @@ -4494,6 +4494,29 @@ int tcpm_update_sink_capabilities(struct
> > > >>> tcpm_port *port, const u32 *pdo,
> > > >>>>   }
> > > >>>>   EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
> > > >>>>
> > > >>>> +/*
> > > >>>> + * Don't call this function in interrupt context. Caller needs
> > > >>>> +to free
> > > >>> the
> > > >>>> + * memory itself.
> > > >>>> + */
> > > >>>> +int tcpm_get_partner_src_caps(struct tcpm_port *port, u32
> > > >>>> +**src_pdo) {
> > > >>>> +     unsigned int nr_pdo;
> > > >>>> +
> > > >>>> +     if (port->nr_source_caps =3D=3D 0)
> > > >>>> +             return -ENODATA;
> > > >>>> +
> > > >>>> +     *src_pdo =3D kcalloc(port->nr_source_caps, sizeof(u32),
> GFP_KERNEL);
> > > >>>> +     if (!src_pdo)
> > > >>>> +             return -ENOMEM;
> > > >>>> +
> > > >>>> +     mutex_lock(&port->lock);
> > > >>>> +     nr_pdo =3D tcpm_copy_pdos(*src_pdo, port->source_caps,
> > > >>>> +                             port->nr_source_caps);
> > > >>>> +     mutex_unlock(&port->lock);
> > > >>>> +     return nr_pdo;
> > > >>>> +}
> > > >>>> +EXPORT_SYMBOL_GPL(tcpm_get_partner_src_caps);
> > > >>>
> > > >>> We don't add new functions that no one uses :(
> > > >>>
> > > >>>
> > > >> This function is useful if the PD Device Policy Manager is
> > > >> implemented outside of TCPM.
> > > >> In this situation, Device Policy Manager needs to know the
> > > >> partner capabilities to optimize the charging process.
> > > >
> > > > And where is that code?
> > > >
> > >
> > > Agreed - that code should be sent upstream as well to let us see the
> > > entire context.
> > >
> > > >> Take existing functions in TCPM for example:
> > > >> Function "tcpm_update_sink_capabilities" and
> > > >> "tcpm_update_source_capabilities" are exposed as well. And no one
> > > >> uses them now.
> > > >
> > > > Great, let's go delete them now, we should not have apis that no
> > > > one uses.  This isn't a new thing...
> > > >
> > >
> > > I sent a patch to do just that. Quite frankly I don't recal why I
> > > thought those functions might be needed.
> >
> > As a mind jog - https://lkml.org/lkml/2017/11/27/1256 :)
>=20
> Nice find :)
>=20
> Given that no one used these functions in over a year, we should be safe
> deleting them.  If not, it's trivial to do 'git revert'.

Yep, agreed.
