Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A56ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13A820842
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="uYZrtvoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13A820842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeGMKBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:01:16 -0400
Received: from mail-eopbgr710056.outbound.protection.outlook.com ([40.107.71.56]:37736
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbeGMKBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdMvGDW4y+C0atHycvWvbZBTBnMGL9qQ0Y+gA3c0J5M=;
 b=uYZrtvoq0hJd+fNvXfsgiUe5CpRBynFNqMIs/e80cwTmsa/6MrIdvBcegbLKDqDphl6CuE3nj7biJ1UewKuVMYxrtRtsZN30G/bi8fHb0WAJ2gmxwX6505hT3JoXqRtNM5qjLVbnsX24RNbw/woj/k+C1cc9p9AQxxYGrpoh078=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2629.namprd03.prod.outlook.com (2603:10b6:903:75::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Fri, 13 Jul 2018 09:47:14 +0000
Date:   Fri, 13 Jul 2018 17:45:08 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 0/2] pinctrl: berlin: add as370 SoC support
Message-ID: <20180713174436.4842419e@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: MR2P264CA0041.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::29)
 To CY4PR03MB2629.namprd03.prod.outlook.com (2603:10b6:903:75::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75271761-bb8a-4155-c8ae-08d5e8a59f5c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2629;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;3:jJ8KUSAxWJwtCzLPJkrwQWDlZS+0NQ5AZQa0wBk1pb9LVb3XHhR/lJZv68C8H2wzRq3c1EHaXp+gL7H5o6GjmTx+IQT0u2VrtPOTKOvholZ/9QeUyIXOSQh3BAPgQOKafcLBShQN6YBsHz3uUlqYxq2uHOmXf6tGSQV/4NaI76fBkTYQWPFAIrgb1Vt+pWfIL0quIbhAlDqfQPUQG3SepTleeMtlueQ2ST6xRUghnyDpvgfPz1VIyvRWRo2hMZ5r;25:RELciWUJ6277M3V05UWXsqJtkzSkEF/5VC+cG0BlYi3EBeEd3MiNsPlI+KSIYSMLjdGODKIBb7+c6gAa1LCsrnUC2xeOQxaR8OnmIfo8rG8bn7vTq6ASVLIiFSagzM5OfutMxJAmvroUwBsniFNBKZf/Fk2Gq/pBlreTf2XePDa+lHmDnfruMNk3aOEUvPR6D2/N8ggsWnsbiqlyWrmXcM4X8pkLmKe0CgmV+dhYmE4uzYLOS51h8XUuuRynjrKUr9fWapXa/4NovDdmjqbUw6VOPhjpGeaviidqUIHJb85JYe1QU+/0mluoSEYFCYgzMA4v92jXalgYJLgOfmR8Og==;31:wnt44t6L0TMe3pEgCShjpeKqVCv8SnDVCYmf+D6bIalKY8iT218ixqf2rujmqqmxfRGdXC+YWbwgagSWnOrlRN0bCkLRmHUc26InhrXEh57nJvYKf5hwaBXn19tljvBiZSPlT5M3jG1F2CZJQSA3FQnnnEilwuN0RYWH1Hz823tx/FAiZh+a9sZpLXcpb/Zn7MIYYKgIgUfNXKcAHN+zF2jTK21XOuIYDs3+Qcv3HU4=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2629:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;20:8yQunorwzFqr5RN4zHzOlb55iFjDj+AhY22NY+blXQS6WFfA8LaS1sieJI4gUTL5mCSUT4MHdeBQ06qFcalhe6IefkZk+3uk2QQ2IVnc2PzWLY8EA/TIpuLZA+l5YCoemtWNumedB+eG7oqwO05Y5WHatrWd1YCchmbhtsTgPdbkWT7h1etk5TORDJnVWSmr0paPxxNxnJ1egGSNMfPu+nitOYsuummpZx0K8t/WPPE168u+Ax8WsOWzbx38HZbHpICizaTINQEdNGqnlmAIKeeFY2Sf8zgX0OD4nhtEP6WxHSLr0/hXnsgS1I5RCoys5V7grhEAUY+kNagkP9T46ohIgkWvR026F8Xn/RSxAtsUVuVYf55Sq7aQzhPpcZNKFJGSdJr4JIWJY7Mr72i1sf54POomsZHQMAhR40k8DaXOuruc816kuMTitCzijmhnbRq+yCHFCCfmAeiE50H3c8uorwWuDaPZdz8H4xqwLaDhF20AuG4aVi7MlrfntOzt;4:O0Ir2hLM8PbQS/xjfPiQt9nmetbTNY48NlwKKPgusaq+dxDbCT6VH82IiFEY9XC4o/StlSdy+sVFg3uk19ACdIP1s/ZsZzxYPgTh3gSmhgj5LiXVhagUp49rzXI1yPPUWrSTVeyNJwLcrElei/8v9l1rK1w7HVBb7hDLAiooYxDafK9EwPm2hcRONzc6P3cbUX3UOFdMxbKZ+b2BOn9kueQQ6jWXjOvh1EJlujn6pqbhGDhoDajRHS/vmwQKcVzvwU8uNnm7uO68AqWZaSVOww==
X-Microsoft-Antispam-PRVS: <CY4PR03MB2629357A75B79B25D434C3ABED580@CY4PR03MB2629.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2629;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(136003)(346002)(376002)(366004)(189003)(199004)(8676002)(5660300001)(68736007)(50466002)(81156014)(316002)(81166006)(14444005)(486006)(6666003)(956004)(105586002)(106356001)(110136005)(8936002)(2906002)(386003)(55016002)(9686003)(230700001)(25786009)(4326008)(52116002)(476003)(23726003)(6116002)(39060400002)(6506007)(72206003)(7736002)(97736004)(305945005)(186003)(53936002)(47776003)(50226002)(16526019)(478600001)(86362001)(66066001)(7696005)(33896004)(26005)(3846002)(1076002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2629;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2629;23:JuwP2sDzLXVYIEHS7sVgE6amwdyEoxN2Z9aRuBVeG?=
 =?us-ascii?Q?yFX0gEqWvCnTyTcs9KoMHM4bQwQKKMsgJSLVdquRfRhbDjgNavbhATb6vW8X?=
 =?us-ascii?Q?5nfE5xV6jROrqKGrFubNGzmcVGf8k+pYGoB4u/GWV8Gt2Ec76/aYDELr5gRc?=
 =?us-ascii?Q?eUb/rsIjHsdY+Nj26UGdsQga0aEWji0xgKmcRIiTfu39368hp4690jwUmwOC?=
 =?us-ascii?Q?j5uSS8S5lPuB1oPL5XI2J38fKzNqlFZO0aa7fqUs7LdYhZEWwrpOSeGURvqb?=
 =?us-ascii?Q?wz2AEelbufKlL7iCllUcx//rpX3qfusEkrIs1Yf6Yl2NWs78VOq3IowLM4Iq?=
 =?us-ascii?Q?9K9iiRzR4nbaD6PrZadliCp1+pQ/czFULkQx/qw+7ghF/MkeaPCH9uqqtsq3?=
 =?us-ascii?Q?Ol0CV4NOrYzzgMq7Bj75DbzjwdhpaEHp2f+xvJeHviQAfT/GMt3mayc2EiWi?=
 =?us-ascii?Q?sBVPEhLVZYrnzo7L6nkebe6GXMnlCPmNSDTPNypuvwSGzEwyNjeZGhwVnU5r?=
 =?us-ascii?Q?claBxEHjxI/4JYc9cqdNWHWA9zzF6GVww6wMUHU3WmdAIzd63my4htOq6j4t?=
 =?us-ascii?Q?+D/XXpmIDuCvwTys8/2veMSohGiME9EmlOBJJG9glJ6o5VqTakN4m3kmFfH/?=
 =?us-ascii?Q?tvegI49H8KdXhHZbzp+HbR2x5jZm3zN/WManCiCC+P3QDV3+aE5pc+Y1ID/6?=
 =?us-ascii?Q?K7OIkzTPO/ynB1tNW/qkRF6stqZAw0jbrORLpONcz0XbPpWYQ5FMH8iGe7fj?=
 =?us-ascii?Q?qjU8PZEteNJPKVTICCrb2X14CwURI5KCxrnAMG+XXpOLaj2G5IV6JfeMAq2v?=
 =?us-ascii?Q?3KL/0UdMD1qaWuyjntZxDRQ1MheHW0Er8WHwrVpMbh8kqfjrNelLn1yavpL9?=
 =?us-ascii?Q?cxfmaiN2uH2ZMIIql4wO6Inu5TN+DEJQq0HMoSyDTVnCTHKoXmKJ3mminNUL?=
 =?us-ascii?Q?nCE0UVFYXFec8UuqsyQcHZNIbpfYg6cVoQES8lr7sx3uCJGzWz3pa8oVG+U2?=
 =?us-ascii?Q?avbZAxp4AuhWUcbzVQ0rahJh9mUfLQjQ9IWuSdp7WfJtJmWLIPtjOQa5h+G1?=
 =?us-ascii?Q?6GZzWkMAjSWSxQoD76I/BbgjshwuGNMqRxAIfUOOjcPAWMn3pXb+cIZ/FhZt?=
 =?us-ascii?Q?b2+SQnr0YtuYrFIL8dCGWNLo3gY2P/hCwS+r5cdUnX4aCmYk1oJj3NQSIEk+?=
 =?us-ascii?Q?vxyNjhxUDHs7nEE3eMDo5jSTEDbxposbTsN?=
X-Microsoft-Antispam-Message-Info: y6KTydxW1KxfDz26toFc8DN/bH+vMWcZwr9xkCIlpPk0soWO7EOGpjBjT/aZ+lK18JvKkDB8Jw1VrlB6uMLQKBr3+ik1erw4hYN1TPzurxNz8Webkynordmew8WoPIcqYYdV8jIYSosYcwavkmXLbvXw3uimZsFLZbRmAjT/vfW7+2aF2StJn/qLzpbJHRPIkXntZpq7GpUFb5Gi9BT9dltmvZL67qJdlCbIhIqw87lsjyYNb8ciQ9fYL3loUS92+DvKt3ubkb0RAvL2p/NdqkeTuGekmWTs504M7sRS3DpIyx7xLw20I12G9BsshttEqttAFixkCqzESWYbQG5Hu1W2s2NcFb5NByQkpcvJRSs=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;6:wBCV33k7x499l4yvznRmEFs6tCgSzW6Gu+pDRGh6Z4lKA94z1iEPRc1bCNC3cLzKqwojSq9tqKe+HcMvNEyoC7IrEEfi4G4xc0UEZtlFE8fX/ifyR2i5B3ujTQU1iSTQBPlCW9Zp/7LMn4bOerDUW8gxb0v4/XFfcnXjJBfM6cFruMA8QizclywgMRxAVyc5seio6Y8fie5Wl+FvdzohkQuyVXBmRnvk/01j2mlugUtOpxPkh8bzyAR59gJEPUBqv0YfgNglyos2Ic8vIUXO75/QVnrwqyqz8zwNJYhthcjzCV5+t8oqYUxCRhsM7vD85r1m6yeiZBxDzrjCTz8I/g+VMQR91xO/8bMOxW84sPjrr2hNpLjA+nDUCoc9CuFMpGgas2M57aeTEjWhG6zT9Jd8VpaJQJ4LUHD7CJ6nTlInXfTgdRnsWcdNe9VJ6vypDkw6zmV76DAZnQ4MbUDLOQ==;5:Gwb+EIf8sqWQNCRMD+VvteBZ6dcDPKlRfuVVmpvp7nqfh81qyDT2eKPGl/zGcCXLidEit2mbKL4l7OT/IgvMDIGfMEYjtXBYGwP3S6ChD+Tt7qO4c0XbwVLHnZdrwiVRmyBmjmBO2H5IcNd3P8+o8UUjR7Yv9WuWUDq0/fYfLHM=;24:JfD4q5iIdsw1grUrWo1oRoRwsNMSa46Kn/ZTDbBx8TxkotTGFzrx/o9lCiNjsdES1hmT7i9SPa6NxNFTuyP4Zc+zUUcVaCM7lC9HFNL9H8c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;7:dR9rtCkzM6y5fjq8x/iZ2bLzkOK5G9rl4mtOmoasmVNm+xmf8WDUJ/U9941m2YTT6oVcEfW/vdQ7R8FFFEb9RNVuD5h/y4frovQuaCNVJ/31gFeC1zxREglndxqKUZcTU8BywhFRuavJZmmp9B11+c3XWfowE9qQWnrA5vEDqmX6t8NoKN3LVprwAL9NPXj8DvDrx2YacVj80THKEU1ZSV3TWw4k/w+f6CaK3eqePYPWobRBtBbvUgQqDlF8nAPT
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 09:47:14.3195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75271761-bb8a-4155-c8ae-08d5e8a59f5c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is to add the Synaptics AS370 SoC pinctrl driver.

Jisheng Zhang (2):
  dt-binding: pinctrl: berlin: document AS370 SoC pinctrl
  pinctrl: berlin: add the as370 SoC pinctrl driver

 .../bindings/pinctrl/berlin,pinctrl.txt       |   3 +-
 drivers/pinctrl/berlin/Kconfig                |   5 +
 drivers/pinctrl/berlin/Makefile               |   1 +
 drivers/pinctrl/berlin/pinctrl-as370.c        | 369 ++++++++++++++++++
 4 files changed, 377 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/berlin/pinctrl-as370.c

-- 
2.18.0

