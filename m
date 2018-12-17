Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB80AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C16320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o1aQPLDe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MP2+6xVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbeLQSEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:04:47 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52962 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeLQSEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1545069886; x=1576605886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8SuznCJxKxbO6GHZfVgeoTmwhmx0ZhGZHjP+I6wVvpY=;
  b=o1aQPLDeMuxlEGFj8+Zc/yoKRq48iEW7niu0yLaB5ccRlLGC9VsQEAky
   YEwrNwFUtlDsJTwmZxBzC8nMrEX6p3XM1DKRPJnCU2iDyfjwlCgjg6ON8
   TeMuxJOdDxfGTbmBXB9Opn+WSBuBHStYODvkRF8CGIiN7/pWmO2UywFDM
   qup+K2XejSAMuRfYAydmnlrMtRqU86MLVGhtvOrbfRa0jc0Qcd4fAZbs+
   BdAGC2OySCAQX9tGK978LAy2E8MnEwfwyD7G+0kRAKTLbXH5/FNEQjAYy
   xKkvLIvFBU6wCVtG9D75j0PRs0EOXkP/fJkuAFl5ghHabyOTgT4yJjUBX
   A==;
X-IronPort-AV: E=Sophos;i="5.56,366,1539619200"; 
   d="scan'208";a="98008198"
Received: from mail-by2nam01lp2054.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.54])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2018 02:04:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SuznCJxKxbO6GHZfVgeoTmwhmx0ZhGZHjP+I6wVvpY=;
 b=MP2+6xVGT+/O2TCRvrkAAImXvIaKIoUExhjyHdXZP366gOgWmhypir61XW7f+++bjIX/qA++A78+Df37gGmfZeq+xjr3lB/ZCjRQ9ui9wloOOBs+ddJ6JUFekrRCQ3MBGlvSmxbmX1FyfLFOLTZktoH2ug2T+06x5DR5VxaWrgc=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB5893.namprd04.prod.outlook.com (20.179.59.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Mon, 17 Dec 2018 18:04:45 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::6155:b583:4364:5623]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::6155:b583:4364:5623%4]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 18:04:45 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] nvmet: fix comparison of a u16 with -1
Thread-Topic: [PATCH][next] nvmet: fix comparison of a u16 with -1
Thread-Index: AQHUk9tIdnFZ2t3vG0KuaznHJpcvn6WBkIYAgAEnoQA=
Date:   Mon, 17 Dec 2018 18:04:44 +0000
Message-ID: <178EFF23-A96E-4DB3-B8E8-8EBF906030F1@wdc.com>
References: <20181214183121.17445-1-colin.king@canonical.com>
 <20181216162638.GB12651@lst.de>
In-Reply-To: <20181216162638.GB12651@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.13.0.181109
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:2902:f782:f5d3:cdc2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB5893;6:bkWhmuUaNxPtlMCP4u9OObgmSNn70VV1hAOT2t2MlbRlLF7JIoBvEknJu2Cne5vxTut3/2hSLL6yTPZB3GFIY8fNilJ27GdcaO0dSKJNBSY1dNGia8EiI+sD7hX0+S299YpqYP4f/EGPBk8sIuhQQJjm9lEDVmtFMPfelAZ7E0vMn4eFpo72CnXyuOc2fe3+Bu69ozRKjO9TyIKfIzPHxQIwzpiJlnB4Auvd6MAJB0Z1QlArwux83u/erVWeXPdstUyKhNu0aWWHEoL67P4kSOGjy/2dLWVFniT/TQ3uStj5cDiKLL9Cq5JQLkDiDZJdWfQvUxmKwdFzZM+dI4Us3pVY3QiCerbv72FWhljBXKBa3Eko8GHVwA6KdhXnn/hbS+o8QcnSl7Z8j0zXnkG2GfL9Lk1+sKUjSyPrmyCb0w6wlS2jZTXA50190LC7Rz5bXzGV3oelyzq/e34aE/fFlw==;5:+kowdfpn1vycTQguOFuataZFxk8mLuNlAdRmSuZ0RUNdgH/ZIAT7wcDCQippdie8w0Mer2dNy54PmAfgrPVDh2/G+U0QowBDWLEhPj5hfegz8au2yZL+5Fh17+iO+nRYFqEs2d6YW4NCFnCR3OyV/EZDhVZBgTQ+SewhhAMsllk=;7:5FtKkh0UHjxDzq6FJ0Wo9mb8oOYG1NXhS4RCT4XXzyuCiB8O2xqI6KeKLmCEx8UFc51YAwRaWvIWkCyVQY6z/7OnRfpYAFXR5nXFSZXv3oK1mZr56KupnvCoW3jnbw4Bt/JP6fVfoqsyaQs8M6ozOQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aa1adce8-38a0-4085-3fb5-08d6644a2057
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB5893;
x-ms-traffictypediagnostic: BYAPR04MB5893:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5893397F93AFE92E7F08A82B86BC0@BYAPR04MB5893.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR04MB5893;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB5893;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(376002)(136003)(346002)(199004)(189003)(8676002)(25786009)(4326008)(53936002)(83716004)(11346002)(446003)(476003)(256004)(8936002)(99286004)(6486002)(2616005)(46003)(106356001)(105586002)(102836004)(72206003)(97736004)(36756003)(6506007)(6916009)(14454004)(81166006)(76176011)(81156014)(305945005)(7736002)(5660300001)(82746002)(558084003)(6436002)(186003)(478600001)(486006)(316002)(6512007)(229853002)(6246003)(2906002)(6116002)(54906003)(58126008)(33656002)(71190400001)(71200400001)(68736007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5893;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Qn3wceSaCO0I7WuUhwzSNDkPLJ1sjLWk7QXYpfY29CyRv47LSzV58F4cD5U7CHSkOI+Yfbz858qHy62dhQOoA0Erg2Wfmoh+CpGsVsfapHHowVokeQXq17k83ns1ud04UMHa6NGQVIlBdfWMDBs2tgLAI4xnicAj1Fk0zfqCFymce++JZdOPTUxsZLOxKSxY9BLvNiD1pNStDs2VGgsMu8R4LW0I6uMA6YPfOjy8bCcgOP3SoSaAHJlKYl6Tnex6VCHJ5adngagDCJi4ntOjYQx4jrWrXCzgo46C27+qdeE88xtJ/9wMETTbkPOYpsRl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB1131BC772CEB44BE86ED823F933B8E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1adce8-38a0-4085-3fb5-08d6644a2057
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 18:04:45.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5893
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpXaWxsIHNlbmQgb3V0IGEgcGF0aC4NCg0K77u/T24gMTIvMTYvMTgsIDg6MjYgQU0sICJDaHJp
c3RvcGggSGVsbHdpZyIgPGhjaEBsc3QuZGU+IHdyb3RlOg0KDQogICAgVGhhbmtzLCBhcHBsaWVk
Lg0KICAgIA0KICAgIE1heWJlIGl0IG1pZ2h0IGJlIHdvcnRoIGFkZGluZyBhIE5WTUVfTk9fRVJS
X0xPQyBkZWZpbnRpb24gdG8gY2xlYW4NCiAgICB0aGlzIHVwIGEgYml0IG1vcmUuICBDaGFpdGFu
eWEsIGNhbiB5b3UgbG9vayBpbnRvIHRoYXQ/DQogICAgDQoNCg==
