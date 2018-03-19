Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479653-2-11062836762490095402
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
    t=1521479652; b=tuoevNVLtutI3K44ZNK56OCY+EyzqArixy6cJTiRj5GZEtc
    S+n0ZN07F8IO+pnTWHY+yx6fgd+nK5IssJSipAuoEiQc/PIp7e+85vmlqn7xXd0l
    ML+jQvaZ/R0CDLTikiuBpIGtI4HEQt8jZVB2lvO/YV1oeme1tVj7BYpBgJnIAfYZ
    jMaCMWY7Oy5Ewxy4gLmiQFOs0tYosqq+cDSLZOK/qMz0ZXstM6ha2ezbzQecupBs
    XxiG1RxuDtV4bNhhOoxQhW9W+7v8PdAk5p5f/qN2EGebhNvLxPzbB0OCOx2U7/eg
    8Zhc5w/0lBxAR8eqVDAU4yP2pirhD0P5E/5JklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479652; bh=bw8Nar
    quo+aYYb5OH63Sd849RmTtL+ergnW6z90Y3Mo=; b=OliGodd16aUTU6Lb60hAwC
    tpQG5aFBlrOVgMutc82h1BROcyiqIqO/mPZn+uoOybk8f+tq83woMKDe2gHAD9rj
    ev57R1uFA0xyLTbuSB0MGrd1tLv6gWXshXt11tuGqVfAxFMfjDdg6yVx0PnFXUH2
    0/kotXimgx3YkFtTlRP8nn1baZMsmDf6rKf03us65c4r+Xg7v05+V29bkI1DT6r2
    6WlUOgiLST/CqaUR/rd9g0J3+5t+Qc+F/a+Rm6O7QiqB23RL/+FhEo+oknZyfy5L
    DkhZYq0K8Mgg3jQDHRdbH/9kWIPj6z6agzawrpMcMO7GECY/HRm3PaKSkUYhACjA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CRwWNFeU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefjeegnecuvehluhhsthgvrhfuihiivgepgedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CRwWNFeU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefjeegnecuvehluhhsthgvrhfuihiivgepgedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966023AbeCSRN5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:13:57 -0400
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:9825
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966577AbeCSQKK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jia-Ju Bai <baijiaju1990@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 115/167] qlcnic: Fix a sleep-in-atomic bug in
 qlcnic_82xx_hw_write_wx_2M and qlcnic_82xx_hw_read_wx_2M
Thread-Topic: [PATCH AUTOSEL for 4.4 115/167] qlcnic: Fix a sleep-in-atomic
 bug in qlcnic_82xx_hw_write_wx_2M and qlcnic_82xx_hw_read_wx_2M
Thread-Index: AQHTv5xrv41P7u2S5kCqN+EsT8NHuQ==
Date: Mon, 19 Mar 2018 16:07:46 +0000
Message-ID: <20180319160513.16384-115-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:KW6nMgIdOJAuJ2W4qp9XuUnLrtr+b1a9NlQ8aXyWFxW3c/fnNPTg07F/KLdSRkbDMIoXRLvTT6g+0ur7NZrcOL/lAS39NbI+Hz/wWrd2l7ELdzoYHQktziz1o5nCr1BjmWfwY835Gjcn7t8DOAiuu0cYRgbGgFlZOzv8+27/es62p+N54eydbZLDFoson/uXiu6pbD78SqGZhGa2cT+xTJ0FM0AUlw2jwb3kQoXAGJlA6XTu4uGlfdSW7yo63qbp;20:1OgMLWSnnTYpyabAiO/xAPRyAG7JfV18IqqxQ6oyu7ZsUbFwiVhdhsJEjY6QIgGy0uAJH+VsWdOetStzRbWvkAlS9OnDaNLXUBtFTE9rqMg+ukRGdcKubVz1dM7hj3YvkosAaseMyz0W1LOVKYqLj+zu4To/Tb1fREsrnw2DCss=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 973b9420-3c77-4e92-a90d-08d58db3de48
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919049957D4C0C5CB6B0356FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(15760500003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(31853002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: UiMFtngAQW7L684PLFamyCTOANNSV4/W7CDaJGJlUasJ0+BinMQxecU9xLSLkYbQokMlpbsd1D1ji3I6yqNYnAP5lNa/oY+E5DPOeYmDs4I9GwhQsWnk/SEIO5iQ8LRZZsRJav+VDn/1E2xFNVB9O7SblzIEGttWPa1cLvSTpk0wHZWNDoo8hl8aMkgXFE/oQFMeoy8IimhbZh0hYbTGwmQQx/n3xLwrywsL+9RuMEGF8NwdvSPULTceCnRK4gD1TVTY96V4vreuCcObw4rlxBi5EHMfNpAeXj5n5iRm2a6PuCpi71fy2KA0qeJvPb8RkL2u9jI1lV5su95DUBg/BA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973b9420-3c77-4e92-a90d-08d58db3de48
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:46.8358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index 509b596cf1e8..bd1ec70fb736 100644
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
