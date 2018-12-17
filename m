Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBA1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D6820578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AjZgIQ3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbeLQPdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:33:19 -0500
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:36897
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733263AbeLQPdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgWlERsSfch0LfRiFKHXqTp/An7IYyO/M+1x7Er4p5Y=;
 b=AjZgIQ3lJqb57jyOtwacRU0d6ND7ndZHwIEO259pkrA/1vJCzKXZkMOmGZomOJy30AOyBoWNu++lAYXAVjY1rj9sCQVsCLRL6UaE3r8wefyy82PHTzcyw3g9rLI+LuKNgV5cCtL8dFh9kL5+7AjXH4gZ2Nz8fk2u5ONpeKHLT9o=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB2877.eurprd04.prod.outlook.com (10.175.23.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Mon, 17 Dec 2018 15:33:12 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::e4fb:858:afdc:c40b]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::e4fb:858:afdc:c40b%3]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 15:33:12 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Olof Johansson <olof@lixom.net>
CC:     arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and
 FSL_MC_DPIO
Thread-Topic: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and
 FSL_MC_DPIO
Thread-Index: AQHUd8kl/5FfCJ+SikWjB0SaOZVRMg==
Date:   Mon, 17 Dec 2018 15:33:12 +0000
Message-ID: <VI1PR0402MB3485A452549CF37694720A7B98BC0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <beb32683-fbd0-fc17-8e71-4f4f51163223@free.fr>
 <VI1PR0402MB3485824A9FB3BC878E7B83D498C60@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20181213064803.kd7p7fzsegu6nhnl@localhost>
 <1541367377.58314.1544910265605@email.ionos.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2877;6:OQ64RjrJ+RAaquOCvPBl0gJ4UivzLxyUI0NOOticYxdgAuOSTJz19O1o1WvGUxct3Ws95v1jeE4fV3GSXmFRS/tmsVgJngH13wxfK4oK2ysju3u1cJ5KRWDdqXT6hezRUCm1NmLkjF2VZIbxSQ3WC2/mHyelAey3SxLaYalAvrON6H8zuuQ1P5eQJuDQI8EPgNPdigRt33aNQdKtJhaIjfmbBjB0vE18wEq18xy4F+7jsz40Oxv4ZjRdEVdfo8GMJr1wHtPb3M0a+JisM5FGwSBaYl4nN1/QLOtEYGAQ+eBvylV/D0l66mLYZbl+md2k/fCbI4e3n5Nx5zgyTLc1vRMzqdthidOpp3vzBXnr3VkKlKwOP2bZD0jTV1pRB+DOg5k7tLRXZfBEPLzsJDksZh/8JP4RH673ePur8IebZ7tjyhZG27DZLkY3madypzx9G8tqvFGQjpyq9DjAjZ/ACg==;5:uV/JgAXwfeJUiBMVNGfdMUw5he32CsW0R5DqQUU2wzHAk6tztpksT6SH4eEnBz6lI21rLcammO6kY9Xl/wJGFalOTjTyFVFaMWm4u1KA2ZWkhTZpaLvDNYUTbxX5F/760tLxjttsF9gAMbtfUi9x5fOo3fYt48DBhN5fUfZMkyw=;7:yasVmUpuY4R3nY4MaU0FYwNoRVTaGH+/RzhpBDJ910yW2uunzus9ALp/3vmcN/oivTGLnuJguqyDWYs14sSjd5pgYnYfBwNEG9tXI0URxMf6ocIB/xm6Jv6Zkh6L6svEDpNtBgBR1JYpbIgFEDgJFg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2422fd10-b15c-4eda-a8e2-08d66434f4bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2877;
