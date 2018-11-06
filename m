Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6273AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CBC2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="DG0istS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CBC2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbeKGJEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:04:50 -0500
Received: from mail-eopbgr710092.outbound.protection.outlook.com ([40.107.71.92]:65184
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730409AbeKGJEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eulyuCQaH6Bk+YvOMoNnwW70Qu2NJiemAlh2SeR3ds=;
 b=DG0istS3hk5RF2aJCw5aAu5SE3Dl39tFItb3jvOcyVOQ97dWJUgKGwZthK5tmCivq9BHxgovJFqrIvRrDpWr3dJsbH7N0My9IF9jTOBXczROUQ/xavq2ihVGf0itnPAfLJ8SDgI8KMbuLRZHtTl7argj1PebRMWiBr9XxjTQLXM=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1023.namprd22.prod.outlook.com (10.174.167.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Tue, 6 Nov 2018 23:37:04 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 23:37:04 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: r2-on-r6-emu: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
Thread-Topic: [PATCH] MIPS: r2-on-r6-emu: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
Thread-Index: AQHUdd4i/Gq/tSya50G2xpTcFC+Fy6VDZ4AA
Date:   Tue, 6 Nov 2018 23:37:03 +0000
Message-ID: <20181106233702.yk6ql3abafjv7cgk@pburton-laptop>
References: <20181106143636.8450-1-tiny.windzz@gmail.com>
In-Reply-To: <20181106143636.8450-1-tiny.windzz@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0038.namprd21.prod.outlook.com
 (2603:10b6:300:129::24) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1023;6:NzTIDREcpg9xCj21arKC7iAGXIJ5+6LLGlMQ7ejGfwLKXi70Fck04sV0n0mlqLOPs7XO7V7GDzEgtQXpmrazQzONjImIMalt/U35bAoV4yG6zDBoVIos9g2JEcnF02R3w3VlMwSBq9gEWW3Z6d5m+npwmak4vZoyHG7zv0vPpee7yQX5MZ/OeNTjpGll0GadSfy1dKIWII8D9GKp+EYsfxvu6X5pAHpyb81iLnIz9yA/1XZLB+2ufo3xmjVWIEMHzNyD6/Z1z1jmAv/XTGRlsb+PrVIWuoE0lN5w/5gDvSi/I//V7uLQaVJTduh5T1LrokBT5PIynYlrX65hn926STJArDJAvTuYjXyP82JmS4k2PBSz4c5WIf3vE5TpSl0xCX5OvbfaUlwo0UY7YZgqjcWU69M+0uKUKeNDgt7Fvj/Dxzx2x7KRHwtDXEXfZL2NXNpdHarqw0MMtJXD1mWpsg==;5:GLpU42n9kT2NroCY3MoWqiHRckOgjSf/TGTrxn48O4TdgpJrYZfNPfIiagUKPyCwi7wqY4+LASkPhqBT5AX4AYi6SQCsQtcM5J5e2BsUQQwNCqzBjTSb6QF6pxeDfSdqvI0WKHqh3GcjRADF0VJ7KYGksmWCWa39YIEjgBuYz68=;7:vrP+fIapgwtzzrLLJs8QrsgGf6Y0h41Ap8q71hGXYKxUI90a5yFeY3tw6pCTrrejR9qPAZcYRmuDE1+3SvWeRjnBZNh3FRgalzY/i5qSNcbTd7n51WYquUv2m1tPCHH9AS4bQ8dfrsn4I/fgMx/oSg==
x-ms-office365-filtering-correlation-id: 8051e04a-c12e-4ee7-42da-08d64440c151
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1023;
x-ms-traffictypediagnostic: MWHPR2201MB1023:
x-microsoft-antispam-prvs: <MWHPR2201MB10235E39433EEF8638308B00C1CB0@MWHPR2201MB1023.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231382)(944501410)(52105095)(10201501046)(93006095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1023;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1023;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(39840400004)(136003)(346002)(376002)(189003)(199004)(2906002)(14454004)(7736002)(8676002)(9686003)(6512007)(305945005)(5660300001)(68736007)(33716001)(81166006)(81156014)(53936002)(229853002)(6916009)(105586002)(2900100001)(1076002)(3846002)(106356001)(6116002)(39060400002)(58126008)(446003)(11346002)(486006)(6436002)(6486002)(6246003)(8936002)(186003)(71200400001)(71190400001)(316002)(476003)(97736004)(42882007)(54906003)(76176011)(26005)(25786009)(33896004)(4326008)(102836004)(6506007)(386003)(508600001)(52116002)(256004)(99286004)(66066001)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1023;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LiUugWg5qsRh9CMhIPHWlWi0lhj6JOa8fR0hWIowmm4nqDRZW00EvXeqimy+24jocnIqh16hR0cmEGNhHkFfIfr4hN591xD0c5Ox0j+6KQepelm8T03GvpGuT0c7EgRt4jbY1fwBP7DdKlBkq5C+JI+LgKaUShUy4SLtylTmdYV0x9W7Fh3mjfRK8X7aB4O107XovAnO5rAU27PsOAc77qLgQnSuYFKIffoP/4e3HbXdlbb7Lepp0lQvR929bCqyu6n1VclaryTTd/q4x8JF0ieNP5bxezUA9wXwI+27wKNqkM4SN707lVUDcGMshzIIs6Faq1Y+i/LH8t1Lzrg5GaOdG1ENaZAhbi1wQSjyJEM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA55B8AE93DAE846B0A116968D6070CE@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8051e04a-c12e-4ee7-42da-08d64440c151
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 23:37:03.8023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

On Tue, Nov 06, 2018 at 09:36:36AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  arch/mips/kernel/mips-r2-to-r6-emul.c | 32 +++++----------------------
>  1 file changed, 5 insertions(+), 27 deletions(-)

Thanks - applied to mips-next for 4.21.

Paul
