Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E01C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5832080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="RBnUPP8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5832080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbeLMEvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:51:03 -0500
Received: from mail-eopbgr1400125.outbound.protection.outlook.com ([40.107.140.125]:53079
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728867AbeLMEvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2R1qte3a1+fRMKfszhVZfmJQ3Ipfz/8GQa1aI03ArE=;
 b=RBnUPP8Ti5Hf/G3NZJFeH7oYbADtvs3MBHQkRPym7S/Mo5iUbFlCTrgzEYyJDOqUdkzkiJZlFudlglNh24D0+txc6fk3Zvbk+CSaf1lKB4d5p1ke+CzpsSQ2uaJWXhPCIGWRVedJuUyxsGRgFQMwIJicePZCttiVlStVd43UWUs=
Received: from OSAPR01MB2290.jpnprd01.prod.outlook.com (52.134.238.13) by
 OSAPR01MB4018.jpnprd01.prod.outlook.com (20.178.128.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.24; Thu, 13 Dec 2018 04:50:56 +0000
Received: from OSAPR01MB2290.jpnprd01.prod.outlook.com
 ([fe80::a8ae:bee4:d7e7:e5b7]) by OSAPR01MB2290.jpnprd01.prod.outlook.com
 ([fe80::a8ae:bee4:d7e7:e5b7%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 04:50:56 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH AUTOSEL 4.9 21/34] net: phy: Fix not to call phy_resume()
 if PHY is not attached
Thread-Topic: [PATCH AUTOSEL 4.9 21/34] net: phy: Fix not to call phy_resume()
 if PHY is not attached
Thread-Index: AQHUkpzi7NOwKWoJWEemVEPD/eaelaV8GWVA
Date:   Thu, 13 Dec 2018 04:50:56 +0000
Message-ID: <OSAPR01MB22901C22F3D16F6229B9ABD3D8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
References: <20181213043200.76295-1-sashal@kernel.org>
 <20181213043200.76295-21-sashal@kernel.org>
In-Reply-To: <20181213043200.76295-21-sashal@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.140]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSAPR01MB4018;20:y91vBCIjqcye//blE1OsC5ACXTavzTZiUAShUXfmtxPgvF1j5mr8RnDG1qvCMTeM7geRcrSjrK3mgAhMcQmfXhAtacd9ArvVOMU58Oms5Rz67zKnD+HHfboD7lfow2IK7dpfVTaHItFZzSSK+3BmoH91R9MkJLvVCZJd52Jixf8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e17e1840-02a5-48d4-c183-08d660b691a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSAPR01MB4018;
x-ms-traffictypediagnostic: OSAPR01MB4018:
x-microsoft-antispam-prvs: <OSAPR01MB4018B6619545DCB38B671857D8A00@OSAPR01MB4018.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:OSAPR01MB4018;BCL:0;PCL:0;RULEID:;SRVR:OSAPR01MB4018;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(186003)(45080400002)(229853002)(446003)(7736002)(81156014)(99286004)(305945005)(9686003)(6246003)(8936002)(81166006)(8676002)(55016002)(2201001)(2906002)(316002)(6506007)(6306002)(476003)(86362001)(217873002)(575784001)(97736004)(53936002)(74316002)(11346002)(66066001)(102836004)(26005)(5660300001)(7696005)(256004)(76176011)(14454004)(486006)(6436002)(54906003)(478600001)(25786009)(105586002)(71200400001)(68736007)(33656002)(106356001)(2501003)(6116002)(4326008)(3846002)(110136005)(71190400001)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB4018;H:OSAPR01MB2290.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Aq/ppYHhBUXxg9kM2s/yDcvZr/tPjqjJrQEkKQqV5fepCEB6Ym6px8B+cqbNm5gc+y+xFv74549IrQ6WPoOJs0FA+AW2rIc/MczKSlwjdS2nN0z7miwJQiyanmMqhFSY+NqIH9+gE8PwqX6Fz8JGOEuHRfLYzIdN7TdXajm/uzdsOWKJJ8Yj9zLgidy5QhEI7MzA9jpdOoA9MHWWIka0+eRSL09FlyKx32S8VnDjXuoah+82EXAhSVqt8LXHEPOWFBKoqIWhsetgCzBfKL3njgItq0In3zaF8mevdiGZvCohiXyqbdinPhMkuHo3K3ju
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17e1840-02a5-48d4-c183-08d660b691a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 04:50:56.1135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Sasha Levin, Sent: Thursday, December 13, 2018 1:32 PM
>=20
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> [ Upstream commit ef1b5bf506b1f0ee3edc98533e1f3ecb105eb46a ]

This upstream commit is reverted on mainline as I mentioned other email thr=
ead [1].
So, we should not backport this patch.

[1]
https://lore.kernel.org/lkml/OSAPR01MB2290FE36AF50B2F29170383DD8A00@OSAPR01=
MB2290.jpnprd01.prod.outlook.com/T/#u

Best regards,
Yoshihiro Shimoda

