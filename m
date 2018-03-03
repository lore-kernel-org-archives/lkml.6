Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117589-2-17310285287982158703
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117589; b=YjLFLebmZ8YjoVRJ7LNmUPjLy4akeDnS2RgpWGe+SIYgba1
    pjvUVpCarhceebuiHUgLHhlP0OIaHC5qJt/7AzkFenAimgJlX1Ie6xIQBdWlJcCM
    gygGvYFyP7OCMY62NxkKWMOEzGOA9TWqZvQXrXluYqvfT/DY7WGJCqDJtbZ+agU0
    8MN+zucc0zFlDwFzrDv5qui5I//GLCyh7aX/dkzy1vVJheHFagHDEMsMcSoAE/Th
    UliEtKnt6EW7Op3MY57MYIlLMF5oIHu2sXWjByLysWlsGDx8euLlNLxPp/5r+BlD
    hKM1GioQMCnRfqvBbc5A4+pePolzojPO0UFImlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117589; bh=HdqEHr
    MI07CyFMHizFxC6wKtf6exbnsrfNioj9tZyOc=; b=W5RzIeqjypu7LP0mKUWqV9
    kcQauzHyRnKodgFwOixmy2oXti4DYwsfds8GU5h8GzxmmJFk7UmRrJj4xTGqFYPP
    x2EPWnp+Gt1tsXFT7XiGcVlCjJUsGKY2Hl/aZ5YBQ1fV0AtVKp5ujr9uvI/1S+Ly
    BiEWwpIzpLlT4edguKXwWOVs9jWpWWTh4UPlbBDw2/LNy/vXmiYfWZJF0Ti1sW/5
    r47tLZkhBiJzq5yyuTtYGHfWNtim1b53eCPHUJqCLlC0BRxjbVhTNuFF9mj+Gabc
    egEDvU4jf8PwiknGAb+ub9zGWmYaBW40Taocnv5N5UM+7qHLxh8IeUnLBNcK9zuw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mZ6ixTyF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mZ6ixTyF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933806AbeCCWwW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:52:22 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:48488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935434AbeCCWlJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
        "Guilherme G . Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 21/63] powerpc/xmon: Fix an unexpected xmon
 on/off state change
Thread-Topic: [PATCH AUTOSEL for 3.18 21/63] powerpc/xmon: Fix an unexpected
 xmon on/off state change
Thread-Index: AQHTsz+iIPOrfcYsOUaUoaqMqo1oMw==
Date: Sat, 3 Mar 2018 22:33:22 +0000
Message-ID: <20180303223228.27323-21-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;6:1wAFAU0ojQ4JHAAKLJ4h58P447oSuzhJxN2W4qVyaaX9vLANDyyBHM8rbatR7qq9byjsvSIlRUTxfEo0Bw3lBGBDwF2GxyHzLii0wEdPGAKdIVdejvF5DbKMQvS5sEUa2+IQxZMni75lVqE2FXyAri0BlJbH+eVjLwpu0CxRW6zumAJBS+iBnNGeZHciFb0iFXPA5DtPjwvoci92abTXbs0A7WwWlKQihZ2MQDC0nx/3LkSn8vCGqWm+pOwrG9WrTvTkjHmMN42cx2iejNMcICaDfHg9w/bBJAeJveKOYP+lEB8pDYoWnDKgVqUbnpvoxre73TAC2Z/GFZCXaaG0w4Si+95R0dfn5ivz9YaLJGV9B8fqOq4ozit1hlKoRohT;5:uqsaC0dkPcXV9jG5EZ4tUoymDvoc5tfQdxpUy9jHgiqPz12Ch+Uc7pP+T86eQilib1cM5OL8znw32q9nLCcHkwabpnVawf19T7sK+yXFlLtaGrJbLhQqxTQeOJNuenFpITGkKL4/F85jKBzL+FYHsTxfrzDxaIVsuci9aEbBLn8=;24:yrgiOqgRh2qvsqtorusKoPK3jkemiQwA4CIvwUNTfy+VLM638RoY6b2UfOR3lDPHFoaWzOrAjB8oBgdGvFIH+iV+ML/P4UeBCXxrZ0DvmOc=;7:ekNjrF8OGhxFol3BHbIzu/VSArqF9uc+eSuXesFilGZrYo/AC0gQYogWpU26+HS6Fijk0+B+/mOvK9xp5vsCUTUsXD9DYFeCu7cRUx6aV2KuOuo9R3uJk519mTkTuU97IQpp4St9Y/3RbnAqmQGRTGcy/FtTyAo3eL6eCYhJZyAlWqz4T5N41NombXKzCvp7MP25NjAz39z2AmEXijWU4GXERL/Jzyw1XCWzlh7UETiFYmL6A1VN6lcQEpJFm1Ph
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f053f46-1e93-494b-a54c-08d58157da13
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0940D4F7245CCB43DCE74A5FFBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(2900100001)(316002)(97736004)(59450400001)(102836004)(53936002)(6506007)(3280700002)(26005)(4326008)(5250100002)(305945005)(2501003)(76176011)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: A3aUIsQNig5GAAndZap84n+X7Aa/nvojLKTehjBwBpINlapzetjpr0rzbk1Ldwzvj0kttDNfNifx4oauu4p6PQfiGNB6x8QTXKrHoA2g1zS8o3XnhhZFNFM6xvDbvKq7VdvGQLI1bG5JrTh/Cdv4HeO81W8jAwNXTePdqEEzP7o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f053f46-1e93-494b-a54c-08d58157da13
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:22.0910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

