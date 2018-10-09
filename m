Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5548CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9D22054F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Bh2oBcjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9D22054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeJIR7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:59:49 -0400
Received: from mail-bn3nam01on0078.outbound.protection.outlook.com ([104.47.33.78]:36746
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbeJIR7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZDbvX80yVo90qgesIGNUf+ardU3SYNN5g2N2J79h8k=;
 b=Bh2oBcjHoHeFOW5/TGXvuBWtCrRVnIoGV+g7bKFkcNmNHyUk6RfCNTSLot/MrCUfWxxUP5zSCoq1VSPRhmcBhB/h9Hbxyd+2nKBDOCXJcy/bQeDrUhZN472l3r0qH7eZlVEAGAb70htBWC3asHaZSreeNQWXPyPBVggVadq6px4=
Received: from BN4PR12CA0023.namprd12.prod.outlook.com (2603:10b6:403:2::33)
 by SN1PR12MB0430.namprd12.prod.outlook.com (2a01:111:e400:5865::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.21; Tue, 9 Oct
 2018 10:43:25 +0000
Received: from CO1NAM03FT042.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by BN4PR12CA0023.outlook.office365.com
 (2603:10b6:403:2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.21 via Frontend
 Transport; Tue, 9 Oct 2018 10:43:25 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 CO1NAM03FT042.mail.protection.outlook.com (10.152.81.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1228.17 via Frontend Transport; Tue, 9 Oct 2018 10:43:24 +0000
Received: from hr-amur2 (10.34.1.3) by SATLEXCHOV02.amd.com (10.181.40.72)
 with Microsoft SMTP Server (TLS) id 14.3.389.1; Tue, 9 Oct 2018 05:43:22
 -0500
Date:   Tue, 9 Oct 2018 18:43:19 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Colin King <colin.king@canonical.com>
CC:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][drm-next] drm/amdgpu/powerplay: fix missing break in
 switch statements
Message-ID: <20181009104318.GA20785@hr-amur2>
References: <20181008162228.4599-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181008162228.4599-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(428003)(199004)(189003)(106466001)(23726003)(186003)(446003)(26005)(1076002)(46406003)(6246003)(77096007)(105586002)(33716001)(2906002)(4326008)(104016004)(97736004)(336012)(426003)(33656002)(11346002)(126002)(476003)(316002)(229853002)(86362001)(58126008)(575784001)(81166006)(53936002)(76176011)(356003)(8936002)(6916009)(305945005)(478600001)(72206003)(81156014)(486006)(5660300001)(33896004)(8676002)(50466002)(9686003)(97756001)(68736007)(6306002)(54906003)(55016002)(47776003)(16586007)(6666003)(966005)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0430;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT042;1:1dBJ34ZdAfRekRf5gYWBQpAyEK1rZUw2UrXnSbpXy5vr4wfhnOiAIybE4j7GR5iu+szQw0A89gBB8U62h1IR2DUmAvmdr1HDeCV6c/pmjmc5ozJMexDpvLqSaDQbiv+t
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aab0b318-d26b-4839-985e-08d62dd40a5d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:SN1PR12MB0430;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0430;3:KJdID+8BpKa4Tsck9iIHNCKy0iII/QFkV68RULRxTUv9VbbU0L67MOkNRex+6MGLQ/aQ9gmbC0mCvLwmS4aNHKr4zI5rHoMTJQTewSS1JnzJ/6SA19poSl6ZW/rlSuliB3+DA8mKeIJsASQSB0TAMWywDVz5QNDYhyjVIapFldJVjk5zIeEj9Mm8CBThIpuDUYTp9MJLvWhpTHRZVGqz1ujveil8CFWzhb5msonVNgQTSR+FFs8FKCfJ1DCB93KgMzG8wZPRIKqacn9I/Cz22byN4Ib91v+9nbWAyDK2bP2U9SXZGVBRSwvF6krSXXh6AtZRRY/FHcVV3r0F5ydsSnWNZgdUozHj7pvpahK4Q4I=;25:kq/RTpRfHqjSazdEndGocHOPob4Wemj7R/9QIMxSk7pu2PC1K/eLcHkKwucpfZIJpYT7BZfqDOnMgNZYrh9yWZe8dTAyQOPzCVjM7com587V3+BzmgKKW1zhknDphqghiPeI2TOpDzdBiSK21de/83/EpnqdZX7p9xs3a76ZAZGDuVsDe4TMw9lGPgEp1keZwv8ytxjzC0UWy36w87PcYkswnXvQlZCnsbKb8DlfL8T4orjyjm9TSDoUy4e3KSZM3BQ9zpmU1qvZlTegHlKBkqE/SvG3cScpWFSPfwzY8zgzGtLb6EbcR+uLgb27CErfEU9l38wlMIIC5p85/3gR4A==
X-MS-TrafficTypeDiagnostic: SN1PR12MB0430:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0430;31:Hy1LVW0ZQ+15S4MvwOIlq46Onn7gghjUAvOu1y2RJ5HYaohmKwmG9d5n8pSVJTQdZqutlN6GOvK9SzSfkS3OA7bqSSsMryZ8i1qI2sd8jHWWVRxXAW1qCDYz5WxJ2JvvOLprlHzRazhb7TXM8y+OO3CTehflQA6UBRudPEsFU3paJplphN1Gh5qf29cIifKJWb+LiGEbQLEif1FUlLxccUnF11k/fMmXuE1pk22PaQE=;20:AlZHMuoVfauXI3PvYd35+n6BQPzp45A4WgqpZ588qPdnm4H++L9VSSFeT+YiZLwQFFNarwJ51gJPU2AhAAePekYHVd8sSiflA6i7ik/eVd3+hyICm/3QbnvF9oZsHaVBmvKvyBlKdxWa4AiCiZKTMa+z+cYEz/4CAPy164oidljO4AniTv/BVHJQAM5qfuMLr/K0gPqcdLb1z26J/BVJBTUz1y+kokhnpyJB1cjitXSHz48OiZjnUkq8PcAXL1KNhaRvHqiDl5j21nV5XoaMJ613A0x0fWr5ziNtYZOJhipLQHy/6AhDXM/crlc+Z5RKyxH2syJ9DLztlAF8XYnIEzHo7nrsgkG3wwvJMLL4plW5LIp2iPrJzavNKvm8C6eNwrWeYOaNkZ40l9Z9O8dajvp3I/hYOULyYHspyG14xj6msLa2+u1i6e+tF5V974KeMxJZVLmyNqx1p+dTjUV7T96NyyRYtH9Do8dQZvLj81n/ImWq7Wz3HysGmu20iAEA
X-Microsoft-Antispam-PRVS: <SN1PR12MB04307EBA1596F428D9D56455ECE70@SN1PR12MB0430.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910)(767451399110)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:SN1PR12MB0430;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0430;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0430;4:qF/MfTR4RjRjD+d2Wncy3376nbDyF8BuXrH4kS1H1HrrJVgEXQOoEO1Ltx99lwJBmfY+hcIf9X+vLBwDXUU5aMRiy+MoHGNLJMpW44OxFMiQcNpmVqR0AQQ/V9qs8Z++HqzLeHgLNCiXux4bBCnWweg1WPDjekLRQqAaF1qQLv+Dtg7oMJR90IAtl5BpGKoTbQf/tzn4ncVgptUY3lsYnfp32v2joGonsHcFIULYMqVGo5Wf2v636scOaGhB5CHGDKStNroPf1mDDoKyUJ2eW8HKrbgq2kfejoRZwhumdkbP+qAZGhZSksNl+g190w3IDSxp0I83TX0eWLMKeSk8xkmB78qXYvkjQ0W05kQvDOXDAUicUo8Wc8V0PR0tf0B/
X-Forefront-PRVS: 08200063E9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0430;23:yOFV4ecLygoaH4ynL5H1v00lRIYvNkTgg8BIfgLh7?=
 =?us-ascii?Q?3oNq6UlqqZ+vPcfHzIcFk1WwstPFM4juJcjRRWFIidvy2d9pnr1csWCjP0nK?=
 =?us-ascii?Q?81uAMRVexl4vwB31Ip7fzNj0QWVgw0OmthhDtnKw/k60aDuR0OgohPUtvfUr?=
 =?us-ascii?Q?aJPp0x61TwJ3G7q3h0zPIevoDnOnRN/KSmTeQ+E47tCBMLXLrWcimdWbwkCM?=
 =?us-ascii?Q?pUDGYQVaipjbEJGZc/eUEFaVPuIjQhwMkpJw+Wmw+qE8wKBMpzcjriC26Uq3?=
 =?us-ascii?Q?D7LUxiRuROn3LFZqo37boswD5DaEkM5317vhqgvgUvWTeTBgAKRQ0GEQYFzj?=
 =?us-ascii?Q?mQ4JZb4szmc15vx563UWjuIWewGZrWmCWwMOgf7kd01kQTt5LGI9qD6dZewb?=
 =?us-ascii?Q?5SjggiDR7VOYMoOIc0FaID3RMmsUiqxwLM5N5Q1HDfM1eZJefTubegX/0opq?=
 =?us-ascii?Q?yDTgUI2PVSzdtn6ylm/gZL0sBibEaQhA3nT0JUN/HHxX7RFQXTI0L4hkOpR4?=
 =?us-ascii?Q?24AgEX9YruOmq3q9ndTSqRqUVo3s8HF0rQMxmccZ3zNchZ6N1ImJ+so2YuDh?=
 =?us-ascii?Q?2SVsGa5LePPtPg07yhSSHD5hjF7ORmAqpaF1DZxl0y3h28w3z4pJq2YFXACF?=
 =?us-ascii?Q?jvbizEP2gy2jkJRxwG4WWPcaxx9wVBKzpnSGKYSthH7Ea3Su56l3bR192ain?=
 =?us-ascii?Q?n7+laguDCNr19PXVEV1xmcKoxGmVmWTnm1LL7K3XuNUXeFlp4wneYm9qTkV1?=
 =?us-ascii?Q?J65unNqjVKQQhTmXMzVJI5lFlgDpND9DWHK+kYURPZ98KXYIiRmyQQxwoZmB?=
 =?us-ascii?Q?80YWbbNbfpqH+AUXFyuRMgrZCKZB+QpbSQwlp5WziNVQiBLCk5m0j43ojZ83?=
 =?us-ascii?Q?9ahf2KD6wHv2jGpKwxAXC2UZFydzoszt5H6ZQjM7Gpq+df/ZDXTF7eOk+rHm?=
 =?us-ascii?Q?TTNu2FiBg7X6DhUY4ceMPKQHV4yeKWqVFaCExNG3d0zPdI9QWN49cyfjzxAF?=
 =?us-ascii?Q?U6YevezpxKFR758duyKKGgiytgCVdQAm+QCHX4G6V+3RZELdps5aPd9vosbU?=
 =?us-ascii?Q?hCPUkj0EqbM2KnVvcC7cuTw8uP8djw6OJcP8jve3GsROKJuZKQu9KBb3qmKJ?=
 =?us-ascii?Q?3VEUgOR+9BToPimJGhgpxt9ARFAlp9XoZ4F7yjbuHgly2KUpRT4rq5aHQfbY?=
 =?us-ascii?Q?HIfIqxLayKlwTl5QF08pzHmW7NSk9rYT0ihtNkLVlSkjw7JgR/NDdjXgxwNr?=
 =?us-ascii?Q?6X6ua1uxDp0yns5EGYCgOcsyx5suOQORMIFoxxxHiMt9uHmZPTkmh/vXLYsG?=
 =?us-ascii?Q?9v02c5GOV54ZksML5+dbsxNIRahoC1tSsrYbJCHP9YGvvV316OMdIrwFR4jq?=
 =?us-ascii?Q?alDRVGy74TXFHzKWfQzVaZxylA=3D?=
X-Microsoft-Antispam-Message-Info: xOnRLpAqjvKUnkB8qFMCDuNXrhcmxTy3D2nWdINWLdvV/XBybUXrozSTKQuf7JIQNKFhoVS2+PAkqgV+ipEGyolZiMhpPYzyXK3d+7ju7QpBYZZnuYWpv5r/SKknnHQXEvDBJtZKfZe3dIweqV/MRDow72wZA1Z75/rWrQAJLz4VWkRBJtAmqleobdWpCfEQ2U0UR2d/JQRhtFfWVMlXG2NHTXho4bHqKwlvPOgHS3g25uYT5DS4aQKHFF2Ot2veJv5odK5Nq95MVMeM1VloyvAxrnvkWLpTGcTKOHiRdZxrOofGLbKnKSuO9IWn2r+p6H7Egoi+S6aNKO7u2IIvXWQ1wcHQBTR3X2gUaAuSNxo=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0430;6:+KqZuV2gvhBLtjbGLjoUdoNj3g9nyPItn0io6J7ImRbN6Vwt9vLzp/rGxOsP+LM+z1sQXWHvaDxYI/MGiai+OaqktvL9lrkx/ycOWfUZwX6UMXkRpWpT4LptJBqJRh98xprVxQuJZAwV1tqjHznQjaVe5gIh7Qu1kmya+FP7VaYO9zl4hmo4POknWOHLTyDgJ7lW2H2qJc8UYkL5aKlh2H5Y0aKI8v9vB7ZwclmhJeyYNy8rrA2u3So+KXccv4xRi54ixCOhU53fvEjZIMNojyEPkyf+gD41NQo/fw9Psc8M0T5euX8jRI/6gsmvlWnQt8wCwMKKBdWmMRnN8J+eKzSo+cd7YvKLGcZinQRY7//9qSGyJFontei+Aku0/UXKEacW79jGVkDr7btXHlB9W/wzE5wZe6yPAkfebnKayUdIEPAslDwFpquJnAyf++ih4bg+/ONJg4b0Bk3+6hBshg==;5:LMTqMVHnrkdROJuYL71a+9yxwyHY3ABXlVb3yDhHHfayLRGkuA+ItAgm4Kd2Ywqwy8zS5lb+0W2w5mDR4tx3GIkCWEhXxhCuxgY02lbJfUIdCvqfNO0AKJLJ7ygjuQMx+EpgSZVY+VxPyS1V9/H6jGtlv40rsTz/B8ujH/wOEhs=;7:qq0ail0A1nt4ax7qO4CpiusOalAaMSDO5t6AyrzIcyWVGzBejcBx1zRbVGMF/Cg6IcbqXTfL4oBD1endSBfy6vMzByvdV6ja5JZ8wqSQxu80XJpiujNS05dFDoUoQv3I7Nm+Ghow9oezAMwy/QNwP4iFywGctUf51hF5QKBw/alPlXRhPymXI/N53wD3uzC23fTG8G8Z3y3y2IhxOvdZknJgdeszDcHzBrfw9+AY01IHhGfMdXfjOeccgUwFUlHM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0430;20:tMIoLArV0M4F3hpUl+Cn4HWIm2zEsrB5E+ZtHmkdaQ30ntCdZu9GO2HtnPCPlgu33z2UUISYUpSP+Q55gJtUJSHz/NI4v38xjn5gDSyLwtCqiyMnGI4UDlLtweo9Bv3ufm+qkUWUXlPMpwKmhGMERwzsIkRXUds6ukbmZGZ84H5mARxreKgfR5mMcmcR4vqbtC7hEQUeVyCKL99sv8XC9PUOatkRoG9F3/qpoGFzbHBhRLhnQP5NNQ2toTe+yems
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2018 10:43:24.6289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab0b318-d26b-4839-985e-08d62dd40a5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0430
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 05:22:28PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are several switch statements that are missing break statements.
> Add missing breaks to handle any fall-throughs corner cases.
> 
> Detected by CoverityScan, CID#1457175 ("Missing break in switch")
> 
> Fixes: 18aafc59b106 ("drm/amd/powerplay: implement fw related smu interface for iceland.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c      | 2 ++
>  drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c    | 2 ++
>  drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c | 2 ++
>  drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c   | 2 ++
>  drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c   | 2 ++
>  5 files changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> index 18643e06bc6f..669bd0c2a16c 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> @@ -2269,11 +2269,13 @@ static uint32_t ci_get_offsetof(uint32_t type, uint32_t member)
>  		case DRAM_LOG_BUFF_SIZE:
>  			return offsetof(SMU7_SoftRegisters, DRAM_LOG_BUFF_SIZE);
>  		}
> +		break;
>  	case SMU_Discrete_DpmTable:
>  		switch (member) {
>  		case LowSclkInterruptThreshold:
>  			return offsetof(SMU7_Discrete_DpmTable, LowSclkInterruptT);
>  		}
> +		break;
>  	}
>  	pr_debug("can't get the offset of type %x member %x\n", type, member);
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> index ec14798e87b6..bddd6d09f887 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> @@ -2331,6 +2331,7 @@ static uint32_t fiji_get_offsetof(uint32_t type, uint32_t member)
>  		case DRAM_LOG_BUFF_SIZE:
>  			return offsetof(SMU73_SoftRegisters, DRAM_LOG_BUFF_SIZE);
>  		}
> +		break;
>  	case SMU_Discrete_DpmTable:
>  		switch (member) {
>  		case UvdBootLevel:
> @@ -2340,6 +2341,7 @@ static uint32_t fiji_get_offsetof(uint32_t type, uint32_t member)
>  		case LowSclkInterruptThreshold:
>  			return offsetof(SMU73_Discrete_DpmTable, LowSclkInterruptThreshold);
>  		}
> +		break;
>  	}
>  	pr_warn("can't get the offset of type %x member %x\n", type, member);
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> index 73aa368a454e..2d4c7f167b88 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> @@ -2237,11 +2237,13 @@ static uint32_t iceland_get_offsetof(uint32_t type, uint32_t member)
>  		case DRAM_LOG_BUFF_SIZE:
>  			return offsetof(SMU71_SoftRegisters, DRAM_LOG_BUFF_SIZE);
>  		}
> +		break;
>  	case SMU_Discrete_DpmTable:
>  		switch (member) {
>  		case LowSclkInterruptThreshold:
>  			return offsetof(SMU71_Discrete_DpmTable, LowSclkInterruptThreshold);
>  		}
> +		break;
>  	}
>  	pr_warn("can't get the offset of type %x member %x\n", type, member);
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> index ae8378ed32ee..a2ba5b012866 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> @@ -2619,6 +2619,7 @@ static uint32_t tonga_get_offsetof(uint32_t type, uint32_t member)
>  		case DRAM_LOG_BUFF_SIZE:
>  			return offsetof(SMU72_SoftRegisters, DRAM_LOG_BUFF_SIZE);
>  		}
> +		break;
>  	case SMU_Discrete_DpmTable:
>  		switch (member) {
>  		case UvdBootLevel:
> @@ -2628,6 +2629,7 @@ static uint32_t tonga_get_offsetof(uint32_t type, uint32_t member)
>  		case LowSclkInterruptThreshold:
>  			return offsetof(SMU72_Discrete_DpmTable, LowSclkInterruptThreshold);
>  		}
> +		break;
>  	}
>  	pr_warn("can't get the offset of type %x member %x\n", type, member);
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> index 3d415fabbd93..9f71512b2510 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> @@ -2185,6 +2185,7 @@ static uint32_t vegam_get_offsetof(uint32_t type, uint32_t member)
>  		case DRAM_LOG_BUFF_SIZE:
>  			return offsetof(SMU75_SoftRegisters, DRAM_LOG_BUFF_SIZE);
>  		}
> +		break;
>  	case SMU_Discrete_DpmTable:
>  		switch (member) {
>  		case UvdBootLevel:
> @@ -2194,6 +2195,7 @@ static uint32_t vegam_get_offsetof(uint32_t type, uint32_t member)
>  		case LowSclkInterruptThreshold:
>  			return offsetof(SMU75_Discrete_DpmTable, LowSclkInterruptThreshold);
>  		}
> +		break;
>  	}
>  	pr_warn("can't get the offset of type %x member %x\n", type, member);
>  	return 0;
> -- 
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
