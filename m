Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A755ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8FF20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Eu8eRkDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8FF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeIOHBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:01:41 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:19456
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729091AbeIOGtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWe/j34FhT6Qi78lnt015naka/fottAhUWKUY6wYSJ4=;
 b=Eu8eRkDpCxM6SFSEydHLVXcHz8mNsCYmOWyCz8vd82AD9q5e25W5pQL/sRQRYx0MAiWprHOVFDtI7NHbQEQ0s2C6V3GIUK80RsjmiPbAk5WJz44h2eK2cjyK6/C4QNDX/5LRlqHLdCIQllg+B/OzXUIkgrCGKwqr6kwV02X7YbY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:32:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 10/57] KVM: PPC: Book3S HV: Add of_node_put() in
 success path
Thread-Topic: [PATCH AUTOSEL 4.14 10/57] KVM: PPC: Book3S HV: Add
 of_node_put() in success path
Thread-Index: AQHUTJP6Kt/jBwG09kWX1ZejUBoMHg==
Date:   Sat, 15 Sep 2018 01:32:34 +0000
Message-ID: <20180915013223.179909-10-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:sjYJEjjh1l4WcB503oSeRKRA4vL0/GiQAO+UWC1BQx3LJO3KATu3yZK8ukZgoq1cbPcuAWLNj/2zFP33wrE9dMr0BChD3eZxzLJJSTmfjHHvBy8z39U1XFFlr+L8Wr/qNjubUeBP3gpJgG9P4KRXVET3/gR0Vo/Ez2SyHWw5Mul8oECehA0nZzm/5yQFedzAXvgF3Kv32n2YU+PLSyxo8PHt9TfLEwZPwhBzF/dLXjLI4Zq0vSLDZChAZ767x7BwRlOzbVRuKbQ0fWdVLdcMPLetNQelVIRzOOvQ8ZNO5jwh0c1yabjG4d8uSNzOJk1CRjtPsBByI6yvxh7DOI77obzxobO31atr5zIaC/Oo7gwCJxb+kLzoJcQpoJt4NeTZp/NbObT2Zh5AsvdSo12H7AS9keYk4utd12YalDghTtkAUbmAVk+VXZlYufHl0sqCC0t3oobQiE8bXwziVE3VhQ==;5:YoyRb/aiQxkvkMYxkU6E+VtRriVqxa1sk/6h9sH8n2prUlxtlQlS15irUl+rGGfFk6pQOTSpVqW1Jlz0QSssbP64rolZ0Wl5PvRK+P2wC5W95HRXQvh8c7k15sSayD94ntYNOj53EMp5H4te/ydQS09XP8WDFqe4e6mFLd9a40M=;7:suosKk1/bnbuV1fzDOyQkahJJVVl0/mMLr1zlPuMRTjMJXWPwI8nbS5qOoKWtjZct7tUyeWOc60+ZMgoZFvIpHNV+LBHhmO7zaVgWFQ2PsDE+iCDcS70PBf+SYPIUDgLOIm55CrRFJAuPZ9Nnr4X3H0dQ0bMln22vk/XByyfXTGoViK7vRoRbdKXb7jiCRaIi4cCbRuwluZLchV2jwkjSZ+20X16aLbbEB7NLIK38LoQbFikkkL/VKcpAMJuuNiD
x-ms-office365-filtering-correlation-id: c088f400-e8c0-4f8f-f726-08d61aab1ccf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01173AF5A2527AAB3EAF96FBFB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(86362001)(256004)(186003)(6506007)(22452003)(114624004)(68736007)(26005)(217873002)(305945005)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6JYcGdI44UBxd0etDUmAy4C6Zxyaqu0sRyLIynw1X8RxIcWUTE32awz26WSQ4eRid6dYRZMQLW0L/R8FtYhDCaVw9NKviQ+otzBwozX4kwn0tGyNhewL4O62EdPg4aeaZeYL0DuGsftCecMllulDvRuBb8BSoA/2zmQwOYSXDUv8IZjEKFfrbSC8PAm4kf/0ZPedc0JonBh04MZ0HmVMgLYp8M1hkULjHRLfSqxtC8VoZfpYc4TAfPmP03UqhdZTVa/1hch/kOfErga3e+jR8Pc00MeW4TjuUUBxiLCp1nYLrDQPLTVX8azhgobJ+VsriL7fsLOsTrxbjsYodiiHOS38gRhyu+BmEVRunx9UAqE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c088f400-e8c0-4f8f-f726-08d61aab1ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:34.3218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 51eaa08f029c7343df846325d7cf047be8b96e81 ]

The call to of_find_compatible_node() is returning a pointer with
incremented refcount so it must be explicitly decremented after the
last use. As here it is only being used for checking of node presence
but the result is not actually used in the success path it can be
dropped immediately.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit f725758b899f ("KVM: PPC: Book3S HV: Use OPAL XICS emulation o=
n POWER9")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 377d1420bd02..58746328b9bd 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4356,6 +4356,8 @@ static int kvmppc_book3s_init_hv(void)
 			pr_err("KVM-HV: Cannot determine method for accessing XICS\n");
 			return -ENODEV;
 		}
+		/* presence of intc confirmed - node can be dropped again */
+		of_node_put(np);
 	}
 #endif
=20
--=20
2.17.1
