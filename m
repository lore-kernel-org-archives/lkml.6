Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E33C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D57E213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="H7wLmRpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D57E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeK3OZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:25:49 -0500
Received: from mail-eopbgr750135.outbound.protection.outlook.com ([40.107.75.135]:31528
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbeK3OZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg1vMvLLYW1IPTrrI7e7r84uDNWxqHp0L+OmuYiGcI8=;
 b=H7wLmRpGXRxBXfy8i5tOvRv6hVr2NbJbNzJYNn1bIjO6Dz0ENwTCaudgJjpzTiBZFwYBvu3OsRsKGrosQGvrKbWFF8tbr3Se2OOGk8Lqq2/SQ6Trzt3slH1ZvjWAM9ELWu0/bkxbOrO/e7buJOnIbMirJNT7GMHeK290VvVyQdg=
Received: from DM6PR11MB3131.namprd11.prod.outlook.com (20.177.219.96) by
 DM6PR11MB2906.namprd11.prod.outlook.com (20.177.216.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Fri, 30 Nov 2018 03:17:57 +0000
Received: from DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1]) by DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1%3]) with mapi id 15.20.1361.018; Fri, 30 Nov 2018
 03:17:57 +0000
From:   Ryan Lee <RyanS.Lee@maximintegrated.com>
To:     Mark Brown <broonie@kernel.org>,
        Grant Grundler <grundler@chromium.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Benson Leung <bleung@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
Subject: RE: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp
 reset
Thread-Topic: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp
 reset
Thread-Index: AQHUhslIRSLmSIj6XkCUBOoX3Wedt6Vk8duAgAB6IMCAAJO+AIAAn14AgAEJ6cA=
Date:   Fri, 30 Nov 2018 03:17:57 +0000
Message-ID: <DM6PR11MB3131F092601136FF5E626A96E7D30@DM6PR11MB3131.namprd11.prod.outlook.com>
References: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
 <20181128094955.GG6828@sirena.org.uk>
 <DM6PR11MB3131E267C1EDF9254BC7D313E7D10@DM6PR11MB3131.namprd11.prod.outlook.com>
 <CANEJEGse1DGQE6K=sn=bfJuQW=-gM6zps+kvKd8y=yzXjrsTZQ@mail.gmail.com>
 <20181129112612.GB10570@sirena.org.uk>
