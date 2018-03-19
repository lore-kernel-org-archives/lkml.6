Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521477866-2-1378614318857736850
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
    t=1521477865; b=NS91e2a9q1MR68l9Lcl4Cq/EW4U3DXgqKWQ96aokOStiyx2
    PkrqVU8O2rdwAKHl2xMOxVvxnFmRnTiT6xM/uwUVx9QnOwh/8e/RKLJH+2QnSWXY
    6BNcv/puHjM1k06SQXzTw1d/FhIAd7h4VLjt5ZxR4tZlSEvdqkGpb/L8LfZ/XuRL
    0Ps2/7VzXarVlj0vcv8y0bSwReqA2RI6oIeyA0FUFY/IiaCESieiG8pCql0HWdoy
    SRn3GrDsUoPO8IgXZsowx9PfE19FykQR46Br5hkYrmtD2GL8n7BESPHo5LArN4ut
    cEgx33ksLM/OTeGtC3f045OtTpsQG7CnRP1lp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477865; bh=bYd12C
    B2pAcAWh8a+fppoJlzjhJm2BU3mbXmfUNOPT8=; b=UeNTsDTywBowJg+rIZWU3a
    kytbSV++g2JBjO5LSJmcmUofb1H2N54k+9NBTqmNGHgXmgiqMPh0tHNmZc1ebhCa
    cBpKug2hMl0parfQVIg1TzAz831w1cuNyJZqj5QI+8cmI4kOqWliJMV9JPsgnXHX
    GUU2QQmNwg4C0QpG/Uma+l0LlGPA1caJWmrl2fmsVGU6v9JSaHaF0Qjhk72Mr4SH
    p/Ry6y8fmFSBR9MeKjdeMy6K66ZCCe7PGB6zew/Wl7RMETWJYB2K6ftGQjMKUYtX
    xcQZO3ZeG/gpAiD6UU7UHCqhO75rhZT73r0Wbk6tWMF56VBDxDpqoQxlLs37zaPQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y7gvzQWt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeefvdelnecuvehluhhsthgvrhfuihiivgepfedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y7gvzQWt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeefvdelnecuvehluhhsthgvrhfuihiivgepfedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965874AbeCSQoX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:44:23 -0400
