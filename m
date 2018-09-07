Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2B8C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868632083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eAUWZbMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868632083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeIGFQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:34 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:29216
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbeIGFQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnhTXWOUNTWjli48UEreNMYku4IgO4/Z0gcspZmz6B8=;
 b=eAUWZbMgK3kHG10ZTc9uc141uYkFWJkm0W+pJyP3g55gA4e5qsffF6OlTPRryHBMz8FZAtv/i9Zlo0AaK+ArgZdFZyTsRDC+DI1Vb066gHXNJzQtyfRWXsc2Zfb3CFxIa2e24fQnuwqwdqNEpQTsFKwb8suJDi6CAzdym7TEcFQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 30/67] iio: sca3000: Fix missing return in switch
Thread-Topic: [PATCH AUTOSEL 4.14 30/67] iio: sca3000: Fix missing return in
 switch
Thread-Index: AQHURkL8bykyNPcgpUuUGEUTlJg2+g==
Date:   Fri, 7 Sep 2018 00:37:42 +0000
Message-ID: <20180907003716.57737-30-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:9MCvEsfVpeJYQUeWTwEGNGgPFaA9WqRu7LRt2fvs5d/Wha5l2iMWMA2ivsjjMSCatvcMY0kcjRvW/q/bh8XmQmA7Kj4e3G1mgvciKEAVFr0aFUx4YHbe/NObKn9uI03Pz5SeGZuV545KjjapmrDPdz1L6Nz+4m/BKyF4kVsNsQXCZt7ZY6wwxrktMs6JLIlHot9aNzjenm9nd0vrUux8k73XS+VZXsPR8mA9HPhALPXxskbT2AKuCnc8/PCmgKCVml4GLqjLJGuKsgKJTOKEe+iEtvFBHrE7lJfU5QQEek51Fwn4+Z8/wN49YrGZEVd838zBrSMpQs3X9PniFNO3F7syRjm10XSjiyUmYymXBsazIIQbeBKDI05nNYdhp8UlAZlFR66Np7DxPNw6qnXs75KjNANmCN0TDx27lHxgl8wMkl4MbXph1dJjSgeWqExjwccOPZzBj7VzNRNz1w5A0w==;5:fUXgxQq0DJ1hDwgQsHyJ5aSayDJRX0o+I55KRyksBIo3PtFRztkvgcdixoYAcM2BzZatNk1T/z0pfu266MWO0HGsR+UIbuF02xYntX2+PdAqHQS47ANEBCrXNeNs+fqKHQHWpU1fpMwC2YO/lYy3/aL+qo83qHIJJguqllGOpgo=;7:WnAwmKYYIndlfNkpmXpLe1jOTuCzjBTHW8/hI9ico7Jzj9WZB7E8dgE3gyHi5JRi9wt1iB1HOV2CqFPVln9r05qlNTWLaSPfUlRHbWUHx4ls/5YrBCFG6e+v9HIPIzFp3PEMqLgoD4Gi4ajaErHtpWZrgd63L30wUk6/oNFhRd8wCEKB+j6vY40QRp0+mi2qI3P+5yepCoVWBlH5MJsRoX5e3jPvPzXbk4ch9s0hk5yZ9o3HWDOxY0/f82qGXVu1
x-ms-office365-filtering-correlation-id: c45113e5-fd4e-4184-dc6c-08d6145a387e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840700E524EC18A976DE59FFB000@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(66066001)(186003)(99286004)(26005)(8936002)(76176011)(102836004)(81166006)(81156014)(5250100002)(54906003)(6506007)(110136005)(11346002)(446003)(316002)(476003)(2616005)(106356001)(6486002)(86362001)(6436002)(105586002)(86612001)(97736004)(486006)(6346003)(53936002)(6512007)(68736007)(10090500001)(2501003)(1076002)(22452003)(6116002)(3846002)(36756003)(4326008)(8676002)(10290500003)(2900100001)(25786009)(256004)(14444005)(305945005)(72206003)(7736002)(478600001)(14454004)(217873002)(6666003)(5660300001)(107886003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0rV2qSWkthL2rkLYVX0oafgrXytcA6L2YSWYAu09bNRIT1jVoNnq4o0CXgNhNWYqGOYPu7lgG0Tb5o4mBTSaHv4HEeBRnlXc0cqtzBSLvbQpROJubie/cR7ljc/rDOuQwRBOy87/4xtrFWTIQv9GFnp+JncubMslhivlmbT6/NMi0Ioi7hLZLLQH/XfZXzCUarktBr2ElxEB6TNysv5+0qztSpaOTiDsYEbdBR7GOM+5gvVRbvnHuyJTcAV1I8YnC6pnHjs1ASz9t/kP1X2qUIXG5a2EuE6E+OObKHNvO+2OBPx3B707leE0V8zRULAsxjqxujafoy1uvHLY1TdCpNRm3+OYtWKgWe/A4TonuGA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45113e5-fd4e-4184-dc6c-08d6145a387e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:42.0499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit c5b974bee9d2ceae4c441ae5a01e498c2674e100 ]

The IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY case is missing a
return and will fall through to the default case and errorenously
return -EINVAL.

Fix this by adding in missing *return ret*.

Fixes: 626f971b5b07 ("staging:iio:accel:sca3000 Add write support to the lo=
w pass filter control")
Reported-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/accel/sca3000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 565f7d8d3304..f2761b385541 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -797,6 +797,7 @@ static int sca3000_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&st->lock);
 		ret =3D sca3000_write_3db_freq(st, val);
 		mutex_unlock(&st->lock);
+		return ret;
 	default:
 		return -EINVAL;
 	}
--=20
2.17.1
