Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523242321-2-11405872899504465170
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242320; b=IsuSCJkj2gsFd6RcxE8UGImaqio5UxF8ip0XySQUGpd6OOKmLC
    P0zgw5ZjXptLpwhgfVgcfN2/QC9fL76QMYUhznS84ZR0ILzmHC8schtcVjU6nCIC
    hhLPHh+rGlzOcqrjjw2IR3jGMbp3mkkqj3EWW9bjyy7zAOFgTZiNeXxalbeBvy+B
    1sxg0P5bU9F4gJ69GSuBuwra3RxyPA4NfhKcUTriiRmsINa3iurlPW2Yl1JtNKiy
    QQEbFc0qP2ue/FgKjhrwkt8hlOEBoUdrBwZuiPazyHM1Nk6hLfEUQL+JMbbwwVPM
    BxlGtzUk0njWZ9X+GJccYJeWdMkBhxAIa/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242320; bh=welqrrfh1V
    p3eUKKymnMc347udvJ58E4nuahHTv1PMc=; b=bv6izV1pASzra0A/NDc6UIWwDi
    AfKezbeEeQCGG9V9AVhEbczduorbu/+ntnB6XQtdX+InnbiFUFyYDNSaZmeqsEK/
    1p6Bkzikvyp5vCO7AI9NnmijY2KMGD+ApWfE+wcXj5h53oSqbxpuTASSwegEIPuj
    lhAOfrPAIszq8Wo9zV5Au1y5/VPTeRbsQcHMZku0VRFWZbQ+wIY8xJZknO2S0JA0
    5Cr96hnUMOrvKPaoHWSlz6Coc317x5EZUBI7ChFSQmTzBUWowDGG8Mc56TSAPo3c
    ZyLKnRoFEy77PCTriPjTPOOGn/l1WVGJftdxjqMz5C7MzemVl1lpPe5ZkZCA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OGpWPdJd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OGpWPdJd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIXz/E92AJbYeDQsjXWd9tFnVPAxj4iaIJjkhfXp/A63CDX/rci9twT5nVTjFQ4xc4rZRjxnQWkGV5WIA2tVRAbm1PEd2ItUsSa11hLe7FDBvJB38Tr8
    5oGCCk9B/fhcrPTh+SIvMWR4L2PoUXSAV/ZxKuGV16jSS0aQV3PHuGUEGqC2Ap5av0mfkBAayvYbmVRnMU+nU6VOUJuZBGKTUtVpHF6s8tYdNoDA9pAwGRmB
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=hWMQpYRtAAAA:8 a=KKAkSRfTAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=-HhIrDMZQhV7y-9XuqcA:9 a=wPNLvfGTeEIA:10
    a=KCsI-UfzjElwHeZNREa_:22 a=cvBusfyB2V15izCimMoJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756658AbeDICvd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:51:33 -0400
Received: from mail-by2nam03on0131.outbound.protection.outlook.com ([104.47.42.131]:4960
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755345AbeDIA0c (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 150/161] bpf: fix rlimit in reuseport net
 selftest
Thread-Topic: [PATCH AUTOSEL for 4.14 150/161] bpf: fix rlimit in reuseport
 net selftest
Thread-Index: AQHTz5jEtetK9ctoxE6z71mMKnti2w==
Date: Mon, 9 Apr 2018 00:21:55 +0000
Message-ID: <20180409001936.162706-150-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:MkRMoVQK6DRfZYAIXiQx0A4vcACZxlkWgOuQQlLqUL301Ye/SSGaVHCvELngahRaghuNgHJrltWtgcF980ileu+rUrlptlQpBywe+zPnG7mA3pcTkl0QXo8uxAJKW3j37IEc60/AdaK2zh/On19A/Cm/fshff4brU38kczBNpGJs/2XCaHv2iKyqHqz2Db775C2oz1zx7Z/pw6r8ypCdal7HGhNMS1FQeAn/7xerUUzWlXlHB0lhCZtckPEI9E4A;20:ONW+XC6LLIIowaG8+9GKQWE1u81zragJNj3SApXNmllKnoiGYZJaksGFMYISaNZ/XBB0q018fUKa1dadiq9YN9+mjMYeWwYYiX387TuUo3EzUArb54n7mcqZsz1S7uLolcUK6Iz4aN/CKYlj/pNwwGXM+QX9UW/SjvFECJuD6qo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c335923-e9c1-4319-9de9-08d59db08413
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725B40F8AA42442D7D173ABFBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(6306002)(4326008)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(966005)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(575784001)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ExHSnKmnG/bwWGBdSAHJic6KsbjgXJX3Cw3EFXl4VA97+sKK6nSDhyQBSUx1UxeIrM5l4cRxd/Xz+plc/onrWyrnIQ4vGQUOaEwvxxT2Z3gujibFdzxQNayyF/gSqJvaE6HS++VND8Ir4q6Wqx+VicOXyh9mE+RwtMm8HUojg1KOWlyW1kCtNLS3DqoFDNQYx5s41KdY3ehufDbNSxdybStDCAcKMeWxWZnFDgWlfVzUIb1qa6b+MZMOgTpvpkOFTFUkTk/3Jw3ZNWg7u+Xf5a5VxL0EO1aZNJxL4qT7L9fsRwX2djGmQzC0BDb0XyzoEaE3zsRXAemZLuG7J9q7DnkOkGF/qbeA1rrSXOILacNbmzVVAFqpxVuOpcA7Zx9irYj1r9Z1ikIKKiZETyPAK9I2M3RRpHFhS/1e4smFZkU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c335923-e9c1-4319-9de9-08d59db08413
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:55.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 941ff6f11c020913f5cddf543a9ec63475d7c082 ]

