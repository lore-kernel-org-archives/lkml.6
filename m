Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F49EECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A6B208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BCKV2k7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A6B208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbeIQI7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:59:00 -0400
Received: from mail-eopbgr710118.outbound.protection.outlook.com ([40.107.71.118]:45407
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729047AbeIQI0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVYrJz2b9bNBu2lOrDBl9969T7BJdPJ7f0+bbbk9ETs=;
 b=BCKV2k7/rdXLtqyB+usgIepJpirzXV9GQR3D9NX0al0C0wMo9AnHxr6jl7cKkkSUOkYrH0UaTOLNV/jdi+3EVNVolmHN/SiWFZlNW/HMM6qFPouqfgkxDHxSOgSZ7qXCqQ1V0OdhKpzTZTlAiRMT4oi6BW9D0RZQH1GJahOt6fA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 058/136] s390/sysinfo: add missing #ifdef
 CONFIG_PROC_FS
Thread-Topic: [PATCH AUTOSEL 4.18 058/136] s390/sysinfo: add missing #ifdef
 CONFIG_PROC_FS
Thread-Index: AQHUTjKi8ovP6WnZG02X0rNz7Bqn/Q==
Date:   Mon, 17 Sep 2018 03:00:48 +0000
Message-ID: <20180917030006.245495-58-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:B9POuocxRNi856Xd/GissNmjKpd15JkR7xOzqDnYVaND/9d2p6JkPm+qWRSti60wtEQWV227JLfZ1AWRJn50YjTfRe0CEhQxZ1Q2nVU5MyCTzqstYcjI7vTLUks+g9hrJEgANdK+yX6KCVNTbND8M2qv6t+MkU1QEae/M+pAqV/c3Q1VRxdZzoFVOEQAgpkYAOwoL/4jTg5Kv7bP3N/3CiNTRY/vZYX3TzOym8aEOeP+G5H7JGvh0A7HQub+T4CuP/o0xBrDL4RVRDOIjyB3AIbGlKCzhOHLjMsJKDM1ZYbOtTfGwnQjtKexhr5drLYALkFVS2Om0MYMbW7i/POb4szhH5mczTg6rXDpT/jFwvZBcs4pCsht93mQvsVgQ7mCQJClOBE7yHi1fhMie2OSh4VAOr1oecsMu5TjCk4KgC7A9BtU2jYlW4dARxDrkIK4HXDFYcaa5tZ5N2kMr/+Xow==;5:Nf4IxRrQunbwXdArh0cmr6E2aqdVgf0gIibwuumAnHMiuMJg8forkpg0YPgh6LxFDIbj9GsqDgrkDy9SPeef3gE+RRnrwKZGAzbDsME1rhUWP9TPnMJnafV8pMeej95M6P3kafX2HXXq1jkKnahZiUrD9xXMychUCb1FP2bTnk4=;7:TSnjKHk+9hG7bDsFIdqIljcJQI0y7Z/wWuES0Ce7TzCkfzodpGMiQdi41EEWXcR6eWK2oxWCR50gGimELdKavMt4xX+muAsTBVL4YRsWrH3O1DLX8PAd05WDOaavDEqODTK5GS8W9InWmY93H+A+Y2V/E/fZ1qzTn9g2jat7HpfOpyEtzWg8Z/pgpzwZlYov0PZR12iTu6o1kx1NwFHtVlTgK+Vax5iDxcS2dpsMJX39FSgOyp0vpC15hNbtb7nJ
x-ms-office365-filtering-correlation-id: 8f914683-df8c-4b85-c463-08d61c49d5ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167AE44C6C4604AEBCCF192FB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190383065149520)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(575784001)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ukGXsuA2d6tepeI9eaaatUUJbqwPm6L4NQpOYbI+2rbFrpNZzYGfFX1TXmsPtUdUzV/E+dMgjP3ZxKpSnIrcs+2FYFTMy9uOBAyrpE+oiYEVMuLBE7uCjo7+GR+9VmPGUuF1+khbEJshPyN1xnkYSfy+6XM9vgFY0WNdbYW1c7kfzJ1746dO8hy+in0FUp9QaQMvTBfAXCTrWsyQ5Nc3uvW7OuTtzwew5zM24Y3qI+B4pUWsQBZq5sE6REg7MKDvVVnD3hchlG4ByNV+jyjXXuwAJQceOx/brpodpciSykZb7+dTZ1rAxXwHAHrXAKXCFiMu5bJqyFd0PAtBOyVtT0Ebml7zc/p9HkQKcw0C8ig=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f914683-df8c-4b85-c463-08d61c49d5ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:48.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[ Upstream commit 9f35b818a2f90fb6cb291aa0c9f835d4f0974a9a ]

Get rid of this compile warning for !PROC_FS:

  CC      arch/s390/kernel/sysinfo.o
arch/s390/kernel/sysinfo.c:275:12: warning: 'sysinfo_show' defined but not =
used [-Wunused-function]
 static int sysinfo_show(struct seq_file *m, void *v)

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/kernel/sysinfo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index 54f5496913fa..12f80d1f0415 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -59,6 +59,8 @@ int stsi(void *sysinfo, int fc, int sel1, int sel2)
 }
 EXPORT_SYMBOL(stsi);
=20
+#ifdef CONFIG_PROC_FS
+
 static bool convert_ext_name(unsigned char encoding, char *name, size_t le=
n)
 {
 	switch (encoding) {
@@ -301,6 +303,8 @@ static int __init sysinfo_create_proc(void)
 }
 device_initcall(sysinfo_create_proc);
=20
+#endif /* CONFIG_PROC_FS */
+
 /*
  * Service levels interface.
  */
--=20
2.17.1
