Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4C8ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25FC20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eZr3Rf1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25FC20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeIOGsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:43 -0400
Received: from mail-cys01nam02on0113.outbound.protection.outlook.com ([104.47.37.113]:35712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728325AbeIOGsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFwwboriQ+sne/3zau4xA9IDCSs8y4isOVbxa1hvh3o=;
 b=eZr3Rf1/drAZ5VdZaqCKRNliSJJN2GSnJMiA87+5XaT+Us+uTaok51idiBbr8K2ag08V5i6gLmBB6ONntHFAnSJPfp7WxxAfvX1CKgh8GFoUmQuLNua9+7GOAhfcB02LJXr2wF1IrRMJij3R7vFmm9/aICPZzJi1WmMbCTSJHwg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:31:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 85/92] block/DAC960.c: fix defined but not used
 build warnings
Thread-Topic: [PATCH AUTOSEL 4.18 85/92] block/DAC960.c: fix defined but not
 used build warnings
Thread-Index: AQHUTJO8NiRGb+1gWEanqILxs3Xq8Q==
Date:   Sat, 15 Sep 2018 01:30:50 +0000
Message-ID: <20180915012944.179481-84-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:oV7DsXOrAw+4gRtFBj/bzaQobi3wjEjY3Ku94RYvv16DwwydJgwHe1w9yu/EHGAm0g66eS0S9fhLJ1Dxq918PckmlMx95WPUBc8QoSHF7plTdLAzZ2M6lc6PQl/kZjwEi2y20Lvs7O192mvT4BcjYKnYVn+Qmy1WTxq2dQ1fm7+Sk+eT1BjW32cTMXtBpQa5TfCgvhBVe7bazKaf4jbpnU2uj6AAlDLjz0/1cG9lVeliQBLflsssfyhlgi7ACkUVoxlQQroIv227duN+Vtj7/Ow4QsZaJDLGradlGN0g449An5Qke6FVq1XzgxFICXZ9K2HOYchoAueWmp6HLW5HRCWOlSXIvFuvXZ4geNeW1icNOlxqGTrFkVl6KWCAQBPH3hbKep5uB8MXQwIh6w5YBX9t/7WHc8+q8kPLoxj3PoVOOzSGFSsvstz8bh1x+8U5grApjaxpgSHZyT2b9M26Ug==;5:uzoMxAAafz/AFnrJlJ6tjKOO6J3dvPwYPzSdJQOc0+Xb9BBHB/txOdhW9XkdthXRkhtzfyYI0uoiKVrCGK8U9xnr7fpKunJsTxTxyJkxrQrn3UDLVTeQj3qK/e5B0rV0Re+D9huwMD4WaDfp1T2UFi9dBuPGgo6o8kVepBoMwHM=;7:6T9IkJobeW4hppNsnvAaF3QQVUE3hx3b6Jjvvh+DJHaUKpP+j24NwpD0tCvtvLyj8YexKjP0nB7xVbJe2YIC+JQ0IJE+KfuvFcelJqyJhADrGiAAZkjjbtWhXX8Z01axEGo0CYDdB1gVw6Jrh1mwsu4YxVIJ4Hqaa3D8SHv/pRXVD1HH+1T46cYwCDAIl2xYHFwU/kQCTFcTINlTfFOC557sOqxYkjOZq/YfxXaXVlMwnjg25ozQgpm8OYdmnhjB
x-ms-office365-filtering-correlation-id: 4a26e6e7-7411-41eb-2095-08d61aaafcdc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011731879D7FD971E01563CFFB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(14444005)(86362001)(256004)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(6666003)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7H6Cf+kMIaHyAQZ5QQgF8HXHHbODrfW/LroNEGnFw/rhAu69k3uh0tJnE7nbTXvxzGcAuCXI0hzg+lLdeWCFVALTGa28mZDtZV0Um81kvKWuwT4Uk/bLgcDB65yogXgpxWGikabXkwvAWpxAeqDn8rCSCTW73ddvOjRWT117Rg1C3Q6nGJ8tvZ2S2iiz8NBwPAfI0u8KovXbLxW+k0qBP+zi56s3kTMEYB6plFd3XfQvGV+e3A3tOKV6g9e8gbxlPn+4AVe1T2kgOfcCdZvVwbDNLnFSPH++3OUDigJp6VapHkO38GVaIuiRJ9epa23/L0cAvuqpFKrvBRGwnEwYwNXlmXliNxuAVWnjKqYTVHg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a26e6e7-7411-41eb-2095-08d61aaafcdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:50.2760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 3993e501bf853cce85c5114a704b86b8f486790c ]

Fix build warnings in DAC960.c when CONFIG_PROC_FS is not enabled
by marking the unused functions as __maybe_unused.

../drivers/block/DAC960.c:6429:12: warning: 'dac960_proc_show' defined but =
not used [-Wunused-function]
../drivers/block/DAC960.c:6449:12: warning: 'dac960_initial_status_proc_sho=
w' defined but not used [-Wunused-function]
../drivers/block/DAC960.c:6456:12: warning: 'dac960_current_status_proc_sho=
w' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/block/DAC960.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index f6518067aa7d..f99e5c883368 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -21,6 +21,7 @@
 #define DAC960_DriverDate			"21 Aug 2007"
=20
=20
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
@@ -6426,7 +6427,7 @@ static bool DAC960_V2_ExecuteUserCommand(DAC960_Contr=
oller_T *Controller,
   return true;
 }
=20
-static int dac960_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_proc_show(struct seq_file *m, void *v)
 {
   unsigned char *StatusMessage =3D "OK\n";
   int ControllerNumber;
@@ -6446,14 +6447,16 @@ static int dac960_proc_show(struct seq_file *m, voi=
d *v)
   return 0;
 }
=20
-static int dac960_initial_status_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_initial_status_proc_show(struct seq_file =
*m,
+							  void *v)
 {
 	DAC960_Controller_T *Controller =3D (DAC960_Controller_T *)m->private;
 	seq_printf(m, "%.*s", Controller->InitialStatusLength, Controller->Combin=
edStatusBuffer);
 	return 0;
 }
=20
-static int dac960_current_status_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_current_status_proc_show(struct seq_file =
*m,
+							  void *v)
 {
   DAC960_Controller_T *Controller =3D (DAC960_Controller_T *) m->private;
   unsigned char *StatusMessage =3D
--=20
2.17.1
