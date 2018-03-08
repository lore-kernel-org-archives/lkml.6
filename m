Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485332-2-9071701588802036692
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
    t=1520485331; b=ZZ3f6YE0oPcXnHRByUbEF1LIdyMOROymV1NVMsrMAG6GtaV
    VF/DJFBpD8Oep/Fk0fNHkgHvyaG3JVW4aEzHtexAgjvIbplI6NuF/z6gQcQO7ogL
    Z789AKqFR3feUvPEqkBs+7D4SfvdzaSVWeZt+/wAc9WDDc22QE+ccl1Cv6Z4le9u
    nKp2Yxg6gdxCgeImEUTmjRc7rf9DGJrxYHpoIledyn8GoD6skhSlP6ZV/I0BNuTk
    cxkNiyb9erqmGLtQatbppSh8e3UeM6azktRaKut/UYUatgVBaaQzCd9pJu56O0sx
    fXH8DJEqR4wwtcvz4ZNvqEJbuNJ7ohRLOMviIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485331; bh=IJD+Tw
    clG8nL8JkaoNhJV7i602YKCe0IugbcC4RmgIY=; b=MAxSthTguYe5jYxXW6An+/
    qiuAi9oY8jU3CNu31LhOl79nScA2XPvPHXT6EUBDRKam29cd1I6yZPk1YSpYCpF9
    HibwcXC07aS5ymW2DcI0fQza1lWAIH32/tqTCvj32M/pD0XjKRBh7taki+58Gn8f
    XG8kgunW0bJ68H4a3uW3vawTUwY3MUbz5wjx0v3BbxobAvvLoKK6Jyy+ImvzQ7Cu
    I9OiPnLo06F/pLBxA99Dp9NrZ0viqm0/vvdb5dWrLnG9bRf54pJMu8M1HnnTFIMZ
    7dC6H7Sggmy4aknsnz2UVjsEbOM3oj5ZdDoxzjMbVDqdubyRQUVi7hB0VVz9AdPA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eR6cUiS/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eR6cUiS/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeCHFCK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:02:10 -0500
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751441AbeCHFCI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 091/190] libertas: check return value of
 alloc_workqueue
Thread-Topic: [PATCH AUTOSEL for 4.9 091/190] libertas: check return value of
 alloc_workqueue
Thread-Index: AQHTtpo+4XbcEcDFakaKOeisNLaxQA==
Date: Thu, 8 Mar 2018 04:59:31 +0000
Message-ID: <20180308045810.8041-91-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:1PLBXkJX4W/ZPyBJsKqM0I+xxUAJEOQbkkaGeFl/3c6/UwCPT0jRNMrCo1nQmGg5a1zRZ9B06Xn7uUwylyr9avNCB6fEInem9VgR3wv9t6zZ7x6s6vw2ylrGuOctZysYXDIsvmaB5l8q6po3O+cHscLYnjS68cl+mckAUBe9Zq5w13vW9oFy1a3o0Tk5WEpLBYhByffOo7VcLrP2LJXB8eOjS9ue5fbQwSefNor/Mdt8THSKL6JnLzY7sJn9iALR;20:P2R4e64brT+siU+BO+meZRC0uAeYT8+EPjd3uuGV13eJ0dUoMs2Vrysaat0YbDv+T574RFjBopVkLG/5pVCbe6Ibi6HnRcw3ye+JrKuwUoygrns7kBFgGdbBpm1kWZOwZ6iAikD1Hez6p1EdzzoaeQdXQGkJPme/4844RstQk8w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5bd27420-07d8-47d2-37af-08d584b1bd3d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063EB785195711E9AD0C0C7FBDF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(51234002)(36756003)(186003)(2900100001)(6512007)(3280700002)(6436002)(110136005)(102836004)(5250100002)(99286004)(54906003)(2501003)(25786009)(26005)(4326008)(2906002)(10290500003)(86362001)(76176011)(6116002)(3846002)(6486002)(68736007)(106356001)(1076002)(22452003)(2950100002)(72206003)(6666003)(14454004)(478600001)(3660700001)(107886003)(59450400001)(81166006)(105586002)(316002)(66066001)(10090500001)(305945005)(6506007)(8936002)(7736002)(53936002)(81156014)(8676002)(97736004)(86612001)(5660300001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ugN7ecjdLcM+xo4i0vjRzH8JXgCvz+9zxO9LKCpYouk2Ck7lXjieyg2bwCate1BdObJDpOZAgT36o/hr+B74Wd5xsYrpwBDELDhou2qYb3OpyxcIDKLvANoD2AzZHKW2fpoy3g2BDI/osN7rFWyHPw9BTRZJJvwK1foMJamSYGDFhiWXwzK591YKxYOucAi1SDlyN5JrOfP59oLs4YHkL0hHUH7Y6Jm/EYFbtOj+XRkiIZNech09H7m1ZvcUlcMcPSPD92rKflG1WJztcXNpwbwVqQ2xfqyQH+s+UIJx+Lb/wPKCpEir/HVuBAuKHxxJsIE/03p5pjtweRPeYoXxlQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd27420-07d8-47d2-37af-08d584b1bd3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:31.6993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit dc3f89c38a8406554ffeffa370aad086a9c5e9de ]

Function alloc_workqueue() will return a NULL pointer if there is no
enough memory, and its return value should be validated before using.
However, in function if_spi_probe(), its return value is not checked.
This may result in a NULL dereference bug. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/marvell/libertas/if_spi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/if_spi.c b/drivers/net/w=
ireless/marvell/libertas/if_spi.c
index c3a53cd6988e..7b4955cc38db 100644
--- a/drivers/net/wireless/marvell/libertas/if_spi.c
+++ b/drivers/net/wireless/marvell/libertas/if_spi.c
@@ -1181,6 +1181,10 @@ static int if_spi_probe(struct spi_device *spi)
=20
 	/* Initialize interrupt handling stuff. */
 	card->workqueue =3D alloc_workqueue("libertas_spi", WQ_MEM_RECLAIM, 0);
+	if (!card->workqueue) {
+		err =3D -ENOMEM;
+		goto remove_card;
+	}
 	INIT_WORK(&card->packet_work, if_spi_host_to_card_worker);
 	INIT_WORK(&card->resume_work, if_spi_resume_worker);
=20
@@ -1209,6 +1213,7 @@ static int if_spi_probe(struct spi_device *spi)
 	free_irq(spi->irq, card);
 terminate_workqueue:
 	destroy_workqueue(card->workqueue);
+remove_card:
 	lbs_remove_card(priv); /* will call free_netdev */
 free_card:
 	free_if_spi_card(card);
--=20
2.14.1
