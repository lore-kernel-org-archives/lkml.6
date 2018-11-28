Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0E9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D38C2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D38C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeK2EJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:09:25 -0500
Received: from mail-eopbgr700090.outbound.protection.outlook.com ([40.107.70.90]:45216
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728883AbeK2EJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY5yBhr8q+dJHXfkqRzWTCaLtmbgiw4CwjKJo3CvOWs=;
 b=aUIWSddgTM23tH+ddCoPM8SNPnd4ViIwkAduXVJ/o3DHsLpOAm05ILMZWgnpUxzkGMP0FfGAl9QjXORs20UOXnyuoCVUqHIa2o1akQZ0/OFkBg8C82KQoK3X3QpMB1gLJPBxEQE80xf/DzinkXjdC+8eiIhbgO9jdDmyIFDViFI=
Received: from DM6PR11MB3131.namprd11.prod.outlook.com (20.177.219.96) by
 DM6PR11MB3499.namprd11.prod.outlook.com (20.177.220.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Wed, 28 Nov 2018 17:07:02 +0000
Received: from DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1]) by DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1%3]) with mapi id 15.20.1361.018; Wed, 28 Nov 2018
 17:07:02 +0000
From:   Ryan Lee <RyanS.Lee@maximintegrated.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Grant Grundler <grundler@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Benson Leung <bleung@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
Subject: RE: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp
 reset
Thread-Topic: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp
 reset
Thread-Index: AQHUhslIRSLmSIj6XkCUBOoX3Wedt6Vk8duAgAB6IMA=
Date:   Wed, 28 Nov 2018 17:07:02 +0000
Message-ID: <DM6PR11MB3131E267C1EDF9254BC7D313E7D10@DM6PR11MB3131.namprd11.prod.outlook.com>
References: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
 <20181128094955.GG6828@sirena.org.uk>
