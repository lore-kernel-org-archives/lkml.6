Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121213-2-7412839049383322554
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
    t=1520121213; b=H6qGiSHIzGXymRunwk/yJiB1dMPKM7jNeC4DHo1eRmz1Vx5
    k67w1gYdpj1sHpdiVTa1wLfqh7UVoTtEhQdTDx3dyM5225uyXHF+0PIcSslRpw7+
    WBaElBKR8TJCw8tO3NEgQWlP9VnZ5J7EPgWCK1cz1Cn+/99GZUOnz9iknmFqK43W
    nNolHNrQrnyaZGZCbvN1K152gG0t0sfbq7RdMZs2NJOf3xhVFwkdMV4L4fbsNtif
    vGOJifGQ2xakA/82ENwHRZXf3Iyp3uPpk3p/tHIDj/vkQoeTkKpwXcuapLdgh+qf
    NaiT/k8wiqpzUfw5jN1dkdDYrMdFBE92bVglWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121213; bh=jDfkD7
    mDJnpJCGXPU+mlshed3lAiTziPkrIrZ50o/4Q=; b=wl488YeZ2ocoeIHa6uGwLE
    aLG8pE1QyC1igkmfeD/3Xp4VVHQ1p0XiFcYVWLZOTKdoqBDtu3vuzb2c2my82+ga
    FVcWtqSYf3rj37aW7NioOdzOXur2mFnGXr9WFa6vryJOUqQTllZB+nggPL2BRZav
    Hh+vx/5TZsQsZiAB1jaMvBa7/yOh0QQsQc4/O7UtY4oylZnR1TvJLj5PsJKvVfDm
    w4nATOhAt3Z4WzYO1ol0lLxkxnH6iSf+gml0ULjg/M22pcyPHQV8G0NErLOkZu2r
    ToU8qh6jQ8JTaOxPcN+AD22eaWrGeYY+pQivUAhkPzmVvcRWAFgUK6QwbvOQHZwQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mqBfmToQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mqBfmToQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeCCXx3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:53:29 -0500
Received: from mail-by2nam01on0092.outbound.protection.outlook.com ([104.47.34.92]:32992
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932419AbeCCWc7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
        "Guilherme G . Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 073/219] powerpc/xmon: Fix an unexpected xmon
 on/off state change
Thread-Topic: [PATCH AUTOSEL for 4.9 073/219] powerpc/xmon: Fix an unexpected
 xmon on/off state change
Thread-Index: AQHTsz75CoISJE7/yUKW1CHc8PSZaA==
Date: Sat, 3 Mar 2018 22:28:38 +0000
Message-ID: <20180303222716.26640-73-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:V+bR9NyuDjz5lGK1Z9aoJUtnQF4eQSdkaXXnDeC2UliLE4G+hU6Ou0C3/Rr/Q/I/AFbhnpq8C9n/hDr7NIZnvUK10TLQdcUBu0Eijt8EU7jeVFXiJXBGwsG+dWvULY9eG/10fcWz1v+J97uTjKEN3O1UjcHlZUHj6NswWtJwod+x/+DothN0pFZY4rCU/Dtw+k/LjNLpPHK1mXqCV64G0JDkU0NsmYk5tyTWGBlF9mE04tvgB0me3cWJG9UqEvH+
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c4efbee-23a7-4e2b-0684-08d58156b5be
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1097E97127E341D07B6EFCBCFBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(575784001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(59450400001)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 9XpJueSRzQg/Z8p5xCZYgIxGTpS7vjYLOzOuNz4R7HSYNpILW0NCVXC52DW4EWB7IXF9wmnEePoRCdd2dFrOZgNJq+96BmFC8Yv2aMQDrKtNuiQmp68aYtlH/KVyvt90M1ShwMTQBm4oUpFafhlsB8tUUtWvDfxMOdkdt5U27gc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4efbee-23a7-4e2b-0684-08d58156b5be
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:38.3538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
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
index 760545519a0b..b975a256e606 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -74,6 +74,7 @@ static int xmon_gate;
 #endif /* CONFIG_SMP */
=20
 static unsigned long in_xmon __read_mostly =3D 0;
+static int xmon_on =3D IS_ENABLED(CONFIG_XMON_DEFAULT);
=20
 static unsigned long adrs;
 static int size =3D 1;
@@ -3244,6 +3245,8 @@ static void sysrq_handle_xmon(int key)
 	/* ensure xmon is enabled */
 	xmon_init(1);
 	debugger(get_irq_regs());
+	if (!xmon_on)
+		xmon_init(0);
 }
=20
 static struct sysrq_key_op sysrq_xmon_op =3D {
@@ -3260,7 +3263,7 @@ static int __init setup_xmon_sysrq(void)
 __initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
=20
-static int __initdata xmon_early, xmon_off;
+static int __initdata xmon_early;
=20
 static int __init early_parse_xmon(char *p)
 {
@@ -3268,10 +3271,12 @@ static int __init early_parse_xmon(char *p)
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
@@ -3283,10 +3288,8 @@ early_param("xmon", early_parse_xmon);
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