In-Reply-To: <20181129112612.GB10570@sirena.org.uk>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
x-originating-ip: [204.17.143.20]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR11MB2906;6:qUdElRV5hm9bUoZMPhCnItC+GY/ZdWtBRBaLCl1IWX469szhTxJGTw+CY9OcAC+sSD5vsoUUE/frKLQ338XCdE/TkPDqihP6gxfljGuBwqEudeVedOHPcv+ed+9hlE6wrAc1PRanrQVstJSRNMzzxdfLRh1i1kr66G13Nz4AEpS5jdzArIL/JQ/cyjk5xv+4OFYCcq6vyTaMRVfybnhr0O1A4ilBY0oIiVxiv0jRjXyqs2ZjRxuxAjE3946zD7ufVZ+TgOmk6fiY0BzyLH/uG0u32+bR5xxw9orTq8B6YRF6LbyEGrM/n0agCFtTjOOYFQbB96K33Pt6fCwPPih9qj8aRcs3QpON2++VLsQF2bABJTrzsbWBsq3WiU5VZ+gvR7prO0M4Go76EF2gzpRceOJPLqhWW07ffP2o5HABJQmySsX2TAWGPEQ9esBkC8Gtzfqett0DagJLLePiCxVrlA==;5:c0jjogg4tpvMqDSn0nnM1DDF9lhv2CYG22/xSt5UM00BGRp/ThCW+CvCdshCp4Z2kcITbAwUEKKdGJwi65UFzqaGShxEpYhDVczvZS8LdLEhWkxIAGJefPxEYzbLh601GaZL2j7JoyMWDlaSQNN/TxJFcYeqFCzDJ67DxJMRTbc=;7:4uN+TSGAgk9IajTKrBK5VxNYOVlpvvFQQjjZTKfce7fCH+eCJHXpb+8RE8FNS+94bReQAAtM8/AFeBqnJfJcFQH8YjnQd+4HtYFoJGuFtgdLRZS4Ks7IUUXL1tFn1Q+VKterZNeYSiXog2rlwEfzjw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 58464402-491d-4fba-c706-08d656726cfb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR11MB2906;
x-ms-traffictypediagnostic: DM6PR11MB2906:
x-microsoft-antispam-prvs: <DM6PR11MB290648C4D71A7EBF1B21D68AE7D30@DM6PR11MB2906.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR11MB2906;BCL:0;PCL:0;RULEID:;SRVR:DM6PR11MB2906;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(376002)(396003)(199004)(189003)(54534003)(13464003)(81166006)(105586002)(81156014)(2906002)(7736002)(305945005)(53546011)(76176011)(6506007)(6436002)(5660300001)(74316002)(7416002)(7696005)(86362001)(99286004)(71200400001)(9686003)(39060400002)(55016002)(53936002)(476003)(446003)(4326008)(97736004)(256004)(11346002)(33656002)(486006)(110136005)(8936002)(93886005)(478600001)(6246003)(316002)(14454004)(68736007)(66066001)(54906003)(72206003)(6116002)(229853002)(8676002)(102836004)(106356001)(26005)(186003)(25786009)(71190400001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2906;H:DM6PR11MB3131.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: bO1SFj9nlHrQLiVf1vfhgxlbbsKd4RUWy6CNj6arLpmvVZtoSfYqeEJaXnbHpFBIzpZO9qS7jmVtKkV7unWqOxp+KV5BcBwzPui44AXEjloTS5Lr49KpBSYfjdfYeqPTGCOfN6lGPWVXAzFNGnMv+WYcrDLDlRVrH2OnK6ldcWLzbdSVHSE5PtiRiHGk2/P5npWFUsCf4fdQes5o/GykLkjreruWVNIdJ9Ik169yyDk3WInXmAi4GC/quORwrwjDvp8+rVHkvq2zluYN9tV5Pfbpv/rhyM/pdoXwgh02tXtDaa+13eZ9LQ2krP8b5DwrjCONkZBfXzoP9sBjL0czaNUouZWVKcwdGay2NGeJ9rQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58464402-491d-4fba-c706-08d656726cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 03:17:57.2797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2906
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Mark Brown <broonie@kernel.org>
>Sent: Thursday, November 29, 2018 3:26 AM
>To: Grant Grundler <grundler@chromium.org>
>Cc: Ryan Lee <RyanS.Lee@maximintegrated.com>; Liam Girdwood
><lgirdwood@gmail.com>; perex@perex.cz; tiwai@suse.com; Kuninori
>Morimoto <kuninori.morimoto.gx@renesas.com>; Benson Leung
><bleung@chromium.org>; alsa-devel@alsa-project.org; LKML <linux-
>kernel@vger.kernel.org>; ryan.lee.maxim@gmail.com
>Subject: Re: [PATCH V2] ASoC: max98373: Added max98373_reset for stable
>amp reset
>
>On Wed, Nov 28, 2018 at 05:55:48PM -0800, Grant Grundler wrote:
>> On Wed, Nov 28, 2018 at 9:07 AM Ryan Lee
><RyanS.Lee@maximintegrated.com> wrote:
>
>> > >Not seeing a changelog here like I asked for :(
>
>> > Actually I added changelog as below. Do you mean this is not sufficien=
t?
>
>> The text is probably sufficient but not in a format that Mark can
>> directly apply.
>> Please take a quick look at Documentation/process/submitting-patches.rst=
.
>
>> Mark wants the "commit message" to be before the '---' line. So move
>> the "Changes:" text up to become the commit message and drop the
>> "Changes" line. That should explain why this commit is needed and
>> include the S-o-B line.
>
>Right.  If you compare what's in git and what you're sending with other
>commits and mails and make sure everything looks similar you're probably o=
n
>the right track.
I'm sorry for the mistake. Let me fix it.