In-Reply-To: <20181128094955.GG6828@sirena.org.uk>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
x-originating-ip: [204.17.143.20]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR11MB3499;6:ZDcRbS8qsisnrj1cgAhKiq+BJ3pBiF6afAsp5n6DMjZrENdbMNaBBbJxsyljzS1JLr7GrLoNKKN8dOLbKwYxJo8xVh+7yOusKoO15hMPuFnnesY1JLHjV+fVJ3205fGzUT2rMRHS6ozyuPPDqeTnxEqd8BN6W9+jX2oo3VTACh0TZKgg+sU5Ba9BztFlqnqDR0OV3aOKGNAk+wyJj08mXWhxr0jHV0esPsoZNckGT5x5FYrRQhidiLkpsKzOEGHIsM8aNkFKXaISLGPIM+MINt8iHR5+aB4TgoSh+GyICq5e5uJANOk1oCnR+PPvePErgINWiwgDkWiQO47+7j6xMSmUuhP9gUmqFcGJfW+y7o3STIDz6O9m7AN0J6Pxe8s9dtWb3E6EJkgpBc9KG50mIo0RxZkFTm9tKw84oR3JPsKoK8EH75g6kg8Q4AmjsBey6B34jEZOVz4ftYcmjpuMUg==;5:k/l+SAFW45+y82wbgg0K88FcDd54ryJpq+wsauaDLzoKtfjV5j+s3W1F+QWHx2UmhuV3VdUlqAAzjjk/cN4pKI5SyEDpuVfTBEeLlGgtw1H0D5gSJ9Gk8Rrwqc7kLbTQRwh+WitZSmdEqofJrtCutGJNo/Zldqj642DwS2N9uhc=;7:G1e3FV0GJ36kmE8bdXmZeGmfnkgoW5qdTE9R599SHTx2hr//btel/DJytpncoSPeIeQYE/o95I9J75RyqK/5Ko+tp4y85LK8O50jqn/OEHVNL5thl5Z5IBGbN4Y6tLhvmQLbwMCNNimCll66w4xtsQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5f7c6075-72c0-4fd5-5e84-08d65553ea6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR11MB3499;
x-ms-traffictypediagnostic: DM6PR11MB3499:
x-microsoft-antispam-prvs: <DM6PR11MB34996D39903A34FE21002CF4E7D10@DM6PR11MB3499.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR11MB3499;BCL:0;PCL:0;RULEID:;SRVR:DM6PR11MB3499;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(346002)(396003)(13464003)(54534003)(199004)(189003)(6916009)(6246003)(105586002)(305945005)(9686003)(6436002)(53936002)(55016002)(33656002)(4326008)(8936002)(54906003)(81156014)(81166006)(8676002)(68736007)(106356001)(99286004)(7736002)(39060400002)(229853002)(316002)(26005)(6506007)(446003)(5660300001)(11346002)(486006)(476003)(102836004)(72206003)(478600001)(186003)(74316002)(25786009)(7696005)(7416002)(76176011)(2906002)(6116002)(3846002)(66066001)(14444005)(256004)(14454004)(71200400001)(97736004)(86362001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3499;H:DM6PR11MB3131.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: CzNT68n9iWXp4/RyfOwkbQdOwAIERRObRqOdpUFAYcwtBgGMcOLQh5+8E/qH0g8BZ0CbHcojSPZAHdx+4Ff373HlJSzb3Qh/9a53gQmP21gzFwuuTzG2mjUygggkNd9flz8X/SX7yBxMKUvhKGOQUJ1mw8FgCU/sXwcOVNivtPCilsMqjsMJ0N/tQSJqk42G9+VFRnbKxgY+YVI+lKNp/HxJEUSikja71ffZa1TFbg1YIMpvgK0lu2VskDzNwroKUygj1nPFA5S1spNi7bt0p70xIiNR32RK42gTpdbDTZoP2mCWmf52duoXyIDqI7gynKGJxz2KF3V7PGiXsq7r+RMPYUHRPM4emn8dTi2+4TY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7c6075-72c0-4fd5-5e84-08d65553ea6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 17:07:02.2002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3499
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Mark Brown <broonie@kernel.org>
>Sent: Wednesday, November 28, 2018 1:50 AM
>To: Ryan Lee <RyanS.Lee@maximintegrated.com>
>Cc: Liam Girdwood <lgirdwood@gmail.com>; Jaroslav Kysela
><perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Grant Grundler
><grundler@chromium.org>; Kuninori Morimoto
><kuninori.morimoto.gx@renesas.com>; Benson Leung
><bleung@chromium.org>; alsa-devel@alsa-project.org; linux-
>kernel@vger.kernel.org; ryan.lee.maxim@gmail.com
>Subject: Re: [PATCH V2] ASoC: max98373: Added max98373_reset for stable
>amp reset
>
>On Wed, Nov 28, 2018 at 03:20:16AM +0000, Ryan Lee wrote:
>> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
>> ---
>
>Not seeing a changelog here like I asked for :(

Actually I added changelog as below. Do you mean this is not sufficient?

Changes since v1 : Removed unusual repeat for amp software reset and verifi=
cation.
                   Amp software reset will be performed once and it repeats=
 verification maximum 3 times if it is failed.
                   Wait 10ms before every verification trial. Maximum 30ms =
delay will be applied to wait AMP idle state.

>
>> Changes : Created max98373_reset function to minimize code duplication.
>>           Changed regmap_write to regmap_update_bits. Other bits except =
LSB
>need to be masked.
>>           Added reset verification step to make sure software reset is c=
ompleted
>well. Software reset is done in 10ms in normal case.
>>           Revision ID is available when the amp is in the idle state whi=
ch means
>software reset is completed.
>>           Software reset will be performed maximum 3 times to avoid amp =
reset
>failure. Generally it is done in the first trial.
>>           sleep time after software reset is increased + 30ms for every =
retrial.
>Maximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 times).
>
>This looks like it's supposed to be a changelog but it isn't one?
