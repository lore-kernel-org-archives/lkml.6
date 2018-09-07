Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D693C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E472083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KFxCBq59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E472083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbeIGFUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:22 -0400
Received: from mail-by2nam01on0091.outbound.protection.outlook.com ([104.47.34.91]:29984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731189AbeIGFUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwngJxouxcCzCp+bwRwzO70yw1obsx+mgKsnkX5jVNU=;
 b=KFxCBq59McJ5daOCvRCaj2Ai2bKGPtPKLWpBhaxcIyWO2Rvce6d1nmVFa+/nwaf4y3wbNtQDthoj/ezq3qDkX0mxWZnWgwl+F50xbLgoM/98z76Cu0BHJBpBORH0CZ2qNahOqnsB5QJwPG0cGUi7shAd5uQPL6yzkYlsxUv7eVE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Loic Poulain <loic.poulain@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 26/30] arm64: dts: qcom: db410c: Fix Bluetooth LED
 trigger
Thread-Topic: [PATCH AUTOSEL 4.4 26/30] arm64: dts: qcom: db410c: Fix
 Bluetooth LED trigger
Thread-Index: AQHURkM07RG7qM+HPkeMhtKwGfRQpw==
Date:   Fri, 7 Sep 2018 00:39:16 +0000
Message-ID: <20180907003853.57942-26-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:s2/DWyCmJJufd9xbXVZ3UHpShxMWWedYeDeTLzSFO4SSUiAanx9Dh5braOBIz4RMRZ07iUO2W3KIUoUDTRtVX1JVA/WQchMTPYHiRl9wuum6VR2HaX+mIRVeXnyWiNZY0UHsXCbr1nqYJrb3SIj27BzuNZitp9jwjHd0d9t1ZeLcth8FiOFF5ScDezM2BReAnVeQPugMI7yih35PYRMLTt0OmVNkYJ4Td/ziMHco0occuiOyuXaUy+L+OOIxinAyr9Ap9ONna3r4KrOVzPdwxqMT/eq689Ri8PEzHP7udKiMZzKvb1y7CfmOncUdvwlQo7LSjCWysKPmHjybDUINpf8gS3nyhVr+gwup9LdXV0QcodScgm+ZY339r94ytJttpZMgUkZw5ij7VNwRe2n0pebi686fRjMMDI1nEAhB2BGnpA9kxfGq5occdOmajOgbfIsflPOdTcEM9aYee7zMCg==;5:0bRKU2MjFMkq4PJMd3Iiy0y6N+EKrzqa26N3sD2rSorF1q6IporG3inQ7K4xiZs3ruihdY84/kJNoniB5js2/64bXN3/Coi84b4wd7KOQItyxO5XLTvbe1NkfvNz/qcThhotW3MiRN3+VfcMolaNZGm7cg/ItnJ0cyY/uQTAE88=;7:ERytH4qhiDeTnHF3V2ZrrFURbWiRVNvTj8YrHc9OJc3yANz5aC3E14fw/Jj4aUyuuiveq0OapHHEfGBJGKZ/JQOUS3c/K+RAiboQAeCwgmuphcGKI0tn2JY1c0MwyGWvEOa7xgIuJMeRMfz4ttz3uWaGhqqajMmWHQPPxRDlyCHCGhXIbDYoGQD4nZB1AOZgQrx+zBO3p+k10sndTRfFmwhW0RL6Uq3GcHWeOivdma77uPBwSpnL0miGo+42/sIJ
x-ms-office365-filtering-correlation-id: fca888f7-df1b-4be5-337e-08d6145abc47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822FBFCFDC63A729618C528FB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aG5sa2xj173tWa+6aD9DutE7YA1W+E3Xyx3h7rVBXdXNzk07SZjhzMMS6L6TZGbScwGPscE7A+P7n09JnAUunQeVV4ocK8Hn4b1SKnUGMyWQNqutElJpJWIsurTiILs1MabjlZGyUdsihAqtWjJ8fDGl9dcTlbtW+E7QhKYrYHiJcUqdGrqZnecMCoeJqGI9W4CklxHe0V/2fsM+9DBYrCWUKPH0S2wnww6yLjhvYrXMofncPV+7uU038jg/zMLrCgF71aXyDQzkICsV8PylueUUTxQgctLeD4aMc8uljh0TzOFXCDqj2sZSUHkPA7eauwzz8WIVM3wX7ztLyqVhRaBfC3TVKaymPJUo019RWN0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca888f7-df1b-4be5-337e-08d6145abc47
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:16.3298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit e53db018315b7660bb7000a29e79faff2496c2c2 ]

Current LED trigger, 'bt', is not known/used by any existing driver.
Fix this by renaming it to 'bluetooth-power' trigger which is
controlled by the Bluetooth subsystem.

Fixes: 9943230c8860 ("arm64: dts: qcom: Add apq8016-sbc board LED's related=
 device nodes")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dt=
s/qcom/apq8016-sbc.dtsi
index 6b8abbe68746..3011c88bd2f3 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -105,7 +105,7 @@
 			led@6 {
 				label =3D "apq8016-sbc:blue:bt";
 				gpios =3D <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
-				linux,default-trigger =3D "bt";
+				linux,default-trigger =3D "bluetooth-power";
 				default-state =3D "off";
 			};
 		};
--=20
2.17.1
