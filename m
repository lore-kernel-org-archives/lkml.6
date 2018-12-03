Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDDEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5050A206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="NCJHChgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5050A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLCVqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:46:31 -0500
Received: from mail-eopbgr810135.outbound.protection.outlook.com ([40.107.81.135]:5052
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbeLCVqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWHCiUB8NBdrpEb9Pbi9gyQ3aG9MloagXKRSpEuNhnA=;
 b=NCJHChgw+MfVsI0PB7u02IuE5fVdtPu9UDqZTjHz+sGYYqw00PSYTKi3RwAikvzrQy/jeG4QAePKMqZCejlnZHsXitqHBQPGbFeeWwuZOZFhPaMbUNvggCb4v9Wb4663/IRuWq3DWGsMr2ghl0F0Q7h8v9HRxSg2HQjOwR/n97M=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1408.namprd22.prod.outlook.com (10.172.63.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 21:46:28 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 21:46:28 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Mathieu Malaterre <malat@debian.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        Mathieu Malaterre <malat@debian.org>,
        Kees Cook <keescook@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] mips: annotate implicit fall throughs
Thread-Topic: [PATCH] mips: annotate implicit fall throughs
Thread-Index: AQHUi05/NisOW8CS0EGBC4Sd8mzpCaVtjKoA
Date:   Mon, 3 Dec 2018 21:46:27 +0000
Message-ID: <MWHPR2201MB12770EA2E8A372B21210DA83C1AE0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181203212344.9372-1-malat@debian.org>
In-Reply-To: <20181203212344.9372-1-malat@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:104:1::16) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1408;6:LNXj1XjOiMXTu5wwNTlyVFiH74bGHKQJdiEoF8oRWknCRHePfp10TTW4pr1amIIVfDpS3pXuOLb4e3QVJS57aD6rYjN15ueSQKVaQ47FjNrfzbLNe2LpkXRfMZHD1c6fYEsISejL/49lHRXhyZ525vjlTTINVQgM9SDKKrbP/s/FhX/FHDzWXn+Bhwx+gS88M4e/S1OSmEDRAKdyim5yKm73Lsalradig12/IOr1omvDd0zuzAKhbhDZApUT9JWVAXf/5O/Dy7fZzIW092+R0aozzIpxaA4iuL704sfEle2od5cXWVdIzGfOUpQPDMgqTyCigeDrVfS2+3RbJH0va4X5Qycev4xDuQCRQMUH3CPWSDQiuWq8qX/2waBxagUyK40HiRp2KF5TrC2/k02s9sLugvQpUrA32W2ZWL/khV8w5BJLss2y7scJzZpoNN9NV3k1MTUKMDQaflYS9QsTvw==;5:tJT1s8LT86DDwBQ5Nf7POG5tRirZoHhUwBbeGzVyuNqXXGt1qaGWlfhYzMuzbcAcLaxsu5AV7tZoFA+PYaO+boG3BJDmxIi3nFsOg04UP+P1lPmcKbTPONfNLfOAbcPN32ZIIGJxx5LXyjJu6loSJsye8RV8GmCHe4+hAL3BA20=;7:cKmnPnWmNdQ8iXYBNJoisKsuwsauTDx2+fgwQ1f+NZBOPSRYm95RB9hz8fcxhTy5kvoA+UC+TJ0I6giThd2ViiwwAprgBooKAvib4qqmnOwn4QFKcOa+8N3nCcDihKk3ufmO460e9Zer3KMCvNFL5g==
x-ms-office365-filtering-correlation-id: 77a13cdc-d31a-4d99-dcf7-08d65968c76c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1408;
x-ms-traffictypediagnostic: MWHPR2201MB1408:
x-microsoft-antispam-prvs: <MWHPR2201MB1408011C08CC1EFD0E8E18D8C1AE0@MWHPR2201MB1408.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1408;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1408;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39840400004)(366004)(199004)(189003)(5660300001)(102836004)(386003)(4326008)(6436002)(97736004)(8936002)(8676002)(81156014)(106356001)(81166006)(6916009)(229853002)(105586002)(33656002)(68736007)(446003)(508600001)(25786009)(316002)(14454004)(54906003)(71190400001)(9686003)(74316002)(71200400001)(44832011)(52116002)(99286004)(7696005)(76176011)(305945005)(6116002)(3846002)(53936002)(476003)(55016002)(66066001)(26005)(11346002)(6246003)(7736002)(186003)(42882007)(486006)(256004)(6506007)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1408;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z8dY0m7GzHxah6YatU+heZxpHR5CzJfCI06JbyFrq9nkpDhnKWqsrpXPvfB5Q57uyrfX71VsiWe+a2a1vmeYSk169Ir8XIgUfAymnjCAk9XV0CCdwTq6mmVvR5vKBueabDWcKaIxLvhG7VJa5mj/9GqZs4lbuvBZWex05T8pjbup8/80aQUHfUaCUuf55KdYr0yCSdGB8uMj2vZFDHp8+qGqHxybj/XvfUHn7CGOp1zpJ6I2v+x3inQsaPRtM1mQcIcBeZl8pLKK+UYby7CkDyuZJqoLCpamxoHwHzM2neunFsU/L9eE9QKgi2XLY2Mj9nXgGFIgpwGzvJew0UmKSak5/d3D4yYEKDtNVTsT4UQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a13cdc-d31a-4d99-dcf7-08d65968c76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 21:46:28.0057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1408
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings. Fix them up.
>=20
> This patch produces no change in behaviour, but should be reviewed in
> case these are actually bugs not intentional fallthoughs.
>=20
> Cc: Kees Cook <keescook@google.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
