Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480237-2-3779113240526910656
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
    t=1521480236; b=OBNF1Wf9ikRwdf6Q0aqPf4DTiaTbedzH7MuSNmw/BX5kKqJ
    eBVemRztiOcrA4C76Nutn2Bh+WmqCwQXwxhEsQtaDaI8Kmm9YgOtFt1k+ebDj+p5
    FWjm2bgO5MKrbMO8eLwC9hPM0pCDmm7kGojNTBFlrzrzIksGclfxtgsX00sV2kxT
    yKq2BFiLobgsYGwGkF9u1hohm50EWEwC2O6vnoagw/GWPpKexe01p2sERzZsP640
    oVxYt2GwB2AB5C9SxWYAf4h0/mrUmTaChGj+NOXS79asclGjwZUIQ2PpQdG1mHjE
    lvFiEYBLtL0fOk/yKUn/0BOXFzxL15wC4tRcI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480236; bh=ziTZOU
    u64YYUTnFgEI/zR3IAh2o/cUJtl7kb0p9yMLU=; b=RCybngX99VvtY4NOeOBNk5
    Q42szWEP/vQzvMJxL6urGwQc24T3JN31tkOlTL9u8l2AQ1vrUKjQbhd/kwFg0h2U
    9Nu68WUWjAIq/PBJ2Rktbc1Pd4UWj34IRXyZE5vTxTvr1XwJIKmkZZtO3iZicSfk
    T+DxN3Fy48ofWY6+376xvVxB6ZwJmK7cpgQnsimYGoOiNUYJkvWVfyuAogmi1ubu
    puoXX+BTVI6pFyXDU0jEhPVPmZSyA+ClisGptU9PdQSOeey77Xm+uXzfQ28emSYZ
    5i8ZT15BCRYE6ACo+0EGGvMV0WGpqc/GNyIqF8E4IDS7qyUhc1lRI/rXPJqCQZgw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HQri+lOr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddvjeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HQri+lOr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddvjeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966468AbeCSRXj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:23:39 -0400
Received: from mail-by2nam01on0094.outbound.protection.outlook.com ([104.47.34.94]:45505
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966374AbeCSQI4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 061/167] ray_cs: Avoid reading past end of
 buffer
Thread-Topic: [PATCH AUTOSEL for 4.4 061/167] ray_cs: Avoid reading past end
 of buffer
Thread-Index: AQHTv5xCoemtsMi/sE6Si0osE26bRw==
Date: Mon, 19 Mar 2018 16:06:37 +0000
Message-ID: <20180319160513.16384-61-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:1Yt78ePodTLU7q683AFxvcQ9/gZjU2fT14YpZ8NHX81WRCOAExGz0VXyrcnunS3y9vpKvFDkXbsRH8knA35u6aFKfHuNgLj5IcJHiAw6ASbGzWFWnf06ny/gQQpMUs9u69GJBzWv5MPpx/1abhM7eEpJKClKSQ2JljnkDG/05GYgcUEJqT/Ah5omXtNCzx9BxtIY7T+zLGnniN3UDvTC45hYhUstwYizhDgfcQVQIuDM8f2qUydDqHUzbn459mAw;20:YX1Er55EUCMSmqxDdIbr/eWD+kVDPHwaji10vBDeqbA76pUf47PEHMR3S/nz5TQTVzGTeM8PMJAB7wiWbu6CuLAZSytnxcxSw/idWXZs6MQJHZs56qoOWSie4Zb5nE4L2XObM6hohJSyJ49GvhbYjO9zXXhzV4RKrYbwhBKoS+c=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea8bae8a-d418-4188-569c-08d58db3b68e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0965C75E223DA393F33C457AFBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(86612001)(10090500001)(478600001)(53936002)(39060400002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kORJyNGiEirAd71oHSN9FEKUcWzVdLeJ+pv29cl04N1gTqrYGn9/eHYQfb8w8DeD+P5cm/63IDDBXhc8HeRE8Q1NB88QIA00otRUF0bDohVGqCWN5fU5I3VZ3rs4uAoSuStjX2q6LO1EuGHxzSRuaDQ4AushQQVnuWnxfsM1uto4/uTKtspmGEuLNXiIAidjCiv2/HzDxJtxcRdiZlC6FlDUDOrnzkwYbRPeLvywvSL7GA2ER9d9qoy7g0ahxXrojMoJL2/EMYfsZrzbTt4MK9WocmfqyHB2eeDuy067BG+bqIMkbilpprfsvpky3pxBD3WIL7JubH1Twn8R0THeBw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8bae8a-d418-4188-569c-08d58db3b68e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:37.4146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kees Cook <keescook@chromium.org>

[ Upstream commit e48d661eb13f2f83861428f001c567fdb3f317e8 ]

Using memcpy() from a buffer that is shorter than the length copied means
the destination buffer is being filled with arbitrary data from the kernel
rodata segment. In this case, the source was made longer, since it did not
match the destination structure size. Additionally removes a needless cast.

This was found with the future CONFIG_FORTIFY_SOURCE feature.

Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ray_cs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index 0881ba8535f4..c78abfc7bd96 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -247,7 +247,10 @@ static const UCHAR b4_default_startup_parms[] =3D {
 	0x04, 0x08,		/* Noise gain, limit offset */
 	0x28, 0x28,		/* det rssi, med busy offsets */
 	7,			/* det sync thresh */
-	0, 2, 2			/* test mode, min, max */
+	0, 2, 2,		/* test mode, min, max */
+	0,			/* rx/tx delay */
+	0, 0, 0, 0, 0, 0,	/* current BSS id */
+	0			/* hop set */
 };
=20
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D*/
@@ -598,7 +601,7 @@ static void init_startup_params(ray_dev_t *local)
 	 *    a_beacon_period =3D hops    a_beacon_period =3D KuS
 	 *//* 64ms =3D 010000 */
 	if (local->fw_ver =3D=3D 0x55) {
-		memcpy((UCHAR *) &local->sparm.b4, b4_default_startup_parms,
+		memcpy(&local->sparm.b4, b4_default_startup_parms,
 		       sizeof(struct b4_startup_params));
 		/* Translate sane kus input values to old build 4/5 format */
 		/* i =3D hop time in uS truncated to 3 bytes */
--=20
2.14.1
