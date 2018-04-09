Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523245208-2-16587140769044725231
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245207; b=K78d1HfsRO51AgtQkiqsWkHBgZN5l9lCtJ6vcTM1GlEqRB2XeA
    eQ4cleXfGg84rz38wSiV7miwr/ChODATpy41ObA/Ue8LOmdxR6Hs6OTN4scpmcv3
    LKAFAD6NC+y6HjWvqTk8yrxyocTfBWfPWv6D9Qgigq7WoLGAIJ+pRfFHD6NfGEJV
    R/Fw0K5dkYWaMzmTi6VDZBMHXc6UfKAY2GowEEaBM9Kn+4BJf4kiQ6u/ZYbns7bW
    XN9eG4uzXII/dg5MCvkaMfWz7MDBjbqsQhdW8qtJDMfyTZd6AaNjN57J4mSIY1Ss
    4/zEt66d9T+9TxTMkU7q3ubw/GQmzzSDCiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245207; bh=rtUeB7Kpp4
    3NEoxG+OqBu7nSVhAbGkO61bIRDdbvnsE=; b=CaesdcI+k+I4BYiymEwbh2LIQ1
    pmq8Wi1DRcR08J5X7Y0p20B3Jp9g8aLipfJMdwYdTOVRRYY4DBxj2tFY+xhqRdep
    XB04rHeVSWO5L59JjpOfX0aOcgS7cbCHMEl48+2jv2LlW2SwvJ/8Xw5B7jBQnKjz
    PRDSlUpfZUi9pJPnTVqfoBLxGla7KKQTC++thbCkgESODdT33n653/xNFULqopwb
    vjAMWQtP7Rtit2slbiCv+ks/7BJShwX34ap/3jPA0WBh1NLNm9GHuzmvtfYg2lNn
    VigJ3uEVROe4R+CmfLA9vT/8h9qjvw3Z4ecu0F22eC2Ua1/K2PbF4VpqVHRw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=djQuwDbl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=djQuwDbl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCc5LZIrodcKDrYh8AEMRbvfFW4+1qrqI6faqBWR3O/+coTED3cW4zSaWVWhMMdj8WMY6fHcAo2GKZfFSThi43X7SIRs9vTBwhaaJCuQvyzLSVvmSdMA
    j1Jsbezm3KCISckVpV1OcHmePhyerI/CSwIiVOMDKakfnX704f4kkqoKY38dbtQXPALRQ2UShXcnxH3wL59ZBRVHi2mbufYo736puePxk9OApf7C2bQhSjBW
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=jZVsG21pAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=TAjKS-7TPJR2CJOdf74A:9 a=wPNLvfGTeEIA:10 a=3Sh2lD0sZASs_lUdrUhf:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeDIDgh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:36:37 -0400
Received: from mail-bn3nam01on0124.outbound.protection.outlook.com ([104.47.33.124]:4000
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754393AbeDIAVN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Md. Islam" <mislam4@kent.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 165/189] sch_netem: Bug fixing in calculating
 Netem interval
Thread-Topic: [PATCH AUTOSEL for 4.15 165/189] sch_netem: Bug fixing in
 calculating Netem interval
Thread-Index: AQHTz5hb7x4hUgs8LkePNx6+3sNUTg==
Date: Mon, 9 Apr 2018 00:19:00 +0000
Message-ID: <20180409001637.162453-165-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:tmZpXvwHsZm0315R6/BRhMFaCIjxds4PA681+Ng1QHGIG6/wReRztXJy1um3JtvLoXatsA9EvbVVzLdQ/vTDs4iCeFArItXi07L/5ZNHafyL5mZdx567cgbPkc+z+XG7FOkN3dSwflaKk3XUpbAti9pJmCrrpCFkbQOUMLAvRDogCoqYkfYk6/aV8OVWtfT5ufmTKFemAH1uDabI0dwDZUgrUS3fSQzxd4X9lMp5Y2Y49qmG4+JKqbNVJDGxmd21;20:DcjBQ2NzFX+8TdTWRpG3cJk66sB7pDwvaoZAgjrp0RIhkc33YiMiJQzfcaPUIo98070CPJhTTQKWO7fSvg69I+lnQRn3/xYwHTwn1kVUrgY6FV4UWdfvl1XBPBVGv5+Fd27iJwvZu299HQoBrE/QtDinXO1Dy4wuZ0C9ZGGf+10=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36853079-c6d2-4b05-e182-08d59dafc9e2
x-microsoft-antispam: UriScan:(166340869730572);BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110086975309B43999B37D7FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166340869730572);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(8666007)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 63tmw7sRm7cW+kJZlIfPenIoUT59HUdYeFqdumgvlz1wTROM25do3Si3ZepJEH6kxvnHF5pz5wvfhossT7RX8L3Qny7ZgqFy6aiRVTtau+AGoJ4Tx1xMUF3v5aCBI16Mm+KYC/E6lKPOSPXC9etVXfaOb89X18r8+8yqLvYNx5m7naLTvEboj2PMudchXCoV+JO1IHs8QC9vYiIDCCcy1szaMX5LxXSYD/JrmBl0pgNdiudAVlc+NTOK88iLZMgM3Vv73Ol7V7eKmB2lojgX6j/guCxUMBoqOPO7NBPnR3/m3J6BhtPjfFu0pMhtxfXDdBIVAtMLnkOZ7azDyekNWLMk6PBk/nqAeRQngUij/5wGVZAOANftDSEszDceDz2xqL7Dc17LH3eT4CXy1GsG3KLK3vWGDAnrBe0wRrkQrL8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36853079-c6d2-4b05-e182-08d59dafc9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:00.2680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Md. Islam" <mislam4@kent.edu>

