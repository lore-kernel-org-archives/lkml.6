Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30C0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D980208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="xcMMgorV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D980208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeGMJe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:34:57 -0400
Received: from mail-by2nam01on0065.outbound.protection.outlook.com ([104.47.34.65]:10976
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbeGMJe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeSwa0rs4sYFX8oWjobEqKteNzp0f0caGm6vOZoJrJY=;
 b=xcMMgorVN33aYXyDK25+DMuxA3ZLGUl7PId9N3rVa3dvgntGOzxBQVTgSb89dCs/F4hLJKIub7SbmI0jG0tlcuORh00hirT0ih8dfo2QeZOsL0Dqj4ZnpNQ6hf9T/vu1+ozUKz29ACot+baCSDq27/dogid6ynTjhA2IzMOTxbg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2630.namprd03.prod.outlook.com (2603:10b6:903:75::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Fri, 13 Jul 2018 09:21:03 +0000
Date:   Fri, 13 Jul 2018 17:18:59 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 1/3] dt-bindings: arm: move berlin binding documentation to
 syna.txt
Message-ID: <20180713171859.6c4e5a35@xhacker.debian>
In-Reply-To: <20180713171712.05f58a74@xhacker.debian>
References: <20180713171712.05f58a74@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: MRXP264CA0039.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::27) To CY4PR03MB2630.namprd03.prod.outlook.com
 (2603:10b6:903:75::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 782de305-af0a-4e1a-a0d9-08d5e8a1f67b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2630;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;3:t2TlXiAuCUy3vuzQifmgXKpOMictyGDnw/jUiSljz4jxYF6MAB83xO8fbZJvA320iSJ4dqfq137n5j89LmzFM6spEcuLRyTTsoneHzoPdHOYQKNBlo4pvVumcoe1ihd1R01E8rB2ugqp8rVchjGdtYGgpNCp0S38B1IoiAFbtQlnywIhxnoeS1q7uPj0CYfX2YR2vu9h3sRPAxBGOokCcMiohrpmpmexoI8hDvcKTNbQYX+3qFRG6Eyr9xQ+JeG/;25:AWABXe97nkowNxCs8aZmVLTTHcduaHQa6eQowUPVAl0l32GYNjoU3kzikLZuMJjVpmWwfwCj1OLvJe4bbqtYubCMlFv7v3AzX7vBVAQzeH83ykaez6718RMmPf2QrnVoWV32PIeEzIjsnZbXjzzOa5rgJAg1kIB6DwTVwqfFV40Dj/HZuSVNV+XfcdCWZv50Hk7F94kb4S03gPtf3WWidjJNnmDJcvXx/37GQJ8mOPOszLC5nbQPyExFCLCA+BD8aDHSy/Y3IiUlBy7rRMK4XjYH/4uhSGtIyzf6EFMhB1JNJF89l8gHbwwNEAnOc+W3vYtJ1ARLOJ3ZFxMjWy2jdQ==;31:hSWe/PTZkZGUkT1/KKWYWQGYsxYBLmx2UDzA2+gdg+4kMHLx7N/0/SpT/2Tndam6FKZeJRTxSsj5eFsnK36lNCUd2usnXmJh9Bo+wv1ciyPsXYzXwBFTwM1S1M0mrSS+5604SYgcwJwoTKzj5YyLxZBZl8ErvAnHasfoHB/rlCV+cVChKOJyOJegSPqzlM7oZPghWwZF+g1+GHUCa6NS3dTU+P27tPXgRwACeOxmcSw=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2630:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;20:K23vphxRK9m/N49VE8l29lEM4zG/PknhLfdGVZiGQ9ULuyojfB0hlfIhhL4orJWTBMVtxlyjfG3Q3Nhwh80YT9LcVEdPTWQ3aqS+3jDzbg+MkgJNAG1Ir47lJntOkiQJ2WmtGDFH4lTd7dOo0dey/tzXS4D0l6WuYfIx1lLrMCz4UI5TSc/8UliG78gkDRi38AmxnLd3O77ODmb1Hu6vIaYY1uacMq9GPsBP0bIf0fYc9bwKkE4TEUox0kyjRgIt2xzTgThpNPQmsa/M3OS/i24hf9Qiq722ehU8s8PNsZWep25EEeVv2XmPFYYTEbq9GINZcoXsx1TTNOcG6sYxGfrFB+LHXJOF0IHiAo30Lg0sOXK3mIjf1tweGJ1xNw8Oia60+KlCiOWbqQyzh0Kw6qjlT/3JTKSbZr4EQSJ4PyP6WBcKDCT0C0DIFf27WLorhMMdeMrMPe+BLLeqRlrt3s6uc0vWLd0iWo9MovdyNwRdc2kw0GJUhfaYfiivzV6i;4:qkehFloqLq+UYaKTbJohBBhGqGjexiyyliLyGFZ00u++nd33Ihx6z98cIR9ZDMdvelRs7yi91oTzFhNEpLNxcfWAUYzPWHDUqHbrzVrPqv01b9yJyMQqwhtn1KD4kZXNDkxkLpeHZk/nAqPna118bCI3loU/KK1/enKYcM51xGuIPRMlreajcDcdaMmlofDYV6tjSyjqn+5epasc+Rv+f+vHH2TWd0vpukGdlzffrp5pCyC53TGcRzHT74q8eHhNnCMRt4M6+gQgO4vGUSVqhw==
X-Microsoft-Antispam-PRVS: <CY4PR03MB2630C7736EB4A38635B8E861ED580@CY4PR03MB2630.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2630;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2630;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(189003)(50226002)(446003)(476003)(81156014)(956004)(23726003)(6116002)(8936002)(2906002)(1076002)(68736007)(81166006)(3846002)(9686003)(11346002)(8676002)(478600001)(305945005)(6666003)(7736002)(486006)(55016002)(72206003)(66066001)(5660300001)(25786009)(47776003)(76176011)(26005)(105586002)(52116002)(53936002)(86362001)(33896004)(4326008)(6506007)(386003)(230700001)(186003)(7696005)(106356001)(16526019)(39060400002)(50466002)(110136005)(316002)(97736004)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2630;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2630;23:OZJz0UOw/F2xzpJoSdMSqWXyDEwbDTLrdEszGdzYm?=
 =?us-ascii?Q?3/jdD9C9JaBCzfRBYKvmSGZ3fdjvbjEvROAMPTCkCKGuFB0iJZClJPtZdkDq?=
 =?us-ascii?Q?Oy588rh1ozOCUO4wZGfeEYK8yvtaZ7djaah9Mgyn3o3K3UOQk816xstg67V7?=
 =?us-ascii?Q?dTbRpV3jcfXu4kMo7+gjQLc9IboLftFg+Q+9FH6Clu140b1Iv47DaWuoX0OE?=
 =?us-ascii?Q?d0fDe0b+AFOU8HZvglP/y9BNqW2/AXFL9F5e/Kd241e0DMGIf3KihBrBnynm?=
 =?us-ascii?Q?fqAOmRrOdRTQcWMki7o4gVqJAOIIRVrSkoa9TrO1Kyd5pr2gnNKGEPrTN13W?=
 =?us-ascii?Q?ZpDx8yjwVcvs3nGFYTvaskPQLjjZM8tlpd6Fqz8RDETIz1wsGrP0LdLkKtqW?=
 =?us-ascii?Q?qXWyfacYoOP+I3HmWKFSjicVI/FVr+vmiCVa7z7+tcqFHc22dzla70CzTP7X?=
 =?us-ascii?Q?rLDlHUhgUHQac0qEi9aGEI8WMekjeQ48wj5bh1/UXVvGjwHi3ZncdTJdoeAG?=
 =?us-ascii?Q?l/QLSVCRDlXA6GKtgwJPWZH2uk87hGhCdRzxV4DF2cT/UUZuflpT173Z38Iy?=
 =?us-ascii?Q?YZw75q+PtThYn5FjCuL0kokhWfS8FFzj8i4+hCM5XwcK0EBktl3TdHM+GIBu?=
 =?us-ascii?Q?9oqG/GLQA3QuUh4Z355R6EaS1ju4pwPj5f7gyeoCmdVPQ86ZmX2MmPOcBwj5?=
 =?us-ascii?Q?00aUeScNfGhPEt52h+re33dromZ1Z809bSpdyhfxzxrqqLKPly5ijbhG8mWz?=
 =?us-ascii?Q?WQchyGmZyo9LT3clZOUDeRD9mcr09ZMt2t2xXjdKlQFZPlfxNyfP0f/aTb1p?=
 =?us-ascii?Q?s29yaZBkaiY8dkDB/lL/+6fvy4RiVuaLXsM8A+mw/5Hqw39dWB5gD9NetNjU?=
 =?us-ascii?Q?cfK/QoiwRUThqWh5HZjvkIFj1OSOFLO8AAPSFfFH4FJGavVj9XauOA1oZt87?=
 =?us-ascii?Q?8HBgW53h4N8TnYG3gDH8ph4JvMZGIzhPz0TxG9qy6u7amuYJPlDbOkeHxvnt?=
 =?us-ascii?Q?f9OiuQoCkad3ao3i3PpIX9D2WZtqLGlPplGgZu8NbeG+mqpgIJDp7ka11Yf2?=
 =?us-ascii?Q?/qbH1KushZD9KzYnXU2kzWaYwq7nxlwuicJPOfb2rT01/yyq6ER5GNN1BFIR?=
 =?us-ascii?Q?XzCVE6akPQR+a0SJ7q32zbqfBKPwIeghgdQKyR/UWBlwBos2fUJMjfKlwlo4?=
 =?us-ascii?Q?RSFAVERz0bZC0qoVCaFVN8hk2a1262JkIdbYOHdG/oWMNswkf7TU1Hvoa7s2?=
 =?us-ascii?Q?ycxiTwFMIRcDsm3u/I=3D?=
X-Microsoft-Antispam-Message-Info: 5IKqeNk9vSi+7XklpSqlyPvVEFQhhiTxrhHxEqkUUWauhsNahz6Z79naa/3x5r8TLtspeX7i+P4abm+wfTtIWrGZYlt5Axt+dHBBxyEcrnpkt5eqK7et1u5ufKmbT2qXas8/vhb6hjgzHOB9eIF2m4kVIqEzhElp5l8x1RalNjGJwvwMArdZMt75/aIIsjp8qLfmsDRHdCAUQu/nLlC4+d+cjw66AfpJcMAe/HnzGCiv/zqPrnhcageRjxkVs+Z3gZ6Jh04twUjUGpigN6rFzixVCkFEsGTlZJIx8KklL8t7GO1YYWohMWJOQ45HzHrQ07frgaca1AamK3pFUph6OZc1dLCLfkFdjc2D1SVHm+0=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;6:JndRSA9sEHZRi00rtnpdGoWbVkDvnhX0u9Bpp2mYkMuMiU6GJM5tezbuNrXi5+7CBhh8TYGLJkJGk/yJGGV/XT1dfRdLT5H7hgtvE9UYFcP3Rr7Q/ovCbG40B8eNpykP9qFkYQv0+AXW9OmZ1/JWom0lHAJ2xgdnrr6seA8IKV6wg7RVPJR+yLDGGb23W9aDrDzU1J4NgGXg3+JLWPSJdhZOFD9cIr3r/KbbUGr2Nx9cFeOPKe+2g/GxqNzPUhAsUYhEM9qViAXKELu9o4WYqx15hoo8ldh17CZoU+FPQqi18htlTTdCS2Y/3SPUel84batsXEW1OqQirzu7/CWJAbhx17tDVINSmjZYdX32hfivaq3eKlffACKrPA4GVf6pTPd4H91nAWzkzLvB3sQO7msn2iJ3Az7aHG8qcMWuZ1VMjZ2oAQl+lMYpAUrFWuHjMUq/vbeeELdgJaZo0kR8xw==;5:B8k5lO0Od3EcE74E9yNUYZcsLxGuTCAsU8Jk8w0RJc2+i5K3Vhe5M0ZGagWHjGuURs6INLpgwvQ/lXYZOb33c1Q1nrrDHL+uae6XGJMowPkosWZ2ZzbcJGUh2/7Z5ZvyeBHuKSv/9Wmaqr10tPriypL3POJPmFpWGHadG4ypk7Y=;24:TdV8AhPTMgz6baM+XaILD1osWC1YT0T5kylFDcfe0aYvIZ2nqYaSSyMypD2WDHSmGnqXblCUg6Ahjqid9yGOBZ5yIzb1ZgtL7UPb292lQsw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;7:v8OZYJEApsUb9cIw2vPYSbH/WN1a+GtjjxSfqdDumgZ03pFIBMzAJPqcXK2WqX5GBt8vred0eK+AKctD06FpGU0l7LahH11H45zeX0YD3IHrpSu4+B/QiWHjrhuqIUhYy40Q+JHpRPhMkBi4h1/939iKdUKsjG3iosZMmTrwZoIJh8BPpKC5yii7UQo7fScGA665JB38qWWAd4bYobFgzl6vZ8M+fWV7BVCQkvVSoGow/CK1txbKzvaW3fOT2aQo
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 09:21:03.4983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 782de305-af0a-4e1a-a0d9-08d5e8a1f67b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move berlin binding documentation as part of transition from Marvell
berlin to Synaptics SoC.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../bindings/arm/{marvell/marvell,berlin.txt => syna.txt}         | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/arm/{marvell/marvell,berlin.txt => syna.txt} (100%)

diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/syna.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/marvell/marvell,berlin.txt
rename to Documentation/devicetree/bindings/arm/syna.txt
-- 
2.18.0

