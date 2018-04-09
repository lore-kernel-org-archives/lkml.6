Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233729-2-3304843865752858659
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233728; b=Vy7UgJ3Lk8qT7/Sp2BljMGdeTmYH+jhprVUARZ6q7uHH/uFDrG
    QtmrVzlsiwXoHPbeWVAlx4kPZsb/VShRrJFtK8jBMkBs1VqoysHyT7VwsRTO7y5C
    rHCoGfRftEpvLXpEfSb/ENmFpium8pAq8zYx4lntVshj244Vc+ezFXrM7VYXDLce
    WhYHzUMFVZtzTnM3oZIRHcUz+993rILle92n+r1OU7jYSf/IAQK54BJnxw8ntD5I
    ypBFXyVUzniK9hgyIDqUPCydicdY5AWdj5EUaNf9065SLf1VzIiBRXzs8jtkIcDl
    ME4IiNrup+oZLh9bSIJfcyYL6GeMzer/GZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233728; bh=mmZw6pgAFC
    RHQj9Os/1WSu2eBNAr3RQ2lb8M1GYgsIc=; b=SnhYKKyernDCQHobyVk42hPC0G
    Cri4k/Py22P0WTjrSKopDeqhir0KFLQcCVKJp5pvpYHdhMCyRgiEGdhCi6I62mFK
    6ZSiaJvO0PQbxgYbGM5xw0jniMUTib1b7qXTejTBl+zpMi0MDSqP31nEZIp+J3td
    2npUV8qVW/gjPE7VFzwAdPNEjrYPFHGAq2y5qGPh1EnJYBWEFOp1WVh16Fnmdl6N
    1Wo9j55yeuNnLAXGoydbQHskofjnBbEduRo305Cq2rmIWSItvbk6WqETqrRAyL44
    noOPgFWbC/qETYbJE5NTirYqqhkWSP+O0r2RtS69jt/Ci6BFCgkw64y8nK4g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q0iOBl9u x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q0iOBl9u x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMdpSGqodHb5oA9kRPGNIR7KWn7ofbc0Fk0RvhaLGhIkVFOZaSyze3Lfp6fq0kFfFv5MI9bt1HkHhv+60OQcprOX94+S/sTJ054eWs6cBvpRAdPJoZ4W
    en7/p8l7b9+XYE8VMbctaHjIOKgbChNEyeZXTZyRD4k7JysEUFbWNBO3jt1EQB5Mc+umzXozg73snLivHh4Amta50RnF1roPVZ2G2YqZcIHMu/1/esuDp6aD
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=R5C9hjxsAAAA:8 a=FOH2dFAWAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=WPl7tRGWGc98aKb1Ak8A:9 a=wPNLvfGTeEIA:10
    a=KpS7wOGxO9l4JKx0McS0:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753991AbeDIA2n (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:28:43 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:12595
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755895AbeDIA2l (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        Alexei Starovoitov <ast@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 086/293] ip6_tunnel: fix potential issue in
 __ip6_tnl_rcv
Thread-Topic: [PATCH AUTOSEL for 4.9 086/293] ip6_tunnel: fix potential issue
 in __ip6_tnl_rcv
Thread-Index: AQHTz5kOdGQ1v/Z+WEKRJ1lDK2Y0IA==
Date: Mon, 9 Apr 2018 00:24:01 +0000
Message-ID: <20180409002239.163177-86-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:gZ4IiBGSRzRkfyaStwkDiQQNFRxz+YlHG4L8atx7QRE1Kw/yF/IGHXJ4Fr3GU4visvKc82r2xzgjOx3W3/7Veunnxth39I2uP2/JsU6aIj6gtoZFkDKUbPy63GZqarcyG1/iyn/LSVkD3Nv4+5N4iMjCx9G3R44Aoc8rRFyZ/nfUH3xAYIdkQciKvH+VZudRSdJaNkYpu8xq5FHdFoycRQBeyZXJo1OZUgYTsH/DfA7i7IRN1aA117suEMDDM7i0;20:dKLlZi9/5A1VzjMfHcwH3pFOlfKTozEr/dmI8thkPE2tq+GFWJv/N00Ea5FmwldZlAQhI5R5chvj1XcY/d/JJQV7nbJgeCEfZa8h+P2FqINIGHKpvGjv/VxsD16XG6cUe9E6Ws6SCDh06Waq/bCB57mURBw9zD0MR8mJe5f+9yE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56d2fdbf-73d1-4d42-ca34-08d59db0d4a7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807A5AB09345885FEEA507AFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(173505980823694)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: obFimwJZjlfjLVXEgx+yUBl7ivve8fyPwA2KI0OaTovaeLICUfUYBkZdwMOMY02GszC5YbYjFpNSahAhPLwrQXepLzneGmhjzYtrGdFBZ8+U+2DGvBQ5qpqHKnFUw81Q3/j9SLnBtSvvOXBtdgtcFoG/SRnAzuj9nKrG2CFo8QqOBK/sKcfh2AWNVb1oP8lZQuf2D3n4reW7h4zKx89RrU4xUjJigHzXIEpyjVdiWctY4pAR1Dx/+uGbv0n9YQGHtxM4R68BnAAdbIlH39JX986lvUI4cbd6QAoAipUstlyfctU1uC9OEsMPuKSGR27X+OkNKi57qUwPqVE+RcguoKg1uxtfY152Og02S5Nn1/aLMeRZZFnOZ6iphNB5mo/pDtq1i3ikSrbaV3TmW1WHdvz7fw4MhQrCgvr9Idh1gCY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d2fdbf-73d1-4d42-ca34-08d59db0d4a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:01.1593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

[ Upstream commit f1925ca50deb48eddafc01bc12c2a17bfbf54425 ]

When __ip6_tnl_rcv fails, the tun_dst won't be freed, so call
dst_release to free it in error code path.

Fixes: 8d79266bc48c ("ip6_tunnel: add collect_md mode to IPv6 tunnels")
CC: Alexei Starovoitov <ast@fb.com>
Tested-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/ip6_tunnel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index a2fcf7bdb597..5a009807ac2f 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -859,6 +859,8 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct=
 sk_buff *skb,
 	return 0;
=20
 drop:
+	if (tun_dst)
+		dst_release((struct dst_entry *)tun_dst);
 	kfree_skb(skb);
 	return 0;
 }
--=20
2.15.1
