Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240164-3-5838123316675528024
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
    1523240163; b=ok0TUkGodRjO7GEy8BzBq3wc+iCrOMf4n//DfxfddcgwQU4v3r
    yfiSQLwqK8yNMGiCKcKG8VAiNAvLf/smE9ZyRqVeD322URykHvB+kBBoP97zIQSo
    FZduFEV33fDd7ZfITrAYLiXrtDFJlb5cNURVJuGc7Mg+HL3LM4Z6mxBsdwCKnwYU
    NhpWC7UZ2tzMORvMHsKHCdna4uumYiPmFl5gk0M1983YCyiRKBnQuTlsFtiBYCS1
    bcQwAPj1P16O7v4kVo72zSWUruGEtQbzeJX9We34xbCenW5inPH0VtyMv3Jnkw6v
    kojyVkGDuQQpuHBp8IhwQxnSIUhkEA9x9lVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240163; bh=GCLLK9fSnU
    a8TxIjpA+II7c/w1l7p+ID69gW2IbbZwU=; b=JWYnnsuuTmwr7rYiFH6aBIvVMY
    AOofqX9MSkMNiHO13bik+IOO+p9tR0iIm9tDVxAMzXaORYVAqsmD9zNPFoQ+hF1H
    PVrsJ1bhJRmkNuwtnM3pBrMzL8fQsaqE8vZAk5i5slQtGYmECzO8eUm2InX2pRKf
    MVI++kUmHhzxOHvXnlrQRwsacPlqVFsdHkroLnhimmZlJ6X9DOKMEmO8yo9FFpxr
    O/2ZwByX2gb1+bSInnPitrmDOZGHY11AVaA55rdy88Uk9m9lspwUuqydp+DWnGRO
    NMxZa9cCvwrsEF9Flca0m6ZLz98nB93K8y24Dw6i21H8QLQff1ANnjyrtvwQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Odz7Wf2t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Odz7Wf2t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBpkP35uampsSzhSnY/wtcKZPUx/o2oJjpVeXkS2Atm4Mlynz2h+BhxQgw6RTCWQF01FZBOc8eIkaXdQNodkv15zlyP5BMcHloqTr5LhTa1p2xA4wwZG
    v7duKVCAAj6UD3aFQNIes8P186veL3xlVvO7cmegMUt5VbkdN1vksCQOmkuFZq8f55KxmmMy2DJl2Hu1JEfCYlGHNbZ3HKipPrwFS2qdOUXgykXNLw066u09
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=48vgC7mUAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=m6LEtlOJsVEtUJlM7q4A:9 a=wPNLvfGTeEIA:10
    a=w1C3t2QeGrPiZgrLijVG:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932144AbeDICPN (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:15:13 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:17478
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756080AbeDIAag (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 144/293] sctp: adjust ssthresh when transport
 is idle
Thread-Topic: [PATCH AUTOSEL for 4.9 144/293] sctp: adjust ssthresh when
 transport is idle
Thread-Index: AQHTz5kpSso8gShfnkaOnkyEr6cjIw==
Date: Mon, 9 Apr 2018 00:24:45 +0000
Message-ID: <20180409002239.163177-144-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:vzBQhpzV6wRnLGJ8RUpeUqFfL8K5oML4M0CNWnGt2JaFhW8C6B8yMO/AebkvHE+ZARISHg55/GDaWoAiDwfT4LcLcCtUSI7Nf95weqDzID7Mi7WY3qT4t4FJxlDtxTxmAOCbhRgjdO/RZAzsqS5mGjujMcUGQ6cMliC9I0c3DisiHckPXvbHMzuBnyIwcj46MhezgZuC4x0qOeYvsQR+8EdZ13Jm6PVNjeF2s+S/pbmX6ZqlvYppTVmcNht3YuVf;20:WLcLU1kx7jYc9I4OoxPvlvtElf5hmmvqhlGmTEYEFFvmSrrG2v0SnPFxvnN1jeedq2EtH8TEosBk9+FDZiLWz7YQYw7s4pLsu6zJktB1glbKXzaW3SyFienM04iGeidFxoyLz+c6zqQSuTN62paRVcQRi89/FNEWzHHKPabaJcY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: df88a098-f5ce-40a8-89db-08d59db119ce
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08075C825900F592E5466A5EFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(966005)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(39060400002)(6512007)(478600001)(3660700001)(6306002)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4xu21TRyfeD2BcU9K/33uOxzWvc5SmD5teeWDXag4aiTtyzveTKekmUD6mOcDHdj+lWkOnIyUQL8veSmC2DontgvBETKfh6x31GVjCrIcpdpGELA++pfmEyd2+RK58OohNAhfLzO+VB3CSQf6wfWAspRiIJIrUkv7TyIMDeEXoFrrmwVgNqKvy2Xxdrak4Ykx/fUvpEvuuA4VT3UknM3PUaOA/ujvl5pk7yGpBOYF6pP0uEDxLG7q6uDNt0qjD2YAHfSPGQjlWPkNTuOunVUnsfVFVZMHFSsVFteKHCjh4noeVpNZCh8fJSY37K9iooei7VhDK4jYS9R8kqz1rDRpktWkk/9fZOMRs+nN05rKHm9W7bngDlsuJhz7tRvVJO11WMiY/u7X9k8XeM2TcY5l8LfzksrP7iiHPgqWFuecIY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df88a098-f5ce-40a8-89db-08d59db119ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:45.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
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
index ce54dce13ddb..f130167ea323 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -551,6 +551,8 @@ void sctp_transport_lower_cwnd(struct sctp_transport *t=
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