[ Upstream commit 043e337f555e610ad8237fd23522d97c968d72b9 ]

In Kernel 4.15.0+, Netem does not work properly.

Netem setup:

tc qdisc add dev h1-eth0 root handle 1: netem delay 10ms 2ms

Result:

PING 172.16.101.2 (172.16.101.2) 56(84) bytes of data.
64 bytes from 172.16.101.2: icmp_seq=3D1 ttl=3D64 time=3D22.8 ms
64 bytes from 172.16.101.2: icmp_seq=3D2 ttl=3D64 time=3D10.9 ms
64 bytes from 172.16.101.2: icmp_seq=3D3 ttl=3D64 time=3D10.9 ms
64 bytes from 172.16.101.2: icmp_seq=3D5 ttl=3D64 time=3D11.4 ms
64 bytes from 172.16.101.2: icmp_seq=3D6 ttl=3D64 time=3D11.8 ms
64 bytes from 172.16.101.2: icmp_seq=3D4 ttl=3D64 time=3D4303 ms
64 bytes from 172.16.101.2: icmp_seq=3D10 ttl=3D64 time=3D11.2 ms
64 bytes from 172.16.101.2: icmp_seq=3D11 ttl=3D64 time=3D10.3 ms
64 bytes from 172.16.101.2: icmp_seq=3D7 ttl=3D64 time=3D4304 ms
64 bytes from 172.16.101.2: icmp_seq=3D8 ttl=3D64 time=3D4303 ms

Patch:

(rnd % (2 * sigma)) - sigma was overflowing s32. After applying the
patch, I found following output which is desirable.

PING 172.16.101.2 (172.16.101.2) 56(84) bytes of data.
64 bytes from 172.16.101.2: icmp_seq=3D1 ttl=3D64 time=3D21.1 ms
64 bytes from 172.16.101.2: icmp_seq=3D2 ttl=3D64 time=3D8.46 ms
64 bytes from 172.16.101.2: icmp_seq=3D3 ttl=3D64 time=3D9.00 ms
64 bytes from 172.16.101.2: icmp_seq=3D4 ttl=3D64 time=3D11.8 ms
64 bytes from 172.16.101.2: icmp_seq=3D5 ttl=3D64 time=3D8.36 ms
64 bytes from 172.16.101.2: icmp_seq=3D6 ttl=3D64 time=3D11.8 ms
64 bytes from 172.16.101.2: icmp_seq=3D7 ttl=3D64 time=3D8.11 ms
64 bytes from 172.16.101.2: icmp_seq=3D8 ttl=3D64 time=3D10.0 ms
64 bytes from 172.16.101.2: icmp_seq=3D9 ttl=3D64 time=3D11.3 ms
64 bytes from 172.16.101.2: icmp_seq=3D10 ttl=3D64 time=3D11.5 ms
64 bytes from 172.16.101.2: icmp_seq=3D11 ttl=3D64 time=3D10.2 ms

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sched/sch_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 2aeca57f9bd0..73c4bea821cb 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -327,7 +327,7 @@ static s64 tabledist(s64 mu, s32 sigma,
=20
 	/* default uniform distribution */
 	if (dist =3D=3D NULL)
-		return (rnd % (2 * sigma)) - sigma + mu;
+		return ((rnd % (2 * sigma)) + mu) - sigma;
=20
 	t =3D dist->table[rnd % dist->size];
 	x =3D (sigma % NETEM_DIST_SCALE) * t;
--=20
2.15.1
