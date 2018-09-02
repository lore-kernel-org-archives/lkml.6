Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878BFC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244DE204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R9Ap3viV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244DE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeIBRWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:05 -0400
Received: from mail-co1nam03on0121.outbound.protection.outlook.com ([104.47.40.121]:64374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728649AbeIBRVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhF8bGM7s9p7Kg/RdHF+iQJGxk8vqyaVtvebV5hp04Y=;
 b=R9Ap3viV1lJytHuOFtdh/txNpYtMXyJIvexAqf+3C1mxJOgBKjT4CU9CsB04cjMdFn0Nk1yqQEx8b9Pyo7vho3zj53LLKrU37M1l7IXfiPSrBTfhNFhN3eJ1r2K+pdzdc/YpmKxextfPgbs6ov8brqD9cv3+VM/rI7gHFHYc3hc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 109/131] mfd: rave-sp: Initialize flow control
 and parity of the port
Thread-Topic: [PATCH AUTOSEL 4.18 109/131] mfd: rave-sp: Initialize flow
 control and parity of the port
Thread-Index: AQHUQr2a2z4lcIrqKku9mIDoaG0Mqw==
Date:   Sun, 2 Sep 2018 13:05:20 +0000
Message-ID: <20180902064601.183036-109-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:yJ0t1vshVCfi88rG8SL1y4adQ3B8EDQ/4h0Lro+N83U2kjH7f3zJo2Rhs/wezChQxefv5GV/ngC7zx8b0rd7ZvPNuGe28umMpZq5+PHeTV0BuHzdarzyz43/ZgQUsbwCpD02jBJWlUpJy0ZHrKkb+OfwI1vxSFogmblXFfsedMzg+xIheXw/WImu6CMS6sk/Sw/zqnrXiPv8+k2331UIoGo9kyWTDcPJzfgdNltz2AaGtCreUOLzxMvQnE5HHMC2oScdCtT3RY322X7MnMtyMIlfPGiLpzsJXYZyvsD0L6YJ8skzEwQC9XYYNJcPy90TyhkYafDw9SURHOGZpykkjgorrZCu5O7Kj87OI3rWO+kRNEK3700044zLNdKNpRFVlfymLZvnOIk1Mjyg9kAyc4OqGhcnak9+MAI2UBXL0Z394csr0T+JKNtXwzF0Aehd8xhlAJS2A5ih4ci1NsBPPg==;5:MjcAPjxaSlh1s4wEl+mojjT+wrbkTbfGRXNDK5Y3916+XE9Su6j9+buK7wsdWbGc+gKq6tJlLoM4RhUN2EXpWKItNEasVDCoa6VPNAJJO/uf/beFq304d2HEaJPNCetmh093gB4WWQBcv5F+K8nmtMHVh0NXeryWd8iSxZtgn7Q=;7:JZ5hVYF71MBE9ZCXPGpAO6kKcpA19Cqys8C5hx+naWKN5s7gkgFifNmUTiI79fqw/96B6SzEktHeb3rADPH8EEDuhtYlAyd+aoa8XWMW5Jr8KQ7lbfsGjlDyAZfDAinknEmFn5rPeCQPPhu9HX8NjFGyaTeIfsvBNjFNltoSX+ReRPm1SvmnBi50S6gQHbqWWl10eKVa3BtP+3WFQsGDDvczcU35GY0IfBM86qlQoosrt772e6wg8LbJ9/bR7txd
x-ms-office365-filtering-correlation-id: 41e09812-e2db-4a90-050c-08d610d4c75e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184AC3877FEF62D86B46FF0FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(39060400002)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NAaMMjTtmnZJdw0wNXsNHkTiTH1ohUdEvbaHj1nZmy/U4qv6cE86UVxA2IlyEPYTtTgtQZNA5halfscTV3S+MK3wV26Mz5PJEczOnG+9ymrMoq9m23LoxIY8a47/mWhInvT3o6g5CXGW3ZMoUXFdHqTi0ept0svy/CXjuMlrPi+MbtuoUu4Y3wcjFWqnbffyMIqK4xaBCpEF0pvVRcC350fU1/g8q/+UJCxEPUn6H7WwxESnxLLVmk/f9p5alJmFN98fjT/zzJ0zMbfUTTp/1le2I/CBwyA7bDzZTHAJ8VX1pbKsZeGabsyvuu32PRTZaFGQPQCsObevtajXRJrjn203uF36hobJJEv6JRLwKeo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e09812-e2db-4a90-050c-08d610d4c75e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:20.2332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

[ Upstream commit 6c450bdf13ebe110821a74960936cec936edae49 ]

Relying on serial port defaults for flow control and parity can result
in complete breakdown of communication with RAVE SP on some platforms
where defaults are not what we need them to be. One such case is
VF610-base ZII SPU3 board (not supported upstream). To avoid this
problem in the future, add code to explicitly configure both.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mfd/rave-sp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 36dcd98977d6..4f545fdc6ebc 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -776,6 +776,13 @@ static int rave_sp_probe(struct serdev_device *serdev)
 		return ret;
=20
 	serdev_device_set_baudrate(serdev, baud);
+	serdev_device_set_flow_control(serdev, false);
+
+	ret =3D serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret) {
+		dev_err(dev, "Failed to set parity\n");
+		return ret;
+	}
=20
 	ret =3D rave_sp_get_status(sp);
 	if (ret) {
--=20
2.17.1
