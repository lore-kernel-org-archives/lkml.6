Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478578-2-1746580523419362535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521478577; b=rkkxZN+B3Nyx7xpXIFGVulsjMouzRw+rWj9q9K37w8b6s7A
    hfWHSyD0muJvnTrbcSQB76dWN8GzynPNOT1zwFRJVy9xJr76brzNPoW/ZRlA2NXN
    iqDeAWkzR9hFQ9aEPZyx+l1KIGlOh3i3tIc8HqknQKiUVE0gH2s33kCMn/0WHUe1
    zK9KDcd31p5Vadlh4rcra0LUNYjFDbD4oWIkEmGjjKLhmUA9DU9QddlLId78DF3I
    McZgESn44UyA4EgwJTfhSDOKR9ZGCeHbe8aa+23jzoVuMCgLDY6Q4aR/7Chq3Nkp
    INqEuVfEvkyEi8uPqnRg1N2X0W9S52WgstrvD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478577; bh=0tW07F
    a+pZubqbB7+cVPIdLhXZbe9Z3+hodu+Lnm0QA=; b=ocOrKqC20tGEvurfJXNUn6
    ZJQpuxETvJBpf8X26FhbQuHPvHen6g5ZYQ9JL5FV4gAexOoi8JZ5kSj/vTKywVWh
    TjbOV+eWDC8o1OkSj3aI4lUXj50zg4TCgNPeT3i+HG1psa9gtmPq/BucQKbUIOCr
    4ETFNJ0JIQIYLDxcgFD2Dw214BLNhKRc89ua9xgLpOrgS1u5nTRBdp67PeJfmONg
    hjjGeeJiLtSLgigNdDVjiFC55b9IEE0SiDckQOoevaM1H1Yb7hhdvox/J9zlDbQY
    uCKJv70nhd3CrRUeD/4gsadiz4A4Pcl2uZ3GiJsgOVVQgYeszgR8K//5OQ/6LJxA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=f1/32Vt6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedtgeefnecuvehluhhsthgvrhfuihiivgepjedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=f1/32Vt6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedtgeefnecuvehluhhsthgvrhfuihiivgepjedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966755AbeCSQLa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:11:30 -0400
Received: from mail-dm3nam03on0108.outbound.protection.outlook.com ([104.47.41.108]:23560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966521AbeCSQLX (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 152/167] vxlan: dont migrate permanent fdb
 entries during learn
Thread-Topic: [PATCH AUTOSEL for 4.4 152/167] vxlan: dont migrate permanent
 fdb entries during learn
Thread-Index: AQHTv5yH639IhHLZDUGRgLlKGN8pjw==
Date: Mon, 19 Mar 2018 16:08:33 +0000
Message-ID: <20180319160513.16384-152-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:9tT0hBBTTwavkKjq2piZTQu8xGkErC6Fh8O8xu9LiZJSW/UrzvTTQZ9DT3iV1A07+yC/C4jyzrcLa+emN50IzENr3HB5sfEZBhArnnH8pD+/poSlFDQrrFhsinXIX/R9t/mwuIjCeO0D1ETOAluq0HE5JwZRsMN+G9J1u3NCWu//RIqLm2M29F5mAOxsXkk03t0RFS0bh7RjIK+GKN6VxBdlQPMlpy2ZAE4YvLMl8oh9WJGy0o9q5NWsu7vokB2B;20:yBIoTghpePEo1oTL4Y92U2+I82NcWvDyaJyecIamnH9OIeCANrZ2nnlb4ETs9P9Jd1babyf7eNbj68udLAcCdKh8cbQN8YpKncJgWgCMBWJNgqhJudPA8uYOtajkEfXT3c4dI1+Toi9Ob7SUMRHiBIi89W3S76QXQXaTYng+WGc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28e60647-9ba1-46ff-3c61-08d58db40e19
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09847C92ECCDEE228A085FF7FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(54906003)(14454004)(68736007)(10090500001)(5660300001)(6506007)(186003)(26005)(99286004)(7736002)(305945005)(76176011)(316002)(22452003)(53936002)(59450400001)(102836004)(110136005)(2906002)(107886003)(86362001)(10290500003)(3280700002)(478600001)(3660700001)(72206003)(86612001)(6512007)(3846002)(66066001)(36756003)(97736004)(6116002)(6486002)(25786009)(6666003)(2950100002)(1076002)(4326008)(5250100002)(105586002)(2900100001)(2501003)(81166006)(8936002)(81156014)(6436002)(8676002)(106356001)(22906009)(192303002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zpTll1KvRsD1wn5rqa363A0PwmaToNpLqmJQ5JuS230MfIwRI3/FEC8U7ObIZuHLoIhvtF9muTS/4wMAu4T5RQNaGBafqHQgn6VdPHY4iTLSk3TwwowmBDUpuYejqO4W+vkNw5ytLey+YwwNe/tjstOUoWH+k2yboJ71efbcffoGnV7fLG1/RsiX6LxHvnClp6DThmRsVIrup6XWQLe1M03oon9mk/YDXHlxnwS3gmUylX7T114cicEk/1yYtgxv0sOzGcJzhip9ozpbYo1RGVmgs0X0z9lBPHA9OJNc89jzfNMl9s+U8MRl7C/6gMh1jLuVF6Pe2drmMv0zP6qbsQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e60647-9ba1-46ff-3c61-08d58db40e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:33.1746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Roopa Prabhu <roopa@cumulusnetworks.com>

[ Upstream commit e0090a9e979de5202c7d16c635dea2f005221073 ]

This patch fixes vxlan_snoop to not move permanent fdb entries
on learn events. This is consistent with the bridge fdb
handling of permanent entries.

Fixes: 26a41ae60438 ("vxlan: only migrate dynamic FDB entries")
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/vxlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index dab3bf6649e6..617a213f9d5f 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -962,7 +962,7 @@ static bool vxlan_snoop(struct net_device *dev,
 			return false;
=20
 		/* Don't migrate static entries, drop packets */
-		if (f->state & NUD_NOARP)
+		if (f->state & (NUD_PERMANENT | NUD_NOARP))
 			return true;
=20
 		if (net_ratelimit())
--=20
2.14.1
