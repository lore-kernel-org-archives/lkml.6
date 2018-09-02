Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F7EC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91063204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jgpBvIR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91063204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeIBRU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:57 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:63944
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbeIBRUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebMv3KIoQJlX1CZv1j1OKqspUClH2JsSpvHfF/6WFnA=;
 b=jgpBvIR1+env0UtsODmugXZnr1I2J02v3Cg8XAU1rdrKNXU1KVubIHOBvPVUdgx26MTJs3bXqeFvGWlcl5wZ0dmFSQJvLkmXgZbQrW0hHhALenph5EEg/KEJJ0YNmMEk99dI4RitkAoIMFtym1+pm+3RTVrwpF2q39LPh7NKgi4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 089/131] iio: ad9523: Fix return value for
 ad952x_store()
Thread-Topic: [PATCH AUTOSEL 4.18 089/131] iio: ad9523: Fix return value for
 ad952x_store()
Thread-Index: AQHUQr2MZk2FNayFgES5eT2eSIoPmA==
Date:   Sun, 2 Sep 2018 13:04:57 +0000
Message-ID: <20180902064601.183036-89-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:RUQxNsO2wj9VaVfhgYN6AeO+VH23b90eOJTO0S+KMTPH8xptsAOGAmzIF7BMjOWDZTrKQn4ngqCNn99LOLMgNGtcUlfPI7jK5Nz0RT6OhPeMXfbpHFgKGqU6/en3oAiXXuWpIg8q9G4esQyEAvRlGkbyiiwa3lePnVkYn5lcwZipSCGWk6fcVtfr6Ygh9cZkZn59KwkVpxEYkbTlt1eotu37BM72u8TCQdQDNfiEhtAKK2xf1ePAuWlCdfGi22/Nwdizn1NkuTaPDNP4Zslbg5BGmiG9nwpahPJVnoyWmpZa0kQyJpTge0miUs48JJjUQNfYZFbeqkDUYMcw2if3eFqAMAVppZ4yYum4b/7L08kEDoCg3j+GRfNeSqcGPbG5ePjJU05vx3nZQX3b8QUuTpLsDEdtWjeK3hSRN6q1SYwD/yWc5iQFTrqpDt/TVTYMtjvOOzqQ67DJug1mt7xEOA==;5:RyyZ8P3ZQSfcstpYsgDsEtRtmS+TdwCzcNAenRyvduOEyrDvhi3K1On05/O5hX2KWIhIeEydMA+5wQlIwhFvFdQOy3QaDRCZ3PcSDQCLHvSEswEIRCIR4BAaTv0XYJ8uvWjwUj8h4oCsQ/wh8HCTg3neVxpubswYBa+L30tT2Vo=;7:kPrtvkx1g0ynUtqgbYGXFHfWJZbnsWLLcSmdy0ydlKinA++Ul2oCEz0d9fb9bhTAeV4LkgKg72vpGsahzQXk/aJwa5FCiwCj2nvHQzdeBjxjesnZC+/4i5INCaDVptzzbTsAGubNlA04idIFxU5eBcbCqa2HEyNGU5tnUPVDnqI/mrmTX+bs9IXtJNEptKiksQwUs2dqc0xNJ4WvqdiLQuWbJs4rg0ISmxE7XO+XhG5ysGeUoP7AZhKLXz/mAt57
x-ms-office365-filtering-correlation-id: 12b683a1-2996-480e-7a76-08d610d4b0db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07412A3C49F1C9701457582DFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(232431446821674)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jWXF2aYSuGIlfuqYm7Zs9xlwVywydQRMdQHjOzzLSK8CawO+aRzyQh0drxtp86Ip3jdJ8UgP2ujgwxSObnvf8EALoek4myjPHi5PqH8AOpwUJWnT3w/Ch73nQ8rqQUd/kwc6z3osQRAWdsBw9Y9bseNGJnUAZWDUaUQMAKrTajBgOgmByGvVwxN6g54a7csEa5yFtx6FQny/iD7rpZ63nzuy14kIND0gDWiCcxmPvFMaB1ERaAXYmIhCqaC/+MKueHl/dYjHLIIPYfRzmtvpGIJDnLvYobyf20sw3HfmV2MXpyAMaEnG3ATO/aw3USiFQbOUct66KUDSq+BRiX5aCrvcOsU6lurtmr+BWeyIgu0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b683a1-2996-480e-7a76-08d610d4b0db
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:57.1130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit 9a5094ca29ea9b1da301b31fd377c0c0c4c23034 ]

A sysfs write callback function needs to either return the number of
consumed characters or an error.

The ad952x_store() function currently returns 0 if the input value was "0",
this will signal that no characters have been consumed and the function
will be called repeatedly in a loop indefinitely. Fix this by returning
number of supplied characters to indicate that the whole input string has
been consumed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Fixes: cd1678f96329 ("iio: frequency: New driver for AD9523 SPI Low Jitter =
Clock Generator")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/frequency/ad9523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.=
c
index ddb6a334ae68..0840288c2e7c 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -508,7 +508,7 @@ static ssize_t ad9523_store(struct device *dev,
 		return ret;
=20
 	if (!state)
-		return 0;
+		return len;
=20
 	mutex_lock(&indio_dev->mlock);
 	switch ((u32)this_attr->address) {
--=20
2.17.1
