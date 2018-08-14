Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3A1C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E038521717
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DsJCw4Qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E038521717
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeHNWBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:01:55 -0400
Received: from mail-eopbgr690123.outbound.protection.outlook.com ([40.107.69.123]:45293
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbeHNWBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtiP3xgSt6Qn+zRdbKLoBbL6bjUR0j3QqpWkQC4lELw=;
 b=DsJCw4QcUn21L4gdnbBqblDHFLozhmgvetHyq1C8oqgGewo0BvWMyKbRMQEIyazQEcB4W8PliuqHyAmgqo2ErO2FcJU0RQmqxP88Jo/UO9UWmGKuHPTE1rBKDVb2GFHylYIj4By2ouNynIsg07116aKrnHFk1G9a7jIsGSE6GAw=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.7; Tue, 14 Aug 2018 19:13:14 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9039:1f12:39f1:267f]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9039:1f12:39f1:267f%9]) with mapi id 15.20.1080.007; Tue, 14 Aug 2018
 19:13:13 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 2/5] vmbus: add driver_override support
Thread-Topic: [PATCH 2/5] vmbus: add driver_override support
Thread-Index: AQHUMP7hUja4hqhYOEGCevbfjkIbnqS+EbawgAFl2QCAAClgoA==
Date:   Tue, 14 Aug 2018 19:13:13 +0000
Message-ID: <CY4PR21MB0773F0CF5B7E3B4ED0F2BBF3DC380@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20180810230520.2055-1-kys@linuxonhyperv.com>
        <20180810230611.2114-1-kys@linuxonhyperv.com>
        <20180810230611.2114-2-kys@linuxonhyperv.com>
        <CY4PR21MB07739595C31B9B9349604C0ADC390@CY4PR21MB0773.namprd21.prod.outlook.com>
 <20180814093514.7febc8d5@xeon-e3>
