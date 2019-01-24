Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201D4C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2479218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Rx67i/9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfAXQwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:52:51 -0500
Received: from mail-eopbgr140051.outbound.protection.outlook.com ([40.107.14.51]:29699
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727573AbfAXQws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbnMcax1LwJQ+UlZwuMoOQPARUbL79qXGyHtTlZIrGI=;
 b=Rx67i/9fyyBQnCyHsHxtaqp39//aBiIRtogRhnACbzK7lI2+2kjT4NAzY60jDNMd+DQ1mxAWWGl633i7jVLPkYrBknpOkFzen1+2/PcqJN/3qZirF7/GTrWxgm76M8XJ4RF5l5KNnxi2IaT3LrIVgKbrnQkhPvxjgxTSQkPmFmc=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB3892.eurprd08.prod.outlook.com (20.178.82.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Thu, 24 Jan 2019 16:52:44 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::6cf2:41c2:1a33:9b18%3]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 16:52:44 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "Andrew F. Davis" <afd@ti.com>
CC:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] staging: android: ion: Allocate from heap ID directly
 without mask
Thread-Topic: [PATCH] staging: android: ion: Allocate from heap ID directly
 without mask
Thread-Index: AQHUs/jb1VUEijWfO0aD6pb/ArbX3KW+lywAgAALVIA=
Date:   Thu, 24 Jan 2019 16:52:44 +0000
Message-ID: <20190124165243.lvjeriknze7jie6d@DESKTOP-E1NTVVP.localdomain>
References: <20190123192835.21827-1-afd@ti.com>
 <20190124152410.qjllxymor5mfzgf7@DESKTOP-E1NTVVP.localdomain>
 <3af0ec35-125a-5f59-1245-20cec0fda828@ti.com>
In-Reply-To: <3af0ec35-125a-5f59-1245-20cec0fda828@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.55]
x-clientproxiedby: CWLP265CA0318.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:57::18) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3892;6:wnnRPkPTOD/OIIK0YUHUoJrP4tu93CHxpvc0rBdQ5Xh+YmUlBjhftdr0shPoObeQavaVhcgFANkceEz/8B0kVFPWltM8IWIGPIaBTn5P7KTbuF98BDzeuZUCTFnyCFeLB9zVnUTnvdjV+b7FN9LUPrxP5PkvVaTWZfVjBu8+kSFnNiIYSat9Zby7Zqvq9cUejJRnYA/QXbJMgBfokL3jWInw7iximbzNjhlWj9ghKDZfUOBRzy/2fuO2+161A/CMdVeUd0eoMrRrJCV525M37xQm/NAhSyIKfQmhUymDSzgzquqBN+OkxhX4qsyIai5g8hUU8GckDCT+j4BgZHO/bwwrH+82UeJrl5FQxfomjsBXPOumUGCrGL0RrIGkgH8q/HOofPfI7QaJTu8f9Oxb6Z9Ni8Y1FkpZkO/NrEA2JNr1E1r5QGJ37WJh4qqfSHqt25wABpWNYiHGh0uYhxL1/A==;5:dpsXp9ZeP+awIB2C1PgNxk+CZ6KwFIRHaxUgDhlsWntPbR2sof8R7hnPM5HgaP6iETQMJdiOw6pCINj9MZQxpS0p0lljkXnxY4JjRHYhZ/Yt95UM/+GbFBwsY6RVENoaV7HNRbOv07SHT0j0IQ9qsGn1K4ZDH3sFJ7++3BY9cj8edRpOpQKaACq4W7PgpAl1XGLScC/eI83TJIsPqKTD4g==;7:nIxWTvB8tunuRu6tT4Z5+EcgxeQ7YAaXnkRZO9mKN2vSveQcmOOPe1mAPVs7NpzmtGZCa/XdABjhcBdNiRw9R5wD2djU7WccNxB2Gqr6kpjVSVlIxoFE39Z9GmlctKUaojtxWemFYgndesCye6hpOg==
x-ms-office365-filtering-correlation-id: ceae840f-e96c-489f-2fed-08d6821c5c60
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3892;
x-ms-traffictypediagnostic: AM0PR08MB3892:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3892A22792FA62F0ED3FDF36F09A0@AM0PR08MB3892.eurprd08.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(76094002)(186003)(53546011)(26005)(6506007)(66066001)(446003)(54906003)(97736004)(6436002)(58126008)(6916009)(102836004)(33896004)(76176011)(105586002)(386003)(476003)(4744005)(7416002)(11346002)(316002)(9686003)(2906002)(6486002)(53936002)(305945005)(7736002)(6512007)(3846002)(229853002)(6116002)(86362001)(4326008)(44832011)(25786009)(14454004)(486006)(52116002)(81166006)(99286004)(478600001)(8676002)(81156014)(8936002)(256004)(106356001)(1076003)(71200400001)(71190400001)(6246003)(68736007)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3892;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GMPRuKGY1bbqL5pWqMNx4+Gigm+AbbXDDRN0XECHdLNptPo1qqJaZnvJtI3KVTlywVpNje+Ae8ulFtruHmrfGp652DuXeMrN1ZLFKXZXlsItHIwDt0G5t7BowOqhbSLuBwVHxkUZTJGIdQ8P95m1PY1G5ymmY3gsQF8JSeoO4KYn0Y8BYfNLCUv5U2YluensC7RhdQD2j9NFTARGvlOtTRPPz0kJra9Uh0448Q/kfBE+qOqEpZ4+EvgWej/x0iil3ERnLjRVmytEsIIkwm1kujncou0WpYQIvVx/b1vBeqobkhcg6jhnAyDmQHPvQ86zWDgtXMTkDpnsYjwUwEnwvHLY/H6bX0AOr5aRnIj5xbeaxVudhHXReRVp6Pra54wnAopFOaL10ncccsBDNav3FuDTjunwiVBqZBOPeK2ffMg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B397B781CB8B6F40A9652560ECBEC331@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceae840f-e96c-489f-2fed-08d6821c5c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 16:52:43.7244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3892
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 10:12:10AM -0600, Andrew F. Davis wrote:
> On 1/24/19 9:24 AM, Brian Starkey wrote:

[snip]

> >=20
> > What do you think about renaming ion_allocation_data.unused to heap_id
> > and adding a flag instead? It's adding cruft to a staging API, but it
> > might soften the transition. The "old way" could get completely
> > removed just before destaging. Just a thought.
> >=20
>=20
> Sounds confusing, backwards compatibility in staging just doesn't seem
> like the right thing to do.
>=20

Well, fair enough. It's going to cause a bit of pain - libion could
probably isolate most Android users. Laura patched that in AOSP last
time around, but I don't know how that went (or how strongly Google
feel about kernel ABI changes).

Thanks,
-Brian
