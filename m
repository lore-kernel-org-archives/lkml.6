Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517681914-2-14956173732110266596
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
    t=1517681912; b=wD8GsEG2/wOLKcguC4HPJ1s92leBJ1In6H7+I8IygN9MtkF
    T55xrf1rEGhlaRPmTefReNEe4FFp/n7e58CDbVifv2tqcPoBsplwVIM2vBWYktAT
    S2hYUHLE1XbuNTsCICKMJfPK8UMNzmzGe8VdFM2mSt0PiItIXNvwnveVaFLK3MdE
    +YZWUy2Sug0lDiVKw7Fy8bT11yCoKuMF6VF1P8tUXjwHYfukL45liTPO0MPKs630
    mgPQhy5Z9HXui3u4F+qWPcu4QNOteaay+dYF7sJyXRUDF0vFUbwYdnocQKOMigzl
    /KrKc8ve4YbGoYC0zbenqyGHHqAKlduiAB5esKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681912; bh=S0eT6+
    cadn8qmTtXL1GcPAb4T8JCbhfyTXBF4QEtbhY=; b=MnD02R1rBNG9MNUWu3Full
    VOnBlACvAE4cE0wI8WZev8/pKs7wT1PcUtH29ii7mFy8+8v+c81mElm4xpb2W4PP
    M5ul6oIwXrWr1iCXhq+Pfzenq6oLbOxk+lhVrJ9lm4VMUmCcA3aQjW7dGPz3bUeE
    fgUaf4Drt9YkEEOLdIVvpG3R3287TcbZc4pSQTF0+J6dlTuHoNj1PWtkI3tRnlqm
    ygubivHQTnF2QrYmgq5mmW6TJFfOfSnz+ZG3dqN/hMJ/MVWNeskby3ntbkil3TxD
    3r8ii2I4GVLHeO2m6gYzxcFRNw6D7c8mWec587njJafNdxveJ3SOwy4w/u5gz+JQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E93aBVTE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E93aBVTE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeBCSSV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:18:21 -0500
Received: from mail-co1nam03on0107.outbound.protection.outlook.com ([104.47.40.107]:45036
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753495AbeBCSGu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Eduardo Otubo <otubo@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 26/32] xen-netfront: enable device after
 manual module load
Thread-Topic: [PATCH AUTOSEL for 4.4 26/32] xen-netfront: enable device after
 manual module load
Thread-Index: AQHTnRl0W28kLq5Y70WvMmSQlVOujA==
Date: Sat, 3 Feb 2018 18:04:38 +0000
Message-ID: <20180203180413.7438-26-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:0Wp+nJHxEp6b/fD33oS7B8Bgalwr59gZViCa6EmNJHtoIh6zMbitqyawu5NWm/mJ+Oenkd4QQxOBH6NkmrLAzJfVFEM1fVyaurw01g1xH6AVt0Uu1ta4sra/d/v6MoVUPydyN4uurPJWad8qktQ+4wkBgLdL7CwZ0zR5j0uieHQ6KTxwDZOv8fim48HDePsqafB8i05NDIGw20+rKOfcO7CySTd8yF5LcJ++n05VgJITKuKQDuokWMlYFbhvpBby
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01b4a420-e2bc-434e-cbc3-08d56b30c7bc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB10095432F3C89D83D555D7CBFBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(575784001)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: Qu91JcZl7B1qMaeyL2YqXhQVgKsLvmmnm7zRS3EU6wYCu1EoMQAMXcZY2HtHfg7B5Z/9bgOKe5qfP0FtbIzvCg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b4a420-e2bc-434e-cbc3-08d56b30c7bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:38.3777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eduardo Otubo <otubo@redhat.com>

[ Upstream commit b707fda2df4070785d0fa8a278aa13944c5f51f8 ]

When loading the module after unloading it, the network interface would
not be enabled and thus wouldn't have a backend counterpart and unable
to be used by the guest.

The guest would face errors like:

  [root@guest ~]# ethtool -i eth0
  Cannot get driver information: No such device

  [root@guest ~]# ifconfig eth0
  eth0: error fetching interface information: Device not found

This patch initializes the state of the netfront device whenever it is
loaded manually, this state would communicate the netback to create its
device and establish the connection between them.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/xen-netfront.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index eb7a9e62371c..0b8d2655985f 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1331,6 +1331,7 @@ static struct net_device *xennet_create_dev(struct xe=
nbus_device *dev)
=20
 	netif_carrier_off(netdev);
=20
+	xenbus_switch_state(dev, XenbusStateInitialising);
 	return netdev;
=20
  exit:
--=20
2.11.0
