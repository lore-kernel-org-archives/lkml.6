Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681304-2-4046458343964580029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681303; b=lkGhi/aZ7MpwHZXFP08vpm7+nzgOdKS20DPfBdUQ569P+rJ
    Qlu9lzenHzaiqcdVFkIcQu6SNhDYKbv8sgXSfJtPrmy+ZgREeC5VSnIJscuHdYIU
    XeyZdnlYAjye5zVPRcWw64D1Pdg51konHZucnmZ8PqS012Sn43QLF/4fbOQTx1Jz
    WGh6Pqw0h/XqtRJVqbtN6A9ktJVD5spMZBBu5hhwMxnMvz8Wv4I8whTanO2ELB8o
    8quAnbd7UAaEsytguU6JHWYHBDCJNN+UvxNC4XmQltxeUvxX7iEplGaKLvsoAmGO
    hqpGzfhM+It6QR8rLLBYCxpa5sSs49FyMsywmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681303; bh=ahROsT
    KmyLXs6i4Irk06m7t/5zS8DQGONiiSddsxnJ4=; b=UKHz3oQMBDmrTXG2s/H1rQ
    cEYWEAT9cVDG9QKdrCoDNOzjqNjpCbu5kBejd7w1waf7pJxfrrZv0jQX3y5i2GyK
    6D9Iwc5TNgG0puv1mNIne7uWIc7+2r5cotIR8PIQpaReiTtWWYHtARXXpr0irpXZ
    Teqi5n50Ik0QvL0UhSVe3snrmGwWPhzXKw8R5hZn4wDVAPRoy3pjMlNcAlX+Nrdb
    mVb9TPj4vCZlVSA4KRWV45AUKLCwTq2GfAQhZLM+YL/1vI4dmDKu4kLo7NEgS2Uz
    o3axev4pALGa3stNLSuWEy/Ji1/7R6Z/kNTrl4v8I+yhvlsfuWdlRaphhECpZhww
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AlaGNqEa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AlaGNqEa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753129AbeBCSIR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:08:17 -0500
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:50832
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753261AbeBCSF7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Gao Feng <gfree.wind@vip.163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 36/52] macvlan: Fix one possible double free
Thread-Topic: [PATCH AUTOSEL for 4.9 36/52] macvlan: Fix one possible double
 free
Thread-Index: AQHTnRlaZIAdYXgOcEuACKVDxL0/NQ==
Date: Sat, 3 Feb 2018 18:03:53 +0000
Message-ID: <20180203180303.8490-36-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:2AtxLKQkyehEzKaOewT3FdsHSpAtt5N323sx6by39KvCmVi7W1yKIvCgydJdX13tpDsYkxgpbm9d/RqjK5UpahE0VS+eaBaLTdWLHO8GsLPRE18XZLYAVvaSbrhZRAf75f6T0/ovUjFCRzPXFKGt1FGvFTvL72eENSK0VBi2eh92dmGTZP1aH1JgBzRUXt3gaBeFPNHo4fff7tVR02bRZr1Qi4AgJ0eDXi6yHMvMoPeB81RYNLvFECTbJcM6ewYM
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9515818f-df31-410e-94db-08d56b309bce
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB1012EC36E48F86C64001ED86FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(58107921199556)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(6666003)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(478600001)(68736007)(14454004)(5660300001)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: ajnGVQXXHRuvCTSj5N57F3kQknCM8McSbyKaJ4PIECbJCZV9TrsyXHsNCNI+k3aiuakAs2e8I7cv9v5YR1RClA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9515818f-df31-410e-94db-08d56b309bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:53.5808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gao Feng <gfree.wind@vip.163.com>

[ Upstream commit d02fd6e7d2933ede6478a15f9e4ce8a93845824e ]

Because the macvlan_uninit would free the macvlan port, so there is one
double free case in macvlan_common_newlink. When the macvlan port is just
created, then register_netdevice or netdev_upper_dev_link failed and they
would invoke macvlan_uninit. Then it would reach the macvlan_port_destroy
which triggers the double free.

Signed-off-by: Gao Feng <gfree.wind@vip.163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/macvlan.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 6d55049cd3dc..e8ad4d060da7 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1377,9 +1377,14 @@ int macvlan_common_newlink(struct net *src_net, stru=
ct net_device *dev,
 	return 0;
=20
 unregister_netdev:
+	/* macvlan_uninit would free the macvlan port */
 	unregister_netdevice(dev);
+	return err;
 destroy_macvlan_port:
-	if (create)
+	/* the macvlan port may be freed by macvlan_uninit when fail to register.
+	 * so we destroy the macvlan port only when it's valid.
+	 */
+	if (create && macvlan_port_get_rtnl(dev))
 		macvlan_port_destroy(port->dev);
 	return err;
 }
--=20
2.11.0
