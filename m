Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47861C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D620724B7B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rzM+RPIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D620724B7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbeGCMzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:55:32 -0400
Received: from mail-bl2nam02on0074.outbound.protection.outlook.com ([104.47.38.74]:38544
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752964AbeGCMz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL+fYnwvCZCPb9PRrGrL7Q/pNJW7/mGb6q3mzwYm7Nc=;
 b=rzM+RPILeczlP/BtOs8AAWowvZl7TWzG0+Jo8eaLXFiM2gA1bsh53K2iK7+7xMmoltxfjQeoo68jIMDfIG6WYxOgb6iEn4w8bIcDCuMsMzxgpagHv92vlRaic/kHpw4mGv0oAHdSMX8mMY6pL7OiX35FHkFx80l92tt4KPYcFvk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
Received: from [10.236.109.62] (165.204.78.1) by
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Tue, 3 Jul 2018 12:55:24 +0000
Subject: Re: [PATCH] iommu/amd: fix missing tag from dev_err message
To:     Colin King <colin.king@canonical.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180703064005.18908-1-colin.king@canonical.com>
From:   Gary R Hook <ghook@amd.com>
Message-ID: <5a0b7254-2b13-6e91-1db5-45a848a0dd8f@amd.com>
Date:   Tue, 3 Jul 2018 07:54:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703064005.18908-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR2001CA0020.namprd20.prod.outlook.com
 (2603:10b6:404:b4::30) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c911b231-837f-4c91-4b75-08d5e0e43edc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1449;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;3:ZBLuCDlOhfkt3Eq/MGaOfgcivyr0Im5rTX5E7YnUbiqSA73jFeir7/oyOwe7Zy7BilWqhJnQgUtmLCu1cXFKR7ZONXn/icuYr49S0TZoyKcQb8592O/asTrF++2/HuJYDNUc5glgQb4+t3rEdnZaUQlBVS9khZvMVLf1/iKggDS1B6bZWgpCdcthzqezivdJSM/Z1oNrDkr5sdM22dTfjWPEoGc8HZyjQ0Wnb1jyLUsiZND6++Cmg47rUvmnmqA3;25:6bSUrGzjnH9iHDA/ardyTxIdGBCK0JTcbLnV8SqYA0Y9Rr/kYLnB9neXP3iAcfn3YXqQg3fbf2xqIyt/KYhJ6ayoNheDZLGsPXXtVXjeB+/NV0alemNiEW13QMagTR4zlbXtcKSW3609R6/F4rt8s24Yj5LBn3OTOr3N9/LlyUSZC5V/ehm4uYTRWDReMLlMXF9Evoy1P742RWqN0PCqXcVudabz1VyT6VVDKDC777ZWwflxRD7jPAcKQQykTCaQ1maRimyYWZe9VvUKBjlRcUK/e0CIIYXyn0X+c9KESjDDzmorm574KrXcJObT3cAwLwv77KAY6btlJVtv+PRHNg==;31:GOlgMLVKRezeM/bHOBwUpYzHXih6PKQsxz0D9KTfXSQD+h0BvfKtytq2CP9PP+Opz01jdS//crLAXWjkytJDB4Z1deqGeZhtMCydbSgkW+1I/YvWhKwYKtJL11k2Eywe9ondYYq/m35oOvqvovUmp1x00nL3UYp4/ufM8igW6nYXkGbfflbtoi08x9oQb8pBh6AjbjszzW/RgHRhzDCeD2gIc1XRfsrZpUQblYJXA7M=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;20:ut0539TIghItM8t2oCe1ve4sw/VwXwYlc1kwq45EgAlkqNmYeTwFtIgdV98GBKh5NXkAPaqyzuW66xm7L+Xve368Ao8rTIdWu5nCus/TOKe3f9l9CWdKPHW445mH/viusq9WvVBABfYdeqTEsyGHl/J8LSyH9wqiGN9WYFVIFcsstB9EXUob1a1is4CTJzktzWxzBOiubS/dy21ELvizl+d+/SYuneH2c+Q1abvss+4uW7/rdJwUdgmQmOjS/V45XvLqTP7R/RYyLBD28SPtwU0mxargBNTHeLcHvpcO45W7BpdlD7EDb0NSHr3fEsVDsbeAEJ+6iwq4eSD1jWq0XDg1oVtDA5YVO9RoUhv556hLFXOaE0JCTNztDFtJc7W1IubidjcCd8+znfbuE0NBF1G8vP8djVvrh2Rd3bzYhgekLm2yyLEjEBrhiveENSa8NbGLczXSkClIaUEc/UEYvohrfuvnmmy+yjE82FqzA0KbiS3cctomIe38tUB2XOhd;4:TGB3jEVqSkHMTYAa7L23dDPZFbTls8kysoJZDqbhrYMB4mGr8v6O7ldI+JuAxUh8iZcCIi392SdFanMn6NDuXAmAsb/gtX7/An1+HBnZY1EsqxslPRl/7ve86+PNO5vMx6DzmCaK1iMBK8fqLrZ24EL6mu9bqQyDdykrwj1o/4sDJsybV/uXX/Ct0C0xeWARHQHGBaX5mzIWJtLOhy+4g/WxaVtNOSk1x4ka42ijfH0dMAyShbQypJHrl9sSb3cQC04kzbLskSMNE8oaGCeVifE7+HX+b/h0qZi/lHSJNzl6w1/8OiL2bzv776K1G9atqqGY6bUCACvDZgf/SnlzBg==
X-Microsoft-Antispam-PRVS: <DM5PR12MB144957B872B98B036656A2E2FD420@DM5PR12MB1449.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1449;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1449;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(346002)(366004)(376002)(136003)(199004)(189003)(11346002)(8936002)(72206003)(106356001)(446003)(25786009)(186003)(5660300001)(53936002)(4326008)(31686004)(6246003)(2616005)(105586002)(956004)(476003)(486006)(68736007)(97736004)(15650500001)(65826007)(2906002)(6666003)(6486002)(305945005)(14444005)(230700001)(229853002)(36756003)(16576012)(58126008)(3846002)(67846002)(47776003)(316002)(6116002)(386003)(53546011)(31696002)(52116002)(65956001)(7736002)(66066001)(8676002)(16526019)(81166006)(81156014)(77096007)(26005)(50466002)(2486003)(478600001)(110136005)(52146003)(65806001)(76176011)(23676004)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1449;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDQ5OzIzOkorRHFpUHAvYUZVaWxNTmgwVGJkdGd2OUli?=
 =?utf-8?B?YVp3MWVwSXhkcWhEUFZNTjJHWE43bjFUdVJjMXM1akN0aUorY0s5a0JsR240?=
 =?utf-8?B?WlVoWGRQc21uejFPMmREMEtEc1gvamo0VXIzdUNXQkZQb2FNZW05OHF2RXZF?=
 =?utf-8?B?MmVjelRodXBJRGVYalh6SEROMWt2Q2xpZGR6YmlZN2E1c2xjTDhZOWlwdVBk?=
 =?utf-8?B?enZwNGd0OUM3ZlduQTBrQTl6TWRleTB2Q0tKcnhhcDF0Nzc1QTkxUnRjcmpr?=
 =?utf-8?B?ZUFmNmgyYTQ4RGErcXJWTnVuNlEvWnlVTmZpdkVCbERuTWVncjhQVEd5bEcr?=
 =?utf-8?B?YUhzOFlRVCtNWEUyemtXSm80S1ZwZXlCWk9Yc2JTYzZnbEZVK0tkYmVXQkFB?=
 =?utf-8?B?Njg0UmdtdVplKzRFTE1CTnFXeGhheTRSWG5CNnpBU3M1ekpHZWhtVEhueTZM?=
 =?utf-8?B?UnJPdGRPY0t5M2VHYmYxakh4enJxVDlvZE5EaDdaYzVPVmRHREFnQ2JSVjFP?=
 =?utf-8?B?TndFN1htbmc3b29WdGZ1eUlFcFJZcEo3Ynl1QVF6T0FkVklCTTBnc2k4enNB?=
 =?utf-8?B?UlJxTUlVL1NyY3JWYU14Z240WHpCQjViQ3hScGI1WkRKMlZIcEZCVFA2K1JG?=
 =?utf-8?B?U3ZENVNFRXB6TnYya2FIbUhxNmxDb3NEZ0VEOTlEUWVpQnd3UzhibWF4VWJ4?=
 =?utf-8?B?cTdRSVl2MXlHMElld2pKSmFnOHZZOEpPSm9LSmRQV1JDd3BWV2pReVJPQ1h2?=
 =?utf-8?B?WHFUaEJGUkF2TzZXUEdXcmYrNTJuL213VG9kN2w3NjdmMXBPUjZEOG9ieWNE?=
 =?utf-8?B?M0lZNEJpaFFYZjhGY1F1MExRSDlkMUJTaUdPMzN0eDdPKzlzMFR5akxqU0pn?=
 =?utf-8?B?Nm9YVzZERG5FZVA1QUVET01tSlJveDVTdTMrQXUvaDMwbkhJaUMyU3NIMERs?=
 =?utf-8?B?eWdQWDFTYVppdnRNVjlTUWxCQWRMQThYOXpFN1VHVGRGTDFvMkk5SC9Zckcw?=
 =?utf-8?B?RjlHTCs4VE10bE11RG9tS2ZieEZGZ1FHOXZEdGYxSzd3OWtWNGxrYjlaWEdv?=
 =?utf-8?B?YW1wU0xRbGw0NlNURGpQVGZyZGJDMWdkUnVZOGRWeTU1QU9IS21PWVBIQUMz?=
 =?utf-8?B?VVA0Nkg2d2ErR1pmR1FQYVJSM0RuQldVSVFVa2Nrd1p1OWZGZFFUOTNIUWtp?=
 =?utf-8?B?L29DQjVSNEZEbG9adldxcVVYK1V0ZEY0VTVjWXR2bjd5TmY3cDZVeUFneDEx?=
 =?utf-8?B?VG1vdEtpOXVnTEd0TVhUcDFJaEFHMDlPWFdJYkN1T1cxdXdRWXYwQzNYdzk0?=
 =?utf-8?B?TDh5UGt0VnRqK0liS1pORDVZTUFiZ1JlMG9JNTFLUDRGZVVGejh2ZzFBb3Ja?=
 =?utf-8?B?L3dRTVBYLzNvVXVPTVo3ZjNxM1FQQmVCVlNDN2doNDFJdEdOVGRQUVEvN05l?=
 =?utf-8?B?S3JhaHRtY0hrc0JBMFk3c2wyeDlkUmNkNmhWOGhETk9CYzZqdWFma3N6b2Rj?=
 =?utf-8?B?d29JZXJiOGV6YitDTEJnTEZrR0UwN2xWczBXbmw4UjhITGs2UzNYTzZReDA5?=
 =?utf-8?B?ZzFNOHJ4TFdETUlFcGVUaDhnK3B4L0J4T0xhTHRUZS80OWtvTTY4UTFESk5q?=
 =?utf-8?B?a21QbnlMTzRJck13NisxTzNlSkJKNGVaTHU4Ti82ZFZtZC9IcG5FUHFITGxX?=
 =?utf-8?B?MElqWDdMcHB1WjJCU09xWDFGUEgxN0QxZmtiS3B6V21vQ2FkWGlyVWR2V3U4?=
 =?utf-8?B?VFY5RHlNWWdNZXplK2ZRWWx4V2RuSjRESVUyZUFCeXl0SFMrSi90dXBYRmJG?=
 =?utf-8?B?eGN3azh2eWVXbHJPNWNoSWVJd1hhQ0p1R2FoUFNoaEZYT3pUbTRhWWRmb3dZ?=
 =?utf-8?B?TzdTdHg4NWozNmd5bnBVUktWWWhrS0hXMjVYWTk2V2RLQTYrNjF4czgxVVFt?=
 =?utf-8?B?bXdha0UybFNUaXVjMWJ3SDZVaktFaHNhQkg0NzhlWVJhWFE0bnJJUEhkdk1G?=
 =?utf-8?Q?QY67h9?=
X-Microsoft-Antispam-Message-Info: AnGUcYLKEMciUDoi0qNryliYqajiL1i1JTd+YTTavMn3aw/3I7NaQDs+8APxWkS7ot97fpVfjva7/vyxuP8vzaGuBX1Hd4tZT/LCLWqMGle8Y6pCemtdGDLLhOAykGoTAixPkpTMxo0nDRbH3v6947CgBr5eOXPEcx58QQzuAs6n2VJGPw37IPZ2/5/vUQ+QczRho3SQNfltE1MFyg9+lvEWHH3R2wtqGd1+L0cQHCcbJhNq9aoPjK0XLaGuJiFoiSKZ7OKr1bT9fvadbfLZypmFKqUkKYHrC8kJYuTFGiyAswkEY6UuWWvJQpGYYcqAdfog09Z7lUKKwCoIMeS+7hSV1kQzgx+uTPjjwNN63pE=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;6:OBhBQhqoADVzmMj+c3U0xxaz7agg19eAaVTWlvciGiP3WVLU2ENg1430lm7Z+pdel4iY4uBaJTbhQKkgDDXZq7h1E7ol3hWhWXJfzeGkrHrtdbVDFQArmQuRp4uFbQFPxMBY9Cd6NX7E+yDWrjr9qPEW/OajiaAWLGjFFwSUGofc0365BiRrREK1/7oUPwwUAbW9NmkO1RX/l6dDdwzNhCYOta2MNf9H0FPwGwwRBtpJkVy0l+X1esml0B2bPLAktczMXceH9yR73m+BoCXS1ug7iovpBnESdHA0nVFSEGJv0iru2/2NEkOSz5lB/Kp8s++C2bAzUIuOF6NZhI+JWLBoPEXj0NbEXACdDgqs8K9fehjLnaVPf8qCajWlDmX9YkrAE3YfrofE3tYOeMbml9DWjtQL2Ivs415kKq8vvb4KCSfscU/Ch55U0Lo6mCAInDRtyQwGxDHssZeUzOuZdA==;5:k9VhHL+QHhDdqefEvL3a9a8+a/geL3iUmD5yK0DTeE62kW/9oJQPGnmPL23MkaiVnveU5Jhe/eGMIWv/XqvB2k5kukh6seKUzI/oeWOXK4OArefXvuavpSWQLdkDgQvAyGSSeHBgUuQDnQhKsh4wIba5Oav1PDR3gMmH1Xox9Q4=;24:zJ4a8kph5oVJFebleIY+q1RTzubaVfOJn6nNnfFg9p0zuUVIyuBEAeWrLwbfbUc11s1QUq4OYtAwQzCVow3a8UMUcqxXdhfog0RPrv+DC3Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;7:KEouBiJf/kZzy/7iLCrYLsMTS+FsZeXvnhTHf5e2nyfkE6UFcnJtUXsPWWL5gAeEJ2NgpUOJht1quPlnsLGmw0b79fVtcTw9IV+++dONH4vUJ9PRFdr/pjBhI/VXPsiOgBRO+mm4m8md8rbNe+hmUXU8e3d5nvMFcHOVHUIRaab5GLoCAWDg4gyIEEom+xS/Quk7YacuGYe3CJjESh3Zag0cv6vdDoFc5ufwig/UKNk8YH1GHdTn6kJ8G1vGcSYh;20:eaLeWMpUCDu1yZHcgr5iz2QauFJKGiyDUtEwgzLmlciKF/q2en8Vn1qAR+CvXwsQopmfu7/aHNAyIT9JUI6AKgAO3pzl51QMhTYkaMAgSRVciYFRDyrTu6C9ut+4OGEm+zWZptEfku8X8WdzTAob0bN0vR92GZH1EOEcerkYeYMerA54aj0gwrFcAb3XX22VZaBMBZToGLhukBmCuNolnS5WUBMYLvr2mXohuH6p90vppDqMdTVzrg9pGkNlXPsE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 12:55:24.9208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c911b231-837f-4c91-4b75-08d5e0e43edc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 01:40 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently tag is being assigned but not used, it is missing from
> the dev_err message, so add it in.
> 
> Cleans up clang warning:
> warning: variable 'tag' set but not used [-Wunused-but-set-variable]
> 
> Fixes: e7f63ffc1bf1 ("iommu/amd: Update logging information for new event type")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> ---
> This is a re-working of an earlier incorrect fix that I posted
> yesterday ("iommu/amd: remove redundant variable tag")

Acked-by: Gary R Hook <gary.hook@amd.com>

> 
> ---
>   drivers/iommu/amd_iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 596b95c50051..6adab2690793 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -616,9 +616,9 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>   		pasid = ((event[0] >> 16) & 0xFFFF)
>   			| ((event[1] << 6) & 0xF0000);
>   		tag = event[1] & 0x03FF;
> -		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
> +		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x tag=0x%03x]\n",
>   			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> -			pasid, address, flags);
> +			pasid, address, flags, tag);
>   		break;
>   	default:
>   		dev_err(dev, "UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
> 

