Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523245003-2-6278379265695244789
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
    1523245003; b=BL/GJuQtCuskGS50spiH8JBfTM4dX3AvXxE6BbVAd8c4kVc/Kx
    d9XAH7kH1gfyW6M//oXOhbT9nyzDW6xLQGR8yoPDxE0tBs2zyC1T+6+b0Z0fyo1V
    b4LhT+9mFF+NYF3/jcurdVB+83JQsB3E4WVy6Z8o7pUHkMj5fiEM96DD/TkTVnlL
    9geVgxrPxCbQPJo9eQwHeUkAElBVEvFP3+00h5oq5UoWzXVEnp7mjh+mnJ/7BEbB
    B0qzoZWkwksbJSVPvBCidRl9oq+hTSBM36NcuyFEBImFT2RpEaeOh8inqha++DzW
    NNBNTFdclRFusTRZNJ10Kd4u+o1CmuKyAhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245003; bh=VA+600A/gV
    zoaBrXLUWbOtFw9f5GI+oV+DnXwHH7BiI=; b=rbkev0uvZfAVSrRr12j+X2n2e4
    cegkYcsMBe921iaZLeT31TPkW5Vg0NZ0WgPTQFsTbd6fDeLBC+QG67v5TLKpxZra
    nnUMUetg+Ys7IcVkGYnFz7whxYbW/3z/CvPPWC84pxqni4FZZoqDjAeCRbu/3JJM
    rjGuvG6wdk9Gt1iN9mWCWWS0vZJ0az6CvBnlUCPeTecnxg2Zrudizn73YgDNGXS6
    XLuKdb9J48KCrhvU02ydNsqL9QtSfC2v2dNrWY2PGUb9KVxAk35j3ncCAmN4LBSt
    YlF7nP24IfitEPUek0Rg2I1XuQwzmgSGEkwdc9xcsd1TZOcOh6FG322vLWIg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eeIlTr/r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eeIlTr/r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE5nsfpFnUsD4HYJrKb6bLRRKznlRVr7/3wN8DzjTB3jbQUoETlIQwjt+JzmGLe6FcOBGaJ+1FaNgdk3omLKB9LELUptmJP6XtwjFP1IS1aXBcwvt6hd
    3cuMdVMdyXJWi4lH2j5FTn3IbsuPiXr//objiy5JchGdEGomPBqIcC1J+d0tQs16j7rg4c2dX8JF/yFZ91PbXFe/P2JuCX0Ox90r+qj7C9nE+HheNe/+om+W
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=RDYB3ynxZCTlTJ5NAJ4A:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754480AbeDIDgj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:36:39 -0400
Received: from mail-bn3nam01on0124.outbound.protection.outlook.com ([104.47.33.124]:4000
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754386AbeDIAVK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 164/189] rxrpc: Fix received abort handling
Thread-Topic: [PATCH AUTOSEL for 4.15 164/189] rxrpc: Fix received abort
 handling
Thread-Index: AQHTz5hbC40wMXXqmkymBZY25UL7cg==
Date: Mon, 9 Apr 2018 00:18:59 +0000
Message-ID: <20180409001637.162453-164-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:ADPJ3UPcY4iiOAYUXRVvu4WPsCiBy/yA4xKZD/fh1pWnTdGm8Dmfc8gSqTJSYl5nClFrEvr+W/TJMykc9aA2ScR9pwIKRMSDIzr8cdVKd+ncMCfsFbGdE6tn80KyMVk5JBqqdqwNo4v3Kxk0k9j0S9g2Ib+npKa1O3UDPTtAucOBDqwP8z380woA+sJxoLaCfez6yEWAKrvcTew4JkIRua48LkZv3cMkbJ28KtaP5wu4Dk39hHDyoH8QyI8Tlt9W;20:ghj1hvalTCgkupIZa/e1QPOE7trWZ2LMwlA7FxH8Hf+D0EO2iDP31PttQ0vM+YQ/dmLJRTne/+qxPCmme+38RC5vrarpJWmaJGIRNlrLvU508YXcsquYB6Ejv7yw2bWuoetcbMSJmFb2aK1Hd9wAdoM0a/cuCvSfXZPqwnaNj3g=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 705bb387-ee23-4467-aac0-08d59dafc98a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110C8CE8EBC031F099B37B5FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YaHM38YwcIfpdnmZ4rALHGbsHc+teer3PLNlAZqLVv3C+6MlhpSQZJqnurV5gLyGeimOVMcouPVx8l5Og0OG7yLbJaN1Gt+0GtPPBWrQJn2wzK3FtJMCb4+RykywY9FQmd5dmJffGIRWTbQjiatDnO815G19t6CRy7JMaMVk9vdBrE9d6sqQnm8KJztnk4V8mZDE4mcu1SvcWk6QuPapKk94XtDRg5S4hl5d8FfMGVqGlKGb1o87tgcl/uLAuI7bxeCgG80/22PGBuB6gNfPRQSJj9xHOiJF9BZaDJAxgkASyv5htBtg7KMEI8I8gsQSPW/3Gbf4Dj6nw/YFgYBIsTaeIwTzICaQYDXIKEXc4JTKRKXJmDCaOwA7dFWXLvvPe2vhPHG3nm3ct9pTPNv3zDLe6mP72VwYC82LZ4jIb78=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705bb387-ee23-4467-aac0-08d59dafc98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:59.5805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

