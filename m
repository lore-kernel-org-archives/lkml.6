Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517682886-2-8431596015723644366
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682886; b=nzdaFA7XSSl/N44gbNUoHq9r9cFhVjolaBlG+/jdmsOO+td
    Xvs3B6DSkKtg98rTjI7mDWh9GhL37RViaHLT8bRbakSwj73EtfovIQtWH3nroYYA
    Z4ZpLpzEwDmA5WLfldnASlTgszV5pVaQNe4irCpgPSMFEfp7OczDPoEzrx3WOmOS
    Qv9mZfyEQ4jwgPZbBBwqJxJ5ddQ6jz5apnm/Wg702iM0H03jnMexT05QuI5C9qKG
    v2h3Ag3l+7Foe+UE7OU3WudeYKqCtAO8A1wTQOPMl0LVKzSompJ1ankwM6Swog44
    9EDDLUbZyBqIl/cup+IuZwv6W5UtcdPuicJpsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682886; bh=kr0m4U
    OB13ogS0jmeLFmjiEZ+YaAKiju4rqzif9yYQM=; b=jXwXFvfnS+/e1afy6o3k1v
    2Wapwi2bt/5gHx9VsDit7KI27fVEoT+pjd2PzJAlJ/QWyta2sjQRb9ZJQrMY95Ot
    BN5z+IpeBQ7V8iADOqN8CkaAj4/SaXyeFXh2f/v8M1zQP/90qVnAl3JX1WIzBsQ+
    iDHFnD9ISRGN8SOPm/TzSe5DTWPel9Ei9QuxOd6H2jcCE0U9B5tlaEgJEDscfPxG
    U2VVGqa2yiZowNBi+Gdu5ke/8VrXCAcfeecVaIfz5l45HBVoQrJz2b3A4Avc92tL
    lbvMvFfr3AbeuKZrN9Pfy8i1t4O8CCZa7sk4MGI659cCjlah+FgHNGdtwAtcdN0g
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PDadUHja x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PDadUHja x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754606AbeBCSeh (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:34:37 -0500
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:64103
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752784AbeBCSES (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 105/110] sctp: add a ceiling to optlen in
 some sockopts
Thread-Topic: [PATCH AUTOSEL for 4.14 105/110] sctp: add a ceiling to optlen
 in some sockopts
Thread-Index: AQHTnRkG5B4xDnB9Vk+c5dT0DTDqJA==
Date: Sat, 3 Feb 2018 18:01:33 +0000
Message-ID: <20180203180015.29073-105-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:CQg6133R2j4sZn/lhNXmwFVsKUV4ZoxBp3JGl6vbFr+V0Cq4feabQU0mjoHab0NR1/4NzKA4Gyg+BfqTy9i9JtE8l/PmnUedfzqkmUcFO9B7yORa40BW3rMmS+AfWNpQ6gITr6IiERKJlQzRr9yergyjDqMiokuZkOQUC3K0yr/3YUM1bxhZqego6D7JpXewgChKfdpclSBWg1x6TQY8wAR8I0TQL6ozkAACSGx8+rhbCsfkKJW3IoA3R7wKMOgH
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 389e1540-277e-4c5c-9fc4-08d56b3058c7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993E826B589B3EF6FD4B95BFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(39060400002)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: BfF8gQE9Q4knpmNLBGcQztp1lAkIy4TG+D3QlGGd1EeRC3e3F1EYSg0fu5tyG7d4ssEBvvAeRsc707tlqZAgKA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389e1540-277e-4c5c-9fc4-08d56b3058c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:33.7846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

[ Upstream commit 5960cefab9df76600a1a7d4ff592c59e14616e88 ]

Hangbin Liu reported that some sockopt calls could cause the kernel to log
a warning on memory allocation failure if the user supplied a large optlen
value. That is because some of them called memdup_user() without a ceiling
on optlen, allowing it to try to allocate really large buffers.

This patch adds a ceiling by limiting optlen to the maximum allowed that
would still make sense for these sockopt.

Reported-by: Hangbin Liu <haliu@redhat.com>
Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sctp/socket.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 1c08d86efe94..978fc7d1cf53 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -3485,6 +3485,8 @@ static int sctp_setsockopt_hmac_ident(struct sock *sk=
,
=20
 	if (optlen < sizeof(struct sctp_hmacalgo))
 		return -EINVAL;
+	optlen =3D min_t(unsigned int, optlen, sizeof(struct sctp_hmacalgo) +
+					     SCTP_AUTH_NUM_HMACS * sizeof(u16));
=20
 	hmacs =3D memdup_user(optval, optlen);
 	if (IS_ERR(hmacs))
@@ -3523,6 +3525,11 @@ static int sctp_setsockopt_auth_key(struct sock *sk,
=20
 	if (optlen <=3D sizeof(struct sctp_authkey))
 		return -EINVAL;
+	/* authkey->sca_keylength is u16, so optlen can't be bigger than
+	 * this.
+	 */
+	optlen =3D min_t(unsigned int, optlen, USHRT_MAX +
+					     sizeof(struct sctp_authkey));
=20
 	authkey =3D memdup_user(optval, optlen);
 	if (IS_ERR(authkey))
@@ -3880,6 +3887,9 @@ static int sctp_setsockopt_reset_streams(struct sock =
*sk,
=20
 	if (optlen < sizeof(*params))
 		return -EINVAL;
+	/* srs_number_streams is u16, so optlen can't be bigger than this. */
+	optlen =3D min_t(unsigned int, optlen, USHRT_MAX +
+					     sizeof(__u16) * sizeof(*params));
=20
 	params =3D memdup_user(optval, optlen);
 	if (IS_ERR(params))
--=20
2.11.0
