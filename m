Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488783-2-513931639614621241
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488783; b=v0okokPFsHG5cz8gM+v/a3DwjgjDyikDnX4OvoD2npp/hX1
    kCaZ0D3dCjVbQPdyq2v4cZGNMDD8IVTW3iNwvPw+PMT/7p2Sb4XJzyDiDFRh4hG8
    bfmAtnCO+tRUqAqAAzrWW2SJQbuXBW9BaMqSbJPlC7Mise6sYzl3Nr2DCPVKNaSk
    kZAK4yxrt0Wjca6m7m2P+l7b5t2/ehsHGfFPXvqhqjoCYLal3+vN0M3Vb7Qw1bfE
    ieNFOOTZZPlAe7rn1vLOxeCm15U0icYbw01QOxWLuNyJGBu2tKPH8EfC5qKWk7R9
    v0aD7GJm+JZqTlzWhKo3Va71noA5thFRZE5CIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488783; bh=Bu7ae5
    ODLyBm0KwynLYHZkc7iLJTGQmL9VVKLJIwetY=; b=EV3ndigXtReOSuSE56VMop
    t+m+1SQJ6nLzwIpRwx84zq5pKjpGZKPZv+mqgpKBA7b619fNRdTHPoHqrbowD5sc
    Yyp2sWIzQCxOUBc/2uA+mHmscYQl+AQK7dk1Y75EVF+aIaMAMipBuIUapwxpBlIv
    rLZpMd6LA9ZRcxjg48pjA9LrsiXNigr7xnkJDLFY7rgRCJ65XP8h4YIFpJtGwSwi
    B/SN1ltjOGRo3usB9ThW7RPN9AQR+WqnjeLw7zaHRbl/KtFKauc4XKAUMSsrFE/A
    FNIhJqravDb8Iu251glSoLkCYsnO40X3WM0OyCDAHNyt3OeBsmTlvlxBR77QYpPw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X778Ih7q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X778Ih7q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966022AbeCHF7S (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:59:18 -0500
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:16747
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965412AbeCHFDU (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 134/190] ACPI / power: Delay turning off
 unused power resources after suspend
Thread-Topic: [PATCH AUTOSEL for 4.9 134/190] ACPI / power: Delay turning off
 unused power resources after suspend
Thread-Index: AQHTtppKe1F/ssnEJE6qroIuV5xlCA==
Date: Thu, 8 Mar 2018 04:59:50 +0000
Message-ID: <20180308045810.8041-134-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:nYOYuAokI5Tk6yOl2ARYJVugMMd5SsocnwGZB/jHTvHDat+DS1ihS1EvU43saiAkI594eu+tVyMOm+Saf5/T8C20FK/AW/7/g2dllbtTopD30us1GbyVGxhyYbOPUuuZErcnJXNj/HSGNgQ+Fjz4pwiAiWn/mxy2o5qy6jN0q7ScWvq7XWuAjzmOlCDRFRzWKwXDzPJAmyUltpnJ55EjhZGhx0tiiSZlCHgq2bhuAcWcqLLGpaT1AqYr0CmN/lrv;20:GxQJNMcv8gc9Vc3vS3L6vUYdsYGJfMBmq8Q6ujOBNcu0rPPP3T3P5IpW5vCvaVz7Cr8MdZenJvcSrd/EBXSHLXq4bGUrB84HhJp5iFd/0RaMD8Hufxy2p5EkAthjVk1pIjxADqANAV4rMZUfYvJ92DgtGjhZ6NJWfJKHeUv8TBM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f2b03f3-9b9d-4789-125e-08d584b1e68c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101397F5F5FEAFC84D2CE918FBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(575784001)(8936002)(54906003)(15650500001)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Md2TPu6dRIRqqBWD5g1JThOsyse6tNtBLD5RQ9upsFWF5qidyDybVbIABvXaYIKy/ebGYG9ProScy+x/ZO7b7Em1gBxVokSL+CRaQmYV5jpv9AA6KMh+0ryb3yssNzOIof0cDoyN3tr2hcKQXMFS+1g9UtAbT5jQ5+aelOHSRGWCxzTCUZvDoBg4yhdMhf/86z81J8aaFZKFoNTF9SRcsm7A7dlKLaPDtfKD/tQ2sJbakXAJJ4zSEunRwyuTMEvM7JmhQzh0DG22qoARgcHFZRYcImxfAaV1Qe5y9TUJ10Fmn0URcC5zHo8V4P0xj8zLu4drEqlVq5J+U6pm5oMrWw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2b03f3-9b9d-4789-125e-08d584b1e68c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:50.7548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 8ece1d83346bcc431090d59a2184276192189cdd ]

Commit 660b1113e0f3 (ACPI / PM: Fix consistency check for power resources
during resume) introduced a check for ACPI power resources which have
been turned on by the BIOS during suspend and turns these back off again.

This is causing problems on a Dell Venue Pro 11 7130 (i5-4300Y) it causes
the following messages to show up in dmesg:

[  131.014605] ACPI: Waking up from system sleep state S3
[  131.150271] acpi LNXPOWER:07: Turning OFF
[  131.150323] acpi LNXPOWER:06: Turning OFF
[  131.150911] acpi LNXPOWER:00: Turning OFF
[  131.169014] ACPI : EC: interrupt unblocked
[  131.181811] xhci_hcd 0000:00:14.0: System wakeup disabled by ACPI
[  133.535728] pci_raw_set_power_state: 76 callbacks suppressed
[  133.535735] iwlwifi 0000:01:00.0: Refused to change power state,
               currently in D3
[  133.597672] PM: noirq resume of devices complete after 2428.891 msecs

Followed by a bunch of iwlwifi errors later on and the pcie device
dropping from the bus (acpiphp thinks it has been unplugged).

Disabling the turning off of unused power resources fixes this. Instead
of adding a quirk for this system, this commit fixes this by moving the
disabling of unused power resources to later in the resume sequence
when the iwlwifi card has been moved out of D3 so the ref_count for
its power resource no longer is 0.

This new behavior seems to match the intend of the original commit which
commit-msg says: "(... which means that no devices are going to need them
any time soon) and we should turn them off".

This also avoids power resources which we need when bringing devices out
of D3 from getting bounced off and then back on again.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/power.c | 10 ++++++++++
 drivers/acpi/sleep.c |  1 +
 drivers/acpi/sleep.h |  1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 1c2b846c5776..3a6c9b741b23 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -864,6 +864,16 @@ void acpi_resume_power_resources(void)
=20
 		mutex_unlock(&resource->resource_lock);
 	}
+
+	mutex_unlock(&power_resource_list_lock);
+}
+
+void acpi_turn_off_unused_power_resources(void)
+{
+	struct acpi_power_resource *resource;
+
+	mutex_lock(&power_resource_list_lock);
+
 	list_for_each_entry_reverse(resource, &acpi_power_resource_list, list_nod=
e) {
 		int result, state;
=20
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index a4327af676fe..097d630ab886 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -474,6 +474,7 @@ static void acpi_pm_start(u32 acpi_state)
  */
 static void acpi_pm_end(void)
 {
+	acpi_turn_off_unused_power_resources();
 	acpi_scan_lock_release();
 	/*
 	 * This is necessary in case acpi_pm_finish() is not called during a
diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
index a9cc34e663f9..a82ff74faf7a 100644
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -6,6 +6,7 @@ extern struct list_head acpi_wakeup_device_list;
 extern struct mutex acpi_device_lock;
=20
 extern void acpi_resume_power_resources(void);
+extern void acpi_turn_off_unused_power_resources(void);
=20
 static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
 {
--=20
2.14.1