x-ms-traffictypediagnostic: VI1PR0402MB2877:
x-microsoft-antispam-prvs: <VI1PR0402MB2877D00C5AE8FB9DD552458998BC0@VI1PR0402MB2877.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB2877;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2877;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(71200400001)(305945005)(9686003)(55016002)(106356001)(6116002)(105586002)(8936002)(5660300001)(8676002)(81166006)(186003)(7696005)(53546011)(3846002)(102836004)(99286004)(81156014)(33656002)(53936002)(54906003)(93886005)(26005)(4326008)(2906002)(66066001)(7736002)(6506007)(68736007)(76176011)(478600001)(44832011)(486006)(6436002)(86362001)(14454004)(476003)(446003)(256004)(71190400001)(229853002)(25786009)(97736004)(74316002)(110136005)(316002)(6246003)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2877;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: StmW+DKjhNAZNSLpHtvbXZHAKPxl9WZnwOhwq3VzE9meCyFGsvrhywIg1ja+u31klCgGDsjzKAhD5XNjULQ2I62pktFbfkyOvBjVf6kUVF4JjWrRnrXSdh08Y6MrL7qsLrCapeRAmcxMLgnqiw2bbnKf6NMAemnNb1+hNYXHNL/Rs0/xL6qrIa/iKuLcIvTVAlZPC9UvdnYbUStS4Z0G93a4pF61Qm9dW2MalnUa2aXZVlz+pQhQ6h5OSo5G6ezHeY7XB06XcVGdKQNyzHwDSiX25tPcai5Ix9WhZ/Btu2H7R6vUKoaflsxU9uDgNNuB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2422fd10-b15c-4eda-a8e2-08d66434f4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 15:33:12.5189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2877
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/2018 11:44 PM, Stefan Wahren wrote:=0A=
> Hi,=0A=
> =0A=
>> Olof Johansson <olof@lixom.net> hat am 13. Dezember 2018 um 07:48 geschr=
ieben:=0A=
>>=0A=
>>=0A=
>> On Fri, Nov 09, 2018 at 06:05:24AM +0000, Horia Geanta wrote:=0A=
>>> On 11/9/2018 3:11 AM, Marc Gonzalez wrote:=0A=
>>>> Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")=
=0A=
>>>> enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,=0A=
>>>> which is not set. Enable FSL_MC_BUS, and build FSL_MC_DPIO and=0A=
>>>> CRYPTO_DEV_FSL_DPAA2_CAAM as modules.=0A=
>>>>=0A=
>>>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>=0A=
>>> Reviewed-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
>>=0A=
>> I had to redo this one, and when I did I noticed that there's also an et=
hernet=0A=
>> driver. Should that be enabled as well?=0A=
>>=0A=
> =0A=
> this patch in next-20181214 breaks "make modules_install" for arm64/defco=
nfig on my Ubuntu machine:=0A=
> =0A=
> DEPMOD  4.20.0-rc6-next-20181214=0A=
> depmod: ERROR: Found 6 modules in dependency cycles!=0A=
> depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> authenc=0A=
> depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> fsl_mc_dpio=
=0A=
> depmod: ERROR: Cycle detected: dpaa2_caam -> caamhash_desc -> dpaa2_caam=
=0A=
> depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> caamhash_des=
c -> error=0A=
> depmod: ERROR: Cycle detected: caamalg_desc -> dpaa2_caam -> caamhash_des=
c -> caamalg_desc=0A=
> =0A=
> After reverting of this patch the issue disappeared.=0A=
> =0A=
Seems there's a dependency cycle b/w dpaa2_caam and caam{alg,hash}_desc, as=
 follows:=0A=
=0A=
A->B=0A=
---=0A=
dpaa2_caam needs cnstr_* exported by caam{alg,hash}_desc=0A=
=0A=
B->A=0A=
---=0A=
caam{alg,hash}_desc need caam_imx, caam_little_end:=0A=
caam{hash,alg}_desc.c=0A=
	--> desc_constr.h (included for descriptors generation functions)=0A=
		--> regs.h (included for endianness helpers)=0A=
			--> extern bool caam_imx, caam_little_end=0A=
caam_imx, caam_little_end are exported by dpaa2_caam - caamalg_qi2.c (when=
=0A=
CONFIG_CRYPTO_DEV_FSL_CAAM=3Dn)=0A=
=0A=
Could we drop this patch, until CAAM driver gets a proper fix (which is not=
=0A=
straightforward)?=0A=
=0A=
Thanks,=0A=
Horia=0A=