Fix two issues in the reuseport_bpf selftests that were
reported by Linaro CI:

  [...]
  + ./reuseport_bpf
  ---- IPv4 UDP ----
  Testing EBPF mod 10...
  Reprograming, testing mod 5...
  ./reuseport_bpf: ebpf error. log:
  0: (bf) r6 =3D r1
  1: (20) r0 =3D *(u32 *)skb[0]
  2: (97) r0 %=3D 10
  3: (95) exit
  processed 4 insns
  : Operation not permitted
  + echo FAIL
  [...]
  ---- IPv4 TCP ----
  Testing EBPF mod 10...
  ./reuseport_bpf: failed to bind send socket: Address already in use
  + echo FAIL
  [...]

For the former adjust rlimit since this was the cause of
failure for loading the BPF prog, and for the latter add
SO_REUSEADDR.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://bugs.linaro.org/show_bug.cgi?id=3D3502
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/net/reuseport_bpf.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/reuseport_bpf.c b/tools/testing/se=
lftests/net/reuseport_bpf.c
index 4a8217448f20..cad14cd0ea92 100644
--- a/tools/testing/selftests/net/reuseport_bpf.c
+++ b/tools/testing/selftests/net/reuseport_bpf.c
@@ -21,6 +21,7 @@
 #include <sys/epoll.h>
 #include <sys/types.h>
 #include <sys/socket.h>
+#include <sys/resource.h>
 #include <unistd.h>
=20
 #ifndef ARRAY_SIZE
@@ -190,11 +191,14 @@ static void send_from(struct test_params p, uint16_t =
sport, char *buf,
 	struct sockaddr * const saddr =3D new_any_sockaddr(p.send_family, sport);
 	struct sockaddr * const daddr =3D
 		new_loopback_sockaddr(p.send_family, p.recv_port);
-	const int fd =3D socket(p.send_family, p.protocol, 0);
+	const int fd =3D socket(p.send_family, p.protocol, 0), one =3D 1;
=20
 	if (fd < 0)
 		error(1, errno, "failed to create send socket");
=20
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)))
+		error(1, errno, "failed to set reuseaddr");
+
 	if (bind(fd, saddr, sockaddr_size()))
 		error(1, errno, "failed to bind send socket");
=20
@@ -433,6 +437,21 @@ void enable_fastopen(void)
 	}
 }
=20
+static struct rlimit rlim_old, rlim_new;
+
+static  __attribute__((constructor)) void main_ctor(void)
+{
+	getrlimit(RLIMIT_MEMLOCK, &rlim_old);
+	rlim_new.rlim_cur =3D rlim_old.rlim_cur + (1UL << 20);
+	rlim_new.rlim_max =3D rlim_old.rlim_max + (1UL << 20);
+	setrlimit(RLIMIT_MEMLOCK, &rlim_new);
+}
+
+static __attribute__((destructor)) void main_dtor(void)
+{
+	setrlimit(RLIMIT_MEMLOCK, &rlim_old);
+}
+
 int main(void)
 {
 	fprintf(stderr, "---- IPv4 UDP ----\n");
--=20
2.15.1
