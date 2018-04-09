Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236138-2-5065915498268061221
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236137; b=Z5VWBMidLUqrUCN/dqfECJVy1NNeyDfLk6NuyYX+iAZ/XnM973
    uvJFQd4U3DmSXTMkDIjHgQ/WBiKUyW8uxzHOmrhrqfT6siGhzFhxmE9AtPZcR8KY
    aaDUjbqtPJWCZodxi79YZyOzsLNN47fjc/lL18zgIbK/mbAwwl60zNn4NJfqsBQW
    w3fc0atG8TArCiasQdgidsH+YPDOXr3OFSh74NsoiimH5FRgVRHaCawUTrUsbGWA
    A8HF61Eg0kal4zVjmXpIqisEWvnz51ult3JcUgfxZ7x+84DJ7fUovGz+bQNCM5dm
    WqceE4mz7rowpLzagiENGmZG6M/Uf0ExW5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236137; bh=9HV2iZBWj6
    E1ylI5j6nRPtv+mYDlX3QDXFPV2QOG3t8=; b=DpGef14/RhmdZXY+Uh0Di9Cgk2
    jpoMnpHgjNaXnuYP5XTew7fss4dzzhRmlBJqFB1dCasuZ7Vm+fcwcRwwqj/deu67
    xQp1jIpVjLDmWN/lzXXllBGv34IjSQTfFgZVWx3a6h8Q0X4env9Wh3Mk5YK+P+sM
    XmA2ubOue7XCyZMvndHfTM2AYGAdt1zqST3JwiMkaMV3UbT2UHjWrQLfbiEw1pKv
    +uoGZ8e3DriDUd4Qos2fm26/vR71IYuTMUlX1wF+Dr8jD0ZRvd56YsWaobMQTCZr
    ctr3pbhGC3/Urqe2xTJx4LA8AIErQ6O/dWL502O1EqeXMgcxvCvX71Hn8ViQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mE4XvoOj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mE4XvoOj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDzqOY+glQqAzMce2Au7UEsWgQ5EdeJpK0Hkvlu2jr4XCbRZsGys8dhjAqb9rP728/uyPs/Nr0q7ZlubrVQG+qbxD9ewG0OSuMsbiC82r74jJYd1zYRM
    9MNM5yhQAgUJmwq3G4HycIUPgCa/U6BJAbVK0Y4nKHsK+zKoDYNjQvZytkYa+jOGM8ZsCCdnw/PnkTy+aMWYZ87ChdrGQbwH6aHG3jfkzuRfimBGjkg5SlIt
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=aatUQebYAAAA:8 a=yMhMjlubAAAA:8
    a=rS5lPRv06gChZfWWlYwA:9 a=F7Qrd-wfcsPwYhqx:21 a=Mu6ixeP5tSG2d3gO:21
    a=wPNLvfGTeEIA:10 a=7715FyvI7WU-l6oqrZBK:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752954AbeDIBIu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:08:50 -0400
