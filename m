Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8218C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0912064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KigLSi/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0912064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeH2IUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 04:20:05 -0400
Received: from mail-eopbgr690061.outbound.protection.outlook.com ([40.107.69.61]:31392
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbeH2IUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 04:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIFyDWA/RAwPb5J4YK0PMF8qsbmTjBMpr8GsSviVI0g=;
 b=KigLSi/cSiQGfSo8RzK0yBAyf0iCFOu4OivKjCNByuDthUq+bl1ae1s5QVChr/nQFGhb3wyW+zBZh/O0G+NUqaZxL/gE9EAzU6gn2JyZypZpWKDR7oncTPW8Vaqct6UNxGMRR9FoEoyggdM7Gqj05D4gr2bY5g634jp9pxJfGp4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from [10.136.131.27] (202.56.249.162) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Wed, 29 Aug 2018 04:24:48 +0000
Subject: Re: [PATCH] clk: x86: Set default parent to 48Mhz
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1534834341-18345-1-git-send-email-akshu.agrawal@amd.com>
 <153549535306.129321.6563896874769936616@swboyd.mtv.corp.google.com>
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <bf082f4f-04bf-30bd-bd0e-04cb113cd261@amd.com>
Date:   Wed, 29 Aug 2018 09:54:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153549535306.129321.6563896874769936616@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: PN1PR01CA0107.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::23)
 To DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b4::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1671700-a931-4c64-a31f-08d60d675c77
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2358;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;3:cRYbGOJfbBcgf1Ad30hCF7DPkNGFeNz2XdoDFeqp/2Z94Uupnse5LXYs9kSnAmNar/+JoOhDCjXHXw81yktnyMZWGOx73agEXsax6RoIXZO9cmdtFxniGUIhl3xNgrZwbNLrys06DysEy8s/yi9odzS+Y6IKnme/zPKNahVo1JwoFmbr+5ydNCA+SaxZ9vjxiPlz6VDy01/T/dNFNotnJt6LmFgD82/DC/p+gYbs8I57Upm/ISDNYQzvDgk1eMzt;25:/ZxCBcaLyqtW2r9I/OCk1uHTufXG3j8wE18JLIxDZJvj4vVxyMIYeCbYP6AhyCeoK0gRyN+h4aGwKPXZk5gPVc6ATKxZMwsLr+c7Sm8mTv91i8ZWHVPwwyPY7Xe6b7AuL2hGGh7g0x5j1rfPcWV6TegkbF9KilBy46Tua4oIcxF91JpdQLNszDwr/H7zYhFfpsVV2vEUeDwNOGX2L5fPGC4+JydFrlCkrAvrJTcP8tD5yQITPQi3LIpdZWw56p0CtJkVzXkRqQh5KiJa4qpXYKFY6iYTdFZrCWYNb3cZ+QCfrbtdfybJgFCF4ks3hrpCnqba0HM9Fs+vgtBRF2ydIg==;31:yWNZSRWtE0jFhnVreGZLcacTpth5fZfOUSafP4psv3ecicW3hhVZnvhlzHyzp3EHRvHfmc4WF8/1UrGbsrKwsLCuRTPG6acMTjAFz53gSLT719REQmuvZrdCGHQTLOvih0wASqFmLb2J2gE0Z01ykZ9RZlCsktvOZn7SrwRPIDYQsXXcBaXul2g6kSUmZxv3N08YrYhDzbG+aXJ7XC9MMULmNwWR6i5/vUCzoGGXsT8=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;20:498umRMFS7Rq04QHeRFzeeSOkRT7yylF6GGHG2X68+UjCZnM68VrDB8P4noXhThfKaFGmCivgryP5gQ6YtIeMwqQjCRP4OIjejEnKz9nyRW6CANzyaROH+j7airZfaV8sOZLPtUdPPQ5LIRnBzvCtkD4eQXeR8zHqL1MJIZJ3WV44RJzo0S6sX4Kj4KL1DGewVqgGVIxJQ1BprCbmwWywK8gbGu1OGBHG4glsK9eMCCEmvA/mxFhfHI9g6ZM3FX5hDSm+jFkhK+0e2W5Cx/ocUXWu7VXjxr5uJnTa1UeEKrkHlx2YngInNzi/PyLr1S/3w8kkitVT/30jGP9cOCFhMo7TnXV1eCcfVeiLsBVS+IC0V/V1rIxbNb4ZVlAHKGcyyNoxRkJG42GvxhI5S2FKDugLt5KIAbzncf6fSQR3w1VwwpG8HD4+a4g/OaGwDU1zvzcfkuQMcNJS8BgXBMOyl6Rk/FTNo+aHZin5ubPFAy0UuC2EOOSlelo1gfuElv7;4:AzUM0CTf6wU26Cs7mdrTJ2AM2RD3J6F2uevAXzd+K44I/bqePXLc4fjAtZ53pRh2/yfa/6fvY3W6wGVxw/QGOjv4yAKW4z3FZ5ZdVFyKWsjFMf5HquJvlDQB1ddHfZLCalQ60k+CngLeeNChHk6Ulk0ScxEbIMIAFeFfnWzpEPkbl+r3mw1WG7OU6Tk4u8z76dnmw9hzCWleMfHmaqt8grdWHJQ4/ll97NftA3lWAxw9lHVF5bkMWhaEAFOriOzHtwWLIzoY64cxX78ytE/1VAQHawKXRYHJsTBy7+/ji90Fr1jm33SDk5gXGLER6AfJ
X-Microsoft-Antispam-PRVS: <DM5PR12MB2358A00581C046F44161F4B4F8090@DM5PR12MB2358.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:DM5PR12MB2358;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2358;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6049001)(366004)(396003)(136003)(39860400002)(346002)(376002)(189003)(199004)(53936002)(58126008)(25786009)(54906003)(4326008)(23676004)(72206003)(52146003)(478600001)(6246003)(2486003)(6916009)(26005)(2616005)(86362001)(8936002)(305945005)(97736004)(186003)(31696002)(36756003)(77096007)(386003)(53546011)(52116002)(7736002)(476003)(11346002)(956004)(76176011)(446003)(486006)(6666003)(68736007)(3846002)(50466002)(8676002)(81156014)(81166006)(230700001)(16526019)(2906002)(106356001)(316002)(47776003)(16576012)(105586002)(3260700006)(65956001)(65806001)(31686004)(6116002)(6486002)(5660300001)(229853002)(66066001)(64126003)(65826007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2358;H:[10.136.131.27];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIyMzU4OzIzOmVQaUtIdXJIUFR3QXBobTQxZHRoZFQvS2d4?=
 =?utf-8?B?OVQ2L0VkRkFiNmFPVU1YTXg3ZFpLaWZaUE40cGo0TE5QWHp0eFFIVmp6NW5E?=
 =?utf-8?B?ZDB6WFpVWGNGVTNwdFYrUURVa2RXY3Nlakx6ME1LelhBSVk4YVcwa0VFZWZE?=
 =?utf-8?B?OHI4RURwSFpQL3ZYRXFkUXVQWjFKankyWHllRDcvV1REQkNqY2taa2JWazBV?=
 =?utf-8?B?L212WkJkb1JISjFHNDBBRTdURFZnS01oejRoa2Nta3ZBMkFJZTZ0b2FjdW9w?=
 =?utf-8?B?UmlzZ0ptTXFYN2ozRGt2eU8yQzVTNmtFSnY5Z2xhYnRoTVNUWHdxdndyMFZ3?=
 =?utf-8?B?L0l4Z2xZSnNtQjkwUms3ZDEyZFg3cUJYS1Rjd2lSMHpsbStwQTN2ZXZXaDd2?=
 =?utf-8?B?MzNmUUZtRlowbW1aWGVEZTFYRlZOQVdtL2FKQmxWN3ZjRVBTZFUyMEhWbmtI?=
 =?utf-8?B?RnFVS2F0aDA1MlFuY2NnSTBZWkRKd0ZhSldmcTFpYkx5YnE4QlBpdElHeWlU?=
 =?utf-8?B?cGFzQ0FDS21oRWU1UEVhQzI2dTFpcm9LT1JPNlFabUdjendUZzU4NlIya25q?=
 =?utf-8?B?Z2N0bGY0TXppME5NdDc0MnlWR1k2R3Uvam1HVUNlbkJxblJmYUNkVmx1Ujlj?=
 =?utf-8?B?ekJTaXUrditQaHFoTVltMm1sdkxGN3g5S1g3UFNkT1M2YnFXNGMwWHdiSDNl?=
 =?utf-8?B?Tk16bm5remMxbElWcUszdGQ1bzNHa3VjTEdJWm14M2ZTYUdGWXpJQlRtSnU4?=
 =?utf-8?B?elc2ZHFBYlR4MlVENlBOTjFDTGdRdTN3OVE2VzBQSlJrQ2JCdGRVd0w2T0ps?=
 =?utf-8?B?WGpsOG9ibE13U1FBZU1ZdlJialJWRGJ6MDl5cXdoTzBsZW54VmdFL0RBTStT?=
 =?utf-8?B?UTZJcVFoRVlpWlNZdEorSms1MFpKV2dIb05zQlMxbmFUQUpzQnV0VThTWWpk?=
 =?utf-8?B?akR3U1ZuTjUxTTJIVGZHYWs1bUJOQzdHdXgvc2VNZS8yWm95aHRoMUFMeWxQ?=
 =?utf-8?B?YTcvNHltWDZrZnN0Tjhrb09DRUxPNGJRT051NTNpc2M4d0ZIYURIN052c0Mx?=
 =?utf-8?B?SFdCZTZ6blNYa1JMT0IrcWk0RnpKV2ljTUtSWWt6ZitiTkpOZ0tLYUdPWjNS?=
 =?utf-8?B?VVJnVCt2MWs5SzVlRjQzMGhFWXZJbXM3R2lYNVhYSTRmbHp6WXA5SW1pbEhk?=
 =?utf-8?B?Zzl1Z1RiTTJoSWVaRC9rak8wWVk1UFFVOElSdm1YeGNpcmd1Z0JPL3g5VGx4?=
 =?utf-8?B?Y2Q4UFoySXByOHZ6aHJiYWJPdU14WlZUMjJjQTVRUmJiTEtCamVncjJsMFJP?=
 =?utf-8?B?aXZ1c0p5UjhmZG1oeVk0RG9GaGVHdkNWMmhiNnlYT3VNOW9PZFJDU1JyWlVN?=
 =?utf-8?B?eVovTzJ3RndNeU1CMHBJZk5ZSGc2ZFAyV0FUeDRFNXFXR3NmMFZudlZ4TENl?=
 =?utf-8?B?aWdRZ0VGQlFBcnRXN1RkQ2FRUU0ySnJsWGZWZUJuZkF6ZTJXcGZaZ1dnZDJj?=
 =?utf-8?B?TDBsOHVJdHlVS202NW1uN3pseCt5KzNtSXI3UWhJL1BsdFFlTHhmd2hRbW5k?=
 =?utf-8?B?NzVWSnNGVVh1bThHenRKU0NYTFpxMVE2c3VkSldYckM2QTk5RENCRzgxMjdy?=
 =?utf-8?B?M2dVSzNKdHc4KzR4WDY2MFdmbG1WT2hxTTF4M1Nsa2RvV0xvZzFBRHVoTjRD?=
 =?utf-8?B?L295dWtoYXhYMm02eWVFRysybzhILy9ONCtKcm9ZZ011cEZUaUFmeGhmL0Fj?=
 =?utf-8?B?NG95dW9ydjVqWDBiQnc2T0F4RzF5NnlYZmJXa0xWZUZXbXZINmFMT1o2LzVo?=
 =?utf-8?B?OFVFVTU3aCtDaVVpZUN6Wm1zTlNTZm92MDVzQWFvZmFDQ2d5eUIySlA5ZnBx?=
 =?utf-8?B?VDlvYnhSeWw0SkcxZnpGUjdxS1VKdkhzNFlnTDM3NnloREFuWS9FTkZTcFlL?=
 =?utf-8?B?VkY1cWo2N0UxT0hUOWxLY1pXWDZpamZvTVE2a3JyMmFhZnZVZXphZ0haekps?=
 =?utf-8?B?ZDdiZGJJZU13M2JiaUtvbWVtMjhSK0w3UmJjU3hmVmVWenRMY3ZQTTBnRXI2?=
 =?utf-8?B?Rm1rVUg3TDEwUkplOFpEbVpLNGsxQ2JRUkMyRWVjYllBU2Naczk4SXIxMFFy?=
 =?utf-8?Q?dOOaJDc8mL+qx0b1ewNRfE4=3D?=
X-Microsoft-Antispam-Message-Info: plDboCSBU6moBRpG2eNkFdKHOHxiEsipaH3TwMXwTi1xqUwUSLaJkdr+Bb4lnHB3NIKaVgoYCe9UlGg+mfEajqxPQecJ5kcZ9zWbUc3/eYLWkxho7jgXWdpGtiEtgvBCbS8VxWREteswl4/dC1fwklgA68ee79MeWhsRnURoQAwTRbsGm0L2Sx+hHCx2Un2okkTzmElqnzduPxNcI7nPpSqWjWvJeLHFkQeUPO88pYXgTQsxcXkt8K5GD6MTwlz9znEn05/Ku+9PG4JAPG5NuN9msCLQ8AWfFLXC78qHqqm0UbipeFKoILsCTMnRiRdFRaeN3Ux/UTxWDw/mQFa0gI2tF7uYG2HOYTI/BEN8TvE=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;6:0th83mUs6O2bxdvG+zbrbnzvMH22F0aqwyFkmVokmscymc6nZ36l34MQpkUzx0GuMd3zift3or8DnRSsCkJmJqIkDbGxn7XU4KwgMEciBIlw3UsRYKTj8tuVbgcp5iyEaTDHm6s8kjSZTO1H1z5r0uLs11Oq1ECDLXYD9KUnTrTzQ6psS+ssjAT28pDjufraHcbAnaG7ZHQLVqQnfce5tv6V8Xk+lQzt5RBrO2rEh9UyQ8eMPAp25bD+sVwsARnwj3X3NbSp82oeRncj1AWye/kdrwKgMFPdDnm+Bw5uzSuyDFDc5K19nKjCgwqcfnUrzSMHg1IvC1PYkS5DsU6uEWfKiPPNt1zWKuUlss9hi6aQ8OMwS2nmcCHwSARMjBBbqDF2BzTAcYARAlj1twCZ732qLQKskmC8VsN8njojS/j3XK8g77FTKqvNlDuSzW62rgL+UJxWPmd5ilBZlHum1A==;5:eXrYFzVnmp1qoLk2XQNpELunD/KXGUw72IcCFj32YNIQuG/H9N4Y1+ur1+yZUMzVAx2pAbtIiOmNBFD6AvNw5vSsVxbnlBq/PniI74tvXtbf/x8D4SuZ1AAFD/HrCDen6gEZLrCq0oUdw6D68zoZ5AugOqphqlvlOVpPJcD2cm4=;7:h1k4aKEmeogSf0jZofHvbvM6ihKgq7xJ1y3qTtHX7WudKAYLxGGRS69NAuhtKAezU9pXJu9XaZUiIVkqnlfasTVK2Jlxjf2AiVOQiqjuzO4sgpMQNYMmj14DkjqwLuXVnpzLIOmg4rf7Sd9i7iimDdaq+XwLCqGrBabVjs4Fi2nmx/uPVi8eL4cMGXIWeTOTUjkLfxsol/CrAS1nN229tEbDIMSRAcejkBIBW/jowpPfSaXsJYAnNzMrlKBzmc/X
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;20:YTpPHuNZnJUry1x2159wCuxE2eP+W2iYS2bYF4ifekv4V4S3vibXm8waCvI1SCWdNlFt11c9aB6rn7hKIISLtISPerqNQSdfUAprU6TBKx5B+8h1pzIg9ut7wYbBPBbuW5jTakijlam1cjWTiyM2w5FL8vWiNnzD2a1TTKjYOxfVfF4XupdGPH+NwnRsb9GoMJeL3ic8pLrPzQ5WfaH/8Xcw8fBgkObr7xwa0EMUrJInjZLPsPXDOZ1I3ruhaNh9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 04:24:48.0359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1671700-a931-4c64-a31f-08d60d675c77
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/2018 3:59 AM, Stephen Boyd wrote:
> Quoting Akshu Agrawal (2018-08-20 23:51:57)
>> System clk provided in ST soc can be set to:
>> 48Mhz, non-spread
>> 25Mhz, spread
>> To get accurate rate, we need it to set it at non-spread
>> option which is 48Mhz.
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> 
> Does this need to go to 4.18 stable trees? I don't see a fixes tag so
> I'm trying to understand merge priority of this patch.
> 
Yes, and its a fix, as it fixes the in accuracy in the bclk which is
derived from this clk.

Thanks,
Akshu
