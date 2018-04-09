Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240427-2-2379731324812184073
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240426; b=ExaKy7vt0Je7PXAM/lEsqci/ATH3+JqtH3NDh/4eSmgBLWtKbt
    AlgAEMTr8ZQjznePTjqOc2/W//WsAe6F+Z65gnLm81ayQyjkfjlOCaANq6aqf4RV
    El4oDAan/4MKAuVjZQHFmVbGf3M1KyavG6F2bjW4a73pkCxWnOcWy8JLzNxpDl+m
    IQ4CPT59asRKP68ElAFascdkwzT9ocxVbi4uS0zVyS1SR61rpwG8liRpeg87yudH
    D+YIkOGefZ15smvwbfq2JCg/PIG1ig7/FP4SYenIEMPrjOgLfXgtTHW5Twb/IXZD
    IOBRGXc5W7Q1iKthNIQWwQIwkWN4k6swEtGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240426; bh=uLdG9zCR1Y
    wYJMwhKohP2P/LJaf1gapoCyrrEa4Ife8=; b=ZdfqmjeNMeW1HpalQe0k7/py6O
    7KafFf46M1o37IS18iOVvAlmSk28gDDFk+rdpfgXVIWTKtVrCYTINdV6R/e9wub4
    FFg0Lrsp2BxZlBXHM80dFruakeAf7Bdp8NqnfrmCClwPdegIvtkty50vwYe/zT3u
    2x9CZYq60ojPlcZg/1+3hZ8PgSjnqya9zMCAFnTr6eD3PxZOyJeHgIcByu/VA6Eo
    X1hQYtMd8xO9eFUV/j6sfkpVzoxoPa1xSgHqMr/6qkHtuj3OQ8EqR905IDvw6YfS
    N66KtYsqwgzia/dmH5G9nUiMdEdaASRvAwVBIRtfxVh5zgQFk+tbxqPlWQhQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GQnXxV2/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GQnXxV2/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHh3Aei3LlntpxveeA/mwvYl+9wpof2GhXlgZ2TFGM5LYDNyO3/2c0JV3z9xYjG/LGIXuwMNQsfjgpvlA1j/GznQ6mXA9iwV3aBWeldgbGeCVE7V1eQV
    mtgUMul2OtSozuqfU3wPk6pz0y0c4Io6ECFM3fKIY5jjcRDiJIzcqxP2c3v/rzAfoWhV4+cBhtS7IkADBzE16YsgjTSxCibD9IyiQQd41tyKA8dQ+NxSM1tR
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=92hT1TDex09zFRy9lPEA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932216AbeDICUK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:20:10 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:10314
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753384AbeDIAaR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chenbo Feng <fengc@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 122/293] tcp: Add a tcp_filter hook before
 handle ack packet
Thread-Topic: [PATCH AUTOSEL for 4.9 122/293] tcp: Add a tcp_filter hook
 before handle ack packet
Thread-Index: AQHTz5kefmQ74nuGU0ScoOG+3jkIxA==
Date: Mon, 9 Apr 2018 00:24:28 +0000
Message-ID: <20180409002239.163177-122-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:9mfAWvJaCjFN3QgBrpj8iJC+GQckPEEshEiBaJOmbN6kkRzLeXEXi6qkDrxdBfrEGqRTcRFNRpD1+nbb4Mvff6rMoQUWZqFCbUF5UjTcBZnYhil7tErdoKOV76gSeXVRQSHH8QHdqLK/gJyoz7uyz1x/JNuyxgj1ycoHylax4Vpl73nsHAt7yRvQyKAdHjSWVwgF9IxnW9yXb8uOpUvNqacQLRK9Bn1k7QrgbYYTO/hmfpJ60LeJcFR4ZwNs2GX+;20:zTMgFxGH+gK+u/K5yXLlwifceKS/Zvkq/Nd6/XxDvC4I7njTSujftw94Q7whtQqdpe5VD/tJ+/AxiivYBAnakPMJIfe4xZ78ORuiiU7V7qYgaG4zYzCd8qWWmFxRseFuMX0Y0GaiGM8IJ26W2GBKO2rorTOOakrLlrQcdnnmsis=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d1f3946-bdf9-4c7f-bdde-08d59db10fe5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032A100083AF4871C7A3D8FFBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(3280700002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 0QSyPxuVbuDAFtRVXgkwyzo1JpFFZkEO3MJS2w7lnLJrY+yWmAWiSP0kjgyD0iCnkEINSt4JOIQ2XFf1axRvbyox1t0Q66aoge4X/LIszxO2tzX7G+S5VH1IxLNFqiSU2qJ5UDHtESN/icX6oAdbrJUXcAfi7vwDQ91it4txVweAVtbC4z15APc1LJrdR+OmNPU0mnhcr8xfyUCjJfu86jBMtTaTo4ij6/fLdW2ycSVNCpO8Wb7hg08czks60J9nJywfo3FVIb0ALAV8XgMQsLi9nT0QPHfdSQU394gr47PPenITF65xy8t4KqN+6eqxOoF6SxSvmEtXONGk/Dg0cWugEd/hRWoZI0XaXAaBOPeaW58YaUJagNivcmiWoYdB2JTr1O0gxHwqpbrmg6va7uv8aYqnPFVrkeW9PROQXoU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1f3946-bdf9-4c7f-bdde-08d59db10fe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:28.1125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chenbo Feng <fengc@google.com>

[ Upstream commit 8fac365f63c866a00015fa13932d8ffc584518b8 ]

Currently in both ipv4 and ipv6 code path, the ack packet received when
sk at TCP_NEW_SYN_RECV state is not filtered by socket filter or cgroup
filter since it is handled from tcp_child_process and never reaches the
tcp_filter inside tcp_v4_rcv or tcp_v6_rcv. Adding a tcp_filter hooks
here can make sure all the ingress tcp packet can be correctly filtered.

Signed-off-by: Chenbo Feng <fengc@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/tcp_ipv4.c | 2 ++
 net/ipv6/tcp_ipv6.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b3960738464e..7294a1106b75 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1677,6 +1677,8 @@ process:
 		}
 		if (nsk =3D=3D sk) {
 			reqsk_put(req);
+		} else if (tcp_filter(sk, skb)) {
+			goto discard_and_relse;
 		} else if (tcp_child_process(sk, nsk, skb)) {
 			tcp_v4_send_reset(nsk, skb);
 			goto discard_and_relse;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index eb624547382f..149b9b3cbd66 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1447,6 +1447,8 @@ process:
 		if (nsk =3D=3D sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
+		} else if (tcp_filter(sk, skb)) {
+			goto discard_and_relse;
 		} else if (tcp_child_process(sk, nsk, skb)) {
 			tcp_v6_send_reset(nsk, skb);
 			goto discard_and_relse;
--=20
2.15.1
