Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497261-2-13769612929932036535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497260; b=gtECiC+62YkhFqvWcmEzGDxoPF18he1nnvdp76ICerE9zbN
    uMaKzoH8IyomgjFL9qgrlbejbQgr4UJtJnKR5W+cLBl6veBzvKC+QJZnYx558/at
    PkVtfjXOAAkTA8z5y3bYFS3zaOJ+e/WfvIzfGFhfGnKSvltgy9cwwwm6JGpORwVf
    6ZqKvoAO18nSVkQJle3AKysZdUdpHwP6BKyqQdPGkk9BPInD0d3DRWFhU5fu/VA5
    YlCtHA0kS6y1ZQvnI4U7Vqv8MlTtS7cTudhHBYAjcGMK5iwnc7vOedW0S+UqVJrA
    5llKi2VI6nHvK9WRQqhbHF2P6devwz/fELTqmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497260; bh=VVzIXZ
    1sDSuV/dyW2p1PlX/nFn9DgYOmSYRVIWDMV3E=; b=rSS6FcrPyRQ09pxTb/Nbul
    fthiLhdomh3JNwN0hwUVrx02YNS4iwXbCJ28GECjV2mYMDzf7tleCb02h377OfvE
    i+7rRTa7MFi2dnRi51FXWzv1Dx1zfWBVb9ps40Me3wfHFZQSCPlbGWiv9mDTQpHg
    iYScbRDtfGfBGyJRbQqmvqh4QgAZ/bdRbJr/Lib4cIxkLL8uvf/vjgPduAscrE6W
    QCMvSTTgszeAUgLS7Bnjrl4q7v3/OOGFJsMc6jllgfA2PE0WMLMU6NkF1k6hK/ci
    LxWqLvFXGh6LJHar2l6wu9MbBKrycLhAeBza7V/qvZK/QQOlRQKzEq/sSi9bim+A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=osqPwhhs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddufeejnecuvehluhhsthgvrhfuihiivgepvdel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=osqPwhhs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddufeejnecuvehluhhsthgvrhfuihiivgepvdel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964787AbeCSPzC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:55:02 -0400
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com ([104.47.37.125]:46720
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934334AbeCSPy5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 23/97] selftests/net: fix bugs in address and
 port initialization
Thread-Topic: [PATCH AUTOSEL for 4.14 23/97] selftests/net: fix bugs in
 address and port initialization
Thread-Index: AQHTv5qfmtgI0t7DbkOcBeKQLcLTHg==
Date: Mon, 19 Mar 2018 15:54:54 +0000
Message-ID: <20180319155411.12348-23-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:5RRdNXD/LQtdUnBlzUuRNs08mQlFztgqFwjkOHUrGIhyy9RoNiwsUR+2bjWOK74n5Rqawvh5oiFQ5/OmvCCRbBwk6KEJKUuh4vXbuxowCdishpvmBzeAZLIigzH7J6KysW9fWJHCJSsctwf9nrSyOgV8a73o9OYuSqt0czaP4teGSJSSXN+sDHnY6T5z0FZ2kOb0T/uypBIMRT7S5vTudmDMibt9AkE5Npje/nFqV/H9RlOOMvw8DbzBWJfxIlvg;20:hUIWFa5C1PS5OXHxUMUbatph2MKJeRf1DhGSN9Be264GztNNHLkREe3+dyzhR1vXYu1oDdg/z5UG8Xe1/H5ucWnMRwbqheHotMbqJSCeysI6Ah6ZrR9/SRJJoE5haEgGGyhWlKrKq1tt+LjfRT4MdjpZFrMZ/CgtOIbi27qh0Ko=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 916fc917-be3b-48ec-d325-08d58db1c24e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08066587DAAA4DB28F85609CFBD40@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(21532816269658)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(199004)(189003)(14454004)(105586002)(6486002)(316002)(86612001)(68736007)(106356001)(36756003)(6436002)(99286004)(2501003)(5250100002)(107886003)(54906003)(110136005)(97736004)(5660300001)(22452003)(26005)(186003)(6512007)(59450400001)(102836004)(6506007)(53936002)(86362001)(575784001)(2906002)(25786009)(478600001)(66066001)(2900100001)(72206003)(7736002)(8936002)(3280700002)(4326008)(8676002)(81156014)(81166006)(10290500003)(10090500001)(1076002)(3846002)(6116002)(3660700001)(2950100002)(305945005)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ZOfhbOV0boP8iINeAP6Dp4WYif05ahMxzUIppoFJWqqAgPFRayQgllKySsY6iVMabQwztFOCMArproGqMO59VzpnVBJpB+O5JDFF3PBYn+6w7LZV94R4d06Py8l1v7qkDhW2IEdrPf0AhTH/DtorEPYJmA5YDVpOvPnbtZQkWdBWD1sJ4yQ630sa93NG1hKOL4KX6pZAaDqXVH8jGur67MvEmvk6sUSxF43fftcxdpoLFIB/zcvIOjs5DcRx+d/ELoMJZwTuuWxjD5uq4ITV5dp9xZWYsvWnXNiTSokhC8lyZJsol+304qTTLu0gPK8E3uBjtPc2+2uZITp2luMiwg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916fc917-be3b-48ec-d325-08d58db1c24e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:54.9955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

