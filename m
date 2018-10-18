Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD16C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63F12145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jlvVPHZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63F12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbeJRXeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:34:10 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:4682
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727757AbeJRXeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu7PuAm4iLDixk9M/ZnBF7z1c5OYIrCWhN2EnqAi5vg=;
 b=jlvVPHZQvzOWwKtJp5XuihUbpjL2NDlDc/MF29Gm5eGXdAGCJLwhIvrn4+pVEFcctrg6QRd6jBLkYAhb/C/WFGTCcTSTUNBL59rrfoZxUgyGB4n/Xx8GZ2uMDclnbKK34sjtEk0YnWy60he/t3y6ThB5f+MqhUDS7sFqcOCVVa8=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0151.namprd21.prod.outlook.com (10.173.189.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.1; Thu, 18 Oct 2018 15:32:36 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb%8]) with mapi id 15.20.1273.012; Thu, 18 Oct 2018
 15:32:35 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Olaf Hering <olaf@aepfle.de>,
        Stephen Hemminger <stephen@networkplumber.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Subject: RE: [PATCH V2 3/4] vmbus: add per-channel sysfs info
Thread-Topic: [PATCH V2 3/4] vmbus: add per-channel sysfs info
Thread-Index: AQHTMDILCEMEoT8qkE2pk3xiw1YEpaUni6WAgAAC2cA=
Date:   Thu, 18 Oct 2018 15:32:35 +0000
Message-ID: <CY4PR21MB0773D6885EC71F92D1A1369FD7F80@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20170918034955.10913-1-kys@exchange.microsoft.com>
        <20170918035419.11062-1-kys@exchange.microsoft.com>
        <20170918035419.11062-3-kys@exchange.microsoft.com>
 <20181018171953.079f6fb6.olaf@aepfle.de>
In-Reply-To: <20181018171953.079f6fb6.olaf@aepfle.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-18T15:32:33.7662112Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:1:65b1:97ff:dbed:8927]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0151;6:RSGc+AO886VuD25eBbUraA5yAqjkG2cvrOMRnsUFr82nfgEuxVo90U9sguRGcScmgOO0Y8eD9bUP/9foedDvQHSv1HG6OqoCFAvYSfmGb38jwXwkcctHkmkV+2EAKYO9fLqwt/1J3eRej1/Bd0YgUDLwbDeG6zRJ6wTWt+XABq85OmjHsaG2/zoQpDaHJP1jFBmYyvbsdljoeSpVlwYXMNEiRVR7ogSCtXVzxfxAX0Gxtm/3aSyKztiTK/g8d+U+RBtCIzSinVzcW+bh2c6rM5x+oGgBOthwnQxPUBPRMp9b4XpG9S7TyALx+gdUWFvLAwphgnBdKulqjCsXdhe93izjNECikGmv24kiGOreqvvoxF9dBMyNgZ2LKzDZ1SEupRskBBuCrK8rCeESHcLmhlm1kgvGcIlN9VD2kPxIA4NTPOSZfCcYsnvSVHidzG5jPrYS5Szkh3QNv5dDDXnyOw==;5:BwWKSGEsBVlAiYf3iPfPGqbMwxLQzhYgZTWlK4zr4yisryM6mKUy4GJo+vvsED5otAywQLqqrKyjAwKrW2+FNDdk2ecAKWf7prr/l38hZ2qCRT5mffP+hIlR/Eyy/OUVtQc6KHczDYPRVW1X7Tvcevi0gMnwzj/2r7pYZBIO8X8=;7:txHVTyHr7d481tLQkCWkCMFG1xJT7NW/ybPfZ+R4Me1Xtaq7s6NdsYBlfOTwwMclDgelnyp6kHM3zKFgZzX7SXGZld82Mm2/1yso5b53QRGYEem9WrPouYn/pg7mt1yn3+g5CSFttXWUNxfPZaEbMg==
x-ms-office365-filtering-correlation-id: 700ac1d0-cca2-4f7e-a410-08d6350eee12
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0151;
x-ms-traffictypediagnostic: CY4PR21MB0151:
x-microsoft-antispam-prvs: <CY4PR21MB015161A40FA596F93BE133F2D7F80@CY4PR21MB0151.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220008)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0151;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0151;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(376002)(136003)(39860400002)(189003)(199004)(102836004)(86612001)(6246003)(5250100002)(86362001)(6116002)(4326008)(8990500004)(316002)(7696005)(256004)(110136005)(99286004)(22452003)(7736002)(305945005)(93886005)(71200400001)(14444005)(97736004)(54906003)(74316002)(71190400001)(68736007)(11346002)(76176011)(9686003)(105586002)(10290500003)(6506007)(55016002)(46003)(106356001)(53936002)(2906002)(14454004)(33656002)(81166006)(229853002)(10090500001)(2900100001)(476003)(446003)(486006)(5660300001)(8936002)(81156014)(8676002)(6436002)(25786009)(186003)(478600001)(6346003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0151;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-message-info: rXSlLM9936kfiroqyWzN7fyn+CCfUiNIsm73ySgx12bAtzMInJbqBAu2Tg6WjWspiL7JLFmD2SRpxXb6er4rysfZxjvkNe0yXJuTeDK2Li4vMqkZ6d6T7yJ4puRB8Mo4zaD2gtBooT0I8C7a261ntkYzlOtG6rYyJvLnM/LXyUh4ZSPu6yM5+rCk/l9BtrW4Aq361hpqIJHFOuH5TYuiYmG0iMLjpUQvkE+XJrdwv0MctYk2dJtu6owR4RdkzTsrmf/a07iAU1p4duMyguWgtdx7UZQDvrVIKCVmKaM7xtxexQWlkEGYtTrFU1cMTAw+SXA5eRPBAu28NEXbY1yewYRxcpEkrjUxuiXlApxKLKs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700ac1d0-cca2-4f7e-a410-08d6350eee12
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 15:32:35.7845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Olaf Hering  Sent: Thursday, October 18, 2018 8:20 AM
>
> > This extends existing vmbus related sysfs structure to provide per-chan=
nel
> > state information. This is useful when diagnosing issues with multiple
> > queues in networking and storage.
>=20
> > +++ b/drivers/hv/vmbus_drv.c
> > +static ssize_t write_avail_show(const struct vmbus_channel *channel, c=
har *buf)
> > +{
> > +	const struct hv_ring_buffer_info *rbi =3D &channel->outbound;
> > +
> > +	return sprintf(buf, "%u\n", hv_get_bytes_to_write(rbi));
> > +}
> > +VMBUS_CHAN_ATTR_RO(write_avail);
>=20
> This is upstream since a year.
>=20
> But I wonder how this can work if vmbus_device_register is called,
> and then something reads the populated sysfs files before vmbus_open retu=
rns.
> Nothing protects rbi->ring_buffer in this case, which remains NULL
> until vmbus_open populates it.
>=20
> A simple reproduce, with a modular kernel, is to boot with init=3D/bin/ba=
sh
> head /sys/bus/vmbus/devices/*/channels/*/*
>=20

There are multiple race conditions with this and other VMbus sysfs informat=
ion.
There's a race on the close path as well.  I've got an action on my list to=
 get it
cleaned up.

Michael

