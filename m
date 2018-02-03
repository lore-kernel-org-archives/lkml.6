Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683537-2-15016277527759765181
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683537; b=GNbS++NFWuSRxXeZh9ZB8dARTrYiRKtj+t95i/DDEoUinNr
    RquD2Rdxgsl31qsfIWntUzC9ZKvYcfAZ944gzaf44CtDON30YipDWwtRvaEKHcfr
    IJmne2NK7b/naGm0N+cFjVA7oCqzjEp1myY1dMlYyxafxcBToym59nz8WvBnr2IS
    0v8dlVPtrErU7oHhYnmQ+njJksUvSuPaaRXJ3zK5Vojk+H6APEMuZ2FK3r51JQgG
    Kd31K4GIOjbPzOv8nFS8uP5ID2XwsGWSGK6JoV7VDApoKSK4GCAfVPw89ecU/VrR
    LKZEWaY9iGGrXwMXzSZsZE/C1uHWXr4GFeqHHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683537; bh=CY3M4P
    5pq51n1e+kfF0hFpo1e2SL25aehtTcUe9GYmk=; b=ptmnMqKrP9e+3HRDykj/x7
    NLQzdZKtT0Ha3HJFAfB3F1TLBwVsgKAz6Sn4Mzx2nDeiu/yafLYeqm0bP5sSTjPk
    lUIXzf7XPg7CDcvcjpGkfw8BvdqD8I4umyyfjktrMlG9khfzNHZ+5DognbChhf7q
    61I7SR9Ah3E5PXhxMuXCPkDBz8lJ5vq7uhWHIkFBvtY7EIh25VHp8QJi4fZrGL98
    3rj0MiPgcm0grFIs2lDW0fGJOGdxbjuqQd4may4nbgX8iiW6zyINS5JqXjDi/k6J
    e9FiB4xVMb3qoU/VnEbQyAP5HK1veHPL2QUPWINj+o6OyCTtl46OgC7giZ3+a8iw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EOcEzQji x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EOcEzQji x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755174AbeBCSpU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:45:20 -0500
Received: from mail-bl2nam02on0127.outbound.protection.outlook.com ([104.47.38.127]:37417
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753155AbeBCSCx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 081/110] RDMA/netlink: Fix locking around
 __ib_get_device_by_index
Thread-Topic: [PATCH AUTOSEL for 4.14 081/110] RDMA/netlink: Fix locking
 around __ib_get_device_by_index
Thread-Index: AQHTnRj/30vh9vLqMkqOZXWWcfqCtg==
Date: Sat, 3 Feb 2018 18:01:20 +0000
Message-ID: <20180203180015.29073-81-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:xVPA14qtMtT0jXxBdBdy2fyManOLZDTYhdkVYpecbqpPPKNPbjD+hiwcA+f+1L0kqPZcNWAILkF56QdWypXRWpE58nay8UFaJKxZHz+HKu/9clGTNH/Ho1xIGOgUc/a2zE6gV4IvMYGdhiqaEKtaTIAaXbXTqtCoGPrbdX8RT/jhKtiWH54tU+H5cq1DNj21dn3KqauOsDcHAJBxnzyus9RPVeTGJucDnAKw5Bu56891WUaZc4PHnvlaE4lE5If7
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0afdb45-eea4-4ea6-ccd2-08d56b304014
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB1041B7FF99FD1E26A3EA9F90FBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(575784001)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: k5ic3DXvhH5g1vkEEp+YWKLseqbIQ571n3+bRPlieXCGX8tPmgqOmqBJOrs3zg/b/DIv5dFo0rRJ9Fx0AI4NMQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0afdb45-eea4-4ea6-ccd2-08d56b304014
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:20.9722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit f8978bd95cf92f869f3d9b34c1b699f49253b8c6 ]

Holding locks is mandatory when calling __ib_device_get_by_index,
otherwise there are races during the list iteration with device removal.

Since the locks are static to device.c, __ib_device_get_by_index can
never be called correctly by any user out side the file.

Make the function static and provide a safe function that gets the
correct locks and returns a kref'd pointer. Fix all callers.

Fixes: e5c9469efcb1 ("RDMA/netlink: Add nldev device doit implementation")
Fixes: c3f66f7b0052 ("RDMA/netlink: Implement nldev port doit callback")
Fixes: 7d02f605f0dc ("RDMA/netlink: Add nldev port dumpit implementation")
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/core_priv.h |  2 +-
 drivers/infiniband/core/device.c    | 18 ++++++++++++-
 drivers/infiniband/core/nldev.c     | 54 ++++++++++++++++++++++++---------=
