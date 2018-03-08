Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489845-2-5049942136069041260
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
    t=1520489845; b=N4BXzZuZYQHmlJmuKMTWfktLtB+e73b1/KBhoPkxcHDtk4y
    dXylZhF0hRw7Po9bwmpx7dNgW3V9F4WfLSMVfEaWa9u85qvawgJSEMyUvEB9vju5
    oLXEmTUWVT8xzNVlssqoZfx3bfMxCdxxAiOaJu1oCde2dq0K/zQAMPAR33RS0bkl
    ADAIVawozvoMD2thppXD4UqZ6LNASEIVhoTA8g2bsXvAH5XrZWcvbU2OY4IBPiHi
    MEArAoeH9omcYwQOh7gCf/XPUUQ2twvzy4h2B5TyBwufAboBUZoFY6eUd/2n9SsD
    1WrbQC16I8lXkOUjk+zlw9xAwGqaqJxqNr+VbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489845; bh=1iqwSb
    mheX4R0QsdDp5S5dWPdsQILYsRY39o9U/scuw=; b=jbxCo4uNQcXwBBM8hHU84N
    Q3f+Q9bWq7xXN2O/ZISfuwzXzJRkXb5cgtPpum17Vcqqe32TS6YNn3W0298cYgua
    cpLN+R0wm/7aVqOL6gh3P+bF0pLT+422BVhfV9rxxliKd/IvhLSgJ+4iT2hkOTx2
    mtAMJm4geAslezUSE3JDuNZF/fTNkdhevVhqcA1lvZadIm0JTt6BF7A2FJTgO7Fo
    xjfylJYD/KE/++QTNHmAVwecGHsHTVpwqnZjqftCUS7fySe4ljRqKYpJ11Qz1VuV
    nM9ZLkyVoSCrCVSQN6lmlKbTjVgImpwch7vRDB4Y9Q8AvMMXsRS32SzMg8jE8IWA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=genha7xH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=genha7xH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755331AbeCHFBY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:01:24 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:14896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965328AbeCHFBV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Feras Daoud <ferasda@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 061/190] IB/ipoib: Fix deadlock between
 ipoib_stop and mcast join flow
Thread-Topic: [PATCH AUTOSEL for 4.9 061/190] IB/ipoib: Fix deadlock between
 ipoib_stop and mcast join flow
