Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235234-2-18088004099102221489
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235233; b=Ysa+YFMF0IAzMsSSp5jVkWEPozLiJleP0/tMOo/dHwlhXdpcgW
    alsrqw9DBBX2ybfv5r/tjEMl7rj3NeO53jtZ4KK+6X2XXphJt7/EEK0ycpYCJgwV
    /bWqpD00mxA7+p3S/Dh8fwaXw4iztEgbJKriNvunKDVfIWp4Lu8A5MJphS7nLIp6
    yiu90RvQNXf/zjg3a4iyUa83d7nnKNtRbOO+9uxnEyM+F8IDnNX26LiQMyU7AD3x
    0wC+GgGM6HiCD2CBYmAhvXCF7rejfBTlb+ZpOsySKWVO4ATo65WDprew8IiFnWIe
    243VfTdigMNT1YDavc7bErHtftK3og45SpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=fm2; t=1523235233; bh=yAVfl2ip7vcDFPJXAghOUIxZOB0YyM
    kqVK+4Frdj7gY=; b=dWvPi7Q7+0zekwd3og42M3IaoRySIRR+x8AHSjfYkdoWXw
    IubMjSvIuO4xxNz0F4ac+sKcCXMnKRp6Rx+35swu60QJ7XPfZZ56Wr/4EuQR7lzg
    0JUgZcw0SjBKnM0S/wGh7vSbAbdyQqW3YCtXE4HVidJZAHMIckj6aTN7vc7q0SAE
    veHW+8kuTIxghItt0nq/kDx6/C6avNmsLOvRH5YgHbCYRvud1AgUIphn4ymLk7Lu
    LMlL3fEo2Pr1QTQV7eJI9iTRHB97bXDS2g4fzvXi9dw4ongEwT6eo4q36CEUSOsh
    RdRqhryhsmZPJpBKebC7fxFMCXx2Ruvi61Dm7Amw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WVzkCwvJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WVzkCwvJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC+a/2ucbXsngEVT1LOp1BKQ9wLJ99KzP+eqQPZsNr4yNuIQc7KCG//oSbDg4ltaNf8RFTlbHjbJtknvEbx8fRvKTcc9TmD1n18ZA4yKDLnRHI1mnnco
    2IQYvxVq+/oHMUxWkDDb7sLTK7K2Jvm0NHuh0Zv6r5IlBGpobmmMaJUkNks9U5a4uUpSXTCsvmYP1MAftanSTLxyYvAPAR/Tbpwc1w8HO2hGYF6XvTAx2ywa
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=Z5yqLHp-0Zm_W5QtMCIA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeDIAx0 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:53:26 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:29344
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933401AbeDIAlV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Johan Hovold <johan@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 051/101] scsi: sun_esp: fix device reference
 leaks
Thread-Topic: [PATCH AUTOSEL for 3.18 051/101] scsi: sun_esp: fix device
 reference leaks
Thread-Index: AQHTz5t481PvKhK5wk6/h/8S7Cl5LQ==
Date: Mon, 9 Apr 2018 00:41:16 +0000
Message-ID: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:RCj1tsS86yJLdfTNddcV3eC/6/Nzzgn8odI4m0RuHdg19mzc8i3HJhN8H3/faO9grwlxZIZ31WJ7FVjUEr88dsEIK0/CHrd70Va9U0XeFJfsaXciXNExjJPuzEIigCc8Xy1PqWobDZkk87CDejE5JvnVyyKmCvMRqYwA4iF+t4en1VqAIv3Oi8keyT1xssdAUUkFa701402SpaTUafZ/GNF2HmaiC/A0RilHoRdqlD6KZmRVdR8ZChOoX8EfNNo4;20:xNEC1L9VYt+q0eJtWV4wl7kPP/NN7B87LMtM2g1oMUDgXmQDfQgXfvc9ruxeFQeEPQcNwDbLt4nXkxQwcrC3wfNy3tvAahJWxJ2+6kPV7EUQTp7/XkztcwAzpulq7zv4zvif0fip6MfUewbFvQVKxdRowHbyZt4YjzGdJ39JvQ0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3dd6417f-647f-4030-ee20-08d59db29c3c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08702C445A9E49547D848145FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(10090500001)(14454004)(476003)(2900100001)(97736004)(107886003)(486006)(59450400001)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: BwJMRtI7qm+G2X1xEpqv9FZQGJXm5UtCRGS4T75Mkcy3pAvE7P6U4gfux3TXnfTgu6HXthfzA4AIgiHCOun6PMOViAb9eGTMsULb34W9sMRHDeSgxQzdiOPpHo/8LQ1u4824Uacz5s8z8aJfOPjNKAgQVQqQ7NeWXipK6elyuGNmNFqgHCtyce0LeunVOzbE+lW137kfVpttraMVDJGj9imJi1WQn/jN2LessaQXVjpmwpWg1BtCjdZciUpncFBtLP0k5WxlG20YOFGuMZoHvN3QvbozJK4uvdx7OvL4UXtTg4FUfjT92DSIAouNgoaCV5Hkx3/4pX0z7Yvq4SqUh+95tfxbfNyIYfMqOgZAoxxzoF3jDovEi1oCil0RJTpZOy2UGbTZrqCnf+XsdRGhwCR1EUOg+cVMWXY3PtRMprk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd6417f-647f-4030-ee20-08d59db29c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:16.9240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johan Hovold <johan@kernel.org>

[ Upstream commit f62f9ffdb5ef683ef8cffb43932fa72cc3713e94 ]

Make sure to drop the reference to the dma device taken by
of_find_device_by_node() on probe errors and on driver unbind.

Fixes: 334ae614772b ("sparc: Kill SBUS DVMA layer.")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/sun_esp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index f2e68459f7ea..6585d75bf732 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -566,6 +566,7 @@ static int esp_sbus_probe(struct platform_device *op)
 	struct device_node *dp =3D op->dev.of_node;
 	struct platform_device *dma_of =3D NULL;
 	int hme =3D 0;
+	int ret;
=20
 	if (dp->parent &&
 	    (!strcmp(dp->parent->name, "espdma") ||
@@ -580,7 +581,11 @@ static int esp_sbus_probe(struct platform_device *op)
 	if (!dma_of)
 		return -ENODEV;
=20
-	return esp_sbus_probe_one(op, dma_of, hme);
+	ret =3D esp_sbus_probe_one(op, dma_of, hme);
+	if (ret)
+		put_device(&dma_of->dev);
+
+	return ret;
 }
=20
 static int esp_sbus_remove(struct platform_device *op)
@@ -613,6 +618,8 @@ static int esp_sbus_remove(struct platform_device *op)
=20
 	dev_set_drvdata(&op->dev, NULL);
=20
+	put_device(&dma_of->dev);
+
 	return 0;
 }
=20
--=20
2.15.1
