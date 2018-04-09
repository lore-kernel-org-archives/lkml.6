Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523244851-2-3861805472655595447
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244851; b=ALEevz8cQbxC6B8FsV8ZZrENJOOZEGifQEu8vZHcpGXavaRjsx
    lhPsCaqO6QSUuFdMKMFoXH1mO0jBIJEdsCj3cRvI8Ct9+QepArTpQJ+FgEkmWYpV
    ZwG21BV0DcXOK+3ZIV3OC87tKat5DZ6GkHNtaqwY67/jgUbFbuboWaLYwaVFk284
    WfoAiIvZyX4OHCMNQ4XCWXFoKxguSBjltn9+eAGhwQkikLRZNGCMtEEJOEN2UYBO
    TFeJvlmx4U/juwIMmtuDNk5sVHzhqj9bi2X13lvY59Oi78rRgbtBWc/4Ce0R+uJs
    VN1ovjDMzCx2EdDIfGXzBmzR2FgSDc2nwC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244851; bh=welqrrfh1V
    p3eUKKymnMc347udvJ58E4nuahHTv1PMc=; b=aCC5gwEdexbMrgT4FVS+PEwh8X
    pGuDPsZDTaNTHBeBSBWbUkvoyKblgdDjQ8MWY45QVirpKvzQ9NhMSA3YRN8twE1A
    a8lDEzo9UTJXozu1BqxNb7sJuPD4ARFPJMERNZHsefaxZhVRSXaoBAPLiWD0xAun
    6/jR6ikdHTyPv7FSGHO6QoLfvEzz0E4kmx3HMtSN0+aVdR+xnw0A17cQt+CKCmZ5
    pcsOLNU7AHYbeMrk87xtjtdwQRj79AK7GMlPMgnSTxhWTDNOJ2uC0iFQhb0ccTlb
    9xAakXztFhIgtMxVjz6udNbxGLR9uz0A5MbVPSj5lNY/Jno+urYREgduc8TA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=drwMqfn4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=drwMqfn4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMhRWRDD1E1ocn+RNybFX+a4Y2Rh7ahrWhEDB9yscIEAvZSLBrRkTdhYzP+RemIdhqDqrBjh1chb3hRkCJBkqG8O6IPLXqoDwsSxviwi9TD3f9bQqKI4
    EZYMrCiDo3I3ZICtYb7z+RwsyMQ1BDkg0rTww7n8Cw3MGBIV4WoORiYJOOTVw3uZQ4z1PuL/ZLOWeyFvcw+KIfAcnLVh/FdWiZU7zseiDXuPrS81EREPRdZB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=hWMQpYRtAAAA:8 a=KKAkSRfTAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=-HhIrDMZQhV7y-9XuqcA:9 a=wPNLvfGTeEIA:10
    a=KCsI-UfzjElwHeZNREa_:22 a=cvBusfyB2V15izCimMoJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeDIDdH (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:33:07 -0400
Received: from mail-bl2nam02on0107.outbound.protection.outlook.com ([104.47.38.107]:21664
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754383AbeDIAVU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 178/189] bpf: fix rlimit in reuseport net
 selftest
Thread-Topic: [PATCH AUTOSEL for 4.15 178/189] bpf: fix rlimit in reuseport
 net selftest
Thread-Index: AQHTz5hhxvY3BUcgNkieK2tYfDzvCA==
Date: Mon, 9 Apr 2018 00:19:09 +0000
Message-ID: <20180409001637.162453-178-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:eYvFQGP9f45W8WFf8HvxQg8myDqDwuBjbevV76N2wjKQsoixw6lnATLXTDNgH4qOe6EIMcnC+0BXwfPujvNlW+nfyz605vtOOZEe61RLqlyaQo5FgKxu1hPZAcylWNtD4Y5HVR+kGE4z64NhmtSZrnZMS7bmsuBtO0x4KWu97ugJQMwafPd44bxtQqAWvwWcNBgU/C6k04LydfJM6UHvZoHxRancRwv9xJYzMYaSXzNqtc5s8cZamrhqIG01xfup;20:z6JEqZs02oBFbhSDuBpUokIV3tlEYauHAQxVCOYbwbwu628iwAaranBNEp5428m62U2GoWR6m6dewKSxgETPAV/74Fi0bu3zgdF96t2nzUYyhzFLha0whQFVy8PuAQJ0YDPmSY+oLdm6d7FoxtftUbpxCanveNOwfG4yc015c9I=
X-MS-Office365-Filtering-Correlation-Id: cf7cab49-b721-4a76-474d-08d59dafce5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11259835F210DDF6984C3D25FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(59450400001)(106356001)(966005)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(575784001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(6306002)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: t3UFXnzIOiABmNtsEeCHV7gSAhsf+gLNDv1aMv84rVHfDnSqkFGMlPxlGXxLExkXDsEARkKFN+jXOiwqjI9nmOoTCLTBTGfQwngtxtY7lBIjFJsbxUNDbhwAO/u50RXXjlKkGqSGPgDCZK79hEAvHETf9aciX4fQxVcWROa+AdIWUvU6yDYBLoZhTVm8o/58dgW7oRwNZm5ouNhI0gkJAqM6YVlUpgJ62d96HCCNXk32zp8jixFOkq5LSs1oQHdJbKXmYI3F64XK0ruhHs0EDZ82WTNGanGUXpNwJI0pWoFVBM8T88KtTQDhh1XKOqSLLUV9yPkNkXbG3X5mrvhHEJFJ9rxrphwTSDS0BeieIVSJdROkRQ7f57kzqpReXYMjbuMVcoH1AfSldhx4rljXnh3pBlRUqYnJOJgP4uXLr0I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7cab49-b721-4a76-474d-08d59dafce5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:09.4864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
