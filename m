Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521477497-2-6254642216333458814
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521477497; b=VkYI3psz+uxtamHkAQSAFRl9GNMv2bCee/aXrnFfM1rbmwN
    H9IABIcVQ7jHOSg1dx12rykY6qIzZ9weP0NBLuViivJ9isAfqRfj/N/XEoVWwTHM
    amABZtWmSClSKWyxAvM/oBHNFc18Hj6VvMqDONVJDGxS4UFXPD+BVoOrH394jj1t
    znNKJfIdgs5H+1/VpRAE5g/P+d6dq65RwRfb+SJnIA52PCbcA1oJ6px2nqsA9YQD
    GWtDCEwY8aIK0k0rxSTLYZFeAo5LGT6LzVhGDNP35DSb9oqEDs+3yTrwIi/Ejudz
    AheT0XJ13xB/oWUf7Iye0pslTFrxwjfCoeim5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477497; bh=JlC5IJ
    /elYpGrZSEb9mBgkvLzYi92o/XeYZQiP8C2MM=; b=j5x7rmuP2aHyXUUnbremj1
    VP64n/oFVv6eRuoms9+rRKIKjzN4HIUclw3tXRoGW9QIDyU7AsA6mB9q0WRpzXGr
    kDGC/o380tO9S0VfKsNRGStz5No5WtzkRI96moTybcSBOYHTR8QYXRvT4D6GQ3WD
    TEbb+1mOsmXvTLWPA5EGaW1qqmg/AjhU+bc2c4V7d4moxngMUVQrukH5XAkw6iMR
    8OnzXEnUs4JvJ8ZkYIuCCtODYj3M6uhm+fABdlPKGaTa/lXqfRPEE09yhJqNuS4A
    Q1f6R/yo1fChghQorMbt1N3WcYyPQx5eYsmz2ab1uzr6Rq880zALtMVC0gIUn0Vg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kfdoz+Ph x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefjeeinecuvehluhhsthgvrhfuihiivgepgeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kfdoz+Ph x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefjeeinecuvehluhhsthgvrhfuihiivgepgeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965249AbeCSQgv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:36:51 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:64207
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935279AbeCSQNU (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jia-Ju Bai <baijiaju1990@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 064/102] qlcnic: Fix a sleep-in-atomic bug in
 qlcnic_82xx_hw_write_wx_2M and qlcnic_82xx_hw_read_wx_2M
Thread-Topic: [PATCH AUTOSEL for 3.18 064/102] qlcnic: Fix a sleep-in-atomic
 bug in qlcnic_82xx_hw_write_wx_2M and qlcnic_82xx_hw_read_wx_2M
Thread-Index: AQHTv50gwyfjw7IMm0mMn/NmcdZhAw==
Date: Mon, 19 Mar 2018 16:12:49 +0000
Message-ID: <20180319161117.17833-64-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:EOv1K851dMgjEi4tgNebkSZp8eMFENytoPT/d9d5YBi268eRsM8j6Jy25Cmpg+GUeiwIWoH0mtLg5dmqXkY+ruiN4bcIfQ3cX6JDXXpzN9hO4u1r5h6sDz/232KOoVNiZkIGoGvuvu9bKwhtD5NbW55rLG5MQPKJHXFn5CDWIxiBDhiN5cjzYWW18wVvDEvHfG1cOKd/eHFcn/brqyV9m0IN0VFpAy/NAbRrlBTY4zvjsVeS83shBZL6aXxiTHWa;20:pkWTsqsGHJi2v+0NvVYX4WWJE6KlsmfUTYsLSaxSJwIIzHXvpMttDRvQbUWEFlmhU834t3Ob7y6GtiZJosyQKQwBTuTMQPEQtuLNNQ7w3qbX75P/YirHAqx+s+DZkWZZ4xxPJ+I18iyRWYEHuyPsTW+Ke72rhdgNl9LX3c6iJTY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef3dd76f-04be-4097-df17-08d58db4543c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10486FACDB62BD15E5BA3317FBD40@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(39860400002)(366004)(376002)(189003)(199004)(10090500001)(107886003)(25786009)(106356001)(102836004)(26005)(6506007)(8936002)(2906002)(6666003)(186003)(86362001)(2950100002)(5250100002)(66066001)(3280700002)(5660300001)(4326008)(72206003)(68736007)(10290500003)(86612001)(2501003)(478600001)(81156014)(81166006)(8676002)(2900100001)(1076002)(105586002)(6436002)(54906003)(110136005)(53936002)(36756003)(6116002)(59450400001)(3846002)(305945005)(316002)(6512007)(6486002)(14454004)(15760500003)(97736004)(3660700001)(7736002)(76176011)(22452003)(99286004)(22906009)(31853002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: crne8S7TSZLR0goOu3SVVnDLgASrS3BOC9EjJlI8Bnz+F0vrkVc4oCKJ2LMw4CD8w07tdnWp4Q5YhrQd4MMvB47Q19MGMp1kQhexVXTq6m4X1UkR9jsiYyFK9qHvyCO6mZlY3q7v1Yqfox6OoY9DcDIvqfcj6SgbR9e3CMMcsRyGwndXfugu/y/4s3tAGJNI/TX9WXovI9cBY7eQo6K9mbL9q9NS316jLzaSStPnvXGHL4jFD5DFUIkSJeqWQOuwpIuhF7+d2I2P892lcSFWiK3gTTUPhswpUTXKHiOIfRE58K0FG2ChrrhOVNW1fH849jqy/kYQ6xIZvd4omTQHdw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3dd76f-04be-4097-df17-08d58db4543c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:49.3389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jia-Ju Bai <baijiaju1990@163.com>

[ Upstream commit 5ea6d691aac6c93b790f0905e3460d44cc4c449b ]

The driver may sleep under a write spin lock, and the function
call path is:
qlcnic_82xx_hw_write_wx_2M (acquire the lock by write_lock_irqsave)
  crb_win_lock
    qlcnic_pcie_sem_lock
      usleep_range
qlcnic_82xx_hw_read_wx_2M (acquire the lock by write_lock_irqsave)
  crb_win_lock
    qlcnic_pcie_sem_lock
      usleep_range

To fix it, the usleep_range is replaced with udelay.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c b/drivers/net/e=
thernet/qlogic/qlcnic/qlcnic_hw.c
index 69b46c051cc0..3295580b3aa0 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
@@ -341,7 +341,7 @@ qlcnic_pcie_sem_lock(struct qlcnic_adapter *adapter, in=
t sem, u32 id_reg)
 			}
 			return -EIO;
 		}
-		usleep_range(1000, 1500);
+		udelay(1200);
 	}
=20
 	if (id_reg)
--=20
2.14.1
