Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826FDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0E8208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0E8208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeLDELf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 23:11:35 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:24796 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeLDELf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 23:11:35 -0500
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id A40D423B4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 04:11:33 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (g1w8108.austin.hp.com [16.193.72.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 92EDE92
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 04:11:33 +0000 (UTC)
Received: from G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) by
 G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 4 Dec 2018 04:11:33 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W9120.americas.hpqcorp.net (16.210.21.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 4 Dec 2018 04:11:33 +0000
Received: from AT5PR8401MB1138.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.138) by
 AT5PR8401MB0612.NAMPRD84.PROD.OUTLOOK.COM (10.169.4.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 04:11:31 +0000
Received: from AT5PR8401MB1138.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51f2:e4cd:af67:5d5b]) by AT5PR8401MB1138.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51f2:e4cd:af67:5d5b%9]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 04:11:31 +0000
From:   "Arackal, Paulose Kuriakose (STSD)" 
        <paulose.kuriakose.arackal@hpe.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Query regarding Spectre fixes for qemu-kvm...4.4 LTS Kernel.
Thread-Topic: Query regarding Spectre fixes for qemu-kvm...4.4 LTS Kernel.
Thread-Index: AdSLhV9I1vEX+F6FR36M0R/JnUUKHw==
Date:   Tue, 4 Dec 2018 04:11:31 +0000
Message-ID: <AT5PR8401MB1138DE66FC69195F3F2A9886B8AF0@AT5PR8401MB1138.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paulose.kuriakose.arackal@hpe.com; 
x-originating-ip: [16.242.235.132]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0612;6:VEGAF7Y4WCnpcZlVFb8HgAaznXiIiMJg83F1i6Hcn94+6fTu+W0E0S1weJ0KyxYd+HO8M+Tm/TGMocAay/VEc09nE4mZZpEKQUwqIKqRD+0z7sMNPWKNZ9kDk9KSOHoTCKoqR0KpUtZ5aTH08HoeUzrT9ekXpPXKzc+QEa7sCRLknpraikVrponullMBSfkF876H3/1oW0gJ9vROKBKH0pbVIOTy8cfOH+KQOa26W0i2FYLi+GyCqWp/gMqkHmLEO7WKo4RqiYdtxGVUG0+f3f/agPchHZNIUEi5Em9p/SmOcODSX5ietuHHa6hldxtsRWyBoZL8AgSsXPD6IT4sV2xkS0BH+6mwTJo6sEJ8dVHGGp2EgHTrpSHcXMyudjwxRFIdjaIHXZ7g6khWdPfpdPf6Xv8sI7E13DEL72Liu/tCWsyXbtmfGTnN8tD+Gn1ZUqYdiW4c5tOxbzhG0K5Dyw==;5:a8QHPLm0bbpqFUPkWEyhagGq2hXgHjtnvQPgu+b13DndfmDwUgjhEBD7BOpi+3MYwA1+BZG6z6ChYsapXG17eFOaVV34SQamAZMOEALaSpQNSRoHN4D+ijI0r+mxjca9T52L3Lo3vCm3MjVL62okE3+VJ+JjJn5tbv7viuafX+s=;7:qnjXOcz4A1Z6XzrTek7CupDC8n5GxunPam1pBIDjY+vXE74EKuHiyN652oWVj3fQkDl7kUq0mNsSkc15N7bn5ESLjdHshhwn7zoAIv16xg/5IhxJ/+zO5UAS+GFpsk/dECoZqbAT8HyEovnSCeqN7g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 901fe1d9-a106-4151-3824-08d6599e9237
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0612;
x-ms-traffictypediagnostic: AT5PR8401MB0612:
x-microsoft-antispam-prvs: <AT5PR8401MB0612A37369FCDCED9CE262C1B8AF0@AT5PR8401MB0612.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AT5PR8401MB0612;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0612;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(5640700003)(2501003)(305945005)(7736002)(25786009)(6436002)(66066001)(105586002)(106356001)(71200400001)(71190400001)(8936002)(81156014)(81166006)(8676002)(486006)(2351001)(476003)(86362001)(575784001)(6916009)(478600001)(256004)(14444005)(68736007)(14454004)(97736004)(7696005)(55016002)(6116002)(3846002)(74316002)(53936002)(316002)(5660300001)(9686003)(102836004)(2906002)(99286004)(6506007)(186003)(26005)(33656002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0612;H:AT5PR8401MB1138.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tZl4V1lqbfgCEsgfIHggia2i0YKwqYxPPydVu9+uwmFdNWsFAq3AMk/uoIE7FSXNROYGTnz2yeFXYRfFIfiGr7av6FiIzwuIBW+TyJSnSKtXr5AX8qKLo6IeqKnGVc/iVizsVtz7oJL9L6tLrQ1HB5Qb0+cea9Zn9k/7xvjMrn6i50v2fKf+AQxbLboB/+FEVcl6dMf+yFFIix5Hc5Z28bESRXOcBGiZe+8SuI/ALdLlgFXzoe0PT2hsWlQFXA0WotAes5ruZXmFx9/YLFoiuD+t06uFaGurlbxaF2Cnf0pJRuRFEiGD87ytRfK2BX/qftaI8YQ/Xq6vT6oTQr2f8zyrgoLwtwyujwrkVTExUNo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 901fe1d9-a106-4151-3824-08d6599e9237
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 04:11:31.1190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0612
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have few queries regarding qemu-kvm support of Spectre related fixes at 4.4.* LTS Kernel.

I see that in upstream kernels, svm_vcpu_run() calls  x86_spec_ctrl_set_guest() and  x86_spec_ctrl_restore_host().
And calling into x86_virt_spec_ctrl(), that sets IBRS/IBPB/SSBD bits accordingly for guest context.

Related commit IDs below:
commit 5cf687548705412da47c9cec342fd952d71ed3d5
commit ccbcd2674472a978b48c91c1fbfb66c0ff959f24

Looks like this change is not fully ported to 4.4 LTS yet. 
x86_spec_ctrl_set_guest() and  x86_spec_ctrl_restore_host() interfaces are available, however looks like  svm_vcpu_run() is not calling them.  
So qemu-kvm running on 4.4 kernels may not have SPEC_CTRL set properly in guest context.

Is there a plan to backport above changes fully into 4.4 LTS kernel?.

Thanks,
Paulose. 

