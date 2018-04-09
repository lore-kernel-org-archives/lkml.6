Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244945-2-2393133448331308714
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
    1523244944; b=K3DR5oSUMlpWu5xdaOZeV1SzYm9vVSWyi84gLG/lmG19OLXu0e
    gSb8SqS9twr4VYEVI1IxdqvUR81Hru//t+t14dPMRdCYzB+oRDmoJgVfpWX59lGN
    c8XAkCA94AtdYfF85R+EAclyLMxcdPo1UbF+zI98zlmf9ND7gQIGfRZmtk0P08LX
    qzISHgZy7LBGsIS6aWhVsPM6UncdYouNfHc5SPr7MeGHJFN1vnKP5eCGO2TclX5z
    6o4YIkAtecjb0RVhmnOpqYpELI7UDmFxNd2oUXmSbAR/RE3O0mmU1+UIaKQdjAsn
    krPcihJozaHwzHuoQSIPVqOifYSBdtCzGSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244944; bh=5b78OoYqT+
    MEfnPLrX++jD8sqVwomxZ4j4gnBNfNI24=; b=I2+CzMVZIJByxAlDpSqY/zvSKs
    x8XmsPlahabN/ubrQqpWK9FAYI9EpD7sLXIk/yH35h/M7z11SW3D16wb6VzHuvAw
    U+dzCWEcQYgfUtTnCse4w96pQtJ/F9V+rKtUtTVgIxBxNCuXIgkI9le5y4RywueV
    dt1BXnGhAHjSTikPbD78UZ2j77uabm1FCOlhVzaMsxaFI70L/gBNPell7Ag/qS0R
    Y92VTeByo14kY16Q8tQ4sbu9BNNSNzcR1rh+h8qm5xOSRpGtvE6/I7m8GsjrEiy7
    BZUDvT5hGYzUOmQ2h2xai5+97EVy5SuaHK0gAFT/gT9Y7od+EEJ0dxZ5IlrQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n/lwg60U x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n/lwg60U x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLnAeagMQP4o4JD+8w90WXbnajClMK8F7lU+uKlnI409kDwFOY1pQghCFCNEug0p/NOeymNo7TC72C69DKk7ufoB7NhKxqcs78WHfTwWt55esJ/cWDZ5
    L3mSlePSNJz+Z44bKrNceUhzsyZ7xnO/nGqFueeuVD8vr15A8mMhsZtjYOf1LyJZiP/jska3THAAIkckyAiquktHS2hOBTwjbM6gD2fKfkrqMxjGtFrBnvGV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=Q8eMNLGMAAAA:8 a=BS-Bl4eDAAAA:8
    a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=fRbur1geQbNQeGRPq20A:9 a=wPNLvfGTeEIA:10
    a=raiHlmlptQsBXkgpqFpg:22 a=Mz5RY1mrK68yK6INR7tS:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeDIDf0 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:35:26 -0400
Received: from mail-bl2nam02on0107.outbound.protection.outlook.com ([104.47.38.107]:21664
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754407AbeDIAVP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 169/189] rxrpc: Don't put crypto buffers on
 the stack
Thread-Topic: [PATCH AUTOSEL for 4.15 169/189] rxrpc: Don't put crypto buffers
 on the stack