[ Upstream commit d36f45e5b46723cf2d4147173e18c52d4143176d ]

Address/port initialization should work correctly regardless
of the order in which command line arguments are supplied,
E.g, cfg_port should be used to connect to the remote host
even if it is processed after -D, src/dst address initialization
should not require that [-4|-6] be specified before
the -S or -D args, receiver should be able to bind to *.<cfg_port>

Achieve this by making sure that the address/port structures
are initialized after all command line options are parsed.

Store cfg_port in host-byte order, and use htons()
to set up the sin_port/sin6_port before bind/connect,
so that the network system calls get the correct values
in network-byte order.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/net/msg_zerocopy.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/sel=
ftests/net/msg_zerocopy.c
index 3ab6ec403905..e11fe84de0fd 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -259,22 +259,28 @@ static int setup_ip6h(struct ipv6hdr *ip6h, uint16_t =
payload_len)
 	return sizeof(*ip6h);
 }
=20
-static void setup_sockaddr(int domain, const char *str_addr, void *sockadd=
r)
+
+static void setup_sockaddr(int domain, const char *str_addr,
+			   struct sockaddr_storage *sockaddr)
 {
 	struct sockaddr_in6 *addr6 =3D (void *) sockaddr;
 	struct sockaddr_in *addr4 =3D (void *) sockaddr;
=20
 	switch (domain) {
 	case PF_INET:
+		memset(addr4, 0, sizeof(*addr4));
 		addr4->sin_family =3D AF_INET;
 		addr4->sin_port =3D htons(cfg_port);
-		if (inet_pton(AF_INET, str_addr, &(addr4->sin_addr)) !=3D 1)
+		if (str_addr &&
+		    inet_pton(AF_INET, str_addr, &(addr4->sin_addr)) !=3D 1)
 			error(1, 0, "ipv4 parse error: %s", str_addr);
 		break;
 	case PF_INET6:
+		memset(addr6, 0, sizeof(*addr6));
 		addr6->sin6_family =3D AF_INET6;
 		addr6->sin6_port =3D htons(cfg_port);
-		if (inet_pton(AF_INET6, str_addr, &(addr6->sin6_addr)) !=3D 1)
+		if (str_addr &&
+		    inet_pton(AF_INET6, str_addr, &(addr6->sin6_addr)) !=3D 1)
 			error(1, 0, "ipv6 parse error: %s", str_addr);
 		break;
 	default:
@@ -603,6 +609,7 @@ static void parse_opts(int argc, char **argv)
 				    sizeof(struct tcphdr) -
 				    40 /* max tcp options */;
 	int c;
+	char *daddr =3D NULL, *saddr =3D NULL;
=20
 	cfg_payload_len =3D max_payload_len;
=20
@@ -627,7 +634,7 @@ static void parse_opts(int argc, char **argv)
 			cfg_cpu =3D strtol(optarg, NULL, 0);
 			break;
 		case 'D':
-			setup_sockaddr(cfg_family, optarg, &cfg_dst_addr);
+			daddr =3D optarg;
 			break;
 		case 'i':
 			cfg_ifindex =3D if_nametoindex(optarg);
@@ -638,7 +645,7 @@ static void parse_opts(int argc, char **argv)
 			cfg_cork_mixed =3D true;
 			break;
 		case 'p':
-			cfg_port =3D htons(strtoul(optarg, NULL, 0));
+			cfg_port =3D strtoul(optarg, NULL, 0);
 			break;
 		case 'r':
 			cfg_rx =3D true;
@@ -647,7 +654,7 @@ static void parse_opts(int argc, char **argv)
 			cfg_payload_len =3D strtoul(optarg, NULL, 0);
 			break;
 		case 'S':
-			setup_sockaddr(cfg_family, optarg, &cfg_src_addr);
+			saddr =3D optarg;
 			break;
 		case 't':
 			cfg_runtime_ms =3D 200 + strtoul(optarg, NULL, 10) * 1000;
@@ -660,6 +667,8 @@ static void parse_opts(int argc, char **argv)
 			break;
 		}
 	}
+	setup_sockaddr(cfg_family, daddr, &cfg_dst_addr);
+	setup_sockaddr(cfg_family, saddr, &cfg_src_addr);
=20
 	if (cfg_payload_len > max_payload_len)
 		error(1, 0, "-s: payload exceeds max (%d)", max_payload_len);
--=20
2.14.1
