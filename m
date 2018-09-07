Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749B1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7362083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mLsLegxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7362083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeIGFPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:05 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:53565
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbeIGFPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2JuanaGTcZkxXtuDVYBi9k/O6nxy/KXTuAfc+3x6Jg=;
 b=mLsLegxhgC5Sq3qi4KZP2Bni8P+j0FSam1137Am/FoYndYvcm4DvQqqOSFz6xcXQ6szdKXeU0VoYYdBsy/gWNvLjAx9Nt81zhVzCCio+EjBVgDa4lctvTyQe3NSJnX1HutocX9OQHp35wIyIU7xJwqLM2NdWCYnVopygi2P4o5k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 38/88] iio: sca3000: Fix missing return in switch
Thread-Topic: [PATCH AUTOSEL 4.18 38/88] iio: sca3000: Fix missing return in
 switch
Thread-Index: AQHURkLLW+7MKgk38kazXd5d9wXgGg==
Date:   Fri, 7 Sep 2018 00:36:20 +0000
Message-ID: <20180907003547.57567-38-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:QfJ1pPC8HZlzEV6rfSeB2BmLrBpi6QcAhoz9HJCU7GmMAe+XX0rSiq0BjgtTh6ZLLndw+NFM98QlotCHDEg88+76VJhHz/PndrOniLoaltz648j+vNqCw0C8JQNsAkwWnyc1EOGkhkgwZUbW3eSk6O/3dh7kvr0l5oGbvv2TeJyyZsjhTqWgx4xQMxq2EWAdYRN7IYDNdd/d3J+iaDfLVmUPFu0wYbDZyMfzk6ViHi2umiDu1BX8IYWtQyX/2CfPOTXHe2VXgVr1cqaCWMCUJlXBaqQDR3LnGk9bEczBSziUEDkt6R5LhhDiiYurUo44H/chigslsLKsIJvdZr2WRoL1EEjVi3MZYFkBu+K+k8UVj5jK0jrva4yvWtc1JSr7vA9P4FVR7K+S0sTjZvY2zUoyGssOVgffgBwZCapwRL0vD8cvvUYom9bFtcs8du+b/ZwzJ/CTaCJREYt9nJpMFA==;5:JqtwXEP3ITMEVjNkwZ36QqIJZwb7u3rae+LxmArMhnPkv68yNQlxrdGQZKTsM8jcmjEoH3v4NoajOpYcAug9HwIyhvm7OeY5kG4fSaxRfjoCHJOHS+B44KHhUHYz/gig+8qZm99jWUhhVDpiTAor3+6LThbdLXEKXA6R8OHUEA4=;7:Bj3bXs0zPqzX8RBvWljhRdh4/Y9uai298lH41EX8T4+yzGUvGakityvyNheZN6XS99ZQN9CWVP3nOZYnIG3xQ4NXiEbyNKE6yesekedesYkjAfugj5MFUI8pjo2qiMs0s7/g/N2fB9HsznsHU0x4Sy4Fad7aIw5tEPZ2w47tCDLbiKOprVL1bdIxZkR7G9QRemunD2yqVGAlTyOMa+EudzKv02i/h3m26DVNwdOXGxppsMebxwHXusqsUtNlsxNV
x-ms-office365-filtering-correlation-id: 830d6110-0628-4da2-1f8d-08d61459feff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB077305382DCB2B28C9D7ABB8FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uA6oOu9tg4O0RVDlOxg/K3P3/UK1MwFwrA3cA+4hJewFeomPhtcvnD046vi1zSLwtJfcJzAYwdEeHSMHnAN2PPSVWfLvQvsVkGac8adBKcUDoTsEyYacG968xTIXdlExG/VFoNPptZl6ciq9Dk7hXHZIcMZOG/+WJN+rs8L0lzhVA8MU6pi13gbllX7PxGlcCKvt4MsFlHza1wa1oQw72ebDQPmobw6iRH7s3bRo2IWTfeX1z7E3RT8BZ+syq6+Br1o43Hd+UlVHsXm6BtDY/w0L78zWs7egLXqxXUUOc88ukS+w+V0RryJcJu4c9O8QL0Wq/E3iyRxBltq9eALbiX9cZowduOGyrmM8QxqZNoY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830d6110-0628-4da2-1f8d-08d61459feff
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:20.4460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
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
index 4dceb75e3586..4964561595f5 100644
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
