Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75E2ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAFD208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lPFQyF/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAFD208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeIOGv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:57 -0400
Received: from mail-cys01nam02on0117.outbound.protection.outlook.com ([104.47.37.117]:43118
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728972AbeIOGvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msQwjAqgVud6RzmQpyjMTmMOhiuReqAWiBcIvhQD5jw=;
 b=lPFQyF/bCo/RpLSShh6GpxNT0/Gxt4dwG3vx3XBC4q6uhnixB1p7VMIFi4pNVVXdz3xqLiG0Ze0rNXzDUrkJpsKVb7QQdE9nS5IS/LK5RGgcMyldq1UNPDEsB29iw1fzbRwUTiflDii+zoNXjx3j6p8gNx6ghwzOTIVsdAPzWGc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 30/34] dmaengine: hsu: Support
 dmaengine_terminate_sync()
Thread-Topic: [PATCH AUTOSEL 4.9 30/34] dmaengine: hsu: Support
 dmaengine_terminate_sync()
Thread-Index: AQHUTJRIpph3kYc59ku51ss3QKOG0A==
Date:   Sat, 15 Sep 2018 01:34:45 +0000
Message-ID: <20180915013422.180023-30-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:/+ZlmFhWhM7eHpYZqgie1i0ro9WF9eNkXHHpTSqIrEQog2v0gMxKaVI6ZJkaIdLV31gLABajeolAFb65EW5gL1syAdhrektf4p+RFxq1J20IGbH65bpMsNmQOlTDrxlVhQiLlPDcghhMq4NsZVFATk7xEYo8d/itOkT5m0yg8QmUBv7R9oRz+ZGOvL75PDNtwuWSUxyHDXC90gwM7wtOppeGNZ8kCakaWH5ht0YekiuocwUARKL1fGNYomd1bhsyasUa/B96pPyY281FwcmyAwEuoJATvmluI1y9Z1OuQaCGrSRgfeOVBZEj3BdOM2ermVpeeqG5eN6MdgQBLCWPas7grliP3YG7PsrINGOHOUlnTZRCEM/roAlLJhCwfFW6QRmsfXYX11vLGdkMLQTLysFmFO5KX6BU5Qs26fxcQnvvc1yzW6YXRhzfm9RK/f+uGVvYE+RX9fyUpnfKdxt7YA==;5:aZ1AOIPfsns0oPyClwNQdkCfjzQKFukgUbU5rIFERa2gYsfcCO3idU37L8juDu65UJUQ4UBc9II11qNv0KK4zNMHkO6/efIygyU5meNxXji9Y4MzuYVPksqKoH0eYYkuyg2DbKJljnYnx9kU93zHshr47ibL8smSmxAwWgUwKVo=;7:BzsogoiWZCi2rLs7/HnHHEgO9hPWUyHxna7sCtX3ZHDeGxivQkqjaQRuYNmS18GAVoQMjMjgZJTKyOHInVhzkDquPdv+M1kzpoYQqY4XDJe8KBA8ekQE34v1Hh/CHvb9re4now9LZ1kvF+WjZWVhhqvTSuJm3laRyF/xvBqCsUklwmn5HpzZtweKlvEgVNjcfGvqpd5s1SQ2YHgUkiSYjwCTHn77285Pl5g/pHhU8aSMpONBgww5Nq4VR4GWmDJS
x-ms-office365-filtering-correlation-id: 8c825ba7-bf2a-41fb-212e-08d61aab6abe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB0823EB5B922E911411B82E54FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(14444005)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: kqssXt/LKHDqcZpp3mB97PA2PSPtOA7eBXmN1pmVbGqCS/qo+PYZkUe2fl+JCAgfR88FJyLa+nriSxlFn/s966MKY6qKYu1Tm0254Cy2rYF9QeJzvUHLreL2FIKkhppdA1PCTREreiSZzyzzC8Jo/9dTEzVyyb8GexCXznRLU0wSo65obKmgG93qyaywPb3CYD+8h0djS7WcnmS5k8k7RPe8DprgF9Qf7aHZHT/L4X/GfDFD/1mfjxInIvzsBtNEHvFOWfIwNAxQpJWQvUbLHk9E56FrwNzHFsJiGnCbmvH/m4Z6wRH/0I5GMeudjqBhc8+gcxLmJtypLqNKn7jcK2R/oWwHO7Q0W+QfYQPzKjg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c825ba7-bf2a-41fb-212e-08d61aab6abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:45.1297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 2abc66cd499aa16876e45c6438788902f7d1ce22 ]

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
 drivers/dma/hsu/hsu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index 29d04ca71d52..202ffa9f7611 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -413,6 +413,13 @@ static void hsu_dma_free_chan_resources(struct dma_cha=
n *chan)
 	vchan_free_chan_resources(to_virt_chan(chan));
 }
=20
+static void hsu_dma_synchronize(struct dma_chan *chan)
+{
+	struct hsu_dma_chan *hsuc =3D to_hsu_dma_chan(chan);
+
+	vchan_synchronize(&hsuc->vchan);
+}
+
 int hsu_dma_probe(struct hsu_dma_chip *chip)
 {
 	struct hsu_dma *hsu;
@@ -459,6 +466,7 @@ int hsu_dma_probe(struct hsu_dma_chip *chip)
 	hsu->dma.device_pause =3D hsu_dma_pause;
 	hsu->dma.device_resume =3D hsu_dma_resume;
 	hsu->dma.device_terminate_all =3D hsu_dma_terminate_all;
+	hsu->dma.device_synchronize =3D hsu_dma_synchronize;
=20
 	hsu->dma.src_addr_widths =3D HSU_DMA_BUSWIDTHS;
 	hsu->dma.dst_addr_widths =3D HSU_DMA_BUSWIDTHS;
--=20
2.17.1
