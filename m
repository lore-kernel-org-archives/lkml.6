Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CF4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A845B2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A845B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sma.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeIDURz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:17:55 -0400
Received: from msgsrv3.atosorigin.de ([194.8.120.225]:27549 "EHLO
        msgsrv3.atosorigin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDURz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:17:55 -0400
Received: from unknown (HELO julia-mo2.ccsn.de.ao-srv.com) ([194.8.124.179])
  by msgsrv-out1.atosorigin.de with ESMTP; 04 Sep 2018 17:52:10 +0200
Received: from julia-mo2.ccsn.de.ao-srv.com (unknown [194.8.124.179]) by MCS02-MA1.atosorigin.de with smtp
         id 2581_0bd6_0c1bd5ab_be3c_45eb_ab95_359bcfb3c0ce;
        Tue, 04 Sep 2018 17:52:09 +0200
Received: from julia-mo2 (localhost [127.0.0.1])
        by julia-mo2.ccsn.de.ao-srv.com (Postfix) with ESMTP id 476EBA9BFA0;
        Tue,  4 Sep 2018 17:52:10 +0200 (CEST)
Received: from MCS02-MA1.atosorigin.de (mcs02-ma1.deuser.de.intra [194.8.120.181])
        by julia-mo2.ccsn.de.ao-srv.com (Postfix) with ESMTP id 0C3CDA9BF9F;
        Tue,  4 Sep 2018 17:52:10 +0200 (CEST)
Received: from SVR-DE-EXMBX-01.sma.de (unknown [10.99.42.82]) by MCS02-MA1.atosorigin.de with smtp
         id 6882_06e2_8c5f2d9b_ff46_416c_bfba_efd4aa8cd42a;
        Tue, 04 Sep 2018 17:51:17 +0200
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (10.0.42.37) by
 webmail.sma.de (10.0.42.161) with Microsoft SMTP Server (TLS) id 14.3.389.1;
 Tue, 4 Sep 2018 17:51:17 +0200
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (20.177.35.208) by
 AM6PR04MB4744.eurprd04.prod.outlook.com (20.177.32.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Tue, 4 Sep 2018 15:51:15 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::5043:318f:f53e:d549]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::5043:318f:f53e:d549%3]) with mapi id 15.20.1101.016; Tue, 4 Sep 2018
 15:51:15 +0000
