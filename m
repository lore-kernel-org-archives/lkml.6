Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475380-2-1308092656092790248
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475379; b=I3UwXmN1BuEFog5m2Z5kMG/rxtS1KapZd1AJZuGEemuBm2E
    3Evqsbkg7Z9rS+47i7IERLDU/jqAO6vQwBNdw7QRPVG3zD0Dqwik7XaQJ5c/vVkL
    LQzLSbKB/JIcpd7z47CJi/acEoSmotC7wsJx63TEwgB86ihLd8MNl/04hxA3G9n4
    KQ80LoTqm1saXisxVcga71HUJ0nJSb5s6oz5VLL8Hj0uN/TJSG5QVpAtpvW/cWv1
    NmcXlcWcvHX1lUQVYAaGE4H3Z7oIl1X2kpBUNnxje/k6UEg7yd8ziLOMyh5i8Zmv
    j3W1UMZAYougiXFEnI0V9GImt8HlYZ25F8aLNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475379; bh=o3Cnga
    kdTIaZh5pWY/3Y/hczWZGEKxmrxgOFiIn6A2s=; b=wDbSHosGYW2+myuZWGrf2I
    f2K03TLmoYGRZzjcZPosAFuhDs7jQLbq/FQ19oDddOtvLZMO4cLDi5wa/fd3rsUi
    i2Rs1MJUvb5BiKlgali30ia5kvCUnD8KIgaGhP9S+bY6IdvdQBh0DY1wAGUiuU5Z
    l+ZZyczeNUUZB3+NWQswBmOUcweScXDp5cLvndt46AiDgQ2N01lqH5gnmbeXfWQs
    /fNRqj/U+q2C7FEH2Bn9lL0WaVAxGh6YFQzmREd4X/CfTJnjp5R3QC3VHVT21XS6
    kHSjTwEAGNegsSMf43DgK3KS0od/6E5QacIEZaMeCHzWgsA4f1xgoP3flHSKDOIQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=odpKBvlu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvtdejnecuvehluhhsthgvrhfuihiivgepudefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=odpKBvlu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvtdejnecuvehluhhsthgvrhfuihiivgepudefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965477AbeCSQCu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:02:50 -0400
Received: from mail-by2nam03on0123.outbound.protection.outlook.com ([104.47.42.123]:60384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934934AbeCSQCj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Firo Yang <firogm@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 152/281] hdlcdrv: Fix divide by zero in
 hdlcdrv_ioctl
Thread-Topic: [PATCH AUTOSEL for 4.9 152/281] hdlcdrv: Fix divide by zero in
 hdlcdrv_ioctl
Thread-Index: AQHTv5t1OvKSLptnnEiLQV/f2rDthA==
Date: Mon, 19 Mar 2018 16:00:52 +0000
Message-ID: <20180319155742.13731-152-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:ZuZRXc5C/7E5nW4DQ4OJsqh0SKAqMf0PjNGm/ac5jUVPXHSvBtGnUit3Qy6kZ/MQbhDx6bNRS2v4SuSPDtxs2ctufFF1+viIQmg0jhdjYaSILSCdiT1Ym7mZeZ9ikQM0yyx8bJL/ZGLDEvtzcgD9l2ymKiYX5MPbS2MScmaAWM1xCOMmj90WCSwojiAYH9Hlvlfxpa0zNYTjS3maf0j3cEJ9RCkOO1csp66xOKeyL7yrjNGUS2+DDCCAO8+ioPtT;20:95Q6JPJVmqXjapcLnKqjFHxWpATGqgdVGifWp0JEg0QaL/xbDVG0DgCnnUlS79FCqMsUZK0rMAv4gCGqHTMjmSXy7g2gRaeIWSYBQNWcxGj2SMneYc3X/RjH8rd/9DD5QEw3FlB5h0bN7or9GvFqvQ63MkT7jdgWqoP275mtvPE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f588686-419f-48de-4402-08d58db2d508
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933E5A81C95364801E08E21FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6666003)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(39060400002)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(22906009)(133343001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: vehuEHZr6E2jyGDDHOCt3m1S/No2Ri9gcsioEQO6erRufvOSQb4kLYZ7TkXLnfARdgLCMOlf6q+JIXt25qY2CERXHM/l1CPxW+07tbaRBmVG66L2g2UPx+ePBsCI8kbDzc/AkwaocDr28h67DGvbI5ZHW3fCOCmm3g0aHrbvZEsOnUsoH4ALTTbH8mf0x+D6m6YDGWSdDrwEtWtjnZJlONqGZYDq5Gu16OzYexB04vP6ekAEredK7EDkwmYxzU7XkMyHXWTyGff3c+jJaHJQX84RN5W8cr8afFflWrWgzWjbjV/6BiDErSGs5yAZYfeGJGQLGU4AWDxxh40rRPOatw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f588686-419f-48de-4402-08d58db2d508
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:52.9326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Firo Yang <firogm@gmail.com>

[ Upstream commit fb3ce90b7d7761b6f7f28f0ff5c456ef6b5229a1 ]

syszkaller fuzzer triggered a divide by zero, when set calibration
through ioctl().

To fix it, test 'bitrate' if it is negative or 0, just return -EINVAL.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Firo Yang <firogm@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/hamradio/hdlcdrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/hamradio/hdlcdrv.c b/drivers/net/hamradio/hdlcdrv.=
c
index 4bad0b894e9c..27160d1870e1 100644
--- a/drivers/net/hamradio/hdlcdrv.c
+++ b/drivers/net/hamradio/hdlcdrv.c
@@ -576,6 +576,8 @@ static int hdlcdrv_ioctl(struct net_device *dev, struct=
 ifreq *ifr, int cmd)
 	case HDLCDRVCTL_CALIBRATE:
 		if(!capable(CAP_SYS_RAWIO))
 			return -EPERM;
+		if (s->par.bitrate <=3D 0)
+			return -EINVAL;
 		if (bi.data.calibrate > INT_MAX / s->par.bitrate)
 			return -EINVAL;
 		s->hdlctx.calibrate =3D bi.data.calibrate * s->par.bitrate / 16;
--=20
2.14.1
