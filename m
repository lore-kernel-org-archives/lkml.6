Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B48C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482F72070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I+TXy88O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfAGGAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 01:00:43 -0500
Received: from mail-eopbgr690068.outbound.protection.outlook.com ([40.107.69.68]:5013
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725550AbfAGGAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 01:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3bx12YMRYopC3qSqaBCHr1LKPQMb7eFSGCGV8z6sFc=;
 b=I+TXy88O4jOuUHsW+VKOjhli3shSiy6br996VKcyGjnZFOAoqqoURc6dXF5x16CP7fXnsZ42O/dpmEI9NKd6DnbklgrDkzI9tMQyKjcMAfCIzQr2WuJE5HyH+J2Q7/EF8p7TdwETpsiypu+X40n5jxeesKobUlMHMh6vrj5evPU=
Received: from MN2PR12MB3088.namprd12.prod.outlook.com (20.178.241.29) by
 MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Mon, 7 Jan 2019 06:00:35 +0000
Received: from MN2PR12MB3088.namprd12.prod.outlook.com
 ([fe80::84f:52f7:9e06:56]) by MN2PR12MB3088.namprd12.prod.outlook.com
 ([fe80::84f:52f7:9e06:56%3]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 06:00:35 +0000
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: AMD: Add delay before starting to capture
Thread-Topic: [PATCH] ASoC: AMD: Add delay before starting to capture
Thread-Index: AQHUo02imjPlpUOJIkieuHvQLigEv6WfCyqAgARKm4A=
Date:   Mon, 7 Jan 2019 06:00:35 +0000
Message-ID: <eac20959-2904-aef1-eca4-0f85c45b1207@amd.com>
References: <1546510559-17798-1-git-send-email-akshu.agrawal@amd.com>
 <20190104122741.GA4140@sirena.org.uk>
In-Reply-To: <20190104122741.GA4140@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::26) To MN2PR12MB3088.namprd12.prod.outlook.com
 (2603:10b6:208:c4::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.56.249.162]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3455;20:EGN7Lg+XWz6MqSX8oHDd38sObC/rHx4U0tWbkbeZQUYMMt/gBeFt/FAvLaNQ+fZRgiBs6knIqeIXizB/3P34sjTtd7u0VuP3JkuEcew6ckHHDRY4CHOcKEpv39y8kORODz/z0C4hW4s+PFX69WX+s7JCKmICvSnznAuvn5J0Md5cMNfq3Poo3BZs5IAlXu6IYG/VrWMSIYNDeBdnnqgeoHpxBn9S1U0+4sjN4iGLdz9J9qAGb4m6WNqszEuPoiMO
x-ms-office365-filtering-correlation-id: e69494fb-dcd7-4fb0-9fbf-08d6746570b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3455;
x-ms-traffictypediagnostic: MN2PR12MB3455:
x-microsoft-antispam-prvs: <MN2PR12MB34551BC6C3D1589B2944B83BF8890@MN2PR12MB3455.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MN2PR12MB3455;BCL:0;PCL:0;RULEID:;SRVR:MN2PR12MB3455;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(7736002)(256004)(39060400002)(6512007)(68736007)(11346002)(2906002)(99286004)(6916009)(36756003)(53546011)(71200400001)(386003)(6506007)(26005)(31696002)(102836004)(446003)(478600001)(3846002)(6116002)(186003)(486006)(86362001)(229853002)(81156014)(66066001)(105586002)(4326008)(2616005)(71190400001)(81166006)(106356001)(305945005)(8676002)(476003)(6436002)(316002)(5660300001)(6246003)(8936002)(76176011)(72206003)(31686004)(14454004)(53936002)(97736004)(52116002)(25786009)(54906003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3455;H:MN2PR12MB3088.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aPWZBDbx8PlNQdQymHxDcLkEw19asQTTv5b+OC1Ihqsb2++U98rQQv2nLFpmZ7JRHeO7zcVooL/9kLJFqXB2D0LhfzK5BcYjqVU/I050UbwoQV/628dS1jbPEzFheqiV67mjeuFMczEiwElcHHVx5QAxmZYMOpsbvi4KkQO3kv4I4qqpVG9b4r4LjJCwHtqK07mX7agmvGDPD2ZN/v47R7elLvxfOzzcTN0pkaZWRKNplFR2LLfx6xBzIsbYTuYiRYEknsGPiBaGQo1qFHAywHLML6Qdg3VZhPoDbhS6B1huCtZiT/tqpoV8fhs+YS9q
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <A2D91547C976C6419B0694D4400AC5E4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69494fb-dcd7-4fb0-9fbf-08d6746570b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 06:00:35.3290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/2019 5:57 PM, Mark Brown wrote:
> On Thu, Jan 03, 2019 at 10:18:13AM +0000, Agrawal, Akshu wrote:
>> On capture through dmic we observe a glitch at the start of record.
>> This is because we start capturing even before dmic is ready to send
>> out data. The glitch seen last for ~20msec.
>>
>=20
>> +	/*
>> +	 * On some platforms, it takes ~20 msec for PDM DMICs and ADAU7002
>> +	 * to settle and start producing proper audio data.
>> +	 */
>> +	msleep(ADAU7002_DELAY_MS);
>=20
> If the delay is required for external components to start up the delay
> should be going in the drivers for those components rather than in the
> driver for the CPU side, that way other systems using those components
> get the benefit and non-affected boards don't pay the cost.  There's
> already some support for this in the DMIC driver at least.
>=20

Agreed, we can use the similar to wakeup_delay in dmic driver in our
codec driver. Will post the patch on same lines.

Thanks,
Akshu
