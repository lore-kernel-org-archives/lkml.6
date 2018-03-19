Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475038-2-13353564896275363188
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
    t=1521475037; b=jVUyWWXSbXbDU6oK3lSXfe1462PrWdh9he9dfjLj5lQPDHy
    Cef3857cGOGtRnCbTFPA+WQOTbCbhPYq+0fevQvOiOSDtWSmfpyOpBV5LALyi82h
    772ACdjxdys/8mqZwEI1Ns7bdBdC9mGua4qZ4qOQ9GfBkF1TCUVMhCGByme2u494
    JtLnoi91Rv+rNpNcIH6z8JlGp1biGlb5xbd8w6mexIpaYHWNfji5pChAuqXusE6B
    4Q4VIZ1RAcGIYH7YOnBfqyOI5Fm5DVWUlBi+GIqU8MbxACoXqM3X6LNQ2panikAL
    u6+iMrAnlgmGhjWRtgPqcIRGtbFevpqWGwcXiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475037; bh=0XnfJu
    TIBpesBAwtMf2XFF/Co2bZds5DJo7X5M6a1QQ=; b=HwPz9Dcqxhq7kwXsFhbKzE
    lkPdmmJs+oeSXAdUT4CxE7V1PvY6Q3wgUjsWtVreHInKZYfKbvmjSx0P3OpEelRU
    nbccwML/sB2A9tLYST/QTt53bVF58X+FyIze2ER1/NjB9OprCOhkJqOFN66FO04u
    icTATD78+2rqX1apOgB6BZMMvFms1PT+NQ2I3jS6DRIBkSepbQj3rqH1qy3hhusH
    wT3ztVKMT6z1zTIe+BhVAZqQ4VK2Zs0qBZPAEDfVeySj6bziK65DdAKime/JxYaA
    VaKMxvarf2j2rBqk1PoQGMiRiqKofGJi1PA/RcbDmHiuOQqOUzWQQrM0vDpge3Wg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZaV2qxgz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedtvddunecuvehluhhsthgvrhfuihiivgepfeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZaV2qxgz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedtvddunecuvehluhhsthgvrhfuihiivgepfeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964813AbeCSP5K (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:57:10 -0400
Received: from mail-sn1nam01on0113.outbound.protection.outlook.com ([104.47.32.113]:22624
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934646AbeCSP4t (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 85/97] ibmvnic: Don't handle RX interrupts
 when not up.
Thread-Topic: [PATCH AUTOSEL for 4.14 85/97] ibmvnic: Don't handle RX
 interrupts when not up.
Thread-Index: AQHTv5rUUhOBDxcfrUecrUvZY7Z99Q==
Date: Mon, 19 Mar 2018 15:56:23 +0000
Message-ID: <20180319155411.12348-85-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1064;7:5EWPH7Bv5A+jeRp1/bK1aXqH/GGWGjvun6Brrg+YviIbOI3/PX1uREvVYDMXFdfb0XhSAYfBiw0dFLfONW23tXfPN856r75/tMCBq7FlIjtZAasSGgJhyqUNfOXC6VIzJVt2MbafcByiXJiq+xlsUUtUSBw+NVWdJCx70oQ2y8edyjiZsfnz7HXEnPjcyjAYpvG6X16hyuIRWdHQp57kcDfDugOaGOMUb4qVLPW3HjKAkoVlfxgKH2mxAXKtj9Mu;20:4SuNRudOxghglaqXUp7Q9efcA0wstX7msI0w6JoLyjgeWQxRyKXhtJKK0cZ1dojllvapQT2HnYZbRHbPzKsMRwfB2/zVtbvbHt1a2XGx2LGWKruPzkUnYSiAup4crKFHgBcs9OIaglbVx27sxlZOTHq33rMLdpkXqUfwQRT8qS0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9411945b-ae14-4cfa-d446-08d58db202bb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1064;
x-ms-traffictypediagnostic: DM5PR2101MB1064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106468A59B2E9B33D43DA46FFBD40@DM5PR2101MB1064.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1064;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1064;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(59450400001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(6666003)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1064;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: K5o2BFJN2+p79vts8rSnWc079NRRR85+hDXxmjTSvrinEziCKp6mpPEseXPaOMzTPb6RBcYudvxveSQx0b2XG8xYRZ8jfhOUQN3tSCqUV0vUOb2eE6BaXDAtzOmeC/+HuNxbnb5q5k/y3dEhUQ8rRfLaJZxWPFgajmnQ5jLuEm7C8XynH/rS/XPLGr/snaADDEAXCqNw+KOS9NMm4EHo8KPHHEiSqdgYUYcwxrZxvkhgPPx4HkrjyxUynqmUwZPfE0GwKNFtbIwmM/0SSQLN8LTSSFwtMR113Jal0e/V6fJhlC+b2IULBLb0zVE528o1liOg+clAyZ/sQANLjSnBPw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9411945b-ae14-4cfa-d446-08d58db202bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:23.9440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1064
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nathan Fontenot <nfont@linux.vnet.ibm.com>

[ Upstream commit 09fb35ead58cd557aa9b20576d15816bc91a4deb ]

Initiating a kdump via the command line can cause a pending interrupt
to be handled by the ibmvnic driver when initializing the sub-CRQ
irqs during driver initialization.

NIP [d000000000ca34f0] ibmvnic_interrupt_rx+0x40/0xd0 [ibmvnic]
LR [c000000008132ef0] __handle_irq_event_percpu+0xa0/0x2f0
Call Trace:
[c000000047fcfde0] [c000000008132ef0] __handle_irq_event_percpu+0xa0/0x2f0
[c000000047fcfea0] [c00000000813317c] handle_irq_event_percpu+0x3c/0x90
[c000000047fcfee0] [c00000000813323c] handle_irq_event+0x6c/0xd0
[c000000047fcff10] [c0000000081385e0] handle_fasteoi_irq+0xf0/0x250
[c000000047fcff40] [c0000000081320a0] generic_handle_irq+0x50/0x80
[c000000047fcff60] [c000000008014984] __do_irq+0x84/0x1d0
[c000000047fcff90] [c000000008027564] call_do_irq+0x14/0x24
[c00000003c92af00] [c000000008014b70] do_IRQ+0xa0/0x120
[c00000003c92af50] [c000000008002594] hardware_interrupt_common+0x114/0x180

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/=
ibmvnic.c
index 3b0db01ead1f..3ae02b0620bc 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2209,6 +2209,12 @@ static irqreturn_t ibmvnic_interrupt_rx(int irq, voi=
d *instance)
 	struct ibmvnic_sub_crq_queue *scrq =3D instance;
 	struct ibmvnic_adapter *adapter =3D scrq->adapter;
=20
+	/* When booting a kdump kernel we can hit pending interrupts
+	 * prior to completing driver initialization.
+	 */
+	if (unlikely(adapter->state !=3D VNIC_OPEN))
+		return IRQ_NONE;
+
 	adapter->rx_stats_buffers[scrq->scrq_num].interrupts++;
=20
 	if (napi_schedule_prep(&adapter->napi[scrq->scrq_num])) {
--=20
2.14.1
