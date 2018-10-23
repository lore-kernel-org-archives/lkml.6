Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CAEC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2672075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dS6Yt/D8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2672075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeJWRBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:01:47 -0400
Received: from mail-he1eur01on0083.outbound.protection.outlook.com ([104.47.0.83]:27680
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727843AbeJWRBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kX/oD6qd7qWZYmiw1pFDiP76JOrNWGGQaoTvLKpUxiw=;
 b=dS6Yt/D86gYKeb5+mt3SgwEwBFPapgA3f3m3tP0LSUYwVDDwT71h70JAMdLOYhgcjZOfRTF/Cegq4KVJjZYp+HFmyEA8ldJN+R52cYKuur4Q71kLjV4qNiGLbfm8yEQaUkZr7plOvw5PsFZmJyPF2eBILAWl8olNhy42/tIfcwQ=
Received: from AM4PR08MB2788.eurprd08.prod.outlook.com (10.171.191.18) by
 AM4PR08MB2690.eurprd08.prod.outlook.com (10.171.190.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Tue, 23 Oct 2018 08:39:19 +0000
Received: from AM4PR08MB2788.eurprd08.prod.outlook.com
 ([fe80::11fa:6313:23e1:c943]) by AM4PR08MB2788.eurprd08.prod.outlook.com
 ([fe80::11fa:6313:23e1:c943%2]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 08:39:19 +0000
From:   Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>
To:     Will Deacon <Will.Deacon@arm.com>,
        Kristina Martsenko <Kristina.Martsenko@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Christoffer Dall <Christoffer.Dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH 00/17] ARMv8.3 pointer authentication support
Thread-Topic: [PATCH 00/17] ARMv8.3 pointer authentication support
Thread-Index: AQHUXIhWBVNZY6Tx102sb5GXVKYZW6Uml7yAgAYG+IA=
Date:   Tue, 23 Oct 2018 08:39:19 +0000
Message-ID: <8478fc27-6e74-4fa6-7956-ffc1cca6c063@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181019123646.GG14246@arm.com>
In-Reply-To: <20181019123646.GG14246@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
x-originating-ip: [217.140.106.50]
x-clientproxiedby: CWXP265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::14) To AM4PR08MB2788.eurprd08.prod.outlook.com
 (2603:10a6:205:d::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ramana.Radhakrishnan@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR08MB2690;6:vxofxxUA+knG6u2CjyojIOcqe0KbKvLClAcrssNk5jU9j8P/EwY68m9CP+yNRUSRhvaHRJS0naTiJsjwDiovbDweNLsAVz5g90XCxvfr8vm49YoZLlwXRQS96QQc+rVjlViI4K/rOfevoD2X5Qywj3RLE2LCceNjGNrKRub1QLVbTIG9tbiCn1AVm6HIMCPBWy2uVQowgV5G48otT5VIeMhZrYAFB7iWW5b4TGTkwhoTYn0LNh1BBGmEfiOoU9mpM+M5rMDAeKTifslfoKslLx4+fV01fw7mzwLgMF4PqODTaFyzLPiuaz2sSZKfnWGQaj+OwRGeUFwTB8lRAiR3j8mi56B87mYUwl7TzpkamiRIKmsUyV8k8Oa4q8pQ+AhnQbIpg+icuv51+8aE1YDKYY4b5UswdnMkqgeLaV4kZbKCUkxp4EFgdCD/5qDob/maHAT5q8sfhb3XRQAiybW6Vw==;5:DYLhOdVxs5EkzdajI8VtRr4J5UlhaPrtVUNnzpTrDukMLqQ/n/gSjo/qmX9F/LSJoMHPsGMeIoSBt9skGHL7tGIHxEhKtpuhXcpFMrfAqzk4N/tGLeCD5yt3dVbgtjwhMFp94NHHsza9X2XzeSj1j6ybdL/k9u3Ti0DfHOFLrW8=;7:/8ZDTp4WnFl6bllfa42NMXXoPMLyx5cDk/nM3dtdXizUDfkp8440VNG1/feFGY3hUOUtZFXrwmVNp5vftDNwqZ9Ds+QH1rPoUK6X/AG/PiDTM0Kef6Ge0IAy85Zu1HlCrzwRKpU9FfJTByAvEZIGP3+6IMIXm2OdHiQnyW5KMT0NpOP3JrTo1omUp+8szzwvygBhjJJO/HKIkwVf5/Lfr5/J8BUp+UrtFHx9MkBLCaMDcFM7C+8LM3y5ndNEJkK+
x-ms-office365-filtering-correlation-id: f2d1a9ba-f867-4687-4ac5-08d638c305f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM4PR08MB2690;
x-ms-traffictypediagnostic: AM4PR08MB2690:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM4PR08MB269068D73D7FA02590D8882C81F50@AM4PR08MB2690.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM4PR08MB2690;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB2690;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(44832011)(26005)(5660300001)(85306007)(4326008)(99286004)(6246003)(53936002)(6512007)(476003)(65826007)(2900100001)(52116002)(5250100002)(446003)(11346002)(64126003)(86362001)(25786009)(186003)(6116002)(3846002)(305945005)(31696002)(97736004)(229853002)(486006)(316002)(6436002)(36756003)(2616005)(14444005)(102836004)(14454004)(53546011)(6636002)(8936002)(106356001)(6506007)(105586002)(6486002)(71190400001)(71200400001)(66066001)(65806001)(386003)(110136005)(76176011)(65956001)(31686004)(2906002)(72206003)(256004)(7736002)(81166006)(81156014)(54906003)(478600001)(8676002)(58126008)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR08MB2690;H:AM4PR08MB2788.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TLrrwhedUKy8V8h2ptliWGTXrngEBAQSUgu8PqNycR0SmiGcu7/O3L1fIRsAV3vndELic3CkfTcOAVj51j+O/QxkMyLYazv1Yqr4YVkxKh7dt3EsKfElcRPo7fo1s1MFJi3rUexHDXcvPgrGow+ugK0sEg5njVEhG1sMnCVPJa0TuWLe2tiUhkJ+N2VVA7vNXQqjariq4UbhqlkHyHOzo7o6HtPEVi+H34XwmIx1GYQUh3daXXGPhjM8jUvCZRtoxEVCykmA5yleUC9Lq11g4h/IA5/3Mxj2GWc2yhcCCUSmxNXJKEjoV4XYBHg9cITs2gdUCrhhaMGy/HqiJQwV8Fgkb+gYpGYMiWwlKT9yI8M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E4BEBC7F548CBB4BB7EB7193E0C88AD2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d1a9ba-f867-4687-4ac5-08d638c305f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 08:39:19.3502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2018 13:36, Will Deacon wrote:
> On Fri, Oct 05, 2018 at 09:47:37AM +0100, Kristina Martsenko wrote:
>> 1) Key support
>>
>> This series enables the use of instructions using APIAKey, which is
>> initialised and maintained per-process (shared by all threads). GCC
>> currently only makes use of APIAKey.
>>
>> This series does not add support for APIBKey, APDAKey, APDBKey, nor
>> APGAKey. HINT-space instructions using these keys will currently execute
>> as NOPs. Support for these keys can be added as users appear.
>>
>> Note that while we expose the cpuid register (ID_AA64ISAR1_EL1) to
>> userspace, it only contains one feature for address authentication
>> (API/APA), so it cannot be used by userspace to tell which keys the
>> kernel supports. For this the kernel exposes HWCAP bits, one per key
>> (currently only APIAKey), which must be checked instead.
>=20
> Given that the architecture doesn't provide an identification mechanism
> for the case where only one of the keys is available, I would much prefer
> that we expose both of the keys to userspace. Is the only downside of
> that a possible exception entry overhead if the kernel wants to use point=
er
> authentication as well?
>=20
> Having an initial implementation where the B key operations act as NOPs
> isn't ideal if we want to support future users -- chances are they'll
> be put off because deployed kernels don't give them whatever security
> guarantees they require. It's a bit of a chicken-and-egg problem, so
> unless we have good reasons to keep the B key hidden, I think we should
> be exposing it from the start.

There are patches in flight to get B key signing support in for GCC 9  -=20
so exposing this to user space will be good.

Ramana

>=20
> Will
>=20

