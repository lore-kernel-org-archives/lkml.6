Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5815C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AED20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Sgx9pVLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AED20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeILWuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:50:06 -0400
Received: from mail-eopbgr680124.outbound.protection.outlook.com ([40.107.68.124]:13152
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727332AbeILWuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNCp9G/X+6TsKItYzxc5maw34S+b6O4QJxJT+FqJBYY=;
 b=Sgx9pVLBeRXFh9hDHdtYft80+XpH1kWtFeJv/ceCPwIz1lElvTWRTtslDM3IXVlrAvgsCJdg16V4hlpni/Z9lYE8oI/I+ePTy3GJL7JInX5iMdwiDzqjFw6WFlASUU3aMcKBHf/5HFuxq3YwGrxbHXzR3EYejgLLpvVs94MBmkk=
Received: from DM5PR21MB0778.namprd21.prod.outlook.com (10.173.172.148) by
 DM5PR21MB0827.namprd21.prod.outlook.com (10.173.172.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Wed, 12 Sep 2018 17:44:28 +0000
Received: from DM5PR21MB0778.namprd21.prod.outlook.com
 ([fe80::d05f:7c53:cb46:9ecd]) by DM5PR21MB0778.namprd21.prod.outlook.com
 ([fe80::d05f:7c53:cb46:9ecd%9]) with mapi id 15.20.1143.010; Wed, 12 Sep 2018
 17:44:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.14 27/67] ARM: exynos: Define EINT_WAKEUP_MASK
 registers for S5Pv210 and Exynos5433
Thread-Topic: [PATCH AUTOSEL 4.14 27/67] ARM: exynos: Define EINT_WAKEUP_MASK
 registers for S5Pv210 and Exynos5433
Thread-Index: AQHURkL6d2X1HVqgFkCEjeg9MUI49qTkXNIAgAiXKIA=
Date:   Wed, 12 Sep 2018 17:44:28 +0000
Message-ID: <20180912174427.GF3821@sasha-vm>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
 <20180907003716.57737-27-alexander.levin@microsoft.com>
 <CAJKOXPdjrVxb4-G2d52KU_MKFPnV5SjmAwr3fW6v8iA1Z32WSQ@mail.gmail.com>
In-Reply-To: <CAJKOXPdjrVxb4-G2d52KU_MKFPnV5SjmAwr3fW6v8iA1Z32WSQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0827;6:1Gv9tfiGlk45kb2G8PEV/ev51lUu1kxY5BRv/OzGdRDPiXOtrarqZ2wv2lt7dKtBMJyHwyjAbZOn5SRTlYdcMrlL2tswzK62UJSUwvB8wWCh95jOohB+mTQKkkLEvFVUKUcBn1y+nX+OLKKOZZlXayWAkCR8UIQAnkWm0BXK0XG2hs1MS3TG2YPvVSuvuRo2s6X4/JScHI3uktwjQ/AS+QsEfJzucO/y0yPpcSpmlwYkzartJ+RN8+8vBbGrWKF4Fxu6mMXxVk8DF40Tj+xY4MfgNnGuXFLlNrWsqTdNv3Cta+c6nr6Spd0u8nAWEDE+1ydEcYz6F6x2F8XhIbK/WPFvPYxjApttbYZ3JlhNTtK5GG4ygQiZcbcwwqURC929WW3CzlISnzb4iQp8nwtR2GqsRPrWrtCrZ0cvi+fDFDdzowS5ftHqBkut4ad0Yc/hjRxfHG9kFO37m46YtpTcsw==;5:9cI6MUnxakyhwq6aYsc/7Ij7Dk/LvbA0yODzgajD8bPV1ovmAgvTQ/3yuJ6/ZqwS8IRU5qoXNMRnrvVhCtI0k+ctnt1gwiAqI3X6B0++NccOLAFLtoj+N4NqksgiBUZ4eK7OObLLU6fYZoMXvk3uX5HNJEkbnF6y6YbAiQ4nnUk=;7:nB9sAp4TDF7L3uCAavANgv9NCSdF+/wDRa088D5TtuEls71UTFqYayF+LI5AhelNyJl5+8rco5UppznJREkStEeNURPS0jOyBlNiwcOCoRYFNH2aUdN4hqKRKNXzK5PMNbHX4mSMF6HOU97J0xULX9C2w8EA+gasuvOhFafqznVDVqy6U03gC6y6vGGWHWEC1tTgy9jOMVJfIxjkoNm/9HFYF87xjCB7zaLmoo3T5CcjaE+a3El0bTJF6KiuIvBT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 43bf79c1-d10d-49fe-72d6-08d618d76353
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0827;
x-ms-traffictypediagnostic: DM5PR21MB0827:
x-microsoft-antispam-prvs: <DM5PR21MB0827E543BF806D4D3B032E4CFB1B0@DM5PR21MB0827.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:DM5PR21MB0827;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0827;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(5660300001)(6116002)(3846002)(33716001)(102836004)(6506007)(26005)(6346003)(8936002)(72206003)(486006)(81166006)(81156014)(6916009)(22452003)(217873002)(33656002)(446003)(1076002)(256004)(76176011)(33896004)(186003)(54906003)(316002)(99286004)(105586002)(476003)(106356001)(11346002)(7736002)(9686003)(6512007)(25786009)(2900100001)(86612001)(86362001)(68736007)(4326008)(39060400002)(53936002)(8676002)(305945005)(6436002)(2906002)(6246003)(229853002)(66066001)(10090500001)(10290500003)(478600001)(6486002)(14454004)(5250100002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0827;H:DM5PR21MB0778.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: LgZ8silF1tvnd/Z02LfYL9+UVDplntwcheIBDOwRz4BngrMBx8cV2X7sYJluMALJSMjlYHdeCfybbP2avYciI3orGgdx3mw6apfJ2iN9X2bmdhpzYfyEbufkuuDylPTLm3fbjTDmfQ/kcxbgKTQOHYAZFVJUUy4VZUEdCFAomiZ6JS8CFSjVZb3GqaMwN4xSDOjIfKNNEkNuJ1VT/6ZKl6JehFQ5D3YIHLlGlNFU9JaUsUbqTMu+KljaLuBuerw87BiKCj7okzQtjGae7gY2D0AAyNA6MlGEjW0unE3yKpRf0kZMKsdLjjJyBFpzhlBkyo4m4eX2UuAi6vmA8+4zzhYk8FBKvn6ejDLORGxX5QI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3254D92F45F2F4F926BFC0650FE39B2@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bf79c1-d10d-49fe-72d6-08d618d76353
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 17:44:28.1871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0827
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 08:33:22AM +0200, Krzysztof Kozlowski wrote:
>On Fri, 7 Sep 2018 at 02:54, Sasha Levin <Alexander.Levin@microsoft.com> w=
rote:
>>
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> [ Upstream commit e5cda42c16d89720c29678f51d95a119490ef7d8 ]
>>
>> S5Pv210 and Exynos5433/Exynos7 have different address of
>> EINT_WAKEUP_MASK register.  Rename existing S5P_EINT_WAKEUP_MASK to
>> avoid confusion and add new ones.
>
>This should not be backported to stable. It does not fix anything but
>prepares the code for a8be2af0218c ("pinctrl: samsung: Write external
>wakeup interrupt mask").

Now dropped, thanks!=
