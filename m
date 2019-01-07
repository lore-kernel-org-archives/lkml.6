Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB226C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A1F20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1nwx9d0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfAGKhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:37:24 -0500
Received: from mail-eopbgr820042.outbound.protection.outlook.com ([40.107.82.42]:13506
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbfAGKhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH0Tdokhwm/KbktjW8qstINkDQfYF/3F7y747l1Nhlw=;
 b=1nwx9d0r4Z3hKqkapZPLAJEQmVy4b8ypt9WhBQHovnkxVe5R7GLLmIYTaM5BrhbmsA09SFdnnnEi8cDdqKDMWFWSr5Y/3jI7ZbT+E49jR9LzCCMZVhbwg7wAjtLISE6XK5FBvYPat8hc8mNtabVyT5TiMLM6e7Ar8NMPF3GQUDA=
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) by
 MN2PR12MB3391.namprd12.prod.outlook.com (20.178.242.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Mon, 7 Jan 2019 10:37:07 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c0b8:71fb:e1f0:d13a]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c0b8:71fb:e1f0:d13a%3]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 10:37:07 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>,
        "S, Shirish" <Shirish.S@amd.com>
Subject: [PATCH 0/2] x86/mce/amd: apply missing quirks for family 15 models
Thread-Topic: [PATCH 0/2] x86/mce/amd: apply missing quirks for family 15
 models
Thread-Index: AQHUpnTwU/LtRrDUoUWagrKeCoPsLw==
Date:   Mon, 7 Jan 2019 10:37:07 +0000
Message-ID: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::14) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:103::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3391;20:2YHz4Av4Fe0kFE56gELopzFumdgbjxnavUUoiRc/z7N//mLKW2QMO+Kkstcrylwq000ZXycMyh0HrsrnajAUeJDZXpt58qTxcKhsigHjc0lIhFepgt4EKi3HTSWCum8IqmdVlVa2Ur3/mxFtPE/a/ACf/zd3bu2CqT0JRzl3GFzqmAD6H2DurKawbqw74ORna3IptXlieAOxYn8bAqRnH74SMc1/0z8qZFjF8mOxN9V1RiV/TACr7Wa76ypSx1z3
x-ms-office365-filtering-correlation-id: 1f8a502a-77dd-44cc-fa51-08d6748c1267
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3391;
x-ms-traffictypediagnostic: MN2PR12MB3391:
x-microsoft-antispam-prvs: <MN2PR12MB3391119C3AB7F629A77EDE84F2890@MN2PR12MB3391.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MN2PR12MB3391;BCL:0;PCL:0;RULEID:;SRVR:MN2PR12MB3391;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(396003)(136003)(189003)(199004)(2906002)(81156014)(8936002)(36756003)(26005)(14454004)(316002)(3846002)(99286004)(54906003)(72206003)(68736007)(486006)(476003)(478600001)(66066001)(86362001)(109986005)(6436002)(6116002)(5660300001)(6512007)(4326008)(2616005)(53936002)(105586002)(59246006)(106356001)(71190400001)(71200400001)(6486002)(52116002)(6506007)(102836004)(386003)(256004)(14444005)(97736004)(7736002)(305945005)(8676002)(81166006)(25786009)(1671002)(186003)(170073001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3391;H:MN2PR12MB3248.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2lb++vnrge2YvaUDrTndFaDXl9vlrGygOEgM1y1T7bM9Sj78FkHMK8WDqj6xWTxZzni2cNXdzw2Fx9V9a7REbXfXKG27w+PHhvTwWGDWpOoCl40rg7SOnEda0lnCxk4c0kppUb9tYnCnKcIDUfr3WFxZcSD/qH8l2TACcf+I2xVbms/ZFji5gQHeGlJCw0EccNd/qC5Rl/5ZPk9RSZrQOdXq1oPrAQzksDkix1zjHORvDas3/C6sAL9veutYeMpAvF4qrcDh4UjqH5YJrD+GOohSwWX9gh9OUzjvsgMlZDvUmyTJDZ/E1qSyvSqOMuX1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8a502a-77dd-44cc-fa51-08d6748c1267
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 10:37:07.7034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3391
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series applies to family 15 CPU's of AMD platforms,
so as to address a consistent warning of
 "[Firmware Bug]: cpu 0, invalid threshold interrupt offset"
at every boot and upon completiong of successful S3 cycle,
due to a missing quirk, which was not extended to newer models
and also not applied in resume path.

Shirish S (2):
  x86/mce/amd: Extend "Disable error thresholding bank 4" to more models
  x86/mce/amd: Ensure quirks are applied in resume path as well

 arch/x86/kernel/cpu/mce/amd.c  | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c |  2 +-
 2 files changed, 35 insertions(+), 1 deletion(-)

--=20
2.7.4

