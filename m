Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5340ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62802208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="J9KqHLQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62802208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbeIOGu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:50:28 -0400
Received: from mail-sn1nam01on0128.outbound.protection.outlook.com ([104.47.32.128]:46048
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729387AbeIOGu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tZso6GFNZPuqaiKDxJVobEuiRDpMNX6pcIX7MmzMis=;
 b=J9KqHLQ2Ij9Kn9dMipQFsaer0qiGKvonmBXTrN2n1H5AenlHAKhzy1PsXYwWWD6PEHLRj4J3Pl4SpuhtKTOBM+PqLOp59Ygr39xxB/t/PAsMK5EK7ZUcZF9yaw/S038+DWIPKasvQtd+7EB4Wkj5+FfRkXG/HPsn9w+ChjEN+c8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:33:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 51/57] IB/nes: Fix a compiler warning
Thread-Topic: [PATCH AUTOSEL 4.14 51/57] IB/nes: Fix a compiler warning
Thread-Index: AQHUTJQKiV4NFud8+EKZbVkYEfvg+w==
Date:   Sat, 15 Sep 2018 01:33:01 +0000
Message-ID: <20180915013223.179909-51-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:EgdCQgqKGORACm4yzh/Y3HiD3lB7k1lPHxzT3wZsdyoiEux8YHZBtLWFYjUaXcWMwxPY7Olgrgfdty4+/NkxeE8iYLeyiwhfGDf8E79MUx3nGyMiVhr6hfVvCBkZRTa8HkDGvQOV9lXf4EgAHIeGCcxNQsC2XnKmviu5ZMqMm5s/3Q5SoUcJXk6diC/hxxlgBSn6nIg6emLrbUuifjWhpNANp08EZjU4z6g0U3ue8JCBL5KGTFJ+Y7CbvYuzDYHCkhmE+DyXV0R588JVCgC2y5120SlEZgHjMmBapTaNVsmEXgRuLrZZ4aJq63oC+QXC9A/raU+cZcTBa9OvXEa6vlJJG/tP73YHZLkRLqRhcSJ5I/1hMbb5YQxOG6R74KDzB0qjzyLnMMfYdKkfJf4/z0M/iUoMn9rKOC0JfLQb2UZ+yR8A2O/sUkT5WPKaeKyyHn+YkLWvJQnYBMoXYEGBLA==;5:H5D7LVi1GccCG7X7t/oOMMZMGWkqAlJ1iWjALicxkK0ebQ2gocb2oJIJSQvcuYV1ac1JycXaBpkQl9DBGQZzShSfOy48kj8yHpWXqnPvHtanVUyfYX1tFccpzQ33+WS7iz4lFw/uB+P/XDftubAVdtOkLEl5FFw83KKcBsKGiXU=;7:sZIg8xwv9Z0PQ+i3zw7o/6jisK2zoXAqYQPFXYsUGiM+kLpeW2wnfeKAqqZExa4ZPlwBHljhiDBBL8v6mlLGFwp9aKsKiio3hUPyUj7ls63LW1MBY04nZZxUnUhlwUA0Vdn6R0F+OM0+ouvfj2/fL9Ow25o8fXEkuu3Zvcb2NlRov0IpfFituayDt7AD+litONrVg0mL75crb2mqTnoPkO3adCW8Menha8vIsZNq1njafAw83dzVpAxzOqxE/+rz
x-ms-office365-filtering-correlation-id: 6dfa759d-47c1-4a77-9f16-08d61aab3b92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855789389B5106603DACA0BFB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231353)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(6666003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: p/4FHO7erHlllmJfNvkFropmv5NgtYIwxlVWhP+u5g6TzVDRKoOweNtI5WyBD/+rmwWfO/3vtw72NXkes61vdW4COcNEu+5KukhCLATC7fl3IYAui2C0UbRK2u4TvMDUrgee7snxGVXfS7UOPNEGIbXjNiVBpYVHKhlHF8gG4hoiKNcmk7OlqL4rI8FW6MzY+qR6f4R/S53x/7YC5PGPydn14kbRDISqYp7gONz9KJmLk/e7Rdc6/t9PoT1UuLe1fbrgUvFwOJffR7GH2v024DFl5Zqb8VzBPp/9o9SeMIikXEpwhMPp0rGZ+gqy2l6ouCx7/+LYfOpG4SIkyuyMiPZDX13EwYo80IBK9FMT00k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfa759d-47c1-4a77-9f16-08d61aab3b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:33:01.1645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit 4c5743bc4fe3233cecc1c184a773c79c8ee45bbe ]

Avoid that the following compiler warning is reported when building with
W=3D1:

drivers/infiniband/hw/nes/nes_hw.c:646:51: warning: suggest braces around e=
mpty body in an 'if' statement [-Wempty-body]

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/nes/nes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/nes/nes.h b/drivers/infiniband/hw/nes/ne=
s.h
index 3f9e56e8b379..6711abdd4872 100644
--- a/drivers/infiniband/hw/nes/nes.h
+++ b/drivers/infiniband/hw/nes/nes.h
@@ -159,7 +159,7 @@ do { \
=20
 #define NES_EVENT_TIMEOUT   1200000
 #else
-#define nes_debug(level, fmt, args...)
+#define nes_debug(level, fmt, args...) do {} while (0)
 #define assert(expr)          do {} while (0)
=20
 #define NES_EVENT_TIMEOUT   100000
--=20
2.17.1