----
 3 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/=
core_priv.h
index a1d687a664f8..66f0268f37a6 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -314,7 +314,7 @@ static inline int ib_mad_enforce_security(struct ib_mad=
_agent_private *map,
 }
 #endif
=20
-struct ib_device *__ib_device_get_by_index(u32 ifindex);
+struct ib_device *ib_device_get_by_index(u32 ifindex);
 /* RDMA device netlink */
 void nldev_init(void);
 void nldev_exit(void);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index 84fc32a2c8b3..f65f64cb8455 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -134,7 +134,7 @@ static int ib_device_check_mandatory(struct ib_device *=
device)
 	return 0;
 }
=20
-struct ib_device *__ib_device_get_by_index(u32 index)
+static struct ib_device *__ib_device_get_by_index(u32 index)
 {
 	struct ib_device *device;
=20
@@ -145,6 +145,22 @@ struct ib_device *__ib_device_get_by_index(u32 index)
 	return NULL;
 }
=20
+/*
+ * Caller is responsible to return refrerence count by calling put_device(=
)
+ */
+struct ib_device *ib_device_get_by_index(u32 index)
+{
+	struct ib_device *device;
+
+	down_read(&lists_rwsem);
+	device =3D __ib_device_get_by_index(index);
+	if (device)
+		get_device(&device->dev);
+
+	up_read(&lists_rwsem);
+	return device;
+}
+
 static struct ib_device *__ib_device_get_by_name(const char *name)
 {
 	struct ib_device *device;
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nlde=
v.c
index 2fae850a3eff..4fbb9681f5cf 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -142,27 +142,34 @@ static int nldev_get_doit(struct sk_buff *skb, struct=
 nlmsghdr *nlh,
=20
 	index =3D nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
=20
-	device =3D __ib_device_get_by_index(index);
+	device =3D ib_device_get_by_index(index);
 	if (!device)
 		return -EINVAL;
=20
 	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
+	if (!msg) {
+		err =3D -ENOMEM;
+		goto err;
+	}
=20
 	nlh =3D nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET),
 			0, 0);
=20
 	err =3D fill_dev_info(msg, device);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
+	if (err)
+		goto err_free;
=20
 	nlmsg_end(msg, nlh);
=20
+	put_device(&device->dev);
 	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+
+err_free:
+	nlmsg_free(msg);
+err:
+	put_device(&device->dev);
+	return err;
 }
=20
 static int _nldev_get_dumpit(struct ib_device *device,
@@ -220,31 +227,40 @@ static int nldev_port_get_doit(struct sk_buff *skb, s=
truct nlmsghdr *nlh,
 		return -EINVAL;
=20
 	index =3D nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
-	device =3D __ib_device_get_by_index(index);
+	device =3D ib_device_get_by_index(index);
 	if (!device)
 		return -EINVAL;
=20
 	port =3D nla_get_u32(tb[RDMA_NLDEV_ATTR_PORT_INDEX]);
-	if (!rdma_is_port_valid(device, port))
-		return -EINVAL;
+	if (!rdma_is_port_valid(device, port)) {
+		err =3D -EINVAL;
+		goto err;
+	}
=20
 	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
+	if (!msg) {
+		err =3D -ENOMEM;
+		goto err;
+	}
=20
 	nlh =3D nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET),
 			0, 0);
=20
 	err =3D fill_port_info(msg, device, port);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
+	if (err)
+		goto err_free;
=20
 	nlmsg_end(msg, nlh);
+	put_device(&device->dev);
=20
 	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+
+err_free:
+	nlmsg_free(msg);
+err:
+	put_device(&device->dev);
+	return err;
 }
=20
 static int nldev_port_get_dumpit(struct sk_buff *skb,
@@ -265,7 +281,7 @@ static int nldev_port_get_dumpit(struct sk_buff *skb,
 		return -EINVAL;
=20
 	ifindex =3D nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
-	device =3D __ib_device_get_by_index(ifindex);
+	device =3D ib_device_get_by_index(ifindex);
 	if (!device)
 		return -EINVAL;
=20
@@ -299,7 +315,9 @@ static int nldev_port_get_dumpit(struct sk_buff *skb,
 		nlmsg_end(skb, nlh);
 	}
=20
-out:	cb->args[0] =3D idx;
+out:
+	put_device(&device->dev);
+	cb->args[0] =3D idx;
 	return skb->len;
 }
=20
--=20
2.11.0
