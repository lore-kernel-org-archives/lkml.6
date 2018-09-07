Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25080C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BD72083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UWr2jgmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BD72083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbeIGFTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:36 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:29449
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730921AbeIGFTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHLgGslqiFmb1xuAxV6f23Sg3L9UnElj560r/9L4FdM=;
 b=UWr2jgmP/kJum8H7InxNlI3ZCiNOB8eyxq6DEPUg2ltSHPP3nsP7pawkEsFVzHsVphK1lnxrnDG7bPQdioHf2wg16S8MGGbUv4g14GDLW78sPoKsofl0UCdElcbIhwBZIsNyAbP1PplEnIGD4dTjgRBvPDeckaUCCDBlABlLTxA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0853.namprd21.prod.outlook.com (10.173.192.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Miao Zhong <zhongmiao@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 02/30] iommu/arm-smmu-v3: sync the OVACKFLG to
 PRIQ consumer register
Thread-Topic: [PATCH AUTOSEL 4.4 02/30] iommu/arm-smmu-v3: sync the OVACKFLG
 to PRIQ consumer register
Thread-Index: AQHURkMpfUcx+iHoy0SfaFNVliXJ8w==
Date:   Fri, 7 Sep 2018 00:38:57 +0000
Message-ID: <20180907003853.57942-2-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0853;6:1LD6Fd19ZP7DQuYtqmT4viCW8q+IXweEdWLLhyZH1W7VtlKT1+xEiUGIHNRLFzKg72k1drhuifsjoDRKwuf+8lQnHyt3zQinyFcuHPl8LTw7B2gN+Ne6aBl4UCLmFeK8XOE2zQD9QONbO2wtMY7fTukaKw9QXBJbAOXZbCs9KNZpfhvry5ZqptJ+a/mQI3y/2+lPZ/TttWLnvY2XrYBDWDlovJYo8IfZkxtJEsKqJwj43sPaPDVSUTyle/dEuyLX5SeXTpNSQ/4CmZlGm4VSv10nxWUlNZLG5E3Xiunxe0b+5pkwIeI9XDQoTEIVubtT4nDVrA2c1JpY8mz52Aoqup1v/ilPrNORIkfjf1hsxAf0w3QT/tdkAq39Ob64agBTe6kdqohVmo2hwL2mEwwrq01wN5dTI82HF4BnFpKhDdqe7x+7+pbzcvRblCusKSPPMtyX7TTPjgINOPNc6v3IAA==;5:uahbhTKo3O58xu6YkP0LJ6YpB8nMZsj2ArNgpg32U0iXC6IR0JIWAcssjx8R60r55ylY3cFZK+pSJn0iwXKrOe5ylyDa81xlseh6vFohCRCKeaT9DMnzhzFYjiGo8m15iWFhxShJ924zqNlj3/oEg0X9v+OMS8torbA+O3EXN+A=;7:L9oxGk13gr0pLqAYg1uuABFxqSJTNzi80IN5BOWwlVzcFJ2YezkfWSUcFQTKKhOOSyBw3alcOy7UyI8lC5166QdmvRevCDfOICOPCd0LlP+cFAVNDCjLo29fVzRCskAp90mbg5SP+GUaNuY24J7etshXsDLqYa9gaZ6UE7BevOa0ldH1F0D/fIkGpDzGEij0EnQgNiU/aWfpZJw0hv10E7YTY4OirQUSJz+d1Yn5Uf6As65pfMiGBqpMWiXM8VHQ
x-ms-office365-filtering-correlation-id: 4328d328-36d1-4dc8-a741-08d6145aa465
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0853;
x-ms-traffictypediagnostic: CY4PR21MB0853:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08538C5396D8155E7DBE2623FB000@CY4PR21MB0853.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0853;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0853;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(217873002)(105586002)(106356001)(14444005)(256004)(1076002)(66066001)(3846002)(6116002)(4326008)(25786009)(107886003)(486006)(6436002)(6512007)(6666003)(53936002)(5660300001)(68736007)(102836004)(10290500003)(186003)(2906002)(2616005)(11346002)(476003)(2501003)(5250100002)(6506007)(446003)(110136005)(8936002)(36756003)(54906003)(76176011)(99286004)(26005)(2900100001)(81166006)(7736002)(81156014)(8676002)(14454004)(305945005)(6486002)(97736004)(72206003)(478600001)(86362001)(10090500001)(316002)(22452003)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0853;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TkiRb/3ZT4pXTs04gCfatb/HS8B3zO9nj9anZz/eIga8oSsYa+br5C8SmceABgCHyFVPSTtIr2cL18Pa688ap32cYCqseMsRfJuzmk7BoJdOfyo9Q/LkL70jcg5OUMkuSRnAclJLVxCtLIVwXdijuKnzwVNM06gjCT/sHyCVRXav2Ra/VoXkBilXmFg7rKgnOi6Yhr8F9xHCQ7f0RMATbQDDRr1+9JcAPyYeurKvuGGQLuWzD3J4YpEeq/+EJZgUatmjyH6ByIm/OUndrbHhE5nnet3isINoZ8B7mJJRWhs7T/MCJ5k4F17F62O6kCNQDoN5IiFMUlRsnONh2ErNI/qsbS49DT9Ts5fY1GH+Ar0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4328d328-36d1-4dc8-a741-08d6145aa465
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:57.6000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miao Zhong <zhongmiao@hisilicon.com>

[ Upstream commit 0d535967ac658966c6ade8f82b5799092f7d5441 ]

When PRI queue occurs overflow, driver should update the OVACKFLG to
the PRIQ consumer register, otherwise subsequent PRI requests will not
be processed.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Miao Zhong <zhongmiao@hisilicon.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/arm-smmu-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 347aaaa5a7ea..fc6eb752ab35 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1219,6 +1219,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void=
 *dev)
=20
 	/* Sync our overflow flag, as we believe we're up to speed */
 	q->cons =3D Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
+	writel(q->cons, q->cons_reg);
 	return IRQ_HANDLED;
 }
=20
--=20
2.17.1
