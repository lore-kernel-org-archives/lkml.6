Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E9AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6492146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xGzZna5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfBAWzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:55:55 -0500
Received: from mail-eopbgr690070.outbound.protection.outlook.com ([40.107.69.70]:46228
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbfBAWzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP+fDv5YgwOtisYVwREivk9c8WSv+n6I1ajPgjtq0LA=;
 b=xGzZna5d5os+fS3HKub4XAuQjjKK2LNrjD8v8pSLKWR0q79Z6PbEFqEsognYhGU+QxRl78X9Olf7WpUlb6lheouzvNzLU28CrYwLhzVS1j0eeJx6HCWAa2JM1KJ/1Ytx8XbUi/zEmgSwcDdeKegw2ossHl7IJajFm+FPCSndpXU=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2628.namprd12.prod.outlook.com (20.176.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 22:55:50 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5%2]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 22:55:50 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 0/5] Add new SMCA bank types
Thread-Topic: [PATCH 0/5] Add new SMCA bank types
Thread-Index: AQHUuoFGpsMf0k24DkG6/OX0ISL0XA==
Date:   Fri, 1 Feb 2019 22:55:50 +0000
Message-ID: <20190201225534.8177-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0027.prod.exchangelabs.com (2603:10b6:804:2::37)
 To BN7PR12MB2593.namprd12.prod.outlook.com (2603:10b6:408:28::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2628;20:HucV/88BYehUSGA5uS8hTbpVcN27ktpGjVAnhlo2Hmy0EiOeGGCu+jSyxCcvDKvgS8z9XIKQK0XBFnuOM38xRSXKvuJNo3NFYxez9ZIqw8u+QmWPDEX6WyZytUsIH5K/9gnVAQZo6lE4AMj9OR0AuM6EAiLdWh8kOQsBdaCTcWE8YXEauhzZBKnc/haCcVZP93UmTSAZy/Wz31HPAsA3bKQPzS4+W4F0xMScrh8upVD0ZJvDnicEz3AR8dTLt/PF
x-ms-office365-filtering-correlation-id: e162f61a-e903-4824-c9fb-08d688986904
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2628;
x-ms-traffictypediagnostic: BN7PR12MB2628:
x-microsoft-antispam-prvs: <BN7PR12MB2628E86035DAF0172BDC3668F8920@BN7PR12MB2628.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(186003)(1076003)(2351001)(106356001)(71190400001)(52116002)(256004)(15650500001)(3846002)(105586002)(50226002)(6512007)(6116002)(25786009)(5640700003)(6436002)(66066001)(71200400001)(26005)(478600001)(6486002)(316002)(97736004)(2906002)(305945005)(7736002)(81166006)(8676002)(81156014)(54906003)(68736007)(36756003)(6916009)(99286004)(6506007)(2616005)(476003)(386003)(86362001)(102836004)(4326008)(14454004)(72206003)(2501003)(8936002)(53936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2628;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aJDjld0AfxPl/IcCzgcAWQe//TxEdLucJZfN+/+siKvIyhHWXtyJnYcpZTrQzfGlwErldpaA/QGNZogTFv7gAy6aUvDvyI1qNEf6qszkbn1a843f65d1quzy6bSXnSOF6eB0irZW3VmRaZudkiMSwX4Lfh4Jzpx+gL7CJovTi4N7o9BBU3xaEmwZws8rpWs2fX7RUxCDY6R+mJe5FpDLpVc1lb7JeTJPfOtTzPndLqOiQoILsa/izK963UNVx0NWGgpShvmnU2nKGSXFjG9yi3ctg3TbgoJCYniPg+FZhjG2khYJuXv46BaoswxewhCBn6ltqF8JYiZWkqy7ADa22rxkgcnX5lCRnLtlwo2/qTgHokRDa5YqnocFDTiYlVC8oZ9vIb2mz9IxbR6wYbkhBcDW1pjkjZ2qeohGyFF9QWs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e162f61a-e903-4824-c9fb-08d688986904
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 22:55:49.2518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2628
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

This series adds decoding for some new SMCA bank types (MP5, NBIO, and
PCIE) and also for some new versions of existing bank types (CS, PSP,
and SMU).

This series also adds new error type descriptions for existing SMCA bank
types that aren't getting a version bump. And also some error
descriptions are updated to more closely match the latest documentation.

The last patch in this set is a minor tweak to print the error code and
description on a single line rather than separate lines.

Thanks,
Yazen

Yazen Ghannam (5):
  x86/MCE/AMD: Add new MP5, NBIO, and PCIE SMCA bank types
  x86/MCE/AMD: Add new McaTypes for CS, PSP, and SMU
  EDAC, mce_amd: Add new error descriptions for some SMCA bank types
  EDAC, mce_amd: Match error descriptions to latest documentation
  EDAC, mce_amd: Print ExtErrorCode and description on a single line

 arch/x86/include/asm/mce.h    |   6 +
 arch/x86/kernel/cpu/mce/amd.c |  26 +++-
 drivers/edac/mce_amd.c        | 264 +++++++++++++++++++++++-----------
 3 files changed, 205 insertions(+), 91 deletions(-)

--=20
2.17.1

