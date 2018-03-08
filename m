Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520485902-2-6339291574055268694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: AXB_X_FF_SEZ_S 3.299, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485901; b=ldZzMKh+pHAFIA0B+ULFhDTKxPOjglEHmSeiWwfa3TnpZjb
    HL1w4aYKb//jTY1t5Y/T9GVfaOZnKIqpEqzFu3NZxKd8MlDRVQaMP4pMrQzo0qY/
    SgINaSxPPSaELsElApVv6eit4VZEY3fhLDdpaMBpFfdgiorZ5acBa6w5LTVolCrZ
    yC4+Nvl6BYYEYHAme3U/kzD53XSXE4KKwhUSH74ADIZn3XJ7xOlEYsFNNI1N2QDv
    2DzFRf5MCovJZKFSdKR4jLJ/eptiNz+UDEmiTv68mMZfKA/fYvCbowF/diTWZmdW
    5CtvlMcfGH5RCKtrvADp2QySWbLwNGAOdJxV+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485901; bh=u81tfi
    ojRN0mbfMCsDOOcqlYmcSj/SARDrCFYW+XCdg=; b=MPPLy5AQKfRBqlpg38NWTN
    78y6amhcP34vPDVofR+F62ByCt9P4nw6auTMJF41N6Iv9EBwmTB3RrZLZjcgADqM
    kiiBr+cLIA8SyGPqcWvx87nXO5Rj9XbTYysslexXT59Myl3gTz6NgcUp6j3z972S
    fs+UM9YRAAhULkh8hgHLhpIOL99g5ADPHtTR8HTaJo6VYTeDI3QZm9Q+O4jVq5QQ
    MCEbrEvYF1pZ2nRZvuNvTHOPKQqhTNPvgK4nwlb6AbeKFShvoS9zBNW8JFyilIws
    ej9Zh0f7q1DF8NcNLHfj2ze3xX0Hc5ZZfAhSpmPwOfdKtO9tkIz2spGRwLWDRi2g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A3QWb7a1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A3QWb7a1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966845AbeCHFLh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:11:37 -0500
Received: from mail-dm3nam03hn0246.outbound.protection.outlook.com ([104.47.41.246]:27438
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966624AbeCHFLd (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:33 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robert Lippert <roblip@gmail.com>,
        Robert Lippert <rlippert@google.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 36/53] ipmi/watchdog: fix wdog hang on panic
 waiting for ipmi response
Thread-Topic: [PATCH AUTOSEL for 3.18 36/53] ipmi/watchdog: fix wdog hang on
 panic waiting for ipmi response
Thread-Index: AQHTtprIoLb1qgaxoku441qVMmDnnw==
Date: Thu, 8 Mar 2018 05:03:22 +0000
Message-ID: <20180308050230.8876-36-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:WMbHrlcmsPbRNfK6GWBlABM7X3jN6IQF7pghoMkUXlSPNGK4EswCSx6/H+sJEBcOec6RkGnLw5frFxgda1qx/c7xlKnHq75GL7opR+XzEI5aDZdwoH52plSI77v0PvRHOwWO3gRH+SlI+vJ8Z8cdfDykE6kYpi8gFgI9B1rOkcsOEZLAnlSYVBwweRx7K9CoqB0vX2ABaPdIekS8lxn0w0Bf0Ieiqq5pdwVkFz+GRAFAN2NwYumxMJBGBBazRhRe;20:Rkr2ldZl8F2+ZGPoVCaRhjnzpwttHuoNjP6YdrEkkqtUE3/kh+RzbfyTprjIX5LroBVsKgzLbW1gzphLTI8uhQHBe/Vj42BlJL+PhDIjZ7VwmHrAAnO5aqoFTQz8j4jkOPinxsNRCsWRY0ucD7XKD5isU2DIHYDQXc97XWKJNuA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53f526b3-6ea5-4071-0ccf-08d584b30e06
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112A14400DD8D0A6B4F49D0FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(39060400002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(69900200001);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 43io0QKywRLwwYlEchk4TGR8nxkquZFerKamaQ+Z0vHZu/vhJmViCwEQR4EWjczxNImz89v5NbFf4+54VmSnN9MnsYK+57Jznv7M82WlVShyVUqac5zDQ4NmZsYWfPo9xgyyVpEbs2ccP8GSbVK4e3eT6GdmK0qZYgVHzQgS93mtWXobqloIXVtJUp2Ke+UAtsTqZSuzZ3+6o4+Ld8a3hkmjjXJsUV/8CRjzsAYYciOhSL0VszdrYB9jAsNAYQYGGYCYCgF3RUzHrMOWS2qxbFpLTBeu6Bq2uUvuzRb9ySZxZTBvx+u3NRKBnFsWzw4HxpKGMzxuCLdAVq2MkNC2lcyny+e3Z6F3Ar8C/KfYWyrf4DKdZwqkc2Raow4Ag34sDPsWWyY4MiqKQtVcaNnSBQ==
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f526b3-6ea5-4071-0ccf-08d584b30e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:22.7903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
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
index f335fcee09af..0109d3fb5fbc 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -509,7 +509,7 @@ static void panic_halt_ipmi_heartbeat(void)
 	msg.cmd =3D IPMI_WDOG_RESET_TIMER;
 	msg.data =3D NULL;
 	msg.data_len =3D 0;
-	atomic_add(2, &panic_done_count);
+	atomic_add(1, &panic_done_count);
 	rv =3D ipmi_request_supply_msgs(watchdog_user,
 				      (struct ipmi_addr *) &addr,
 				      0,
@@ -519,7 +519,7 @@ static void panic_halt_ipmi_heartbeat(void)
 				      &panic_halt_heartbeat_recv_msg,
 				      1);
 	if (rv)
-		atomic_sub(2, &panic_done_count);
+		atomic_sub(1, &panic_done_count);
 }
=20
 static struct ipmi_smi_msg panic_halt_smi_msg =3D {
@@ -543,12 +543,12 @@ static void panic_halt_ipmi_set_timeout(void)
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
