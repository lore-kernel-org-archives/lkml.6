Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F9EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65ACB20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ecm//g9d";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="HG81EJ66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfA3LFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:05:17 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51410 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729299AbfA3LFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:05:16 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UAwtC5016613;
        Wed, 30 Jan 2019 03:04:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=dyrt4WwUr/k46KnPUxgwpKZHPEh2EMjOWoGSRSthEg4=;
 b=Ecm//g9d3fPDhzqpb9yGwM5RbKTlVURnTNHW3FSd7k3iha1NVvKbALcUiR2T+qfRIIPL
 zPaWFZ6bRegzaKAzVB28NT1JzhYasX7BrbP5i0xwFR3O5DRBf75UGuvaeRXie6eZQ/B3
 Y7UyT/b9dDx2YMxT1399J5jXNe4l8hoEGwReCFjY6QJYagerGqwxvhTJ8KzDguZdMR8E
 E+Npbdr5eBVcVyv/RUtZe9SSWocrcL04YVeJ5tfX/4kWvZGvFXukK6IV0+74DEStKFvR
 VZMX//oGsn6RBWHY/ptJqKHW2LyJ+xoDM6GOUNv080pJHsPBbs/uCNr50i5II/47qypZ fQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qa8178d8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Jan 2019 03:04:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyrt4WwUr/k46KnPUxgwpKZHPEh2EMjOWoGSRSthEg4=;
 b=HG81EJ66n1/c8tqOriTN80izfZYckexa4fWYQ4kMI1dijyOvXlHyAHilaQ4Mu2dk9nsSPsBB5l6jZFvtujhf50cNMajS+V1r6kn0vpY8Fa5BRjhr2U0VAXt2aznhwIrXkOCfzbI8Rd0hwBb+WiJduSoXp87LARF2jIstJVn7OL8=
