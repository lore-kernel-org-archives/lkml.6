Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8C5ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2B7208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XHSolMmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2B7208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeIOGuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:50:52 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:38374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729450AbeIOGud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCxC+vmiFKuMzCwyglRLy4LlyE9MW5rdhjiT4k6PHEY=;
 b=XHSolMmbgURIhf/sGn82isjtq1x0LLLPLFsKEbOPZNKtdn2dUdT8MdOkH4w6pF9bXc2R8ePXD/6fF/tsMj5a7aBC1kCJ2Oh/w0ST6UMti2/sz7pT2SkrPztmANxxqsBazozo9IDDf5qLpNjA+Um/DEKgkDr4u9P7ljgehB7MfI0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 50/57] dmaengine: idma64: Support
 dmaengine_terminate_sync()
Thread-Topic: [PATCH AUTOSEL 4.14 50/57] dmaengine: idma64: Support
 dmaengine_terminate_sync()
Thread-Index: AQHUTJQJQrKY/6mL+0+p3ygYQ8Zbaw==
Date:   Sat, 15 Sep 2018 01:33:00 +0000
Message-ID: <20180915013223.179909-50-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:7ob6I2NkvW2WJR1nmgK3rcZdE9+uhfCueXSPlAnigYq3PZgM/qlkiAM563KvlcHDE6RNZPka6uVJVEW9d/MekzvUSUSvpTt7at30i69B7J6L5/3EtyhUpkLFplrKD4C/kSARR2Xqta+3u+v/aCpY0vUO1oSmOR2bblx2/WA2iCwTHi3anBzzQCKhfQkYWl9UVQr1FgvU7OCkj9xP7FdW3XUU8EnTIs0l518LDrxshZMFY/3GvkmIfrksd2zgLv/JCIo5TZ7hieu7CLHQ9D6CoLeEjvrGP14oXnuKfGKbEaw6gZhS24YwRxSyiM12Ao8VulRAstPz9DNnHbd+xIHdp+wQ1y1lI/qlm/js3O8nGs/n4SsCzXEcf7eNvxCkAzgB2y8O3HIMIzj1OR9YOFYUzhqmuRqiNQaqFYuZH+05MtEgNBxPFl3FQXu6is1ztqZwSlFv2WytBIntsgzugRlbgA==;5:9puyDhWKi86aV1mJDfpE1MehLzzWQrBPg4ndOnc4jlhu/QcPZDJrqbaaO4raYyzuMyW+VIFh96+hTmi6SaqWtN9L+CkaoheHVrA9E1es1CUshE8Fy2cLo4Fz4z9PjU3lMYpSBhskn2UREuK6sJQ4KiT7WpAdKALVUnD/kcE1Kj8=;7:KDEdwXIFVEuaLr3SQFI9E3b7+mZgp/NoLAIqzM74kp6qp9gOOtltEOZu2RG+bpTrvGh43Yfs3ys1+lpKCQHWqFIJ8rhsI2tC04JaHKH047Nn+5OZEesXMP4j1JH/vaNKvOw0mRUW9txxNzGuLA8kA2fNT8XB4hotdVjro9rBa1TusNehyGJvsU3qHi4Bc6Y0Zvcyv04eHvPP46BUOLzsocQ7mkoMzdyZnP1k/ogc4lcuM6MEVwK4VV6/ny5HvFzv
x-ms-office365-filtering-correlation-id: 30b9432e-b9b9-4846-2be4-08d61aab3b5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB0471EFEDEC2BFCE2C6496937FB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(14444005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Hmmxm4xmtln0mp6A2HnP9DBhX6u0E2aRrChcetJ8bg+5NgGQ0YPEO9nj6Q7BmGD/ApTvafP5cYFWdxv7swDXKs3bx6ihGObYvvieTwweQxQ8iWGP1goIunKBmkluj0USRE08ekYFHL8P+EJITcEPg/5iDgQkbBVp0G84Z/l0omP+dcb/p0htMtMr/baU3wWPlj/fJYxp4E97bZxlygOz3pa6yDvOUwXhDFZYstUVMN3tlpfc4TFko3hDy2u6hURjD1TaL5mbXyHuV4M+Gj7IQ3ihVJO+9xZtbhkb5f7ow7BnlAmwyIVwsOxjRiJQrjVhuvEf/u8I60XXROLkiorGCsUJR0LRNY3XW1GXuiIjAfs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b9432e-b9b9-4846-2be4-08d61aab3b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:33:00.6177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit bbacb8e78a3b29ebdbb6af7d54fcf25d3f1c248f ]

It appears that the driver misses the support of dmaengine_terminate_sync()=
.
Since many of callers expects this behaviour implement the new
device_synchronize() callback to allow proper synchronization when stopping
a channel.

Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization s=
upport")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/idma64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 1953e57505f4..2ee93cf98f00 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -496,6 +496,13 @@ static int idma64_terminate_all(struct dma_chan *chan)
 	return 0;
 }
=20
+static void idma64_synchronize(struct dma_chan *chan)
+{
+	struct idma64_chan *idma64c =3D to_idma64_chan(chan);
+
+	vchan_synchronize(&idma64c->vchan);
+}
+
 static int idma64_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct idma64_chan *idma64c =3D to_idma64_chan(chan);
@@ -583,6 +590,7 @@ static int idma64_probe(struct idma64_chip *chip)
 	idma64->dma.device_pause =3D idma64_pause;
 	idma64->dma.device_resume =3D idma64_resume;
 	idma64->dma.device_terminate_all =3D idma64_terminate_all;
+	idma64->dma.device_synchronize =3D idma64_synchronize;
=20
 	idma64->dma.src_addr_widths =3D IDMA64_BUSWIDTHS;
 	idma64->dma.dst_addr_widths =3D IDMA64_BUSWIDTHS;
--=20
2.17.1
