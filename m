Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520485842-2-10883335861209662311
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
    t=1520485842; b=jik+l+QmWycEz+67OaCKzzQLc10sP/qbD6AU6HH5YPNv/X4
    EGVvpUsnDqWByu9h8Vlw3DpbSGqB1Fc/Yt9wfkkTdIqxdAMjIv6iH9l6intfA86W
    yVUZx8GbnCEYltn7VER6ysOOk6ENksjmfXJfN5AWshK0hLLTy5RyC2eEzzjo7yem
    KRuSeS9Fip3wM6/Xq8xefAkdbK0eWUtz32TpTsItcBfno2+s7CgMcz+yorxEv778
    E/rV7hTYy6D2xULvg9PLeyOmzGpFOEvHzDZ76o7Lm7OpqdtVl123go6MR9s8WZB+
    y+AOLl0wXOVzhbFBKm1iGD7OnmgtW2KHb/LH+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485842; bh=I35gNQ
    HLvp0NZQtgA/hzWBILzM6/Q3CIgEUejU8Je3o=; b=LHOjayeZeOlitR0rOn1RHx
    vmZsX4+jR3KusHZLcc4xQdG7pELfgrTiVZ2wGh5vleqLMK5TPX2ziZpSGqSOJd7c
    kf37ouBsMbb67Aswkbcg+Kmw5Gc8bd2GsIwxvKCfjiJ51zg5WxDRfGBqmGMxiC3J
    fe1Gx2R23QW5iClBgtYnX0KjA/ldyijnmvZ4JdSPGoY7ekQ/kj5uvS4g4rRVjPkD
    o6Sg98nQs+yw/nzFdM9oZ9uQZuPUrR6vLrfJk9dbrZlEKA4P8PX+Hxfr5ZDgFzeV
    frvBPol/ElDpL/Hkq3hSrob7dZ9vqDldSv3OEMIKEpoojDptaEz7QxVXOXiVvXig
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g4bT+jpY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g4bT+jpY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966824AbeCHFI6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:08:58 -0500
Received: from mail-bn3nam01on0128.outbound.protection.outlook.com ([104.47.33.128]:16664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966793AbeCHFIz (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Feras Daoud <ferasda@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 24/53] IB/ipoib: Update broadcast object if
 PKey value was changed in index 0
Thread-Topic: [PATCH AUTOSEL for 3.18 24/53] IB/ipoib: Update broadcast object
 if PKey value was changed in index 0
Thread-Index: AQHTtprF444pYBVwp0etDpK5/F7WOA==
Date: Thu, 8 Mar 2018 05:03:17 +0000
Message-ID: <20180308050230.8876-24-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:nB3WIiX2jDL8M4FcHLcFfeC66s91mwDHzgFWdI+hVnR/l1fKl6uEGg5/5FlmAVMMS9HMDfGKyJDWcFkYyPlSpB1Au743Kw8MF1wB5BikJdk1Eti6jWEd0sBSBjETNAxt47z+i84dTS7A9+cZiiDZiv5RB8/WtJT77twXf//YVQGO+3zLqf/NVsd84pCnnYM4KJqjwvV0aBJWk5D/4Ex0Of88JyShgWK9+CCrd80HhSbNM26YjTW6U5J6igv5YVc/;20:FJ19lr0xCYH9PnWWG1KM/lBifojmBpAVzgCfZAOXlvblewZEPD+nB2nPhx3a7sJM6oMikWS0sxCkdw+TvmbK1odXqjiktaXXYecfZrcjKAbUEyj255VKYqOB3m5qN8SLTQGN0F4t4CCEZHPqTAtK/t/CjzcKO02r+8PQ31s3qmI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5aab29f1-9625-4dfb-612a-08d584b2add9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087191E7273A0992018A770DFBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(15650500001)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: hduvbd+rMinX+3Ya24B0HGrQ8h27ihrgxc7vbexoAQzonGhUUFohS7a5HJGcnai5AYkNE5lhg5aj544dZp36mdGO7qWbVLzwbuNtd847Wyg7PvrPD8BOE2uxs2xIc17f5fg09ztXgcwd2kO6k2UAtTAAs4zlPxo7HcR3PBDbqL+jQFmgcLqB5DYmleB5w8lrIL5RUnJMJQIljKTrxUmnPWg8w7TBUgpqkGWEhG6BrdENd5+H8tKl8smw4165Jksl1Fm0qDm/vLq0o1sDwGGCN+MDOWAjYDbvW7EV1A1kz38Y1f58e6YyOjVhHURqdfSYA5zA5itFJWvjZys4zoKMZQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aab29f1-9625-4dfb-612a-08d584b2add9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:17.4484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index 72626c348174..963cef55dc60 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -955,6 +955,19 @@ static inline int update_parent_pkey(struct ipoib_dev_=
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
