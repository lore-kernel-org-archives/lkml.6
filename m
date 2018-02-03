Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681254-2-7237758136544381458
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
    t=1517681254; b=eAx42H3jGAWIRJDvPvyJrrGdrdIWd6vPwBZO4LgjnmodfQ6
    T1S9pm9ClxDXZVoNaJ5noM0YLkzruT3KQTPSV3G/GVYzAy236J/oguJe8p95S3Sf
    xerLeoE15Znj2gkUifCJWBQfojLEjBIhL+Yl0FLmMSAjX0/w3nQNWA3vC0Ii0Md5
    ADDPUJWtuGBEceEpwBseiBaZxaLa51yeucABxEpVZOssFiaZTygObsBoZixXn87w
    qIq1ylC1mNpO1FPq42e1wzKnRKHAi9WVvWnXybHzWR1csEUXiq0c3x7YkZ8fQhIu
    SnwRUn7mxkKSsfTbT5u9kISjWky7+kz/BJDVSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681254; bh=oHyt1W
    Ud49mAMytDzvqNqu5ZbMUzdJc6evDbnL0rBDs=; b=S1svAI4aktgmuC9qyDgVhO
    S/0GJVpV2bTt2IkEcxg/AuDNI/XzvNgJzTXBxR92ky/VnFGbv9VtbxZ7cCAjmSJs
    N81LQHT3zp7Si9l1HHOdAhZVQb/NbBhNFL9oLSHbjvNvhYzas7h9QkEaj/3B2IjE
    rUGyiBl0pOJ0PzriUt6oZr7F9pAUSOsQYtEsp3/BQygUHbVEI97Gp53B95w6nltB
    mvQZ9u6NfIH88csDnCKx9TxqxkyvrXFYkb6Zv/qgEegrOELJHf547kgeaHtFqxX1
    gsAFPi6WkeMz4+7mrxrrgtEKlq+DmlIiPKDEk2e7O892jdk5Hzuv2EAqy87+BcMQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZIjZmakS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZIjZmakS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753583AbeBCSH3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:07:29 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:45129
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753366AbeBCSFR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Gao Feng <gfree.wind@vip.163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 077/110] macvlan: Fix one possible double
 free
Thread-Topic: [PATCH AUTOSEL for 4.14 077/110] macvlan: Fix one possible
 double free
Thread-Index: AQHTnRj9cQCtIt56b0G1P+0Fbo2gTQ==
Date: Sat, 3 Feb 2018 18:01:18 +0000
Message-ID: <20180203180015.29073-77-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;6:1JSIJQzt3HdE/DoleuE0kJioePy5DoEcN5xitvXVfw6YESC8ctuhDBVaSJB/oElC5mTf8kEQt+0z/Z+BlARBiHlFQAQET/u6AtAhgvEbSG8q1XdnCKru9zXPGn3C0Uqu63t67Wm0WOnI7oC0KaJ+m+vC7SoF8V2Ivfar63o12bi3yl0wqQmmpEzuBedlT8xTNlYbCWf6ORBlnTSN4XxqduVQeUHHtdyrTXniLrelgvqB2L2KTXSHbHmDLqZ1R31CQEsW7kXJ0U8N8gaC4prD42cLmZJWyXD5BygKuWf0B9Vra1qS9iEfUFct/s8AE2KOhjBdHYnQMDm7RXao+iAxpjti2dO/SSF8Gp+43+gndZxQXzH3Kkk238EQmcgvDoHN;5:Jv8JfRdQ6wUV19fc4JEi2wex3v95MhWwbsmZiiYhT2qfaIlKf3ykhLhUPY4Se0FZdltZLwSqoh7P2nepE+vi+b/hzKEAY7XnUQ7NOomzWvxQ0G/NYQ0CPcoPj5xam9bzkZjQhrpTh1r+iEPJXVVjnlPewFstl3TKER9NqmOg7U0=;24:fxoZAFtPNJSwzPIf8VTwkw7uPW7JRC4dtNaPj9+yGT+IRdMYV0MuGjso3oGv91QEk9WPpK3G4jEAosCtfDBTKQYgqW5j9WqNQLUizygPdTk=;7:7jHwcrxICt5VWoadmlO36wb+MFX4Iawtzcpo3p1/pkp647Fnf3imRJk8qKLfO9lVCYf9ObA0dyIoRk4b/2gS6fW/pBtvisaq23zmWm/AW3S8Pj6AwOFEy6pSVCJAnYURHUuJYFrReLjup86edrpfwlW85SMmE5a9tSC2rUZbEKtWtuR3W8N9b76T5FsRcx2zwYX+P1brPw52y5sI+H9wvfByZLqu4WzbcevkJGA0iRoTY5BvoFBsxRXaHnuJHCAu
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7420488-a81e-4d52-8a89-08d56b303f0e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB1105075523E74105E53D5B83FBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(58107921199556)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(59450400001)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(8676002)(110136005)(575784001)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: /wHXt3dwhwlGws7oMCxUXDVQweBrcZGyPug7YH7XiKBlRzbAazPWy9CD3IiO6eA5uuI5R0fDEORO65QNFRkYjA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7420488-a81e-4d52-8a89-08d56b303f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:18.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
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
index fb1c9e095d0c..176fc0906bfe 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1441,9 +1441,14 @@ int macvlan_common_newlink(struct net *src_net, stru=
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
