Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492969-2-17148152113222261605
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492969; b=eO+skvp1T3glVrHgTijgbJxWHQqAzFJAG6w/OWjLOrxBas3
    93kUvldRHhQz0mC0OEcwDm19NQUYQR8cdrGk30KEJFuC8BU6y1o1C0HRxQvwrS6e
    J0kDDC0QRTTWYEPdIwPIAE8IZoL16LcC42hTkdmu26GOXwyC9I+4sTOY+Dn3OOk0
    xMvQW39Pu5CdUH1HS8JPhn+Zo8ghMByY7apWESJaS5J/OFCRPBARVuARNqZDD976
    CwvOTrr3957+wnSnN6kvAhymHSIX+s4cRzfTP/tQPlVcSF4UM57Hybq0fDcBc75A
    9Ab5Jd+Eutm2cIk8wOcKBJlNLO0OTe1CjtsrSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492969; bh=j/fQ97
    j4cN1pWAAGCC+z8OvdRjDICyV0g9BEIvWEYQ4=; b=K0TrNgquc/UrPvR0uzIUZu
    HU+WnfCYtZJtSnW+h29WAD1Wxjg5NwkTgc6FwGtEiQj0LEDGSjJO3SLFy0XpIysh
    ujLGDa2Kts6MW4fVdVvUF6A47itSchXu7TOV8rJ1qWodjJlrESPhom9E+pZpOJyc
    vR9cxOMPpeB3aEfDOepkFmaHqP55x2+/bxl3vVTg+OZeNwAC3TtG/MjEP+iSA0N8
    rTneSL4T8o13a+iKrbOcicuhVtSVeXvoIY5mMSNFWqMCw7wuw2svmDk49UWy5BWe
    q+a3nhJV+eUGcP7xAK7Q/oU1O5EquG7pLAIA3sOCx7H2b5Me6gXCXlHr4mqIGXxw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CX+O1iQ0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CX+O1iQ0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934542AbeCHHIg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:08:36 -0500
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:45246
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755107AbeCHE4R (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Roman Gushchin <guro@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        David Ahern <dsahern@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 18/78] libbpf: prefer global symbols as bpf
 program name source
Thread-Topic: [PATCH AUTOSEL for 4.15 18/78] libbpf: prefer global symbols as
 bpf program name source
Thread-Index: AQHTtpnF176Z+OChAk2NQaqhgN6DyA==
Date: Thu, 8 Mar 2018 04:56:08 +0000
Message-ID: <20180308045525.7662-18-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;7:IeDDgO7TLfQ805/s1QMRCGNgBTR3GPBM9Efj6SuaMZd9yiO+Ej79Yjgz2LYbDQkndN/599ZAFPL9e41hU+9c33NgmeSsrnug8ROYgGkcMOnA/P7svVWcvRUf/SxVgilW24y+D6eiTVnxWMk+1KPOgpNctz5JdXtTLyDaGfz0kOOUqbav811KKOX3CMoEMluE/zLn8Czgqg1CmATQ9tbPLjR73UuQrh5AxS6mkFO3xXDq47x7s4bVHUe2jAX1OdWL;20:TKn+0ZMRxOK/XH+NqEvYTGrtEhdfmkgRFZDeLst4o063xaSzkDofIzHfwZtgrxx64eEgiFKJV0cT3JsqWBV8ZMsgp4Cy3E1MnN0QAOev4M2EYkmBWRGSbNn2h5kFKH5DV3yLPvLP9A7wAHEKKeyfO67m6r2dZymjlyR44Q8LYM4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 022d0275-aef7-4ad9-fc42-08d584b0eaea
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1111C3FA8027136FD3A5C715FBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(39060400002)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(59450400001)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: RUinPadF6K/u5Re+2ewclkIp0PKak5SdfJgtKYZyMDifkQhw8LqbQkR1q7FBw4RkfgiYcUfamIVpOA5KNDwRsP2NlCXRL5IYE8Hoududlz5UdXYUGIf9687qfB/cCuHI6mCWE0kR2cWCDjQMKwpbukIxOMXIUEcsOjDDoO2opDfU6Ze3NCpCX0blM8sr0vRWQY0aGK/pltiAPUuiopRtxpb0JvWyEefzpCTw55sT8Byn7K6nM/ZgOTFLv+sptmfnArw9DFzYkVwbSxqoGKe/sJ/xEr10UonPEik8ZICplANPx8uiWIWCAOnH3ukhA+lTZV7gL6Xdw0TOqapsjPwrdA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022d0275-aef7-4ad9-fc42-08d584b0eaea
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:09.0052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Roman Gushchin <guro@fb.com>

[ Upstream commit fe4d44b23f6b38194a92c6b8a50d921a071c4db4 ]

Libbpf picks the name of the first symbol in the corresponding
elf section to use as a program name. But without taking symbol's
scope into account it may end's up with some local label
as a program name. E.g.:

$ bpftool prog
1: type 15  name LBB0_10    tag 0390a5136ba23f5c
	loaded_at Dec 07/17:22  uid 0
	xlated 456B  not jited  memlock 4096B

Fix this by preferring global symbols as program name.

For instance:
$ bpftool prog
1: type 15  name bpf_prog1  tag 0390a5136ba23f5c
	loaded_at Dec 07/17:26  uid 0
	xlated 456B  not jited  memlock 4096B

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5aa45f89da93..cda652a12880 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -387,6 +387,8 @@ bpf_object__init_prog_names(struct bpf_object *obj)
 				continue;
 			if (sym.st_shndx !=3D prog->idx)
 				continue;
+			if (GELF_ST_BIND(sym.st_info) !=3D STB_GLOBAL)
+				continue;
=20
 			name =3D elf_strptr(obj->efile.elf,
 					  obj->efile.strtabidx,
--=20
2.14.1
