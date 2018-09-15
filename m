Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BBDECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AE121476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YITn0U3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AE121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbeIOGxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:53:03 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:53808
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729303AbeIOGxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGAyb/Wv35MI0CoxlLUvupwe8xgxn3eZ48lGcoRYnAI=;
 b=YITn0U3N5UhJOTBTx3NDxcNg1uRAJuifNeiJcShZAsQMwzaT9oEdaAj9iWnOuH/O41ncANIek1DJCWhwTh2VWbVBr5XzQwDkNeb7JIQWQRGNy/6eGo5VtKuFtXfqOLQYb9DagcTOAYp2cizgsvIJz7wglkmfuBYY9DIoK2zHPok=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:35:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 08/11] rtc: bq4802: add error handling for
 devm_ioremap
Thread-Topic: [PATCH AUTOSEL 3.18 08/11] rtc: bq4802: add error handling for
 devm_ioremap
Thread-Index: AQHUTJRiz7dJxmRM2Eqju1UyKnUXgw==
Date:   Sat, 15 Sep 2018 01:35:29 +0000
Message-ID: <20180915013521.180178-8-alexander.levin@microsoft.com>
References: <20180915013521.180178-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013521.180178-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:o3WnY6XLwK8h30Owsi9XsVmblxMCcEkvBWUhsBeewHFaIergp0o6XvFJH6Vo3VSaeQvvL5S5W4xkXGVOtFQzLrvCOcL7stqLWEF023IqF5RE8+YuCzyox1ojYPxguyBtA8OYej4q8X4sSCxYxhEyyz8eyOhPGGL6fG7fb8iy2rIEGc/n4Ew6ySDRvXao9hp1IoGXR/NfjZALwqT9SJvVUQJnYJLFBNccC/nII6mUphoGnOInZgrRAq6l1OvHk63JKJ5CgXozNbxC5RakqKHnyNzGUrV4+daC2JbwtD8i55ZJ5Rb28h1T+zc9vnujM0F9bnN4V5C1i5Oy9Uitj+wDzP8JOz1aamTsEhbxSdYlVi+aFbscJWdqgDVQOx0z7LkGNuNLzGotgumpJGfwH2gF3frINdkNX2V9ceTI7TNBKay6sfaJ8CcVxqgaqprWtwC2LhxaAst4GKAzclyoQJ9pKA==;5:NDW8b6OXSsEMjPOh01iGVpOm1aP0iEXQIGL9rt8BJD47I4be1gX2ViBsLgDELSyphpYor5+4m649cPlOR4KAW8X9wF0xujBIRoCVALOenijgCknjvCU4/L4qhm/4cwYeCNhKk+cpAm45JinQC8lJuvzbq6yPsiv5ZxGKjT0MQUo=;7:ERUDwN/WIvQ2NTA9uNGDx6dfRFh4YecW9W/8rEjJ3kaF9UcPwseq/en0NcZPIZOACEEXuYRpD1V5EtN4L42jANDz//sQAAY+YrydqCev9BuuoSCcawseG3R8u2yfpct0CV6U/tE8ylF23s3Ip+AqvnUsUnA1n8a1FyPUSxsOSQOfdCY+4M8nMrONPnGXKT6OJqxZNX19v4Uw07fTNqpQVESYU8LENXJy+xZw4UGFpjJWqSKS7W/pS4fzSN3CURMu
x-ms-office365-filtering-correlation-id: 8dff3388-caca-417d-539b-08d61aab9717
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-microsoft-antispam-prvs: <CY4PR21MB0280C6B4BED1A5D29FADFDF4FB180@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(25786009)(14454004)(10290500003)(2906002)(4326008)(6436002)(39060400002)(107886003)(72206003)(256004)(217873002)(478600001)(5660300001)(6666003)(6512007)(5250100002)(2501003)(97736004)(53936002)(6116002)(3846002)(8676002)(7736002)(305945005)(1076002)(6486002)(36756003)(105586002)(10090500001)(106356001)(22452003)(11346002)(2616005)(476003)(2900100001)(486006)(446003)(66066001)(76176011)(99286004)(316002)(54906003)(110136005)(6346003)(68736007)(26005)(186003)(86612001)(6506007)(102836004)(575784001)(86362001)(8936002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +hRYk28XS9XI1s6X33aY94fgedeZ/BFzXtUZIQH1bqbECDv1QP0DRNBIQksYe1WwhHj8B8YOWQRCQKoaoQLYTkunI+ZPBiTCu+XpjUhGloiSog2zsaZMAvo18T6Ur5T8ABpmD2z7jjjomdwH87WV4Y5zFV+ZpbEqBgTjUnhZPi4SaDCzprXmcTk61M/oyZaW9l2p+NFZGknlkm9Ng+T3yPfDZ/7UZLT5osVr5HHxyQpPqeUASZnEF4JIAWRDzWo4TJFbdsWnjLOSTnqkndPb334jeSTA9TQYEgeEoDzKms5CGB25Yn5gBnFwB11QYdg6fVnQEscOHSvYAyMlHWxOFwi+bFtfBvz7PCJKx901Fis=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dff3388-caca-417d-539b-08d61aab9717
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:29.6286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 7874b919866ba91bac253fa219d3d4c82bb944df ]

When devm_ioremap fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling devm_ioremap.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-bq4802.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-bq4802.c b/drivers/rtc/rtc-bq4802.c
index fc0ff87aa5df..f53198207e93 100644
--- a/drivers/rtc/rtc-bq4802.c
+++ b/drivers/rtc/rtc-bq4802.c
@@ -164,6 +164,10 @@ static int bq4802_probe(struct platform_device *pdev)
 	} else if (p->r->flags & IORESOURCE_MEM) {
 		p->regs =3D devm_ioremap(&pdev->dev, p->r->start,
 					resource_size(p->r));
+		if (!p->regs){
+			err =3D -ENOMEM;
+			goto out;
+		}
 		p->read =3D bq4802_read_mem;
 		p->write =3D bq4802_write_mem;
 	} else {
--=20
2.17.1
