Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240505-2-1124770769534581386
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240504; b=ieHLOWtU6G8wGZ7WtY3FHQvx/CLMLR7FH3bFmo8X7MFY5S6VoW
    AD4l1zLI9THsss7JTug4D0+p4f7XJYMIYxQiw9kYoodCUJFdzrJ00n/SQl3iVANv
    zofSz5Dk8akl9YDOKiRdqISMkV8Vt9Dy7m+qz375h75jYwydJW6cb4KvJOIjYc4b
    Cxv/So8b/HGvLjUl/AdRzgU80j04myZEk/J8IxTt3IgYaIeqrLUAN1mzmL87wOnl
    r9cMau1sxuJ3ovORE/2kPY1evZHdunzIXsYnri171/BrNnHaCvDA2iniXxDIIPPh
    rBvM25C8gZqG6xaVjUcqlAfewGBChbTL9hfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240504; bh=x6dbnEBvgS
    MlxPksEW579KIrP4VRkkEDRs+gtUtQotw=; b=oRYzANBJgSI958z1vct4N08jYV
    6ELFmstUk8mWuzRjFnw5cl9h5UFjFqca/ZV19rsOPKVaNvnsXAwZk6PEN4RXlp9i
    eNp6WOGaYi5ZqJm1HbvaQDWIDcJKKzG1SzQ94UZwE4IGfkL/bDTZTm1O4BJlSRKA
    agEs5KYSGLWrWUEJJ3xeadVqaosUp1vrJispd+6x3Jj8tSJfO2kjFpuMmG9wxObW
    UKHf4SdOLfYXAwBzv1iH08X6HKw8m2qsPj+DJUCtsPthRWJjeFr9JsOIR98xXDki
    gTimkDwL6PmrFo/erdz7k/i54e3bow0VKKLxjxviDRf5Un8VQkPDMCjoyV1w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GbkUTVOW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GbkUTVOW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKTYisf875X3qQ9fk3hqIO6b+3i4/gxNwFD1vcM1LAYU/SZAhNvZUZ9c32V7OrSCv5WQX3EiiRUyNgWkZheH2q57oqF4ZH6sQ0FiSuOVjXh7HsvtpLum
    U4ekxcMvxSwDe3PwNse8tgPuehmbCpp6Rl4eZd//CYFaExkynSR84jKsFt42+74zljM4VXNo032BgvLp+aTAEsrR613R8gF6b2UYSMmxBd1Sf3uno5Y0MwsC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=Q-fNiiVtAAAA:8 a=LpQP-O61AAAA:8
    a=yMhMjlubAAAA:8 a=QhuOlXLQTCo54ItQNw8A:9 a=wPNLvfGTeEIA:10
    a=Fp8MccfUoT0GBdDC_Lng:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeDICV1 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:21:27 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:7529
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756039AbeDIA3m (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 114/293] brcmfmac: Use separate firmware for
 revision 0 of the brcm43430 chip
Thread-Topic: [PATCH AUTOSEL for 4.9 114/293] brcmfmac: Use separate firmware
 for revision 0 of the brcm43430 chip
Thread-Index: AQHTz5kb/7vouQZBhkmbrg0lcnTldA==
Date: Mon, 9 Apr 2018 00:24:22 +0000
Message-ID: <20180409002239.163177-114-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:sxlhy8OR90yHzRevWe3Z8Hzfc4WiGUYTtqg4RyHJRPHM3qJJItj7hT9v7OP4KLK0yItyM5A4ZGMY/upRCwyS4g2wo+2ZyrJXMgKau4nw2E5S1W7Xz2ZNH+EJQTBJksyDDBm/O5CeWOqmxy5+Ib5i2c5T4Qwl2Ls+I1Qa/bLWqqNcmlG3O4kUgEbSw6IlCTOvr3LM2B/z29i0/9xpZC0VPFkCgfYJtHhULcEfr50uyYqkpay9PnyG5GNcztMCiHgA;20:a9cEgiBzIbUJEpUBexn6cxIi+oEEgM+nKUAJdqJfKCd6iGtMFZK1+kzaHu35inqsO9BIvjXJ3CFoh+InavX1dUB+XblahiGdbEzzCmzrFyDwvx7jgKPmla1ohMSxbMBAeStWF0BGLj9QhHilw8un5hO3UxiMiePOywO8fhYJ1a4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b2a1161-812c-425d-f745-08d59db0fae2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10321A39BFC0805447948CFCFBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(3280700002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zEJq8K9+AmP6LUopGFfZzM2Wy4EK6s2yzd8QTv+5k0FyCWRuPHb6G8VF6ygXXnbRF92Cl/Oh6a/dc0jgPqr6CWLBmPG84AEuhXHXLjuKCo3w25XR2mwQ0d2g2NnAZhjct/S+U6+A5dmQsrmKbRjFN2s9HpYR/fm4rjbOZljTZVQ3gr2CpyRMllwuEVqVOWLOAeT+/NNr5AoNMgVCo8i7NvyRMfCK8LMdeI6aHyvK3zsSamIS0PAguVCcLrfxQfdR4zxJCwcJfJaOmrH33TslnpAsOE/FkYgQ57/chYAsMLqINTnmeqD/VlKV4Bp4baBpWi4M0fuCUyQSaU5dFkMHuxRQgL9ewgNrWYOobtZe0tDfViGHkxwGOwT2SuPVwYvHBBT4qNkuhrTFaHsEusPC8IgmeEOtaSOMliV0j7gRmIs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2a1161-812c-425d-f745-08d59db0fae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:22.4094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1278bd149839f2281db45a910082ba143546a148 ]