Received: from DM5PR07CA0039.namprd07.prod.outlook.com (2603:10b6:3:16::25) by
 BN6PR07MB3090.namprd07.prod.outlook.com (2603:10b6:404:a5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 11:04:38 +0000
Received: from DM3NAM05FT064.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by DM5PR07CA0039.outlook.office365.com
 (2603:10b6:3:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.17 via Frontend
 Transport; Wed, 30 Jan 2019 11:04:38 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT064.mail.protection.outlook.com (10.152.98.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Wed, 30 Jan 2019 11:04:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0UB4Xif009639
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 30 Jan 2019 03:04:34 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 30 Jan 2019 12:04:31 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 30 Jan 2019 12:04:31 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x0UB4VbI018087;
        Wed, 30 Jan 2019 11:04:31 GMT
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x0UB4Uj5018077;
        Wed, 30 Jan 2019 11:04:30 GMT
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Andrzej Hajda" <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <dkos@cadence.com>, <rafalc@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v7 2/4] drm/dp: fix link probing for devices supporting DP 1.4+
Date:   Wed, 30 Jan 2019 11:03:19 +0000
Message-ID: <1548846209-16406-3-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1548846209-16406-1-git-send-email-dkos@cadence.com>
References: <1548846209-16406-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(2980300002)(3190300001)(36092001)(189003)(199004)(6666004)(14444005)(356004)(26826003)(106466001)(105596002)(48376002)(54906003)(87636003)(50466002)(478600001)(316002)(8936002)(16586007)(42186006)(110136005)(8676002)(50226002)(36756003)(86362001)(305945005)(4326008)(76176011)(51416003)(2201001)(186003)(7636002)(426003)(446003)(336012)(26005)(11346002)(246002)(476003)(486006)(7416002)(47776003)(2906002)(126002)(2616005)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3090;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT064;1:7KTQnPLRY4xVupWq3BhdILspWqxV97ls5aEh1CmydAruVddjHJ0tlHXVlW2pQ9uol3yq4LnUYGYs6plEyemCeZz4TbPQX49j5Tjbk2jUKiiHeXVO2V6aTCcuNU/6+uluAVtF8QFAAn//6VG9GAyHdoGCyz3Y3u5xUS2j2PrX38Y=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc231dcb-486e-448a-9733-08d686a2b9f4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:BN6PR07MB3090;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3090;3:Nwh4Rx5ja+LHLZ0d/Yhg/w02mEXXtt1+P5/ht3HgWEu1CWO8uaHGiuvurR4cuc5CKH2KpsAHZLeIYa8yqkp4piyQqJy1tX/Aw/Rpaxgt3D2WmKOww/Mh4ab15bIu+PIhqDvh36GjoTTxpcYIy5Ukdq1Ywpgm9YqoikkcXWiEtzWtnAX5q8XXSCcU+MO8M/wD8kRtC4HVrYuk61HiCfjmhTNFH0gT6ZVblITVXdwx+HXdOX+Eux183Patl/Ua3bGCfhhGDSBTJURANXx7I5pb97JSwowrIM/oRStouOJtqDvDThqUQUrWJA7gTfou7RlP3w6U6yyuT91QTDaHKRuBqMvzC/5Tpe6q6AiMD4XjkOake83hvGmeFKz96mtMXYSA;25:5cbkLeOZbyMHspT8u7lEaZ82Fu1ofUJHG6KP97uEd6W9HE1LVuFMNM+fvfr6LkDoRDUDBWqpoSlLdv67eEF4uNK3GMCyE0R/YUgQ5HuAKqKF/VUOt9sv5OifhhGCG0N+6v52QnFa3kiW8vxlG3k5hAmBmrWMvMopJOeoPB0A++G4W8ajYZ9yPH/miNqR2kkkHT0cPdM/vfpvrb0WoCrmqW1WcSAiUXwUtLzEeAcxKbBkOngH6xzyJs+xnNP+e0I/33VJdWinJfU7yN6PZLdX9taZeGmFyatYCpLHy3Kgcx00dqtHUZ/1fanYinhOOZhE6NdFq34tf4UFrpC38lg5SQ==
X-MS-TrafficTypeDiagnostic: BN6PR07MB3090:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3090;31:1lhETgAgcD+rujtUZZS7D5R9FIxeX748p0icaF/0327XQ9ocjxdV7cvTdUJl+QVx9fVX14f0LB2A6EaXi4AVt+Zjy1nr4ZGog18AJvO/c+DE1UDRx96lQMVavJMjmn4alAJrIzPp/sMu8HN0FKW6Wx3fDHZnCWbpvFXkXw1O1Rz0ytqfFS1tEYXjIVAliERolgkaodvhwC57qubIbxAdLqtCv1T9PVBa1KitFANg6Ig=;20:w3zwvSLk8/X4kdNqtZXdrmWQwb/IgVSno+TLb0Yzd8uNrdPrDH8/bJiMd1X0FMhGt5rFOCH8quBzrtjMwfUlN1gOBKWi8A/VZalEfK301MtL0zrEGUufbOWG/SkFpbldt15D/yirAfzJo2OZC1oIaNuYnQ+8NhwUMdfKieDJbkLYRhC0jBQVzGPeMEo5p3y30tbapYiMcL6XPIi9lhEfIRkWTkma4HUcSkCFJ1YtQiGJEBiUmz4SKr2JAYPFi24/U6Rd/o6zP5n4Ybr4XQE1IZTueqCRSLLB9q7+fqJeGEvTFUIx9oSVodJ0h2Mj8AxmJ9iH5Vc03VMl+taNUEzZflHBr9OLbye9KCAokozILTHbiWTKwUWkSOHUJB1SfbhY2Od9Mc7FNdv6RFUBPqL422IqqStcNVpygF/hkdPSRRZZj8YnhQk/GBIAmlf9IL91eF5ZuQpPtam39pn9nRbqRmgCtL3ipbqjZmob72U9z4ndXSVtJ6TN0e/Lv6F8FGzP
X-Microsoft-Antispam-PRVS: <BN6PR07MB3090034782975A8AD1A02636CD900@BN6PR07MB3090.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3090;4:61rIBxoBh156NU2dtqjUQVzXX2leid/+gWrfz7wsuEip/A7dR0N1rWL1YAPd1rP4LOePejybA8czwt0lr42N6SM2HKUDCaffzlUm5POgRU5FDyYfuYxmafZ+i2uyyoQLd2/UEl8XIvAtLAKBlx0qw1UDAHwPQb+ocwy+3TZ2Zp5FWi+yp9OQVdVHQVM1oNz40Og53RSzFWLD1X14B1Vkh6UGqqs3CHemczZF9y79E+8/ahfE+Zx44JBJza+4NpAjT1DUH62JxO5sKbZGnkMkV/kF1uz2BqQ1hSFLlLTA310=
X-Forefront-PRVS: 0933E9FD8D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB3090;23:LLEKAeCSTDkJNIFAcCFOIuZ3mS4L35yHTWP4NwJws?=
 =?us-ascii?Q?E30g1ucQams71gt6rJPVVv2ie1zIWON7lEbZF2PbLbAXhK5+PUwqM8+0Fpn4?=
 =?us-ascii?Q?uJ2Im9aURAebMedGxalKoRE2RjyXKkoOyT/xfdbtXjaFuiOOgtqurFEkXpBG?=
 =?us-ascii?Q?mJ1KT6vdOLc+SNrtNhmHMLHaCfiy4R6CmuaJ3/xsOx6Hlq6+JVWX8TJIHrgk?=
 =?us-ascii?Q?BpdRNk9pqxt1KR4e7toyno39EOzibBQ+cfn3rzVpehDDVkTkXAgkTJaozTiG?=
 =?us-ascii?Q?IBIZNsCFEfYHLqVx/LVVR/yLXDVd36AbBnJ5knuqowfJY2ttBXTGSq5zchxU?=
 =?us-ascii?Q?dZ0qFlcgRUzJHGF9Xym2ThHVDzhqQU6KmX3E6SPHA9xxic6wuWYq017UI30y?=
 =?us-ascii?Q?H0rXkyErIIYnkajLiOtndszpQtxh+KozL4/YqNukJq7FSZbQhXmT3iW5lnF9?=
 =?us-ascii?Q?tvko/j+uMr1qZK8zz7FLA9ivjXc4RUm8X06GEVbrJhYbpCB22/RvFqKOMhjJ?=
 =?us-ascii?Q?yhcPeLFnjjWtCuCoY0h9llcvi1nYCJWiBpsofXokJ4LYIhKgIy790CMeKm95?=
 =?us-ascii?Q?kRqrXcficwcwwb9zthdm9ALxcG5uVq7eAzGaAfnBcdJ+56q5I7gPJgxUpqXF?=
 =?us-ascii?Q?wfc/7BTMGRTZ1TdW+tONBE7gyRMnprYdGDpTw6eGBrxfS+PoStYh2Gm+mAns?=
 =?us-ascii?Q?LUttbkklbO0RUj7haVIcLSot5SEKbXMq/uij/ZKpbIs/VfajMLXXvQ9fNHoX?=
 =?us-ascii?Q?jerY5pvq4bFcZnojvkIhCCsEpg0LqMNO8M9xeBpwDn0A484fZQFrFnUddDpc?=
 =?us-ascii?Q?87N/RwgbmXlVJuoxOu5LWAlhjqCUZTx3MBEWs2xMfDDW0tFksxS1RVkVtd00?=
 =?us-ascii?Q?nPnaO/v1uhsNW45fIdwSZbH0uw7JwFO1c62AjbhaUu7zVKiXMgusUhVlDmza?=
 =?us-ascii?Q?4kTizATrxdKDpO5cEJudBtvLq+h+h0RLKEj/13XLNzkhizNP4XCvmjlFlwhz?=
 =?us-ascii?Q?W9MYJzBD5dGHnGYx3i2OTlqrNdQcyakFHNWL8GxVM7gdNQ1Y0L4EkksL3H54?=
 =?us-ascii?Q?ZtM+kjCbQMllykXqrectaog5zt3Im2XDl8fdXU4ZLhQnGVi89Igdxa+hdQl9?=
 =?us-ascii?Q?8cVm5j+RADKO71oFl3d9c2c5RZ86lomhYTSOFa1TO/5S7mKh3CRIu2UVjR12?=
 =?us-ascii?Q?Lz9nDfrinNkZko=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 4sOyrDcVKhILa901+EPQRlRMyp3AVu2FLWYMbWn2rEiKY2MnaL69DvJPwcybwK+ZE05cFh0z9mJSm2ct7sR77WOkF+rsQQdW5zuilue6+TtLgwar3msucU4rjBi+Gdbf4vslYQTm9cIcs5w3X0eiJB6GPC/puFNgdi9+6TSsFT1DgywzraRNrVXh6cDrw6W9p02vlwYVno3WONl00gg5B0y9awvEfXsQDYd0KRpn4z3ccVkUSu+5sz5pPsU3oLCdCCCKUd4MzC7of7uQS2m8tctYzUcsFxXOc8HzLOqMaaCuEtZEbGyhsS+wC4rfY25dPFGcLoitMo88wya2FkJ6dH0KMBP1cZbX6hA8OFKBwIDo07eEAT5Pz1isO6dDDF98uuZdHP+ECLQ0sb7xcUqtHfcFnZjhHBOBp30WIvXYZXg=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3090;6:roW0wKE2+hcc/Roxupb1t+zZfExnTV233gBIdLagxF+Lztw/R3zBip/KiZxuUB0kfWufzZmcMXCN61B5GYmEBiBWOaGE4S1FKzYzR6qlnkenZFd8aGIF6pOy230jx8fDRaMiWjkR27G+2+vUqnXxZLQeUqRSOOTMBwXfi01ByJOIYYv07qRncFdMBmjRmCaNfbaA5GDlppTPXxZS2d3RCBVA0zrIdmFSxOSxJpYXjYS27lw6IHeGBI+yG9jFKlLdApZborYkSb1+LwcYnqltnSKHQ01dD8H+ep9FdaIWA74zZ4S0b0bOkueWfD2zFNz6/s8dYD7kQBEVZ0PipwHBr6ucgfegwFOp3Zfef08JAI+oWMYiOS5iPWR+LNoMANBkSBK4ZcIgLJoYEAWlQVwnzDJgjiJUdxCbG2E4PJK+BspMTYDsgY/qLHtI9YWiOVXDKKiKjdnA5o4aj/hxo0rbhQ==;5:3/xz5tNULfAbjZv3t52p1fpBGHatu+XJWp2I2Dq6IkGtaoySnp5svuNJRV39fAe5TYr8Z14HR/0bd7yl+srOuECKRH7XD02Ra0QupkqNhvYjb86s37UULOKZzzhFUMFxG7PUenWl75o5pUF3yD8ou/vgMBcfbre5FkEHsrAahOB1VptfEorHI8Uir59viww5+QJTVEpKaEAnwkeb+TVL+Q==;7:La17AD5e7Lm3fiOasuajHeccDobJM2AWE02u3X9U2GT1SJw1vGaO66bnbo2nO35hq/JXTtpPDnea4K6BS+IjmOzqywvMpgRfWcY61UWpp29XyCle5wNLrjZB4OrumiT1tZfJ+fWP4CsZtRBtR9/Haw==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3090;20:vdN7nbK2AciL0JUZbiUC2Hhs7owZ7GoGuoW/a7lhrcle9JVekA0cA/QoJz754XgTBMwGylZRGr4uojNqOgS696R9Jff6TXaifVxRgDURVG9j08A48hwS3rEL72VUB9rMqabU4L0gu4uj7z5QVh4J+a19mnOuQEnTu0CrL/AAMAIeuGwLT/vznDlAq0Wc9VrTSTEPV1D0OLg1GjYvYsQJL2WaCuTThZ2APH7FO3QsvZV+FrGZVpbe7FOJDWWckLtN
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2019 11:04:37.1393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc231dcb-486e-448a-9733-08d686a2b9f4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3090
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=748 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
"true capabilities" of DPRX device.

Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
might falsely return lower capabilities to "avoid interoperability
issues with some of the existing DP Source devices that malfunction
when they discover the higher capabilities within those three
registers.".

Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
and read 0 so it's safe to check against it even if DP revision is
<1.4

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 54120b6319e7..4e36d708fdce 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -372,10 +372,38 @@ int drm_dp_link_probe(struct drm_dp_aux *aux, struct drm_dp_link *link)
 {
 	u8 values[3];
 	int err;
+	unsigned int addr;
 
 	memset(link, 0, sizeof(*link));
 
-	err = drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
+	/*
+	 * DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
+	 * DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
+	 * DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
+	 * DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
+	 * DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
+	 * "true capabilities" of DPRX device.
+	 *
+	 * Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
+	 * might falsely return lower capabilities to "avoid interoperability
+	 * issues with some of the existing DP Source devices that malfunction
+	 * when they discover the higher capabilities within those three
+	 * registers.".
+	 *
+	 * Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was
+	 * reserved and read 0 so it's safe to check against it even if
+	 * DP revision is <1.4
+	 */
+	err = drm_dp_dpcd_readb(aux, DP_TRAINING_AUX_RD_INTERVAL, values);
+	if (err < 0)
+		return err;
+
+	if (values[0] & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT)
+		addr = DP_DP13_DPCD_REV;
+	else
+		addr = DP_DPCD_REV;
+
+	err = drm_dp_dpcd_read(aux, addr, values, sizeof(values));
 	if (err < 0)
 		return err;
 
-- 
2.17.1

