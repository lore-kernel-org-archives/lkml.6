Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521499065-2-18254549454075088536
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
    t=1521499065; b=aQCFp5fgAra7AG5iOEyfS6+tluxP5ydSmTAwth+35TK74wN
    HZPM+J5DQ2buqk2Gk7RLbSoHT72ZDLLVNxnQM+f0kWmirVtDR+oG8Jo10+Olcwgk
    w54B3erY4XLSyR4tAb0VA3yKyJzhqRmJLDT4/q+7OOFjUARuWRbZ6w2Wucyd/Qc5
    bLSsDtImx+90Q4HL96aK9OwhDUsBJqecILiCVEZ3qyUT4aTLi0WlWa5mNP8Xikl9
    cBc8RjzkKTEAVLPTPcdL7pQEK6SjoCgWzsJpprm1eFY9qWwpYTbtMtyCHkjTz3iG
    04vkoq8DIAGvOF5G5x6tpAMk5s28SOrlolf154w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499065; bh=VVzIXZ
    1sDSuV/dyW2p1PlX/nFn9DgYOmSYRVIWDMV3E=; b=BwYiPH0hkPo6Yg+lSBWi9K
    ep5LlBTz7rUWvVjQVhjMvVzdi4PYk1pIKo5JsJW6rt7bzkpEnF+PG/Es+j9xXCk5
    /LwAmsXrcbH8bdVpYARnxIFdoqBdgWUrWymSJRyqMwVjFPeLRbct05m/Xu+66Jws
    7kciQmjBYeN0E+txIOMauQ/JtgXPwhtsPO3MyPBTAbtl9tCbGX7WKPQl0E0sD+9W
    QkPLah9n7nG2osYbAhs4u8jKCbMMBTzhtnzImPOsj2TvuYKtOQCHm+GOOjoumDzl
    NgpPfIyUtmQvI3G7UuyAZv1DGsrzEvUAmz7JblgFvWmWMto6JBcOXpg0wA8PuVPQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LzPQfUiz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddugeefnecuvehluhhsthgvrhfuihiivgepudej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LzPQfUiz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddugeefnecuvehluhhsthgvrhfuihiivgepudej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933629AbeCSWgx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:36:53 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:59200
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933301AbeCSPrj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 029/124] selftests/net: fix bugs in address
 and port initialization
Thread-Topic: [PATCH AUTOSEL for 4.15 029/124] selftests/net: fix bugs in
 address and port initialization
Thread-Index: AQHTv5mVzIcLezXKeUeW6dJI+VkoBQ==
Date: Mon, 19 Mar 2018 15:47:28 +0000
Message-ID: <20180319154645.11350-29-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:zWhBGCmxKKPwnWk+/eMQCFfkwVDwZC9G3JaASyiP4KIyf6fo0TV6JveRuhWAVAdq4/uCufbXrnNod2gXFGXAa5NMnC3gugE5eeIn+bFCKUh94ahLVY4/cIZT3TyQjvmwmjHjPUIOexWgSwtHLXF1tU3tmdVaAZJnMlwJ3ggYfIQAq3jkjTYbaRYy1jcSgUMuK9kII7IDSw4lWpiZnkN6E3//hM6F6pg6q+QL5sN+3b4tD7FBV7m9WWArO4+QYiYl;20:dgyrErk6NuCmwIuGHeayNXSNGofh6bf2XFnhLoHHn5sgKb4UzLxunrPSfVi5N8GThuETmZW6NCvQeGk4cxkkjJwZPL+lgOUuBfnPlw1pihb6zMSVn7kBV6Imc62N5brOJW+OKBMcJY5KvSyYI4b13Nk63FPXBlmob/ectU0Ks0A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 874bc67b-78e2-4a87-f4bb-08d58db0b960
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998559B5DD9FC420ECD7B1AFBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(21532816269658)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(575784001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(478600001)(99286004)(2950100002)(14454004)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(3280700002)(1076002)(5250100002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SQhUO77Ekfx/NSVj30WONVPmleKvjFs3RePBeMSXJWARty0XFf4qXQAfagVdQ6XMgcaS4R7wxzdzMLuEBe1ukVSrxgFzeEDRHNjEt78PwwxwfENimrTs/cblJMn88HwrJh0/J54ngQbF23JK47Ddkv3jp6ipJHFHqAAF1LXqKiQiAAXb42AC5DyXjFBlQOs7OO9tHkXImwJzKY1zVobM/aiWWQcYoluC/3+j3YSiz3hrnDYxEI4tTdblvmR6u2PiUXIHBBdQFosrHetCGyHgA/ojwn95l+RgJ+YWRRFZHox8xSCtOzmibmZQNaHxpvndJpBLn7LbwjnGfGcpX6ZAgg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874bc67b-78e2-4a87-f4bb-08d58db0b960
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:28.8720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
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
