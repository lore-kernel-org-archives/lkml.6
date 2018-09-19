Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49ACC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CF0214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CF0214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sma.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbeISPF1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:05:27 -0400
Received: from msgsrv4.atosorigin.de ([194.8.120.226]:56644 "EHLO
        msgsrv4.atosorigin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeISPF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:05:27 -0400
Received: from unknown (HELO julia-mo2.ccsn.de.ao-srv.com) ([194.8.124.179])
  by msgsrv-out2.atosorigin.de with ESMTP; 19 Sep 2018 11:28:22 +0200
Received: from julia-mo2.ccsn.de.ao-srv.com (unknown [194.8.124.179]) by MCS01-MA1.atosorigin.de with smtp
         id 5b23_0780_72663a8c_fa64_4044_91b8_b63e40b167b9;
        Wed, 19 Sep 2018 11:28:22 +0200
Received: from julia-mo2 (localhost [127.0.0.1])
        by julia-mo2.ccsn.de.ao-srv.com (Postfix) with ESMTP id 1CFDDA9BFB9;
        Wed, 19 Sep 2018 11:28:23 +0200 (CEST)
Received: from MCS01-MA1.atosorigin.de (mcs01-ma1.deuser.de.intra [194.8.120.185])
        by julia-mo2.ccsn.de.ao-srv.com (Postfix) with ESMTP id EF3FCA9BFBA;
        Wed, 19 Sep 2018 11:28:22 +0200 (CEST)
Received: from SVR-DE-EXMBX-01.sma.de (unknown [10.99.42.82]) by MCS01-MA1.atosorigin.de with smtp
         id 5b23_0730_a093f2f4_1ca8_4ebb_bfc9_a4e425247756;
        Wed, 19 Sep 2018 11:28:17 +0200
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (10.0.42.37) by
 webmail.sma.de (10.0.42.161) with Microsoft SMTP Server (TLS) id 14.3.389.1;
 Wed, 19 Sep 2018 11:28:05 +0200
Received: from DB7PR04MB5243.eurprd04.prod.outlook.com (20.176.236.87) by
 DB7PR04MB4394.eurprd04.prod.outlook.com (52.135.137.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 09:25:32 +0000
Received: from DB7PR04MB5243.eurprd04.prod.outlook.com
 ([fe80::f198:36b7:1793:542b]) by DB7PR04MB5243.eurprd04.prod.outlook.com
 ([fe80::f198:36b7:1793:542b%3]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 09:25:32 +0000
From:   Andre Kalb <Andre.Kalb@sma.de>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached
Thread-Topic: [PATCH v2] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached
Thread-Index: AdREZxxSehcX9yb4Tui0YlbCxpETAwCflhgAAIFiuDAACG4qAAG7OyRA
Date:   Wed, 19 Sep 2018 09:25:32 +0000
Message-ID: <DB7PR04MB5243B43ED321F828C5094DA8FC1C0@DB7PR04MB5243.eurprd04.prod.outlook.com>
References: <AM6PR04MB52394FDB1266388BCE1374E3FC030@AM6PR04MB5239.eurprd04.prod.outlook.com>
 <c0bcc2c1-3058-db4d-ca4d-4e56c502891b@gmail.com>
 <DB7PR04MB5243B6ADEBCB4B53B5A161F8FC050@DB7PR04MB5243.eurprd04.prod.outlook.com>
 <CAL_JsqKc1-Rz6iBJ_dpDrEDoFRpTaLR+1voXdTgiJjjG65druA@mail.gmail.com>
In-Reply-To: <CAL_JsqKc1-Rz6iBJ_dpDrEDoFRpTaLR+1voXdTgiJjjG65druA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andre.Kalb@sma.de; 
x-originating-ip: [62.157.91.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4394;6:4WKoMvMODz7mqfSx4ezR6PCOC8VLaV0v5eKeeJYpE39o/+qMSPFakgCofRs3PCM8FaEZ8nVD+y94vbTCPyXhGDtgdJKVGPmxJDrpK5u3h9aglACPM+CjWFEBg0kL6J6YZVKrRV7tI2A6Af130kzCUDre3qGD+qMuam4aKdnkwncM9ZQikubPlECy521gDNfsw6wnnRvCCuMmezvMwhKxQd9BBFyU5Q2Vh5GTi9Dnr2wIb0I3PuM/AKq6jgVmkP/XSKokVQmcDeRHaF+b1wXYeomSpTGoHltG+Tt86JXDbNl45JvZPT1nBhiUFvMjYBAFC3A2rXgGiBKzWgc6zp4bZKHLnIe46l33hJkqu/e/YGuwXfuTOVdWmu+yTY/RKeLYFz52HzP/rJPPn/HPFmhXtfb+jEnt8Lad1exIJPHWgC5YZB1OnN63dTMmjMkP5lYnRHziZEqd3yok6oMeGPeWKg==;5:4PZXFTObq3E+7uyjVaAvCs7kxiLP+v3Cd1w8bhPLnWFMMrYq3lop/DCJO6XHklzwbCbrTkzbdOgInggSv2WzHqPqEQD4Lzy6tul1rXzDWMwXndr5oTv3NpVVMqJoIygpKoBktX8rhG+annb/nfHgmtfrbWim/qCViurBQ6BKpQs=;7:vPXsWRs3YyWH3lYcp+7dW3CLSqiudKvZve5bSkENuskJWqmv3H6/u8q6yOefOCk+zAsVASmuqqW/sP5mhA6HEC1ng0Mb7I+AYSl7hu1t6tUaeEkEp5dAmKyGx0yTBcBjD+woQc6Cx8mex9SvXNy2j1zqZ/LqrPpK3WfXsjLixXd/59Kr63h3oVnQFCjVUbUx0J/ibyxinVfzmKZQIGXN0yzZYdYqq7xG1jdEn8NVdb8NcR4QyeckfkDWiMz3DGKu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c405e72a-62df-4540-3500-08d61e11d936
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4394;
x-ms-traffictypediagnostic: DB7PR04MB4394:
x-microsoft-antispam-prvs: <DB7PR04MB43941F25123359FBE097DA25FC1C0@DB7PR04MB4394.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:DB7PR04MB4394;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4394;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(346002)(376002)(189003)(199004)(54906003)(5250100002)(305945005)(6436002)(7696005)(68736007)(99286004)(105586002)(66066001)(74316002)(9686003)(6306002)(39060400002)(33656002)(75402003)(76176011)(3846002)(55016002)(97736004)(316002)(7736002)(6506007)(6116002)(106356001)(446003)(478600001)(45080400002)(476003)(14454004)(11346002)(486006)(102836004)(25786009)(53936002)(53546011)(72206003)(8936002)(26005)(2906002)(81156014)(74482002)(93886005)(5024004)(86362001)(5660300001)(4326008)(8676002)(186003)(966005)(81166006)(14444005)(256004)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR04MB4394;H:DB7PR04MB5243.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: sma.de does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kXjACFvZlhMDKdSxhNX/r2uUxkHBInZQsPKfHGc6Ic+l/DRy+cc8PcCPpxXxVi5SqQpkHm8ZV29zuXDm35z1GdVVl9u+LBCoXD1FxqMMtvPALIfnLvyjgvuOg65XCvm1TP8JOyToRgqQhaO1f7ilOyZfrYut+EHxkevGizStGZbkIwCKgQ2uO1z83bwDKqmjwWfBHs1pivQNiGV6L/tWNkK3A5nl/r7ycZowA15KEWnkPKshzX5OyQRhJ7IIsUKTR92uzhBKCFNapKz4nUaBbREx/9/HM60Y0osyDMcMHvfHEeG+4/T17Dm8spwAgDcLU7eUjqtK+S7oUHGQFvKO4G2Np8At5Vz7fUf8uWPVFt0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c405e72a-62df-4540-3500-08d61e11d936
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 09:25:32.5888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4394
X-OriginatorOrg: sma.de
X-NAI-Spam-Flag: NO
X-NAI-Spam-Level: 
X-NAI-Spam-Threshold: 8
X-NAI-Spam-Score: 0.9
X-NAI-Spam-Version: 2.3.0.9418 : core <6376> : inlines <6884> : streams
 <1798889> : uri <2713604>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I have used an other hardware to check the patch. I hope it doesn't matter. I added few lines at the untitest.c. All existing unittest use an attached sysfs, therefore the bug isn't detectable.

The patch of the unittest is posted: https://lore.kernel.org/patchwork/patch/985738/

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at fs/kernfs/dir.c:1481 kernfs_remove_by_name_ns+0x9c/0xa4
kernfs: can not remove '(null)', no directory
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.18.7 #3
Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[<c010f338>] (unwind_backtrace) from [<c010cefc>] (show_stack+0x10/0x14)
[<c010cefc>] (show_stack) from [<c0122004>] (__warn+0xe0/0xf8)
[<c0122004>] (__warn) from [<c0122060>] (warn_slowpath_fmt+0x44/0x68)
[<c0122060>] (warn_slowpath_fmt) from [<c02c6540>] (kernfs_remove_by_name_ns+0x9c/0xa4)
[<c02c6540>] (kernfs_remove_by_name_ns) from [<c055a704>] (__of_update_property_sysfs+0x38/0x50)
[<c055a704>] (__of_update_property_sysfs) from [<c0557b94>] (of_update_property+0xc0/0x104)
[<c0557b94>] (of_update_property) from [<c09521bc>] (of_unittest+0x1b8/0x28d4)
[<c09521bc>] (of_unittest) from [<c0102d88>] (do_one_initcall+0x40/0x218)
[<c0102d88>] (do_one_initcall) from [<c090101c>] (kernel_init_freeable+0x24c/0x2e4)
[<c090101c>] (kernel_init_freeable) from [<c06a1f6c>] (kernel_init+0x8/0x110)
[<c06a1f6c>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
Exception stack(0xcc099fb0 to 0xcc099ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 4522f69e0760e4d5 ]---

Best regards
Andre Kalb

> -----Ursprüngliche Nachricht-----
> Von: Rob Herring [mailto:robh+dt@kernel.org]
> Gesendet: Montag, 10. September 2018 15:47
> An: Andre Kalb
> Cc: Frank Rowand; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Betreff: Re: [PATCH v2] of: __of_update_property_sysfs only call
> __of_sysfs_remove_bin_file if of_node_is_attached
>
> On Mon, Sep 10, 2018 at 4:51 AM Andre Kalb <Andre.Kalb@sma.de> wrote:
> >
> > Hi Frank,
> >
> > > -----Ursprüngliche Nachricht-----
> > > Von: Frank Rowand [mailto:frowand.list@gmail.com]
> > > Gesendet: Freitag, 7. September 2018 22:01
> > > An: Andre Kalb; robh+dt@kernel.org; devicetree@vger.kernel.org;
> > > linux- kernel@vger.kernel.org
> > > Betreff: Re: [PATCH v2] of: __of_update_property_sysfs only call
> > > __of_sysfs_remove_bin_file if of_node_is_attached
> > >
> > > Hi Andred,
> > >
> > > On 09/04/18 08:51, Andre Kalb wrote:
> > > > To prevent warning "kernfs: can not remove '(null)', no directory"
> > > > if an overlay
> > > isn't applied to the active devicetree.
> > > >
> > > > Using of_remove_property and then of_add_property doesn't show the
> > > warning.
>
> [...]
>
> > > What is the calling path that results in the warning?
> > >
> > > -Frank
> >
> > There is the callstack of the warning.
> >
> > [   10.782830] ------------[ cut here ]------------
> > [   10.830357] WARNING: CPU: 0 PID: 170 at /linux-4.x/fs/kernfs/dir.c:1276
> kernfs_remove_by_name_ns+0x30/0x80()
> > [   10.928997] kernfs: can not remove '(null)', no directory
> > [   10.993107] Modules linked in: module_capemgr(+)
> > [   11.045750] CPU: 0 PID: 170 Comm: systemd-udevd Not tainted 4.4.143-
> 00158-g8e5ca65ec7ee-dirty #114
>
> 158 patches on top of an almost 3 year old kernel...
>
> > [   12.011373] [<bf0000e4>] (module_capemgr_slot_scan [module_capemgr])
> from [<bf0007bc>] (module_capemgr_probe+0x3c/0x58 [module_capemgr])
>
> And a driver that's not upstream.
>
> Not saying the fix isn't valid, but please reproduce on recent mainline. Add a
> unittest if you have to.
>
> Rob

___________________________________________________

SMA Solar Technology AG
Aufsichtsrat: Dr. Erik Ehrentraut (Vorsitzender)
Vorstand: Ulrich Hadding, Dr.-Ing. Juergen Reinert, Pierre-Pascal Urbon
Handelsregister: Amtsgericht Kassel HRB 3972
Sitz der Gesellschaft: 34266 Niestetal
USt-ID-Nr. DE 113 08 59 54
WEEE-Reg.-Nr. DE 95881150
___________________________________________________
