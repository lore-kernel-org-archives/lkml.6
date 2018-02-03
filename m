Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682508-2-6313191401227176206
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
    t=1517682508; b=dV3P0u5b8axlWSHfdika4hzIREPjOwcQdjJdo/4OrGYSu6f
    AYBKPJT48qVtHcw3CM5pkpRdfjBSohuo3yw7nB1M53U1WY8OZ4YxJVs9Gi2GPvmI
    qr1vzufZK4h7/gY2ZhAxyCVnALk0dSJV508luj1MhSfbNgtq4vwrVi+HiHgZA42s
    G3KBjA5/TtZqij+D/2e2jI2FpMVwqMRI2m2vWAVu/bRCTVJCssIKZ5QiTXi4HR2f
    VJM6MnrkiYVTsrpylse4aG/Nt3DEP8ZA26qUD47Zb9FmHJcw85gw+6bdpfz5/ugR
    gdYUk3RA/8TIymY+jgRPm69LwyHI5PjsD4Y0xKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682508; bh=lz6DB0
    jYgOiWxwNj+IeAuSnhl6rPGskX0Vp4EMFsCVU=; b=kF2cpgJ/gItUseitDuc2im
    W5KG2ooylvQ/59ZUdQCu440phnjgsHeKQBe91/WILIvNWYtUDyWka9CjcVhIY96h
    YWfqLfXlcslK02d6DbOLq5tnZVUe2gMAREi20YUagkKj5dkzx+QkjVbsdAPDUYGB
    QeATBlKNvmQ/ZiqjKPmz/7tg7edWsn28zQqFzPUgSH2u7uN9OwJzDmxM+nmZ/peb
    +h00EpT5nExV8vwoE9AjE113o8Wx+bh+Myb3KPj65G+dvwDsHgusqX/L6q+toz3U
    rGSB5+b+IQoVMLw4S3BTPcY1Spaarm44P8tEvLPVQ7yAUR/ym7NWCgo7EwaOAh+A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QBe5qmNA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QBe5qmNA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753291AbeBCS2X (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:28:23 -0500
Received: from mail-bl2nam02on0132.outbound.protection.outlook.com ([104.47.38.132]:63252
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753241AbeBCSE7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Eduardo Otubo <otubo@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 46/52] xen-netfront: enable device after
 manual module load
Thread-Topic: [PATCH AUTOSEL for 4.9 46/52] xen-netfront: enable device after
 manual module load
Thread-Index: AQHTnRldDRrJDFoQ8kCUYQzUNOrVLQ==
Date: Sat, 3 Feb 2018 18:03:58 +0000
Message-ID: <20180203180303.8490-46-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:ioXSu+jU7tqVEUbeGDnThBi8B9CffHVdmMqPcFw8WL6ksvylKp7PVNRVsFAL0XL6mqyp3DgMCVJNbN2/b87kqrkCh1frJjwum0Bm7ZXbX+PyVkrVLdks/xbMaQFoQyBkZKPWdS5kTvfrLrZ5MHtmPr/rL1FtsTBiyf5tISNkfx2uRTRpjaxyh7lBQ8L/Hwu8JBdExOlwNhzXW8+/6utsnAFaAx/cmYeMVwcKHercZA5sS1A5KjKACMtLL4oo78Y2
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42de07fb-1ee2-4a9e-aa66-08d56b30a25a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB10898CCCF17291B9B4ADF780FBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 5921JDiRusN5Qv/Kr4ncBtXTwRq8JRkVojrjn3CfnmBt2XhZhP/6tD1s8DwMXxwIoAZXI51Stq8ZfJ2lAwZNcw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42de07fb-1ee2-4a9e-aa66-08d56b30a25a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:58.6120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
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
index 1a9dadf7b3cc..b09c81e882b4 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1345,6 +1345,7 @@ static struct net_device *xennet_create_dev(struct xe=
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