In-Reply-To: <20180814093514.7febc8d5@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-14T19:13:11.4400214Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:DBfPn0yPVONIxd0H5tKE/jEzsb+nhP0d9kJWfWIhlzZlgW6DFJQKr2T+c2o+43GQAxFePgra9wJAlo7uKNzwBTHeDHms73nlb9gkzJHO+Y7ImNx2105P6cS5c4tcAEKfdb4BhevMp2xmCZLbi9E1LU9apIxz+nDWkr2WWYGJn92q9ThUq+oN8TFWQr8rCWnaQeC4K5HvlrKqvFQ+CJGZA42xhrMnxt+g4c/nIQYM4J/7FowIJhZK9PT3HCGpwSAVPuAJqlfvmjzyzHMAf+cAZt3Ov7GZ0Mciux9U8MPY3LeUcVGOYLhnLTUeZoC8ESZcjwoHsxMTw/0ZUWa/njgMFf31GgVljKakkv4pEgWh4Z8t7QLb7QI32y389yLijPiLTiO0LstT2kgMSyqojTKCpfrKrGw1TZz5+jKdgt1kdhBO80jHMhRjg0cKEVhGZTPlgLb04HO+ybbcJS/Hmro7sQ==;5:JYV2B/IU/ZtXC2Lo1Squ0Fgu8hQoV1ki9bTcCes6AZcn/hlVmu2JfOjm6SHqnVjuXonvHUG8B0SBKYzqz+QipXvt9YH5FlVTuIcMZilaoREv4Clavp/73p6Xbr+P9J1TWVZ30FFR2Yv+XtfTZ4GJHP0vEIovOa9Xenv1Ir8/kK4=;7:EflqYDz1497c1UouFKs+c8smxr+1phCz9L2zQJmJUIedHailhuT7Nvi8Rnc/k1dOu03BrrsLGEOlMtRfHYwkJn+fcpeL91bqGD06npex2G8iux8rjAJoTgXLWCxdROyN69zGP4NMNGQAcKkYe4/RRuDIeuuEmfwjqGTzOj6Zf/W8CN97A9Y/XD3eKoo3sxAU2D2AAD5sdXeZ5Ebr9TabipBM8s/m6N19o9AavdeCpYFR9tHyfhnCRcguUR42sWnS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: db51092b-e0b4-486c-5dd2-08d60219fbb2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0117E20B11E1FC9F7A5EBE44DC380@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231328)(8210008)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0764C4A8CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(478600001)(54906003)(7736002)(93886005)(316002)(229853002)(86362001)(5660300001)(2906002)(2900100001)(72206003)(14454004)(74316002)(10090500001)(6116002)(22452003)(305945005)(3846002)(33656002)(86612001)(446003)(11346002)(186003)(5024004)(256004)(26005)(53936002)(14444005)(476003)(486006)(5250100002)(6346003)(9686003)(99286004)(7696005)(6436002)(10290500003)(6506007)(4326008)(8936002)(102836004)(55016002)(106356001)(76176011)(105586002)(6916009)(66066001)(81166006)(81156014)(8990500004)(97736004)(6246003)(8676002)(25786009)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-message-info: qftzYbFXHjQzdVTLN6v2FKb4Fas89Cm73tBJDip5ahoaOlBNvZ6DFcy7oCdja35r4+zfjHzxEfSFTedrikvhCk5KlQQMWMbNIYs5mf2laKSMVZfpMH/bvaP7OvBDSbril6gK7b0u97e1wftW1JgNLbj6C6fQC5lzBd67bOVn80Lx6/9ZUxTVF6N0749I7S7dtryMEhg3E+jU9P7dbdWj1nz3oxDpZmoGPul97PS1mXnV0iV9MMLmx+IeKAuBd1mlLGiFEDWPLPzCyBoaHA/xnc9ENsG4fkIZJqqDl90IHhi6VaodkgkiaRDhanK2mUOnXrBhWFJcnU3nD0VEt1NouRBfeogen/5ubQFAxiZnyYA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db51092b-e0b4-486c-5dd2-08d60219fbb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 19:13:13.8781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>  Sent: Tuesday, August=
 14, 2018 9:35 AM

> On Mon, 13 Aug 2018 19:30:50 +0000
> "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com> wrote:
>=20
> > > +/*
> > > + * Return a matching hv_vmbus_device_id pointer.
> > > + * If there is no match, return NULL.
> > > + */
> > > +static const struct hv_vmbus_device_id *hv_vmbus_get_id(struct hv_dr=
iver *drv,
> > > +							struct hv_device *dev)
> > > +{
> > > +	const uuid_le *guid =3D &dev->dev_type;
> > > +	const struct hv_vmbus_device_id *id;
> > >
> > > -	return NULL;
> > > +	/* When driver_override is set, only bind to the matching driver */
> > > +	if (dev->driver_override && strcmp(dev->driver_override, drv->name)=
)
> > > +		return NULL;
> >
> > This function needs to be covered by the device lock, so that
> > dev->driver_override can't be set to NULL and the memory freed
> > during the above 'if' statement.  When called from vmbus_probe(),
> > the device lock is held, so it's good. But when called from
> > vmbus_match(), the device lock may not be held: consider the path
> > __driver_attach() -> driver_match_device() -> vmbus_match().
>=20
> The function hv_vmbus_get_id is called from that path.
> i.e. __device_attach -> driver-match_device -> vmbus_match.
> and __device_attach always does:
> 	device_lock(dev);

Agreed.  The __device_attach() path holds the device lock and all is good.
But the __driver_attach() path does not hold the device lock when the
match function is called, leaving the code open to a potential race.  Same
problem could happen in the pci subsystem, so the issue is more generic
and probably should be evaluated and dealt with separately.

Michael

>=20
> The code in driver _override_store uses the same device_lock
> when storing the new value.
>=20
> This is same locking as is done in pci-sysfs.c

