Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523237092-2-11224464205659268807
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237091; b=SJZjPyMTS//YARxoG1TXmCXox26rnb3jwO3QzXoxhOFsuIOmmw
    dDoHhB+CeVnZMouNBs0HYH1E7LX4kenZpXpD7Ug4yII7PAWnc8cyCjx3AvAS5Sda
    55sTvSgEZygG9KMZO/+swAlWdIatq94+RymHFKgueH1XMRY7jskJLzxrs4H2xWVA
    VQdtqtI8kfIs7I7Jyk/CvdlzXowJqyi8Orkb6li0mxOkJNw5HFCSV0pABf5XOl9/
    V7lG/hbROlVWl5bxdF4pYX1rxMsAoEWDpBjnfQsMS6D132rCyaNuLdQEyX5vb7GO
    1tYlQ1gKALHcVrh1DZUprGQxcmZPABNxmKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237091; bh=Ux/e9001fx
    KrrWSLp+Q+LRHhtER2elYPOqm04zwlduE=; b=MkduTLY5TfcuH5Y/HUIm6JWcvR
    cWofvphrSiZ7P4hiZ1PYhwpdxQURxZ5ExBiv947/q1osKqH5xAhjZ3VCwCcKeb68
    YLJRKRcdC6t4L/4nfrvS+z+Tmdcl6TKuZYZguKpcU1ZZOFzQVz2Gi0x7T0jE7NU/
    3NMf8k+yXdbtNSknUkvcUmVL7GpHS5mBlAUt0Y08frpz1/AJ27e1E///a+uF0rQD
    2j0F7fw4zFMekafY8oNgcdcEl20v4FIxeuTdTG8JcjlHp9yDL1EVGxn4Yis8GF8t
    3bDrOwVQeGQBq7Z5PnhX5TUQ3KF7QlYvZAq71NdlfWnL+qu22cYWOi0zu0Aw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OjVJZ9tE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OjVJZ9tE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK+6yIknPEgIOSjMnlq3ZxhMkI4lcWdn57gbN9x7Gxo56EKwihQlN8yLFQTvwJLnV6vEWW3dim5trUKgRYZ87/dHGVuN/e7ry+RsDGBPGf4gcT061/Mq
    Vs+6KkrL8PMylOpeBYBUJVGnn5gANjD04gmQKUpdcGsbZDmUZ5W+eT11CvNfCpV/pWE/PkXzyh87Iu9y6Wheb2JJ2kWGEHcxweMCiM9wU9Bqx/7zW9otI1IE
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=48vgC7mUAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=m6LEtlOJsVEtUJlM7q4A:9 a=wPNLvfGTeEIA:10
    a=w1C3t2QeGrPiZgrLijVG:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932133AbeDIBYW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:24:22 -0400
Received: from mail-sn1nam02on0113.outbound.protection.outlook.com ([104.47.36.113]:53303
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932705AbeDIAg5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 071/162] sctp: adjust ssthresh when transport
 is idle
Thread-Topic: [PATCH AUTOSEL for 4.4 071/162] sctp: adjust ssthresh when
 transport is idle
Thread-Index: AQHTz5mxfwGI0Jk9BU2I2YvxwjOohQ==
Date: Mon, 9 Apr 2018 00:28:34 +0000
Message-ID: <20180409002738.163941-71-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:BPGs44aQXDzmA5IPALETxeRJ9Q9h1moq8TPM6/SjZueIDFXT92WqpqaohW20NRIjIsD+9ZN2izJZMpRTOPaDSIZNfwvdV/zlsEHHBpdtqfEsHXrChD2Hqke7f/Q7yp+LqVsTjxAAoYXVGt4OK4LZAJRVBC1vI9hsAmdzdzlT5Nry4P7r9TsUiLULm0Af0pGm7QvZYWiAL1HSW/QJ4r7CobStOV6W7LsS3ayEMIJIIwAuCSR2M2ACz0FhLwbO2Tkm;20:DdhYejNerzaIQZ4mL56xncgdkPb75n1HW0EzvCZxYK5XdkfFNMunqd06c9Y/n4kx7Dhbt4WK5PtgF5qH6B99joBCxuZa5E2uYbTIpoHp63R03ZOmjL+ybeacJlfB3ZSYBpIZ/CiGYnzLjT6dwC53p0W4as+tSz2PRZzt6w2skrc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e951bf9-3007-4280-3ad4-08d59db1fefe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885445328048EAFDC78EF86FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(39060400002)(3846002)(6116002)(59450400001)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(966005)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(6306002)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ckQElbyZj8dSOqUzgVBZn6HFR/PFg/olLtSpEzRAelp1ZRkh0sxRLVWA8wrzCHL87y7Qyp0qryRKuZ4iKvvCfhwlwhbeQxq8BDGezWyQTBCQXcrPKc96ZJyiV8kUmAUgvGjRDUsnaMc5xS62F7o7kdhpUCK7mLEGqK4bktPDSe7RLxIWVkxqBDlx5BKFn+uoijw/yzRU5iki0rozFYlQX1Uy9LDS7edUslrsXoO0XYocoSm/Krd3/W17RnHRv3fdEzvpVq/DLaTMrTeVXGnGQCggj8ai6XaSWFqeBM1Ick5AC77GKAD6kWGEkPMV83oN9cZ+KwH/jn+SUvRQwejYO0OWmSKKcpNEtl7EAPjyc0zigLuAAuqaAmL03PVaGQLyJvCf0bCDgqTOweOBKDHAFgXlbQn5A+toc6gMn5hETgY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e951bf9-3007-4280-3ad4-08d59db1fefe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:34.9739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

[ Upstream commit a02d036c027e9070ca27c156f59eb445d5405480 ]

RFC 4960 Errata 3.27 identifies that ssthresh should be adjusted to cwnd
because otherwise it could cause the transport to lock into congestion
avoidance phase specially if ssthresh was previously reduced by some
packet drop, leading to poor performance.

The Errata says to adjust ssthresh to cwnd only once, though the same
goal is achieved by updating it every time we update cwnd too. The
caveat is that we could take longer to get back up to speed but that
should be compensated by the fact that we don't adjust on RTO basis (as
RFC says) but based on Heartbeats, which are usually way longer.

See-also: https://tools.ietf.org/html/draft-ietf-tsvwg-rfc4960-errata-01#se=
ction-3.27
Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sctp/transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index aab9e3f29755..d0889e560615 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -546,6 +546,8 @@ void sctp_transport_lower_cwnd(struct sctp_transport *t=
ransport,
 		 */
 		transport->cwnd =3D max(transport->cwnd/2,
 					 4*asoc->pathmtu);
+		/* RFC 4960 Errata 3.27.2: also adjust sshthresh */
+		transport->ssthresh =3D transport->cwnd;
 		break;
 	}
=20
--=20
2.15.1