Received: from mail-co1nam03on0120.outbound.protection.outlook.com ([104.47.40.120]:40064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933032AbeDIAit (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chen Yu <yu.c.chen@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 146/162] ACPI: processor_perflib: Do not send
 _PPC change notification if not ready
Thread-Topic: [PATCH AUTOSEL for 4.4 146/162] ACPI: processor_perflib: Do not
 send _PPC change notification if not ready
Thread-Index: AQHTz5nauTe2yHiHFE6Alg3U3svSCw==
Date: Mon, 9 Apr 2018 00:29:43 +0000
Message-ID: <20180409002738.163941-146-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:y8Iz/I4F2Cs/qvN2yYjpamqlUMQN8HpkvsigAoE21L3I03SiHLB6KRC5ZLHhnruO+0PKm0DYTnI7zAsTg5d9KIUldwaP6y2HTLdqZ/KdpKbD5/aS977llxgvIQPuoNeB3K6WmQMkeHhrhjU/XgiDDrS9KN3t0EQqHcbBdPbrByfxS2DpXGCpBrjWIkYNgn78oWuJysKgwBbvk/Ixb86PtNlng0YOHoO3AvaWnag+aZX89QcTlZDIuxkt3QCrq3C6;20:q8fDGjpZk+tAdi7NvDNPUbKcO62+iSStH3ZQayIgjDJMow65btKmGgkRAEwGcTR9UIvWjIH6wSk9ari1fAb4c0ihzY10nPke+p0Gf5SGdLuBIwuW5c8VmVnDq086aRdHaLlq8XU++1/nNEkP8ThaZmZxul0m2zTo5moHDsk0CDE=
X-MS-Office365-Filtering-Correlation-Id: 0b18e119-0dca-4da7-53a4-08d59db24091
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125953B4AF51A78181BBD92FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(228905959029699)(54914632383503);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(15650500001)(3280700002)(10290500003)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(59450400001)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Exe4Y8Gt68DOmoeq0gDbwBbS+ghUe6yi+iTzKozq3jvaovgyhfoxb+A6zccWW3Zdq8CxddBHXR5+ZMfnxw8BZ8q2BycAengWXDwXFBRO+KkvCxzU3Xy5ZWj/xp+9mSqZBUAwBjQFP9Zr1gRXFXwWj7MzmVI+AcY29lsDTco28PEo3FpftYjqsCJ1bQubsScHeEzCLR16T1jlsSzGTZ4OmXh4VA4Ia05MFeMLLBQRFc4psL3Vto6h2wnzXd3bzGZx8gEE0sHLJD0qm84tjGCNKSolBHo6BlwBCcmwcN0Q6cOQhtp7Rc3SXXmST9i49EA2XPmJMPUMQpyx4gVWZSYCp/HrYbAM+qDwT99aO5HK85HYzLa8VnH6UA2e5CkiTwvOyXTKnyRFg5IyGSYgTBz5Of0HzhRjmriOS9tuTb0AaZQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b18e119-0dca-4da7-53a4-08d59db24091
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:43.7401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chen Yu <yu.c.chen@intel.com>

[ Upstream commit ba1edb9a5125a617d612f98eead14b9b84e75c3a ]

The following warning was triggered after resumed from S3 -
if all the nonboot CPUs were put offline before suspend:

[ 1840.329515] unchecked MSR access error: RDMSR from 0x771 at rIP: 0xfffff=
fff86061e3a (native_read_msr+0xa/0x30)
[ 1840.329516] Call Trace:
[ 1840.329521]  __rdmsr_on_cpu+0x33/0x50
[ 1840.329525]  generic_exec_single+0x81/0xb0
[ 1840.329527]  smp_call_function_single+0xd2/0x100
[ 1840.329530]  ? acpi_ds_result_pop+0xdd/0xf2
[ 1840.329532]  ? acpi_ds_create_operand+0x215/0x23c
[ 1840.329534]  rdmsrl_on_cpu+0x57/0x80
[ 1840.329536]  ? cpumask_next+0x1b/0x20
[ 1840.329538]  ? rdmsrl_on_cpu+0x57/0x80
[ 1840.329541]  intel_pstate_update_perf_limits+0xf3/0x220
[ 1840.329544]  ? notifier_call_chain+0x4a/0x70
[ 1840.329546]  intel_pstate_set_policy+0x4e/0x150
[ 1840.329548]  cpufreq_set_policy+0xcd/0x2f0
[ 1840.329550]  cpufreq_update_policy+0xb2/0x130
[ 1840.329552]  ? cpufreq_update_policy+0x130/0x130
[ 1840.329556]  acpi_processor_ppc_has_changed+0x65/0x80
[ 1840.329558]  acpi_processor_notify+0x80/0x100
[ 1840.329561]  acpi_ev_notify_dispatch+0x44/0x5c
[ 1840.329563]  acpi_os_execute_deferred+0x14/0x20
[ 1840.329565]  process_one_work+0x193/0x3c0
[ 1840.329567]  worker_thread+0x35/0x3b0
[ 1840.329569]  kthread+0x125/0x140
[ 1840.329571]  ? process_one_work+0x3c0/0x3c0
[ 1840.329572]  ? kthread_park+0x60/0x60
[ 1840.329575]  ? do_syscall_64+0x67/0x180
[ 1840.329577]  ret_from_fork+0x25/0x30
[ 1840.329585] unchecked MSR access error: WRMSR to 0x774 (tried to write 0=
x0000000000000000) at rIP: 0xffffffff86061f78 (native_write_msr+0x8/0x30)
[ 1840.329586] Call Trace:
[ 1840.329587]  __wrmsr_on_cpu+0x37/0x40
[ 1840.329589]  generic_exec_single+0x81/0xb0
[ 1840.329592]  smp_call_function_single+0xd2/0x100
[ 1840.329594]  ? acpi_ds_create_operand+0x215/0x23c
[ 1840.329595]  ? cpumask_next+0x1b/0x20
[ 1840.329597]  wrmsrl_on_cpu+0x57/0x70
[ 1840.329598]  ? rdmsrl_on_cpu+0x57/0x80
[ 1840.329599]  ? wrmsrl_on_cpu+0x57/0x70
[ 1840.329602]  intel_pstate_hwp_set+0xd3/0x150
[ 1840.329604]  intel_pstate_set_policy+0x119/0x150
[ 1840.329606]  cpufreq_set_policy+0xcd/0x2f0
[ 1840.329607]  cpufreq_update_policy+0xb2/0x130
[ 1840.329610]  ? cpufreq_update_policy+0x130/0x130
[ 1840.329613]  acpi_processor_ppc_has_changed+0x65/0x80
[ 1840.329615]  acpi_processor_notify+0x80/0x100
[ 1840.329617]  acpi_ev_notify_dispatch+0x44/0x5c
[ 1840.329619]  acpi_os_execute_deferred+0x14/0x20
[ 1840.329620]  process_one_work+0x193/0x3c0
[ 1840.329622]  worker_thread+0x35/0x3b0
[ 1840.329624]  kthread+0x125/0x140
[ 1840.329625]  ? process_one_work+0x3c0/0x3c0
[ 1840.329626]  ? kthread_park+0x60/0x60
[ 1840.329628]  ? do_syscall_64+0x67/0x180
[ 1840.329631]  ret_from_fork+0x25/0x30

This is because if there's only one online CPU, the MSR_PM_ENABLE
(package wide)can not be enabled after resumed, due to
intel_pstate_hwp_enable() will only be invoked on AP's online
process after resumed - if there's no AP online, the HWP remains
disabled after resumed (BIOS has disabled it in S3). Then if
there comes a _PPC change notification which touches HWP register
during this stage, the warning is triggered.

Since we don't call acpi_processor_register_performance() when
HWP is enabled, the pr->performance will be NULL. When this is
NULL we don't need to do _PPC change notification.

Reported-by: Doug Smythies <dsmythies@telus.net>
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Yu Chen <yu.c.chen@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/processor_perflib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perf=
lib.c
index bb01dea39fdc..9825780a1cd2 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -161,7 +161,7 @@ int acpi_processor_ppc_has_changed(struct acpi_processo=
r *pr, int event_flag)
 {
 	int ret;
=20
-	if (ignore_ppc) {
+	if (ignore_ppc || !pr->performance) {
 		/*
 		 * Only when it is notification event, the _OST object
 		 * will be evaluated. Otherwise it is skipped.
--=20
2.15.1
