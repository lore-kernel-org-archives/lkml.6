Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B5CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7242086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="pAKaZ0fE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7242086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbeIXVDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:03:51 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:2846
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730302AbeIXUwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssdWCuUhSMgW/ajnu2cehVFqxxqMR8zRZa47lwL1AaE=;
 b=pAKaZ0fEhw362AtVBN49H2mb6f5VBMxYIqkpwi0UWXCQihy08/FswjKh4nmQVKsca6zmvrXNqC+W6gCivOF3FSwWlM756Ra//MHySgVejjDDkKkFs0+w4Ff2D8IVkiBn2B9ch8ZOWPdmNvIAtmzkIakNm94e40nDiTZUNIZVIvI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ivan Mikhaylov <ivan@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 65/76] net/ibm/emac: wrong emac_calc_base call
 was used by typo
Thread-Topic: [PATCH AUTOSEL 4.18 65/76] net/ibm/emac: wrong emac_calc_base
 call was used by typo
Thread-Index: AQHUVBWuvqsWtqj/L0+HrTOYvLJYiA==
Date:   Mon, 24 Sep 2018 14:48:40 +0000
Message-ID: <20180924144751.164410-64-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:UnUt2KZvo22eZSnFjy+zDij5DE0RN1ZAxpXoqrOT2FXUTi7xd+9l/2bpDcbrEGQiy6o9udIp6iFv/hWkgDCQH0usCLp6/6W39UbtSEt9ncEdfkULWbBsy+pWVwhCQ5hky40jP63Z44Ioub7Of+FOasx3fZkTRFBDGHexkreQP7GKQM7Va9SIichtL4wpP9E3p1jXcEhOMLc7hC07wggq+CPmebXU2eyXeYQyfq2iOSHpWF5EiNU+/d693ZgV19KKIDtw9409wQyxfqer/O7RFBzoSqXiwVCQ0i/kV5a/LoiojL/iU4lntZsiv6VRjI4YGTBNQTmgHO9S8c1FWB9uOsWcZwTY3yi7pqbQ4WJiKMPRp0qL2LXNLijDOnKKllgf02Nq8nfRGmn+CD2Ezmo1PF0FM366ens5sKVXScRoBb39GH8+zKAUadjHmIlM76IXm9WBWkTS+tr+BKG2UPHO3Q==;5:mFkhTYNgmaD3lCCe74nku5rviDCGy/cm/Cr5vV0gSGzvNNUzaaBgpfIz3HSaO757VOSXuGzUb+NauTz6CxwY3z42SJlPktNmch4bZ+9eyJwkx8W5BKF1vTO0akf1AZhyVBSZxex/C260LE3aOk2YyorAW0rmA7fJecuefZJKGeY=;7:9thzorXdeZTu2zCRu+TA9xTF+QWR1Mlelzfkibx9OxYpjKbX5kpPs7KW0DAwP/KXXKldzPgrTmLT+qHSIETGBAk9jofwGAEeKICbxMkQk2OFBu4/vS2obayM9JbA/SM1Vtbzxg76pcT1WEvDtrFwcEHXKRgsdyhM//qXnEEESlnHZ+MnneHrU3jO/vXrQG4dpT8bR5NKqTCl+nikIKDJfKfWbfQsTaA/8FaZ2gbbh6r23u9dZknAypOoSEKyWZSZ
x-ms-office365-filtering-correlation-id: 7cf3ba6b-fc81-44bb-fc4a-08d6222cf1b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0471777AC4B28DC3D75DA1F4FB170@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190383065149520)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(6512007)(105586002)(256004)(53936002)(106356001)(10090500001)(6486002)(217873002)(1076002)(6436002)(71190400001)(97736004)(71200400001)(446003)(476003)(11346002)(54906003)(316002)(2616005)(86362001)(575784001)(2906002)(86612001)(8676002)(5250100002)(26005)(81166006)(81156014)(36756003)(10290500003)(4326008)(478600001)(2501003)(7736002)(110136005)(2900100001)(186003)(6666003)(22452003)(102836004)(25786009)(305945005)(68736007)(107886003)(76176011)(486006)(6116002)(6506007)(72206003)(3846002)(99286004)(66066001)(8936002)(5660300001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P1wF/YkW2R1/CoHMWP8o4ZtOOhvxLbiy1jzN6Ggb4yzjHk9TuKpm82wW4lBbJh06I/54Fz5PkphLdDTP+vaC2kh/uyfrVlZIliM7ZcxV6V2c2fp+NhGAviFM12R9dPoeh1YstH01NVWXpiiCuKgPRJsQpZfo23bbwDyV0EzZuwvxfw9zq3EZR5rhFTgpB+WrKntu/DTv7fyB4uonAnbMU1xxtTtG5iCKoXcoewbXxIrEoJKIdAKIFl4NKwJuZvn4R+n18AqVCtiBcnB0hN39GJY+Ei+CrIBDISDajB33kdDEJZ1rRj4fG3Asgrtk8cKNyx22rZxhaT1EJynqa04eXi+bzNJ2VtXWkE6LFmWhib0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf3ba6b-fc81-44bb-fc4a-08d6222cf1b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:40.2504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Mikhaylov <ivan@de.ibm.com>

[ Upstream commit bf68066fccb10fce6bbffdda24ee2ae314c9c5b2 ]

__emac_calc_base_mr1 was used instead of __emac4_calc_base_mr1
by copy-paste mistake for emac4syn.

Fixes: 45d6e545505fd32edb812f085be7de45b6a5c0af ("net/ibm/emac: add 8192 rx=
/tx fifo size")
Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ib=
m/emac/core.c
index 354c0982847b..372664686309 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -494,9 +494,6 @@ static u32 __emac_calc_base_mr1(struct emac_instance *d=
ev, int tx_size, int rx_s
 	case 16384:
 		ret |=3D EMAC_MR1_RFS_16K;
 		break;
-	case 8192:
-		ret |=3D EMAC4_MR1_RFS_8K;
-		break;
 	case 4096:
 		ret |=3D EMAC_MR1_RFS_4K;
 		break;
@@ -537,6 +534,9 @@ static u32 __emac4_calc_base_mr1(struct emac_instance *=
dev, int tx_size, int rx_
 	case 16384:
 		ret |=3D EMAC4_MR1_RFS_16K;
 		break;
+	case 8192:
+		ret |=3D EMAC4_MR1_RFS_8K;
+		break;
 	case 4096:
 		ret |=3D EMAC4_MR1_RFS_4K;
 		break;
--=20
2.17.1
