Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521477858-2-6025067281340438941
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
    t=1521477858; b=faHY6d2WmI3M5iyjNl2SPO+93kswKZltufyJu0N3yLrTZ44
    iYxtKyeHxYDHgu9mpCtJOqX9m3iuVtu0phKEA/tHvLs2xuqyykCJX/jeqwxRyulm
    p3yEN+F+jb6iAvnP7EItGKlfqKbrPYxmcve5kJeBL2goKpHw3T+CxyRghAXqZu4/
    Xk/4P34sJohZAh9wzdRLVVaT/I/xGJvwtmr4F/phU2MJRAmU5pDMnFsSQP4x9bHN
    Zh/kPR2f+dtqLKVjhjSxc/gJrM4XxEz7Fse6Q8bid9vlgdDtOi+5GjlR71VIKiU2
    YgyeJa4+9OYLVcqA7taM31IaZxJmqZVCt5DAxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477858; bh=11ZV6+
    mJA0y8HU0oCWXRo5LVVOBLq15+1Y0WrpkDIlg=; b=ZhvxWdXDAWf0M4p02su94F
    PJu+ChQU/+xb0uCH4/CaiGVTMuuH6iN7Jr5D2BeV1dQu4eYwdCLXV+I9eZji+eYk
    PA+oC3VTr9cMQWQ/UMRILhlBpcLcWlY3w67uBVBg19z8gCd6RPvVYh9G3nvj0UuS
    CFtGL1c81F42hkBkyW7d8cTAW5/M7b1mF+zv9p3Q1o0ZkoqXuKOVxoyQhCZ44AK4
    FpJPW6dS3MeKQWPFX6LzvpzAyzTwVEUnXUHTCGTSFYJQMLoOJb2Jrirmij9huswL
    qOPPdBCxOcYtXNUC/OvIW7ogWMXb138C7lin6F+Amv15l0GttVovgh54mlIJmTug
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hrIRwSgf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegudejnecuvehluhhsthgvrhfuihiivgepieek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hrIRwSgf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegudejnecuvehluhhsthgvrhfuihiivgepieek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965463AbeCSQoD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:44:03 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:30227
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934127AbeCSQMX (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 033/102] sh_eth: Use platform device for
 printing before register_netdev()
Thread-Topic: [PATCH AUTOSEL for 3.18 033/102] sh_eth: Use platform device for
 printing before register_netdev()
Thread-Index: AQHTv50HPEjBE1U4fEmFZtxB13Bj5g==
Date: Mon, 19 Mar 2018 16:12:07 +0000
Message-ID: <20180319161117.17833-33-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:KyTt0Rf8y4Sw00oCCtwH9T43gZOL0bV02kyUX6INPBW77egtcevX+kb+URChcSeJ+fLlNGrRvRZef/2YN1c9M0CiP8eOtvjXgE7af92L6UnHryUlhDUEtpV/Ia08vAyeaUwYqpiEZDbJ4FnchKGCV+GM9u6ZB+ldkBlFVJTx2ubTZv/R5SXUP+fCEnC8cJqiWk93WmlZ4Y6uO/apJvMzRjM1IA1XLyFtmIJ+Qg1epzwoi8sVasxg0cVnQ5GP4JZM;20:amiafqjcJeG2pomRyIAVx7VjTEHPw2Wtpi4ZXCey8RP3NXnRtHYIp2Xb9dw11T1BEU3lDxLkv6ngMSX39Uvxw4ozzKj95s3kSZJEp4k2Jk3YNizZPrTFRv+qyf3AjbvfJJKb/hcIOOdCyO2BQSHdkT5GYaJRR4821AohyvcnZ9g=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69871cb3-1ecf-42ed-cebf-08d58db42b84
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB092062462B1EB77E920BC7E5FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: x1TefWXxm920MNBjppDfrAxff90npcJ4nWRStNAQYVuwduI240eeoOLJOdAa7bODZLOKddMzAScVR2NIPUfZQOxEgQSw06GbLBtk6k1sfE9u6HusirHHNGubwlNVdvcF4jRkc2h2lgIME0FZlJ+oTipx7GzzOHf3/KYiktSB7ra6Wc+4ygA4Q3eWUwUWPFgAxwhwmeta1GIMiyl07q/tAf+GgGrjR5DvKXwvC+1/jO+rveJJ3uDeCBnCQfDutdKVkycH4DKZfEwA4zASHf7PcVyl4Ko0WbWiul0quarcAJ/2dxhTpEqbXAutsvbH341owIv4qE8mnk/Vievly50lsQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69871cb3-1ecf-42ed-cebf-08d58db42b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:08.0028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 5f5c5449acad0cd3322e53e1ac68c044483b0aa5 ]

The MDIO initialization failure message is printed using the network
device, before it has been registered, leading to:

     (null): failed to initialise MDIO

Use the platform device instead to fix this:

    sh-eth ee700000.ethernet: failed to initialise MDIO

Fixes: daacf03f0bbfefee ("sh_eth: Register MDIO bus before registering the =
network device")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/renesas/sh_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/r=
enesas/sh_eth.c
index b89d7c16991d..8f3f692942d8 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2933,7 +2933,7 @@ static int sh_eth_drv_probe(struct platform_device *p=
dev)
 	/* MDIO bus init */
 	ret =3D sh_mdio_init(mdp, pd);
 	if (ret) {
-		dev_err(&ndev->dev, "failed to initialise MDIO\n");
+		dev_err(&pdev->dev, "failed to initialise MDIO\n");
 		goto out_release;
 	}
=20
--=20
2.14.1
