Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520121837-2-3231451855528500550
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121836; b=wby7OdzFQrpm25OVtYVaO/BEEHUZ0gZdaKXmRgBe33gqgJG
    NPlsozRzsetGiJo52zN/RAKBkFV0dDyJ+dqCYoOsmTaTRT/2KdFTWSct/KqL5RaY
    smgasWsUZzGHjIEfUmGxaM0ndvyCkTaQilXPEPy1c9ty5ZFZWoL6vhksxi6cnOpl
    JXwtz3GSZQ0JyUDH0tZ3roChpqJKRiHudan28bxDfZFS+BLVrAYr4v7WaXQctf4x
    WVP8TseJpDl/LLSLm4mQVIVc42mpJ0cJkcidSzgU7WTeNxFGtdeWKAVG8DlXwAvT
    JhPoBKvSW5zx5pfHAeh0vkZeeOCgsdhV1SAC4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121836; bh=DWUOsP
    k3WdSw3+oD1JrNuUiq/427WQdYnW/PnFTmUIc=; b=vuZ3rQlz8tmBGdRYX5QjQB
    H/BzrsI6AQyz+VrSV1zerH6vwiFgUYNKEFJCxGrhUhZo9GpWqaQxRTNos9mQy4Kg
    TdX3yha6O35ZeCx3vaZikLh1uXbRe/yHotKpJGSGms+3Ax4ILXjLL8Za0wxdQAHx
    QPxTVpwT1QW0GBqAb8KP/5Kbh/bHDQWbrUEbp+1xg/HPt5IC7f3Kjs36SuRLC0pu
    yiwkZECucAdFBf9BdwbrgYM+1ZTXhSxFe8YAD3kO/wQjxJqbQQBGYccQezpKbAir
    mDsWFWL0IRVugkNlzFRTXrvnDIFiatlYiW6IWO98hifVUb+zhYnW53sMa3QR4gZw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AZLL8193 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AZLL8193 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933695AbeCDADt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:03:49 -0500
Received: from mail-sn1nam01on0113.outbound.protection.outlook.com ([104.47.32.113]:58832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932516AbeCCWb2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 029/219] ARM: brcmstb: Enable ZONE_DMA for non
 64-bit capable peripherals
Thread-Topic: [PATCH AUTOSEL for 4.9 029/219] ARM: brcmstb: Enable ZONE_DMA
 for non 64-bit capable peripherals
Thread-Index: AQHTsz7q05+UCfefME+R8n32mbAIDA==
Date: Sat, 3 Mar 2018 22:28:12 +0000
Message-ID: <20180303222716.26640-29-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:zxMCm5bPqOiStd3cIrwNLTyuKRwBcp4v98OFhbwvYFvFogkuOEIjxAHANS28kRvaISuYDjOhrCSt4uU61oS9rpDIfK0KxZv05zhVpULue4KR7g/SQpKziCnJeZFLaxQ1lEhtQI8kMK9rs9ojLR/L34/PMBkH3sSYmyP5TL/qbxYCKmTOf4qj94Zglwc0mvpP69z2wTumXwIqkbITPDthSWl1hu45cDbN9ekobWaZDnGhqEhvg8tEijWGTpJUA2tl
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6723c1c1-6394-4e06-9b96-08d581567e57
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970BB1F4987508F3F613E7AFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(39060400002)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(133343001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Wc02rMRyendzZJ184YE9I+nSupTqH0FnJ3HKMwf1A/2Gj2k9gBHQ8MGmLXNk29TdNHAc2EcszeFKLFXjIBOcEuXxM1hAYx5rjOggRb4VOIyCnPbD4A9W5WmXTkPcGge31IaJ1DjRqxebkTZ4UPlcxRfC7GoPsbmgLzCyyZBYdR8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6723c1c1-6394-4e06-9b96-08d581567e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:12.6193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Al Cooper <alcooperx@gmail.com>

[ Upstream commit 3c51b9c7f1fae00c25f1e34da649a288e3fea1ae ]

Some Host Controller hardware blocks, like the OHCI, EHCI and SDIO
controllers, have hardware blocks that are not capable of doing 64 bit
DMA. These host controllers fail on boards with >3GB of memory because
the memory above 3GB is located physically >=3D 0x100000000 and can only
be accessed using 64 DMA. The way Linux is currently configured for
BRCMSTB systems, the memory given to drivers for DMA through functions
like dma_alloc_coherent() comes from CMA memory and CMA memory is taken
from the top of physical memory. When these drivers get a DMA buffer
with an address >=3D0x100000000, they end up dropping the upper 32 bit of
the address causing the hardware to DMA to incorrect memory, typically
BMEM (custom memory carveout). This issue was discovered on a
BCM97449SSV_DDR4 system with 4GB or memory.

The fix is to enable CONFIG_ZONE_DMA. On ARM systems this makes sure
that all DMA memory is located within the first 32 bits of address
space.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index a0e66d8200c5..403db76e3497 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -199,6 +199,7 @@ config ARCH_BRCMSTB
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
+	select ZONE_DMA if ARM_LPAE
 	select SOC_BRCMSTB
 	select SOC_BUS
 	help
--=20
2.14.1
