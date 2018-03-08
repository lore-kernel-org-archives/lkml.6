Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487513-2-7743260034459825652
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
    t=1520487512; b=CdrwhWKKakb4S+t22DItB+7L6BIAzG/xoKwqEmAiBJGs0Wt
    ZBmqnK6HPyhYHb7blfwU5gSO6d7JX7rAI104W03oooEAf9zf9p2rH6vP4Ifzm6vW
    gpIMgTpGr6ZyfgyUoSviV8IuUZhCw7dUwvOUjYoWi1cG6/mBmk1HyuUAdPcY+hZ/
    mfKGZyP947XBQoIGkyqfig6tiL0bIRdAa9KaKHnSYAXMFdMt6NgZ9zJ5n+hmsPd0
    +XuJUPFHgYzu6Gea74sfLo6EA1YnQJWW6jDLq3S2qmWaxsN25iB95HC4O6V9YKmo
    Knlud69GU400oztlp2uivbbMOoXLNUDv75eBb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487512; bh=XE9OS7
    wW48/7rQvrhHNruG4ZirUKMNL/V7oHUu7mWbA=; b=PZ6F/2wMiAoLL5of9KTJN0
    AFtj7ZlS4YlCiy3dyS97izBBCp7PIim+r/I9chuh5BpdRoqhfDHoURno/9zO6Xcj
    baeAob4d2paGsuSR/Ts/ZVywfzL45K8smMroFcPMit1KXf9INZ7YxQPKBAWCl9Xu
    eJ8D3kKEMG+pmfnUokMYf0NyZ1A7oErNiqkn07FYKA2fFa/M2dNVBo/q4hr2xxdb
    QiyrqQg+o3Ww7G7Z2DpFrq+cMx/bAh3MVzhwSqmvpaEsHBpoOMPbhAkRJ2r+5iz5
    bhinXnGbmjFuflxCwd+9v2AWMOvYiTlQwcnek9DBZp+eQwNju17Y3YcCsAwfGWZg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PzVOmDcH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PzVOmDcH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966315AbeCHFh7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:37:59 -0500
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:7384
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965736AbeCHFFy (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Feras Daoud <ferasda@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 036/101] IB/ipoib: Fix deadlock between
 ipoib_stop and mcast join flow
Thread-Topic: [PATCH AUTOSEL for 4.4 036/101] IB/ipoib: Fix deadlock between
 ipoib_stop and mcast join flow
Thread-Index: AQHTtpqKl2h+uYdt9EO0L3EhAmx5Yw==
Date: Thu, 8 Mar 2018 05:01:39 +0000
Message-ID: <20180308050023.8548-36-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:RZ5LkunKGndODpZ/V2DpxqGo0tRmdNG73QGn3VmIV20yhvdYj8sIsKTUR1Ex1GzNyrekiGLeZS3MdrskDlPRR9GNlaCIAHUMl5dLgwCzD2zQVZPEO9Cu8BJppHdavfgDYeZBdh/vpgBiXjtCEm9QziRcDks+TtSjtlkIOIKWbi1kTQuMhQwBygGiEzJ0WnufYmhxN+KRaKx3YvUzfjv0nq2Ruh/B6S0FAWlEe2iERc8NsrDGDctiIQDmzNSBDbmT;20:ZPoKoCdJhEarFI3uZ7WOy9Dl4y3HDpRkw6F6ShmReqqZFBbyFhLrdAHsuylOd3KauaWmwGE1q2/uDqGhk7R1cbYBNw7W+InpY4woACt0CCLv1NKceOs+TZ7gmCS4vxIyXShJ8Sp8rihEF+4E90lj6SK69CrRaiCN7VDdMM4sRI8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 677c3592-8e4a-42dd-17ed-08d584b242a1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046FBFFBBEE9007664BEB7FFBDF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(53936002)(3660700001)(5660300001)(6436002)(6512007)(36756003)(3846002)(478600001)(105586002)(305945005)(6116002)(1076002)(2900100001)(72206003)(3280700002)(68736007)(7736002)(97736004)(22452003)(14454004)(6666003)(2501003)(106356001)(10090500001)(10290500003)(2950100002)(81156014)(25786009)(54906003)(107886003)(59450400001)(76176011)(6506007)(2906002)(110136005)(99286004)(26005)(186003)(86362001)(102836004)(81166006)(5250100002)(4326008)(575784001)(8676002)(86612001)(316002)(8936002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: DIVbOz5WVyVj15UuQzsIKvivApFKS8MWysFGB+C2IEBF9yHz0kUB2qimqT8wq8ea7iVwC2oBLCaU8E0BQecITx6wFHdxZLhlp5Kk4jE5bbw0Frjum7YWuqDGEeSKQ3j1aniYavkLI2QsurwsjvJ4QUOIh3D4+KAK+rgXie2ntUQGYPDjjfo+5OTaDZGS9NkkcQgOT+SFvKJo1PYsHGjsjXTv78KuunpYnMQMYBwS8XNHadH3Oj0tiQjowEvuQor+u1Ot0eHUuegi4JrnWlIO5KWGnO83faLcoiJ9YX3V3rSEJZgEDiMuffXWqJ5DjNA+XeQ623wqBPi0bohuqe1oFg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677c3592-8e4a-42dd-17ed-08d584b242a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:39.6098
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
index 5580ab0b5781..682a69daac5d 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -473,6 +473,9 @@ static int ipoib_mcast_join(struct net_device *dev, str=
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
@@ -631,8 +634,6 @@ void ipoib_mcast_join_task(struct work_struct *work)
 			if (mcast->backoff =3D=3D 1 ||
 			    time_after_eq(jiffies, mcast->delay_until)) {
 				/* Found the next unjoined group */
-				init_completion(&mcast->done);
-				set_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
 				if (ipoib_mcast_join(dev, mcast)) {
 					spin_unlock_irq(&priv->lock);
 					return;
@@ -652,11 +653,9 @@ void ipoib_mcast_join_task(struct work_struct *work)
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