Received: from mail-co1nam03on0099.outbound.protection.outlook.com ([104.47.40.99]:8096
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966583AbeCSQMU (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Antony Antony <antony@phenome.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 036/102] xfrm: fix state migration copy
 replay sequence numbers
Thread-Topic: [PATCH AUTOSEL for 3.18 036/102] xfrm: fix state migration copy
 replay sequence numbers
Thread-Index: AQHTv50NznBZi6ZJ1km27fPVYDTrLw==
Date: Mon, 19 Mar 2018 16:12:18 +0000
Message-ID: <20180319161117.17833-36-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:fMSWnGyYYqtjM3qMgWQSRMieQZmdbUElBs5fUNoeXS6RV6gihwQmsW88zqYztbswgcJpfTmiXhobcUzPYwoxv5zGrl6MR849dv1Qog2iEz6gv/zfs0El+JXUxh9R2Cz8BviFyCNJohbOdcBllOwFkgRWCPRfvFkAabvIM7FZntXFAnNqztFCMiOp0Xk/bgxqXkUISx+KKH1j+4+vWdxbQkWvMC3D4OdL6gUxogjLIeDrXnNCTZuQD94oo/yApJFQ;20:3mdQm/HGsp7QcMayoMPymZzH7FQNNfnDL+gF5YamTAorYCidFOaIXS1K/asqEyQJBOL4349a6BaxnOpkeSof+NXr4TRFdI/28L+Y0DEJDktDfZYSz2tCor5+B7PtvODzbMHP67Cu5fYQSMRDe3BjEcK1Fy4vBkOR9d5nwHqOSNk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10cae924-e632-4768-e3bd-08d58db4300f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101457A3D976E8D41A5283C4FBD40@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(2501003)(6486002)(478600001)(5250100002)(102836004)(86612001)(1076002)(97736004)(86362001)(99286004)(72206003)(2906002)(6436002)(107886003)(66066001)(6116002)(81156014)(10090500001)(81166006)(305945005)(8676002)(7736002)(68736007)(3846002)(110136005)(54906003)(26005)(3280700002)(105586002)(316002)(186003)(53936002)(8936002)(76176011)(2900100001)(6506007)(10290500003)(22452003)(2950100002)(36756003)(25786009)(5660300001)(106356001)(3660700001)(4326008)(14454004)(6512007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xzY8uQ0x5I/QHlm/BAYUYeus+SDXSkNFMi0cGbnhLMCqRroC9rAnouDQzCQwUqd/u7OEACsAe9VPZx8tFIjs6d5vK+xZIWLKWOgWdtzQMF45FyZ7hWk3OdpKJNYMVM2q6kDAxNFVZ6vrF/t+5KdKTKAJNQYNU4G+HG7p/tzTs/RShn4OGzur8tczPVm/BaIhl78ySwjImDwgRbALG35pzi3OhV/mBRe0cbEZJvnyKUmjHJJ8M9fnv/K5sSqHQg1Ntw168uAyM9B0afPiJNetzC07t+pqK9XYhuHR1YrmLcwVjG2eQAnejz1LJvUNzQPi3zDbPT12gKpMbhysc2UoLw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cae924-e632-4768-e3bd-08d58db4300f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:18.0839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Antony Antony <antony@phenome.org>

[ Upstream commit a486cd23661c9387fb076c3f6ae8b2aa9d20d54a ]

During xfrm migration copy replay and preplay sequence numbers
from the previous state.

Here is a tcpdump output showing the problem.
10.0.10.46 is running vanilla kernel, is the IKE/IPsec responder.
After the migration it sent wrong sequence number, reset to 1.
The migration is from 10.0.0.52 to 10.0.0.53.

IP 10.0.0.52.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=3D0x43ef462d,seq=3D=
0x7cf), length 136
IP 10.0.10.46.4500 > 10.0.0.52.4500: UDP-encap: ESP(spi=3D0xca1c282d,seq=3D=
0x7cf), length 136
IP 10.0.0.52.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=3D0x43ef462d,seq=3D=
0x7d0), length 136
IP 10.0.10.46.4500 > 10.0.0.52.4500: UDP-encap: ESP(spi=3D0xca1c282d,seq=3D=
0x7d0), length 136

IP 10.0.0.53.4500 > 10.0.10.46.4500: NONESP-encap: isakmp: child_sa  inf2[I=
]
IP 10.0.10.46.4500 > 10.0.0.53.4500: NONESP-encap: isakmp: child_sa  inf2[R=
]
IP 10.0.0.53.4500 > 10.0.10.46.4500: NONESP-encap: isakmp: child_sa  inf2[I=
]
IP 10.0.10.46.4500 > 10.0.0.53.4500: NONESP-encap: isakmp: child_sa  inf2[R=
]

IP 10.0.0.53.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=3D0x43ef462d,seq=3D=
0x7d1), length 136

NOTE: next sequence is wrong 0x1

IP 10.0.10.46.4500 > 10.0.0.53.4500: UDP-encap: ESP(spi=3D0xca1c282d,seq=3D=
0x1), length 136
IP 10.0.0.53.4500 > 10.0.10.46.4500: UDP-encap: ESP(spi=3D0x43ef462d,seq=3D=
0x7d2), length 136
IP 10.0.10.46.4500 > 10.0.0.53.4500: UDP-encap: ESP(spi=3D0xca1c282d,seq=3D=
0x2), length 136

Signed-off-by: Antony Antony <antony@phenome.org>
Reviewed-by: Richard Guy Briggs <rgb@tricolour.ca>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/xfrm/xfrm_state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index de971b6d38c5..592a6102187d 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1208,6 +1208,8 @@ static struct xfrm_state *xfrm_state_clone(struct xfr=
m_state *orig)
 	x->curlft.add_time =3D orig->curlft.add_time;
 	x->km.state =3D orig->km.state;
 	x->km.seq =3D orig->km.seq;
+	x->replay =3D orig->replay;
+	x->preplay =3D orig->preplay;
=20
 	return x;
=20
--=20
2.14.1
