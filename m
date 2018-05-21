Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeEUJ0A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:26:00 -0400
Received: from mail-sg2apc01on0094.outbound.protection.outlook.com ([104.47.125.94]:53229
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750993AbeEUJZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:25:56 -0400
From: Tianyu Lan <Tianyu.Lan@microsoft.com>
CC: Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        Alexander Grest <Alexander.Grest@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] HV: Fix definition of struct hv_vp_assist_page.
Thread-Topic: [PATCH] HV: Fix definition of struct hv_vp_assist_page.
Thread-Index: AQHT8OW0xvko0r+GHEaIrg880bNuaw==
Date: Mon, 21 May 2018 09:25:50 +0000
Message-ID: <20180521092506.90121-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KU1P153MB0101;7:IYr4Ht5FFiR5YGcqdpOgmBCZYHDDKrUCmOYSyiq5dr/FJTIUQmEejSKBow2tVruI1+klNSoujdum/zyiGFla0/eNhsm9gBljBNR2TaLcscAuPG0RqfwFFAvU9q+KOCQrtMj4NAHf5hFerHPHIVy1bZ2EWnGaJ4uTE2Vua3wXqpMCKTGbPkvksX8u29YslWKXStJ7Pa2ZMgU5N8NCJenqu+Qc3azEHPM1HtwU8YjnWUFmJfv1TE5wNUu952bn31gf;20:e0Dpo0H3LRnQYlYoNg38dVgft1E+XNDB49i04Ruiaen9PlYMDGBDFamyYEe14I+ZZDD2wXtWHEGTMjmcFuA5F8vR+4wYmnuTpKSnSSnWU5GSgFqdj6MZIu6/3j1qnspZniGlQbcAaiur8yd5y/nSY/w/KdRinczvMMoCg4eOJdw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);SRVR:KU1P153MB0101;
x-ms-traffictypediagnostic: KU1P153MB0101:
x-microsoft-antispam-prvs: <KU1P153MB0101918379A821EBFB2D508192950@KU1P153MB0101.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:KU1P153MB0101;BCL:0;PCL:0;RULEID:;SRVR:KU1P153MB0101;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(39380400002)(346002)(376002)(199004)(189003)(5660300001)(6506007)(10090500001)(81166006)(81156014)(486006)(86612001)(7736002)(8676002)(305945005)(1857600001)(53936002)(6436002)(102836004)(86362001)(575784001)(2616005)(476003)(54906003)(316002)(25786009)(99286004)(8936002)(109986005)(26005)(6512007)(22452003)(4326008)(68736007)(6116002)(3660700001)(59246006)(1076002)(2900100001)(5250100002)(2906002)(3280700002)(3846002)(36756003)(105586002)(478600001)(106356001)(72206003)(14454004)(6486002)(10290500003)(66066001)(97736004)(1671002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0101;H:KU1P153MB0136.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eQZKuvHNGB3fFyfELhYfaF4RmqHQts09TPGkvOYNR//qg5Af2kQBVEX9kJ4/Fz+9MyCTu/eDM5PU3/wwKO7Z+BDYBf14fYp4/IxtR1IuXswHKTUliyH/V7L7cFjtPyq9yi2c0PZwnY772Jt/0PwgUjsS0rkA1dq/Z8Zqjuc/tKHSBV+Q0sLHKIYzDpzwSgfP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d486d4f4-48ad-43e6-37b8-08d5befcd7f3
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d486d4f4-48ad-43e6-37b8-08d5befcd7f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 09:25:50.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0101
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4L9Q6A3025159

The struct hv_vp_assist_page was defined incorrectly.
The "vtl_control" should be u64[3], "nested_enlightenments_control"
should be a u64 and there is 7 reserved bytes following "enlighten_vmentry".
This patch is to fix it.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index f7be6d03a310..fae0a5431cdd 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -496,10 +496,11 @@ struct hv_timer_message_payload {
 /* Define virtual processor assist page structure. */
 struct hv_vp_assist_page {
 	__u32 apic_assist;
-	__u32 reserved;
-	__u64 vtl_control[2];
-	__u64 nested_enlightenments_control[2];
-	__u32 enlighten_vmentry;
+	__u32 reserved1;
+	__u64 vtl_control[3];
+	__u64 nested_enlightenments_control;
+	__u8 enlighten_vmentry;
+	__u8 reserved2[7];
 	__u64 current_nested_vmcs;
 };
 
-- 
2.14.3
