Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235739-2-2985851587860580976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235738; b=mioorCLuTgFlj5VK+AFb4zGQo4obDqQlgRYN8hBRPMi+T7/eWo
    RdFgcjh2ndjl/5TrfTAYL/mso6eWRsjG5O//z2u61+lJhZ+K8nxziv4M7Hk+5Ql+
    MQB+KAioB3ylQZa3POpAr64nDgsEUlMP0Qm++VhEwEcUfJ+inBy7GPG/iZuB+Pq8
    wo1aoGrNY1yyzRvFvnjO/SbmYf2VCCypz8+mNUNGItK3u420CxsdzncUwWwF4ArJ
    DjokynawfoA0AzeWUs6JoKK66H+j3K7W8v2iz8R6Lw9rdMUq0MWvAF6ZbioPLNnB
    kTAcIPMF1Z5idKTrHrfN8uVAVeeiSNzJSxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235738; bh=ZnWFVvqNfV
    E/XGuEU9YMzf+n7dIBCGlUcgxD6NhYr7I=; b=IkXaURUNCx1jpYyhl9tUuXYCBC
    kq8jh2HhW8seo7P3HkWCffcoO9GfkyxqPOBJK4JvdteCS1q+nT7GbO7EvLZPA3VX
    Q5fYKm+JzSS6gsxiq9i/LNsEFbKgzZusyWGAwGVCF2knRvL1bRyYJTtLOLUJjf04
    yRuIOZEoSueVEWqO9pRGS6TIClKkzpn083xy8w32HHwkLKEfMPrcQdheIe245XfK
    8O+jtulgIeq3NqEV1X+AzHAg7uN/JRwWlobYBUkFpnaFSuC4lUm1BM3cMRqrVYZO
    j0RJKHvF5HV6ZuVVM5vwmXwO1mPKkSR/cU9cse1JQBVVSqnhFr+8v9Q2OoiA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DVscxT1p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DVscxT1p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHZoh2YVVxr6tAwZuGTPGM/YhzrNUQBowNru5F+S5bzfCggdsP2Na4Ypdwf9jueKqP2KKbZc7YM6eMm79zU/WuzLjDLea8O2E+MdJs4T7RYq9MjxOc60
    g3odFDDo0dhxr9QqmtPm5tLyhQsFDc/MOC1CsPfx7NzECmuRqH08kN18suQI77WSSGaJuwJcmZSVwfOnVZURi3UD3dM1/DGbK6iSl4ivSuxxtgEZRL8YYa+x
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CDq0vqnqAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=mVir9Wizfw9NSaUnJ1kA:9 a=wPNLvfGTeEIA:10 a=Xn7iXEen_xUG9zZOO_Hb:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933175AbeDIBBT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:01:19 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:21055
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932457AbeDIAji (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 018/101] vxlan: dont migrate permanent fdb
 entries during learn
Thread-Topic: [PATCH AUTOSEL for 3.18 018/101] vxlan: dont migrate permanent
 fdb entries during learn
Thread-Index: AQHTz5qmxLXU3Ojh5USMzQ+1523DKg==
Date: Mon, 9 Apr 2018 00:35:24 +0000
Message-ID: <20180409003505.164715-18-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:P3JgQfYbjK6705NyAiu6GftlniGwRsYcFRiUb8AW64YTpnY/SFZwTICmS1bwxX8K43F2eDOIBDvKIYhWATi+X1Rfog3H4Z+2cbs+wN2HV6rIA8A+nyeH7qNw+3Ov7M3RrTRgyys0Ro1dZfnqBpfzb8AJYqpley1C78hGoXyj2ilRD5MbqggH0s4YlIi52P+EZdG3zIOccAQojiOM7GTD751wGZokNqCgQ2jRX1GquuuF/3irkvlMKa0bAopBJUhA;20:tAoVjTibBDXuRnDD6djAO+K7qLiXb8DhZy2jaLULwUuW3cXqQEMS5fWxhwuG3XVgRSkt+l6mTSvcWXFJy033sa5bVWgHR6E+dka6fWhC9RF/99JuaYsAONZ1PcdRt4kb2XPTK0FSASRAjAzasokfrm4kDp06pHSvUROucoW54cA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7363156-81cc-4a51-0388-08d59db25f27
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096601A0D1039A673F321285FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(192303002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: d31DQvE3owdtBUi4TwWYqFRY749dK0uXgwqWlvwX5+QXkoulB7l8vF+2hcLMFoGyVuiFlU3AdJsQq2j3tL5dzAvBo46MIm8eZw2pm/CF2Yw0oT5P4F58ZsRD8TUDMhGVPkusd5grVyn0dS4hIQTDtdYZJ5neJtoXH6NlKYYBf2OZZBU2fnydoR7sGpBXArQaV7gF5zDgwNPT+w6Q57IWcrCv+oDN0fEfatkEiPOcwgq7yDWy7rTJpXU3n58HjdhGYwfgDHJAb3wtg8DMUfmqaHgojmU7lYHzP6wiOQCHljyEwYn90etfTA7jV70dPk5TMRjQdCnaZwQvaSS3/Y8iw9tA9+ODIrC84Yc4HY9jDFMg46X5RoXqz062WyHFh5Bpp1745BAK7Kd7l98UvDvTKhcNx4SCLQ6wpRtJ76yV7AI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7363156-81cc-4a51-0388-08d59db25f27
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:24.4079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Roopa Prabhu <roopa@cumulusnetworks.com>

[ Upstream commit e0090a9e979de5202c7d16c635dea2f005221073 ]

This patch fixes vxlan_snoop to not move permanent fdb entries
on learn events. This is consistent with the bridge fdb
handling of permanent entries.

Fixes: 26a41ae60438 ("vxlan: only migrate dynamic FDB entries")
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/vxlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 2dc89582575a..3db77c274098 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -985,7 +985,7 @@ static bool vxlan_snoop(struct net_device *dev,
 			return false;
=20
 		/* Don't migrate static entries, drop packets */
-		if (f->state & NUD_NOARP)
+		if (f->state & (NUD_PERMANENT | NUD_NOARP))
 			return true;
=20
 		if (net_ratelimit())
--=20
2.15.1
