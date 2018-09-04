Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22508C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B431620867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B431620867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sma.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeIDPzE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:55:04 -0400
Received: from msgsrv4.atosorigin.de ([194.8.120.226]:8282 "EHLO
        msgsrv4.atosorigin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeIDPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:55:04 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2018 11:55:03 EDT
Received: from unknown (HELO julia-mo2.ccsn.de.ao-srv.com) ([194.8.124.179])
  by msgsrv-out2.atosorigin.de with ESMTP; 04 Sep 2018 13:20:21 +0200
Received: from julia-mo2.ccsn.de.ao-srv.com (unknown [194.8.124.179]) by MCS01-MA1.atosorigin.de with smtp
         id 7d96_032f_f3c41c26_034f_4bac_a570_670c556e497b;
        Tue, 04 Sep 2018 13:20:21 +0200
Received: from julia-mo2 (localhost [127.0.0.1])
        by julia-mo2.ccsn.de.ao-srv.com (Postfix) with ESMTP id 7ECDEA9BF9A;
        Tue,  4 Sep 2018 13:20:20 +0200 (CEST)
Received: from MCS01-MA1.atosorigin.de (mcs01-ma1.deuser.de.intra [194.8.120.185])
        by julia-mo2.ccsn.de.ao-srv.com (Postfix) with ESMTP id 61AD7A9BF9A;
        Tue,  4 Sep 2018 13:20:20 +0200 (CEST)
Received: from SVR-DE-EXMBX-01.sma.de (unknown [10.99.42.82]) by MCS01-MA1.atosorigin.de with smtp
         id 1195_0bf4_2ada0968_3fcf_4d16_977a_1ab232aa06be;
        Tue, 04 Sep 2018 13:20:15 +0200
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (10.0.42.37) by
 webmail.sma.de (10.0.42.161) with Microsoft SMTP Server (TLS) id 14.3.389.1;
 Tue, 4 Sep 2018 13:19:37 +0200
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (20.177.35.208) by
 AM6PR04MB4486.eurprd04.prod.outlook.com (20.176.242.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 4 Sep 2018 11:19:35 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::5043:318f:f53e:d549]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::5043:318f:f53e:d549%3]) with mapi id 15.20.1101.016; Tue, 4 Sep 2018
 11:19:35 +0000
