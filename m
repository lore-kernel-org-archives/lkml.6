Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1369C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BAE2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JVKPPWzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BAE2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeKCCdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:33:03 -0400
Received: from mail-he1eur01on0084.outbound.protection.outlook.com ([104.47.0.84]:23538
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727518AbeKCCdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EuLcW8utDSKm+7Sqfv0+0H6xccJNnF0CMw0cR7/kTI=;
 b=JVKPPWzvl64+P9da5bXnnxFgnn2IeSSC5f9y0EzYk/8zKyFmT3zgEj8YYV5jlXM7hP6nX7gjRRcxpwp8pnayXGlvHScBMg9uJpFXJeFUGVJ3bTMfrPraXAq+YrPNwpZqhgK+2Lr0g+Dlz+QTiS7NJHMr2FyN51j8ea7PUmOrYp4=
Received: from DB7PR08MB3209.eurprd08.prod.outlook.com (52.134.110.159) by
 DB7PR08MB3481.eurprd08.prod.outlook.com (20.176.238.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Fri, 2 Nov 2018 17:25:05 +0000
Received: from DB7PR08MB3209.eurprd08.prod.outlook.com
 ([fe80::c579:4802:58c4:2247]) by DB7PR08MB3209.eurprd08.prod.outlook.com
 ([fe80::c579:4802:58c4:2247%2]) with mapi id 15.20.1273.030; Fri, 2 Nov 2018
 17:25:05 +0000
From:   Catalin Marinas <Catalin.Marinas@arm.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
CC:     Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: kdump: fix small typo
Thread-Topic: [PATCH v2] arm64: kdump: fix small typo
Thread-Index: AQHUcqi2Pjy1aw01b0aSadjkOKh5uaU8vKMA
Date:   Fri, 2 Nov 2018 17:25:05 +0000
Message-ID: <20181102172458.GE218059@arrakis.emea.arm.com>
References: <20181102123619.24199-1-tiny.windzz@gmail.com>
In-Reply-To: <20181102123619.24199-1-tiny.windzz@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::13) To DB7PR08MB3209.eurprd08.prod.outlook.com
 (2603:10a6:5:1e::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Catalin.Marinas@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR08MB3481;6:9vRzEHlcBEEZ+ju77nD4YDdDa0znu7/PadBOyVVUeM2I9/8GEe8M/BygBJWqHTE5Ff9v5dYlR6KhzUF7T67WLFuwzxzJ8uBFJbOTvbJ8Go2wpAUFdzS1vzwfKt8NZYmk6J2DSIvx1/HufXDSMd7aBoGuLa0BbCSdNFontDDW8FUvmZ31Lxc2uP8Lwv/9ctdYTLGi2XwoA4pNsnUulLsFztbgIJ06LTgP9RyC3SWAmwQHwMz0GolNOza0i4HsurLGsVdycsv6Uo05MvWAZ6Zf6trbNfDrbVhVrMzp32AgahHJa9JE9Nmf1TdaJem7YnaitMAHpb/2aU5ulm1G8LZ4paIyDaEn6fTwHlM14w4o1PKpYrIDl+MzjTm6nEL/4qEpsI/dSQloQJeqHuvnhVNB9efWdm926mhlpBjyeI1fZgquoCbXplQiqwcqQ7QB4jstjBtJYgpIjmHdSMPwFJdQng==;5:SNILAu1iIYN1XTgzzj0jIvbcxY/XlkRvf69QwziXRR7+aZbBwHR8xJwY2zOQoJUA9cx0RzmowdZqvbvFS0OKQPp38kaHQzBWBxY8p+wV0PYTO+izMbgO7ZXAeEo/ooq48oaKd97grzBoDxCCTiRktihbkRVDih6Lsu1ElPr+WrA=;7:GTH71zYP5T0BZRoWDZQRh9Z8FBtx1Li7WhrzREcOX0grHKIYoJPScY3XLjG46EP4kEEYwvcqvcWNvIB1getMXhIbXya4rmbZGhxrw/8pds0iK4GwhTJx+HYBmiVA3zWhxIUA9k0OQ2XfCfnHPvqYmA==
x-ms-office365-filtering-correlation-id: 9f996bd2-d164-4ad0-948a-08d640e820ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3481;
x-ms-traffictypediagnostic: DB7PR08MB3481:
x-microsoft-antispam-prvs: <DB7PR08MB3481C2B66F311C0717B3969AF2CF0@DB7PR08MB3481.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR08MB3481;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3481;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(40434004)(189003)(8676002)(81166006)(256004)(476003)(81156014)(5024004)(446003)(186003)(6246003)(14444005)(2900100001)(14454004)(2906002)(26005)(6916009)(5660300001)(54906003)(71200400001)(7736002)(68736007)(11346002)(66066001)(44832011)(486006)(6506007)(8936002)(305945005)(71190400001)(386003)(97736004)(87496004)(25786009)(99286004)(3846002)(76176011)(52116002)(58126008)(86362001)(53936002)(6116002)(6436002)(4326008)(39060400002)(6512007)(229853002)(102836004)(72206003)(105586002)(1076002)(478600001)(6486002)(33656002)(316002)(106356001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3481;H:DB7PR08MB3209.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2G8H+cnrWkHgLp2soG4GNTISOBXYDfw67gvZX0AFeytYdBotM920cFo5rrxk+RDCr9TSg3cy34DYGUTZ4AHufiW2vzi2pRojGr2SaMz2yWLLei0Mldo2Fowlu2g2pIS/O3Qky9Fhu21XhjM5KE/q7seOoXQ/KJDwFwiYTFxVoWsJhk8V9mxoYoLK/Vrqcn2uev5NNTW32JLehqFfChm1TDIZDxNDoXJO/bsvDtCtbyzh+Lc1rzJMOKLft4Y+Xgk+NpLT5qTSnMJToivBiDZ8rQDAwJ24mkcUumY5DYIsXJcJDC0msLWZywdbwr40GopyJLoIUveJveahwnB9uhelsIFJEyWzDE5F2U7rcXm8ZO0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A642999D18E17E4C84CFF78354145DD0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f996bd2-d164-4ad0-948a-08d640e820ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 17:25:05.3283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3481
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 08:36:19AM -0400, Yangtao Li wrote:
> This brings the kernel doc in line with the function signature.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Queued for 4.20. Thanks.

--
Catalin
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
