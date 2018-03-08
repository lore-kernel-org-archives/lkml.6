Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520487472-2-9730259423177727744
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487471; b=Gs3SqRb/LELUYMdmjXgH3YDmRScnAqqexE+VFM+25I7I5JU
    3Sz31DolPAiQVu931STI63f20c9qY5KN4Se1Ls1vHMjTfB8hgzSD2ur6Vn9bKFg1
    kJJAgSh+mDNc4LKZ4CCm+SKSJ6yIYHSYXpL7nXXdFFVW39+29lmT6tCXj5TQ3COh
    ILrPWIUAs09EZDHvd303D0i6ZmnhbL3TG9Wdc4ji3Sl34ncn3zbu9l4dULZzomsR
    X7v4+Q7QrCjfUpZng5yC+kX95s9WnVciFdIdSDMlmNKdyPg0ZWlwctXoAG4AW/1O
    9SU3hH2ph4zYqf5jE4zPyTOzpvQ+vT+RtoMOf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487471; bh=r946wI
    8BjGkaCslv9qyS6aY+Jk1BILFzp63WynjkLHs=; b=Wq6bMlWtJV70CHeQQRR8LM
    L66H63gQWDhuAs8Vb9t2li9zyT8R1/7tvLA1N+FAyyPKBXNjKBFrnKJv5wZtf9bT
    1Pwxh3yDCwswGwUFNUkkZ0tkGe83Kbrn61J8HrLQO7VOdcbzgaDqtBTE/KkXkOG+
    dsrGY+dJDdWZDU9APZT1bPf1C9wY2xv65+cAigUe5A1yobJhvdRui81JZmZ6l4jO
    2AFPdl+G5mu6egwrtYLIF26jpe8ThdCP/n4dWxUSm3tLun06T5aU2dLAl91x8ydo
    i2QGHEAyB1nYabWNnFzGsyCfXoBdpM584LBu3mzX4+QSLetrWFEVexy5BGh+RGQA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kHZIZmMH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kHZIZmMH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966329AbeCHFhj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:37:39 -0500
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:7384
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966296AbeCHFFz (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Feras Daoud <ferasda@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 037/101] IB/ipoib: Update broadcast object if
 PKey value was changed in index 0
Thread-Topic: [PATCH AUTOSEL for 4.4 037/101] IB/ipoib: Update broadcast
 object if PKey value was changed in index 0
Thread-Index: AQHTtpqL+P9bg1vZKU6gTEDRfGaNdQ==
Date: Thu, 8 Mar 2018 05:01:40 +0000
Message-ID: <20180308050023.8548-37-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:0ATVCHtFinwY410EvvU8jjfnX41d7pjqeQ7HsbgpMjg94SljiJKIkdVJv5voZBguMcvL5je3qj7/e0d/g47i0HeCkCpEdnncpoVLoV+jX34GUFMqBtqXmqdKToyBdaGm6FM+JTTnn/yuiIgerMoPopwvUo/PWrhlivkx1SpHgygkP/0qH4m+UTbBTCW17QDSkMTGq8b0+z3WO+6Qcmsyy6XDXnNAlYY0H1UCBSyqKGF6q+eqpeCCuwD5ahxhMcVB;20:Pr3WnObs/0a3kusYw/bRp5Q+z/Lf3nxT5CEyfaHdzKJ7IbjBbzEZ/hUOgd2kmdrQLTwXVTDVufQiQlNhCDeHtMia/qjtBD9eFzoWxzbTLR6HEfD/mpG4rF6NUnZwjYwGE4iJYDVFZIw5+61MDDBKePNpHI609CjdWHIhWCPlPuU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d53e088-ae8b-4d3e-9c3b-08d584b242eb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046314B089D6A1AFE65E273FBDF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(53936002)(3660700001)(5660300001)(6436002)(15650500001)(6512007)(36756003)(3846002)(478600001)(105586002)(305945005)(6116002)(1076002)(2900100001)(72206003)(3280700002)(68736007)(7736002)(97736004)(22452003)(14454004)(6666003)(2501003)(106356001)(10090500001)(10290500003)(2950100002)(81156014)(25786009)(54906003)(107886003)(59450400001)(76176011)(6506007)(2906002)(110136005)(99286004)(26005)(186003)(86362001)(102836004)(81166006)(5250100002)(4326008)(575784001)(8676002)(86612001)(316002)(8936002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: NxoaQhVV790ze0j8CUZBs1+uzgu/pkeTiiZ7KF5FAXLGvvAiSC4RlB+4QyWSvvn3UljNMabnKUDgEDB41EgbgSQ3hvvJthRUX4na73OzZp3O8PRq7WzIvha+zp3UHhfcXLcOUM8si7SkY2nvIFgqPNLW7eKySLrO9TVb+DhDNl6/V2YrIndgXmod7vwHjgJpSdHCs2+bHXn3nW231skna17BOc7lVVJdGklobMV9A9qv6rs8Y63Dt+UoB9fRKirgbEvD91tABZAuiGawmYBfaf7h44tQf649O02TfBFtBhRMUCII44wthEWGnQE/RV3htQsIVyQVYJcV/w/5u8kssg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d53e088-ae8b-4d3e-9c3b-08d584b242eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:40.0852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Feras Daoud <ferasda@mellanox.com>

[ Upstream commit 9a9b8112699d78e7f317019b37f377e90023f3ed ]

Update the broadcast address in the priv->broadcast object when the
Pkey value changes in index 0, otherwise the multicast GID value will
keep the previous value of the PKey, and will not be updated.
This leads to interface state down because the interface will keep the
old PKey value.

For example, in SR-IOV environment, if the PF changes the value of PKey
index 0 for one of the VFs, then the VF receives PKey change event that
triggers heavy flush. This flush calls update_parent_pkey that update the
broadcast object and its relevant members. If in this case the multicast
GID will not be updated, the interface state will be down.

Fixes: c2904141696e ("IPoIB: Fix pkey change flow for virtualization enviro=
nments")
Signed-off-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Reviewed-by: Alex Vesker <valex@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_ib.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/u=
lp/ipoib/ipoib_ib.c
index d3f0a384faad..f6b06729f4ea 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -945,6 +945,19 @@ static inline int update_parent_pkey(struct ipoib_dev_=
priv *priv)
 		 */
 		priv->dev->broadcast[8] =3D priv->pkey >> 8;
 		priv->dev->broadcast[9] =3D priv->pkey & 0xff;
+
+		/*
+		 * Update the broadcast address in the priv->broadcast object,
+		 * in case it already exists, otherwise no one will do that.
+		 */
+		if (priv->broadcast) {
+			spin_lock_irq(&priv->lock);
+			memcpy(priv->broadcast->mcmember.mgid.raw,
+			       priv->dev->broadcast + 4,
+			sizeof(union ib_gid));
+			spin_unlock_irq(&priv->lock);
+		}
+
 		return 0;
 	}
=20
--=20
2.14.1
