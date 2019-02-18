Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFC1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514582177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="c8NjvtkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbfBRR1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:27:08 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:43598 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730010AbfBRR1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:27:08 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IHOMpH016222;
        Mon, 18 Feb 2019 11:26:50 -0600
Authentication-Results: ppops.net;
        spf=pass smtp.mailfrom=James.Schulman@cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2qpftrtw94-1;
        Mon, 18 Feb 2019 11:26:50 -0600
Received: from ex3.ad.cirrus.com (ex3.ad.cirrus.com [141.131.36.34])
        by mail4.cirrus.com (Postfix) with ESMTP id 3203B611C8BA;
        Mon, 18 Feb 2019 11:27:25 -0600 (CST)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (141.131.3.15) by
 onprem.cirrus.com (141.131.36.34) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 18 Feb 2019 11:26:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector1-cirrus-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r188GdoDu3LYye01QegVn50xD53bRIWVWmfhqO3lzY=;
 b=c8NjvtkGmo0Ra4t1+X/r2ReC6H5LYvbde9YTauCDiUOTsW8qO2WHZxSRkt2Hrr4usB5GJ1pfRhJ1poBBMLR/1rfnzbF3MAdsjIUt23v5nGftL4tHZ/RU7tywqqoEVmfBQpBb5BQ61xqEK8tic9pR7MS17UpTqIiKT0ILNQOXUuo=
