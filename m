Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489311-2-3446697687386671451
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
    t=1520489311; b=ZgO8Vo2vPrzH7gJAnHWyQdKfjjra5PH8nYmpGL6yf5Nh0fX
    EE0urKSNF1yEDT9fdTbXJpflWPwN9J1hIDOclU1aDWQQg5cwJC62e+MdZ/62O08P
    Nk288qBvcMpM9u/0ULO7KRpBnPttEXUOvzbNgnhiaLVkdXB3OM3zOwyaPu/T5edE
    67Zs2Av5FkfmTBeX63qVsLW3TrUX2o66EvFwpiO6dG9c3WjDKhVjgAYCV4jlBWrI
    GAnilhgA0z2kHxjKFPNA148ldN5l0mPPgl8+jb4xvhqBtxuhGpfIH/+fsOXhJsXB
    6omjmO+YfyvuFbi7biDg+xjecL/uE2bBk5w8Pvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489311; bh=eSeLRG
    TDUbjo8xZ+yzf/dFkhf+Tac9RUkO+r5uaev8A=; b=N9GXH57MqvkEREb4wu30/D
    XJh7KzC4KjElpEpaSn8hFL9ELBjt8u+Y9dPqV5Yqho3zb0qwshGd54sMwpCu2DfC
    xlrdYyljQdOUjHotwLGFdXCLgA0NYs20tMBv2nozGVIBkC6zdZekjxpUP9mW0Mkh
    04gXLxvGxqPZFpmqXdkTKBcpCbe8RLJfu3a1XU1iAB9Mn1WY8AYeA1KYPUtwFkR7
    8CdIMddSLy35PBTWt8keAT2PJXrAXJ2p6/dY3nJgQIJqeTZOOmU+aqyE3CvHHwXb
    h6MWPMUYs/tQOdBw9Za2krXu8xqaQKJH5O3/miKUVPmQWBHj4kxKslaJUKyUdOOA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gCpdbht0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gCpdbht0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965849AbeCHGI2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:08:28 -0500
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755364AbeCHFCN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Martin Brandenburg <martin@omnibond.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 096/190] orangefs: do not wait for timeout if
 umounting
Thread-Topic: [PATCH AUTOSEL for 4.9 096/190] orangefs: do not wait for
 timeout if umounting
Thread-Index: AQHTtpo/pmJ9ag9ptkm+dD4uRrGtbA==
Date: Thu, 8 Mar 2018 04:59:33 +0000
Message-ID: <20180308045810.8041-96-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:euBc9Zrue+aHfL1YDy3IsBktv0jwLtxjepIMykiHH//zBwJZlw/NH2OnYuFw0XUGvjwwWeERIkb4EnkikUhWkWgHZvOGH7Evj70HReud6ewXKM/59HBLHxUa7atU+WlLJFPJ4JIDvlKkGwWHt+7Tw0UX9wjxxRmU8/+d/DNyZ0oR/f2Nu+kOqit3mwJSDHNtuplljEX+iFhMWFx9ZfbL8Eqx3tunfri6HYoCPUhqPzJLGT782Ip3+yZoSmjsqCfN;20:BDRgIW8y8Cz/QSycgKHpVOPuOeGdveQpZaU/1HpwCU3iz5nv98Qw89opvsW/Rtpd3+VwsXZZLn8xzQhIGAMvefcJW85Q/sEM/py3oxhMoGdQa+PC4FxXuykceKzGmQFQfrdkpaFqWU4I8x1GEN3oEFwYnsJjPJ28jeGXCUXiqs4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04e52340-43dd-4a53-a180-08d584b1bec7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063300BD276C410E0630D83FBDF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(36756003)(186003)(2900100001)(6512007)(3280700002)(6436002)(110136005)(102836004)(5250100002)(99286004)(54906003)(2501003)(25786009)(26005)(4326008)(2906002)(10290500003)(86362001)(76176011)(6116002)(3846002)(6486002)(68736007)(106356001)(1076002)(22452003)(2950100002)(72206003)(6666003)(14454004)(478600001)(3660700001)(107886003)(59450400001)(81166006)(105586002)(316002)(66066001)(10090500001)(305945005)(6506007)(8936002)(7736002)(53936002)(81156014)(8676002)(97736004)(86612001)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: xcDpE9uw6iTkqS9JQe4vdRDFhlfei0pkv1UdKwZeUk4Xrmwjc2xIWW1NzNUa7O4b5mnOvaUBIMPce7AjpD4WG4OIci8RGJEmc8nwGCOHa7HU9ZwFYeU3XcD4w+Y9ReDHmRSycjeJHH2OPuETT1O24rAEUaXtfV2j2Ojii6uK5PVq4DvRfl9QTTZSeNX9osIGBm7pyWbtKO1L0oEFw7P9bFdzaH8/Kr8qiryNsQmrqcnuh+H8tO/+QgqWpSQmecGWBJYhnZ8DMM9h0Ss/tUxxxHlAhcH0FApKofZjt36FMa58X2n/GBW5rEfq5L+nUHm7ThhTqlTR7apyvu6CEkEiSg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e52340-43dd-4a53-a180-08d584b1bec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:33.7448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Martin Brandenburg <martin@omnibond.com>

[ Upstream commit b5a9d61eebdd0016ccb383b25a5c3d04977a6549 ]

When the computer is turned off, all the processes are killed and then
all the filesystems are umounted.  OrangeFS should not wait for the
userspace daemon to come back in that case.

This only works for plain umount(2).  To actually take advantage of this
interactively, `umount -f' is needed; otherwise umount will issue a
statfs first, which will wait for the userspace daemon to come back.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/orangefs/waitqueue.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/waitqueue.c b/fs/orangefs/waitqueue.c
index f61b00887481..cbca58ba008a 100644
--- a/fs/orangefs/waitqueue.c
+++ b/fs/orangefs/waitqueue.c
@@ -124,7 +124,14 @@ int service_operation(struct orangefs_kernel_op_s *op,
 		gossip_debug(GOSSIP_WAIT_DEBUG,
 			     "%s:client core is NOT in service.\n",
 			     __func__);
-		timeout =3D op_timeout_secs * HZ;
+		/*
+		 * Don't wait for the userspace component to return if
+		 * the filesystem is being umounted anyway.
+		 */
+		if (op->upcall.type =3D=3D ORANGEFS_VFS_OP_FS_UMOUNT)
+			timeout =3D 0;
+		else
+			timeout =3D op_timeout_secs * HZ;
 	}
 	spin_unlock(&orangefs_request_list_lock);
=20
--=20
2.14.1
