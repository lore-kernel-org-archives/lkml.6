Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487117-2-12566774468691785551
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487116; b=A+zG/czbd2MOOtvVyK7cCDM/g0pSVQj8bOQ3NhMC+cuzaVh
    Y/7wMTxNC80HasAzZaoRW2e7/beB7tx2Rp2N5Ktv0/GwQ1glZOS3NuB43JgALfF9
    XX23xPTr4YqKs4uxJ+bjUPz/S/94ETFCW07K9vJSvqtuR8F0oIEwptTu5wUhOQR0
    mAXfyuBOWTwP7aJRUGPy5gSFGIsZsixpDj8g0Vbm83QnrFXlj0byLKiVhZfPYxdD
    wac9pz+GmUidFmp+gTRPxB75NMWdt5gAsWl5fHZLpAd4kPTpMO1POEVXWuR5cj4Y
    Pus1qFjWJ1rU8CLYZsmz+WSjiiLozooGdFE2g5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487116; bh=MNAHZQ
    QgKzMt4ejP+5nJrQa9AlLVGbtZ0GeZXwMiDhg=; b=tH4ddkRm4zttrDN1XYW5eG
    uKclRR0ce5upzxuhyED8qZlyjUZN9UCcOoPKxQ7hbuwNRqjoQBONRMOM4MKBxH5S
    E4gp8o/HSlyxNVS8wDS7BvWr2PvmZViRYCV+CD9MEOM0jc52g/JKNkAPqknyoHur
    puqvrcO+sqciOYc1UZwpq8ErlwGNks+kWLU/W5iM1uffijiIVg7zLnq6QVIt1mF/
    kz4vlJ/FiWBjKbQDpqBxSlRRyfBSYFv7CR4Jc9UeWDr+AuN5ikm1jBkHoEldeoP9
    9WmEToLyXketnCCbkODzMF8RmxiIMl/w5ZoXQPs6XNO6tjH2URVxYlIYZPpCn3vg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XfUCXfXo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XfUCXfXo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755243AbeCHFbk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:31:40 -0500
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:18336
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966416AbeCHFGW (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: yangbo lu <yangbo.lu@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 060/101] mmc: sdhci-of-esdhc: limit SD clock
 for ls1012a/ls1046a
Thread-Topic: [PATCH AUTOSEL for 4.4 060/101] mmc: sdhci-of-esdhc: limit SD
 clock for ls1012a/ls1046a
Thread-Index: AQHTtpqV8Kc3dKzmvEuhoB7ldYevlg==
Date: Thu, 8 Mar 2018 05:01:56 +0000
Message-ID: <20180308050023.8548-60-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:x5tJ0NwWWuasJMqimDTUh6F5cdCY1WUMkboL8hQlCL/ayM+fT4br7ZValKNLO32m3TIbPf8pPqMSp0OgjOlwulc4ih6xvW20/n3DUcpOtblEfmlYbE5hmayJ1A5JX8nQ1PoByRii8ap6fcw+nM4LNJQF3bZ07gP0QBdMJipW+gpfvR5Lyt2a147ZFUstMA2418z0zf+wkx1lN7WTe0N1UvzyHbl0OR/mze5qx6jNSRxr/4TypV4Ngk+EdMl4MnNm;20:U3FSKUc7mtsvqTX1sS9USQIgcixNmdfcIZNFwQ2aKTbG/tY2Kz2SK4NMLTlYfloTDbMOEvxVdR6McRiJfw6dwy9OeRCDteokJE2w0uwfkq9HOTxDLKe4XvV7Q1nZGo39dnxyQyn23jfmVPxar1DCubhPVUjhtx4gMttIeCNJp9c=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd17d69a-7729-4c8c-4786-08d584b25264
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917D33E8BDBE3BB382D8BFDFBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(8656006)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: weLPBMr+YTuJYzbUpfkRsFDSIXuVp22YByckoI0LDl8rR96sWZaeWg5tu29vkg/775lXMBNdjjSWWiCZOzKIZbUZ/bem0JM5XVCSXK5jdcJFmc/qUKeNV89s5KJ79sbY9xbc5KhO6761JPao3i2AW486WnF6FI/r8FUDKGP47HFcnJ31fOqMASe8Tmf+KGG7ObntiWXASBkulP7clxeTViGdjEA5SRVg0Eo1D+7TycgGp1J+GGqK0J7F8t5n0lMbSNQu6o7B9t00elb3JP77MZFPMRZ6zP8oub0VFwb6+7jjzmNs5+A6yjwqKdQBJ0XHL7dKOjzBnxwpwfS09t0rZQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd17d69a-7729-4c8c-4786-08d584b25264
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:56.8100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: yangbo lu <yangbo.lu@nxp.com>

[ Upstream commit a627f025eb0534052ff451427c16750b3530634c ]

The ls1046a datasheet specified that the max SD clock frequency
for eSDHC SDR104/HS200 was 167MHz, and the ls1012a datasheet
specified it's 125MHz for ls1012a. So this patch is to add the
limitation.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-=
esdhc.c
index 83b1226471c1..ac66c61d9433 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -418,6 +418,20 @@ static void esdhc_of_set_clock(struct sdhci_host *host=
, unsigned int clock)
 	if (esdhc->vendor_ver < VENDOR_V_23)
 		pre_div =3D 2;
=20
+	/*
+	 * Limit SD clock to 167MHz for ls1046a according to its datasheet
+	 */
+	if (clock > 167000000 &&
+	    of_find_compatible_node(NULL, NULL, "fsl,ls1046a-esdhc"))
+		clock =3D 167000000;
+
+	/*
+	 * Limit SD clock to 125MHz for ls1012a according to its datasheet
+	 */
+	if (clock > 125000000 &&
+	    of_find_compatible_node(NULL, NULL, "fsl,ls1012a-esdhc"))
+		clock =3D 125000000;
+
 	/* Workaround to reduce the clock frequency for p1010 esdhc */
 	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
 		if (clock > 20000000)
--=20
2.14.1
