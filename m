Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F76C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EEB214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="bTAEe87k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EEB214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbeIURnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:43:55 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:28767 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389517AbeIURnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:43:55 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 21 Sep 2018 20:55:21 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id A93AD7318B;
        Fri, 21 Sep 2018 20:55:21 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,284,1534777200"; 
   d="scan'208";a="291574203"
Received: from mail-ty1jpn01lp0177.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.177])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2018 20:55:21 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c5nVPTJygk3Jf7jILP/JEaXE2rxvKuCdWpU1cEPqSQ=;
 b=bTAEe87kqGslIiUdoJgc57dMYil/Qp1Qfk76o7HLoYdLEfnltAlUWHNRB3nuUGSYoq/iz97CNsB4FgBbvw2FNoSVQbXQ5B63jeHN8uohnKGIABIdIpEZ/jUzVHdnuFoyUvEaWv/SJWtgv9mPe0jb/yST1hPiH0eei4xOb/LOLQM=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
Received: from localhost.localdomain (211.11.155.144) by
 OSBPR01MB2296.jpnprd01.prod.outlook.com (2603:1096:603:26::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 11:55:19 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/8] dt-bindings: rcar-gen3-phy-usb2: add no-otg-pins property
Date:   Fri, 21 Sep 2018 20:53:17 +0900
Message-Id: <1537530804-19399-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.144]
X-ClientProxiedBy: TYXPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:403:a::35) To OSBPR01MB2296.jpnprd01.prod.outlook.com
 (2603:1096:603:26::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de87ead7-70a0-4629-2b0c-08d61fb91ae0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(8559020)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2296;
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;3:dfZ379iHr4LecaDq7eKHCilfmFluuQEbvslhfJIISVINwRRQ/bTc12DkvjMFZh3sYFO+l100dm42ssgvxbwp+lHBtaV/ZoGsnFXdbFJWMudH0g49uyLbqbSa7nCeo3n11bcsa2RMPIyES00HVwa8bMVqAtUZAO+rnGAnVtp/VfHShBqoJImvd0uaBuUs7I7m9SglPBdNSqZge4Qvaj6sTcBN+cds6PnK8rChNAlDcn5t9XmdBzZx2CvUMy+/QWeL;25:B2Ujk9DQoCyTJu9uFxsGfjqbFncyhRj05Az0azy31jwVAywy+JxZQdVymauXWr+iHW6naOQlVDTqYdCfZuWOJb0XDtXhmz3cwXLXyqfSrqQujX2L5mxTwB8rBL+7RiPi8qyAJ2m5++eN4GNz7ZebZopfEvYr0pN9Dh4B1mRGuyIAGdEWcoBBNqmcmE7ADRZmgS69MYGVY5iqhmnRliZ1ESiFGhsuqB/w0fgp2OoajF4Gqy0Lf4pfOxc57yK2BwciJgunWrvuiTRhAfwDStQ1cEnWkplFi5PpqNGIl/55OrUag65/2te+wXkgT0SG6ws/8USOg++PYus20pvnXEZVQA==;31:ydtN9OVYQHBGy1+0zyT/SV50nhZmmwunS+tzacCocm8oOLk9uuZXqHAfraZC3J0hFLQnB/pZGZOD8aXmq2MdExEWOZEhtCBhYGzOcOw6eA86h4xgiUrYqVtZ9DqC6o9V8qpdE5MXr9+GGcjVd6n5FpRn25w5lJmyZo6Qs5dNdCKVJMzDqXdd2LtE2RL9445vnUUq7pPiUuyu9DQR8O1f1QEPgmc6SKKkASWlgHeYmZs=
X-MS-TrafficTypeDiagnostic: OSBPR01MB2296:
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:orfG6oKRnk6pb3PwOzT3ogOpFJz8Q5k8v0Fj9KLpA2hm8wS5TyK/iYLhDS0T+L6ttZ6ZrdiSptnBVoF6iuTov/bvbmE1zrXNEi3XdWUNm5J0EEcwpl/l/FwlcxDegx1xKQeBY0LhTix0dlrIWFM7/CNnBFgTH3aNuo3Xo+VDiJNdTu6HKN5yHvxsTFn2uRf2WvAv+YOugO7INFN+MS3TgkMktOFRCxnnERCGyVTRpDGo/W3KTaFq02QU2bvcu0T0u3UtLitdIu55AMHSgQCFN7yLzpEBddDFeKCrxEdD7Ev677Ui4TvU/BEHvUnd9voARk236E0ae0elOyayseCTZ5qg/GwLnxSet0CfGekgr5+dGWIoAaItRvAaUOgXNSviLDYLd0/ghOqjfXlMEPH/XmGV7dZGrRdC1nAWQVwbA4UNplBymCYh5p0Af2g/XPc9c/d6Ki5OBnStjIsF/yrtbxMPk/cINaYdlzCsm7ZRk6DEkzp2BB3oMlv14PAmYxpP;4:Lkz+ghub84+8oYXRqBWGU4nmzl+gkLbrXbxM6qoU4ikX7QdIiaiam1PmD0mzWrulWTNB8zwuRVh5GQBFJ8lWbSv2Bg6GIfFrL09CglBD6R9CWGIm1ZokTht4Rezfkdt/HUYY20rR1KfaUOVQ2dUo5UepCDBSbGCKn78ztNd2s8IX427M1TfXMWj3VnQwdYFJRbBPkZSb/LDg1iph58UQ2/DCc98/Vf0oJhw8Ir+jc6w/2XXAAkragVt3dV8Y2KoBqfc33QPPFunDFm9Y1DWKzw==
X-Microsoft-Antispam-PRVS: <OSBPR01MB2296280F2B659B644AB63842B8120@OSBPR01MB2296.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:OSBPR01MB2296;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2296;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(66066001)(4326008)(52116002)(107886003)(6512007)(486006)(6506007)(42882007)(51416003)(386003)(47776003)(78352004)(476003)(26005)(6486002)(105586002)(11346002)(956004)(2616005)(53936002)(446003)(36756003)(76176011)(69590400006)(16526019)(25786009)(97736004)(50466002)(81166006)(5660300001)(50226002)(16586007)(8676002)(6116002)(3846002)(81156014)(68736007)(316002)(48376002)(106356001)(498600001)(8936002)(305945005)(2906002)(7736002)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2296;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:0;
Received-SPF: None (protection.outlook.com: localhost.localdomain does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;OSBPR01MB2296;23:saMcZ50Fuq0Gg21NCfpVhWb7fCSjpV9rDMFvSD5GE?=
 =?us-ascii?Q?tXO2zWknS0AptFTZUxM4ROzFOH9Hs46uMDhLJi3PLxnIZqefFrQK4AxO1yId?=
 =?us-ascii?Q?DQiIQ7InsbYdp3b7zZ+XKtEnsO+hb38xVTdurbu+0xaseb8t8F8Oz5vEyyyt?=
 =?us-ascii?Q?X6pi9YixUN6jXDrG3/yYVk4wDxKyxWWJYjqYUs//oBwEqrm+2td/XXwUx7yp?=
 =?us-ascii?Q?HZ0CAB/QxBhai2qLT7XEKlSo7wCzCETKH0dg7tfEJTVIu0Qh4osbjDmVJbfB?=
 =?us-ascii?Q?fIB9Grq2W3GEa6yicTWF0XL4CVqCCkoglPdkJ1JyREOhF5CJnR+KkSifwvPZ?=
 =?us-ascii?Q?dgZPejnEU8OmHXAJ6GeHGbJKeiKYnlbwA2e2+l/MmCTvoPCjN7VvsK2NvJNZ?=
 =?us-ascii?Q?6NnjaWfkaMsl4PoUuPTCjG/n9zq/KlPgBfbAy17Ty3V4o8AED+JsKd8DKErp?=
 =?us-ascii?Q?5LGBmJlE7rn20NMDc5eVApCnLWn45FIh6BSf8JorUhD725yfyvicyGgj+VtB?=
 =?us-ascii?Q?h2pKg1hBvA+Np46KGIyguaYGGjxEDIG9P10HlZZv3OSYtov1u6jkD25slyrB?=
 =?us-ascii?Q?zq9ZYnqS02u8CFN6f5+EXckf5iWK70FKfOhPO8Hiz8tWX6MGAHd9QcaDBJr4?=
 =?us-ascii?Q?rQApjWq71W4clxD0bqNSBK+iwMsS1mVmpb42o1zkCPa8ChZ4j9D+9fhApkEV?=
 =?us-ascii?Q?cA8A5zcp7CFVSwjzT5tVsNDIXtaSuF9tKRnAUvCiuNkS0CeVATJkOfCpkpKW?=
 =?us-ascii?Q?+CY37mfUaNbFIEjBd2JKKDrYdfSQSy1i0GKsvEWfouBOdEp0mWR1P91keX5J?=
 =?us-ascii?Q?599d4k35ayvpZsX4+4bcJikkIQsINxBRK4USL4KBUhS37fE6caOmz2oKx0YA?=
 =?us-ascii?Q?/kDmumEb1pqXxXPySnDNMUS+I4vC4ZQD+ujxqPxllMn+Iq5aLjkmlNsJ1t+w?=
 =?us-ascii?Q?mpIQV9B74HvhdbZ8BF8T+/oSODl8rbvR4JXLFgpQyZiTgi6Czk9twLJYiVdF?=
 =?us-ascii?Q?Xy/oyZlGj9NtcX09l34qertA8ZHtlN7ISfopkoqFy5QqjOvkU4/bg6eIFg6H?=
 =?us-ascii?Q?SqEoN0aoAISsRUpWYpxfSHpXmKg26O0oTAXvk2zSb9/FG9ME7Bewbc1TkQH9?=
 =?us-ascii?Q?14fyaThhQ/vMwZomro9LUHfbtNokZa5lOTeN4AR/59iZ0304OX1pK0ah087V?=
 =?us-ascii?Q?yPtc83Q7MTeUDXQq3P1xI+M/olgU1u97kWm5pRg8g1rN+bHpGOIyhwpSg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: wOSRtOH27oaX0UENaJzkHW4yvLvgmH5tBXQJS/vg6vehnC4pkj0HDz2xFwf2+J4YcPH6QlMj2eW84miK1OiWVq/IXLzDSzK/7qf6yV5YnqObR/ZzNokLqYnVsH7ABVwJEU2aS8yrqQ9WxsaM5yIBZgnrgIMXYkZn3CnB/KXzbLUgYED9THf4gv9mjnLH97srmmvUrgR97g78rsw3khlbCuS6eulh6MJoXEF6mv4lyqUofSf74hroJUyQZoQQN1r44owT0pJxPFDlAUW62fV5OeGU4et90B5sX1RFzo69r2nO6JuqD1cB8WfyUzFnKXq5XOsaUeSLqV1N34rsx/c4PB6CBsD9dlQwaFWFLHgp37g=
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;6:m6Fa+kbAwRFJeUfOF8q8Z5C7hmm7tk2gD+KEi0Lf5L+rv/rVuN0fG3IzhBPwvibaolZC3fcimokjLDfMZbGfDYpFRmpP7/6sa+gbudDQNBnPJg6ab08U1W22zB0Ps/AHyfipicQjzFb7dot92KSBZTsezqVMD/qwF7ncQYhLwGtHi7D/iB7jVkOweKxXgXnCi0kfaHqS953jI3q9vh+5RbO63DpA1fh4WI8Nvs3p+6L1Sqk9ptPYizQGvyiAkiiFHBKxqZMY1Gan6qHHHYV7bBTPLE75szLmO6MGFXbKyHpBp2CL51o+PGQGH7NZ9xeJMmAPK420JvvuTCaIJN9JbUlkLlSdTRl/GCZI8DmIsyqNIqngKma/dbbr9uZxh7pWPp1bfCixWFAmpsToxKDY0ncdVEzHQ5as/D3otRhwqExzLduosfXvfO33kfc1aq6YysHPjtiKDpsQrGUrNLQ3YQ==;5:tmwXTz7FDd7GmaRQsleqVk9XW3ufBHWKx4pYRFP+fyHLhn0nmI7PzL17EA9g0m1UsVklQV/r2cj6S0PG5o1CBDZyDf9WXbbt4nNE6f2pUU0zrWlQ4DxA2iaqu/pYGhjd8hWz+C5W2QBL/q6KnXpkwd+0X5qqENlKKS/CR2M9QXU=;7:6mtK1PYhpqkIT0upwomrbkdh5Xk3rmID20zoEdBK9+jNu/SAK2b8KfZNi+DFmRte0NdH4iFIg5hpaCUPJtG6VIKfcmTk+LoAMNdirLxcl6BttHQPdX7kTpJANU9Kgrd16ChPt0E2lh//LBu99SIxzfNyPjb4q9rBbYG8skll7RBo+1I6ClaoCwEi88ueAHngOIyecYdm2dMagxa66Xuw1Jbp0aU7TeSyoTGRDg5BDpBoPLNFE6/rSTTqvRJF6pNY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:ByzVXywJ6iVJJDrjXfqd7PnsuKygHSbMp7KA/0ZyX/uCS2lgIt774cePUqvnTf9V4Iz1qY59X+89RNSQZxfGC6Ntu+OtH8Y6UvSU84wBBtiHmpFdiFVnIs4VQDhzoLloHcnCktHFWAVBdSE5hW0GVoLxiV1uVe5KuC/bGwPOeHg=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 11:55:19.8402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de87ead7-70a0-4629-2b0c-08d61fb91ae0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new optional property "renesas,no-otg-pins" which
a board does not provide proper otg pins.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
index fb4a204..b90d692 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
@@ -31,6 +31,8 @@ channel as USB OTG:
 - interrupts: interrupt specifier for the PHY.
 - vbus-supply: Phandle to a regulator that provides power to the VBUS. This
 	       regulator will be managed during the PHY power on/off sequence.
+- renesas,no-otg-pins: boolean, specify when a board does not provide proper
+		       otg pins.
 
 Example (R-Car H3):
 
-- 
1.9.1

