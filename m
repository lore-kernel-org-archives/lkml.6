Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AB8C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D75A2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lAv0G9Se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D75A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbeIGFS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:58 -0400
Received: from mail-bn3nam01on0093.outbound.protection.outlook.com ([104.47.33.93]:60384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730743AbeIGFS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClGRlTN37CNdBDlQ2zq+qk2HHtWJ4kfLZkfJRM91GgY=;
 b=lAv0G9Sez7z6gWs0Fi2jdbyTeqANnVbGECMRTNryx9tRoA+bOgg0wN32iKp1+hNkHogaoC09x0BdeR1BTRGSQs3ePt//dSKT/pSmAnAmjOyaH8vHRh1BYz7/Eco36S9oXBFcusJ98Irhw1NmF8O3jRPLlR1+Z18jcOshKlBuKtQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:40:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Imre Deak <imre.deak@solidboot.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 19/43] fbdev: omapfb: off by one in
 omapfb_register_client()
Thread-Topic: [PATCH AUTOSEL 4.9 19/43] fbdev: omapfb: off by one in
 omapfb_register_client()
Thread-Index: AQHURkMapDn3D7taIUGno+EMxRWcTw==
Date:   Fri, 7 Sep 2018 00:38:32 +0000
Message-ID: <20180907003816.57852-19-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:eu5sXBHwjOhGQxvpylmV+5vHOEteuVE8AZIoq2vPycLxtTIx8EyqOZ+n60f+easMUVG3UlH+BcFylFnDzyrFUYQq5m8JpOd417rY/lwgxUGaeoIbSN02+GwC1ehBZrXvlPRTWVRQcSIHkT5GGflYKHJdgIe+dVJE7uOG7vpuYVJImdchfznzs5VOmBeIP5CK3FYkLDADkxRPz0K8ejdq46E6X7RwgQ0+bbkiuggIsbEpaq3p1mFKsteEyi1/Qg6hE/L7wQomwkT2TJXjD3X+yXUkGVgAyo5TpuX7YMt03383/zXBH+QcguOQ1pDmpGJVURIby63Pu915QsRhmVdGyM3kI+SwrLGUkAIXZ6I9dCEGlN3NKwFW36INB0F3hv2EdQ8WUtyulLg27uPGtBvoD80Hknz/Q7XVSJ+jwz+W1qD4ISn8XE5GMAFwO0oiGXjD442NsA0EdfoW3T/sVDl9kQ==;5:U/v4kzS8C3fsETOOr/6QD199TOft/QSHMbA3cn0dFDFsZIICz9I+waBgsAVMzIGDVPTN7WMmeGwqzlB1VKaaCDU5o+r9y1DCBvSC2xEe1YGR+l51KU3eGtfoeQikA97+0bbvp4EEeb0Bo5wz2veMzJI6iYEQhZ8TONUSPCDAcVk=;7:IFwxvhue5JOHpGmr5MTapVre8EFsf2X6G74dC8XmMowWRJX/Ae4MEvbVx2aUcCk5hYsDBmjeuxCDf1IaxsJiwsvYF71FRt8QY5lljVu2/7EJzLUXPrFhYaubklVagyT9NsdNlS9naiZwNbOPO/ntc6/oAWlWciVtTTxtfWwN0lToDqCXEJYH22PNHqItAJk7x3MXNVXV/vmonzUaJhZM+8VfUcwdP62Wesdea6MYb3C/xpFlTlstlDPaCjbDezyz
x-ms-office365-filtering-correlation-id: 0b8f840f-c606-4fa0-b6ef-08d6145a8bd7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855FA2C08B7B6E3D3B82630FB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(146099531331640)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(575784001)(2906002)(6512007)(54906003)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(14444005)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vCTeN1F7dwUks5fpURX76ROcJMXEYb86Tm4SFKvjVorox4bP/5z3J98JlUgGpz8xbH9tySKQOSWvpTOJdHKPnfAu9ydGe57VIHI2sQ3HCOG1pWig3U2K6ynUY2F+BHTGKbJxNfLuAp2HGgAps5njM8AXOWblF3GQBq4k+FypEwIFru+I6hww8rauec75abYPFxXeihW7Zsu5ah0mhdw+YeOF/d9ejSa7xhIdVXDxZbTBo+uIJbrvcRHJlEcnRhYCfNosth0Yv/bznk58Tkdpe2Ld7M63uft3rAcG+6dnl2CNedLkTQ0vpANnVKJezbPmuZFqDISbqitJ/qZ+iqcpVZG+k/Wqsx5UCVYTWHK/0jc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8f840f-c606-4fa0-b6ef-08d6145a8bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:32.3533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 5ec1ec35b2979b59d0b33381e7c9aac17e159d16 ]

The omapfb_register_client[] array has OMAPFB_PLANE_NUM elements so the
> should be >=3D or we are one element beyond the end of the array.

Fixes: 8b08cf2b64f5 ("OMAP: add TI OMAP framebuffer driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Imre Deak <imre.deak@solidboot.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/o=
map/omapfb_main.c
index 6429f33167f5..77c97c697fea 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -956,7 +956,7 @@ int omapfb_register_client(struct omapfb_notifier_block=
 *omapfb_nb,
 {
 	int r;
=20
-	if ((unsigned)omapfb_nb->plane_idx > OMAPFB_PLANE_NUM)
+	if ((unsigned)omapfb_nb->plane_idx >=3D OMAPFB_PLANE_NUM)
 		return -EINVAL;
=20
 	if (!notifier_inited) {
--=20
2.17.1