Received: from DM5PR19MB1580.namprd19.prod.outlook.com (10.175.225.146) by
 DM5PR19MB1371.namprd19.prod.outlook.com (10.175.225.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 17:26:47 +0000
Received: from DM5PR19MB1580.namprd19.prod.outlook.com
 ([fe80::fc49:3658:64e3:89ab]) by DM5PR19MB1580.namprd19.prod.outlook.com
 ([fe80::fc49:3658:64e3:89ab%12]) with mapi id 15.20.1622.020; Mon, 18 Feb
 2019 17:26:47 +0000
From:   "Schulman, James" <James.Schulman@cirrus.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
CC:     "Austin, Brian" <Brian.Austin@cirrus.com>,
        "Handrigan, Paul" <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Schulman, James" <James.Schulman@cirrus.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] ASoC: cs35l36: Make some symbols static
Thread-Topic: [PATCH -next] ASoC: cs35l36: Make some symbols static
Thread-Index: AQHUx68g8/DYRrkB5kyIo4aa8oEpQQ==
Date:   Mon, 18 Feb 2019 17:26:47 +0000
Message-ID: <alpine.DEB.2.10.1902181126050.1596@james-tower>
References: <20190218074653.181365-1-weiyongjun1@huawei.com>
In-Reply-To: <20190218074653.181365-1-weiyongjun1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR06CA0067.namprd06.prod.outlook.com
 (2603:10b6:408:34::44) To DM5PR19MB1580.namprd19.prod.outlook.com
 (2603:10b6:3:14f::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-x-sender: james@james-tower
x-originating-ip: [141.131.2.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4267ce3b-b78d-4ed9-0d59-08d695c64271
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR19MB1371;
x-ms-traffictypediagnostic: DM5PR19MB1371:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR19MB1371;23:sAhtU2WuBXfHszvhLrff+yvKbi0DJZsSeLee+ounk?=
 =?us-ascii?Q?xqjWp+Q1XKHoJIIY3Hf5TzCWSU7qYyUGoHF4wOrGKcOUluPvMW1biYT2cJ0e?=
 =?us-ascii?Q?PzpajWly2M1FfjHM9TcV36KLe1jgPZ8EhqKeo65mqsC6ZydktthQLsEEI/4a?=
 =?us-ascii?Q?GaOlxFXv+xlavXzhQg+KzafARwNmtX38FPIg+bcGk3coM4YIivVVRma2vzWQ?=
 =?us-ascii?Q?pCgGSFdHkp9+gDgHj3Ic1k8tIOMvQk+ubWh/VZYVTY6x7uY1rSh2vs1zTlRO?=
 =?us-ascii?Q?v+tFTCQkq4lHlBnIQ3epOiBldGCHzZJ6Av2IVdNme6iBUVP7qnfuWBrsQSj2?=
 =?us-ascii?Q?nzHF8Org9q8D25o2TOo+Up13YDSn5iiqnABD4KFh5j/7fJbb8Df80OLvgyuF?=
 =?us-ascii?Q?TAtEZW5DE4lU9Z12WJ5S7jM3YKR6+/AXIBrAfVZ4SmqRZ6ZUfjyqj3CiG3gf?=
 =?us-ascii?Q?zTCHS145G20xfhvNKwPNGff6CrlAQUUAtlHFs2fe9eGb/NuFeRl5gAVHNpcm?=
 =?us-ascii?Q?eL1hTXD7mUFXlaKlGiei95LFdLeJfHYs5a2hguQtwM997eHlgpySyGlQ2mZq?=
 =?us-ascii?Q?cXF8cd/cIs7uLReD3S1L+riwnEQ9rVgo+UCJjF2G7YQYeXLcPK/wbu3JChtD?=
 =?us-ascii?Q?j/LvpHZVHe+9ZfYpmiptDIpdb8JMvzIzRd3To40bu+HfWDHwswnUk381DUgc?=
 =?us-ascii?Q?qq4N1U73zV8fZ7dP9eGFGTUIrmigNKEQnQwMAcqZrIw+bNiW6okpkTn3KLZS?=
 =?us-ascii?Q?LfaB/7477k8YwQ4MizbLI4QxdmZhF97uJyWMFqFXDAqpasVRvpsMLp8BTye9?=
 =?us-ascii?Q?xUsIGZr3YBHfsgclW+DoAKInAbaFm1vSaq3UVxPtjaPF8u428KL1BW4+n1Fb?=
 =?us-ascii?Q?d+jr5fMvjFoGo0KHS9XrtjuxteIXvyocux5iTrrPIrJqUYcun1f5QfZeGZl4?=
 =?us-ascii?Q?6HxBZstKMJGJIaSstR1XuSE7pJPdzl/cAeY5zVSDhcW85WAMkfcbwKUhqMsK?=
 =?us-ascii?Q?MmuGvdArotzvIHsNWHfgKs3TLM7qqirck5Lh6RlvswnBOnwZIj0xWwSmOV6I?=
 =?us-ascii?Q?1tkMxphQ9L6tjgw//W7v6VnNTeoaoyX7OX966w4TJpa3Ci88cqPObkjLhbv6?=
 =?us-ascii?Q?FN60YumZpZ21thQ2d9hHvuOWuUW6BmSy355amT3rm4hxDb8Kl4jr9Cr8dZ6x?=
 =?us-ascii?Q?a79VR7H3yGuUVsHoUnFys53dsbZ0Fmc/M8d4gAqeUAK00kzSS6wD7uXsaT3d?=
 =?us-ascii?Q?BvCXQGpt1ciayjMZexOZCHVQ8VVxg+2SkcGI7HerooqBpgvnx1o9ZLLBz5gi?=
 =?us-ascii?B?Zz09?=
x-microsoft-antispam-prvs: <DM5PR19MB1371BFD925EF6F605D78DB6CE4630@DM5PR19MB1371.namprd19.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(376002)(39840400004)(346002)(136003)(396003)(199004)(189003)(6486002)(33716001)(11346002)(446003)(66066001)(186003)(6246003)(316002)(8936002)(105586002)(106356001)(71190400001)(81156014)(81166006)(54906003)(7736002)(86362001)(53936002)(6916009)(478600001)(26005)(14454004)(305945005)(476003)(9686003)(6436002)(14444005)(486006)(99286004)(33896004)(229853002)(2906002)(25786009)(97736004)(8676002)(256004)(386003)(6506007)(5660300002)(6116002)(52116002)(76176011)(3846002)(102836004)(68736007)(72206003)(4326008)(71200400001)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR19MB1371;H:DM5PR19MB1580.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cirrus.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L+ud1LIFxpgl6K+s79zVB4m4K7+PN0/BSMGKbDNHxgxVZKYEeI7lg1QEoSvzbFMAjq0JZ3+z6QZjQCmj6x9xtMKI6//3T0Aberm8hpX+YIXvvD5nWK7j/ZEbSwPNHVHSKY+cEGfD/xcujg5vm1UvIztC41ZoR+eCQRQQmFdLmVAKVdNRvFbOE3KwBp8TnZ+BlKjpBpepUa00u0Z2GpKUoTltzX5pDJq80pqhQFiuI1050fPEQa56eytjG/ZwDpPs65xUgoMC1/6sAx7Ay/iZelNXYO/nut7GFd0HnYzRNmbHlWCkY5ev8fK0RKFINhiohVEMNSSAzktt/HOnB2jStTespNT5LTdb3ocHt6Aowdf3MjsT482svPl/bfW+HJhqql6M30rP9HWw6/FAJ3MU67LWvT4S6T6fiTbHmmNW/UA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <94AED2AAD7DAF647A3D83FF6941D0803@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4267ce3b-b78d-4ed9-0d59-08d695c64271
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 17:26:45.9363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1371
X-OriginatorOrg: cirrus.com
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com ip4:141.131.128.20
 ip4:141.131.3.20 ip4:213.128.236.230 ip4:87.246.98.25 ip4:87.246.78.26
 ip4:87.246.76.56 ip4:87.246.98.35 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902180129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Feb 2019, Wei Yongjun wrote:

> Fixes the following sparse warnings:
>
> sound/soc/codecs/cs35l36.c:135:20: warning:
> symbol 'cs35l36_reg' was not declared. Should it be static?
> sound/soc/codecs/cs35l36.c:248:6: warning:
> symbol 'cs35l36_readable_reg' was not declared. Should it be static?
> sound/soc/codecs/cs35l36.c:398:6: warning:
> symbol 'cs35l36_precious_reg' was not declared. Should it be static?
> sound/soc/codecs/cs35l36.c:410:6: warning:
> symbol 'cs35l36_volatile_reg' was not declared. Should it be static?
>
> Fixes: 6ba9dd6c893b ("ASoC: cs35l36: Add support for Cirrus CS35L36 Ampli=
fier")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> sound/soc/codecs/cs35l36.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
> index 4f880a678812..005f1adc80b8 100644
> --- a/sound/soc/codecs/cs35l36.c
> +++ b/sound/soc/codecs/cs35l36.c
> @@ -132,7 +132,7 @@ static const struct cs35l36_pll_config cs35l36_pll_sy=
sclk[] =3D {
> 	{27000000,	0x3F, 0x0A},
> };
>
> -struct reg_default cs35l36_reg[] =3D {
> +static struct reg_default cs35l36_reg[] =3D {
> 	{CS35L36_TESTKEY_CTRL,			0x00000000},
> 	{CS35L36_USERKEY_CTL,			0x00000000},
> 	{CS35L36_OTP_CTRL1,			0x00002460},
> @@ -245,7 +245,7 @@ struct reg_default cs35l36_reg[] =3D {
> 	{CS35L36_PAC_INT7_CTRL,			0x00000001},
> };
>
> -bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
> +static bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
> {
> 	switch (reg) {
> 	case CS35L36_SW_RESET:
> @@ -395,7 +395,7 @@ bool cs35l36_readable_reg(struct device *dev, unsigne=
d int reg)
> 	}
> }
>
> -bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
> +static bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
> {
> 	switch (reg) {
> 	case CS35L36_TESTKEY_CTRL:
> @@ -407,7 +407,7 @@ bool cs35l36_precious_reg(struct device *dev, unsigne=
d int reg)
> 	}
> }
>
> -bool cs35l36_volatile_reg(struct device *dev, unsigned int reg)
> +static bool cs35l36_volatile_reg(struct device *dev, unsigned int reg)
> {
> 	switch (reg) {
> 	case CS35L36_SW_RESET:
>
>
>
>

Thanks Wei. I agree with the changes.

Acked-by: James Schulman <james.schulman@cirrus.com>