The brcm43430 chip needs different firmware files for chip revision 0
and 1. The file currently in linux-firmware is for revision 1 only.

This commit makes brcmfmac request brcmfmac43430a0-sdio.bin instead
of brcmfmac43430-sdio.bin for revision 0 chips.

Note that the behavior for revision 1 chips is not changed, ideally those
would load brcmfmac43430a1-sdio.bin, but that will break existing setups.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index d46f086e6360..3f3b6300bd51 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -607,7 +607,9 @@ BRCMF_FW_NVRAM_DEF(43340, "brcmfmac43340-sdio.bin", "br=
cmfmac43340-sdio.txt");
 BRCMF_FW_NVRAM_DEF(4335, "brcmfmac4335-sdio.bin", "brcmfmac4335-sdio.txt")=
;
 BRCMF_FW_NVRAM_DEF(43362, "brcmfmac43362-sdio.bin", "brcmfmac43362-sdio.tx=
t");
 BRCMF_FW_NVRAM_DEF(4339, "brcmfmac4339-sdio.bin", "brcmfmac4339-sdio.txt")=
;
-BRCMF_FW_NVRAM_DEF(43430, "brcmfmac43430-sdio.bin", "brcmfmac43430-sdio.tx=
t");
+BRCMF_FW_NVRAM_DEF(43430A0, "brcmfmac43430a0-sdio.bin", "brcmfmac43430a0-s=
dio.txt");
+/* Note the names are not postfixed with a1 for backward compatibility */
+BRCMF_FW_NVRAM_DEF(43430A1, "brcmfmac43430-sdio.bin", "brcmfmac43430-sdio.=
txt");
 BRCMF_FW_NVRAM_DEF(43455, "brcmfmac43455-sdio.bin", "brcmfmac43455-sdio.tx=
t");
 BRCMF_FW_NVRAM_DEF(4354, "brcmfmac4354-sdio.bin", "brcmfmac4354-sdio.txt")=
;
 BRCMF_FW_NVRAM_DEF(4356, "brcmfmac4356-sdio.bin", "brcmfmac4356-sdio.txt")=
;
@@ -624,7 +626,8 @@ static struct brcmf_firmware_mapping brcmf_sdio_fwnames=
[] =3D {
 	BRCMF_FW_NVRAM_ENTRY(BRCM_CC_4335_CHIP_ID, 0xFFFFFFFF, 4335),
 	BRCMF_FW_NVRAM_ENTRY(BRCM_CC_43362_CHIP_ID, 0xFFFFFFFE, 43362),
 	BRCMF_FW_NVRAM_ENTRY(BRCM_CC_4339_CHIP_ID, 0xFFFFFFFF, 4339),
-	BRCMF_FW_NVRAM_ENTRY(BRCM_CC_43430_CHIP_ID, 0xFFFFFFFF, 43430),
+	BRCMF_FW_NVRAM_ENTRY(BRCM_CC_43430_CHIP_ID, 0x00000001, 43430A0),
+	BRCMF_FW_NVRAM_ENTRY(BRCM_CC_43430_CHIP_ID, 0xFFFFFFFE, 43430A1),
 	BRCMF_FW_NVRAM_ENTRY(BRCM_CC_4345_CHIP_ID, 0xFFFFFFC0, 43455),
 	BRCMF_FW_NVRAM_ENTRY(BRCM_CC_4354_CHIP_ID, 0xFFFFFFFF, 4354),
 	BRCMF_FW_NVRAM_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356)
--=20
2.15.1
