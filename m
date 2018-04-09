Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235565-2-9120432396767689453
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235563; b=Tu5qFnvFBdSCOympD0gj7bxq4RfG2bvjbqhE5YY2dAzIf71ypA
    TI8sdGBvgYyzaemO3saRWBL6MUkgPpNh0rGZp3pHTsBaV2euPdVLKj5WNq02MVqa
    PQpQFdUA6rjdNE9u9ek/ZxM3TMdN3hjtZzOJv95UxD3fbfpcWqON5QDPQcRYqR3g
    w3gmwJnaQgBGv7yAXjzO1FKa+xpmBZPOJgO3hJp/bP4CFVzSauMhqYXqmUN9SC0g
    e7gpmRAISrOXRxfTGdfQw74DdSsfIaUA3tNhGc2XSQKlnDxJL93UsgiKTz+wyyZP
    +4c7ZBg468G3KZ+MuXvrgx3c82ZPKA/XoNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235563; bh=E0Txft4tVe
    dJutdMuOVkOzN2kw5dRyF6zQa9+cLWQ0c=; b=wE13mipvjXh0MO5d1bQ6F/ThAO
    LVIv8Y50ZIdmzBXI6Jt2ZQ7SmoAUA81pUnhHnggO+Bgyl9Hnwu1Wg51hahsszS8F
    rz5OZBBiQ9BkBxPQtFVKLYNOGykcYZSZa9XpBnRkbe5xn6TyVtTP3FdHHm+2uJZz
    QsRCDeWaRdZeNsF1GZIjytIsB5Tc7vOuaiR/ij3WJ7R93/2owHlXaz42Dk0PLdp/
    /iDcal4+leaFplJhUFzKO9mbU4Vv5uRza4A76VLEDtNyOH3SmYzY/Z5HIPAc5e38
    9JlpA6KU5BQp7iOg8QncUfqGAX0D7iAvxE8AQjH6wxUH83lBh+zyiSN18AaQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NdnlP7fk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NdnlP7fk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG9wNIbAeAkQ8Zw0Q59iy92rdIydH42w6fg05gD69a1Km9WeU7CqAvAHxLCJyhsRlguF9dU7vkD6enZPn3RyMiHuAu5FgxisEkNqL8wmS/w1M+9fKtCn
    uiLlEZw2kQ7fuUx5nzxD1mINorbVE6XMJZ4xGihg9t6a9VuaA1Z2CJvEZ4kw/FKw/SmnMXq16jzar4O9dqN87oXKpMVAKFeuFX92L2da0MJCsrW+Hv46ISaQ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=Crlv7Caxbz3YXNOajsAA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932777AbeDIA7E (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:59:04 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:21055
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756336AbeDIAjo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mateusz Jurczyk <mjurczyk@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 028/101] caif: Add sockaddr length check
 before accessing sa_family in connect handler
Thread-Topic: [PATCH AUTOSEL for 3.18 028/101] caif: Add sockaddr length check
 before accessing sa_family in connect handler
Thread-Index: AQHTz5qtczPGaJqWYkCRC/pwwjWIUg==
Date: Mon, 9 Apr 2018 00:35:37 +0000
Message-ID: <20180409003505.164715-28-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:bSEPVBKWTi85qlSyoa3aLV5P438oTapC0cHqkTa6IfdOqXosoA4D/Q+SC+V+O8TWutnUO4FisnuNW/xUqHZLLgh8jnlPI1iPLq6fuq8ILbPGzxJ3zV91fzKWDDkvVOxOMnR3XEO8edr+WzD7RyUlk6tXAls8A/zRpU5Jo1pqm17S7f6FjBFW7qtO4T0/48erj/gna/VW0HxzzpJkAEzFWMi6kTRaFdlnaM3rhIov048F5/fWRQJq+GfbLGeqs5E7;20:L06LoHlevS0dkr8d74wPPR5HRBihw7c1D/rYFx+5ScTtVmbyIdVEzebdU40LrTiFcGh0n0fDy/sPEK6J6VbIzto9WA3xImxFPhZ4Ci6NCUDpe/fMRWycreEW14KqL7j+SMgXxcJJBELltgrEFozRyboedQUkFHOhDc8TqYwsB+o=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 048637a4-e780-4e85-9dfc-08d59db262cd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966D8DC39956091F03F510EFBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(575784001)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: LkusTGrsknTsP4On8nCNUG6Z29H5rRTuX1Yu26zP1chyHO2M90i59ihkoYicH3G9HpwqFr5+ku8kOMPn2YHvca7lMAWIqTl8r39X7O+yPluMKiQYk35+yujfnQXExTWVXYCcoVXLPivrClmfpRDgkpbNrbZVfyud2mLxKHXYJMSHsuDpGmuUuWrTDFTrqA+6aoW1rJSaNm5mNe7p/HkoOBV25LfS++PbocWRGfra+1gNxGB6g0PJdAzh2XsfIxUdGPk0cS/T5dUBrXu36sngd3XBb4utiVp2tmXayd4bsPycsjMAvOVLNa3b1bpVf0L3kS9MRZjSpnXXc78Z8QReYUPsZAnPey1/cgnCaFrU9ICCTw4EpAtBnmIlxiw/YGa6X1tfXttE6wCqLGm4bxVAtUPgsMPlssVaCDonpCKHXGI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048637a4-e780-4e85-9dfc-08d59db262cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:37.5641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mateusz Jurczyk <mjurczyk@google.com>

[ Upstream commit 20a3d5bf5e5b13c02450ab6178ec374abd830686 ]

Verify that the caller-provided sockaddr structure is large enough to
contain the sa_family field, before accessing it in the connect()
handler of the AF_CAIF socket. Since the syscall doesn't enforce a minimum
size of the corresponding memory region, very short sockaddrs (zero or one
byte long) result in operating on uninitialized memory while referencing
sa_family.

Signed-off-by: Mateusz Jurczyk <mjurczyk@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/caif/caif_socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index 5e10ee0efffb..40389e5b8b32 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -758,6 +758,10 @@ static int caif_connect(struct socket *sock, struct so=
ckaddr *uaddr,
=20
 	lock_sock(sk);
=20
+	err =3D -EINVAL;
+	if (addr_len < offsetofend(struct sockaddr, sa_family))
+		goto out;
+
 	err =3D -EAFNOSUPPORT;
 	if (uaddr->sa_family !=3D AF_CAIF)
 		goto out;
--=20
2.15.1
