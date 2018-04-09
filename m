Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235322-2-6693030139459824702
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235322; b=vc4ceABNsv/k8arwfTAD+JNFbfobJrr/rc5HLVODo6D6b7DFc9
    ChzWVDfSIotOlXWuvRFglgb2TA7AeEojPkzSfxxbytOytlWeNWY24VrcwnA3Yiz4
    UNB++VD3G8L7PQyHQIUxpo7Do3AdgaEu7bUOS1dip6GvNqqZ9Yp93cnRzBMvsdLn
    WJW1iaDep/C3bXztxG0FuxIu7awUbyk8yJ4XEzPwYQVHeaJpQecC1YI7EsNXDgQA
    YPnyBtWP8FbnCL5ATKMwbALcZt4R4PyL8QvcTYt6fhvOkoi7qAWYLAZKiJQbd1UY
    Id7ElMR3o8yOpwQ7NknS9zsNz9qMZRjigkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235322; bh=tep5ZwG6jR
    8U/529vFdkO/nWPLzUDsN1hxfXpBsixrs=; b=LR5eNES6JYMD3vLr2VurOExD1R
    T0pK+DSFo0lRegtV6FNB8Luz8wOCs38NgBRXUeFvNMyyW9Wc/ONQy8spgD1KCvez
    p3Exiho/YP02QoFcII3dCo9GAcC8+WDlgpg4FgmF3QAud8FQVBMuMTxq4rnvbAUT
    4WJ7NkPlP/VWOxwA0UDcvia2GV1qzGZHgoYClMYKa9/DcFR4MnYTiGmhO5ng3fcv
    zzEyD+t3WsS6SP7KOItoalIEagK40rHystahRNSMraKaJvdqvCWa7TGTfuvqRtZ0
    xm4E41uxYWcoOa/iAx5mxeRK1jyKwPJ7UUVXiuWI7kSDWmMdKejAyF2IyPNA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oWMT5JEN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oWMT5JEN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK96pKeP9uD0w6GwgC3uZNsUT9qL9E6MtVyMZzAGbbxACfCpv9R5uSkwL4n2GWydYYOnkKmISAS1WiBJbjnJzAgn2Wf2XDRKV5E17al8pl+ZnZQYRpgL
    pRg9o8nqqd6RK7cXfyk9ESZ8cCKPU+W6Tvw+BZP2EcG8fwEZn+kAJqLUnNEqh2Lsg6xDee7nupC4b13dWwlQ6UZvDDBGjUtmRTRgUCOq8mxaQ1jQvOYCNBiN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=3zoF6VXyhibmEizl51sA:9 a=C8UaXxRzhaQZOXpy:21
    a=xdYuMBUKZ35pDqT0:21 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932628AbeDIAzE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:55:04 -0400
Received: from mail-sn1nam02on0130.outbound.protection.outlook.com ([104.47.36.130]:38544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933298AbeDIAk0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Vlad Yasevich <vyasevich@gmail.com>,
        Vladislav Yasevich <vyasevic@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 045/101] macvlan: Do not return error when
 setting the same mac address
Thread-Topic: [PATCH AUTOSEL for 3.18 045/101] macvlan: Do not return error
 when setting the same mac address
Thread-Index: AQHTz5q4QTSxJmP41Uq2Wmm9AIpGQg==
Date: Mon, 9 Apr 2018 00:35:55 +0000
Message-ID: <20180409003505.164715-45-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:si9xGVeGkvkffQTSms62PuvEd96Jkk4YTe9yumI8TyTM2Ig9yHyOC/nzcyaqL+BK3vHcxQOq1GOUb1S0IqFX9BGlOVPTvrD1SOa5+wpPFQp6EXW9IOjdKkti8Kl7w2+f/CQoBdr/pvNNo/aheFdeNpGuxzMJQXmvJWYzzMjXbOE6s2MJM3JMU0RvLWMwDC8pzzjLUryR8kXXGIjb4uhxCBFOmPRd9GzKgZzq15WMO1QXgPt8/h6aqYvG1nvoXDOi;20:YZGWYf2k9tWPYwIsdzzXoiakGkLtH1cib+4UExL/IouYMXOkqdEKHPV/AyEaNBJqtESuD0SIjLgDPCyi44/g1xBA1dV/dRl2Ngk42O/BFToC4n6FRHiqf6O4iAVw4JQJN5VTcJcMo7/teNR5+uFHXCb2Qyd4yNfc/KOxKsD+EJI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24066ab0-2a7a-4036-c6a1-08d59db27a64
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870C335A8B9455A6CF7D652FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(575784001)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(39060400002)(486006)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: pmkglGVp0jaIG86QdZgBjUZkzIl1ln3ApHHICGnu66vgwk7KQYujYgawGQFY2yf1nG7GMjz2aWek17jPXIc81DvWxnxNLcQ+drGac0KnPjk1t/meivufap+QzXXIPDkdG1UpbaF4eTkNEJLhaixmLkOPSr34RvoJPtlW0g5vbVmECrIIoM711YSThlssviD7VHFZ35TePys35ZJqswSqjeKctVPUY9NEQhBuLuBT1pr47iqurfKr787DDUrD/Op/Q1PEJCNKnYePZP0KHmOWIxAxUDE26iyWTYtJb4egi36vr1z79MaxDdC7AmCqW4/0iuN7lHLcNrdAvZiqPx0IP6VxWP2SE7yo1A+7nVho2dvAuM+PkTF9E2rw/EL20MvfYZCBQmvhBJX/GL8aLViOAXLAfwSkCvtWMXiepcH+N1Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24066ab0-2a7a-4036-c6a1-08d59db27a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:55.5328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
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
index c0818ec3d427..fe7b49cbfba5 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -681,6 +681,10 @@ static int macvlan_set_mac_address(struct net_device *=
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
