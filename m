Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523237029-2-10810520730694907938
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237028; b=NJH1hAzmgkY8kNk4fBVyoQhKuOFMcSUIw6dKSFnjLsAMwt9QTx
    Gq0QgH3qlm68t6nMk3GxGG6Ver4luQXQV+lUUQRX+Bv2k0ls6sBnc8wat/i5NfiD
    bBleNtQ8Ot/5H4VAM/jnGs35uOVHwfUchQjSkdqLsBVJRnjKAzcSbKUXRZLecndt
    8waEX7Bm45O/e7Ihtrr2CkXauQefnZOdEn2zhBM4+Xg5Y9b+OxgN4YUGrR/p8+uQ
    HEx1gGkncuugO1SU1oUa415OKnbVAvpl1OQrulFYgIQVokntcWQlJlKwGGRFBlr2
    ey/eZ86Z0Ftdug54Ts5GUnHmsVP9RnyvyLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237028; bh=PMh7TcrKyr
    l3BAqELtodm9eWigni+3eH3zn+ZIestcM=; b=VyJWSVaxfs/RjbTf4f8jO16b2W
    Wyk26sqYCMKPUyz5d+xb+0u6l58SsYfwsK4h6BJVs7a2e6HtXc+cQuANNg53TwTS
    bnEL7BH9xADVaFngzJjn0CFrLj1PX3s+e3i578Qhu0XQ1mnLnglrrFMmPioaHfJ5
    IVVyoySHNsllzbiYlTR3YDPzQnkl8q/ip8vxP73s5YUqo9qA94MRBL+sMLVLibv+
    qkB2jZ2wYk88hvBhVKY9qS1T7jA2YNqHHdvPA8CzI/7axsmeFsIx/D+GhSIitL7Z
    ZYr8f1GEN2bJDXDER/yWR+Ktch1BiX/RQir9WjRlgyscbV1ZZE2uvPBaEchQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QesipJ7c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QesipJ7c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAwEu4JTgHxRX0cihbLTTZgZaRL49NBGgGDLduw8TaeyiyTgNmGvUq/OgT8TkerVJ5IHURtnVNKuzcrLQjJHkHhyF5EIzZQGnINjubzK2CJbJTpHdcTB
    0fkh+f1QJltxRx/bKiD6VUKj0VPOSySIOvOFuoTKvEtlsE3F8grePZB8o4ejgKrI/H4axdz+dCoSN25+zTO7lgQaL8VRpmH63/Wn5UjcY9alULVMuT0CuPHt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=Z5yqLHp-0Zm_W5QtMCIA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755610AbeDIBXA (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:23:00 -0400
Received: from mail-sn1nam02on0113.outbound.protection.outlook.com ([104.47.36.113]:53303
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932727AbeDIAhF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Johan Hovold <johan@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 078/162] scsi: sun_esp: fix device reference
 leaks
Thread-Topic: [PATCH AUTOSEL for 4.4 078/162] scsi: sun_esp: fix device
 reference leaks
Thread-Index: AQHTz5m1mPzBILJ5/EKmfT3f7bBSaA==
Date: Mon, 9 Apr 2018 00:28:40 +0000
Message-ID: <20180409002738.163941-78-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:ZmwHRLu4cWxBbakFfDvncGw2Ps/dQTWq7uGHK7PgLnl/uYTBIbj0PrZVxyulkLH55fQJm2Tv5D9SPthCtsQWdbvyCVD6ueCKmDXpyd0S1N87mitUjJiXGs//aZyq+tswIivzoRu/lksnBRWgB6scsFH892yOFc46XTsPjQ7En/Cv6aa6Fh3ATyOa3N5CXB0/zmCo7IJLCleHmHB3uPZOmh6aFKnQMdJeLOaakOFlV6Ip358jPCRXoicytlMqWxIG;20:l3UkblJmrruGQsc7/TVLsBEz5R3+XuwgmANjZB2/JhugXwDpxrovUweUdkuINONn36x3fkG1zqefXZnsTjJheWwRPLgELDf9SsHPYd+y/tfc+YwK3kaqXBIqlTTbq6WQbCeiUpqaoNHbEwgFUbsvEgYnFt77oxlGIAhLAzvRU1k=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ecd1bb3e-8237-4d45-f085-08d59db201fd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885EE763746EDF179016828FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(3846002)(6116002)(59450400001)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2Okpc6yXJ39zOnUrE9M3nbBclnjhPvcpBix8GeDzo1HVXENogQ5XDG+pQ4k0doj/DB5ig32szv3uyoQFslHgtyzVQe5kxSNxx44TUVtQhSDgwa24D0lZDibRHIy8HuIr/BLUEJQbQaAtUPRKZg89Pih+LxSDpUcGXsHo+V84U6AAnEs4rEzCT4Qenc+biVTNwY13lUkWrdD/YInEzOc8MTHv1JcsVHmAMJgj+qGlCw5jppgZXtB6bfk1vxPzIMYWZO4afEfj8ODdejPssXmrOurHOA4nuTneudRnlJzZcfoDtAIQ0F0HqSX7Casikcv2+gfMrxne2BVvOcBXvc8nka59v+PtR0kHMj0tQi8Cv2O/aRHh7ibm7H7WAEseWFpwsu9wvRgegRUiBP2K+p8h/I/ifmqTF+9nHw9NjwG2uBI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd1bb3e-8237-4d45-f085-08d59db201fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:40.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
index 7b6d4c2087d7..747ee64a78e1 100644
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