Thread-Index: AQHTz5hddYiUQ0vvUUiHL9j+DGmg/g==
Date: Mon, 9 Apr 2018 00:19:03 +0000
Message-ID: <20180409001637.162453-169-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:XNBTRTmECrItScp57tJPDMs8bLZXwtoA+i/Ku5IukTDEODyU5XGJic2s4uG8o9DZsqtDLQ0xLsJyRgRlYfGTkwTHwYh1aobihFqCIJ0OfH7iGgbNGonvGyVgY2pPpE07z4qOg0UTSVBuDFaoA9pLPyHEzoiDTCcuvBZbFQ7Ow1z9JmmzoPqjK9g3ZQPZO6QSjaEgC69UCRWYSvxAWJ8dMo1xiWM73LZ+fehUmDhskz2U1j84Md6N84vp0woSGeUh;20:ghW4dAF9BhYvJwiM02Wj+0LDrqRPT7WrqDLEnp1O5PKbZeucOv2nLt8ZHuFzOEdfdzEwSQavMUQNq/i9McxN60a80UKA4qo1mkaFetsJ7Hn3Geyy/GnMsyEzh617UwDsPIaQ2/zQcEOOTYG1neAyaT1fu4O/xQYKn9AULucO+rk=
X-MS-Office365-Filtering-Correlation-Id: c444dbc4-4f0a-47b1-58c6-08d59dafcb60
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125F9319F08AE4BF4EE0301FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(192374486261705)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(59450400001)(106356001)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(575784001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ibu6L7Gk7Im86MvTYIq11Tf4ziu2OOO/a4e8NONQBBj8ClQWuEi6KvDlLT95XxwSvCNJCuUg+Uhgq8iKohQ67lGxwgTCDm45fA5kZG2oQTtnTAwyWeSKMgNXDkV9wGsQcwbyR/KoyLnee/H9bPEVg03kPCdG3UgBFnKTu/QFIhDcX8hw8GixOu8vF01ezj51VC+ZCoqB6NVQNnFiZg7MwFysOgys7dBhYfUgDRIbcegCCrFhK5xm8sEnIre2+sIJeYyzUzZiWoH+4HlD65g9AnIPQw7l0PEx8ixY7+5jns09Gi8go88DIZwrxX2ZSD59acBVRVA7t1ZTOqf/kptq/flLdGTAT9AX+/MI+DP9zT2SXKdzpS9A8RD0V6OEJgLwQJAe9CZvAN3OWs6BvK6vY/kF2S1amt1NZf51/8/s4nU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c444dbc4-4f0a-47b1-58c6-08d59dafcb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:03.2991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

[ Upstream commit 8c2f826dc36314059ac146c78d3bf8056b626446 ]

Don't put buffers of data to be handed to crypto on the stack as this may
cause an assertion failure in the kernel (see below).  Fix this by using an
kmalloc'd buffer instead.

kernel BUG at ./include/linux/scatterlist.h:147!
...
RIP: 0010:rxkad_encrypt_response.isra.6+0x191/0x1b0 [rxrpc]
RSP: 0018:ffffbe2fc06cfca8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff989277d59900 RCX: 0000000000000028
RDX: 0000259dc06cfd88 RSI: 0000000000000025 RDI: ffffbe30406cfd88
RBP: ffffbe2fc06cfd60 R08: ffffbe2fc06cfd08 R09: ffffbe2fc06cfd08
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff7c5f80d9f95
R13: ffffbe2fc06cfd88 R14: ffff98927a3f7aa0 R15: ffffbe2fc06cfd08
FS:  0000000000000000(0000) GS:ffff98927fc00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b1ff28f0f8 CR3: 000000001b412003 CR4: 00000000003606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rxkad_respond_to_challenge+0x297/0x330 [rxrpc]
 rxrpc_process_connection+0xd1/0x690 [rxrpc]
 ? process_one_work+0x1c3/0x680
 ? __lock_is_held+0x59/0xa0
 process_one_work+0x249/0x680
 worker_thread+0x3a/0x390
 ? process_one_work+0x680/0x680
 kthread+0x121/0x140
 ? kthread_create_worker_on_cpu+0x70/0x70
 ret_from_fork+0x3a/0x50

Reported-by: Jonathan Billings <jsbillings@jsbillings.org>
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Jonathan Billings <jsbillings@jsbillings.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/rxrpc/conn_event.c |  1 +
 net/rxrpc/rxkad.c      | 92 ++++++++++++++++++++++++++++------------------=
----
 2 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 4ca11be6be3c..b1dfae107431 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -460,6 +460,7 @@ void rxrpc_process_connection(struct work_struct *work)
 		case -EKEYEXPIRED:
 		case -EKEYREJECTED:
 			goto protocol_error;
+		case -ENOMEM:
 		case -EAGAIN:
 			goto requeue_and_leave;
 		case -ECONNABORTED:
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index c38b3a1de56c..77cb23c7bd0a 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -773,8 +773,7 @@ static int rxkad_respond_to_challenge(struct rxrpc_conn=
ection *conn,
 {
 	const struct rxrpc_key_token *token;
 	struct rxkad_challenge challenge;
-	struct rxkad_response resp
-		__attribute__((aligned(8))); /* must be aligned for crypto */
+	struct rxkad_response *resp;
 	struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
 	const char *eproto;
 	u32 version, nonce, min_level, abort_code;
@@ -818,26 +817,29 @@ static int rxkad_respond_to_challenge(struct rxrpc_co=
nnection *conn,
 	token =3D conn->params.key->payload.data[0];
=20
 	/* build the response packet */
-	memset(&resp, 0, sizeof(resp));
-
-	resp.version			=3D htonl(RXKAD_VERSION);
-	resp.encrypted.epoch		=3D htonl(conn->proto.epoch);
-	resp.encrypted.cid		=3D htonl(conn->proto.cid);
-	resp.encrypted.securityIndex	=3D htonl(conn->security_ix);
-	resp.encrypted.inc_nonce	=3D htonl(nonce + 1);
-	resp.encrypted.level		=3D htonl(conn->params.security_level);
-	resp.kvno			=3D htonl(token->kad->kvno);
-	resp.ticket_len			=3D htonl(token->kad->ticket_len);
-
-	resp.encrypted.call_id[0] =3D htonl(conn->channels[0].call_counter);
-	resp.encrypted.call_id[1] =3D htonl(conn->channels[1].call_counter);
-	resp.encrypted.call_id[2] =3D htonl(conn->channels[2].call_counter);
-	resp.encrypted.call_id[3] =3D htonl(conn->channels[3].call_counter);
+	resp =3D kzalloc(sizeof(struct rxkad_response), GFP_NOFS);
+	if (!resp)
+		return -ENOMEM;
+
+	resp->version			=3D htonl(RXKAD_VERSION);
+	resp->encrypted.epoch		=3D htonl(conn->proto.epoch);
+	resp->encrypted.cid		=3D htonl(conn->proto.cid);
+	resp->encrypted.securityIndex	=3D htonl(conn->security_ix);
+	resp->encrypted.inc_nonce	=3D htonl(nonce + 1);
+	resp->encrypted.level		=3D htonl(conn->params.security_level);
+	resp->kvno			=3D htonl(token->kad->kvno);
+	resp->ticket_len		=3D htonl(token->kad->ticket_len);
+	resp->encrypted.call_id[0]	=3D htonl(conn->channels[0].call_counter);
+	resp->encrypted.call_id[1]	=3D htonl(conn->channels[1].call_counter);
+	resp->encrypted.call_id[2]	=3D htonl(conn->channels[2].call_counter);
+	resp->encrypted.call_id[3]	=3D htonl(conn->channels[3].call_counter);
=20
 	/* calculate the response checksum and then do the encryption */
-	rxkad_calc_response_checksum(&resp);
-	rxkad_encrypt_response(conn, &resp, token->kad);
-	return rxkad_send_response(conn, &sp->hdr, &resp, token->kad);
+	rxkad_calc_response_checksum(resp);
+	rxkad_encrypt_response(conn, resp, token->kad);
+	ret =3D rxkad_send_response(conn, &sp->hdr, resp, token->kad);
+	kfree(resp);
+	return ret;
=20
 protocol_error:
 	trace_rxrpc_rx_eproto(NULL, sp->hdr.serial, eproto);
@@ -1048,8 +1050,7 @@ static int rxkad_verify_response(struct rxrpc_connect=
ion *conn,
 				 struct sk_buff *skb,
 				 u32 *_abort_code)
 {
-	struct rxkad_response response
-		__attribute__((aligned(8))); /* must be aligned for crypto */
+	struct rxkad_response *response;
 	struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
 	struct rxrpc_crypt session_key;
 	const char *eproto;
@@ -1061,17 +1062,22 @@ static int rxkad_verify_response(struct rxrpc_conne=
ction *conn,
=20
 	_enter("{%d,%x}", conn->debug_id, key_serial(conn->server_key));
=20
+	ret =3D -ENOMEM;
+	response =3D kzalloc(sizeof(struct rxkad_response), GFP_NOFS);
+	if (!response)
+		goto temporary_error;
+
 	eproto =3D tracepoint_string("rxkad_rsp_short");
 	abort_code =3D RXKADPACKETSHORT;
 	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
-			  &response, sizeof(response)) < 0)
+			  response, sizeof(*response)) < 0)
 		goto protocol_error;
-	if (!pskb_pull(skb, sizeof(response)))
+	if (!pskb_pull(skb, sizeof(*response)))
 		BUG();
=20
-	version =3D ntohl(response.version);
-	ticket_len =3D ntohl(response.ticket_len);
-	kvno =3D ntohl(response.kvno);
+	version =3D ntohl(response->version);
+	ticket_len =3D ntohl(response->ticket_len);
+	kvno =3D ntohl(response->kvno);
 	_proto("Rx RESPONSE %%%u { v=3D%u kv=3D%u tl=3D%u }",
 	       sp->hdr.serial, version, kvno, ticket_len);
=20
@@ -1105,31 +1111,31 @@ static int rxkad_verify_response(struct rxrpc_conne=
ction *conn,
 	ret =3D rxkad_decrypt_ticket(conn, skb, ticket, ticket_len, &session_key,
 				   &expiry, _abort_code);
 	if (ret < 0)
-		goto temporary_error_free;
+		goto temporary_error_free_resp;
=20
 	/* use the session key from inside the ticket to decrypt the
 	 * response */
-	rxkad_decrypt_response(conn, &response, &session_key);
+	rxkad_decrypt_response(conn, response, &session_key);
=20
 	eproto =3D tracepoint_string("rxkad_rsp_param");
 	abort_code =3D RXKADSEALEDINCON;
-	if (ntohl(response.encrypted.epoch) !=3D conn->proto.epoch)
+	if (ntohl(response->encrypted.epoch) !=3D conn->proto.epoch)
 		goto protocol_error_free;
-	if (ntohl(response.encrypted.cid) !=3D conn->proto.cid)
+	if (ntohl(response->encrypted.cid) !=3D conn->proto.cid)
 		goto protocol_error_free;
-	if (ntohl(response.encrypted.securityIndex) !=3D conn->security_ix)
+	if (ntohl(response->encrypted.securityIndex) !=3D conn->security_ix)
 		goto protocol_error_free;
-	csum =3D response.encrypted.checksum;
-	response.encrypted.checksum =3D 0;
-	rxkad_calc_response_checksum(&response);
+	csum =3D response->encrypted.checksum;
+	response->encrypted.checksum =3D 0;
+	rxkad_calc_response_checksum(response);
 	eproto =3D tracepoint_string("rxkad_rsp_csum");
-	if (response.encrypted.checksum !=3D csum)
+	if (response->encrypted.checksum !=3D csum)
 		goto protocol_error_free;
=20
 	spin_lock(&conn->channel_lock);
 	for (i =3D 0; i < RXRPC_MAXCALLS; i++) {
 		struct rxrpc_call *call;
-		u32 call_id =3D ntohl(response.encrypted.call_id[i]);
+		u32 call_id =3D ntohl(response->encrypted.call_id[i]);
=20
 		eproto =3D tracepoint_string("rxkad_rsp_callid");
 		if (call_id > INT_MAX)
@@ -1153,12 +1159,12 @@ static int rxkad_verify_response(struct rxrpc_conne=
ction *conn,
=20
 	eproto =3D tracepoint_string("rxkad_rsp_seq");
 	abort_code =3D RXKADOUTOFSEQUENCE;
-	if (ntohl(response.encrypted.inc_nonce) !=3D conn->security_nonce + 1)
+	if (ntohl(response->encrypted.inc_nonce) !=3D conn->security_nonce + 1)
 		goto protocol_error_free;
=20
 	eproto =3D tracepoint_string("rxkad_rsp_level");
 	abort_code =3D RXKADLEVELFAIL;
-	level =3D ntohl(response.encrypted.level);
+	level =3D ntohl(response->encrypted.level);
 	if (level > RXRPC_SECURITY_ENCRYPT)
 		goto protocol_error_free;
 	conn->params.security_level =3D level;
@@ -1168,9 +1174,10 @@ static int rxkad_verify_response(struct rxrpc_connec=
tion *conn,
 	 * as for a client connection */
 	ret =3D rxrpc_get_server_data_key(conn, &session_key, expiry, kvno);
 	if (ret < 0)
-		goto temporary_error_free;
+		goto temporary_error_free_ticket;
=20
 	kfree(ticket);
+	kfree(response);
 	_leave(" =3D 0");
 	return 0;
=20
@@ -1179,12 +1186,15 @@ protocol_error_unlock:
 protocol_error_free:
 	kfree(ticket);
 protocol_error:
+	kfree(response);
 	trace_rxrpc_rx_eproto(NULL, sp->hdr.serial, eproto);
 	*_abort_code =3D abort_code;
 	return -EPROTO;
=20
-temporary_error_free:
+temporary_error_free_ticket:
 	kfree(ticket);
+temporary_error_free_resp:
+	kfree(response);
 temporary_error:
 	/* Ignore the response packet if we got a temporary error such as
 	 * ENOMEM.  We just want to send the challenge again.  Note that we
--=20
2.15.1
