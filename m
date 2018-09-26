Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA23C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353AB20684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vx3ix7Hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353AB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeIZTUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:20:19 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:61903
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726880AbeIZTUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s33nKfy//vqiXM8qXmh0kAVbxSMNS+wwkN+4amW+fvY=;
 b=Vx3ix7HbM7I+Ioj0XmcTykBf+6Id20uwyhhNTV/iRRmSqaEdJ+q336vJBOgn+j1KMcW3qnRODqlfT9r8jh3F9BuG1fZ4fl8WdPXvAKuu4kt6ouMwPwByQJBBpgCP7go3zJsCrxxqjGVkIk4/gqUvzJepnA7k3ezdzrwgRRKwuko=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB2847.eurprd04.prod.outlook.com (10.175.23.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 26 Sep 2018 13:07:21 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::78d5:848c:49af:fbc5]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::78d5:848c:49af:fbc5%3]) with mapi id 15.20.1164.024; Wed, 26 Sep 2018
 13:07:21 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: caam/qi2 - add CONFIG_NETDEVICES dependency
Thread-Topic: [PATCH] crypto: caam/qi2 - add CONFIG_NETDEVICES dependency
Thread-Index: AQHUVZj5HhbrSPS8dEy6uQmb4fo92g==
Date:   Wed, 26 Sep 2018 13:07:21 +0000
Message-ID: <VI1PR0402MB3485AB14555EE65B951F787998150@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20180926130045.2295764-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2847;6:Dd1v+MMsBgIQqSdx3mdOqY+kcDJvpIiXyBZr6fRRcDeQLixPdsfyVtm8S5q2tlHeift+TDCW1mmmnWlhfINjUT6Rk4eZkzafVoluGMAOQ8JCUrDpjj0sSAfrHF2j8o1yr3DL7AIXOwrYOzLcH4PapsyoJ7mW5OTqT+3A1U21Xa4j7inFhOzRL8hTM7rdIdEkgikmOlnGy4q8z8JxVlPIhevOq7JoQHSTWNWozFspXIvyXeaHNAqKnAuIEMFhaECrCwRqrfijyIqlQStBowKrIw3PKYcpoCKbMnYq8fJM/fCg/mrG4i6ut7rkL7zAJplmxYYPoMcX2hok1t8SQHoobsDFSYHb9gzFft197fEriI7b4nzc4HULyjsbJPF4gG7RqvcqgA2ZwLCQcgcwzagXAtHOyM7FY3eBQ2U4e9Ipwy4nZKilUvqLvHTVX511zDVRdQTCzUyTdf44dJE2apzspw==;5:QrCEjoJ/FoPhj9dFMpNM4RoYN74ZfMQVDnBDBBq9/PPn4Dz7gubrvfj+Pm7zfQcBRyXSsTE02SHUbCkAuVjoj5NUudp6dX6m2m1Qbq7WUcRjJxD1WfxyYPixRlnk5c04hhg6b2i0B2hOl8Cxpc0EbKWlIBRZU3Z1pOFfq/THFn8=;7:9I3a//wepERye4PZm44lgzklOQ5MRkpTrmpFeKXWqTem3VBVYmxAnoUQztQcojxrhGgsaJ28akbBDffcsE09tAqM10odtMzNJ8z0iZQajz4wJonKFW7EJWZwDO4/ljRBHBuUeGQG1k4r4Q/YEhdmig42CDqP7lgMo8CRgBjoFDp0iigmmkGu3/cEhHz1KHnKCZyLpbB6o3q7qUgueLRjF7grAkTxlFGcor9hLALYnLTeFcQLkqqClHbH2kXmj8Ec
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5b3d6daa-79f3-49a0-bd4e-08d623b0fee5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2847;
x-ms-traffictypediagnostic: VI1PR0402MB2847:
x-microsoft-antispam-prvs: <VI1PR0402MB28470DF6E8B58E61448BC72E98150@VI1PR0402MB2847.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:VI1PR0402MB2847;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2847;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(26005)(5660300001)(6506007)(53546011)(86362001)(6246003)(25786009)(186003)(4326008)(74316002)(6116002)(7696005)(102836004)(55016002)(316002)(2906002)(305945005)(7736002)(99286004)(33656002)(54906003)(53936002)(9686003)(3846002)(110136005)(229853002)(76176011)(6436002)(106356001)(66066001)(5250100002)(44832011)(105586002)(68736007)(446003)(476003)(486006)(97736004)(14454004)(71200400001)(478600001)(8676002)(2900100001)(256004)(81166006)(71190400001)(34290500001)(8936002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2847;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NxaV81L8m4wu6/Ucx7kZz8MD8ln8RYuiepfxSMVvO9rNmFOlxscCKCv+YuWInzxM8+2D5qXwjVMqblKkFxWhHOPo9obZmOcOEKuo6rOA0KbGRM+uDjIT0mIdZHEw1vE0OjKzrXIK5Wj0OXAn5IsyAN7LMdHj6B6rNimu4mhzqZCY762R9pbKCCOApqAq6GrLtEqfhi/Ou8sHP3hfuc/vV9DEpOXljzB1c+q60te4UbqFE8gvJkhlCtK06x7z0rTuuuaKET/qi2bVK01q8uldO4vktB+OxF8eCwSGpwy/OdFPsoLfxyaxTeSKOx3oGzCPwXc/jKz33+Qv2H534eodobK7hdtv++upysb93idGrVs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3d6daa-79f3-49a0-bd4e-08d623b0fee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 13:07:21.5001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/2018 4:01 PM, Arnd Bergmann wrote:=0A=
> This driver implements a (part of a) network driver, and fails to=0A=
> build if we have turned off networking support:=0A=
> =0A=
> drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_caam_fqdan_cb':=0A=
> caamalg_qi2.c:(.text+0x577c): undefined reference to `napi_schedule_prep'=
=0A=
> caamalg_qi2.c:(.text+0x578c): undefined reference to `__napi_schedule_irq=
off'=0A=
> drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_dpseci_poll':=0A=
> caamalg_qi2.c:(.text+0x59b8): undefined reference to `napi_complete_done'=
=0A=
> drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_caam_remove':=0A=
> caamalg_qi2.c:(.text.unlikely+0x4e0): undefined reference to `napi_disabl=
e'=0A=
> caamalg_qi2.c:(.text.unlikely+0x4e8): undefined reference to `netif_napi_=
del'=0A=
> drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_dpseci_setup':=0A=
> caamalg_qi2.c:(.text.unlikely+0xc98): undefined reference to `netif_napi_=
add'=0A=
> =0A=
> From what I can tell, CONFIG_NETDEVICES is the correct dependency here,=
=0A=
> and adding it fixes the randconfig failures.=0A=
> =0A=
> Fixes: 8d818c105501 ("crypto: caam/qi2 - add DPAA2-CAAM driver")=0A=
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>=0A=
Acked-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
=0A=
Thanks,=0A=
Horia=0A=
