Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238069-2-6526089247309051193
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
    1523238068; b=HxEtBkaPYlHNZ4JeJK/ckwZgI+Q2YDRfZKrKSA1A9MJqXhKEZV
    nDcK0xz9TsbQ6JLnuI2c6B+UlaGK/fN+0Y+BCmw/C39pJHOpsKEW15g5EIHFKP+m
    4CUS5iq94AgWlpV+x2rFCJpgWnsZS9KJPQrBo4PZM3Z93Rxs+exvsGr+yFa2CMYW
    PojTjMH6zAZNTQGQyB37T5MUtQw4DpmKPwKM8Jc4G9HHXCMPXGSxcF6xl+3hsj+r
    fXQgI1/H5bJhk/p1fJEZ59a7hy9LT2O8xKWkad8DYL8uqOs5iWZih5zoaSAssI2G
    oWP+yJYmtF6xFeLFACV9D1myZ0HJBoVBD93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238068; bh=welqrrfh1V
    p3eUKKymnMc347udvJ58E4nuahHTv1PMc=; b=YHSvQSzZZfPNfmj8+JrS8ua9pd
    CHSWhkEuT1twnHvBTr8mWjHVHRpd6OOPxWkoiGAK8Dp0ye4/LQv81xYWl7ckK+iB
    M9cScnXWB+93tCHSKnJJlzF7q2Y1wiMwlhVpkSBe9adv63q2Ij+qZaSNU4lNEeA5
    U1dv0dg9NkVwKwXFij93An57yj83p711EzqOMpNnW6r77E4kCDSBiYV4UEg/8rvi
    WugrhNwq28wiMVZSvpfaZjXDUvATRgKj8B7Esd48v88K0GqYa9gmm222Pa806MUM
    +eQh9heoZSU6Ku0YIjPlJ7Wfm67SKfUC2gvOFG4tNXbiRxJ318tfxqpwrDIw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GTDz59Ts x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GTDz59Ts x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLKEsdL7kfX4/0V4GsLKo9bQ4K2K32phT5J/aaNwmW68J8np+NwEUG2NeZotoJJzz2rRnpt0giygUxzsoqJNgZumUNhr1mzZYL6yb1GG3C9SvZMjZ5oK
    Y9GLYo7UkUzIX6mE/gEUfJVs4ZabdpxjpTLuIb3NUERK9unJBum2aH5c3/2KA72hpYVLfUxYmj2wMB0+bGmiImj+ABn24bLQoQ8+SFHz9YW5gQ5vv6C4zvi/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=hWMQpYRtAAAA:8 a=KKAkSRfTAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=-HhIrDMZQhV7y-9XuqcA:9 a=wPNLvfGTeEIA:10
    a=KCsI-UfzjElwHeZNREa_:22 a=cvBusfyB2V15izCimMoJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932532AbeDIAe5 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:34:57 -0400
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:46358
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754270AbeDIAew (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 288/293] bpf: fix rlimit in reuseport net
 selftest
Thread-Topic: [PATCH AUTOSEL for 4.9 288/293] bpf: fix rlimit in reuseport net
 selftest
Thread-Index: AQHTz5lu1qzGrlrE506I8dvNqoqCFw==
Date: Mon, 9 Apr 2018 00:26:41 +0000
Message-ID: <20180409002239.163177-288-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:OS7Zv+HrbrSbOU+v7Fs0NGD+Bf08hkthrN6lvPVHJXcN5+xERq48T6ZWq6gjg/Z0BY3RBigJMj6C18l+towIb8MajGfWUrk3Nw+pCm0Oxdy2GUiLwVZAxvTf31QA6mjBi7sBLXVokz2MzP5S81IyJ/9IbTzIjHY56Dekm/v6a4JiiAUudbiTG/urvf2byuNVc67nyQfO9btm3gGOjFoZVyKNA8yuARGBEOhifRHcKjkWYl3GZ/ATgdJbiMKDlA+o;20:+BGnUzzgHoFY+meX+KLhEzVEyaJPfMstMinbBc8tf18YHUD2ctHMvde6cn8RoYNnHSgklTPimR3KocHDU1G0VGLD2+lctbJDgklWB0OvVcOQx5lpW6NysUl+U/KB9e0rnhCaVz/pFIh6DLgawH3PCrK6eGXVJG1x4UR7orUob0E=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ab14cc3-6879-46c2-cbf9-08d59db1b16e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08062C5A700DD5B9B5B00B82FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(6306002)(575784001)(86362001)(966005)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: K4t4qjeUxT2cMYHQ12+iw78PKQN0Qy2Mac4t4SA+I3PVJSgT6g/rn2WU0CCyhQUkmVSifHpCAJrt2TRKPYU/G4MXRZbSSnO+lKEMhUftsTsr1PSv4uHGNh1otrljf/1LJN5aondLfJRdqN5F71CUNQ3fdZpVOWSLi6QqwizwtfuZ8F3kvqtUZERu6tzEJY5YK4NccxZJcDAp0TESY7Lh/Q6QP+Z2qohCD3Lfn+4C63EpQHZqDtES2dUcR7IbNmU5rHO0EhX6RaVk7YdLqlmUbUg7ElwmIEkksOSO/bdPIS+ctKBFTmJZqa2/cfqPbZc2oMfyIcZxYEcabir4SGzkNLz1SKP/oV5w759IipGRKPxS7a2cSNpviV+Z26MbnC5+N9d0HuSPgwLtAXAMIjM7+5hKWAgkPWnQRHt0T5j6GD0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab14cc3-6879-46c2-cbf9-08d59db1b16e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:41.5822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
