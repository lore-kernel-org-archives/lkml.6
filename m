Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D91C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC8E20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TNnXoe9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC8E20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbeJAHS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:18:56 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:26608
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729948AbeJAHQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrRungXDr/CWY5nYSFLGNaSfMLUrVTEhFJKHAXBfAt4=;
 b=TNnXoe9l/mYu0CU+dq7Je8hAbU/FTE6Fri8esMkoMXeNslSFGPkCWdtCcc5AyA39L2Fd0GbyDpW4EBU45h01nEn5eyHtnntH2Y3b+JwoXSixXZgWgmgC70UyZ1EBK1Y95ZQPzFPS0uPns2LswWeestWxDO8zYVX2bCPamZAvYS0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     vkuznets <vkuznets@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 15/17] xen/manage: don't complain about an empty
 value in control/sysrq node
Thread-Topic: [PATCH AUTOSEL 4.4 15/17] xen/manage: don't complain about an
 empty value in control/sysrq node
Thread-Index: AQHUWR+AzkUjBM/sHEGarXJhDxTTHw==
Date:   Mon, 1 Oct 2018 00:41:33 +0000
Message-ID: <20181001004122.147276-15-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:fMnzHzVPtKrBTxm7UI7Fxl1WPQAClQOVNTNt5Fu9iXVPGnfgnsbT8lBt2HOK79yGbKPG3s5NaHr8jK5EEIbdR4xFAS6PuBpnTs0OH09UxDfEctEcx4H9DaSjSNoId0PEt6z/a0lVcYFGkDPOxz/zMThZFPSDDYSL4Cwi/oc9ycPLCCiUrSinG6yI/KZdjT5ekrGgINAF3ntkNXhRMvFnRkrq4N7gQsTtBcMhsKrhUKrJIAcTdyR9v2NCiRSaiaTk/ZTdwtH/uRaKcoYhbOagvD/749cFotdp8toDSi8uKvqRx5LEj/Lfpw6zggusTxQZvo+pgpywq5FvkPgvHAIPVi2W9DYccosl7kvPDZv6w/SGiP8t/qLnlwpDXDy5TjScbSk+5drhKFMdwDndX5UwyR2RotIGy/MlsT28lxPw7GLWMh9Uz1JBnKhdDabjNbcUWseLNUmV/LbIoEkCI3kMsQ==;5:H6hoKgac652X/EYim9JlAZRNDdxtquwyXZEnq4xksJCC7WXfpX2qqT2ywX50fX6lsIe9EwYjXFhoYc0LNUXJn49vUn93Q4QDJ2SJpBPrh/qXqYdLbaqMKWQf33KLg5bKk0Qh3Rc64RWmGipKXreKqReNy5Hwd6jLDE6+GDUncMg=;7:q4plUYfGonHnR+gqfnM6/mFSn350HWmdmoDlfI+eLUUd+EsEEn5i6VPQRTqW9lmZbr8CAQBXN0LMN8Vqpdhgbt+gpHchwDKLawA/f/04ulI1XK9NknrxeftdZF6h0OrrpTvRG5H9IEfG7r2++AzEbzTKvThkcDtfhIH+8PujL/OzVOQSsQ0zCmS9l4jk6xct4Hy3kSD/wgYPImiYMlxHOBBuZ3bOVXtGTyy4T9qZ73s6Wc7fQinS9MwVkype8gBF
x-ms-office365-filtering-correlation-id: cf85df73-ed89-45d1-001b-08d62736a325
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB07916A2A891D9385E96C4EAFFBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(70601490899591)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(551934003)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002)(13914002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +Xw8xHdwrkOko7o/rq+bDgT/ehZCYv3BzB0WwQ/m2za04AtWlhE6qytI3V+UQIyNz/OVOPiXL5mvqm7EAFe6DpcdFC2jIaTSHWIs7mBZ4f3AJIp/S4FBeagZA+sXmLKNH1Bse7TOZco8IYpnb736UKydrzvafYJXr1CJ7z7SXzaoTFhIcoY70nFLe9kmCoSG4wy929LzVdvBB+eeyFICWfQe/7YD72Ho8Fx7gjHHrOD19wSZ3e/lf2Z13B80q26fpjqPd/k5rh7n8yrjRSgw0NswVsMzA3DYHhiQBhOSHDh5Wpk+Goo0CTcPhRlfh7u7IX6DOjar1Emdtg1V2F4XVv12oQeWgvgCJZJvbsplA4Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf85df73-ed89-45d1-001b-08d62736a325
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:33.6790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 87dffe86d406bee8782cac2db035acb9a28620a7 ]

When guest receives a sysrq request from the host it acknowledges it by
writing '\0' to control/sysrq xenstore node. This, however, make xenstore
watch fire again but xenbus_scanf() fails to parse empty value with "%c"
format string:

 sysrq: SysRq : Emergency Sync
 Emergency Sync complete
 xen:manage: Error -34 reading sysrq code in control/sysrq

Ignore -ERANGE the same way we already ignore -ENOENT, empty value in
control/sysrq is totally legal.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Wei Liu <wei.liu2@citrix.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/xen/manage.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 2dd285827169..f494126aaecd 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -280,9 +280,11 @@ static void sysrq_handler(struct xenbus_watch *watch, =
const char **vec,
 		/*
 		 * The Xenstore watch fires directly after registering it and
 		 * after a suspend/resume cycle. So ENOENT is no error but
-		 * might happen in those cases.
+		 * might happen in those cases. ERANGE is observed when we get
+		 * an empty value (''), this happens when we acknowledge the
+		 * request by writing '\0' below.
 		 */
-		if (err !=3D -ENOENT)
+		if (err !=3D -ENOENT && err !=3D -ERANGE)
 			pr_err("Error %d reading sysrq code in control/sysrq\n",
 			       err);
 		xenbus_transaction_end(xbt, 1);
--=20
2.17.1
