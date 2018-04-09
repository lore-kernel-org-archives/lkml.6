Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241807-2-4426670242005138898
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241806; b=Xb+fCyw7zJFfzfJoWIsWTb+istxCrRe6o4ASSDHAMTUhye1avK
    tss/kPspHnxvESIAb7cpXRYD1z9CpJ/5hxQ8VAyq59EP3iXpN4TrrK+2byZc9BPJ
    qySscTx6Fel5w/l25r7uGtbSn4KFRr72mduudR6Z/bUY9cMxEMIvxUZIoofPh6Db
    tO6SKeniyjmqdpkF3RTCb3VAKBrCZHFD5cPAjjaxDcQtmiDba+njlnr57V10DV8Y
    rm1EBnodpJzmPWhLKpp2BfTrvRdPjYdDKysaYQfcHrDBKnfA/fhdK9VmhrIYcyN+
    obv8ZsJvzfsARtyL81unsYh4gKVQAXBT7oaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241806; bh=f1hc6HZW9p
    +irROW5gByMPdoAzaB0sU2nD8MzrOJ5pw=; b=livUn0UAkB2pCxWK4BidlL0E2m
    QXujHNzb0122hDDR2GZsgoisBZ0aAmmeXP3yO1wT6F8dU8s+nBCPR4EE6o0T1tgR
    BaUL1YiBCpf/TEt3TXpvYuqL0khu6zEaP0MeIIJqhWmCw5r1GotaI3nmNJrLhksq
    Xqp0sJ6dJt494/t5zEvFqRbyN+U4/PTTs4ZQsB/bYO+lBKvAI/dVxIEmiINU+p+m
    kkZ0C4n9Bq2HwePVYP+Vy29dBTuuI9T5iXT5nUAVvTo1ch/yIE871WR5grhcSEH8
    6Y7CrrfxFk61nR88ml8SlG88T7GQdk6gX8oiznNRxiwwDzsQGpVzSWMpVF/Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dnj/TAGt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dnj/TAGt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFUhikkrtpatsTJ07mzP3+XqGkrBoUbR7q4Og3chbHlaNsCNWrFL1it0PQXZkf4GKRRqHjL3+Jx2MeCxebQITiCC469EAvlBindCdVTj3uAutH/k+w+o
    p3eRulgH+DgbxmtHSf9JPNSTUJjP5/QtK6Stsg6RZuMvsybDmKxt1oxNaE60UdB8BA+gphSs1YU/msiBXLOkuZB6w53RAwDmqH/dVmH+s74g4mS5hSFD8hLS
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=8AirrxEcAAAA:8 a=t7CeM3EgAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=slF5MxTFN6a7s4ZqXpsA:9 a=wPNLvfGTeEIA:10
    a=ST-jHhOKWsTCqRlWije3:22 a=FdTzh2GWekK77mhwV6Dw:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeDICmP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:42:15 -0400
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:46250
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755476AbeDIA0z (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Fabio Estevam <fabio.estevam@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 029/293] net: fec: Add a
 fec_enet_clear_ethtool_stats() stub for CONFIG_M5272
Thread-Topic: [PATCH AUTOSEL for 4.9 029/293] net: fec: Add a
 fec_enet_clear_ethtool_stats() stub for CONFIG_M5272
Thread-Index: AQHTz5jyDEqCw0OXXUC/YKalc4relQ==
Date: Mon, 9 Apr 2018 00:23:12 +0000
Message-ID: <20180409002239.163177-29-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:/qMWtQ220F7V7haI8AVao3FnBJxudK4lQB7FKED2mYg2IPHTB2IsJPLvxlJoP8NjcDWQmfNvx4McUtfAfUwqpEfDpbJXzUYOnkEVDFdAjam9K+rMzDgkNUislKq5TDPGREufHIxC9namgpER9Dra5P0nxDvxpNxyD9IvpUjrSMhgmAWmiGzUn/Cjbz4QwZk/QhAod3CUnb1aLJp6iHVOcvX/OWhy9APv8IXxtHyBgQaQdtX9VOO9GwMFOmJyvKsc;20:x7klgC0LuwCQvdKRbQ6QG1tlAofxi6HBjTUtRzKpiZF8hOUN6WBMI1xEsSOhAL/FWbKgkC8cW4VuaaKtivm1kP3w/Ns5uOX58ueoqhboudt8v+hnUnPdFyL9s7dhIwhCURRlgZad+YJq7Pvb4LJ+e4Q9/duQY78suEy1nZG6TGc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3acab99c-7f53-472d-23b1-08d59db09448
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB088509103822C35C29566EB2FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(8656006)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(3846002)(305945005)(86362001)(59450400001)(66066001)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: YuRbvs5AmZAOQZE6HsLY9vLoyKA9y5ZNE8ODyPc6c8N8NzOpEZRYlGyKRvgr5ucZEbUGem3JTHW118J2nI6y1RonqTYtSO2k8kPUppVOsk0vsXTVJIwqobxkBbMXkgl6UvUnHHAX+7W1NeJEoOdy5L1R5tr5s9i/FdNu5JIac5Wwm26jd42VbS4czpiblrV8mEYQubm37pIWxXtTj2kpkdoaLduzRS8NbhCKc2OldwaqO9rX8aN03vPMoPtnI3hsPFv6NjUMlgQ2FBjRY6XIoPGqPPRp9ykcjc4MzF2x7c022WSZw6lHbLc68vxZbysBCpZb0aTLQ9k4setqw/NVFqG8+LCHvhx38xs0BP/6m40zS0sgiI/YyB2x7JNNBdU0NdcAwI+olSazBanDVQEpvVcJK+1x6xf4/cFQ6P2UDQI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acab99c-7f53-472d-23b1-08d59db09448
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:12.9873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

[ Upstream commit bf292f1b2c813f1d6ac49b04bd1a9863d8314266 ]

Commit 2b30842b23b9 ("net: fec: Clear and enable MIB counters on imx51")
introduced fec_enet_clear_ethtool_stats(), but missed to add a stub
for the CONFIG_M5272=3Dy case, causing build failure for the
m5272c3_defconfig.

Add the missing empty stub to fix the build failure.

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethern=
et/freescale/fec_main.c
index 05e5b38e4891..fe00f71bc6b4 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2371,6 +2371,10 @@ static int fec_enet_get_sset_count(struct net_device=
 *dev, int sset)
 static inline void fec_enet_update_ethtool_stats(struct net_device *dev)
 {
 }
+
+static inline void fec_enet_clear_ethtool_stats(struct net_device *dev)
+{
+}
 #endif /* !defined(CONFIG_M5272) */
=20
 static int fec_enet_nway_reset(struct net_device *dev)
--=20
2.15.1
