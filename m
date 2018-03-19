Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521476363-2-14905139176536890364
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
    t=1521476362; b=HtzKzqujstjh0wrUVMpgZd933XuPkcWyhgexvs9cfuGsRfK
    58/IchfTHJdRQUG1lWnQReKw3uWw1YcoRf9SA6LeXJfbNsMJOyv2VCfSqTgrwhUK
    vNFqHa+agJY8W0CmdkXHLsJt/awdDu8wezpN2iMZH0F2fzKwvJ/k+h9xuS1IVy51
    0NWFY2EuX1yjPpMzeHfEm6PypFMVQxLS1n+gigDHhahxJ5iidvKvoZ2N3fKIMVmh
    hJU0l22kInMNjRUNNrMFPPKopxGYFsMhLt1f7Ia+7QuSVJAf8c+ymXtojd/9GqXP
    8TQAiZAaImrRALGQB/AnWTEo7TFTQvAhzgMPK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476362; bh=+bMd+W
    y+Oh+i9+wXGglNs6Cv42VSHIhkauMX6zclQsk=; b=gkext7pnyw/eGSGHx/cJEe
    JhmOFQpAxl40OL/pkNYcwYbdPi54G51xhFbeYBXioaxFnld/RDZaTOB3ktzoqgEC
    EH36GDdaAsHLpVGB40KNHVoEmhoLfmosdR7t7NxjAeNsEAXazcpQ3KGvQz4qLqdh
    ygaThMpAlk771m7s/L+iIauOZ7KyVeNqyVU07ujjzBE6Kmh2g1t3lIv12kCEXHcx
    PV4JYYSfCp28inw+NaP/0vX5TIdebR1qVhasGmzvPB2cfU8WFSCyaeWrbHCQFsKO
    UKXxhLR/5rmvlL6HJQ8bQZJWqht7QLls0HY1sO806Z1LAuy1JSKOqlfHAqW+X5lw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZYupO5qM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelkeehnecuvehluhhsthgvrhfuihiivgepjeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZYupO5qM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeelkeehnecuvehluhhsthgvrhfuihiivgepjeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966966AbeCSQO1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:14:27 -0400
Received: from mail-cys01nam02on0119.outbound.protection.outlook.com ([104.47.37.119]:50448
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966940AbeCSQOS (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Mintz, Yuval" <Yuval.Mintz@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 084/102] bnx2x: Allow vfs to disable txvlan
 offload
Thread-Topic: [PATCH AUTOSEL for 3.18 084/102] bnx2x: Allow vfs to disable
 txvlan offload
Thread-Index: AQHTv50umdao+s44NkKxZbpZNdsnxA==
Date: Mon, 19 Mar 2018 16:13:14 +0000
Message-ID: <20180319161117.17833-84-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:QXy3toYfUU25uTru1Ao77d+rqgiFCHHdsbZYRuJm0uZQ1BgUXbkyyAAcQo6fkajSml3cjBQZKjo79sCKKNKideSkQ6ODzKCdRB5hriK3f1nbtfDq+guqRTwjIdNVCZ3L6MloskdH0vVAOON8agdc5vqJGov6I5zuteVefNS2fK6ecuAvNY/+VuHapxTWrlGomdS88AQFKgozZkCgtQsmdreHLSNqf3+YOjSiqXBb/ZX1MFOlxUMk61dTKK2hhTFs;20:as70+40jQcfImZwI4/hWa7KP8rm0jToJhFvzOCgncJWYvI9sWkCzWP5rDcUvoWIr1vIfH7KnB4fklpzxlNOtm7iYoRgWiROYQHTOOEEoqY1klHzhSOKR3Moc2S6qwqBDZd26zuFfBCq+djjDx46Y3gzuBGg+v7gJEEoADKKkQsc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48141267-a5a6-49ac-f97c-08d58db471cf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063ECCF64AB9C090DBF5D04FBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(3846002)(6116002)(8936002)(1076002)(8676002)(3280700002)(2501003)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(59450400001)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(6666003)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(3660700001)(25786009)(86612001)(26005)(6436002)(6486002)(186003)(4326008)(54906003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: r24EDrB3PcskXu2wmjEa2I9x4cuPpMsghIR6Z/kyFPS/Q37XAWKTGYnzxEA5KbQXK3NnlWT1Ig6kzpeGNudqVAK8hpfJ/3s6b5aofh8ZGNhtsymecBptNdk5VjUD7LLlfja8FD5zomJZpzbHKZKwl0+6lxro6DsOf22KEj6tUDIczcvD/ll8m9tFWam5c6+ucFfVp0I1CpdDZp9rUM0zqkQsKYvm7eEzYLl5RVb07Xx9WHcdm6NeSAfAYfakoVGefsrKLw/BLgTTYWASEKBybGqyW3RImfUbc8p+769fSf9EHRtMVQTI5uyCpXE+f+4zxNk7eBoCDz6pwFC1e460kA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48141267-a5a6-49ac-f97c-08d58db471cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:14.2354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Mintz, Yuval" <Yuval.Mintz@cavium.com>

[ Upstream commit 92f85f05caa51d844af6ea14ffbc7a786446a644 ]

VF clients are configured as enforced, meaning firmware is validating
the correctness of their ethertype/vid during transmission.
Once txvlan is disabled, VF would start getting SKBs for transmission
here vlan is on the payload - but it'll pass the packet's ethertype
instead of the vid, leading to firmware declaring it as malicious.

Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/=
ethernet/broadcom/bnx2x/bnx2x_cmn.c
index d2ebc9d5e183..ed29efe69787 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3875,15 +3875,26 @@ netdev_tx_t bnx2x_start_xmit(struct sk_buff *skb, s=
truct net_device *dev)
 		/* when transmitting in a vf, start bd must hold the ethertype
 		 * for fw to enforce it
 		 */
+		u16 vlan_tci =3D 0;
 #ifndef BNX2X_STOP_ON_ERROR
-		if (IS_VF(bp))
+		if (IS_VF(bp)) {
 #endif
-			tx_start_bd->vlan_or_ethertype =3D
-				cpu_to_le16(ntohs(eth->h_proto));
+			/* Still need to consider inband vlan for enforced */
+			if (__vlan_get_tag(skb, &vlan_tci)) {
+				tx_start_bd->vlan_or_ethertype =3D
+					cpu_to_le16(ntohs(eth->h_proto));
+			} else {
+				tx_start_bd->bd_flags.as_bitfield |=3D
+					(X_ETH_INBAND_VLAN <<
+					 ETH_TX_BD_FLAGS_VLAN_MODE_SHIFT);
+				tx_start_bd->vlan_or_ethertype =3D
+					cpu_to_le16(vlan_tci);
+			}
 #ifndef BNX2X_STOP_ON_ERROR
-		else
+		} else {
 			/* used by FW for packet accounting */
 			tx_start_bd->vlan_or_ethertype =3D cpu_to_le16(pkt_prod);
+		}
 #endif
 	}
=20
--=20
2.14.1
