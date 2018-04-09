Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241593-2-16562517157757991185
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
    1523241592; b=WSHbQUQKuP7BEFGetPiW3dnF1t7d0/6FYS8fonJKhIpvrpYVyT
    sJjCJJ/CSJAYlmHJmvxNEaZ3xtKyU/nksHAgtLAkXRIsrtt1YvGr6O3TZeG+cmIq
    HO+bEKjyCY7SIm43mfnd/myZdQVxHVHqKvBVp+eZRRUHOI3M11cXELD+Q+YPKKUh
    hQgcQvUmNLjuilcjXyDB3DRwwcIkJopIX/f84ASz2p/97SsXVBAXO4d8NZq1tL9J
    4fKU9igZukNjqJlTMKPrPrsho+WtLUrZx7s/9rrQ2Ii6lwa0h/jBmL2rY8NHooO5
    fbNb+na82ExiLjcHqtHZ2J8w/7+p8IPI42rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241592; bh=R6HgIuEi2y
    6S6u+gB328zdMdO/ktE//5DprpT92GMNw=; b=uz50rjTZXLRdqJMaQs4418P90w
    kVg6blTrTGjHAb7SFdCS7E2Ydabl3OJl4ykFBig3UkobWWWQqAzHkRX6GksLzouG
    irUmAzyUwSMQTRljJq+K2ZP3332uCLTSNquizpfqkiePkaFDsWQoiIJJeh9/ARUu
    N+6QsnEhpULAyFD5d5zlnmgoBIGUhu70l61iDhC7qKJ3RMbTx1q6jhaJ+5tF0Ibj
    5RPdjTJqwQrGyQwhVk4unzcCTqtj58HEMz7W0xvq7WE5dtaw3Nc10zsdw2Dd0yv7
    IdfhcD6ur7z+zwEcGlSC3FHLp8yEt/NSvORoXQb3rAXtVLwnYFAI1h2G38Dg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C3TtCRbi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C3TtCRbi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOP8O0ZdrIaiXxsfXRN7skcj/mJjEZcEXcd0sjttrfCtPb7ZNMzAzRmFo23RPS6zLPy+E/PGb0VKwWP0Xn93F3JRcxA81TcvfNnbyMnqwbUuGnAVAgXS
    n0VUUGFTL31zARNvNNowBmJ3kvhwdS0thHCzLQtuvLL5hbi23GQzQg0imLClsqLqUT5UHobajYJZ3a6SVTtC11cxBUo7pEnph9TTe88RFRXw8PAMw0S9zejo
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=vggBfdFIAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=kctQ_G0Z_aRKXrxv770A:9 a=cakF1KBDqPFBzM3U:21 a=gXRmuUMSryawTcB7:21
    a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755564AbeDIA11 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:27:27 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755453AbeDIA1W (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 034/293] net: ena: add missing return when
 ena_com_get_io_handlers() fails
Thread-Topic: [PATCH AUTOSEL for 4.9 034/293] net: ena: add missing return
 when ena_com_get_io_handlers() fails
Thread-Index: AQHTz5j0VcT8jaJvKEK0CXF79H1UuA==
Date: Mon, 9 Apr 2018 00:23:16 +0000
Message-ID: <20180409002239.163177-34-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:7iopGlXYz0P71tiktZkF3bjoP1AGrQAN494x4+vZLIyMyPiMYlGZTMwnD+K1W58HkrxZlsQilI7mD1AmhoRKqCujKhl5nZazA7Q/uI00QT1kJj7/mBBME8s0hCigCeuMrTNpbjVPjBjioZ3bdJKd8mw6QdMHv8/9Y+3FOXDmIWT0Z5mjO09uKDRl/zlxeLQW731e5tb1H3S1FVsHvkAepRPQHcMp2IhdxycfofsT+tv3woFc1SDjnyFll2p3vl+p;20:DKJAL4hlNXUeOR4ckDxN6ma4+ZKeM541XlksOPpY2Wr3cdS7UJBZojxtTIDplrtIJVhIGunXewDpz3VRT3JBOyrPSuGJGXze9jMkDUcQbqlUwVkwda4RZW8NjbFLQ2c+7OyQmdawpRSXSliVyAfeM9GFfImhF2VT8d9AfsW6h40=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e116fb1-93ef-41f4-228d-08d59db0a7bf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10312FCD13D638BFD0D78116FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(33061846794335)(47284530071512);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: w0PPRlmvSsM6SZUYNftnlXhiBrGp6hxnODF6cQSAsT/1ftlvAn/Gg/xHDa0UUFZhy9s8tVUWcbnLs24sscI0snDgyfboSAFeCeCk0dTX0UjW2bKAtRyUdhAsqmT91+Pqg40XxcN1nDWMZRKpjK9U56LbbTjN9klKwB7/kqVE5T+vSAbbs7bOe9NGwYRpeVUhrIyoNPGxhOtV46Qbf/J1pjpJqxCpeUU+oX63zHuE5wVtmb9wxYiEJ/i6X5E0DBvT/N8EGYZry8DH9kuYnd4siye+30F/t9EVc1rjBaUszYD289/OU0jbULc9WKb5EdfRFCwUV87b7okqt/jYPmnjB3W/LVcBlcbofm/vY0LH2AiIxlzEfJROgoC7apew4EtwpAV4fbu8Hve2HcYD6weLKScpXLHjRzws6CszmOI8fd4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e116fb1-93ef-41f4-228d-08d59db0a7bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:16.7842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 2d2c600a917127f16f179d5a88fc44ba3ed263ed ]

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA=
)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.c
index bfeaec5bd7b9..fe691017d5aa 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1542,6 +1542,7 @@ static int ena_create_io_tx_queue(struct ena_adapter =
*adapter, int qid)
 			  "Failed to get TX queue handlers. TX queue num %d rc: %d\n",
 			  qid, rc);
 		ena_com_destroy_io_queue(ena_dev, ena_qid);
+		return rc;
 	}
=20
 	ena_com_update_numa_node(tx_ring->ena_com_io_cq, ctx.numa_node);
@@ -1606,6 +1607,7 @@ static int ena_create_io_rx_queue(struct ena_adapter =
*adapter, int qid)
 			  "Failed to get RX queue handlers. RX queue num %d rc: %d\n",
 			  qid, rc);
 		ena_com_destroy_io_queue(ena_dev, ena_qid);
+		return rc;
 	}
=20
 	ena_com_update_numa_node(rx_ring->ena_com_io_cq, ctx.numa_node);
--=20
2.15.1
