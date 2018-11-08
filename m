Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313ACC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36FB208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MxFssxol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36FB208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeKHU6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:58:11 -0500
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:38959
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbeKHU6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzxDa8jlOsbhH1AHJ4SiPsGAo8qN743YU7VZxhe2E4M=;
 b=MxFssxolQojwdyeRacnlEKz8z0c82wkgbiafVz+FTz8fN48kLhAZi//1b9jHVL37AJXXcMvVSuxD4q6e+HOxcqZP/c5ZU662TMLDl4a7bF44CCOm5GLuPIxJc5XGhzfSL6zpl+UBAALi8KQ+d5JBfXTYj5g9HRwtjGQxi9wfBv0=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB2768.eurprd04.prod.outlook.com (10.172.255.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Thu, 8 Nov 2018 11:23:07 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::6570:f84e:f9d9:4ca3]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::6570:f84e:f9d9:4ca3%6]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:23:07 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/9] arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
Thread-Topic: [PATCH 7/9] arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
Thread-Index: AQHUdtfqCNpcjJX2bUWA1IsQb0UP1g==
Date:   Thu, 8 Nov 2018 11:23:07 +0000
Message-ID: <VI1PR0402MB3485342DB8A0F5C5791E213798C50@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <e6e0105f-3135-e5b7-8224-419c9f730a09@free.fr>
 <85a73243-0c53-43e5-5002-90631c0a8c90@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2768;6:aLAGylCroCyM5Mw4F3HNJfFgG/PtPBU6wtupB90tMSqtBZdwYVgMLexhNnffuaGEbUdeZvrZ6xWuyDXawBCN2SxYP7GCL49Oe5sUBeTvT6IjropuouU1PszbqvjWaDzJ+GcyinVabUSsRgwrPLQYk7gMgTAQPTgMDMPV5PHp3Zf816nXql3qxGmdbLomHGnc5YspXDMsOtFuW/dJn0JBfrNsdQY6v6mzh9Fgw91IuRAXDJZbMK7cshy3VwgIE0dzVtscSpGnTNUFOAQAYepgpbMSwf+4Jh/G64TxhQf5uXubfS7ZlmTEjtAsxABhNTacE5WI677eun8Xa3FeEJScV+aUEB8yrrJBSDd3DDfc7QoMDpJCzYHka0/UgBrjhsXJNl3mittYkTiTeLAU9ng8/jVGYbp7c+gRT1S0XmzAO9FrRCcKVM8iEO/641o1sn0o7jVG2TubAbQev5AdjVdlrw==;5:kA3L9FeDDlxL1wfhPnPRU2hPl9GGV4YDjE0DZSdh2Org7WulzpDUj+8nxo/4o/pEHlnA4Z+zuRzsBgq2LVpLTjA4/yeFIRvoi1dY/cPhV3SF7JkSnwSfePiww1Stew/EfF6+OfYqCvyaL/bSk5I382uEdO3W2Q43LrvMDnaiLEo=;7:pS39YbXaC3rCyeNEv71sFh3rHPnyTgcRMgGekbLn7XFYgp10XeUEd3yIQZMGxTAcFj12+La5xcDeweBmN9a+BIjGlJNS1BVkoKkCI2MCAOZ7gWSSeXuYl1gBBaqKeMb/liNCIfkBsYE6Sn8cr0YU+A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b73f6379-50ee-4906-88c1-08d6456c8f06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2768;
x-ms-traffictypediagnostic: VI1PR0402MB2768:
x-microsoft-antispam-prvs: <VI1PR0402MB2768450215CF2DAC069913AE98C50@VI1PR0402MB2768.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB2768;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2768;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(476003)(33656002)(316002)(486006)(446003)(44832011)(54906003)(110136005)(53546011)(106356001)(105586002)(102836004)(6506007)(7696005)(26005)(6246003)(76176011)(186003)(305945005)(5660300001)(229853002)(55016002)(9686003)(53936002)(71190400001)(71200400001)(68736007)(99286004)(6436002)(8936002)(8676002)(81166006)(81156014)(97736004)(256004)(66066001)(7736002)(74316002)(25786009)(2900100001)(478600001)(4326008)(6116002)(86362001)(3846002)(14454004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2768;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gyyvhVFRMtKJD5lFlpMNU/JR2eYVjvKJqzxbkrCxMdSYYDDYqPYlHhD8ArSFzWSk534SGiaUfaqtGc+pcm8DiDvVYVOqaSW9rTCDgz9Iv7P2kuyG6WNI3FEScUJ98kzmT07qrk+GWewCuq7iZNy6YXmQTMbzaM99p3EtZYObom/01YLDFkyuDfwp/3l4TV6v2oXDP5u7xfhx1ShsWdph+eJt1LfEeFXlyFIgH6zIcMP8otgxQQZC/3yRQ5XpwQ+/Zmx1TyNfR/bXrgRYHyv2/PVJpHmqM8u/O/+YGa5DbNIvCKEWovqegchCK3ySy2LSSKVl5Db798fomY0Q8gvhaVSwynwSDalZ0OiNEAdq0Vg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73f6379-50ee-4906-88c1-08d6456c8f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:23:07.6867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2018 10:49 PM, Marc Gonzalez wrote:=0A=
> [ Add interested parties ]=0A=
> =0A=
> On 07/11/2018 21:18, Marc Gonzalez wrote:=0A=
> =0A=
>> Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")=0A=
>> enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,=0A=
>> which is not set.=0A=
>>=0A=
Thanks Marc.=0A=
=0A=
Though I would prefer enabling the dependencies:=0A=
dpaa2-caam driver -> dpio driver (FSL_MC_DPIO) -> fsl-mc driver (FSL_MC_BUS=
).=0A=
=0A=
Horia=0A=