[ Upstream commit 17e9e23b130e4e269fa53c2370325249f3ba75dd ]

AF_RXRPC is incorrectly sending back to the server any abort it receives
for a client connection.  This is due to the final-ACK offload to the
connection event processor patch.  The abort code is copied into the
last-call information on the connection channel and then the event
processor is set.

Instead, the following should be done:

 (1) In the case of a final-ACK for a successful call, the ACK should be
     scheduled as before.

 (2) In the case of a locally generated ABORT, the ABORT details should be
     cached for sending in response to further packets related to that
     call and no further action scheduled at call disconnect time.

 (3) In the case of an ACK received from the peer, the call should be
     considered dead, no ABORT should be transmitted at this time.  In
     response to further non-ABORT packets from the peer relating to this
     call, an RX_USER_ABORT ABORT should be transmitted.

 (4) In the case of a call killed due to network error, an RX_USER_ABORT
     ABORT should be cached for transmission in response to further
     packets, but no ABORT should be sent at this time.

Fixes: 3136ef49a14c ("rxrpc: Delay terminal ACK transmission on a client ca=
ll")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/rxrpc/conn_client.c |  3 ++-
 net/rxrpc/conn_object.c | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 7f74ca3059f8..064175068059 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -834,7 +834,8 @@ void rxrpc_disconnect_client_call(struct rxrpc_call *ca=
ll)
 	 * can be skipped if we find a follow-on call.  The first DATA packet
 	 * of the follow on call will implicitly ACK this call.
 	 */
-	if (test_bit(RXRPC_CALL_EXPOSED, &call->flags)) {
+	if (call->completion =3D=3D RXRPC_CALL_SUCCEEDED &&
+	    test_bit(RXRPC_CALL_EXPOSED, &call->flags)) {
 		unsigned long final_ack_at =3D jiffies + 2;
=20
 		WRITE_ONCE(chan->final_ack_at, final_ack_at);
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index c628351eb900..ccbac190add1 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -177,13 +177,21 @@ void __rxrpc_disconnect_call(struct rxrpc_connection =
*conn,
 		 * through the channel, whilst disposing of the actual call record.
 		 */
 		trace_rxrpc_disconnect_call(call);
-		if (call->abort_code) {
-			chan->last_abort =3D call->abort_code;
-			chan->last_type =3D RXRPC_PACKET_TYPE_ABORT;
-		} else {
+		switch (call->completion) {
+		case RXRPC_CALL_SUCCEEDED:
 			chan->last_seq =3D call->rx_hard_ack;
 			chan->last_type =3D RXRPC_PACKET_TYPE_ACK;
+			break;
+		case RXRPC_CALL_LOCALLY_ABORTED:
+			chan->last_abort =3D call->abort_code;
+			chan->last_type =3D RXRPC_PACKET_TYPE_ABORT;
+			break;
+		default:
+			chan->last_abort =3D RX_USER_ABORT;
+			chan->last_type =3D RXRPC_PACKET_TYPE_ABORT;
+			break;
 		}
+
 		/* Sync with rxrpc_conn_retransmit(). */
 		smp_wmb();
 		chan->last_call =3D chan->call_id;
--=20
2.15.1