From:   Andre Kalb <Andre.Kalb@sma.de>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached.
Thread-Topic: [PATCH] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached.
Thread-Index: AQHUREDltYQrhuDetEKt2A++ciUohaTf+YWg
Date:   Tue, 4 Sep 2018 11:19:35 +0000
Message-ID: <AM6PR04MB5239B08D03B4B4678818D41BFC030@AM6PR04MB5239.eurprd04.prod.outlook.com>
References: <20180904111739.399781C210C@fedora-nb5693.sma.de>
In-Reply-To: <20180904111739.399781C210C@fedora-nb5693.sma.de>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andre.Kalb@sma.de; 
x-originating-ip: [62.157.91.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4486;6:3yxqK6tYypOgh5+HewZQJVr99q1vPmXidhCuhFuKdTQa85l7Hgm0lQ8eUoDurlua5f87goN19FPOhQRToepqMzgnxt9Fp/v8zfdzJlg9pAIyddqvYEjdfkDokDXbkfiHlJ2yKsvKIaMueJY3vBrkV6RWFnHwtDUjcFRk9pvIbV4QixjVvbU/e5+ua66ThVO+vBwOlVVtdqPX+5lf+OxwDccIcu94xa0zFb9qqFke2Vbr49/YHtW0gbQYKuwv1Q1zgj5WvGJ+kejRZPN61T12VyblaAaqVW5x+SoMiISN8EuQI3P6vEpdzwYpRtPTyOC06ypDDP6hDmhLdYcYisp3sIL4o/iViINPT8spPQhOqsZHvnZEEI3ghJkGOKC/83VxaOHXtawN2/7btMaaH9bnRBE4X2/BR0SQHPkJXHoVyn7bUPD4B02srJKbnC4PtTb/zyz3EXJz+s5nK5Kj9M37Cg==;5:36B3aFalLS6Y3vifgOkwFYvSzVHso66f3Oe4If4RFmxp/vu57TGhZ/d7qoKOgewpBoEbtU/H9Ca/ISEVEksUaC4fWiz3JaBN425oJQ9vZ7jVXhuTEytsI+l+OyOGg4PPS7YLejQfT6qgoKRbYoxW6kpO+MkGPTTYgmAlA58dPEg=;7:Gruhyu6AiVMMaQqItoYna5B1UBJEsS5KHAr3qqYuCIu1y9T9sKbKeZCoB9jHYkNk3sDWmZbb46o4RCfESqGwOLsoR3xQMKsn8lCat7cwCU4s7CaMiRGD0wvZf8zq2CHw4p1SSjUG36LYWKta4FaqZvHnJiCMHXOI2G4uHZeAhyAIRT6/ZuzXCT5CReP8wrWSwn7VVmbvu/7w7ZulJkuIC6XwyjySbVsA8cqYS/GIwsEgoGx3vcNVPbuJ6cRWAAiS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 35abbcd5-4af6-4d0d-a4d4-08d612584b95
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4486;
x-ms-traffictypediagnostic: AM6PR04MB4486:
x-microsoft-antispam-prvs: <AM6PR04MB4486779A44C5A4658C240124FC030@AM6PR04MB4486.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:AM6PR04MB4486;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4486;
x-forefront-prvs: 0785459C39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(11346002)(478600001)(68736007)(66066001)(81156014)(81166006)(53936002)(106356001)(110136005)(2501003)(316002)(2201001)(86362001)(575784001)(6506007)(25786009)(72206003)(8936002)(486006)(14454004)(5250100002)(8676002)(476003)(2906002)(3846002)(6116002)(446003)(33656002)(39060400002)(97736004)(14444005)(5024004)(256004)(7736002)(26005)(186003)(305945005)(99286004)(74316002)(102836004)(75402003)(74482002)(2900100001)(105586002)(9686003)(1857600001)(7696005)(76176011)(5660300001)(6436002)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR04MB4486;H:AM6PR04MB5239.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: sma.de does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZeFzAyucOLHyI738brZR27PYlXkD/z4zCGJEPoONdEvi+67IDRJKrOqGCVtIlocXOWJkDDeLKb8VB7ZHtbcaRr6qn6hTBs8X6hbh+/9oszU89grF5qsEDg9V5N1yHypkqvQ52N7bo58LkpC/cDL9iXo45gGt0JqnAWjUE3PIlxm/oxIWF/tIbtZKMcu2DofBaMMKGtW33BXyVQ+XGH3YGP9dZQNQgamAlUFqcx8CSYTVl1/Jj2jkwqfB01y7cGmztU7bymGxy/YMSfDdhiVY6jpzCQNEgSju8QFqgtbnKVLJssk+74SDkAYLOVimMu2f9yp34fM22lsIv4b22PlX2UENMir5U5vFR6XBRExuaUo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 35abbcd5-4af6-4d0d-a4d4-08d612584b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2018 11:19:35.3086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4486
X-OriginatorOrg: sma.de
X-NAI-Spam-Flag: NO
X-NAI-Spam-Level: *
X-NAI-Spam-Threshold: 8
X-NAI-Spam-Score: 1.1
X-NAI-Spam-Version: 2.3.0.9418 : core <6366> : inlines <6848> : streams
 <1797466> : uri <2702823>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent warning "kernfs: can not remove '(null)', no directory", if an overlay isn't applied to the active devicetree.

Using of_remove_property and than of_add_property don't show the warning.
---
 drivers/of/kobj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c index 7a0a18980b98..2b71e5979580 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -104,7 +104,7 @@ void __of_update_property_sysfs(struct device_node *np, struct property *newprop
                struct property *oldprop)
 {
        /* At early boot, bail out and defer setup to of_init() */
-       if (!of_kset)
+       if (!of_kset || !of_node_is_attached(np)))
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
