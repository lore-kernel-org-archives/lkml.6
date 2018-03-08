Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487062-2-6815803724898519727
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: AXB_X_FF_SEZ_S 3.299, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487062; b=dKuipGETvAdLbir++rGUwAQyFMGZqKEriZVZ6RucrFvDuMG
    CVsPoljT/VgSNZEzhiPB2LUGMHCcgSw7m4XdcvmsOL2XgSpN0ZoSR2ZalS81dj6s
    AGDbjJDt05z85s29R/9IaiWpDdBcoFHwc0rrwVSiK6pnMcQ/U4IwUfanLlTrG5rP
    QuAopk3wOsDqqVaYdzMPh0VAGq3Ix5McfnuVB0JFJxEww76bSmHZLfBP6nQoUUcX
    aaY2owr5FqygxQ/v3pWVAZRSISOBWV+CsOn5u88zVAD9ej2L4orfm0IPr8Cs1Zac
    A4fc/ZY9GnzAwLBJSqKNYeiMqbGTjCVC0UbJfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487062; bh=3Crdj5
    Elh8xnHF752tiCeTQ7mt+o137LkzraYkgbHjI=; b=rR6IyYvVf5MupJ43Bfem+k
    sZjD1cH+ShWwckPK7zspYmHugj5avmKEgZSFB7unZnuDkqwSWTPKaMzrAW0FW866
    4FP5+KV+5jD/bY6MUsJ1qRDh50ml7BwVdDgruEdNTm7upu46EUcP65tDu3dDWkcZ
    9Qzc0x7qsfj2T/XCBPTkC8FZGws+ntAH/EWTtuORHEWsdsxMFqNMMLZlpUQlW1rx
    IDjnPsNT/4McwCk8n7oAkH7VssnqQJSWlT20wBKFwpKnKzaWq98J0TZXe19NwSFl
    kQbw054aNgCOjdpRY8M/TwRSbssF0lq8i9dGXV2URNBmL4wDKhqqn+ER5yCXYilQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UqyOmkWv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UqyOmkWv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755397AbeCHFGx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:06:53 -0500
Received: from mail-cys01nam02hn0204.outbound.protection.outlook.com ([104.47.37.204]:8367
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755361AbeCHFGv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robert Lippert <roblip@gmail.com>,
        Robert Lippert <rlippert@google.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 062/101] ipmi/watchdog: fix wdog hang on panic
 waiting for ipmi response
Thread-Topic: [PATCH AUTOSEL for 4.4 062/101] ipmi/watchdog: fix wdog hang on
 panic waiting for ipmi response
