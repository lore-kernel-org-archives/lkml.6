Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474423-2-15126274342884869393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521474422; b=eU+rbDvVnfek+zYAMCbh6tit0dTe+MO2OTs7sRtSAZVQMfF
    tJiaDPh32DBR7t29v1/GdOO+VJYDYBxU2aOY6F3/8bCNhH6mbNGr8fVkWnlM0+pA
    j/+CrhSb6KZFUnyFIfV/6nDvZfwycjDmTVOzfsq0TUJ7R670WhSnoeZB5u6lZQ+L
    h2E+yUtZRwM7/jfWPKu9aew5H+BQpQD2kQ3l2qvMZkKpxLGaNM6wEXXAZkbiZ256
    T3RExmurh2AVF2/qRM+OzDyd34fAdkIS2VRN7fuUIrXDO+NxAcXiMgVq5K4Tjle0
    Nbl6rcc9jp2kMzraIOx1OOy0rPeaZOllhTa6TgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1521474422; bh=V80PdxAEzsa9TQGt27yzlcDq/j
    y6dSYH/HbvyBS4ADI=; b=wiaAfh2Vqa4aYsSBNhfw0oc2nVmUijpeNaWA5htp4M
    WCUsnkINvLWZlorZLO5HUWeFVdGXeDgeNfW/knfKkPBd+IDZEdCDrxEqBU6LXmkV
    WOOoXkBg75egz6yd0MP/v4hTLueKUmkeUflKXfhRGShGKoCiDxAt0NycVSVc2cnw
    fHN/vnHFS1bki/ZECFIDp03cE8cwBVGb3t5xvgIBrkuaYhYfW6lu+wZvPkoJe1TX
    3aZT/HzVnRlzWn2btkMXssd2P8BytAf9HduseeDXDEPverkJ3Fabkb9gTR5YGON9
    XYZ3QQeFVMPe3JxNm4gktJr04al7dB3+Mji0ZH7E2Prw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S399YsPc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeiieeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S399YsPc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeiieeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755497AbeCSPq6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:46:58 -0400
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:37074
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755455AbeCSPq5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:46:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 001/124] i40iw: Fix sequence number for the
 first partial FPDU
Thread-Topic: [PATCH AUTOSEL for 4.15 001/124] i40iw: Fix sequence number for
 the first partial FPDU
Thread-Index: AQHTv5mB6l4QKRsU6EWu8dMwqV3Yvw==
Date: Mon, 19 Mar 2018 15:46:55 +0000
Message-ID: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:G24DkAOcbnL0K0r2wWjATpo8v+sSojHP6TzsaFW7eo3Wfgzity83+sxVvOYgS+/VQfMJVdRmXoGtIFoIYo8/ZEaBMjPv0R5yToveHZFjCa3n6d8u1yc7Wf+2yIQVDSjn5bGzgdX77W3AAtUq0TUdcQJ7krYKEJWnEiCHlCJFBEcLbmn4qgpFlf5/8wnLfQq+klnjP8Pdd4RaGvWpyxhqz4I1qlBz/oXSCqR152kn+vvm9MgBNgrj4Oez4ircRoz/;20:cpTtyMUrys3Yd/1jQ2H2pcaboZc2BrXd5IUKq4fxNLp2LpeUMcK3kaLmJo1ZBAfg7lKHuN9l7c14OGtULzF/my4RerQEGw3IA2y7GBVu3UOTzDcI0zSSVzgmH09YgMTC6+l2wHFKHAkzoVV4wtZW6ZYC9Qthgv3hf8jH31N3nL0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c040d90a-b52b-4f84-0fbd-08d58db0a468
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013D7C38BA60CF7905F025DFBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(575784001)(59450400001)(54906003)(53936002)(36756003)(107886003)(3280700002)(14454004)(22452003)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dY/b3XIrWzSJkSOKvG2FnakII0r00j/mFWNJuNNm4A/zFaSSKMaN2u2wz5r2h7n4TrPVq8FL1In0fMyhMweYdMoZwSo/T1uWKXRo4jiqKfYHyfGi2qLh10on0dzAYzP3uw8p15yDULRKev5IJV0d84qy2IxRqCyhPEKYuY8XdMhwXSLYvklqJqanBI3XCe3sqvBhI6WdKObYvSvub0y+727SQv+iL5QlWonC8Z3rcwdnLyhq9S6QVLnWX2COf81NKT5Hz31lFXmQipSCkliEy7yLfg8KB4N1MiLWK2CIWZrjTW1QbEyvRl/y5quzaM+U+qfLNeNIvxa9RnPBBeIyXg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c040d90a-b52b-4f84-0fbd-08d58db0a468
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:46:55.3245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shiraz Saleem <shiraz.saleem@intel.com>

[ Upstream commit df8b13a1b23356d01dfc4647a5629cdb0f4ce566 ]

Partial FPDU processing is broken as the sequence number
for the first partial FPDU is wrong due to incorrect
Q2 buffer offset. The offset should be 64 rather than 16.

Fixes: 786c6adb3a94 ("i40iw: add puda code")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/i40iw/i40iw_d.h    | 1 +
 drivers/infiniband/hw/i40iw/i40iw_puda.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_d.h b/drivers/infiniband/hw/=
i40iw/i40iw_d.h
index 029083cb81d5..4b65e4140bd7 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_d.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_d.h
@@ -97,6 +97,7 @@
 #define RDMA_OPCODE_MASK        0x0f
 #define RDMA_READ_REQ_OPCODE    1
 #define Q2_BAD_FRAME_OFFSET     72
+#define Q2_FPSN_OFFSET          64
 #define CQE_MAJOR_DRV           0x8000
=20
 #define I40IW_TERM_SENT 0x01
diff --git a/drivers/infiniband/hw/i40iw/i40iw_puda.c b/drivers/infiniband/=
hw/i40iw/i40iw_puda.c
index 796a815b53fd..f64b6700f43f 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.c
@@ -1378,7 +1378,7 @@ static void i40iw_ieq_handle_exception(struct i40iw_p=
uda_rsrc *ieq,
 	u32 *hw_host_ctx =3D (u32 *)qp->hw_host_ctx;
 	u32 rcv_wnd =3D hw_host_ctx[23];
 	/* first partial seq # in q2 */
-	u32 fps =3D qp->q2_buf[16];
+	u32 fps =3D *(u32 *)(qp->q2_buf + Q2_FPSN_OFFSET);
 	struct list_head *rxlist =3D &pfpdu->rxlist;
 	struct list_head *plist;
=20
--=20
2.14.1
