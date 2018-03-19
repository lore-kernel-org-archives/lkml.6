Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478833-2-3321708843036581656
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
    t=1521478832; b=aw9I8PSENfAn/uavZm/02xD2EDbmO5qLAdQQhLWpvsmvzTh
    t7k/NPv1iAPFA/QAYY4PJNWVi3nRcNRvMxt0dMUpFkr2HPB0KneIjUcUkTVYMWQq
    n0ZLul7x3l7R4lollj1TYdvL26cnETCVheR/WPzhk7AaqvTzBBUT7nknWG609b/J
    2v+BFRVo0NIzW/0x4V4WNX5PAQrDiujsCuPx691jTd2BTuJH5xJR5BnuFkGO/jy1
    48vWjA7ZW0WFPMtS8s2rEbNULcvzcUWHIlknsNSCKZum263Vlkzd0Tth/gWWmCcc
    Jbo7Ie7vshP1IuOBFWo7J1ZwBlkGDJGhGqqE/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478832; bh=jqX+3J
    7oOxkeQnz9LD5XvjE5Vh1K6YzDPDd8cc+PWbI=; b=cH+iLlj812vwupHfYf+C4n
    Xm6MfRT3a2/0jvXMrzq8YLhYmOcdEtxvovriMvfqgmfZ0ebgMg2+zkoL6BA45+wi
    m3C6Jywkfc8wwAt2ElGEvr9qoIZ3LhIGzHhGF3JF7IDPLRXcHeVD030TouxcP1eD
    JCR9BhNIy1XC7qOcHDlXSj1CnFjRXf2u89txnStNsf5nNwqd2tBKFETfbMbKe2PX
    rE9D2RoYnQSCwV5PW+nzPeOlWy1wjoIsdXuSOM1bi0Y79WZOsG1RlXfgnnfTE3dd
    26wwlNoWdjTN71j4EmsFvePOfJXxCzrIVtmQVsXuEow7wQOPN8xVvsbZmOFJSncQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VsQpkJR6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeljeelnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VsQpkJR6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeljeelnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967576AbeCSQ62 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:58:28 -0400
Received: from mail-co1nam03on0139.outbound.protection.outlook.com ([104.47.40.139]:6160
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966742AbeCSQL0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: chenxiang <chenxiang66@hisilicon.com>,
        Jason Yan <yanaijie@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 158/167] scsi: libsas: initialize sas_phy
 status according to response of DISCOVER
Thread-Topic: [PATCH AUTOSEL for 4.4 158/167] scsi: libsas: initialize sas_phy
 status according to response of DISCOVER
Thread-Index: AQHTv5yLuwf0yWMjTUaRo2Rt1mY6cg==
Date: Mon, 19 Mar 2018 16:08:40 +0000
Message-ID: <20180319160513.16384-158-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:Xn8Xs9RV4wOcrzI48dy2AsIcfmHE8YHLGXbt3K7BPQRv1Zc0zvOISV8hXLaluf4uDZ9MJWdJGkgb+xGE4JIvywRe2m9T66FgodsrtW5rsPHIFfmfrOekqzP9hVepW7qUjlfNWtzYlgpdlT48WCs1AA/dW43brzrPFqVHwYz8jqO+KWLvQzsHMiV3S5R+Q5g1w7GiXVqb6J+R+5ILJMtPYTGZ8hUtdHd6tk/9reXyahOvuPYbD2Dlotxv6sB7XhDM;20:y9wVjQ4PfyKj9B4hFs8uUE2wff1P4ffEAFBrR6gz76m1R9p0uBSP4lT0xjRaVS7WEvgszC7YDIhaNcEfx20nOUci03xxfFzBvzHmfDjFCX3V/SGqIxJ+107/+yGGuAB09pRmp7V7i7/k0eEx+2xwx+Uzr9CJ+CPc3JopGngxOCA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e40d67aa-e57c-42a9-4c37-08d58db40ffb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0888DB5DAABDD961E13EEDE7FBD40@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(189003)(199004)(6486002)(72206003)(106356001)(86362001)(3660700001)(6436002)(68736007)(53936002)(107886003)(8936002)(81166006)(8676002)(81156014)(2906002)(6116002)(4326008)(6512007)(1076002)(86612001)(66066001)(25786009)(7736002)(3846002)(305945005)(5660300001)(99286004)(5250100002)(110136005)(478600001)(36756003)(54906003)(2501003)(5890100001)(6506007)(186003)(59450400001)(26005)(14454004)(6666003)(2900100001)(316002)(2950100002)(102836004)(10290500003)(3280700002)(97736004)(76176011)(10090500001)(22452003)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kCSj3emKBWD5Mjwz0/ym4+Kh5fxAw6TgrxuQoWZZqGGSVj8u26fEppTb2A9Y/WK99g+MW/O+fFflbKdJYAq8ZXqMpX0wLnDcSm6mtuZhn9nrw8CplC22uGg8NqItxny6NDYhCtMYOTqr+JmiegcMNV0Lbqjdw8BsdQ3AMjU3ZDL9crZr5mhqLGStD+ZAGTgHpSlQBmw1sCeUIo5y66bwYjkMGUDLR2UkkA1OtaoPZJDTgHpNGpdFEvtVX5JemvrR/Bo/1nkiqvostdut7HRPcNjvL65MXudovBWJWlFhw37cgosw2isd7BRplcPgKyST8NV0ccnTZiCVIKw4u8dWew==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40d67aa-e57c-42a9-4c37-08d58db40ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:40.9201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: chenxiang <chenxiang66@hisilicon.com>

[ Upstream commit affc67788fe5dfffad5cda3d461db5cf2b2ff2b0 ]

The status of SAS PHY is in sas_phy->enabled. There is an issue that the
status of a remote SAS PHY may be initialized incorrectly: if disable
remote SAS PHY through sysfs interface (such as echo 0 >
/sys/class/sas_phy/phy-1:0:0/enable), then reboot the system, and we
will find the status of remote SAS PHY which is disabled before is
1 (cat /sys/class/sas_phy/phy-1:0:0/enable). But actually the status of
remote SAS PHY is disabled and the device attached is not found.

In SAS protocol, NEGOTIATED LOGICAL LINK RATE field of DISCOVER response
is 0x1 when remote SAS PHY is disabled. So initialize sas_phy->enabled
according to the value of NEGOTIATED LOGICAL LINK RATE field.

Signed-off-by: chenxiang <chenxiang66@hisilicon.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/libsas/sas_expander.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_e=
xpander.c
index ccdb9d5e2f28..12886f96b286 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -282,6 +282,7 @@ static void sas_set_ex_phy(struct domain_device *dev, i=
nt phy_id, void *rsp)
 	phy->phy->minimum_linkrate =3D dr->pmin_linkrate;
 	phy->phy->maximum_linkrate =3D dr->pmax_linkrate;
 	phy->phy->negotiated_linkrate =3D phy->linkrate;
+	phy->phy->enabled =3D (phy->linkrate !=3D SAS_PHY_DISABLED);
=20
  skip:
 	if (new_phy)
--=20
2.14.1
