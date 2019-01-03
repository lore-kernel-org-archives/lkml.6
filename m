Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13415C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AB221479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lnA1fIZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfACTr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:47:26 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12724 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfACTr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:47:26 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2e66be0000>; Thu, 03 Jan 2019 11:47:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Jan 2019 11:47:24 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 03 Jan 2019 11:47:24 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 3 Jan
 2019 19:47:23 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 3 Jan
 2019 19:47:23 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.58) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 3 Jan 2019 19:47:23 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (20.176.178.161) by
 BN7PR12MB2692.namprd12.prod.outlook.com (20.176.176.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 19:47:22 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e%3]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 19:47:21 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V3] i2c: tegra: Fix Maximum transfer size
Thread-Topic: [PATCH V3] i2c: tegra: Fix Maximum transfer size
Thread-Index: AQHUovSarnR0fwShBEqtBBjOtaidVqWd6McAgAALOdA=
Date:   Thu, 3 Jan 2019 19:47:21 +0000
Message-ID: <BN7PR12MB28368BFA8C7DB877316960EFC28D0@BN7PR12MB2836.namprd12.prod.outlook.com>
References: <1546472423-31366-1-git-send-email-skomatineni@nvidia.com>
 <20190103190552.tspqarvalqxlz7yu@ninjato>
In-Reply-To: <20190103190552.tspqarvalqxlz7yu@ninjato>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2692;6:PifibtHaI6r1ThCNmzuqX+g3rCKhlvRclsKjj6k7NqGOaf7u/n+pLav8tm0evDVvl+MeC5ym7uQlJ6+NfbHmZdAhwFlYEIEV6Kzap877bZcbneR5k6I/sk1IDJD8XwJcTa56Snvvy5amoV88x3Z6Y0rf5aKz+wFc8+hemAJts/Vbjllvp0f4C41YUTdzMtAzAwRNfaSSRRCbDVI/uETJnfYGasf9wTMGKrzCZqwlJK66GTc1zN8hdzmxMVGmqUlSovkfiNosgWV/PFkS10wlPsCNvHaMABPkC3WsiqeGaq/z64QKumCfgWFj0WjAjSAweUmyzU15tQYA/7ud1n2Z/rhQYXvgpzWd/xZl1bPdMDJ4KXy0fBUNJcGIviLXQk3aAkg+mkhhy2o6tl958XcXfNw/RNX+6QBkk/0zd3jUBOZKtzsgRYcCpfsHpO8OybpkrPKShasfkqgzBJA2UsDvpg==;5:9gOzd3c8AOkICg//NMsXTjXkCYkRyPX/j1YLR6tSe3AF26/QDRTyDaJLRLiEledZz+mxaLwHWjICMsJB+SPczjLDRJu4fqN7tIw2Vh2y0oY23EeN6hlCwr2fC36h/HHPtLrNTusNgEaborikwSKFVMH0IVhda5f+hjvHRqNnmNkSTgLQslFS3nM+MCbXpaHi8Xd82KtsXPkhFPmvsUlfTw==;7:Cu6pbHBWQa8KZlVNta+WRu5nVuysWn2Dqsa9ew94KOZA1WYd21geT0eIrsBCfHFibBwbvxjd5QPh4qSe7ec0SxGoOryoMITCBElE9Wfuoo0tfW9M4YrNEx8QuMHWWgRanX1dOOr0/ZiDn+fU/A9EnA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(105586002)(106356001)(305945005)(6246003)(33656002)(7736002)(14454004)(68736007)(8936002)(81166006)(39060400002)(53936002)(9686003)(4326008)(478600001)(2906002)(97736004)(8676002)(81156014)(25786009)(229853002)(99286004)(5660300001)(14444005)(256004)(186003)(102836004)(74316002)(26005)(3846002)(6116002)(6436002)(486006)(7696005)(86362001)(6916009)(55016002)(54906003)(446003)(66066001)(476003)(71190400001)(71200400001)(11346002)(316002)(76176011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2692;H:BN7PR12MB2836.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: ddd5e0ce-8f01-45c7-bfb3-08d671b446d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2692;
x-ms-traffictypediagnostic: BN7PR12MB2692:
x-microsoft-antispam-prvs: <BN7PR12MB269269A3758DCE5DC378B1D4C28D0@BN7PR12MB2692.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN7PR12MB2692;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2692;
x-forefront-prvs: 0906E83A25
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j39s5HsRYZV16udjqpRlw/34G3YypJTfeFm/cozi245P7qkxxXmCRuwhmo3fvYzQylqRAbWCmlUgqQIXNrOr42z4BmLVkwQj1pV6TYLS4Ym1rzjwbU9PjLo3SQLdQWq+dRA3rgzEuHjUzCZ2FGdixCOhnsBHaRlCO4BYR7euNDOgFCO53fCnwIIid5WNq43aNBrvtf5jKTY0JkVApz+XKS50oLdD2+1GsiSEG65DhnK/sJvWU8nFQHmw/K52p/hON/IuD5nJ6bMA0y0tWEqMnDsduEN/iCCGiI0eWXZAOjj4kXoFtCiFxAzw3DrSSQhC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd5e0ce-8f01-45c7-bfb3-08d671b446d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 19:47:21.5139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2692
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546544830; bh=b2de1qvuJeSvqSZ+e/GmTeyo1SqMNOnv5JQBQWKw6Bc=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-exchange-antispam-report-cfa-test:x-forefront-prvs:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=lnA1fIZG7cvVq+w/hdBQ2cEa1n1CIgnMvR0JTNnBHWkW3MciVkPhQtogVBUoanyTH
         cvbPwVn9u/CYAuo1BbzSiiN48SEtAdW8GJNXFeyVrgrxt40j+0zhBEHaCDyls/cbl5
         Rd2kPFRILVgL01EIu7MZASE6BFY1teXewUo1go46Eq3HqRXPLis12hCTzLWDtaWOkz
         Q7QOWqJolnqCoSnWa+1vAU0NI+FPFgr3kpgdFtp7h09M+iTU2KpFgfrII0t2MMY1Q4
         Pmuaon8avMLdrC+KQwZ06AigTQc4zLkGzW7YJF/BCJ8KBY8GM0ywt7XuNlIRYlZlpe
         WUlXdDcrYnyZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Tegra194 supports maximum 64K Bytes transfer per packet.
>> Tegra186 and prior supports maximum 4K Bytes transfer per packet.
>>=20
>> This patch fixes this payload difference between Tegra194 and prior=20
>> tegra chipsets using separate i2c_adapter_quirks.
>>=20
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>
>  CC      drivers/i2c/busses/i2c-tegra.o
>drivers/i2c/busses/i2c-tegra.c:171: warning: Function parameter or member =
'quirks' not described in >'tegra_i2c_hw_feature'
>
Somehow I don't see this warning. Do I need to document somewhere on quirks=
 member of tegra_i2c_hw_feature?
