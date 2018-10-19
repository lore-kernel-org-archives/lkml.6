Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5ADECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613DF21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="r0EVb9Iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613DF21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJSTZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:25:44 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:24716 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeJSTZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:25:44 -0400
X-IronPort-AV: E=Sophos;i="5.54,399,1534834800"; 
   d="scan'208";a="21941064"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Oct 2018 04:20:04 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 19 Oct 2018 04:18:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW2WIqGUDlhCSUS28KR7GLp7cYk3J1e+dvgtU1S9ycA=;
 b=r0EVb9Iw26jSdcRHI/BHfqg0hNhCH1UUIswjE+bRtDMxYVRO48ZKullcHDcOi5lVdioP3dPOZ7dsFXWUsoD6Hta+6mZCRvsIaSPdVMGWY4uMKD+Q2+Hm+PWB/j8OUmnGtwGfbcEOxHLDp/Sbz5W5hMLcW7Y+tEzTbggwstCmyrM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
Received: from [10.145.4.38] (94.177.32.154) by
 SN1PR11MB0750.namprd11.prod.outlook.com (2a01:111:e400:c426::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.25; Fri, 19 Oct
 2018 11:18:36 +0000
Subject: Re: [RESEND PATCH v5 0/9] extend PWM framework to support PWM modes
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-pwm@vger.kernel.org>,
        <treding@nvidia.com>, <shc_work@mail.ru>, <mark.rutland@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <b95d0de2-1a97-36f0-03ad-3b5e52b1fa5d@microchip.com>
 <20181016120321.GG8852@ulmo>
 <fca49cff-f883-baf4-4bd3-80f45635bb5a@microchip.com>
 <20181018160038.GD6226@ulmo>
From:   Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <67708c92-edbb-0429-d7e7-ac000968c271@microchip.com>
Date:   Fri, 19 Oct 2018 14:18:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018160038.GD6226@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.177.32.154]
X-ClientProxiedBy: CWLP265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:12::28) To SN1PR11MB0750.namprd11.prod.outlook.com
 (2a01:111:e400:c426::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51a8a025-6ab6-4350-a18e-08d635b49f94
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN1PR11MB0750;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR11MB0750;3:f0TDMxpyODFH3u2LaKXg5IOJQB1UPTOioT4xsdekbtpa+LKvduzzsXc3Jw/u4gAlFu2weSjuQZXBl4W5ahPn4R1XDBXq54ExeaE4b2HY0TJQwwDSYZgMgddTgg9/AsD6SVCn2G1onQ5m96/56FviJSjmfZtq+lYZth7Xfq6qBlXzUpiTTMqMPtDB1+QfICsck9rZJquUsPVmSR7GHwl1JxD9mM2SxIt7uK381UC41SUGDki1/zRzLXXzksblrZSG;25:uq4iUY2dmcPuro/aqZT4Mc82Mnl/2u8nL6Tl6Hu/aEG59xDiWNfSMCMtjc1af5l2Hpk3ZenlvYK7AbSpMIxEFup/lGGWa9ArL0XDZ+mUJdCEKooG49QqzjS82M96YuHGHjyiyR6AXyr/+QBk7g1hrDoRvBi/VzerKas/Zj99mQEOd/i2VQd9KuOWeKLqQ5OUB5W6kmkbQcIQOK1F68sUcqMHDVHDs5DlGfzUSaP/gx7xFkBFY/P53Jjs0COJFRFRjfwS0TZz9QdkxKNs65lpQDepxY6L+BmWqXpnnBOEr0j3NU4t/Iml801CQW3yjpa87oEgy5h2HQxgd2qXfBC5gPU5JfzSy1Pb0HpWAZ3byKE=;31:/WnaPsjD7cMPIrBbYjw4QCKCbl3aBAIH1u5704m1I2sPZVje3QJI1aEMwGYP4gulxe9EMBtFA6z5nr+Cxb8qrB2CxaoOIMk3HRjVQySu7VmnQL+vHQ3k0q+GHQlR8JW1XxssBpVZ+uH00cHBDHdn86eC3/YcY4+UOtj0oGy9/1JGQai2CEAi0RvmxOqGN+RYmhTPqmuqdcwxeJUhlswdbdpRWNQxTHXv5k3CFW97M7I=
X-MS-TrafficTypeDiagnostic: SN1PR11MB0750:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR11MB0750;20:sqIsLL3iXxyoAvFJox7G9/p7vqbNaSJLHfDyKDT+FosvjtaVEJdUkYfXCnW1qwQLxrd6CBGAe6Th/QlVZUV84Xl4Yfue2b6tPlxVLcsrN1G7WCukoPiGLkhFEA538D6RSuRLPKRINaA/+w8mnVU9taWFgAqUDV45syyvHHS9RGBb9ff/hJlsgx1646/fDBLXYpqdMMYL3OGsBjDJtqllHItqCHyGyFoI3we7Gai8Gg5hpSuTa2lPFT79Na00J543QuMNxWb2qQmTzbHf8t206NRXMTKWZHb8veUeCoepST14Ervs51Q4QMuDShUC1/D5pAc7/aTW3M3zqprRJlfXVQxwDiqbiRto5bRXaMJ4BJgEmymXc8xU6doN+uAl1mFgeMJI4PhYEplbm+kb/FEh0QKfhwCXUuEqb90Ih7clKqE=;4:cL097il5HlhZJ3JwVHrGfR3wSn2R8O2lvNb3pHLukfLD6jhNI1IUk9SfAwYjo3yVSMFqwSPtqwOQMEME6WnuglZdT7xVWtHYi+jMmVAolWaMYxDQWuZ4WPG/ZzCX/AieIgfG5hBYWdMHZRkLViCn0ziUujay08j3rHILIfXDS6YviU3Q5LBcXVpEofxeZfmUmCCGkf1cVim43ZNFs4iI6rfqyfqAU3p28TyFLkQuEddtSGaszvTop8j2xUQFxsK8IG5igzs50PHFBHZuWce9Yw==
X-Microsoft-Antispam-PRVS: <SN1PR11MB0750BD3CF218CD11CAD07A3E87F90@SN1PR11MB0750.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(4982022)(52105095)(3002001)(10201501046)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN1PR11MB0750;BCL:0;PCL:0;RULEID:;SRVR:SN1PR11MB0750;
X-Forefront-PRVS: 0830866D19
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(396003)(136003)(366004)(346002)(199004)(189003)(52314003)(72206003)(956004)(68736007)(66066001)(81166006)(476003)(16526019)(11346002)(230700001)(65806001)(106356001)(26005)(8676002)(105586002)(478600001)(65956001)(31686004)(77096007)(2616005)(186003)(47776003)(58126008)(31696002)(23746002)(76176011)(486006)(446003)(25786009)(81156014)(86362001)(966005)(8936002)(97736004)(16576012)(53936002)(316002)(6306002)(65826007)(14444005)(6116002)(6666004)(4744004)(2906002)(39060400002)(5660300001)(36756003)(217873002)(4326008)(52116002)(229853002)(305945005)(7736002)(53546011)(386003)(6246003)(7416002)(6916009)(50466002)(64126003)(6486002)(93886005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR11MB0750;H:[10.145.4.38];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR11MB0750;23:n6ADTB4aGQ4NZLpiuxNcWqa0ouPsYD0RXj6j9?=
 =?Windows-1252?Q?vseLKpRG/7of5PBOVadjFYiayBZAlN1VrqsI6OnCwrev4bDd4shPAEJj?=
 =?Windows-1252?Q?+V9TG5T0HK1cFExC/fXv8WhTFNd7bsMtwVBCDSE3wgQIwJQpyrgFlzEq?=
 =?Windows-1252?Q?7TlZ0CNxmLQmFW6TOrKuJLQIwEC0Q7c9+2wWxpuejNVnCn0k2lajRhYe?=
 =?Windows-1252?Q?srY+rfidnOYiM8M5woVObmLEiTBe3BKyWO3rRjujDHs896koxGdseDIB?=
 =?Windows-1252?Q?HGWx1RZ2XfWHw2rjLwOsvHPCvpUCadWdEt0k6+KahBudwZZBmCEC4mub?=
 =?Windows-1252?Q?Y4olFCU/Fin+urWk1IF6J6yJhBjEFV9iSLXcfy0R5yeMsBOpLdUm/nT8?=
 =?Windows-1252?Q?m+KX1po3JFfGmuWB0gtmbB7nvexKBQyLfmlOCof7xGlEmARP2AxQCTWR?=
 =?Windows-1252?Q?7fFe0KWhEXbULakrmUx4y3uKAdN5dVbgPzp04aJFbIvvStVmsyvQHxK+?=
 =?Windows-1252?Q?r8A2SXQ1VtIjyRQ5uzRe9gvLE484Mbws6VZ+ZcstdzLAg2LK6HEkdGIQ?=
 =?Windows-1252?Q?aGFDS5AjtjjNUp4BCAwSFkY6V8x7Gro2kdhNuw2DfNRroVx2DxOj5CLx?=
 =?Windows-1252?Q?u5JdPE8WmrL4ItllSObg841qSYkqAIevPy9L2KLd/zgvxevGnaXWxib8?=
 =?Windows-1252?Q?Mh1DdegN6lujQKXHgzyc8+UXZKx5VJoQuIH4s/Qk6EvlBsnofaMaSg4y?=
 =?Windows-1252?Q?VEIgXlMtaTMEztNIOD6MZg0Xz85rVAcyyUn+XUJ1MBaVU1YqsUPouTPR?=
 =?Windows-1252?Q?lAbQDBSF+/d11nVoStqmfSCvQV/o5oLbtwmXvObJoAAsce1dKZzJEya7?=
 =?Windows-1252?Q?JgQ4fdJkO9LB0o1wzjT9g6d6UfhiAxsyuZgllhjKUq/KABKGPvFvus4d?=
 =?Windows-1252?Q?sQUP136fuGiQOq/mAAjI5naDPWFEA7n9dcAY519oJ1WtkkSpQYsoY7C1?=
 =?Windows-1252?Q?t/ktKt8Vqs5u040tNiu6BOEaXQog85R5Aqv2CUoXvAeyBUYmv4b/HHJC?=
 =?Windows-1252?Q?57j1fsG3B92Gj3zKhVfEYZibIctr66a4vDTAU/PoVxVc+w6Q924G60Ie?=
 =?Windows-1252?Q?bYgK2p7BAs/yDUtyCcvQsEaFoM3/AqBwt86RXBidx0NHs1WrSWQ4nybv?=
 =?Windows-1252?Q?hYSaX1BvJXvQHsTSC/JiHKQwYj8rchcFRBul2OI2xxMN+VC3+H2GBDwM?=
 =?Windows-1252?Q?m9QKdXQeHaqfAxAQIuogovnlOu8LNJ+4gPxO+4B0CkHmd0zE6h+8G+Jh?=
 =?Windows-1252?Q?tel5Omt0ArkYcJc1RlSY35+moAr32Eopb33eMfO/Sj2RQsAOnLJlDCBf?=
 =?Windows-1252?Q?UU5kgK4SXNEdE+MlvdIjCRk1gBGG1H+CeZHVsrzu5L0baRPBx7qwdLJM?=
 =?Windows-1252?Q?x9AJQP/atPpNJiV9ZD1hxmIhPSRlmolmsK0qVcGEIDJ9/0Ax8CcVqG38?=
 =?Windows-1252?Q?LjB8D05+wy6Vo+iWGATcwtAY1jF3GUCUoGTJoxRbQwRzx/8Fe4KoCfDI?=
 =?Windows-1252?Q?b9+sjAOGeMAH0uGHPjSqTU29HgL6RPscZXMXS5OueeX2A3Ntandc1qbL?=
 =?Windows-1252?Q?qj9Z1LDYUORdlGEr9i2U9uOdlZPn7OxpjmLkBhFR2vrv7xQ93B8xJ80I?=
 =?Windows-1252?Q?mFBQWmaRid6OlD60JhfUdtW4dBY+WQ=3D?=
X-Microsoft-Antispam-Message-Info: 6YFs+bkPkI2LiGUVnTPv0yv07+0UDkIg+/jvaz0mgKzOcgPY1BXOr5gIkDZmjT9MeyAGDZ0m2EwQe6WOShuBPbLkhU6qKeihqrMry2cCwTMBZQ5qH1nApOthuGDOAeC9JRh2pi7JeVJ8uAa6Ws7DTaAxoi/+qV4wJwItWfK/kPL1WJrUna1qtx2wDGP/kZWZuw6Acu9SF1MaJq7KK+rHCgZaa45mi5bolaePa/fFIhEjJTwt/W12EezU0cNGsLatPZplDQKpERfUj5+knsX+uwI2EPUyzZC4MLAF3lPsli70KTDVf/6Oygo55LKL42KRwGKpS5tCd/6ssBFV/yPL4RHoKO7VhnLpJfHKu19PxK4=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR11MB0750;6:sEOTq+TWKUmw7eWY6xGu+TgfUl/6u9GkWbu4yn7+GBj8BO3AkPRmZIZgRp7swX4NQPWn6Pp0ABuQEgRmJamaHYxHd09TUmYLiCVn9kYwoCnKtfJsHLvHzgNOtRjJ5oTz//nPBokROG8if65Q5Ek6kszOD5YntI4Bff1nSeEIOVX50WK92NYBc+oYfp9bHz8SptRJ6S7bqpJRcvEfk0OLaGsiiS7PBjDCdN8NPGk8f79AoVZcMv2O1mFMKEc60GY+CzEe/RYiGBz03r7bxF4q5TJ4Y/BkJlPk9C1a6oBqq5NBVaC/GhDRUShARNwSADWXfs2i/6m8Sr5GKhibav5N1WLfa7FrQ4EF+ilSZzkSYqanufCrXTv5sShocCZuXUM8HwCaG76sHLu5I/PBhw/42j0WncJTfmZDfNa+Wt7zt1wB3qRUtkGzSjfiDlIbcuPpOp8vj4jIhCqYaluHwnCdXiCDJEf6qosVRn/tBLWr2q4=;5:vjACiiBk719cx3WGyGjX05My7Dcc9VbR6LfFL5wgkv1GlOC4W7Y7Qt7Ps6z+SL9h3qxG/QhJLYS5JmiuyG/RqMuOlJqrEREV+3FdNb+1e/LSTdst2Z0d6pOYdwYrN3hHzkITENXrNseKuVcIx7YEM5XP249C/uB6LX3Fv5t8Mb4=;7:g/w6fJsQr8TFLKr6UXMV0xZlpn9CHnaVpaIuW+E3WXgX+RPmm93eLG2ifI+AZJlZQfTrQcQc0A/0x7st6qUHF0Ldx5dqTa1DIXQwKZIAMYo+Gyia0+vAtl4JtRGdJ0UP1Aglq8bNlZJ9Yi5v0JX5TdDPgBKMCgk/Lxqpva3iRkZ4rR3sRI328/rZbHEf0qwUNbmoYs+mg5/vDgbkfrGTbXcl2HUAiGbezdiEZ4n5vXl1jirwDzvAxe66n7zM1/NK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 11:18:36.9392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a8a025-6ab6-4350-a18e-08d635b49f94
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR11MB0750
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.10.2018 19:00, Thierry Reding wrote:
> On Wed, Oct 17, 2018 at 12:41:53PM +0000, Claudiu.Beznea@microchip.com wrote:
>>
>>
>> On 16.10.2018 15:03, Thierry Reding wrote:
>>> On Fri, Sep 14, 2018 at 06:20:48PM +0200, Nicolas Ferre wrote:
>>>> Thierry,
>>>>
>>>> On 28/08/2018 at 15:01, Claudiu Beznea wrote:
>>>>> Hi,
>>>>>
>>>>> Please give feedback on these patches which extends the PWM framework in
>>>>> order to support multiple PWM modes of operations. This series is a rework
>>>>> of [1] and [2].
>>>>
>>>> This series started with a RFC back on 5 April 2017 "extend PWM framework to
>>>> support PWM modes". The continuous work starting with v2 of this series on
>>>> January 12, 2018.
>>>>
>>>> Then Claudiu tried to address all comments up to v4 which didn't have any
>>>> more reviews. He posted a v5 without comments since May 22, 2018. This
>>>> series is basically a resent of the v5 (as said in the $subject).
>>>>
>>>> We would like to know what is preventing this series to be included in the
>>>> PWM sub-system. Note that if some issue still remain with it, we are ready
>>>> to help to solve them.
>>>>
>>>> Without feedback from you side, we fear that we would miss a merge window
>>>> again for no obvious reason (DT part is Acked by Rob: patch 5/9).
>>>
>>> First off, apologies for not getting around to this earlier.
>>>
>>> I think this series is mostly fine, but I still have doubts about the DT
>>> aspects of this. In particular, Rob raised a concern about this here:
>>>
>>> 	https://lkml.org/lkml/2018/1/22/655
>>>
>>> and it seems like that particular question was never fully resolved as
>>> the discussion veered off that particular topic.
>>
>> 1/ If you are talking about this sentence:
>> "Yes, but you have to make "normal" be no bit set to be compatible with
>> everything already out there."
>>
>> The current implementation consider that if no mode is provided then, the
>> old approach is considered, meaning the normal mode will be used by every
>> PWM in-kernel clients.
>>
>> In of_pwm_xlate_with_flags() the pmw->args.mode is initialized with what
>> pwm_mode_get_valid() returns. In case of controllers which does not
>> implement something special for PWM modes the PWM normal mode will be
>> returned (pwmchip_get_default_caps() function has to be called in the end).
>> Otherwise the pwm->args.mode will be populated with what user provided as
>> input from DT, if what was provided from DT is valid for PWM channel.
>> Please see that pwm_mode_valid() is used to validate user input, otherwise
>> PWM normal mode will be used.
> 
> No, that part looks fine.
> 
>>
>> +	pwm->args.mode = pwm_mode_get_valid(pc, pwm);
>>
>> -	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
>> -		pwm->args.polarity = PWM_POLARITY_INVERSED;
>> +	if (args->args_count > 2) {
>> +		if (args->args[2] & PWM_POLARITY_INVERTED)
>> +			pwm->args.polarity = PWM_POLARITY_INVERSED;
>> +
>> +		for (modebit = PWMC_MODE_COMPLEMENTARY_BIT;
>> +		     modebit < PWMC_MODE_CNT; modebit++) {
>> +			unsigned long mode = BIT(modebit);
>> +
>> +			if ((args->args[2] & mode) &&
>> +			    pwm_mode_valid(pwm, mode)) {
>> +				pwm->args.mode = mode;
>> +				break;
>> +			}
>> +		}
>> +	}
>>
>>
>> 2/ If you are talking about this sentence:
>> "Thinking about this some more, shouldn't the new modes just be
>> implied? A client is going to require one of these modes or it won't
>> work right."
>>
>> As explained at point 1, if there is no mode requested from DT the default
>> mode for channel will be used, which, in case of PWM controller which are
>> not implementing the new modes, will be PWM normal mode.
> 
> I don't think that's an issue. I think what Rob was referring to and
> which mirrors my concern is that these modes are a feature that doesn't
> extend to typical use-cases. So for all existing use-cases (like LED or
> backlight) we always assume a PWM running in normal mode. Now, if you
> write a driver for some particular piece of hardware that needs a mode
> that is not the normal mode, the question is: wouldn't that driver know
> that it wants exactly push-pull or complementary mode?

It should, yes.

Wouldn't it have
> to explicitly check that the PWM supports it and select it (i.e. in the
> driver code)?

Yes, that should be the flow. I added the DT changes for cases where a
driver could use more than one mode and to be able to choose one of the
modes it may needs.

> 
> Say you have a driver that requires push-pull mode. It doesn't really
> make sense to require the mode to be encoded in DT, because the driver
> will only work with one specific mode anyway. So might as well require
> it and have the driver check for support and fail if the PWM is not
> compatible. This would likely never happen, because hardware engineers
> couldn't have validated the design in that case, but there's no reason
> for the mode to be specified in DT because it is fixed by the very use-
> case anyway.

Yes, agree.

> 
> Also, leaving it out of DT simplifies things.

Agree.

> If you allow the mode to
> be specified in DT you could end up with a situation where the driver
> required push-pull mode, but the DT specifies complementary mode. What
> do you do in such a situation? Warn about it and just go with push-pull
> anyway? Then why give the users a way of screwing things up in the first
> place?

I only introduce this because I had in mind the PWM regulator and I was
thinking to make it work for either push-pull mode and normal mode. But
since there is no code for this at the moment I totally agree with you to
not introduce the DT part. My bad I push it here without a use case.

> 
>> 3/ If you are talking about:
>> "Also complementary mode could be accomplished with a single pwm output
>> and a board level inverter, right? How would that be handled when the
>> PWM driver doesn't support that mode?"
>> This complicates the things and I think it requires extra device tree
>> bindings to describe extra per-pwm channel capabilities. For the moment,
>> with this series I've stopped to only have the capabilities registered from
>> driver. My understanding is that this could be accomplished with extra
>> device tree bindings in PWM controller to describe PWM channels
>> capabilities. If you also want me to look into this direction please let me
>> know. And also, suggestions would be appreciated.
> 
> I think this is very interesting, but I don't think this needs to be
> done as part of this series.
> 
>> I know that Rob acked
>>> the DT parts of this, but I suspect that this might have been glossed
>>> over.
>>
>> If this is about point 3 I've emphasize above I would like to have some
>> inputs from your side, if you agree with a behavior like having extra DT
>> bindings. The intention wasn't to left this over but to have a better
>> understanding of the subject. I'm thinking if it is ok to have modules
>> outside of the SoC that model a behavior that could not be controlled from
>> software (it could be only hardware) but to behave in a single way. Take
>> for instance this scenario:
>>
>> - new DT bindings are implemented to specify this behavior per channel
>> - hardware modules are soldered outside of a PWM channel with one output
>> - the new DT bindings are not specified for the soldered PWM channel
>> - user enables this channel, it will have only normal mode available for it
>> to configure (because the new DT bindings were not provided)
>> - but the real output the user will see would be in complementary or even
>> push-pull mode.
> 
> I think we could possible model this as a "logical" PWM in DT. We could
> for example have something like this:
> 
> 	/ {
> 		...
> 
> 		pwms {
> 			pwm@0 {
> 				compatible = "pwm-fixed"; /* or whatever */
> 				pwms = <&pwm 0 40000>; /* input PWM */
> 				mode = <PWM_MODE_COMPLEMENTARY>;
> 			};
> 
> 			...
> 		};
> 
> 		...
> 	};
> 
> The above would model a logical PWM that is driven by the specified PWM
> in normal mode but which is effectively complementary because of some
> additional circuitry on the board.

Ok, i see it. Sounds good to me.

> 
>>> To restate the concern: these extended modes have special uses and none
>>> of the users in the kernel, other than sysfs, can use anything other
>>> than the normal mode. They may work fine with other modes, but only if
>>> they ignore the extras that come with them. Therefore I think it's safe
>>> to say that anyone who would want to use these modes would want to
>>> explicitly say so. For example the sysfs interface already does that by
>>> changing the mode only after the "mode" attribute is written. Any users
>>> for special use-cases would want to do the same thing, that is, drive a
>>> PWM in a specific mode, on purpose. You wouldn't have a "generic" user
>>> such as pwm-backlight or leds-pwm request anything other than the normal
>>> mode.
>>>
>>> So my question is, do we really need to represent these modes in DT? The
>>> series currently doesn't contain any patches that add users of these new
>>> modes. Are such patches available somewhere, or is the only user of this
>>> supposed to be sysfs?
>>
>> For the moment, no, there is no in-kernel user for this, only sysfs. I had
>> in mind to adapt the use of these new mode for PWM regulator for scenarios
>> described in [1] page 2126. Anyway, since these patches doesn't introduce
>> any user other that sysfs it will not disturbed me to drop the changes. By
>> the time I or someone else will do some other changes that requires this,
>> the DT part should also be introduced.
>>
>> [1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf
> 
> Yes, I'd like that. The half-bridge converter certainly sounds like
> something that may be able to use the DT bindings that you specified,
> but I'd be less concerned about these changes if we had actual users.

I understand.

Now, thinking again at what you proposed above with regards to logical PWM
channels I'm wondering if, for future, if needed, would be good for PWM
clients that could used a PWM channel in more than one PWM mode, to have
specified in device tree, as a child of PWM controller, the mode that the
client would use that channel. E.g. if DriverX wants to use PWM0 in
complementary mode:

pwm@00aabbcc {
	// ...
	pwm@0 {
		mode = <PWM_MODE_COMPLEMENTARY>;
		// this being the only mode that could be used for
		// PWM channel 0
	};
}

driverx@00ffffff {
	pwms=<pwm 0 50000>;
}

For future reference, do you find this feasible?

> 
>>> I'm hesitant to move forward with this as-is without seeing how it will
>>> be used.
>>
>> For the moment only sysfs is supposed to use this.
>>
>> The PWM specifier flags are somewhat abused by adding modes to
>>> them. 
>>
>> I see.
>>
>> I think this hasn't been completely thought through, because the
>>> only reason to specify a mode is to actually set that mode.
>>
>> Maybe it wasn't clear understand, with the current implementation if no
>> mode will be specified the default mode will be used. There is no impose to
>> specify a mode.
>>
>>  But then the
>>> DT ABI allows a bitmask of modes to be requested via DT. I know that
>>> only the first of those modes will end up being used, but then why even
>>> allow it in the first place?
>>
>> I had in mind that I will change the PWM regulator driver to work in
>> scenarios like the one specified in the link above.
> 
> Yeah, that sounds like it would be reasonable from a quick look.
> However, what I don't quite understand yet is why the mode in the PWM
> specifier would need to be a bitmask.

You are talking to have them as bitmask in pwm-flags cell right?
I though to stick this to the current way to request the PWM mode.

Take for example the pwm-regulator
> case for a half-bridge converter. If your board uses such a setup, then
> you absolutely must drive the PWM in push-pull mode, otherwise the
> converter will not work, right?

Right!

So you want exactly one mode to be
> applied. Then why complicate matters by allowing the mode to be a
> bitmask? 

Just to have everything behaving almost in the same way as it was
previously.  I'm saying to request the PWM channel from a PWM client (via
DT) as it was previously done but just adding the PWM mode (in pwm-flags
cell as per this version).

I also was not sure about this: in the 2nd version of this series I
introduced a new cell for PWM modes but this new cell was after pwm-flags
cell, and pwm-flags cell is optional, so to have simpler code, in scenarios
with PWM modes user would have also specified the pwm-flags cell (although
maybe it was not necessary).

> We could just as easily reserve, say, 8 bits (24-31) for the
> mode, which could then be identical to enum pwm_mode.

In pwm-flags cell, right?


> 
>>> And again, even if we allow the mode to be specified in DT, how do the
>>> consumer drivers know that the correct mode was being set in DT. 
>>
>> PWM user will call at some point devm_pwm_get() which, in turn, will call
>> of_pwm_get() which in turn will initialize PWM args with inputs from DT.
>> After that PWM user will, at some point, apply a PWM state; if it is
>> initialized with PWM args initialized when devm_pwm_get() was called then
>> pwm_apply_state() would fail if no good mode is provided as input via DT.
>>
>> Same thing happens if a bad period is provided via DT.
> 
> But that only checks that the DT specified a supported mode, it doesn't
> mean that it's the correct one. For cases like pwm-regulator this may be
> fine because the driver ultimately doesn't care about the exact mode. If
> you have a driver that only works with a specific mode, however, it can
> be problematic.

Yes, agree.

> 
>> Let's
>>> say we have a consumer that requires the PWM to be driven in
>>> complementary mode. Should it rely on the DT to contain the correct
>>> specification for the mode? And if it knows that it needs complementary
>>> mode, why not just set that mode itself?
>>
>> I'm thinking it's the same way as is with PWM period which could also be
>> provided from DT. In the end a bad period value could be provided from
>> device tree. E.g. Atmel PWM controller could generate PWM signals who's
>> periods could not be higher than ~0.6 seconds. If a bad value is provided
>> the pwm_apply_state() will fail.
> 
> I understand that. And it's good to validate these things in the driver.
> However, the PWM driver can only validate for the PWM that it is
> driving. It doesn't know if the consumer has any special requirements
> regarding the mode. So if the PWM supports push-pull mode and the DT
> contains PWM_MODE_PUSH_PULL, then everything is fine as far as the PWM
> driver is concerned. However, if the consumer driver strictly requires
> complementary mode, there's nothing the PWM driver can do about it. So
> we either need the consumer to be able to query the mode if it has any
> specific needs and refuse to use a PWM that has the wrong mode in the
> specifier, or the consumer needs to explicitly set a mode, in which case
> there's no need to have it in DT and the PWM driver needs to reject it
> if the PWM doesn't support it.

Ok, I see your point and understand that DT part may be risky and
complicates the things. And I agree to remove it from this series since,
anyway, there is no in-kernel user for that.

Thank you,
Claudiu Beznea


> 
> Thierry
> 
