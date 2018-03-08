Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520489155-2-3801195881044235536
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
    t=1520489154; b=HavvyGw6/L7lYCsFq4EQWr75bgNGQp3P7HXyMuBcdmWuAQJ
    xegCKw4PHuISyHVCpbQjoHJVZjGnv3i8Xw6xFPDJliftjuV8lEPAXN9LsVL8X9G+
    wUDhO04oGTm+hAUBtLXlvaFW89wb66hC2nSPmThbLt+/P3FpDXQXT20CEDKWy9nM
    COVPdyx2xfwCw1R27AEvhTM4CdypTJlAUX401A5b6ZXx2/Ew2Nka98Xb/B1AxykL
    eYKxw9ZSZCZ7UScGhKXwvAybvQ0zrlBlKM1TkUoTc4Gw571lfJP7lkR4fasJ5mgl
    8LYFEUd1popqtORQo+L8t5/k/mlF2fcSSOnU4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489154; bh=zvfX6m
    XHN4WqFFpfpVAIFCVQt+ChjRbDazLZcXFfpic=; b=fFwN5pYiRXYbXacxtWeG9j
    IXihobpPPBkPOMj3B+v5dPV5vEjt0XCjKBKZ+orjMi1gcZpiK2GJqm4yiEQs838U
    zuAo9IZ3v2SL9w7ceCZGKwpoXACR1ux6ioMy0qE71ZpoRENUinENgkMcJm/sMEDo
    FVr94s2uldeWLgXta/r/wb97BdZvQDzWAQpoyVXiyNJRrR1/9OWQeeyc08hdCnr2
    jiVS5P0k0NSEmpNIdsQ3PbISivWj6XBByW5CyhQY5YZvsHLMv54e6FM/o3L8U8yu
    9XfD53natMpT5dYULrHj4BOndR8lFO8s1So1zUkfDJ2hPfHb+yCzz5dn+6VxQH/Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N04jKoHg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N04jKoHg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935211AbeCHGFX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:05:23 -0500
Received: from mail-by2nam03hn0237.outbound.protection.outlook.com ([104.47.42.237]:45201
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965837AbeCHFCU (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robert Lippert <roblip@gmail.com>,
        Robert Lippert <rlippert@google.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 115/190] ipmi/watchdog: fix wdog hang on panic
 waiting for ipmi response
Thread-Topic: [PATCH AUTOSEL for 4.9 115/190] ipmi/watchdog: fix wdog hang on
 panic waiting for ipmi response
Thread-Index: AQHTtppFhQu5Us1XT0qxao1MFDrSfQ==
Date: Thu, 8 Mar 2018 04:59:42 +0000
Message-ID: <20180308045810.8041-115-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:Ru+MesoGnPIszccZ9jqc0w6G7L1xgkaeC//9lseFLBCakZ33qgl90/rkrfU6BooRCE1BME8sLxqfQSspzxM/KwMlUeNmZLVdsoFXRoivhrpfOcgx/6LV0X1qio8t/N6Nv85t1B8w5y7MgPjR1BpyRqKgA2Zs+ogSR/ce7rRkoAmDhgJB1nwdqSB+LIGvotqmfFCdyTk1F2DzIR46c0ddI4n+QnWCgzexSoxMxUyzuLroLu46/KgNjw8eYBgtb/Mr;20:zJgH1t/FvE0Gjle50JIACG+I/hYiEiLXXkWlwJeKqF+0jy7xTnhVT/AQq6dTfBwQyI39L8JPU0EBN/nxtQTTlfgffXvEU37nD3A7EQkbe5VIb4s/95tm0Sy9rN5plml5VgeevAWaGnPDCZ1RbfjDCqpbiQxjuE/kvAl/Iun1blo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d13a1ae0-600d-4378-b656-08d584b1c429
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0997C7F2405B39A136771760FBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(39060400002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(6436002)(22906009)(69900200001);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: KGZK7Dv6v2ITpZciWRPFwqsigesA51BY4qWiyL8ArMmCLIKSh9fWQ8b3ctdzlPeWTYbavMdcGWXSXhH4HBAI+Pp96LTf392pyVHb0VRqKE+QMaNXd3rhHwfca/Uvq/d0U4wNCF8q2nCHTFoaEHMp5mrixUtQnjHKZpqGbPbWYwcw2fGcynk9bQ4/HXWcIiD65bha33bYJ0PSN/qDX+ct7R2ko6k770Ow3fgtoe1l9BBMrPFuirkwQl0Siu4SimfLj3IWF2twDOvzlBw6DEMYGYdR5FJ8oY+NRczvhvMXrx2gJkPSnTrhnu5/gvRlo2Kmj5ilN8jdPi0z0rH+LzTKfCfBbHirhweQpGFsXL4bgVNChd6iZhILkmRhZD+u0PP0yS5+Gf3PBupEn+CuI2IcVw==
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13a1ae0-600d-4378-b656-08d584b1c429
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:42.5530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
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
index 909311016108..055d2ce378a7 100644
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
