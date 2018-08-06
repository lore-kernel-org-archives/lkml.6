Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CDEC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1705421A50
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OFrvPOBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1705421A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbeHFRhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:37:43 -0400
Received: from mail-eopbgr680108.outbound.protection.outlook.com ([40.107.68.108]:13440
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730628AbeHFRhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIjK3C4tddxWp1tjaw7BuUTSNPtoEkvQYzVQPOfVm10=;
 b=OFrvPOBmOL7vg/VdeBLyrA3MV8UB9Jc4sXqL03T8YvzOVvzTaqlp8gnHfg9WamMF78z26aFehqmhQkMscQU+7BaVSzsBgzaPLYDXBDHr+pynsOgBeYZijjAy76AKtUa78yqzWb/udWaSkRtvpY4DVKkHbPJSGBHN8j1OnqecHRE=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.2; Mon, 6 Aug 2018 15:28:03 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::9005:3b61:42d7:1fe1]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::9005:3b61:42d7:1fe1%3]) with mapi id 15.20.1059.003; Mon, 6 Aug 2018
 15:28:03 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     David Binderman <dcb314@hotmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: linux-4.18-rc8/tools/hv/hv_kvp_daemon.c:289: dead code block ?
Thread-Topic: linux-4.18-rc8/tools/hv/hv_kvp_daemon.c:289: dead code block ?
Thread-Index: AQHULVxQ+4Xffg6AG0mKsM5Boe4v86Sy2U3Q
Date:   Mon, 6 Aug 2018 15:28:03 +0000
Message-ID: <MW2PR2101MB1113A4A2F965646EDF1FEF02A0200@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <VI1PR08MB3342B5316CD432BB985E1A5D9C200@VI1PR08MB3342.eurprd08.prod.outlook.com>
In-Reply-To: <VI1PR08MB3342B5316CD432BB985E1A5D9C200@VI1PR08MB3342.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:b5ce:42b:da6f:ee72]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;6:xhZUenTzahFaCUTewS66OzxYAaGJjXebv5GjrWfG2O5rljAsjIUIkhK+VZlSzN1Kc4+BCaGedJrvCxKIuqFrvHMEPiFvfnWCSIFKq39g0jkSy/tcYxFL5rFsSKYxQODttiGHa9FT4sqWkYP+3GA3sTZffB6ABM9o4we7TAproINdDPoBmOAbg0Dl4KMI2w6X5nGGPECKbcJBLGH2l+r2TYoGvKpObLRJU+YROGsPAg1d7B4OjtrZRK0WyRC1IKddy13aOxKd9u0y7QOZvrhtlKFjGc+2wcD3gmURKK06rWafRylKNsNhgciSU0Qh1e5UOKwz5fe56KsMtSrLhq9YS0lax95dtQbYM1MSdAxPGKxhy6zl/Hal+QYHGgmKLHlUopqmSFhUvd7i6bMXBCzLUhNa6ok80Mic05tRbQu4YxzJdqeCSkJx1fL8LIuvZvq4AAHHZjh7dQD0vLgaZPZfPg==;5:1ItrXGCHOsWIWtOoclIdjML8q7cw4HPeeSeiFg1SNGwoJIobYJOPuGYiAmPqr9w4QwdPBLP5YfzVSOWoQDg117S2HQxhLpzDzAbsVp6LFPvfJVeRkWNecIv72DO+5zahYh/C1NTAET+KXt/464DOP9eaRjSGH4cqk2t4i5NWOsQ=;7:B88v5jDfuHByALBL1H9NyyHHMRayCZ6hoXaMUK5sMn6rfcU0CA4nTV9Xr1/vjjH+pcWiS7PC+eePUfexn3tAU++7LvEyskaKVjde37zzyNu7eNyIlLLaDm3zXiSc/fyAef0vN6MFbqBz7IxNUkHLUraswcRbc0yFqYEYDuXaR+eLQktKZ1Fgq59B4GUOmsDJoHMUweF91MCz79WNHxIWY4QozpALeLPg14E598hnsARqkBprzpvftLoeS4rEDkVY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 98c80ac9-6a34-460b-65cb-08d5fbb133c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1113F314DC648CA885035D8CA0200@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(130873036417446)(194151415913766);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(346002)(39860400002)(189003)(199004)(13464003)(6436002)(33656002)(486006)(55016002)(7736002)(1511001)(2201001)(86362001)(2900100001)(229853002)(68736007)(53546011)(186003)(53936002)(86612001)(102836004)(14444005)(6506007)(446003)(256004)(476003)(9686003)(6116002)(105586002)(8990500004)(25786009)(5250100002)(2501003)(106356001)(11346002)(14454004)(5660300001)(81166006)(8936002)(8676002)(39060400002)(7696005)(22452003)(2906002)(99286004)(6246003)(74316002)(81156014)(46003)(10090500001)(316002)(478600001)(305945005)(76176011)(97736004)(110136005)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: B7K/OTyPB+4Y1w91c5Ju+7WQvkKG85zKi880wg3+1YUT7V9CzUTTns9tWPhxZsGOaGBsIG+QVAAChiRDiQ79tGDLOp3KguBjMAKXV/dt+ydtNtMrlmnIOffWhu++5VV1JmviqMnX/f45LI+lTlDeCUXzT2RlmSKcg5rZK/2t9bkuYa3p8zaYwjPNEXSVbozupXmRkFn8dhjnsMLbMs4Sm2p/6IBp+acfnGJF9pbwnDQJEIHMGsZNK5KhPeVJ+MC8daPDostd/+4M074ZEdUag388xVcAobrwwqkt4SjsQI4LQrFCHGjzSvW2XI+RgPWgr+wsyhJ0wwVA7OGQuLvK/8H+Pt16laXja01BBz3APrM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c80ac9-6a34-460b-65cb-08d5fbb133c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 15:28:03.8475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: David Binderman <dcb314@hotmail.com>
> Sent: Monday, August 6, 2018 1:08 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; devel@linuxdriverproject.org; linux-
> kernel@vger.kernel.org
> Subject: linux-4.18-rc8/tools/hv/hv_kvp_daemon.c:289: dead code block ?
>=20
>=20
> Hello there,
>=20
> linux-4.18-rc8/tools/hv/hv_kvp_daemon.c:282] -> [linux-4.18-
> rc8/tools/hv/hv_kvp_daemon.c:289]: (warning) Opposite inner 'if' conditio=
n
> leads to a dead code block.
>=20
> Source code is
>=20
>        for (i =3D 0; i < num_records; i++) {
>                 if (memcmp(key, record[i].key, key_size))
>                         continue;
>                 /*
>                  * Found a match; just move the remaining
>                  * entries up.
>                  */
>                 if (i =3D=3D num_records) {

Thank you! We will fix the issue.

K. Y
>=20
> Regards
>=20
> David Binderman
