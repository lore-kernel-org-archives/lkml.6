Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480385-2-16745438016094683590
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
    t=1521480384; b=BY4WLxQZs+Xzp9PvtegJ291pMX+XnhpqKYxrhnd/zBY4LEw
    NgZHg+KO4fUSQ5HAcsGACgsSuGGMXKue84qG7VQHysyV0oL7An6v3H7hxavFwZYp
    AcvZJJv5EJqH2Vz+GkNnoO83zBSl2qrXvfhHp1m1/b5b5cmSZQULfXoVTrdXb8Q7
    B5qP/sBiXIKyQIDmx0v8hAecYosjdqXfvEyG9tB6yATZmX3ZzOnUotg4SJDHq3oH
    ngVgD7b+kKCQcq3t31fa0X8pqbfey+BEowzo6fbwIt6/C7Txv5jPb2+VjCjw0Rg8
    yc1vFsUK8K+zrOTfX3e4komtRt7byCC3nekDbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480384; bh=ZgNh6m
    N33OfXn/b805JFh9STZQ1UBagWEW8cF1LpVGY=; b=L90bC6WlfzMHLLgM+auFnm
    jVWOb3UwGbYWdG5jdIL1emtUyQnyYjByPspuHSbTaXPMmfHqlDmCS7uC58sU4+ZP
    QzqcuCKW3Yi4OFIL25EahrqS6Q3e6gxpBRe4C0J9UK9b4o//NNvQ2xCvwBt0/3iT
    cWiSRradHZXdMRCI9PxfaokS32zoDmsaXS3rlRVHujja8cok8leVcuF0cpZf0wdW
    /iNu3xMzDizNs7Ev/OyAy1UCqYPRaiTzVtn7e4QSAKS5q1Lsq8Oi6g8B5jtFrO2s
    pYRJ9xswMbm3B1k5R0E7KzC04xvtsOtqC1B535HxVbW441mziU6P8yNkmmUs/rBQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OVBC3K+P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedufeenucevlhhushhtvghrufhiiigvpedvvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OVBC3K+P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedufeenucevlhhushhtvghrufhiiigvpedvvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968033AbeCSRZy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:25:54 -0400
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:41411
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965886AbeCSQIZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 050/167] sh_eth: Use platform device for
 printing before register_netdev()
Thread-Topic: [PATCH AUTOSEL for 4.4 050/167] sh_eth: Use platform device for
 printing before register_netdev()
Thread-Index: AQHTv5w6WIj0Gk5OJUyLwyM4yTSnyQ==
Date: Mon, 19 Mar 2018 16:06:23 +0000
Message-ID: <20180319160513.16384-50-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1094;7:hvCjkhWIOorZwC1mX59xvhX1F1C12FiJvAnSltpLNDCSYPrLkpVvcz8oJJ5QofB/DTdrPlGVvCBigj6KLN4ZALoqSAHBq+pIkeWC6drNWJdQdnAj0trW+rw+fXFjf9qjTSH+0MYaH6VIAUHha+eyg8iCkQkQ8MObbT6oOBAYAcGJACGVKsPNDMdPctwOZDlEdN8f/yWSKHs+Km+OI+7TLgnqPl6HQ7lOr3r6X2NSS8ZvI4dmwEX4AgLCY+3rdy4Q;20:pZG8gITDOGoIgDOeCoSOFTfBSKtysYdUIJfnpzfSBMjd3HocxawfEoFL6vPwqdf3lK0Hcv3yHht6CEG13XS1DO+nFBDJ08g3LyJDORQhet/ctCOyJ8wC19h8OdorpMGaIDJ3X3Eb5R9fZWDj4BKizrdjP0XMKfv5GXmHb9dJNOs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e298fc30-14cf-4fbd-75b7-08d58db3a163
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1094;
x-ms-traffictypediagnostic: DM5PR2101MB1094:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1094AC4319BB0CF613CA0D47FBD40@DM5PR2101MB1094.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1094;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1094;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(39380400002)(199004)(189003)(106356001)(10290500003)(110136005)(22452003)(3280700002)(478600001)(6666003)(54906003)(2906002)(2900100001)(2950100002)(10090500001)(186003)(26005)(97736004)(5660300001)(72206003)(66066001)(107886003)(102836004)(53936002)(59450400001)(6506007)(6512007)(316002)(7736002)(305945005)(1076002)(6436002)(36756003)(3846002)(6116002)(6486002)(105586002)(8676002)(8936002)(86612001)(68736007)(3660700001)(86362001)(575784001)(81166006)(81156014)(25786009)(2501003)(4326008)(76176011)(5250100002)(14454004)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1094;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: z+FZduR4VtYgnqokMvd8vH1sNDiMBrcYgjLabmCj6jFlUyU9WseeEeY7eRdthWouSIYpmzHjjjsMhWfavD16E6l/YRJ8Z8FkN93+8DO9GtrTEcvrv3alVizdpL2/cUoyJNl3IoDXBp/ZcduFJ9ONWQc2cG+Pioqe+gN4LDtqRnB7SkGex8gKxxQ5flyglEs72ECCL7HMFqJnqqs7pa7WcnUFlM/nFcLZabwZbDOQZW6Jz9VHm8i+ez4nke19gpja3aOKXico+w7+FmcOPHaSMoUbdelrE9EAxHRg8e1E0+wb8XhWG399MJB01jL9bP5PPR23+F1L85iBJi8KooFujg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e298fc30-14cf-4fbd-75b7-08d58db3a163
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:23.7699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
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
index 424d1dee55c9..afaf79b8761f 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3222,7 +3222,7 @@ static int sh_eth_drv_probe(struct platform_device *p=
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
