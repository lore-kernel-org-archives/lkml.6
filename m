Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC21C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7C8208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ELnedFps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7C8208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933110AbeFUNMw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:12:52 -0400
Received: from mail-sn1nam02on0081.outbound.protection.outlook.com ([104.47.36.81]:28591
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932734AbeFUNMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t31qW4PYdOQmVzQiYaJAo6r5YoPhtwjVflWxxiPcfJc=;
 b=ELnedFpsWI0gE1I4MqqtUFdp5ywFxm8jgU41/mYGe5VSMrEBlM2fXHaIRO94miYlrvr3YuXomcg81HsBppTTSXU1PAT7p+aZq+iFgHmaXmTrAjrs53F/tcYQ5e0QM/Ti0MJBB5Sj7R8cvplHzV0wrRox7LJJPVISG4rWdgKXgy4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.64.67] (165.204.78.1) by
 SN1PR12MB0175.namprd12.prod.outlook.com (2a01:111:e400:5143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Thu, 21 Jun
 2018 13:12:42 +0000
Subject: Re: [PATCH 3/4 V3] Remap the device table of IOMMU in encrypted
 manner for kdump
To:     Baoquan He <bhe@redhat.com>, lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dyoung@redhat.com,
        iommu@lists.linux-foundation.org, kexec@lists.infradead.org
References: <20180616082714.32035-1-lijiang@redhat.com>
 <20180616082714.32035-4-lijiang@redhat.com>
 <60c6f00e-0eb3-d39c-6a1e-8a1dc1e095af@amd.com>
 <c591dec2-2135-2e96-8ace-87cbf4b055bf@redhat.com>
 <20180621083915.GE3815@MiWiFi-R3L-srv>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <4c71ac2a-5c53-f1b1-8de6-4b7b944d5d06@amd.com>
Date:   Thu, 21 Jun 2018 08:12:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621083915.GE3815@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN6PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:805:8e::40) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27b29608-133d-4a84-798b-08d5d778ac39
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;3:QLaCJE7hlm8WcuWfghzCfACo8H/Dfh9qEGR/0iA0I1Mt1TgTL+sqqHAavaQfqXKAhsn82m44e6uet0sufSJ/rZvtj1zuVJRYRi/veC86wGLetBskrtKWCfwNDVwy+GmqZ3G6H1rLNtN0m5thlladqM0PeBHCXIMjENUSL/fBxZJxwddabP3zR2+OFWfUIuiBhRCieaQ6wD+hGuBq6vxMCrDr8Wp+DV5cKrRlrUPD1fQcgVGu9OIhCaqTH5FQx44s;25:IAwlSHh8hHgU2pHJG9Ua5DI2N8p3SMMnrsCSVJtrW9BnPIKJqlBVrWtwhsra9qEui04Xlk4c5DeNQytKfznZIllQU/zubSTfS4qUJoUd+2rq8cFfZGQss1aTb2cYGZNVXqDLfG08YByxH+JPriSBtWGmhyPINuvLHsagQGQzpsCKlk0vE8vOLp7VITAiqhqHlZax3wZPXT8vf+KirpZQpAcWM5xvxWPwnq1SE+tSv1aNHPE/cD5mZjpg1c/M1oPasIroleqmRObuu2GbdIKaB7JdGZm4X8C6GCzYMnO5l/9cUm+TM6BlZThaivWRdAR/K5MR67EmdTbbFqdycLAA1g==;31:IJDWe4XbVoma3cPeU+//Vqvu9IXGeqNuLEpOpBx+PXRNfI7YuOQz7unVavIVz3UdpwLcsi32bu8f6qi++b7byCgbVSl1PtkTSXSPwTpbkHMRVF1wQNyUnOgcVUtTK2ODPV5dilCHBQ8B91feiORBgrVivpxxsQ0+HoqzoexpTy2GFYZNDqrKDXjKhENmzSBfAvTdebd0wgdc1jfA3qgwjH9HSKvF578/isJMS5RZF4E=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;20:SFyJ39rXmb7o//zCmkRBG9O14lMVoQlQhUlS84m2jUUFPNjx5sk+3ArTIqyLsujCGcOT3YQhvvS3afuuXT1sGjO/92eRyJlhCR68r5fgV9umAl3q3i7JRRu+A45huSEjX2mXefHAyyU2/GB6K6+JbpfmfnE+hDD6/JByOLQjZelt/4fVuVvmrUSbKc4oRpWMEYPZELIIBIGiMWRtWqnGmrTgBoJE0/+Y9c53vpfTUUyamkAYvahzlTSO3c67aKCjGi47vmsNCFi1zg9nsxl6Zn8d9HdjtPouVV33XkaPHf1uaWaMYZ5y0RbAhKhaO6TfR+PykRoFP8F51AsSUHEszR/fPTAAKHxG2GLIKHBHcH2k6CAznhpQPu4YFKZii1KcoQSu94linH0kwWTVX2ebuxut3pI0KYcS5CJ6B8nobx5FBHFhcUxEEvr3GNdliRCj9cxSrPDiFYWsmM8sfD3evJyE63NPixpsGIxjwizlUEM9c+LcwNKB7qWj0p2LECr6;4:+lkNw3blOz9Tz1iXHrAYVwvp4bOMfvtAvm4w3irp2QBq9oQMxyS7AH1Je4NElOeEZgM/AF8E1XbZrGIJhF9LF12XyitsNa2TJ86AKfeUWWee7JnTHiHu9eYSGYjQVLTQGUDaxGe1jqVyhIQ/fZeluS7GUzs5bdlNW+B5ot5uKRKcENjwoAa4LaRzYzw6LxPy9I2JZpN79h5yG2QshaE1/DRFMB3DgLrlhZ26GCMtlHWkNdWkFFUJmC2mo1HpKpI5Nf1da+47OG+03QotW739elyXKVUm50E1AXVGbNll2fHT9Yx8MZ8eLu0iBVsKMczy
X-Microsoft-Antispam-PRVS: <SN1PR12MB01756E2748CE5B0C7FBC2E13EC760@SN1PR12MB0175.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(258649278758335);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0175;
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(396003)(366004)(376002)(39380400002)(189003)(199004)(23676004)(966005)(6246003)(64126003)(72206003)(3260700006)(25786009)(31686004)(6116002)(3846002)(4326008)(5660300001)(65826007)(110136005)(2870700001)(316002)(16576012)(6666003)(6306002)(106356001)(105586002)(68736007)(53936002)(2906002)(81156014)(2486003)(58126008)(81166006)(8936002)(386003)(8676002)(53546011)(59450400001)(93886005)(52116002)(52146003)(50466002)(186003)(16526019)(11346002)(26005)(446003)(76176011)(77096007)(956004)(97736004)(486006)(36756003)(476003)(2616005)(66066001)(65956001)(65806001)(47776003)(1720100001)(305945005)(31696002)(7736002)(6486002)(478600001)(229853002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0175;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTc1OzIzOk1zNkExUUx0VHlNcU5wNVhJMlFoTEgzMito?=
 =?utf-8?B?MG8rMStmSjNHTUdNeWV2SExRc3ZHaDdieXQrVWZxMlNXY3RJMGZHMEVpaTVP?=
 =?utf-8?B?bHNzb3lxQStsenNPUk45TG94K29tOFdnRW9lU2JnVkh3ZSt0TWozUC9NS0Vv?=
 =?utf-8?B?bE9iTW15S0pGZkF1eFdNNUM4dTRFMm9lK3pGR1dZZHpmdzl3cisxbzRDK2gv?=
 =?utf-8?B?NXJwaS9zWlh5b21aRmYxOG5GK3BWcWdnZWdwU01Oa0lyUTd3Z0liWTBEL0JD?=
 =?utf-8?B?QzRzR0VWcWQyWUJUWGk0TThzS1R6dWpudWJESXdYazFheTV6TVNMMzhJdmtC?=
 =?utf-8?B?dGEyUkxPbVR0clE0T0xWMm5WN3hzMEFoamF3Z3MyZmJEcnhLMjFrUm16aHFI?=
 =?utf-8?B?alVkeEFFak1ySCtnOG9GeVlsQWJIOXlVQWtuZ3hRcWdJVjJ2VTFCWDNudmRZ?=
 =?utf-8?B?OWIveUYzekhIT2JxNnlmMmduendXZklqVlFnSHlwZkdoa3RpYktLbGp2RGFm?=
 =?utf-8?B?UFdNV0dKRVdCTkpXRmZxNHA3L1Jpd2pDUXRVVTFRUWVXUFQ1MmEyUzBUZ3Va?=
 =?utf-8?B?OTA5dnEzZUpRdzlhbmN6ZzNVWHQvdnlTWHhtTGtXckNsQzlObllOc1g5cGZM?=
 =?utf-8?B?VHBpV0Zqamova2JmS202OHhHdFpxTlRmRUhIZWZtWEozL2h4SU5EQjZ4a29B?=
 =?utf-8?B?ZG03UmpBL1R6RVNjdjcydmttLzRKTzE1QnQ3K3QybGR0RENjQWtpUDRyRW9Q?=
 =?utf-8?B?aHk0NEdSVHYraWJLWTZ2cXFBTFRDTURQRytPb1VJZmcxMGZRMnU1UlBFTkxY?=
 =?utf-8?B?YTZ3QXZxeVQ0cTRIZWUvYitnN2FSOHRySGRZNXNtYzg3MEY1eFRkWHhYYm5H?=
 =?utf-8?B?REgxcmcwb3dNY3NFTGlrdWFXYWp4aE1CWjJjNUF1cHlMV2dKWGY1ZGN1bStI?=
 =?utf-8?B?QXg1SEg4bDBEcTJ1ZGhMYWtyWUNnQ0V1TGxkRmdmb0pIcmdrM3MxMjNiMGxu?=
 =?utf-8?B?ajRiNlZzaXYyNVRoRnFSMjJodTlpRElKbGtkUDZyNnNiWTJla203UkpuY3hW?=
 =?utf-8?B?cXRqY1BMZzNSQXlVZzRHVk9XcHQwU0pRS253RFRpQW81UCtQZ2g5c1FUN0d3?=
 =?utf-8?B?WUxaSUNFSEthR3FMUzdER2g5TXVQcjJ4L3gxZk5uamp0Z0hRekZ2bTZia1JQ?=
 =?utf-8?B?cThXSGdyaXNWdlBFRm5nQ00yWVJ1a2Fsb2ZsSFhHeGRnZGUydWdxT2U1c2ZU?=
 =?utf-8?B?eEIvbCtPZWZOMDdpay9YZTVoTCtyZ1hXSzRFNDk0eUVjQm5EZytqbDhkWnN3?=
 =?utf-8?B?MmJZWmZKY0VxREgvYjBWWExzOG1IbHZod2Z4ckI2eE9SeDJocXJqSEExT3dY?=
 =?utf-8?B?NURTQ1NkdnBOVStkVVNxUWprRU5ZbkJVeVZoTy92REtMOForSnJNSDNjQVU1?=
 =?utf-8?B?WkEwd0oyL1RZOUZUeWttek9jM2RkdGNwK2NjKzdVYm5TclEya21OWWVqNlJ4?=
 =?utf-8?B?Sm1OU3RKY3h1Zm9UeForNFB0anBjT2hoOTFOdVIzdWhnSkVqWjRXT2NxS1Y0?=
 =?utf-8?B?c1k5TXNyWVRIcC9oZjdHbjhMN09uQWxCNUU2ekxNaStDUUNCZG9RS29vSW1U?=
 =?utf-8?B?Nm5jUmZYaHFLdUlTMGdOalhaOHFWY3B2NGJXdTZpaVh0Q2NpcjJlVlc5UTIv?=
 =?utf-8?B?d1FKY05QSG10emExMUxIcWNyZFRucWxlSHROcUE4cDJMSlU5bEV5c1Yzdm05?=
 =?utf-8?B?TkdpeGp2YS9xSk9xUy9vOG5jNnc0dVF0V1hBclRWM3FNNk5aTVVLWDB2Z1Q5?=
 =?utf-8?B?MENrWWpEK1NEQ1I1a3c2TUVFbTk4UG5VVGk5VGt0R25yVEZXeHpWQmFQNFBZ?=
 =?utf-8?B?bDhyWEtkc1ppQkpFWEFvWmJnYVFBWjRHcEFjUUwwSUVSOTRaWmdGOFBERGQz?=
 =?utf-8?B?V2VjZHNMNVhFY1hod1I4d2s3T1BObEJBckwzeTB3dGEweTR3b0kxVXZDNVNT?=
 =?utf-8?B?a0dONzRJMG5TRHZMTFpkeVhhTC9WVXduR3YvSzZISVFQWnJKZHp3L2NHYk1z?=
 =?utf-8?B?NzFsSDdFZ1JoU3A5c1M2TTdUZGJLcDdwSTlWU1NJMWc1UitvOWZhTmErWDNG?=
 =?utf-8?Q?8iTKanD9P7xLV9Ko/v8mibc=3D?=
X-Microsoft-Antispam-Message-Info: tWTBP8fItVtqGhRj8aRstQQN9HZlcXm/9GUsmik0e21UY5n2R/F7YyGaGrGrZNL/12W1HKSXnpXYmi7oeyuqOV1CqqPBF87B5RHoOBVIABKPPIpNhMll/pDY6GX7RfhYxemEOjoiOlXqSRX910pF2JTWY+EIBP4Cja7eLBVw8gd2fKL38/awOjS2aIc24QplLeSCLGtKHwsre1IOHaJ78GJc3meXtgCdcK/DIkJXE4XYPKMZRlvH2sadkzv5pYCFPGUmlVHNsbSlP86QORzolp4ZeC62EL0Joehf2YjnQMtYPDoc3X5T0kNQSN5ak45jGUZLErdoSqwhcb7O+vA9wA==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;6:t3vstoRzBhHECDfOAfY+UAcBXIXUjPGEKhzOiNuLZG6Qv17gmt1SJ/roVCWNeelomVt8DQjZ/v0wPl45HvL381UawEAJ2aMXQV7SdwdvWMaVrhnIar1TfR96gumwVQ+1u4diAc29SZty7y9UTb4tA64CIpsGxBbNW7DArCeYQSsHmo8bBEx4xGetojFRaKfZAqY2eWrftsw9giXpmja8XYwXQqTq8i2QOMBnC5wXMGPGD8VXOobsQRIYKgFqk5T9O8YeLwkOI79HDvJQFo0muENP4gzcPUvRNz1GbSBfZ2RZCZ49CbptvT/8fZ4SUOhL0u2fo+FFY/Ilugom1wtDsvbPS/osDnC99eHYaysNcVI6BdyKssJf4ijIwAGyt6lP3uHgt8arkRbgYmR0J3h0VjBBk5ID6AxTxrkywvx8TYeUsVEWVjya8GnDeWWq6yhWwiCkdUkDEJlB48D0rQpMEQ==;5:J5zIxVv0cpS76+/CeASNXwOZ8h67HPxiNLvQYyGdQXlji+OBFwU6WlSA3CiEoE9gkjz1LrH9EHkLMPQ8CsvQJQ8mESEl8cl/GwtU+phPf5Niu5htU1MtWQcDo5flDp4jZWeAhlCMf+4ZJr0CGCX3A+aspTuL+tIHKpAosFBTeXY=;24:WdKLwathriZFDpX5CsbGOXnJbRMLniyUQoSglhdAp7i0cifU3S3q29rxGthmeS/zJGz7QpqkQpQnYhexJld63RwI7ThSAahl6qq3ZY49uww=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;7:24qO8tsRlycqdoUJd1KvXEL8DwvmG4gKMN9fUsMEpsQX06pfywhGhQ5cVQWd/dd+4+BOQYkBbdvrJ7quQ+gHINfln3M+lhLu0ZKW3x2eZfBpw4a3qpQ8kW3ZGHmTjfCnot+zqcu872doPPP7XK0atM1DhZEB3HJGrRQV+kGxe6CKdlGU2V2RBTYJoK+qzi0wqBO4osBuVszBDccsfaF2BHVwp0nM24w87BuOlRR2DA+EQB7G/qKWu2ss+Egpl8af;20:tR5MqR96PzfCmHFWTc8X0/UnSdzVxY1uaYGf53dFpfKnhHtBLW6td8NdpfcqCCbAblX0eUm7Rg/JvqTxaGqBo2lwz5yCBKm36Xc9kfbHy3Cx4Ub3OybYhI6BSpCPQdLsHNdidBLX/wYt8KBUyGcxHk0wakifNIhdAF2OmpHv194ajvgA592cFO2Vr95DqlE9fA/0jHP7KW6GM1ow/w6HR6o+uV/1F/dx/xfU5Q2nXUkyY621Vm2XGQ2nwZudAnDu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 13:12:42.4905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b29608-133d-4a84-798b-08d5d778ac39
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/2018 3:39 AM, Baoquan He wrote:
> On 06/21/18 at 01:42pm, lijiang wrote:
>> 在 2018年06月21日 00:42, Tom Lendacky 写道:
>>> On 6/16/2018 3:27 AM, Lianbo Jiang wrote:
>>>> In kdump mode, it will copy the device table of IOMMU from the old
>>>> device table, which is encrypted when SME is enabled in the first
>>>> kernel. So we must remap it in encrypted manner in order to be
>>>> automatically decrypted when we read.
>>>>
>>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>>> ---
>>>> Some changes:
>>>> 1. add some comments
>>>> 2. clean compile warning.
>>>>
>>>>  drivers/iommu/amd_iommu_init.c | 15 ++++++++++++++-
>>>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
>>>> index 904c575..a20af4c 100644
>>>> --- a/drivers/iommu/amd_iommu_init.c
>>>> +++ b/drivers/iommu/amd_iommu_init.c
>>>> @@ -889,11 +889,24 @@ static bool copy_device_table(void)
>>>>  	}
>>>>  
>>>>  	old_devtb_phys = entry & PAGE_MASK;
>>>> +
>>>> +	/*
>>>> +	 *  When sme enable in the first kernel, old_devtb_phys includes the
>>>> +	 *  memory encryption mask(sme_me_mask), we must remove the memory
>>>> +	 *  encryption mask to obtain the true physical address in kdump mode.
>>>> +	 */
>>>> +	if (mem_encrypt_active() && is_kdump_kernel())
>>>> +		old_devtb_phys = __sme_clr(old_devtb_phys);
>>>> +
>>>
>>> You can probably just use "if (is_kdump_kernel())" here, since memory
>>> encryption is either on in both the first and second kernel or off in
>>> both the first and second kernel.  At which point __sme_clr() will do
>>> the proper thing.
>>>
>>> Actually, this needs to be done no matter what.  When doing either the
>>> ioremap_encrypted() or the memremap(), the physical address should not
>>> include the encryption bit/mask.
>>>
>>> Thanks,
>>> Tom
>>>
>> Thanks for your comments. If we don't remove the memory encryption mask, it will
>> return false because the 'old_devtb_phys >= 0x100000000ULL' may become true.
> 
> Lianbo, you may not get what Tom suggested. Tom means no matter what it
> is, encrypted or not in 1st kernel, we need get pure physicall address,
> and using below code is always right for both cases.
> 
> 	if (is_kdump_kernel())
> 		old_devtb_phys = __sme_clr(old_devtb_phys);
> 
> And this is simpler. You even can add one line of code comment to say
> like "Physical address w/o encryption mask is needed here."

Even simpler, there's no need to even check for is_kdump_kernel().  The
__sme_clr() should always be done if the physical address is going to be
used for some form of io or memory remapping.

So you could just change the existing:

	old_devtb_phys = entry & PAGE_MASK;

to:

	old_devtb_phys = __sme_clr(entry) & PAGE_MASK;

Thanks,
Tom

>>
>> Lianbo
>>>>  	if (old_devtb_phys >= 0x100000000ULL) {
>>>>  		pr_err("The address of old device table is above 4G, not trustworthy!\n");
>>>>  		return false;
>>>>  	}
>>>> -	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
>>>> +	old_devtb = (mem_encrypt_active() && is_kdump_kernel())
>>>> +		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
>>>> +							dev_table_size)
>>>> +		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);> +
>>>>  	if (!old_devtb)
>>>>  		return false;
>>>>  
>>>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