Thread-Index: AQHTtpo2nxnHASF/o0K+/qm5X0C76Q==
Date: Thu, 8 Mar 2018 04:59:18 +0000
Message-ID: <20180308045810.8041-61-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:DZPOHxNrGcdd6M7s4GuKwtOOXqjlA9pS2aLG5PGaBooo7whHnIc3RGF4dp+WrNddK74KY28OauIZEJREUoRwdhLubtFas1bO5K3MUJrsaM+YkuNVWEIWExWMaknMrIcQ/dHujbIfargtaX7ozB9YYJRMfFYbHQVNKMJ4tzgYfZFx4u8siy3xLni80Q6ZPUPgMaiywCiqWgI8OetxXfoc/Fjg5JFVCrnL4clxnvxj/hpoGcygI26FaXW8ahNuRX/Q;20:cY5dg5z9L8Ho2jkepuRRKoIlNjvT+jn2G+CoDtdOdw5OeGVoLFOGu0ejZXQ+h5p9eeKJ6hOReW6fHq3yHnz8jL6hTtJW/5FSRdFOMsTo2/EhGNjI+QVDYYIMJPn8lizishE6LvuhOFflXv1BPA1taTtG3bQJOtxRe12GrrS5FGU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9c2931c-6015-40ff-c38f-08d584b1a178
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0999750795BB406FAFA54119FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(575784001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 8CvouqyutZJ4Xb55ywEgPnPb0M7FlqTZbCjg4gILeL7uswyj7kJMMcdXUvjuiOZKJbMtR9y6vDwHXI3cnLr6trBb8nRKodO5YtePLN48xvbVD4ulrh1rNjuTFZUXV48d9OqopPDKOm7X0CPB4LPgRxuFVtBGU8JfptdmE31wGVQrvVFK274yiG7FsiDtSmMiXzhUuw/iudsGpVF3/+JSAA5CZprUeOrpRuUQvLUOF80yDkj1iSQBi6pQIZFZzvYE71sGV6frjenz+niCtG7dvbDSfAgNdhnbdHW27qQO42QYHxdm/cBsxT5EUOcphDEzMXGMkxII2eiXqaJ39r8Umg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c2931c-6015-40ff-c38f-08d584b1a178
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:18.7422
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

[ Upstream commit 3e31a490e01a6e67cbe9f6e1df2f3ff0fbf48972 ]

Before calling ipoib_stop, rtnl_lock should be taken, then
the flow clears the IPOIB_FLAG_ADMIN_UP and IPOIB_FLAG_OPER_UP
flags, and waits for mcast completion if IPOIB_MCAST_FLAG_BUSY
is set.

On the other hand, the flow of multicast join task initializes
a mcast completion, sets the IPOIB_MCAST_FLAG_BUSY and calls
ipoib_mcast_join. If IPOIB_FLAG_OPER_UP flag is not set, this
call returns EINVAL without setting the mcast completion and
leads to a deadlock.

    ipoib_stop                          |
        |                               |
    clear_bit(IPOIB_FLAG_ADMIN_UP)      |
        |                               |
    Context Switch                      |
        |                       ipoib_mcast_join_task
        |                               |
        |                       spin_lock_irq(lock)
        |                               |
        |                       init_completion(mcast)
        |                               |
        |                       set_bit(IPOIB_MCAST_FLAG_BUSY)
        |                               |
        |                       Context Switch
        |                               |
    clear_bit(IPOIB_FLAG_OPER_UP)       |
        |                               |
    spin_lock_irqsave(lock)             |
        |                               |
    Context Switch                      |
        |                       ipoib_mcast_join
        |                       return (-EINVAL)
        |                               |
        |                       spin_unlock_irq(lock)
        |                               |
        |                       Context Switch
        |                               |
    ipoib_mcast_dev_flush               |
    wait_for_completion(mcast)          |

ipoib_stop will wait for mcast completion for ever, and will
not release the rtnl_lock. As a result panic occurs with the
following trace:

    [13441.639268] Call Trace:
    [13441.640150]  [<ffffffff8168b579>] schedule+0x29/0x70
    [13441.641038]  [<ffffffff81688fc9>] schedule_timeout+0x239/0x2d0
    [13441.641914]  [<ffffffff810bc017>] ? complete+0x47/0x50
    [13441.642765]  [<ffffffff810a690d>] ? flush_workqueue_prep_pwqs+0x16d/=
0x200
    [13441.643580]  [<ffffffff8168b956>] wait_for_completion+0x116/0x170
    [13441.644434]  [<ffffffff810c4ec0>] ? wake_up_state+0x20/0x20
    [13441.645293]  [<ffffffffa05af170>] ipoib_mcast_dev_flush+0x150/0x190 =
[ib_ipoib]
    [13441.646159]  [<ffffffffa05ac967>] ipoib_ib_dev_down+0x37/0x60 [ib_ip=
oib]
    [13441.647013]  [<ffffffffa05a4805>] ipoib_stop+0x75/0x150 [ib_ipoib]

Fixes: 08bc327629cb ("IB/ipoib: fix for rare multicast join race condition"=
)
Signed-off-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infin=
iband/ulp/ipoib/ipoib_multicast.c
index fddff403d5d2..8f36fda48b87 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -487,6 +487,9 @@ static int ipoib_mcast_join(struct net_device *dev, str=
uct ipoib_mcast *mcast)
 	    !test_bit(IPOIB_FLAG_OPER_UP, &priv->flags))
 		return -EINVAL;
=20
+	init_completion(&mcast->done);
+	set_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
+
 	ipoib_dbg_mcast(priv, "joining MGID %pI6\n", mcast->mcmember.mgid.raw);
=20
 	rec.mgid     =3D mcast->mcmember.mgid;
@@ -645,8 +648,6 @@ void ipoib_mcast_join_task(struct work_struct *work)
 			if (mcast->backoff =3D=3D 1 ||
 			    time_after_eq(jiffies, mcast->delay_until)) {
 				/* Found the next unjoined group */
-				init_completion(&mcast->done);
-				set_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
 				if (ipoib_mcast_join(dev, mcast)) {
 					spin_unlock_irq(&priv->lock);
 					return;
@@ -666,11 +667,9 @@ void ipoib_mcast_join_task(struct work_struct *work)
 		queue_delayed_work(priv->wq, &priv->mcast_task,
 				   delay_until - jiffies);
 	}
-	if (mcast) {
-		init_completion(&mcast->done);
-		set_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
+	if (mcast)
 		ipoib_mcast_join(dev, mcast);
-	}
+
 	spin_unlock_irq(&priv->lock);
 }
=20
--=20
2.14.1
