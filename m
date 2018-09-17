Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5342ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5818B214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="XUnfLqk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5818B214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeIQNbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:31:13 -0400
Received: from mail-sn1nam02on0049.outbound.protection.outlook.com ([104.47.36.49]:2816
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726732AbeIQNbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WdUUoAWM/cbQvjrzAkYbKyJLYFT7IIB9MbIWRjsSi4=;
 b=XUnfLqk924JhojBePK9bL3PNMucOFXrpgxZLVScRViRBSoltB8DXv4kEtyILv+e7U7mFLIkgyb4+GOuttRGr2qa+/AYAEarrQ6qwP9NhkXiirBt745jMUaMbT+L8zYFpX9fAF1OVJLVG80+Jic8a2zCejyoWNUr0TlWLZQOTT00=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1583.namprd03.prod.outlook.com (2a01:111:e400:5232::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Mon, 17 Sep
 2018 08:04:52 +0000
Date:   Mon, 17 Sep 2018 16:01:26 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: move berlin binding documentation
 to syna.txt
Message-ID: <20180917160126.49211da9@xhacker.debian>
In-Reply-To: <20180917160015.05a1fc5b@xhacker.debian>
References: <20180917160015.05a1fc5b@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:404:a::14) To SN1PR0301MB1583.namprd03.prod.outlook.com
 (2a01:111:e400:5232::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5837ca2a-bd01-407f-2db6-08d61c744080
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1583;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;3:3Xh8aI+7PkoUPYytvW8kR8cbFbwb6ukR8gpiFScwg8tsOxNf0HRGnEs0jZGPxmiS0zcjXBxmy5nHR+lUc/FElZFve36p0X5Dwk4YP/3t2CJmOqQovd6f0aY3U6D//7QZK98ulYA/1ppnRzAmZzJWeZwkgtPfxk9Ugn7SdD26HP6Z9x8fI2ZwNDob86ZNG1+h8JzSAFUAYrO6stei/D+79lZ5yOprmbb6k1Jj1GsHsmQMexI5rcJkNZq9fM+e7XNU;25:4gflIFrO2135BAWb+bFKsX/CqIoBS5qWuTUsKnNiAgbtaJtvf1nh3p8hL05TjERTkR38cPI6q8JnmCHbK3sxVFRcALn2SzXfZpQNkcUymZcUE0FUsmZauhvYN68VvEh72nqbqOfPbJHdy/qw1uKXS5+3mS+Uxvhq6aawXWVjhhHBWPJ2wmo9sJCw73D/ixMyjyMaWllQdr9KEFJsCpI/CX5twQIgftYAnLJQHW116OgIVTdHhnz7wDNPG2+TaOe7cJFFOCPcHXjJPizvVSCeKQnkwd98gK5pr4z7qQ2qsr4dmvaXxUdLAA3VytWjmENPncEYAEgULUbhXC4FWQ89Pg==;31:DvYZtoGdb/HFCMGCPOBbOSEviZ2igLyHXq5X7f/JGlLz5bgCYyvBUTxY8hIe1QbB6wprVyUsVybbl4pJXODaTjpiJ48mlt2Li29f0Yo7PEVatzgiizdab3bbJtzreNJPjVaNKsh8XTQcMmvyzEVrWLH+asjAEcoFfI6GKqnZ31AH8RLmwISaZfNnUqRmju73XfOa+ft6zA+vtgtXO5IREmv4HD9py4ANpe2zbgqWDMA=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1583:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;20:kq8B/0e/OfRuTqvm9kVc7BmxxXAAlOYUjp3qTA3DgjFyJjet3SmeB68CEAlnW9w8KnM7UxZaDq662oR26jBnW4dOBG9sJO3qQIGkHsF/eUx3cQiBUf2zkHmfX8jz7nrAq08O+Jwb2fl0HQKIqvDxUL5h9zfTHB94yVJ7M/s54CD4cSNpwQa5emMHzkVZLdNPfa9fiaLEnQsIyIyUNORdqtnQJMAUoa75UIuZ5lea4asw4+LDvKi40/P2wmGyI5F0C/PQjwXTM+HDlMPeDKmIru8hMaOArVyNURYgHROLfQuhVZlUkzFzwD054sbJisg4DJDtS+1jKs4gIgevHz87dHohUdT0YEkWY6uSoAZ8uZ0WEwgkpxWRhsNC0M9OAEvWG/aS0hjlzfp7ihVFvGEAD2iEzRE2WPQ/jdo+jrA3fOuYVtLvSDECvVIi3b0gwkPWPgsZg3hDuCWTs+wEBVORNb9csZR76nlDx+c9xOTm/iaQn8pH705hthXtV2ry+WC7;4:v2cKNFzH6e3VsVt1hJAplbrsk+XOZ89ksYnHN8sQNo0ZRUlN6Dd0EuEqMQShbdO+pTYyenH59okrF6gS0/EwwXrSurdnmrEcp9vITpMjAQqqfm7BLGaLGteSSwTc/y7n9IX6+SigRaDLaRMnssXmgQIvVBUMPlWD+DuVlh4u+WWIzbuSFslNX/VqprwXJboX0lNyO0td9Mm85W+2vWS0r0nbPa1PSzAl7WF8fG8q8kTn6q7ft8rykrPfFHlFy/medzMpOcZaGzk+YsinGLkieA==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB1583DC2793036625AAF3C0BCED1E0@SN1PR0301MB1583.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699050);SRVR:SN1PR0301MB1583;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1583;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(3846002)(53936002)(6116002)(446003)(11346002)(8676002)(50226002)(68736007)(478600001)(81156014)(8936002)(33896004)(2906002)(50466002)(97736004)(23726003)(72206003)(81166006)(26005)(16526019)(4326008)(25786009)(39060400002)(7696005)(52116002)(76176011)(6666003)(186003)(86362001)(7736002)(47776003)(386003)(6506007)(5660300001)(305945005)(956004)(66066001)(9686003)(55016002)(230700001)(476003)(110136005)(54906003)(486006)(1076002)(105586002)(316002)(106356001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1583;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1583;23:B8nDUKXiLO3m6LntAnTHfKCpvNSl+JfGKBQGSim?=
 =?us-ascii?Q?xnhqdc3mQSJCNuq9IQ3bTkMXNYj9b+DnK7iuDrdUG773VCbaFQii3QE1KLDz?=
 =?us-ascii?Q?tF+LO20GPjSgfxR6eJu1IAc/2xl10uUtvuDizbX4d0ht+sn9/GUbFilBpDLk?=
 =?us-ascii?Q?NmE+1J7H6JuDGMiiRxk8Uf5NcUud0BGD6WTYCjyWvWLV3rVuPVqjSp1IlONJ?=
 =?us-ascii?Q?Pm3srw5YpFhJrUTs8iRmk9PAQwM5RAp9C0XcWha8wxNvQjT22TSgFsNBtYEx?=
 =?us-ascii?Q?OoKItsJIihw12Pry3tedaXpDgxt6NtmhAgJ9Zmssa/sLSGxcC9ieJzYskccw?=
 =?us-ascii?Q?ehrdMnZakDN8YMpTI6cfx5wwJ2jd23gx6JELz4ujCz5tgWb0nJg/v5+31OpI?=
 =?us-ascii?Q?72EMFjO2CWyOXAYHeilznC1X8ENwv4j/QgFNAjO2Snb7NxgNI3Iy3vFwMFFU?=
 =?us-ascii?Q?x19hWT7HBvybzJHY/eQ1SATmdFKidYBd64hHzfhB+MtVkG31xz+/My/C80QW?=
 =?us-ascii?Q?zZVEygNFgkKE0DdztmC2BVoJ/eJH2DZlfQBhyhVeJSZft+3cLzqrzoxi9X5j?=
 =?us-ascii?Q?9+THbx058Dbxh1fSAbj660J8sy84+500PIXnr9yAVPQyJBpo1pCPYOE5LjzX?=
 =?us-ascii?Q?j2IJ+s6EQxXXLqntqpUFhRi7xj8Elp+2tPUdfYd8TA8XMk+qFwKGbwCuQ5VZ?=
 =?us-ascii?Q?j6OGmR8/rXf01gQvC5ZhKn7/arbdnj1UxkPtdzR9V5m2huPKg3LNYk8KXSq3?=
 =?us-ascii?Q?g3LOUsQSggjvo6cfNm5yRDwfImXMSDPN6Rs2esreC/kqmr89X6daiOmE6azC?=
 =?us-ascii?Q?tm5elSQeeRt5HRpnWwRHyKFKr9S2ChgPBwTTJNhdXqRXYtgeJP8Su3osA3vm?=
 =?us-ascii?Q?Z6jjJJLd0uLK4Lr63bPemUhb4cZofQNj7aNoNsPyudwtGD3U3o+2ekbAvgph?=
 =?us-ascii?Q?Lwn5QGYpjwMWvGK2kT7Xpt5UX/tNlV5Vxpwk10SMjE1PLV6xddAxxDw0s6iS?=
 =?us-ascii?Q?ePwhCw8xcapC6WHsSyz1EIuoocgi+U4/Z5eb6pZz4vlmYCPl8BO1d3t0/6lw?=
 =?us-ascii?Q?qoBrrohLQXRe4NixZP8t1EiQxhBxK3N28ZOBmZRjS3AwQkfHAuh3ZD+RXqU9?=
 =?us-ascii?Q?qiMCWqV+b6qufxQfT1VRSS5Un9G3xQJdZFbGvDCAQ2vB0nJzhqThS61a6tkf?=
 =?us-ascii?Q?a6L2Uv9STu6laeee2ovYOylAne9Pg7oYmnnxjzaA7ERa6tpVQxNBb4mLNJ4g?=
 =?us-ascii?Q?Gy+B8+sx54RTXeZLr9drIufjSZpVJ8gHlY/fpOY5Z?=
X-Microsoft-Antispam-Message-Info: F0VaoR60wAol/GPTXEfYSFysGz/RSmG1lHV4JgQ5RZltySzVRO7WNmmMy/o1u1ujDaQ3zcD25QSOofmUcA2sOhW/hKCZ4Axyh3tziS/yJ0mU4WPRbBgZxfZYbLqynqiGwNjxfNlw309cKUyq2W2eWJdaynjVR1rmnCPGfuqXDMDebtOlj5NIS0iwjYXl3bm0lNpJ7+AtuvsWaX+Kjlfay0/TyrBaKP1nc+wcE7aMBc0uUm4Zl/sCOnLqzn6yxso2YM6zEN91fytql0sJ2Gz3leHoHYfBAc6dxGoaDK8CzKzUv8F1wZk+03WNypnb1KeYyzdOEhD7+9oKxcYTPqusEdTacMmzAubSaSctWT/76J8=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;6:L9ILFfQZkf3RUTiLwT9sIckbEYOCbCpsWRIV+YtMrVlwAXEC4JxYIQ8xPK0QLuFjltbwUo7afzjaZh0oCCjHu9JiniEsYz0tmChshhNnv/zLREz1Mh3eof1/31cwnNJ/iHoP7EMg2zJKbY3SIBOIyPeYqn11C+VQvPNnx8GYpa4O9jy2wdG+CokuqqG/chKlc+MbVIdObiWH/M+aiIOyV/RXMZ3umoKHrdEbhQ6ck7ShgBMkXNlYz/GWXKhWMSQaCC+1FBlfX59cjFtHDphsIGcvnB4wOYIJyzhTyLbz0QTfn5lNEdvbJQbD5kDM1b/WoDTp3dMzJQSyv3zjqP1YVT/a5rpz3eb+quxc7CTQW4XK9XsKLsq3fuGZxJDzaT/UF6Zzrri8Y8+EK3ivunLu0ptiAeFMfEu6EOMCqs0SlL97ON7P2i3qPrM4KQT8m/AgJ5hkTw0B8I8giGnvJlwfxg==;5:6cCQdXC/9lr3A9Hd34WvKH5aq2LeCJgg6x5LlMsjXhOoquoZkpSudNadPrmUqk6bhqEQS6DhltNnOb3pQF0xdydkyJw7bBL3mo1kPk5RqR2coyaCvwSAndJI/fe61Jax0OfsFlsW6QZ5hpFix0guLoVQ/IR09PTDnls3Aq/0+Yk=;7:uCUl68UwH3zbrafaU7J1jxSOSqZ1J/ZwAnPiAD/zvQVdjMhxjK31QYwmoxB0nriniongib6eh0RCThgyr1ubu+O+KCV09dzQyUe90N5oK67A89tjcP/AEOCEZ3cw9IZK+kp5A97gNIOTUr4qZSxq0ruEYt3YF9SjhP52Cjuxn0xtWxWOVTdeTDyOMBSFeEmuQwpCsbJ1AB+LtQ+fn6UgOLOpKYRL7Ypzf+p7tX1XI8T4GJ+YH6u667f9IrrLVkEF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 08:04:52.7306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5837ca2a-bd01-407f-2db6-08d61c744080
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move berlin binding documentation as part of transition from Marvell
berlin to Synaptics SoC.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/{marvell/marvell,berlin.txt => syna.txt}         | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/arm/{marvell/marvell,berlin.txt => syna.txt} (100%)

diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/syna.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/marvell/marvell,berlin.txt
rename to Documentation/devicetree/bindings/arm/syna.txt
-- 
2.19.0