Thread-Index: AQHTtpqVW5VRyuoblU6lwfFQ1ekhKA==
Date: Thu, 8 Mar 2018 05:01:57 +0000
Message-ID: <20180308050023.8548-62-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;7:/1q0btKWtjJBs/oUssSCzV0g6M1hVcyxCrsIoJXJfsv5fvaXUfZqey3W8SAtoR/VlWnKZK9NnMhLEAOvlQNHPJEj8M3GS59aLTDCPFskFQ2E1bBvevbbv/QBEZRQmdnHlUNjYfwirn+Xy6oCB+v/maFSuIl89via7xy8ebfhxqnZE9qZxaZybKHpO27TY+6BbuB//xpxoR9KDv1zL4dxe0f8OoAhtc3Q5wJrgGhd2/TgEuc3OYnUsrWyZR1HVwCE;20:odiMuKZgmy2y68I8vcukVbsAKh7tKptmFOuMYZrEXMl6/4zVSnfmY0LVAAJHhG80g4DN53prhq+cmRKtF7sgPj8RVL8gmca3auCIXkQ/7PCESwV715luKbrtvGY88NZdrU+43/nRrOBQ/ndX0qoKOU13KeMs0zrZ3WMWh77KpeY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62690f15-69e3-4bd5-9bbf-08d584b26531
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10162A6F39F868D7CB692ED2FBDF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(3660700001)(10290500003)(14454004)(25786009)(478600001)(53936002)(5660300001)(6436002)(6486002)(68736007)(39060400002)(110136005)(54906003)(316002)(6512007)(105586002)(22452003)(3280700002)(2900100001)(3846002)(6116002)(72206003)(4326008)(2906002)(59450400001)(6506007)(102836004)(86612001)(1076002)(36756003)(76176011)(26005)(186003)(107886003)(6666003)(2950100002)(7736002)(97736004)(8676002)(99286004)(5250100002)(8936002)(81166006)(81156014)(86362001)(305945005)(2501003)(66066001)(106356001)(10090500001)(22906009)(69900200001);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Cuw3gSadkXwqfXK78GSG+X9E60TMHgyNGV9ZmQjpp2oZ74xoYvc2weNn/FVi5a3k6CBAa6iu0PiMCQfQdphU3om/9u3sq6d8mIJeGrrg7fIqAVq6NMhcUTpNGj7We0sKsxk7EuPQ7bdAMZv0pm4B7hnqNeuK+NBv6nkvjWdaU3kUFbOQVN7/jrkX7lVgGjzr6OAVjy6ud+NaqC7X2T1OU4Z46k5PdvG/5Vzqi0+oeSGA4BC/zjmWg1J9UoPD4JB1LAJdWcUTputx7cJHq47BtE7ngwo/9jRU7iY2f9jUA5S8co2JpvTkPd6MSBNlRzaH6684la8ExDZrAY1IaRFU14mwbioj98/4clxoaE5m2uuXnuWeeCfE24hY7tNHKOqNEjhug+5H8exkYMOl5o80Fg==
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62690f15-69e3-4bd5-9bbf-08d584b26531
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:57.6896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Robert Lippert <roblip@gmail.com>

[ Upstream commit 2c1175c2e8e5487233cabde358a19577562ac83e ]

Commit c49c097610fe ("ipmi: Don't call receive handler in the
panic context") means that the panic_recv_free is not called during a
panic and the atomic count does not drop to 0.

Fix this by only expecting one decrement of the atomic variable
which comes from panic_smi_free.

Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/ipmi/ipmi_watchdog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_wat=
chdog.c
index 40d400fe5bb7..4ada103945f0 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -515,7 +515,7 @@ static void panic_halt_ipmi_heartbeat(void)
 	msg.cmd =3D IPMI_WDOG_RESET_TIMER;
 	msg.data =3D NULL;
 	msg.data_len =3D 0;
-	atomic_add(2, &panic_done_count);
+	atomic_add(1, &panic_done_count);
 	rv =3D ipmi_request_supply_msgs(watchdog_user,
 				      (struct ipmi_addr *) &addr,
 				      0,
@@ -525,7 +525,7 @@ static void panic_halt_ipmi_heartbeat(void)
 				      &panic_halt_heartbeat_recv_msg,
 				      1);
 	if (rv)
-		atomic_sub(2, &panic_done_count);
+		atomic_sub(1, &panic_done_count);
 }
=20
 static struct ipmi_smi_msg panic_halt_smi_msg =3D {
@@ -549,12 +549,12 @@ static void panic_halt_ipmi_set_timeout(void)
 	/* Wait for the messages to be free. */
 	while (atomic_read(&panic_done_count) !=3D 0)
 		ipmi_poll_interface(watchdog_user);
-	atomic_add(2, &panic_done_count);
+	atomic_add(1, &panic_done_count);
 	rv =3D i_ipmi_set_timeout(&panic_halt_smi_msg,
 				&panic_halt_recv_msg,
 				&send_heartbeat_now);
 	if (rv) {
-		atomic_sub(2, &panic_done_count);
+		atomic_sub(1, &panic_done_count);
 		printk(KERN_WARNING PFX
 		       "Unable to extend the watchdog timeout.");
 	} else {
--=20
2.14.1
