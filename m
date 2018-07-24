Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AFAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E117920856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YXMaiR4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E117920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbeGXPde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:33:34 -0400
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:61312
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388455AbeGXPde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zleM3UotCiDDtXeUHzH326t7aanTvB05Up4t11Bzjnw=;
 b=YXMaiR4DHJ/ZdSL2Drv4SAiiaQMOCoySBx3gRmKVpCEq2JzieJFn9qYfrJZS7jrtwz5MGLVpAtvYCXLRH23j0HanMQ3WAHvBRhbJDfaxuKdjWyvIuhqrLDz63la53sEBPYG8FJAJqvjn4C8W+3GEPoraDc6mJgGChL4aNwCvp28=
Received: from VI1PR04MB4494.eurprd04.prod.outlook.com (20.177.54.85) by
 VI1PR04MB0926.eurprd04.prod.outlook.com (10.161.106.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 14:26:47 +0000
Received: from VI1PR04MB4494.eurprd04.prod.outlook.com
 ([fe80::74ad:396f:569a:3811]) by VI1PR04MB4494.eurprd04.prod.outlook.com
 ([fe80::74ad:396f:569a:3811%4]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 14:26:47 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     Horia Geanta <horia.geanta@nxp.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: Re: [PATCH v2 4/4] drivers/soc/fsl/dpio: Convert DPIO documentation
 to .rst
Thread-Topic: [PATCH v2 4/4] drivers/soc/fsl/dpio: Convert DPIO documentation
 to .rst
Thread-Index: AQHUIqa5GYYi0mamyE+21OpfE5TfNw==
Date:   Tue, 24 Jul 2018 14:26:46 +0000
Message-ID: <VI1PR04MB44946C75CDD8BB0DB337181886550@VI1PR04MB4494.eurprd04.prod.outlook.com>
References: <20180723170025.2259-1-roy.pledge@nxp.com>
 <20180723170025.2259-5-roy.pledge@nxp.com>
 <VI1PR0402MB348590E265D062CFC83F7FDF98550@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.88.158.246]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB0926;6:db5ewuoX7qF9C5CWdVBrg4iOYXNxxizjF5UVg7J8GCtx8B/atIAebMcgsr7gDLnF/IPAuNF3MAukW00AgPR5JcOC3ZyGARdIoCA8vlmWoVvLIxSyEI48wSgRWS8EOfWD1jkx8l07HCJ9keaCK7BP/XQrSKG6OXY64Vw5pTQmyDHDQ3eCl280Iz0wCwuqqtyvNW9MSE3OH4eXvhy5OM02hqXGQI8iNvqyJSXj017fSmthXCAGPl8EgRuAP7jabnu5n7VExgm12c9o2csCHTC076GWqdNDP3erhXoYmoXfIMGLd1RrsJ7pXs8ORiv8AshG2uHD/rG0tZpdefNp0WSfaBYEihSJpSU5ng53d5NK5Y8f7XZFLO0gzYxsT4vyOQPY+tZcDiNwzjViqersSrrS/SRzyVMccy+gCK8Lzbp/jVtBTiT4Jh+oLtv7DAJTEWf7g/EkLI3bidzLhbrOdGxAWg==;5:3Eak3v1DZGJXKYYb6j0O2mR72rXdsfKWUxNlKdtvBDcnwJffEVF9RHh7KWO2sjYWl3BmK9JorZyoXRsYXz7WWXHB9utY1+tz6gA2NR08PzH0fNJ7clpj7/kJj7fF4v310Ym4D7UQ4uzAvFj7+D5OmM9we1Z5z3wpvjAieFE3KRk=;7:ItXMI6v7sZwR+ja0G845lW9sHxiS190BEdzTY86sx4dIHPEbvYq795Qe0Db3cvFpPJL/t2LZI2UOsDk/wzfD4Sp5CgPXG2oBzx5xgWHr4wKCUJgwlJvMxuHJlcMgZhDHBzOo8T3qhBbKHW1PkTAJpCx0Kd8dmLNNxSaLuSqZy7hn9AY/TFkiC2mxA8xJGDnq61wFdwrBSpU2CIGa/C/8tRLFb2qUT+REcGaCD/txkOMJf9BM3+QaimHvRAP0V3u1
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 77aff260-600f-4140-fb47-08d5f1717cd5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB0926;
x-ms-traffictypediagnostic: VI1PR04MB0926:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-microsoft-antispam-prvs: <VI1PR04MB0926553D4F5E5481287C13A986550@VI1PR04MB0926.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB0926;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB0926;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(256004)(6116002)(5660300001)(44832011)(3846002)(106356001)(6436002)(2906002)(9686003)(55016002)(2900100001)(33656002)(105586002)(97736004)(6636002)(25786009)(86362001)(8936002)(81156014)(81166006)(4326008)(8676002)(446003)(476003)(26005)(229853002)(54906003)(102836004)(6506007)(74316002)(7736002)(305945005)(2201001)(316002)(66066001)(110136005)(14454004)(478600001)(76176011)(7696005)(53936002)(99286004)(486006)(68736007)(2501003)(53546011)(6246003)(5250100002)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB0926;H:VI1PR04MB4494.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BIJt+FVcZ0lYM5x42nb03Ya6j5UERLLHgyxvwGA0CZfAW1juJcEljAxF+sWLSE75tP5hy3mCpDJ3NByzvNmZBA0atEAiIzbrDFN+iLCE15RvvFmRYDLpRsFXUJJVZxOIHsbvrUcP3fGcq966OaX0/YOCckBgokJlRahEe6rSqG+s8JBAgGj4/LZ4biJRixu9tdKyAGhmr3lTSTWIMSTVOplhO/HBPS0m3pCDNN4gDNSrtLwhceessdhq2JCTwYRGPSBWNKu0ypwbHqqkXAPzep0t2WrT+BhTYEcpyIqopvOwSpKm+jjRzkRvyz95KObNf9jjwSLKJged6QipsLLFce6b5xlG/XcUAPnwxhVWO4k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77aff260-600f-4140-fb47-08d5f1717cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 14:26:46.9852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB0926
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/2018 9:52 AM, Horia Geanta wrote:=0A=
> On 7/23/2018 8:00 PM, Roy Pledge wrote:=0A=
>> Convert the Datapath I/O documentation to .rst format=0A=
>> and move to the Documation/networking/dpaa2 directory=0A=
> typo:             ^^^ Documentation=0A=
>=0A=
>> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>=0A=
>> ---=0A=
>>  .../networking/dpaa2/dpio-driver.rst               | 30 +++++++++++++++=
++++---=0A=
>>  Documentation/networking/dpaa2/index.rst           |  1 +=0A=
>>  2 files changed, 28 insertions(+), 3 deletions(-)=0A=
>>  rename drivers/soc/fsl/dpio/dpio-driver.txt =3D> Documentation/networki=
ng/dpaa2/dpio-driver.rst (94%)=0A=
>>=0A=
>> diff --git a/drivers/soc/fsl/dpio/dpio-driver.txt b/Documentation/networ=
king/dpaa2/dpio-driver.rst=0A=
>> similarity index 94%=0A=
>> rename from drivers/soc/fsl/dpio/dpio-driver.txt=0A=
>> rename to Documentation/networking/dpaa2/dpio-driver.rst=0A=
>> index 72ba9da..3a33a33 100644=0A=
>> --- a/drivers/soc/fsl/dpio/dpio-driver.txt=0A=
>> +++ b/Documentation/networking/dpaa2/dpio-driver.rst=0A=
>> @@ -1,7 +1,16 @@=0A=
>> -Copyright 2016 NXP=0A=
>> +.. include:: <isonum.txt>=0A=
>> +=0A=
>> +DPAA2 DPIO (Data Path I/O) Overview=0A=
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>> +=0A=
>> +:Copyright: |copy| 2015 Freescale Semiconductor Inc.=0A=
>> +:Copyright: |copy| 2018 NXP=0A=
>> +=0A=
> Existing copyright should be kept.=0A=
> 2018 could be appended if needed.=0A=
I have resent v3 to address this oversight.=0A=
=0A=
Thanks=0A=
=0A=
Roy=0A=
> Regards,=0A=
> Horia=0A=
>=0A=
=0A=