[ Upstream commit 3b5bf42b81d56085fd58692b5117f69aa77fdff7 ]

Once xmon is triggered by sysrq-x, it is enabled always afterwards even
if it is disabled during boot. This will cause a system reset interrupt
fail to dump. So keep xmon in its original state after exit.

We have several ways to set xmon on or off.
1) by a build config CONFIG_XMON_DEFAULT.
2) by a boot cmdline with xmon or xmon=3Dearly or xmon=3Don to enable xmon
and xmon=3Doff to disable xmon. This value will override that in step 1.
3) by a debugfs interface, as proposed in this patchset.
And this value can override those in step 1 and 2.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/xmon/xmon.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e23f559faa47..7d5464524324 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -64,6 +64,7 @@ static int xmon_gate;
 #endif /* CONFIG_SMP */
=20
 static unsigned long in_xmon __read_mostly =3D 0;
+static int xmon_on =3D IS_ENABLED(CONFIG_XMON_DEFAULT);
=20
 static unsigned long adrs;
 static int size =3D 1;
@@ -2938,6 +2939,8 @@ static void sysrq_handle_xmon(int key)
 	/* ensure xmon is enabled */
 	xmon_init(1);
 	debugger(get_irq_regs());
+	if (!xmon_on)
+		xmon_init(0);
 }
=20
 static struct sysrq_key_op sysrq_xmon_op =3D {
@@ -2954,7 +2957,7 @@ static int __init setup_xmon_sysrq(void)
 __initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
=20
-static int __initdata xmon_early, xmon_off;
+static int __initdata xmon_early;
=20
 static int __init early_parse_xmon(char *p)
 {
@@ -2962,10 +2965,12 @@ static int __init early_parse_xmon(char *p)
 		/* just "xmon" is equivalent to "xmon=3Dearly" */
 		xmon_init(1);
 		xmon_early =3D 1;
-	} else if (strncmp(p, "on", 2) =3D=3D 0)
+		xmon_on =3D 1;
+	} else if (strncmp(p, "on", 2) =3D=3D 0) {
 		xmon_init(1);
-	else if (strncmp(p, "off", 3) =3D=3D 0)
-		xmon_off =3D 1;
+		xmon_on =3D 1;
+	} else if (strncmp(p, "off", 3) =3D=3D 0)
+		xmon_on =3D 0;
 	else if (strncmp(p, "nobt", 4) =3D=3D 0)
 		xmon_no_auto_backtrace =3D 1;
 	else
@@ -2977,10 +2982,8 @@ early_param("xmon", early_parse_xmon);
=20
 void __init xmon_setup(void)
 {
-#ifdef CONFIG_XMON_DEFAULT
-	if (!xmon_off)
+	if (xmon_on)
 		xmon_init(1);
-#endif
 	if (xmon_early)
 		debugger(NULL);
 }
--=20
2.14.1
