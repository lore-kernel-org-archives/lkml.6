Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99281ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A358208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FY+TGRZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A358208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbeIQIsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:48:22 -0400
Received: from mail-eopbgr710093.outbound.protection.outlook.com ([40.107.71.93]:31768
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730191AbeIQI3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuKZMw1N6ecuBgbObRFUs0+f0rxknSJ5GK1AjnCQcbU=;
 b=FY+TGRZMa0ExqSnrk0hHiPdHQj/fd+LCPcsaR67DsGdZhZkIrlhdHs3Ezn2vRYjPma++ig7X97HtHdvd+H2k3dbvo8ZCHq9IsrxuFC9SOGGVwVJd2cp1jRrUM77V1O0ehKWrLGAYbrydkp2dgtZW3IqrrMY1Abj/EvbSW+zwyXk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alagu Sankar <alagusankar@silex-india.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 40/87] ath10k: sdio: set skb len for all rx
 packets
Thread-Topic: [PATCH AUTOSEL 4.14 40/87] ath10k: sdio: set skb len for all rx
 packets
Thread-Index: AQHUTjLqq1XRxbDZ7kyNWrQIbkiSqA==
Date:   Mon, 17 Sep 2018 03:02:49 +0000
Message-ID: <20180917030220.245686-40-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:fMJXts+qmR4mEaHbApZn4w2xfjTpKqokROYQKeg9nYxy/1fgVsen8+Aj/x1yWC1x9bMec3iwbsKW3RC74zDF1z9elQCknrbmj7sBYmiW292CV4AKx8hci0e/Di9ydDXhZochBCFxwiVg/+AQGjTqth57TwqTNOIz1DbR4x7iM6Q7J6j//0g+TdWrxxD8/KeSE1dxUht1oA4rNEp+oZr6qTcACGb5mLNzsewwJboLZtMn1cnvGMULiZsoetRmwvxNLW5BRi9Z44UljlF9zUaI/Azgq47jlrT0w2fqYOpUBjVfYVLRRRAaKy800OQEIeg500oGO3DCbHiES7dW3R75aZvyEWxiLNVVeMvmdfOvF/Hv8HB1zfyQlc+vpKawtMcJywpvrJyc2X1wImh+5maEg1vgE87wnKZIK+wP9XFsmugJeewzRHpYEHMGWrsEfHXhC/C5/5JDYmwecvkQJLnfwQ==;5:N6zzOPWRxJ9r6wiTgparT2Pq9IZzGcCcyRRBzR8Q5s5JgQZhSJO7zMPSUcdgOg3ElgVAj5pXdwmdub0Otd9hsetdrGPnNh6ZhG0ONGCdiZUsRP41K1ITKVbQ7bEdIHXfBaGsOzKY0oUZEX18+9Gg6q5vlfWwymL0XJaxL69MOvM=;7:lDc2XOQlwXLIeXPZyXAFYGdF8mhDOlXN1d3GIDO0pW6Ejj/80bsw30t1EwJ2z0xa9iXVP9Gt3C1+Wn8TtfJpk9htUGAoUyQUO+7pMtjqFYvBy+TgE+pwWmWRtlCifS/v/SrDrVBIHTLkMP49g4/XFEvslBuh8BJ4gyFQSEajcEcQMqRrpaXJaLhFhT2GTZSVWMdtc7rhN93UWRtkXmjPZZFocY+aRX9YmAcs9LcRib87k3zJL1vcWRIsUxSYHqWs
x-ms-office365-filtering-correlation-id: 205db70d-1935-47a9-997c-08d61c4a406c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB07762CDAF7B7AA35BA94A570FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: lH48z7UjHdxjQZSAM4e505j4ANBPaJcvRnAHe3VMbfhz+wiMC9WL0DFFiVDxfu5CDh+aPCyIAUMOhTiepfAesZZZWm9za3O+u2maAmtPRoo6uluaYLOzIJxdOs9fZaXUttu9yFPAWdpdveDoVe/lM98GieocpFepWbcokyNNsLWKPtU320OhyK3vT+KiTi/h6qpc2/XYllLCicKtX4PNB2aOZwVZWwdj3OQkoGXpMMnMtzJtng9LMCYueotu//ZHJf+uQrHoUu8lLqGu2f4378FjlWdJxpD/+ACd/3uI7AxEGUEIOXulhmtj+HOTa42AMdvDTbEVcpSjVvojlXFD0bbKlqtrI6AwDjj2Y+7eB8E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205db70d-1935-47a9-997c-08d61c4a406c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:49.0874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alagu Sankar <alagusankar@silex-india.com>

[ Upstream commit 8530b4e7b22bc3bd8240579f3844c73947cd5f71 ]

Without this, packets larger than 1500 will silently be dropped.
Easily reproduced by sending a ping packet with a size larger
than 1500.

Co-Developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/=
ath/ath10k/sdio.c
index 895ccfb2141f..c5e6f4254e49 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -396,6 +396,7 @@ static int ath10k_sdio_mbox_rx_process_packet(struct at=
h10k *ar,
 	int ret;
=20
 	payload_len =3D le16_to_cpu(htc_hdr->len);
+	skb->len =3D payload_len + sizeof(struct ath10k_htc_hdr);
=20
 	if (trailer_present) {
 		trailer =3D skb->data + sizeof(*htc_hdr) +
--=20
2.17.1