From:   Andre Kalb <Andre.Kalb@sma.de>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached
Thread-Topic: [PATCH v2] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached
Thread-Index: AdREZxxSehcX9yb4Tui0YlbCxpETAw==
Date:   Tue, 4 Sep 2018 15:51:15 +0000
Message-ID: <AM6PR04MB52394FDB1266388BCE1374E3FC030@AM6PR04MB5239.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andre.Kalb@sma.de; 
x-originating-ip: [62.157.91.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4744;6:3dLmK+E8uLTwqwJG1l9ISMs2L+2AseyrwfHiIInLauWNvckXj5eTaUuJoORrURiRFwgosv6TuVYHJ+mHTL29Qb09pLOo4zlZICu0Gd4czxwBJIvsZ5DY/jEMAsWjlzL9Nlclr+K1YUtC4qeG4y7cEFUCu81X1Drar1ulpCmvfs6jfshn1nSsTl4Bb9tkJ854Sl435x1kjVEf4IN/cEUudEq60nZcf8zFn2evDDeabw0jNwdXKhZ1xbwBUOjYg4XVvWBhrkD9Hc02fRM6hBUD7qcq7R7CpQaVJafQtk0luftnMp9CVEZ0h0B3veZFemGHlpCl9urApJSqGMwmHlIbPlkpb0+KYS7Lo3ZTISADfb/ABA4HvYfXWbsHGVkhSwHCzuj1fOyrtOzlZG3IFW7ViNh26retkdZCk+uVaA83pXHJposQyWe5r6t/jvS4REwbKQSoISr/FLoF8qRdiAeCUQ==;5:RnIKzR7uC+xXIR+/d2i0Ombp4bnlNNIZDgnXepBypgcJDZ1OKRcybeqdP31lp4apUbvLE509U9WvOxhaREESm/zdxdy1qYPxvBbkyp4E61brRSVEoKcelEmt4fW+8SuCPRQA1JOawaUGpI1iWSr/83GtovTGMYvi+xKVf3kmCUc=;7:RYmZEmtVLt/uKer04jWSVLbEF+wAd7BvLuj1l9py13ZnUF5awdHPHku2U3xpPUweRrYXgDwOXHtnls45e9/TGmZI+S9fKv89/qJzfHzaW3p0/rqnvSlwzLBpqmTDOvXb5hEe33WFbXQYqNJUpUOQwnAnPteL5jdeVegOuH4a2hayoil0VhCtP12VWvanAmprwMVRS6iBHoLzGSmp2SChSOG+8JMRJE0pHc8ppcrHkHUPO71E/eENNbsmejgmPfuK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d6d23e43-be77-4188-294c-08d6127e3f68
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4744;
x-ms-traffictypediagnostic: AM6PR04MB4744:
x-microsoft-antispam-prvs: <AM6PR04MB47443773CDE6A8A1F1247DC2FC030@AM6PR04MB4744.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:AM6PR04MB4744;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4744;
x-forefront-prvs: 0785459C39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(6116002)(3846002)(5250100002)(186003)(305945005)(7736002)(2501003)(75402003)(316002)(68736007)(74316002)(110136005)(102836004)(2906002)(8676002)(39060400002)(2201001)(2900100001)(7696005)(99286004)(86362001)(575784001)(26005)(14454004)(33656002)(105586002)(5024004)(14444005)(256004)(25786009)(74482002)(5660300001)(72206003)(8936002)(53936002)(81156014)(81166006)(478600001)(66066001)(106356001)(55016002)(486006)(9686003)(6506007)(97736004)(6436002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR04MB4744;H:AM6PR04MB5239.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sma.de does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GcNgf8KF0tGx5eJeQ0neTHVTHPZjORrrOrRk1irK7h0B1FzvXALPx3dK57MsF+c6UhyXhle5RuJHHs8PiR+8KJThnB0Gcv/1t+Sw+nU4CCWRR8vwhH+pSjwKBGGp0d/F8ZYOGSZaF88BJlxFPGd0fRXSMGbws4wuL4DH7CGeWS/uZ1lim8VE+zeSlmvO4rB+0ekz0C7PHkUHt1N7a0/RzfVYffdA80jram7th8zzlQy8O0Iiq3rbt76zqGL4ArYUt4AATpIEFE5PHG6bpE70Z9UnNEyVSIurHuaDVKC2SItJUxSyKe7TaDlMuIf6RcH2+xae7GwIzgRmSF43yACnELFzjbpYKiNywlEBVUWtIbs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d23e43-be77-4188-294c-08d6127e3f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2018 15:51:15.7380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4744
X-OriginatorOrg: sma.de
X-NAI-Spam-Flag: NO
X-NAI-Spam-Level: *
X-NAI-Spam-Threshold: 8
X-NAI-Spam-Score: 1.2
X-NAI-Spam-Version: 2.3.0.9418 : core <6366> : inlines <6851> : streams
 <1797484> : uri <2702983>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent warning "kernfs: can not remove '(null)', no directory" if an overlay isn't applied to the active devicetree.

Using of_remove_property and then of_add_property doesn't show the warning.

Signed-off-by: Andre Kalb <Andre.Kalb@sma.de>
---
Changes in v2:
  - Fix typo

 drivers/of/kobj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c index 7a0a18980b98..962b660e8ad1 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -104,7 +104,7 @@ void __of_update_property_sysfs(struct device_node *np, struct property *newprop
                struct property *oldprop)
 {
        /* At early boot, bail out and defer setup to of_init() */
-       if (!of_kset)
+       if (!of_kset || !of_node_is_attached(np))
                return;

        if (oldprop)
--
2.17.1


___________________________________________________

SMA Solar Technology AG
Aufsichtsrat: Dr. Erik Ehrentraut (Vorsitzender)
Vorstand: Ulrich Hadding, Dr.-Ing. Juergen Reinert, Pierre-Pascal Urbon
Handelsregister: Amtsgericht Kassel HRB 3972
Sitz der Gesellschaft: 34266 Niestetal
USt-ID-Nr. DE 113 08 59 54
WEEE-Reg.-Nr. DE 95881150
___________________________________________________
