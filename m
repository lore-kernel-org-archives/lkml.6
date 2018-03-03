Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123726-5-1917207768395219271
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123726; b=FaLM9AZnD9tiRjIYJ3VCv8KpGYvZh8u2gIkQ9QbjCHOsULe
    LScPSIzk4ezxBkliE08MNN+Wjk4IYFqAAuUeCWH+ZHx4QY8nueqhpUjId6uBBqbU
    ZxPz27dk7Fv6/yJ7RJunLWGxXW8qjq5mj9FSKwMdbSqUSV8tYHg1ywa2pHlOT0N5
    eoibaVejrtawYX8GEF3yuHGyNEtVHZRIJkGLetgG0k6klrvR7ZW5N+Ya9CyZ9eib
    gpqKwy0M7EUtT66jVFEezi3FCAu6l/nFKUnmFRwrStlgclzPAZKc3w3WCam4DEpl
    V3rZ88XiUQdwIcftq+tOhCojput9TFI2MQvM+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123726; bh=qmZXAY
    WUN8a3GYCCan7CqMhtGnVR1W7kyp7h1ORy8Qw=; b=G3B1efvGRtn8vnlgZPQqGK
    um2qDTFSE2M2fDR4aeU5yTEs9qj+xq+22W/UOnXxOsrpc+ZBPyqlfR/2s1L7DWev
    u2LNJdWzJ/DMF9Cxj243EFlX52Ke9R80wzSU8e9lJjEo4Z42dodxP7rAdditNp1e
    VvFavktHjeczx/gXW3OcfLj/eDWNKkYydBcMA8zUQCesBhxWUAiUkBERVJ8968fs
    Lf+hGm+UYTimvob5V/NBkovCA284o6FMLt0A5tmSVZ4VhsCmSHwIwwc8YLuGQhdV
    4i9j/kHDUcwYTKCzU9iSvd+twXoAtIFFvOrsorDQwurO4/e7EUxCmMKis1KS+IlA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IeR6DUwV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IeR6DUwV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932907AbeCCW1N (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:27:13 -0500
Received: from mail-by2nam01on0137.outbound.protection.outlook.com ([104.47.34.137]:52173
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932847AbeCCW1J (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 077/102] clk: renesas: r8a77970: Add LVDS
 clock
Thread-Topic: [PATCH AUTOSEL for 4.15 077/102] clk: renesas: r8a77970: Add
 LVDS clock
Thread-Index: AQHTsz50Ab5tfSs/dU+HbaGRdOVbZA==
Date: Sat, 3 Mar 2018 22:24:54 +0000
Message-ID: <20180303222318.26006-77-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:Uj5yCPje0Md+PuKju6FyPStKDKxTn5MPnAugRvGlMwJjH9STGTbkgAxjXZ0YSsEwjJwqkHjNZHISkzDUH2G5cMQHkS6f9IIqw8JqOQIsocT2YWq0L2Qwa3W520VuaKqHTBHU9V8NOfoUmQtdOV1dliy/O+yh6GUweLKpgFiygaM6kygmsSh+K2NJ1ILJrIOevfGTlhWtL/XXo5GyON4ODJddU5CUbzBt03f6ub/4f9m5QshlIS6FsBgKDM6BGsh8
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 059e8087-53d7-4b1a-3711-08d58155e3c5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06F85D44B2EB6AEF24CFA8FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(575784001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: OyslxDqh4DNnUKT1KQf6voa4qCkWKy+noGwlK+ShcWLQusLFfq7f/4vPLAxHBd4ITutlhUxF30B8rjTJtT0Xysc1i8evTtqtPMVqCEORkuEwLU5EhLTNgQ1NF9+RSl1wy5bBTqy8j8eSNn5rqGpmTMFrUeFh8V49FIRUENcDCpA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059e8087-53d7-4b1a-3711-08d58155e3c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:54.4159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[ Upstream commit 64082568dd1e05d349a0d9dfda2bdf6ace3f9f6c ]

I seem to have omitted the LVDS clock from the R8A77970 CPG/MSSR support
patch for some reason -- add it back...

Based on the original (and large) patch by Daisuke Matsushita
<daisuke.matsushita.ns@hitachi.com>.

Fixes: 8d46e28fb5081b49 ("clk: renesas: cpg-mssr: Add R8A77970 support")
Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/renesas/r8a77970-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a77970-cpg-mssr.c b/drivers/clk/renesas/=
r8a77970-cpg-mssr.c
index 72f98527473a..f55842917e8d 100644
--- a/drivers/clk/renesas/r8a77970-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77970-cpg-mssr.c
@@ -105,6 +105,7 @@ static const struct mssr_mod_clk r8a77970_mod_clks[] __=
initconst =3D {
 	DEF_MOD("vspd0",		 623,	R8A77970_CLK_S2D1),
 	DEF_MOD("csi40",		 716,	R8A77970_CLK_CSI0),
 	DEF_MOD("du0",			 724,	R8A77970_CLK_S2D1),
+	DEF_MOD("lvds",			 727,	R8A77970_CLK_S2D1),
 	DEF_MOD("vin3",			 808,	R8A77970_CLK_S2D1),
 	DEF_MOD("vin2",			 809,	R8A77970_CLK_S2D1),
 	DEF_MOD("vin1",			 810,	R8A77970_CLK_S2D1),
--=20
2.14.1
