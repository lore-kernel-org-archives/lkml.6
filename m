Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE54ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE5E214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M0MYJ5As"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE5E214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbeIQIad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:33 -0400
Received: from mail-eopbgr690116.outbound.protection.outlook.com ([40.107.69.116]:54124
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728636AbeIQIab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te13EQMPL0Cjl0U81RzvaTxP0ClVC2mD4OsTYNF6Qfo=;
 b=M0MYJ5As2b9fB0mcMA1CK7AsMt8ghSxcIgb2FUY83ow92LWORY81smOQaeme8GOmExqa92gUDalhi/ISsmBUqR06bzPjB9F5C020twYRgdhemmL2aIw7lt5wOUVt/bd/lanZHIQyw3uP91I8iWugw9CfqBVYx5CjqMhHAg01DUI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 85/87] iio: 104-quad-8: Fix off-by-one error in
 register selection
Thread-Topic: [PATCH AUTOSEL 4.14 85/87] iio: 104-quad-8: Fix off-by-one error
 in register selection
Thread-Index: AQHUTjL8vcR3rNhI40ev+UGOLcItQQ==
Date:   Mon, 17 Sep 2018 03:03:18 +0000
Message-ID: <20180917030220.245686-85-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:FfQUZCq2Ww6akGh//NSwBhl2oB0xrj5aKLvJhH2hSqYEuxSb4gbzp7mV8I9GTbXc+9Hb0y67FP1KbV/OZOswvSIqnMx1ubSw/Tv3SGUKjlwQjHlvYRiPwmLFq/Wx2R2/AKWZJeq9f6V3Q8Z35iMwZVJI0TnRq1AD9BxF6Vl/ZbnUQO1CBpl5BHcnjS04nLNggTtlTf2EnHmZiafDQtB+NmUiouEuS7mhkRSX0ub7X9kOVK6m2ejTi+9kvbd0xoubSVywLMmpySdhGQIiFpsjSblY56ZyljSPqxzIl0/fPgJ7jEUPL//ufN6P/FksFWqMh8wE/A4MUmQszYgD5Otn2+6paf+CeC38wArJe/YdwL0G6Kyu2hmPqR8pX7Z+o1REZgXK8wtXcSPY6Kohih+0S178zbyKfHDXIEUakCWEbd90ntJX5wBvW/HBXv24YE38DHj4p6rzM9IyjRdsUGNZow==;5:sTbl57/BlRyDGevwpBeqIE3xsZldYvyD812IA8Upjgzb/YtwJuVCzvj4D+qosiNGTOIcsoepaY172VPHXsoHxdOfLQUFFFQDDWVrdUjmkrGACMs1NJXqjXF5vYWXHVBhodM+sf2frmb9gS0DzixFftTE35F+UAxTYSw5onQYCeI=;7:3FxSmPNasz4u/fddW254GdgOQgBfz9G2BYOCaLrDqb2YB7KiC96fc+8533I036iscdD3IV7tg2bE36p9HPWTXufLzYdeR9YEGv1fHQd7vCxizsecfP0+Ihu2aDbfgp3qOqktlnvk57/adBpFCyqP0ICdl9/+Kinm4xI67ASEvxWFIi4gSUh+LnC97xyOxLNhspxukrPMkbQgfNXotSOSCClBrApwOjDxp+FYH+nY4d0b/XmBz0zqxVz47jm5hq40
x-ms-office365-filtering-correlation-id: afb44540-5793-47f9-9551-08d61c4a5d9c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0133ADA6FC06F0175A1DD340FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(39060400002)(110136005)(2501003)(10090500001)(14444005)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(575784001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iFHn1+RPftKqi6WassZ+RRY+m4ZdHgwbCB5J0yPRq2PhIQda922HuPnrqW6fu+UAUhGnP/jbvq5is7P+p7lN3Ct0jUNmVl7sEIiTTJFEiMhhxK8FhA4sPbgo5fLJnwmADbrPO55udlAckFNmSabCch5f82SALZQL1UAw8gM8izj2jw0GNLWSekUJFKXvn02YOwLGeRUWrekPolT5hIRvDtqPZt6OOdwLI7ITBevqEVWFRCK5qfh+FPhqu4OYg+t4bbJsFOeBtkcPPO+n3wVnuj4PG3Z5MdrOjcY0mq7qnsv+BCCseqw6W47xxrQc0sAdycZWtyajT/JqV8oUPI2KTof8wB5Dv6Ph1jIjq+SY6HM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb44540-5793-47f9-9551-08d61c4a5d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:18.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Breathitt Gray <vilhelm.gray@gmail.com>

[ Upstream commit 2873c3f0e2bd12a7612e905c920c058855f4072a ]

The reset flags operation is selected by bit 2 in the "Reset and Load
Signals Decoders" register, not bit 1.

Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QU=
AD-8")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/counter/104-quad-8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-qua=
d-8.c
index ba3d9030cd51..181585ae6e17 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -138,7 +138,7 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 			outb(val >> (8 * i), base_offset);
=20
 		/* Reset Borrow, Carry, Compare, and Sign flags */
-		outb(0x02, base_offset + 1);
+		outb(0x04, base_offset + 1);
 		/* Reset Error flag */
 		outb(0x06, base_offset + 1);
=20
--=20
2.17.1
