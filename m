Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489785-2-14945310724030800637
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
    t=1520489784; b=CgU2gIN0fdcUf27QFFWdvXR6S5Cx36j/ydNzmxStlfr6N9Q
    JrjmM3hoPOX6o3lhDQyj7SG2bXhWj88X9hAls7EiPRlXvnGPzEzNFC87IhaKILzd
    M7ofCqVx/urvWlnPTMyPbJL5PcsMkMB1meE/CSYZzK1EhEaey6BWSiquEpsuTRDP
    idfaF2jgmo1e2Y3BKeYiLHJvjpfQT4jO6ECg5/klPCmPw6qukUqUKN9Yte0gShPW
    ukJECU1dgjebuQYM31RkZtju6HmU4+Z2kbYN7DSsdb7IXhwtQPwa19NJKUhxkJw8
    C/xsXePntVdMW9Am6viYgVXv3Gm+0mPUzMI3sqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489784; bh=wSmDLK
    Lc0HrOTuMSvWgGB7a+nThsSaCxOtQMg7yffUE=; b=EOTPp1QYCNC+ChZaHzMhMW
    jN7zm/IUVsidZpfpj3KYdJcObJvc0uNS6thQ0e1basqATN43vstBEXrpyr9u7SwZ
    TE2enf8mw+JB+YmXQv7sbQdCzwkzLRm2x0Pz7ntJ6jDgVXNOlCM2BE16V1Wc04VF
    G3L3DhzmdIlJpMIraxD3JwAGDcpmxSMkp65sdncwwE30jt+uh7Kh8E/p3duB8NCW
    e0F/BIbfywRtvvV/gD+gorTfUC82/mvqZuZFY9fVQaY2oDYx0NjigFk4WzwgfAkp
    0hEDpQjlOQuwbK6PGoOvYSD4Lv4TojWJznvarXwAhZLmFPX2PIqT5CxPixxVWTyQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LIoTPMz3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LIoTPMz3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965709AbeCHFBZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:01:25 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:14896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965601AbeCHFBW (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Feras Daoud <ferasda@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 062/190] IB/ipoib: Update broadcast object if
 PKey value was changed in index 0
Thread-Topic: [PATCH AUTOSEL for 4.9 062/190] IB/ipoib: Update broadcast
 object if PKey value was changed in index 0
Thread-Index: AQHTtpo3hsBofq6DXkeLh0wAE6qWVA==
Date: Thu, 8 Mar 2018 04:59:19 +0000
Message-ID: <20180308045810.8041-62-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:yLGDeLOD61IEbrFV7xV/4GOijs3TYFPWXHXHQfJS4ee4wnobVmO433ZWehFNTwu7OwbH3CycH0KpkLPzh82UWT0cvt3AH4gprp3SeO5qgh23+cjKirgyqcIMKLacezF/F3J66+F09tCvxh2/q6AFwh3bl3BmRS2pglYZVIpQDW3howSLy/KdoKWBR2LHMTqbATohNRFfDDUXgkvtkjTvPMjchdL/iINkzW+j6jkd4WOGZw8nw46AzGkfmsEgVi7G;20:rRjaYNf+MG1uPu1SEY7EeI1GYRy1VDEkgDZvQAzijt7qbVy9KoxOojOEST5YHX8wnEhkfloRTNUef20rVtOLwPzKeBDjVAOKYcRuPhMjValOLkq2i6zma564c/QxlnlzgTkCMStwMpSr1cvaHwOsNu8ii3wPSQps4LyBDTn8mSs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1840dcce-78f1-4c05-0c7d-08d584b1a1b9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0999F4F4FC7B381B886025AFFBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(15650500001)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: qkRWg0Gw8v5p/yvF83BcpF6E+j70zr9Sg9MAvtRMkadWr/yM8rBuJ0lWJXlDmGmQp7ek8ssdbuKJj/SynkUitq/jZ+8dGo80/v6B9lJw3W/7/fCl36j7fh9fhSWr1aikhny+lVWM0H4tXYUCz7P2uRQi/4ROHF2dIbVuB5XmZvHqbdIyAZJheN57q9Hz9SuzFOE4TnhTIpCW20iJBpNdfVdjQgoZ0ATUZqg5LnoVxBJQmhf1qJJIcXggB4QoJC9+TDDnOUkOyWN4mHipSCESM/wFL9iUh4HvfyWQ3XI6ibLHe9I+InjT9XPGkk+G7JHlVnEB1PrOMoXkDQD7JAwVsQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1840dcce-78f1-4c05-0c7d-08d584b1a1b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:19.2765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
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
index 335bd2c9e16e..34122c96522b 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -974,6 +974,19 @@ static inline int update_parent_pkey(struct ipoib_dev_=
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
