Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DACCC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF6E20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hKuBxhx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF6E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeLACBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:01:48 -0500
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:31292
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbeLACBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ugwha5pj8bUuoM/c+8C39i9Pvi15ZZJR8q6+1BLEf8Y=;
 b=hKuBxhx/Y82FeFakabWBH3nGcdUAgRvoThpNn0XFg5GU6bAviBvVn1K8JvxW6yrrQrSpfxDalZwLT7xQ/ZBViQldHePn3qhmr+ViGbHB0A28luKHigO0xNnhnosnW98BJQdD5OjClLmg0YuFUx4Tp/+XuqnusIEXvMA8/v8FZT4=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2429.eurprd08.prod.outlook.com (10.175.26.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Fri, 30 Nov 2018 14:52:10 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 14:52:10 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the akpm tree
Thread-Topic: linux-next: build warning after merge of the akpm tree
Thread-Index: AQHUiG830bfhnb2BM0a+P2q17Dn1oKVoZ6uA
Date:   Fri, 30 Nov 2018 14:52:10 +0000
Message-ID: <51cdffd4-8e89-0366-a13d-154b2cbfb69a@arm.com>
References: <20181130164030.3dbeb8b4@canb.auug.org.au>
In-Reply-To: <20181130164030.3dbeb8b4@canb.auug.org.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: CWLP265CA0259.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:25::31) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2429;6:yZbhslSiu2j3eC1FQwozKdooSD4JtSIGm7w1dYuVgfJjTHi/aYhMDVq6oGmwVAwEXrxBGL54SEVIsDZwihNn8mybrOxsmk5wWkMDJDZxPiSrqOv0TPcaT+zg3tHfBgs3xij3RDPvU33KbetPXEf3qymGc0pX/DbtoD2P3/jtkSyt4T0wZnimzd3y6Ln9WKJJUcQJZco6m63oMJTBVp+0wI6ogBc0T8hZtqBCPM7c8z2hC6mfoDhP+427mAg21kqr3/EoKvkrMKAuAuNi9Y3YQMu2EZrG1USpibjopBEodx4DCJM0iBjYFwM7mqYUvU+2s4FPyPBJDha/PK/Gj4fC6jUC5q5Cn7ZLMjN75r8pRACfdYUg90s45IP3TNhFzG8cxvdIpFuPTilRL+0Z8GSooI9l8ZoleM0Mx4gNUQjyOkGGJkDXifUQ3xT40PsSGsXoKTQNXivPA/TIwUCVxw14BQ==;5:1rGY3OCryr1ylPgqD3VUSP9teJg7J0985h2uvGY2zlchIjHZM8GOjLpXCOQwil2j2u5Fq9Wp8yOlrXR8ZjB6Qu/Et5XJ/r0gltvFHP2BMxKPOhY7aa8o4mb0R3gQCdPYk62Nq8tzyP2cbC1jPxwWluVKgNSi26/bnCmc9zdbtD4=;7:wLnuAcpuieggkg/g7ve4JB03uXyyzwmlIkAmYzZpLAgaBK++NyV+HQjb+EM3ShwP23u4nRZQjL60ocb+fHbuttPDrhWs0C9TQiYjxjpcKKEIZMOny5g0HvTY9gUEMvAGntm0KRNBIxjHv9ITGDCDtw==
x-ms-office365-filtering-correlation-id: 9476fb2c-318e-48a5-39b9-08d656d36808
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2429;
x-ms-traffictypediagnostic: VI1PR0802MB2429:
x-microsoft-antispam-prvs: <VI1PR0802MB242951EA482C0678041FB9498FD30@VI1PR0802MB2429.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231453)(999002)(944501466)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2429;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2429;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(40434004)(189003)(199004)(53936002)(36756003)(486006)(6486002)(316002)(7736002)(44832011)(305945005)(5024004)(25786009)(81166006)(110136005)(54906003)(256004)(14444005)(81156014)(102836004)(26005)(476003)(8936002)(8676002)(106356001)(105586002)(53546011)(97736004)(3846002)(5660300001)(6116002)(6506007)(99286004)(52116002)(31686004)(2906002)(186003)(229853002)(11346002)(76176011)(386003)(86362001)(68736007)(966005)(446003)(478600001)(6436002)(4326008)(6306002)(71190400001)(14454004)(6512007)(2616005)(6246003)(71200400001)(31696002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2429;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hFXTeErimBSE6SPFscCYswUvLdQLj59DMKthSGgP3Ry8UpMNO1yYJHp2l7vhG8LiIe3nXRA3X3GnCucGcx+DLvoXcWAze8lftcQKGmSth8J4eBSfzOc9Mf5UxWavOg/XdGUHPbzGnl5GMR1tVQPAZtIXizmaNlxDSXuE0HlD6e7Q3mBnYhiccyrFEA4waqAyjUArjcYEg2nym/OsbskVrAPWChK4bKF1t+zcI6kSC7JLMbaZOVstWlJ1xqMFvLHYO6ElNQgQGX8TJsBCuBphvkPduAONsxx1mlb3pPoiQpLcpkPDv4N39JuqucHk039T2Rr+jkgOV+7FN/2H6OKHiRSeSV/H7qtgS/VgpF0yQR0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4B6D5845808F9340B244166314195929@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9476fb2c-318e-48a5-39b9-08d656d36808
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 14:52:10.5853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2429
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 5:40 am, Stephen Rothwell wrote:
> After merging the akpm tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> lib/lzo/lzo1x_compress.c: In function 'lzo1x_1_do_compress':
> lib/lzo/lzo1x_compress.c:239:14: warning: 'm_pos' may be used uninitializ=
ed in this function [-Wmaybe-uninitialized]
>     m_off =3D ip - m_pos;
>             ~~~^~~~~~~
> Probably introduced by patch
>
>    "lib/lzo: implement run-length encoding"
> or
>    "lib/lzo: separate lzo-rle from lzo"

Apologies, I didn't spot this (I think it's gcc only - clang, which I
was testing with, seems smart enough not to report this false positive).

I've fixed it in the latest patchset (v4):

https://lkml.org/lkml/2018/11/30/972

Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
