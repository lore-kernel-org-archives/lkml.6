Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475137-2-6476543287861661558
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
    t=1521475137; b=uGCg5N+wkz7Q4pdie8ELAUk41h1CB9rEw0/RW1n2LbxKZgK
    DzoGfWOtYGv1o+6nZfdqMVAPWaTTObW3R7vrFOODwRqL917lSK/rWs01dMVZIjuR
    POuDOj7X1nvrf9saq2fQ2LUDSevsh/FsQsb3k5j/fcl9V9g8LxOyxjQeGwNYs8i0
    evDy1s2SSMpybK+0IZPSPx57y1DnmM7EFpQus0WFDHpSus0Psl0s3mVA3q9LP2Gr
    HRjp3L0szYphACDy9CaQW0bkO7//GlZRrYcixfM4femJr5bKpDLg8Yq7ypfeBlU9
    9k35jvaXCiXa+BaaQPfHhVLZGfjH/0jxumEqR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475137; bh=zXjlvc
    tVwp+QfeLyXCpgWX+FIChVYmUBn5BiGVXCkeA=; b=i+dDWGx3Tp6UYbKg71tDBY
    BgZ7IOiQeYFh03AOSy2+Ed9k1635QrLrM72jv3oLwi7NQS3GsP9BKuE2Syu14/l+
    lHJFzjHZVhRVs6ZiLjSdNXksLw8RmNRn6qyxdaHW3HDOtNBWLyo8Nma5mEDnAxSR
    LF7feheVM4BvhPW8FDWXUjcDSaftmgPrde0phzhMdu3hNpJ6pN/eQ6J6/eQTyxtY
    RTlNJvYz1nPYr2cQ2xxEDq7/dvcxnea6Q7btexQYmEE7X8qKWISygp13FjBADMSb
    rGrlxof5EsdiXuySWq2TFyHY8cseLVU7H401iXxfWLK4i5hObAASbTO4DdQ0Ny/w
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i4jduUGm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvkedunecuvehluhhsthgvrhfuihiivgepuddtvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i4jduUGm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvkedunecuvehluhhsthgvrhfuihiivgepuddtvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934348AbeCSP6v (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:58:51 -0400
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:19072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934614AbeCSP4q (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephen Hemminger <stephen@networkplumber.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 75/97] uio_hv_generic: check that host
 supports monitor page
Thread-Topic: [PATCH AUTOSEL for 4.14 75/97] uio_hv_generic: check that host
 supports monitor page
Thread-Index: AQHTv5rMfJzEPTfXZ0yVh2KjEfRdiQ==
Date: Mon, 19 Mar 2018 15:56:10 +0000
Message-ID: <20180319155411.12348-75-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:8Q+dlc0ZuO8IVngtKpd8ZhHNuP9q9/F/eHocK1T8haDoGdZ2ShUbULcIymOYGU5YE6N8pm2g7c+N0bho15/38g2JkATtuRnZYOCBXcMFki9gZNN4GiAEhcSxHod0W2u5IcXn8k0SQExDLOEcdh7Vw04P0NVwPJ/7ppimSKtgVJ4Ki7ME6sFC7IuF0ihX9NQFT6WCekWRqC95suJNQ4pqRxMx0awnk+MW08QBvgX7XL5840n9xBPGaeQl2vWUBjFD;20:ONXTlsQJr8oXlOWft6le6d3DWUlvnnVmxbdodzuRv6HMgxv7ur2IcogpMLM43K96jHo42k2BQ90W6LD7Ve2m4bKrzVGiiXgF2ZsI+/4CJH+uvDgBSq/yv8020KrCjIYO7FsFWJHD223834jArTTXludae82hGpKH4JTZCG8ZwRI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a44c9e40-b997-428e-6de1-08d58db1ff7f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103112B8E7BCEE1B088B42DDFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Tld1Us/d/9ZunF68chvZb7FJP7N2vBNJnCH7JVpLE7eUgW/9Tn8EY3M3dIJ/geLT+uloDwsxpDeHVJ3TzYeGxmU1PIoal8uymxUquxoTHL0x7SPijbLCV95CKwd66DJaE2yhnoNUi2Rb+f2TfQSUI81BHikehsbZeilOzPYH52W1DorqUZ0ClsIcNw4eYe+AmBmw87EMsIhLWxW8HcBh9YSb/H+lT6GkuiYkpFVw8ljQ6PeU5MzoMQSsTUyPWsesGouIzDqVYwOn4AHtkxg8Gi7m8Jj/QLM4kcs6R/yjleL/S+LIHZb/qu/Diir2YxCAB454Wyh6gOOUFnEfJH1jDw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44c9e40-b997-428e-6de1-08d58db1ff7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:10.6952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 06028d15177a1b406b7b075ea47c6a352732f23a ]

In order for userspace application to signal host, it needs the
host to support the monitor page property. Check for the flag
and fail if this is not supported.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 48d5327d38d4..fe5cdda80b2c 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -124,6 +124,13 @@ hv_uio_probe(struct hv_device *dev,
 	if (ret)
 		goto fail;
=20
+	/* Communicating with host has to be via shared memory not hypercall */
+	if (!dev->channel->offermsg.monitor_allocated) {
+		dev_err(&dev->device, "vmbus channel requires hypercall\n");
+		ret =3D -ENOTSUPP;
+		goto fail_close;
+	}
+
 	dev->channel->inbound.ring_buffer->interrupt_mask =3D 1;
 	set_channel_read_mode(dev->channel, HV_CALL_DIRECT);
=20
--=20
2.14.1
