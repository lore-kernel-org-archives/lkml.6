Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD60C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5BE222E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PonqHoew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfBOJR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:17:56 -0500
Received: from mail-eopbgr790053.outbound.protection.outlook.com ([40.107.79.53]:30846
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfBOJRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3JXrOQDORjAdnNzbwyJbMo1+XjeO11dEslerZ7GbaE=;
 b=PonqHoewQVPm/hphQy3dVb0071EGL7TStHQ2Ap+Vi09klqTLiZjNhE+m/pEfUb6tm/R56H1bTdEa/9DJMBfvbMO5ByBs8zSWFKnoTODm5jxG0TRy1JUEtrgSHQiqiMx+O0PWcjSaq67kPNR/sIcxINJWBLMi+iv3FtXXGsjXmXE=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3264.namprd12.prod.outlook.com (20.179.83.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 09:17:51 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f01f:c1eb:8483:1679]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f01f:c1eb:8483:1679%5]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 09:17:51 +0000
From:   "Mehta, Sanju" <Sanju.Mehta@amd.com>
To:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>
CC:     "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 0/4] bug fixes in ntb_hw_amd and ntb_perf
Thread-Topic: [PATCH 0/4] bug fixes in ntb_hw_amd and ntb_perf
Thread-Index: AQHUxQ9T27dDEa1fmE+JNVoiuBSvhQ==
Date:   Fri, 15 Feb 2019 09:17:51 +0000
Message-ID: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::18) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d580b79-1ad5-41d0-b93a-08d6932675ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3264;
x-ms-traffictypediagnostic: MN2PR12MB3264:
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3264;20:DZlbR3l+fmw111wJp53QUj8miXTvwZzPazbY/5aB3Tfw2Kq4APlH7sxsFnzYnzPwdoswssrxywr4awy6ILxuZzun1amZi47/sQj2amoXOYKBfgUws6TXqhTWN0vfuMJgYHWZlrozncBBNULdKIFvKb0rER5dK9g9o+q8dICMmdUOcqjGJzS86bN6L3KuJfXjUat0WDv5QEYaxuWH855Gf4qiDjjnQFgrXdvaPwHWbdQbosYJ4vs/pjvLKCl27GpP
x-microsoft-antispam-prvs: <MN2PR12MB32647868DD37C5A3DF05A94AE5600@MN2PR12MB3264.namprd12.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(2616005)(105586002)(99286004)(8936002)(4744005)(81156014)(81166006)(256004)(476003)(71190400001)(71200400001)(3846002)(8676002)(50226002)(486006)(52116002)(14444005)(6116002)(68736007)(97736004)(72206003)(478600001)(2906002)(14454004)(36756003)(86362001)(2501003)(106356001)(54906003)(186003)(26005)(110136005)(305945005)(102836004)(6436002)(2201001)(7736002)(6512007)(6486002)(4326008)(316002)(66066001)(386003)(53936002)(6506007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3264;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DNMcJraEkmY/u35pfCgjOvr0oc3ubwUJJ/dA/wc5bXO/KrSZEk6LNopVYBPWnTSN5acMu2Lrj+S6vD06oXFrNAcg3xsMf0aCt+VPCOi/+0VSSOSSU3SoVg1TUDyKQBWyihuIEawA4+RA+7fVzTK9AzIrjAnI/L/VAcWKKPP8tHy6gnH9xHHuMLnRLKKebq1nW4OXhGuoKk8/jyhKPjJc2o5v4BovAxIq2dVax1kGMAT0vP0cqihF6nRG7pAipiJprJAdX4BG2PozvOWnt/9pnJmsDxuKk5nGlF1SnLs/Hy4P3VYWxKUEQD8x/Mh3QfM1sjTua5iHBjza4b/DlqpzMIjkFeVxXQu8bqd4jXMIcYEtbyt3ruUBA2QGtvYtNS1ZIkL00P6Mz4qz/FL7GoX/3w267SvWAVMuy+JnpP/o+xY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d580b79-1ad5-41d0-b93a-08d6932675ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 09:17:49.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Add bug fix for ntb_perf and ntb_hw_amd

Sanjay R Mehta (4):
  NTB: ntb_perf: Increased the number of message retries to 1000
  NTB: ntb_perf: Disable NTB link after clearing peer XLAT registers
  NTB: ntb_perf: Clear stale values in doorbell and command SPAD
    register
  NTB: ntb_hw_amd: set peer limit register

 drivers/ntb/hw/amd/ntb_hw_amd.c |  8 ++++----
 drivers/ntb/test/ntb_perf.c     | 14 +++++++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

--=20
2.7.4

