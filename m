Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240338-2-12756859451239014874
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
    1523240337; b=iL8SENPOG4jj1Rkyrz7/rFrA+QJEdLFNv7ya60BRzl06nhxhbr
    MwdBXvYFNi9AN1jEYNiT7dhwGs/9AlrJ07dx14x/StFRiNI5+XpEbtaIOglapDCJ
    fnHOB9/nEc2pe6EmN7WrrfNJx90BSBdgAp/qlo0woojRxKksD4UBPreJovBO5juC
    ARRyUqPX/h6l2XfqBoxUnJ2bJH5xHmw6xmSow0oBU0K3IHb/gRS9xp4v3/YiL27h
    tbELgcbBH0q4maKbDg8rOlOkVlbHFbJi67F6q1W8Ad6VoilwRabDmdF2T6qa4DyR
    4xU6+t53LrbT2q5htFP+mecchnwhNAtoGayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240337; bh=nd076g7Pbf
    34je0RcrYRbrVdGt4Elg7sZIT+QkNfKyo=; b=FQ63GmilBa7tjgObfy5GqwLA5A
    1Ise1M5jhJOLXARB7rdSREXfiYDvGxaHw2MKU88BmybFcBtvfWHMHliRqfH12e0o
    iy/eoy5SS1JJWvrL1Ka7JhOKN0s16X6v6O6F779tLj1FHcIfIw+f7irj9pPVn6N4
    xwpgFyvu4ZQlLnrHg+X1XxfDtUI1Keimd0qhZ5c5zuS2VOKn9CjSE7+2MhnwWWlc
    b2NRs5ufJof6lqlahzrpRJb189YDp7ZJRTPAwrM+vAD0yvrSebleOba1xAxRBU0t
    gXsddgwOeBL2d+HNVtF1LFN/WxAD2jqCgkjqlpw6DB1HOF8Pwo18/qkIqR5A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n3kAoN+/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n3kAoN+/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH0K93t3Od+dJLuB7bdJ2l1tinLKm9n0ZY+eb2BRCLe+u5IaBRo27U/ULQPNk2kv41uaEMh9WRbmE5EgssKDhg2fGZNz5n57ytPkPVT1dm3BUXrmPwsA
    aYeg0rGB+/W9+HbHi7s/K7XWWrK8pruSFpOqdJs8GFFz95OQ5BR93OW1PZKwjDg+KMPCS9XwWuJ6c5jTzbPWHrc8Rx9g4Zw0YCiYkB0TZdSUy2mtNNvlcrej
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=3zoF6VXyhibmEizl51sA:9 a=C8UaXxRzhaQZOXpy:21
    a=xdYuMBUKZ35pDqT0:21 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755141AbeDIAaY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:30:24 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:10314
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755753AbeDIAaT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Vlad Yasevich <vyasevich@gmail.com>,
        Vladislav Yasevich <vyasevic@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 124/293] macvlan: Do not return error when
 setting the same mac address
Thread-Topic: [PATCH AUTOSEL for 4.9 124/293] macvlan: Do not return error
 when setting the same mac address
Thread-Index: AQHTz5kf7HX3Ie/nQES2Jo7EPlrEug==
Date: Mon, 9 Apr 2018 00:24:29 +0000
Message-ID: <20180409002239.163177-124-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:G/muW76c0YAOdYKR7KtM8cDDUPo+aTYRAtqkGsyHk51kwsSYy01L7bmivSaK03Fc9aD3pjCXIhmiuD+hAb8zzy3obLVhk2SBcwh/VZMcbT+QEN2FbYe4nsq5CCmt415YSW9CV5e3hPu92BDcS2bslYEGvymowpVbag/037dI6ecIdynQIM8fQ4W1E1BhFk5k7vLMJ77R5cYndgDKJ8ZfBryAS5seoejYdDZckej+l/yU3aAxvkGltib87tJr2iGR;20:Yvb+Aoy7KP+g0GDxoRak8isanuWnSGiUQORgDjiIJ1hS+9g62U8JQ7cTcseUvpFBStqjNX5c6vYzXlsZfW9io/2qCfCMvh7yuYbW7D2ebOk+7cDu/Fk03jiS+fvEC4pRKqswMHR/w/aBwlUuOUls6dQsVbvi8z+dj5XY+uArpX0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48d852e0-9c65-400c-b6e3-08d59db11080
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10322789B3E8FC2DB8DF3DA1FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(39060400002)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(575784001)(3280700002)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: EOn5wQa3608ic3G0qKFCgPTx7RIgFXrmPzoNugI45zs7QHJnI6+m+7rOh8omXq50iMLsv0XBj+72ahzv+tmEY58XjEyOI1YXKHKUhf5UrFMjV/2ADOabmZdDI72OEAUHobljTeKmssWnmjdyPNAw5MbJLuDeebEVQJh0wIJk6kX5WOLQ5g1L1oZnEW3BWkY5NQcLRr1huSccSu8nR8WJNg3HNVh1SNws9VdH2xIMrYA0Z2no0i8NAqulP5r07+sEoqFCCX1OwTt8ed0+IfAtEcZLyyVilt3RILuW8wr9QzTSctMgSgcgvgzW5uX+qMZt0tLOdhLSty9MuBc+F0Rk+0ibmAK6CgRJizG2kKSYdQmWoRPX5gii4rUcr8pw1OiVN+7s60hjspn7F/zD7edBBV3rz0+fjVsRGmzpaP6mGKA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d852e0-9c65-400c-b6e3-08d59db11080
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:29.6906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vlad Yasevich <vyasevich@gmail.com>

[ Upstream commit e26f43faa0d79dd06e9e94829696b68b9940c2ee ]

The user currently gets an EBUSY error when attempting to set
the mac address on a macvlan device to the same value.

This should really be a no-op as nothing changes.  Catch
the condition and return early.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/macvlan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index e8ad4d060da7..3d2cfa5e824a 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -705,6 +705,10 @@ static int macvlan_set_mac_address(struct net_device *=
dev, void *p)
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
=20
+	/* If the addresses are the same, this is a no-op */
+	if (ether_addr_equal(dev->dev_addr, addr->sa_data))
+		return 0;
+
 	if (vlan->mode =3D=3D MACVLAN_MODE_PASSTHRU) {
 		dev_set_mac_address(vlan->lowerdev, addr);
 		return 0;
--=20
2.15.1
