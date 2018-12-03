Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E0FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB56B20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Ny7Udhkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB56B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbeLCDvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:51:11 -0500
Received: from mail-oln040092008096.outbound.protection.outlook.com ([40.92.8.96]:63264
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbeLCDvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwMVRJP0Tg+SdOgkTSb7+5BinAzL5pXMv7v5qdeHE+Q=;
 b=Ny7UdhkpRQDTwcaiS5OOgSecJ/uEjoWRFSCH80EDqy+xUZQnbfhgW6omL0VD8ZQm/Sh7QzAeNIFmx9SarBXmTTJrb0k/AadXz2lQWuQ9kOHbk0nZTR7odvHuT2Ynlzzrd2KlOKCTK5tKz+pQm1+N0bhWh+McbLQcmiLAyrx02L6q/Ji8BvLVX6CAc5E0SGvdqn4yYGxlvYbqhuPOtojd4ApslmXJ7+Icd9dc8PwWpjkXLTHjDoICSXNiT6oVln8Q0xuM2rmd8/Ku5p1guzHO/Lu7NFeUXCawPPxy2cMuLI/V7YRHJyXl+VB7qjeiZvcPpIiHTaBY0QmaxaLEe1mHyA==
Received: from DM3NAM03FT030.eop-NAM03.prod.protection.outlook.com
 (10.152.82.57) by DM3NAM03HT210.eop-NAM03.prod.protection.outlook.com
 (10.152.83.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.18; Mon, 3 Dec
 2018 03:51:05 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.82.55) by
 DM3NAM03FT030.mail.protection.outlook.com (10.152.82.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18 via Frontend Transport; Mon, 3 Dec 2018 03:51:05 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3%2]) with mapi id 15.20.1404.011; Mon, 3 Dec 2018
 03:51:05 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] memblock: Anonotate memblock_is_reserved() with
 __init_memblock.
Thread-Topic: [PATCH] memblock: Anonotate memblock_is_reserved() with
 __init_memblock.
Thread-Index: AQHUirtqtuzF7rWp1EuMR6Zuhke7FQ==
Date:   Mon, 3 Dec 2018 03:51:05 +0000
Message-ID: <BLUPR13MB0289EFC5F40ADCAC2146F687DFAE0@BLUPR13MB0289.namprd13.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:23A99CE9DFD4FE9E963AD6BE761DFC59F0B1960D1B5B24B31F3AA52EEF89D03E;UpperCasedChecksum:94C04BC4F8988D58C468B80510F4369B15FDA4F097C793F3E790E45DC7569440;SizeAsReceived:7472;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [DBXn40p1D61h5wf6KYr6VyOjwh7yHJ/y]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM3NAM03HT210;6:fiLjNPdCa83hchLSAUFl2zRV//iV3iZ7r8fczHmj3Ge/686ElnItRro5O2+qbNBL0flRUvgWE5QZ2Ydnm60dW9m1fry2r9bi2fP/3Aij7cY9Ba9wHB2ob+fJSj2WxAWOZ3b7Xjq1Jy87ePHq740I1fgZK+qibMwpPBaDto7ITq3ASUF+aw8P8RPWPdvdkZrDCkXAmRSqLn2vcmUlKPALws/fDl87jehxtAMxvP5YC2HcaBg4nGgUY8ZcxDUTcuQRLafOAlt7bTVEAYnJQuUJV1Jb7ifZhFJJiIbC+Sxrjfb+KnV2poi0UyCGMCw9uTqGQ8KDeeuRUCygnXahDNsRFM6eeLh1hndMDUR5mN1oyhnSGksnolsQmb3tnqrUBfo2TI6C9xbbeGS5gh2T5e7rcgjrVVXquEv4c6ng1vzwtAke31scPj6S0U44oz1CdC5ixZlHdobmMuZSBOnWR7/lfA==;5:Yh8NmZILjE4CghzQ1DOPo4tl0CUb3zDS6cZdN+U4fJ4ZDxIhHocTIy7wJnOWLMNZv58fD6rzpiLqgcl8ZiJhcjUAto5MN+caSTGaQgrU2zvUpmfq2c7TZI5LwAHlx3GGZ+i+BJcuQiPYhYFkP3M3F9M6+fkHYQzsE5O1AEKTle8=;7:WZNCEFl+v6OnHKIqWXvCjoy0GyVFuLaRnFo8rPlcLGIe7jMi9Ih0i4XexWYzey4Ug+7PEDX98spHCTluL4hoc4yHpme/9A9jIWmajrur74gOtNkEmt98ndcSRsNLb5JJD3RtvYILCh07QMURbN1g8g==
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:DM3NAM03HT210;
x-ms-traffictypediagnostic: DM3NAM03HT210:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:DM3NAM03HT210;BCL:0;PCL:0;RULEID:;SRVR:DM3NAM03HT210;
x-microsoft-antispam-message-info: OsWRV2+ZgZmp8Pmjpjw4S+D50uoOnamQz5H2gDVTPMeleByiT4ySIsq9R2s7aD4o
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d3d101-f355-47ea-7570-08d658d28ca6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 03:51:05.4349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3NAM03HT210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found warring:

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

