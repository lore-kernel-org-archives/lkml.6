Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521477575-2-65707152204805575
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
    t=1521477574; b=v4lnrGO6cYIFy53qcqZQXIAGSPr8G81jOSxLlstkOri84KE
    wiwdmutRU0BTRAc8gZrZFvPhPXIA3sC2Twozl3AMZR4ypGCLFyA3IO7tpmn6jFmO
    3jW055rP4MScFzjCs8R4OZslsI7JwawxOPM7mGyof1QdsIqoKnnEBlxt40MFwk8Z
    6QmEPr36HSJhdD2/N3Op9n8wTOqOw+wNkpECqYLUNmIqB5BjHeR/chSSalGzrGwn
    taSwfHtxWJqN4K16ux3F4ZroEdjM8wruOgHnmcmPhSfYwcwURrYNXm2NPC88v9st
    /a3W2ivbca1FBBoB6jTr5ZHO9RwrNHe5cT/hqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477574; bh=JUyBZ8
    6TdKZO5rSVEIyKrb92lZunp0ahK3RRDgIeJ0Y=; b=arLbLjWkaI0uU+V+yMEKm3
    RVfuCmM4W2CmeQyAAO5NEsckC4F4pog+5wQDrzDnkv+ZDKcgZdz4nfoXeZMI/cxl
    1XeYHoJrM/VIJWfOpaXKBbd9OLsB12iyeioP19FNhk0dhaRHYIRqkQN4SBZmhrDy
    1+WvA1eGXaXPOvWpOOUqsBQHEoBoNq7af6KaTBBJon+i1h5Cqtn5q1u1qU4IYSAi
    Z17JbrJxDxMPaq6weZaeKNJM1DUaZSbVrN6MDx/F3ifWdrSjw9UW2ABSdp+/lBzi
    KwtjX+ttJ2FOaxmzYSQyAsZztLNg8oG8kFsDp301cVTxrugG5EiDPSTpVqOCWf/w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z0Oyx4OB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduleejnecuvehluhhsthgvrhfuihiivgepiedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z0Oyx4OB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeduleejnecuvehluhhsthgvrhfuihiivgepiedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934847AbeCSQjR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:39:17 -0400
Received: from mail-dm3nam03on0095.outbound.protection.outlook.com ([104.47.41.95]:57888
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966868AbeCSQNF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Firo Yang <firogm@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 054/102] hdlcdrv: Fix divide by zero in
 hdlcdrv_ioctl
Thread-Topic: [PATCH AUTOSEL for 3.18 054/102] hdlcdrv: Fix divide by zero in
 hdlcdrv_ioctl
Thread-Index: AQHTv50Z2wVnSSIcm0WwhIAeAGpb2A==
Date: Mon, 19 Mar 2018 16:12:37 +0000
Message-ID: <20180319161117.17833-54-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:Q/TuQoD4hsyRbYdMSZjI94WsIVD0y8SbvSOCmkTRm1B3JzZAWxZqdo8AUlB6yylQecy9J3AXpukGfdqJtuql8Y2a1fHFGk0fNPD76nvb5vuuH1QU9qZf6TadJhU6IM8C46IBRniCJCvxTPL0UZtpJBF5ObK3Kqp41cknaehGbvdkD+7VSFdHyjkAA/SCpnFLS8pdmnEUqcnrLDNgylpJ2DrykIrkGOm3BUwTK0ABP1xME8kpNMQmR1hmyqYcHrS/;20:4FSm8hKtS3LYe+QE1kyPQY1MAuIzpH2hcsLnoS4VnhJBFqDV8WL+c+jSMT9Eu6yQqZyQnjftLMPA9kA4CiNyCTNDdt298ZRgJ2wBGUiFoaH9Lg0p5Tac9jKbsFPXPkke+P6kl+/X/Yf8xIfmTnTD9VYVJmJMhWSJs99ttMVnpSE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78b7e183-c9b8-452a-a617-08d58db447f3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032E23EEECCB3AFC0545A81FBD40@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(3660700001)(5250100002)(3280700002)(8936002)(3846002)(6116002)(1076002)(10090500001)(105586002)(72206003)(81156014)(8676002)(81166006)(2906002)(5660300001)(97736004)(2501003)(36756003)(6666003)(2900100001)(14454004)(6512007)(6436002)(2950100002)(39060400002)(53936002)(4326008)(54906003)(305945005)(6486002)(25786009)(68736007)(22452003)(316002)(6506007)(86612001)(66066001)(76176011)(102836004)(7736002)(10290500003)(110136005)(106356001)(99286004)(107886003)(26005)(186003)(575784001)(86362001)(478600001)(22906009)(133343001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: PRngDFH1aa0aSobs3YddsWZSzCm5PjS+ZF8Q7wiVOOopTOIyZUciGxVfeunItqBpFPOsC1tQvpe9dDJUBJt7CKHHKnqjt7Frit8Qmc1yk5bmc/uTYD5YnEiXyQZM+IYb2EVJTv4IzpFQqbDNSCNHIV85oV3Q4FQsAcdvswtqe+A7r+x8Ze15RzWqA3w7xRFNM6o393ElceDL6NrFKe+CBFONfpj+AbPB6EtC8VPI6oBw4ygCmDxmp4uTAPumxUlBndMAWvyQzbMRKOQWtD3nSlJbObaO1qYGbUYCsmxxZWzKz+PGQi96Lsf4AUq2C/kyyPLn6LxMjKedSrFQpoi23A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b7e183-c9b8-452a-a617-08d58db447f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:37.6687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
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
index c67a27245072..69421ac06788 100644
--- a/drivers/net/hamradio/hdlcdrv.c
+++ b/drivers/net/hamradio/hdlcdrv.c
@@ -571,6 +571,8 @@ static int hdlcdrv_ioctl(struct net_device *dev, struct=
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
