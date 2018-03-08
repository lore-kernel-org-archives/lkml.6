Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520489115-2-15237490689642326549
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489115; b=VZ8AYgYMvKFeq8KUSotl+hwb27+Ffc6Bk2a+uZHtiWE9N98
    86c198Ql/+3MrP5NQ1T5PgfXqo90gL8B+BXJqP6Zlwa1TNVUZkO5Owfn4EQT0h8t
    IcpA3NxBZti0uu5KHgTbzjcKzHUKSzxq6r0Vbi9MgIvtKVZekj35o/fZ982m26av
    T2z/hZ/6JuL4Gz9rkU3N4yshKov0YJl4YkxrqF/L3SM7w9UYPdE9xr8dkWSjzbQM
    VrPhnKzdrUeDqBGlTlObxSTyDkpE877OSoiQUqLB5TbKgY6sjtPrJaCHh6NErIBv
    7Abj23rFtKHfnc3Z8DB/uGZtLTxRoXZoJV/Sg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489115; bh=48yDAH
    nN3Sz7LQAiRuyiT4nMRnJ5wbi9jDnt6fpIJ7s=; b=W460T7/QKTVTiiuo4meddQ
    cmBnheHZy+ukzykvgbcb8goTwhEiyBvwo0tTpN524SEx8NytrLXWoHTTRotD54Gh
    Eb199WEULMCvxgzEFEk6sye29sdHWxfqVdnZbCK5nG5twFId3oVi4UzO5mPvoIxq
    8IcOGUyHtrrz4E8UmNoZXOQXzZzBWnaK08DQRtsFZ61g9j8ru6BUFlXi5yfMg/nZ
    SqZ4JCsHW2ONw69bTZiejcA8k6wzIBRn5D2dP/2FTws2ET/lrWTsZTXLhq1TNKhd
    qzJ1HUCYjOpNd4HD3hI0BLhyr+0ScCspGNtVII37rgR6LpD9R7lVpfpkDaa1VnFA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LlIBzbxn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LlIBzbxn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755243AbeCHGEn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:04:43 -0500
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:45129
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965855AbeCHFCW (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: yangbo lu <yangbo.lu@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 109/190] mmc: sdhci-of-esdhc: limit SD clock
 for ls1012a/ls1046a
Thread-Topic: [PATCH AUTOSEL for 4.9 109/190] mmc: sdhci-of-esdhc: limit SD
 clock for ls1012a/ls1046a
Thread-Index: AQHTtppD60q6C+/vCUCtrIcwFAoSaQ==
Date: Thu, 8 Mar 2018 04:59:40 +0000
Message-ID: <20180308045810.8041-109-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:ErKGy+DTm5VMYVmhfU1oPct1fmfuL9+E4EtKw+IfXs4AQF32SHD85bk+lI4Us4dXpbL16UZmhwJelSsycKUrwYtvzgngePpX/tIuzxnYqLmf4N7IRAYCuYDiBohlSoBhSF/xo3WCXdvJvaqIH38isM6uBQD6Wh3t1AueQXOWzjj4FDO+3fVmXbNB/z+uUAUeZaVrOnMZta4SKaFwOR+3XZbOWxLQV9om8ULvts+43sARV+arxjqQUPkUPSyBrTDy;20:iONk040IXmhAkTVhPE+0RJESCJSDA12wCwkga2cHbz+JorHTx2oPrYSutcH1OzJLTEzwIPk55P3pZGiguzlsR8D+qKsf9qdP/T9Bpp0gBQsbym6EIB3sY7lL5zDR98EekpUbPzzUu4yKvLjTKOHCI5ryNBaa0cPpYr+BKA4ql94=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ad06f15-46dc-4e86-22f9-08d584b1c296
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0997C1D2C188C98FF0E72635FBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(8656006)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: +zez1q+vcHpk91Smu02fhgT49SUfVoC8cUFrPMrAVlusk5Y/VvqtXDOfMdf1qf0TRw4mU/RI/S+MlHkmecixqe8NesyNLEB3JF85R36PKUTVo3uFNVXyNz1GBjalcn2H6Y04Kmq8/4AyPznxtG5lksNZt+x+BHsXo/qCReFe9rYCcmzYah/JzuLdpQzaCZYWdoC0WcGyDL493kmw/ccWApW++7rtdm+N5alkLgbFv4OO+8HX6A1TElBUOXur42l1BVxETOYRti1CP8QPjcgirm2S/aNXFQrGRmi1kxn7QxhKXTzzwMkyPYoezOOresxES06xCYTzxLP2PybjG+0cVw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad06f15-46dc-4e86-22f9-08d584b1c296
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:40.0132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
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
index 3c27401cf7fe..a51d636c2312 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -432,6 +432,20 @@ static void esdhc_of_set_clock(struct sdhci_host *host=
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
