Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8983BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A99214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PVOlwZOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A99214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbeIQImX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:42:23 -0400
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:43296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730626AbeIQIbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+nWAA8QonFcLCxoJvyG+i8x42wNTUlJ+B0B4P/Nc6Q=;
 b=PVOlwZOGpFOzqvb+Q6kT5YY6Th5v6O6UxwqjZitv/PlpQXKDxIwzewWzZXHuxwdRSowCx1pWxSq1/7/F2JApHdeyws92ndkHQf/Ac5dAnYFbxLOiqv6G8SD7JFEjtf1eB1/ZioQ+R9lN3La/xrWbCgpxd/xZQBGLgjBUTuOo6So=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:05:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 28/57] powerpc/powernv/ioda2: Reduce upper limit
 for DMA window size
Thread-Topic: [PATCH AUTOSEL 4.9 28/57] powerpc/powernv/ioda2: Reduce upper
 limit for DMA window size
Thread-Index: AQHUTjMVgplxxOZws0qud8E8NQLgIQ==
Date:   Mon, 17 Sep 2018 03:04:00 +0000
Message-ID: <20180917030340.378-28-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:xwaOBrQInvWPRO8cUJSKLwKkfIfbYKptCS5OP/LxxkUoCr1JMkJP5NC/8kL6DOH7y2fFkVkxCc93TCh2Rl5tkM0GB0TQbIIz8LeBsO/dXa6zoVOOv+UWbk2nbTpWieq+m/smJ6O9iBq132C35FpNS6kapB2GUIbDHBA1DfV5Fpw6059PEbgRUELoZPVVjxSt1QfOX2Wk72V9Oo9iNgXPbDoNYgmJa2fUvtjfFO9dC9W+X8j4e1drtzyGTR9iYtWVgefs2VNONy+yl++iDjOC80XRJNouR7jML2Y2CL/GUtlpVj7WNykgLfofvvLFBkxIZN6IS0OW7ng/OUqm3+mheaQfPkJ924K2xJQgEzZrciVxZMhQ3RY+eI/73fPF6cMkn5+iMbrwZPIoMK86gpt0eBUWZd4H3hVllZeqzGxR25XEbE5tGuma7trtWFhNyQPnLOcSluT62uRVFiI69WV1ng==;5:lDzS4HuYlOitAlA90jxjtIAV2F5EOAgxHMlaQ7e3x/C8mjdwrvVegG/dqdsjyt81zuFiDvHGokWtalvrQ7XUTjp7E+HBIVTQitA8TluDsPYiohWQMJrpkeqtV3iFBnz3rIQ6AiiKQqlAYnoyKLHJRG0v4MywuVQwk/0m4BXMcr0=;7:68jHr1vI83mem2IwJ7h+AKftMeWeq/lxQZUXcQ5LvUoDAOjc8xoGpQMFHTfzvvDDRn8oH90MRUxUEr0V7plIf+tpTRef/IWnFYcvXdrdK0vauyihTi5IrSpyvHxCcAf+eN30BAvYhF6pPvEQE6WACgnLqvrPoOtyoPQcL2qA3FRnInfd5sLfuuJNrjOFUqQlE8XFnkwv2eH7P7BffQAzynZ3S+eAot2clPE9OPl2JTEJwQ0l0N9yvTdOaTDdSYZG
x-ms-office365-filtering-correlation-id: 380cab35-1afe-4b9f-e46b-08d61c4a7697
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757F0DA891EEBBD4AE5F74CFB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(4477795004)(25786009)(6346003)(6666003)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: HceHImyDif5SS1wxlMzuBocN3Se0EG5ZeY4nQJofOhIxavxk5qEdJOeSQnqnxLL9PIGaLQ1GIY3ozAgm1XaxoAHL1KhKf1SoUfb2bfRcMOacOSR2UD0i3rPpHEPNNUMXyXU4q2WAFiakM4NgNhXpkm6gsKoJdrfmRSyO9gSEWNHR7SGRvNfH/vOP/VYAW8bElcXafk3qHVJjdRsPot+uBvOxWLo8dhSEF3Pf9adr/GUyffXWKkQE1xq84L2iPu4HTDPLeiaSUyusqhT7jVJqyDBs0Y6YszLzUAmqEoZ/fx7oL2SMRzMg8qfApNnc9IDivt0UHQlZDnx0ZFgNiOXRpr3esQlWMYpNYNaTFFHBazI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380cab35-1afe-4b9f-e46b-08d61c4a7697
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:00.6959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit d3d4ffaae439981e1e441ebb125aa3588627c5d8 ]

We use PHB in mode1 which uses bit 59 to select a correct DMA window.
However there is mode2 which uses bits 59:55 and allows up to 32 DMA
windows per a PE.

Even though documentation does not clearly specify that, it seems that
the actual hardware does not support bits 59:55 even in mode1, in other
words we can create a window as big as 1<<58 but DMA simply won't work.

This reduces the upper limit from 59 to 55 bits to let the userspace know
about the hardware limits.

Fixes: 7aafac11e3 "powerpc/powernv/ioda2: Gracefully fail if too many TCE l=
evels requested"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platf=
orms/powernv/pci-ioda.c
index f52cc6fd4290..8015e40bc7ee 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2623,7 +2623,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, =
__u64 bus_offset,
 	level_shift =3D entries_shift + 3;
 	level_shift =3D max_t(unsigned, level_shift, PAGE_SHIFT);
=20
-	if ((level_shift - 3) * levels + page_shift >=3D 60)
+	if ((level_shift - 3) * levels + page_shift >=3D 55)
 		return -EINVAL;
=20
 	/* Allocate TCE table */
--=20
2.17.1
