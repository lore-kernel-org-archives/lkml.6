Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120970-2-9720588433192269131
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120970; b=OrFRSB5NLmj9bQ02Nex5IBctIoqYz9a/IsNO9etB3gr+XgM
    iGD87NBm/cgoKHdmFCzMlNUebYU8AI+m4Vu9gOL8iJ+c8PSm+WqXEcmLRUb9lqpV
    0ylVROWjHf+svLhY7yvpeqeAtkiDxhngrjxFtbJzkBiI4EGpRz9OY4ZGvLib8E1V
    uraBE7U2VA7qePn2oxYiQwrTDDfkyDPaHOVzDk+GfuC6hIfxlCsYyv3D5AA25w0P
    tXrp1Y/fjSstvCuKrZwzSyTWAkrt43IKGckhaT05r0tJcjjr/NwPH8yPnP34uDcR
    mywBpzgqNNdslk5FKlprftn4i1OAEUIsG9M/FjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120970; bh=luaoUj
    tODjAbvY0U9G6p91TNXVPu9WThvZ2hCRXCeKA=; b=kdnkLDZgPMnbmivQ0xMh4C
    1/7XQ0X2/K/pOjtIbf/qRiZNLdQmmxwZYN8USg8xx8ydFibLMb6CrsyWx418rH63
    RFgObuomNneyagnSprzLzQcVmknwK2kJsjV5CK1I9Yd7EyizVCcj0STU8XcUGVXK
    U+pNHdFJI5aEia6Wb1PxbPkluEieurkUgC2+/aFIT0W46UyiT4tmoD7n7Hjgwb/2
    xjlJ5c/QJyw6ElKUXmRRuOuM+4g57Iza4IQocUMdQSA821D8/sujaFti0SdSDm+r
    GkWPCqxP9bHlF6Z04r6w4ZMSau9aX8bbgvVsPXy/9s7owStEB3sPkKqVJhZRSHVg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ErgPi0Rl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ErgPi0Rl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933639AbeCCXtZ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:49:25 -0500
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:3173
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933463AbeCCWdy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Felix Manlunas <felix.manlunas@cavium.com>,
        Satanand Burla <satananda.burla@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 092/219] vxlan: vxlan dev should inherit
 lowerdev's gso_max_size
Thread-Topic: [PATCH AUTOSEL for 4.9 092/219] vxlan: vxlan dev should inherit
 lowerdev's gso_max_size
Thread-Index: AQHTsz8AmEjmugU3ckWTbBi1GRIsKw==
Date: Sat, 3 Mar 2018 22:28:49 +0000
Message-ID: <20180303222716.26640-92-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;6:8U6VwJKhWK9JD4IVq8SZuxldSmtBJu4bEeHYWa4eUrze7G39FG+0eeA+vOVXx/9iJ+WtrgabyA2Wi5D7LhVi3cmOKcAS1Ygoc0IFZSzUaBBm3txlgqOZGXjuZlXkQLKYRA6LHAvnMeqgThsFKpbGqfqWUMNK6zzea/1K7g2Ewfkn1QhnGB0h9XBY4LMAZ9Z0kxPRG9I9WJIlHVg6zsrDE2+QO33eE+x6DlRzC9WZ56TZU9RUpqukqa6vKfADDgqpi0fycMd1wktUvcbf4fVXclpg9EMJq47q6yzycBPEFMy0FVMmEhNtiSUU8k/m+c2PDjcjycSdRJVGB9+V3BggqoXCsxBw+GFkxtlTKzJ8suCNryCvspLyFxqZbPt+vjyy;5:1/fzSXf5b8bikaxokXVfVbYwKTuKM2vvMhrHeo/cc0b1R4qAvtcryf1TlPJXe7PDl2jFiu1+O++b5jUH5hPEbnz4VXbeTNU701pYBqF74Z+4cXGTHtGUsZU0PI1scnvHf3O2H6JarHNTM6B84QKeQvO06Td4sNtx0d4HF2RxCBM=;24:pr5AtocmCmPi/EEf+AEKMh1oSvc8lICX9v/ttisY1k2roiZ1bT7NT2zX0cX2KEd3UNyoy0oW4tOYIhV/8X17cWmQlHMTCJR5KNsvWOeXTvo=;7:r12CfKEvIm+5pOEDXOdh9xlne1C9IOqmsZJYtPLEjh1x9qm7Brhlpr2MsisY7HgaENILlAcVLQr5EsQ00hoG1+aZlNIw+KIacxnp1lraQQ6I89xtxvJ9fhltuBILVYaE44E1P1LQvoclXOpH3+uB22JqGteRdeYg7ZXfTUDY4bMmEda8OiE0MTGwIMjBi26XT6c3CyFodxJyHNp0wgGT5OnoVArM9qTq6v9YPsCGc/w2f6yV6cYEt4VyWcciAa6H
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd6c0080-6dda-4dfd-0306-08d58156d6c6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106537EA37E3E9B474675666FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: HIuGRACZoj3FWTF0P5alLD1mO/gkDDBWGISG1J99xKAe07qs2B13t6dfC+ippilGJeJTYRWTzbSf8Vtalb8CBSWUgDMni5STHglDu1DCazCst2kBSjx9SNa/MxkyXCHhKwP2+gLz3VPfQREAYYfAV6r2n0PGunA00kTJHH5x99U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6c0080-6dda-4dfd-0306-08d58156d6c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:49.1975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Felix Manlunas <felix.manlunas@cavium.com>

[ Upstream commit d6acfeb17d030bb3907e77c048b0e7783ad8e5a9 ]

vxlan dev currently ignores lowerdev's gso_max_size, which adversely
affects TSO performance of liquidio if it's the lowerdev.  Egress TCP
packets' skb->len often exceed liquidio's advertised gso_max_size.  This
may happen on other NIC drivers.

Fix it by assigning lowerdev's gso_max_size to that of vxlan dev.  Might as
well do likewise for gso_max_segs.

Single flow TSO throughput of liquidio as lowerdev (using iperf3):

    Before the patch:    139 Mbps
    After the patch :   8.68 Gbps
    Percent increase:  6,144 %

Signed-off-by: Felix Manlunas <felix.manlunas@cavium.com>
Signed-off-by: Satanand Burla <satananda.burla@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/vxlan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 983e941bdf29..50570d779b01 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2912,6 +2912,11 @@ static int vxlan_dev_configure(struct net *src_net, =
struct net_device *dev,
 		return -EINVAL;
 	}
=20
+	if (lowerdev) {
+		dev->gso_max_size =3D lowerdev->gso_max_size;
+		dev->gso_max_segs =3D lowerdev->gso_max_segs;
+	}
+
 	if (conf->mtu) {
 		err =3D __vxlan_change_mtu(dev, lowerdev, dst, conf->mtu, false);
 		if (err)
--=20
2.14.1
