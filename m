Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235297-2-1432458619853075306
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
    1523235297; b=RMVc4tIiib0YY91lzVGw7KYPU3IKptqEYUuXy+LhsQYFr2uQbl
    vTLVJBdPWkEaugkyog0ErYP/NuKoIRex85ILmbo/Q5tKkJGWZd03CF++n7cngxUO
    c3i+/lMh6jOtFLd6jnyXvXVCM8935vXZN71EoQVONUnCbIBFLrL1Omk71qsrIP7f
    cACYPloKPBWQP9J52wjSgdWd+392/nASK85UK2trHWuSj0SYpiBv/G8PGsVlDCsq
    R5Bf/hwqhe8toL01Y5XEfc7XtgF6MN7zRh4rcN+qtXhTiAlnO57sUSb3chUPLAA6
    S1Om/dsdnuhfnMCx26fXvTDxahoSUvD3DpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235297; bh=Dr6uioYSuw
    i0lKD5GNP8Q/BN1SOmELVmkfI9FjOrUjw=; b=V7RoWv0ZkCtQiZ9xgeLI6CqQmy
    sxEz0HF5dhNNrdkyfPqTRhXuIPOfRCOno3ofkAW+rd9uPRklMHDHJU4b+efK1Lhy
    oG441492ge4X1BhcuzBlKdOkW+gIa+FsvrkVPzVo+TrV1uu30MYvu40hZ9VwlCV4
    0eLdfd3a+EKHAPobSceMPIqh7GHLbY+NGnDmZtlqdFpCjuFKPvcl7lY1Z1G4Qe29
    deC3jhvpBQ+KFj4lVYGWYninf5hUqdeocrxcD9Rp6fTL94eVNvaaLRCJ1wx0uKQD
    oPrE5xtUljXb1MMd8HMsafBkN5ECqbTIu59IqwAEYFzN91AXhjE4howvh2nQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jNovamUR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jNovamUR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL//Qqs2a3giNoeyIF4uNKgr7nD2RQGRygciAyhoQjYVmZ4kZCI1YOAk3KMpRBOGeMprC4AtUxSsfOgmn2phnQLe2sJ9/LExhWjxskShXWGULQtKsN8t
    +V5eXh3/dlFsR3iYFYHutiry63DQQh2jVJomvUw6eGWJrFP1NNcWFQnPxz/ErVlkE7JeVqzLy05UOIoI+z10/bQTRUcTaDuJl2ph28bKlkYjbaHYNtQ6w5hH
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=48vgC7mUAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=m6LEtlOJsVEtUJlM7q4A:9 a=wPNLvfGTeEIA:10
    a=w1C3t2QeGrPiZgrLijVG:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932341AbeDIAy2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:54:28 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:64040
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933309AbeDIAk2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 046/101] sctp: adjust ssthresh when transport
 is idle
Thread-Topic: [PATCH AUTOSEL for 3.18 046/101] sctp: adjust ssthresh when
 transport is idle
Thread-Index: AQHTz5q5vfs8bHuh2Eu4DNPj72ZB1g==
Date: Mon, 9 Apr 2018 00:35:56 +0000
Message-ID: <20180409003505.164715-46-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:ymjIiUGA29WF/O3GqSU1Lvnj9bbH4A+9Y5MsPxWPU5o3GiT49mmQAOJLdJVZOoAK3u8LOQslX3hc1Jyuv4vDUH1IR+tEN+jbHtEtJTX/dEesXIAo8mdLJ/eEwckG90wcUlo43z7Db+YYc5p6R2HB5olE+jBfyCEdp9ZixeqtmBYAudVnA827Z1TDi6yvOv5vNGH0kOMmP8Gq02n2+y1rScJbnbXOPyPi7IP9kep5C46vMcvR0cwPbUmVnvLXUsnP;20:xPnYGYCOHdN2IQ7HBHEFRX+ZZjH7Go0B47XMXdYd7792GerCnARFnGa/1xbPj9ab869n5q/PUeKKRzC49vEUJUHCLZcbu4ZortHAXFGVWeqk/EC9j3OXZXBBNjV4jx718umVsvZCrGRACTDnXM+LZNwdwq0LxI0Mo+7sTJcKlOQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c59a965a-d53a-4a75-262b-08d59db27aa5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870487A94E8D2413AD664ADFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(575784001)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(39060400002)(486006)(59450400001)(2906002)(6512007)(6306002)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(966005)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: aEp6UzV8WxXHjwktNCZ1F0xSwOiydls+WK9XvsOOp8QrIuc9mWJyNatzUi/7eafkuRS2OWs5PtzaiATc+UrC4zpyH54sswnqjlS8ieqpRkfO335zF/TfX/6/RTnmBnwVH47aJ4yubnNUk/GpRNm9AcC0onsU+1TTJvNrmpCvoAamXPMV7d668v8AgeEhHdYspMiAyCB1uWfHXdkuerYX/KSspV7Px1lTtjjQJVP+20ukkddZnH6j3gdFpnmEEa57Qfow1LeliVQXEDqSwCOfOMIdZuhcwBiVvRMclLTm8zFVvimqCYtjJf7o9bBE7QnW9WPPLsSTMV72OTWWo2fwqOR15bnc0u0oQM22PE/gTCRxP5ID5zPzMteufGxbgnPVX6f7oumk7KYn3lNCCW1Iu3ucED3LcqygGrzynWADhww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59a965a-d53a-4a75-262b-08d59db27aa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:56.4391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
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
index a0a431824f63..3edaca07f0f9 100644
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
