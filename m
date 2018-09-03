Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB34C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 03:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C206A20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 03:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="HM3pwtKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C206A20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeICHih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 03:38:37 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:20036 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725780AbeICHig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 03:38:36 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie3.idc.renesas.com with ESMTP; 03 Sep 2018 12:20:25 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 6A36B76955;
        Mon,  3 Sep 2018 12:20:25 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,323,1531753200"; 
   d="scan'208";a="291362591"
Received: from mail-ty1jpn01lp0175.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.175])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 03 Sep 2018 12:20:25 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdZds0Ns7+Rl+XoUMwEJWAYuUqfNSKQAKA5V8uWCTQ4=;
 b=HM3pwtKrsaD+INKukMt7k97x+uyo4XXstdJ7pQqu/zfsEnYMXJzR3S5XskVMd8ZYUWfKHfzm7tqTvcid6lidYkvzmKVAJ+An/2RbXkB7b/IYhQiLiLGarlaYqqLW7Ah2OKf264LR5zs/lILHKMVgIiTVwzVkY6vn5Y+Mvwfb3Uc=
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com (52.134.243.14) by
 OSBPR01MB2677.jpnprd01.prod.outlook.com (52.134.254.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Mon, 3 Sep 2018 03:20:23 +0000
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::3c08:a2d5:1513:b7f9]) by OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::3c08:a2d5:1513:b7f9%4]) with mapi id 15.20.1101.016; Mon, 3 Sep 2018
 03:20:23 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: RE: linux-next: Tree for Aug 31 (drivers/usb/gadget/udc/renesas_usb3)
Thread-Topic: linux-next: Tree for Aug 31
 (drivers/usb/gadget/udc/renesas_usb3)
Thread-Index: AQHUQUFiajocAjAFpkOa0RN9XTmDhKTd5agg
Date:   Mon, 3 Sep 2018 03:20:23 +0000
Message-ID: <OSBPR01MB2293786602584B7F92A4A333D80C0@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <20180831130356.6b0fd971@canb.auug.org.au>
 <d3eaa71e-c11d-82c7-27c3-3cd0a2b031c2@infradead.org>
In-Reply-To: <d3eaa71e-c11d-82c7-27c3-3cd0a2b031c2@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.145]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2677;20:oCRJ99zajBM8A2De0jNQeR48ktD5Bu4YvJomz+oBbLdwDqDPkE6GbVOQf6s7OZwnDDKTpI8XM3gscS/Zsw1FmELb77MdnQEqWwIb/Fp0Xx7o9Q0DEnCIC/bwdleBMyrEfYnvyZH56nqG9Dg4norso+2WWztWucAWeBtAf+E08/E=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: da2a2f3f-5a93-43ba-8f13-08d6114c2ff9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2677;
x-ms-traffictypediagnostic: OSBPR01MB2677:
x-microsoft-antispam-prvs: <OSBPR01MB2677FE532F872DD64376D78DD80C0@OSBPR01MB2677.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:OSBPR01MB2677;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2677;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(396003)(39860400002)(53754006)(199004)(189003)(27584003)(2906002)(8676002)(66066001)(2900100001)(6116002)(3846002)(7736002)(86362001)(33656002)(6436002)(5660300001)(97736004)(5250100002)(229853002)(9686003)(6306002)(53936002)(55016002)(68736007)(6246003)(74316002)(14454004)(305945005)(478600001)(966005)(102836004)(54906003)(26005)(4326008)(53546011)(81166006)(6506007)(81156014)(186003)(25786009)(110136005)(99286004)(476003)(446003)(11346002)(106356001)(105586002)(345774005)(316002)(7696005)(76176011)(486006)(5024004)(8936002)(256004)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2677;H:OSBPR01MB2293.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u4zT1OQbHEc2xbTfN4yrunn8lRvozPmIBhu7OqEGm/kl0oBpJcXrGruKCH6aDxEOC0OGG+85/Sx1R63DA7BWigCU9faQrsV4Lo1mzhlq0woGpM5lysreEcjRjUBDSHo6Dq/chdO/r0FcOiOkaxt/OeCqB+Fcegu3mc1OhVsenPmBAmqFARvUyTgPCH04m1ta5cRrsvER/TN45X/UU4zX7wA5v0+QU0eILdsEhFXhyz6hQ0p0ur6p4UJmLa7lh7c6+/P54yXWd932UBHvaQuX6UWHY75ecNSmlnm12gO1b+rH8dYeoGMOSGGGCnJpeQt9JoQHwsvkm2gdRAOk46Zhs17SlN4BJdJFSUfvurvdlbY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2a2f3f-5a93-43ba-8f13-08d6114c2ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 03:20:23.8949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2677
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Randy Dunlap, Sent: Saturday, September 1, 2018 12:43 AM
>=20
> On 08/30/2018 08:03 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20180830:
> >
>=20
> on i386:
>=20
> drivers/usb/gadget/udc/renesas_usb3.o: In function `renesas_usb3_probe':
> renesas_usb3.c:(.text+0x16da): undefined reference to `usb_of_get_compani=
on_dev'
>=20
>=20
> Full randconfig file is attached.

Thank you for the report!
I already submitted a fix patch [1]. But this patch is not applied yet.

[1]
https://marc.info/?l=3Dlinux-usb&m=3D153476263226681&w=3D2


Related ML archives:
https://marc.info/?l=3Dlinux-usb&m=3D153382696712253&w=3D2
https://marc.info/?l=3Dlinux-usb&m=3D153419699328537&w=3D2

Best regards,
Yoshihiro Shimoda


> --
> ~Randy
