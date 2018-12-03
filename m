Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01A8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9834520672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MBko6OJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9834520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbeLCEAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:00:15 -0500
Received: from mail-oln040092006082.outbound.protection.outlook.com ([40.92.6.82]:15584
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbeLCEAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzwWAoKUcExgrH2MIJNMLUHo6y9PHK+FjJ+WzJ/qCkc=;
 b=MBko6OJwUh+0We7pAxA21IEMKnleILD5GuIDSisDNDE9rMOeJsGra5WyZPmUxvXnBUvl/LoyPT/WggqFktbLm8jXHIGJ1GeQrIeRJfKAii1XtUgm8sPxK1NAnHMNEV1FSZA04pwBpWhMogETbSXGuEFTjxeu2/DXhtKIiAeHqmfZMH+CyYw9CeUcKuod+GDvlbWVFtOIKAqZ9QoAXkhc9B3/+D4zDu7plnt9m9UklKJMoVMUG5t8HQbSp5Z3yz0WVtJTOpR+Isk3QsFvJgpQmfcbvFYGnS5xi/jjaX9YlEGF28SiD/iF25eh3m6Hro84r0YuzMOmHWe1/OCZwRrXVA==
Received: from DM3NAM03FT057.eop-NAM03.prod.protection.outlook.com
 (10.152.82.59) by DM3NAM03HT033.eop-NAM03.prod.protection.outlook.com
 (10.152.83.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.18; Mon, 3 Dec
 2018 04:00:08 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.82.55) by
 DM3NAM03FT057.mail.protection.outlook.com (10.152.83.45) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18 via Frontend Transport; Mon, 3 Dec 2018 04:00:08 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3%2]) with mapi id 15.20.1404.011; Mon, 3 Dec 2018
 04:00:08 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] memblock: Anonotate memblock_is_reserved() with
 __init_memblock.
Thread-Topic: [PATCH v2] memblock: Anonotate memblock_is_reserved() with
 __init_memblock.
Thread-Index: AQHUiryuEY3GC2m5nk+tSrupm8LKDg==
Date:   Mon, 3 Dec 2018 04:00:08 +0000
Message-ID: <BLUPR13MB02893411BF12EACB61888E80DFAE0@BLUPR13MB0289.namprd13.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:CADF5910D62F21D2D326401D14BB064476FBF0BB36CF0A5BDF8CE38B049FE3A4;UpperCasedChecksum:E536723D6C0517F71A0ECBF994BB0A9E0B92DB6E73214B41E27BBAE9AC8EE109;SizeAsReceived:7477;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [B3Rb1htbLpTDb18nu9reItHvZCPrRL8q]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM3NAM03HT033;6:2rh28tb+OIUqbSXtQ8XJ+1sf+tNwv7bNklPJI3IfsAm2JAzGsBwo1RrLxMB0q5rYOwBAmqmOqeucR5+48JsKQvOPpi4pCNrapw4MrEY17bQ0z49QFU5MFOC5ggu5/Xp3NL3hsQLLqBYkpX7a+i2de9YipHSvttan6EJJHMAA2nYgrZFkM1+Ot8a2o5iOthaCe7EAkIMeaQ1ybFtpMqXWnMmTL1Jm68u5vlvFLOD9FZ1PH87aZFa9MHWaeTrNoIKTXBnY1CE1hatCb74YIoiYfCvkb1l/WhKHJXBmhaFy2yHlwSE7Uk0G8zrhmGC9kzxwAcIbkcy6C9mmQhf6MVHAKl2tG1NRqAkdetuIPZ5Lo7h5oYU7SrnRIQmNA9IH7CT6U6OWlCoJE5sTOcPEZap1I+tb7aOU4lENlaFRB5YBYOD9o9F1RCAwLbDxMI9olxvBSx5cMKw77+gsAdFhlGEDXQ==;5:6AJCQxvnvLEZbE3l8o2dXiI5E5sOb9oQqK/uhia8GtWWQ/gWebq7bHmscKNnibhCkjprPP7/5AxgMEAHrYMnV2KCzOFJ+q3pT6D6Ly1qDKBDlVynG03Kudjk1sBgDjq8q1VG1W6VYzBTGKzvv5tM+SOKPLmoU30yEUgMbka7Pqk=;7:KMmaHkYRTc/YLE1pThgD6JSX1wzDoDP7qp5WoQX62dfUDmbZ/YPNJmL8/6zV4OiFUNMW8gpyUSxKLMWDanUar/H4fTqCVVGkhlGow6jfLmkIgeH04DAa84qM8t4GDAgfXIEZGhlx+D9YgyxGuD4lgg==
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:DM3NAM03HT033;
x-ms-traffictypediagnostic: DM3NAM03HT033:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:DM3NAM03HT033;BCL:0;PCL:0;RULEID:;SRVR:DM3NAM03HT033;
x-microsoft-antispam-message-info: iC9GG0UfEaCYgowctpYH8QIqCyrbp5MRU9UgwYsFGBXSeM3jkZOihBdWV/r/u2KZ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: ff09b059-f8d9-4936-1262-08d658d3d08c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 04:00:08.7032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3NAM03HT033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found warning:

WARNING: EXPORT symbol "gsi_write_channel_scratch" [vmlinux] version genera=
tion failed, symbol will not be versioned.
WARNING: vmlinux.o(.text+0x1e0a0): Section mismatch in reference from the f=
unction valid_phys_addr_range() to the function .init.text:memblock_is_rese=
rved()
The function valid_phys_addr_range() references
the function __init memblock_is_reserved().
This is often because valid_phys_addr_range lacks a __init
annotation or the annotation of memblock_is_reserved is wrong.

Use __init_memblock instead of __init.

Signed-off-by: liyueyi <liyueyi@live.com>
---

 Changes v2: correct typo in 'warning'.

 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 9a2d5ae..81ae63c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1727,7 +1727,7 @@ static int __init_memblock memblock_search(struct mem=
block_type *type, phys_addr
 	return -1;
 }
=20
-bool __init memblock_is_reserved(phys_addr_t addr)
+bool __init_memblock memblock_is_reserved(phys_addr_t addr)
 {
 	return memblock_search(&memblock.reserved, addr) !=3D -1;
 }
--=20
2.7.4

