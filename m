Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969914AbeEXXv0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:51:26 -0400
Received: from mail-sn1nam02on0089.outbound.protection.outlook.com ([104.47.36.89]:18896
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964788AbeEXXvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:51:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v7 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
 <152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
 <ba2bb6f7-77ea-4431-af0f-d20c19820d5d@infradead.org>
 <5e45f38e-cb45-d4a1-f351-30543f787290@amd.com>
 <20180515134603.GD18595@8bytes.org>
 <4041cb33-19a2-5542-4211-1dce51de5e40@amd.com>
 <89a0e3af-8970-cd80-418d-630841795807@infradead.org>
 <3eefbef8-142e-0a29-3e97-536717f63a98@amd.com>
Message-ID: <51bc04a4-81f4-f2ab-091e-a77059de12ec@amd.com>
Date: Thu, 24 May 2018 18:51:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3eefbef8-142e-0a29-3e97-536717f63a98@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0065.namprd05.prod.outlook.com
 (2603:10b6:803:41::42) To CY4PR12MB1445.namprd12.prod.outlook.com
 (2603:10b6:910:f::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1445;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;3:z47oLq9tf8pDdfi/NvmSyCVOAQHTAtQFGww+6Iu7OjTXYMc8bJqo5lDEAYB4MBHin6YYk9XMDxQ4vXR9RSUAvMflPQP/b3Kpnw2YBNDwdfmLZroZa66a7YK1NUkXVPo04xC/F0A8OqNThJtUh6bJ+AwZzye1usGU8ScvO0a1o+COn1EAG8fJj2FHIIBOsPoLw4TFHrHKstrwb5n0aWgFB1Eet2aXpkTlNhcjj4OUJfyqqzaDDRW+fv/GzeYbYVtk;25:T1YrgLgEHqtlnh5CRffIjQDUgu5fHEk0DisXbnqiDdeBfiOE+uNiv5bYV27r0+uTMFrxGbTyfnMFf7mMTEdgV3iyO6N8TVQTxrWW9hkyYYI5tnnLfLQY57xIgh2lw3wS7Jq3qtBDimNOtZNCxUgtOnQtpAKpzStcNHZqOD7Ol3QfpQplG75092KZyn8oRAYStFT9eIWibO7hyFwGGpFEnOZDVfY8+aOneLgk+6wvErOhUnE6pBJGe+HASw6a+u3NcCAPtwjMvdByolYr2HC8wQf9ztcl2yru74+AXlDmwY71vYTEDkdnXXHrT/6RmmE/fIdlAf4CsdhIz8+7MbmRnw==;31:mO4OSVWA/0aQWMLXaa+B2it+rv9ZUK7hBIfyG3wzp9Mrd8kZjb8EtWtFo5E0cYFWDcaE8X+1TKJUxTTQm+mcy6jA0HYX0Hpcszfvtk4fFQIregEYEquRjzqpQtXBES49Ut+7WfDENc+0hudImyOhkaRnUXiOIhp1FvQvm0Y+czHfJ0q2cyqEx2i0JE5Acp1/yjS+oVMBwhi4eY1nkX24Krf1tAa35nlEjZihOjvFYKM=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1445:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;20:6D3WB3IwQbWm7poVeKY6eQk8d4DD1pEnhlxXld3BUR0g/L2l6akxu8ISZ7zRT56kfuRKdf0h8JBlOihjN8o32CEozOnodt8IaZwVFvgNEfWJ9HPiMPIvdGYU0mw+zNNNOcltmjiuslBB9sApwsalArrhyRMlAZUlDa0PCVCOLgtMp46Udl9f1Jp2Oja2isJJ2dBVgYzjmLLbflwJlAPXw7t45lQLeUaPYUwm2SIetqYehE1JRbeXD5wqOOPuU8LuiR1u3UA9ZX6Id6iywOIMMHPiWRWT3926wQJ+D/Cj0KPRLomj1p7RZ+iOBtKnRiXcWhXKLKuXai3Jr5mGtTY4l0C1taxfs4fLXwwnYzZFUhQCtYQDdRgtxHLWoHD1PWJv6iJT/BIgnfgL/SLIsVJ6q5hOkvKgh3cbdkfF2/Etq7OQQGQSyVtCrm6ZiPjciAG7ZEiWN3McGhIHNQNbvcE32O8aFP+BTmjWNXpdxhLKw6+R9c3vXLQnNNqDOobPU5u/;4:FF1WTbFICMS1ZODheaTbViY87JFauNGYhQwvdIlQqaLwPeYR7Cx2NAJXl5na0/6RKvZsKQLpchIVeayEgly2KJe63ipdvaLLf+Qa8nZarlnX33S6TOBsqMlO87b4dRw/KKC5kwfXKxcHDrh1lzctEqI7VRvsdm0c06axxWmSOwxKlBeyoUZnsb/pVbJXttxuK4+1/wA0r3EloVzCyNmHgk/l00MC0kNh4PSEPKFG2Le3qnoDKIK0ObgQazTsTFM9xH99j4KO2/iOJTRH5D/vBw==
X-Microsoft-Antispam-PRVS: <CY4PR12MB1445C9DC957756F6AB618072FD6A0@CY4PR12MB1445.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1445;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1445;
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(396003)(39380400002)(366004)(376002)(478694002)(199004)(189003)(97736004)(53546011)(8936002)(7736002)(53936002)(47776003)(5660300001)(386003)(478600001)(65806001)(2906002)(16576012)(58126008)(6246003)(76176011)(316002)(65956001)(66066001)(93886005)(16526019)(65826007)(67846002)(230700001)(26005)(4326008)(72206003)(77096007)(186003)(229853002)(6916009)(6116002)(68736007)(25786009)(36756003)(2486003)(52116002)(6666003)(50466002)(305945005)(106356001)(105586002)(486006)(3846002)(81166006)(81156014)(11346002)(31696002)(52146003)(31686004)(2616005)(446003)(23676004)(6486002)(956004)(476003)(86362001)(8676002)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1445;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNDQ1OzIzOmx5dGZzOURLZE4wQlNJQ3VRZHJQUjVIc1hM?=
 =?utf-8?B?bmFKT29EMnhadkR5NkFUaFJUMUtzL3FkUm41QlNsQ09Oc2RkNE1CTzZ3bWtn?=
 =?utf-8?B?cjZrR25yMU9NRU9ZbEU4V3JTQytkM3ZNeDlESC9vNWVjdFd3VjdLRHRhQXhY?=
 =?utf-8?B?SkFTSzEvQmxYNnRaczNOZ1FmclpaMEJKMk1QWkJxVzg0UWJGRjUyM1NHeDFH?=
 =?utf-8?B?TmtSdmpxbmZoV1c0VE5lNWU4ZHVkNnBuRlZhTTNzczNRbjU2TUEzcmx3b1A1?=
 =?utf-8?B?cHNTUS9ad0wxM2JqTjU3VjlvNzJDZzNibUtaTkNJbTRqekxXTWR1R3pqMytV?=
 =?utf-8?B?N1FtV3pwWDEvRDZRdm5QRUxBMUFhM29WWDI3TVJ1SW1lclQ1QjlmSzJINVdP?=
 =?utf-8?B?T2IzUjl5ajZOOTRKQkNVSFlhMVNQL21pQjQyK3RGdWp5cDVJd09zVWQrWGli?=
 =?utf-8?B?WFA0QXhudnc3cGtLU1ZQRXJVRUtDNi9nb05xTjU5dXRadkpRelpOVmlvRFYy?=
 =?utf-8?B?S240eHZHVElveHNrZzREZEtiTVFObFJselRSYzdiNnRMZC9aQ0tzelFlOHA1?=
 =?utf-8?B?TTMzbVljMWltYlRLRVRDR2JpWXBxWml1cHBPK1BDS2pRVFB6aHA2REpoWmFz?=
 =?utf-8?B?VGgrdTJKWVRwYUR3TEFsZ1V3TzdVekxRTkd1U2Y3VUQzejBVc0Nxb2MrdkhZ?=
 =?utf-8?B?dWpPbHpleGVQbjBJMHdCMXNrOERjbitCNm9TNlBJRGQ2bUtJcDFaS3ljWUl5?=
 =?utf-8?B?bUZwQ0NQN3A3ZlkvU25kclZ4WlBnaXZQOVlYSjRJYUo3STFQdzN6alIyOUlt?=
 =?utf-8?B?V01RY1RNZnFuWWJXUDFmVmdNSmVjM0JBUkY5TjA3UmhRdWpaTFlVbFpxSXFR?=
 =?utf-8?B?WTNqNWlKRGVGSDJrbHJFNnkzNEMwT3FPTllQZzUvdFNRWXkxNVdCR21IeENF?=
 =?utf-8?B?Z0x5WTFVUzZHZ2dSZ2p6UkNGV3laSkIvdzdJM01WVEZTOVpRbDNSS1VBQktY?=
 =?utf-8?B?L3BpdXdaWnF5UXZvSnFBOExudjY0ZTVkOUZSbDB5dTBKTWxEWlBZbU9SL0dr?=
 =?utf-8?B?dUw3TGdKdk9JWmhna25TYi9LOHlwWE5BQ1JtUDhOdE54RGpSM1NBUzhNSmZ0?=
 =?utf-8?B?WVY2OFRsdFl2Vkt0cllOSXYrYXpMa1poeTN5YkIyVG0xaWQwQjViRlpCU3hR?=
 =?utf-8?B?Uys4dlY5Zy9Ya01aTUUvZi9EYVRaZTUwR0FnbUdlTmQrZVJKYnF3Y05xZ1pk?=
 =?utf-8?B?OHdsdVpIejBLQ1lBaVhjMGdxeEp0ZXFBVVFHZDBoZ3BhNDU1VEcwUTlxbGJG?=
 =?utf-8?B?V2NjMFF6NVkzdklwM0ZjL2NoV2gzdEMyNVZvNU9RVjM2MzNtSDBjdVRLNHl3?=
 =?utf-8?B?ZXRCaEQ4SFJwRFZJMjlrRTRuSnIxQzdqYVVFUjZIdUZ5bnM1RU5Jc2YrTmxH?=
 =?utf-8?B?THZDMUkyc2FvZS9RTTB4OTVGS3ZVU2tnM2hMZ1QrSDA5dGJaT0VOTFNXTFNx?=
 =?utf-8?B?UTZuVmRDaHY5dlJraTc2UHdUc0crbXdWaXoybTJtNDJqUXIrVEpsRUxlWUlI?=
 =?utf-8?B?UkRqZVU4c0tmZVZyQUJ4dnhobGtCU09wMXh0K2g3ekZQZEdDMVVkOFBSK1FW?=
 =?utf-8?B?bzBUd2pzcHU2OWFva0M3ZGxSRUNJU21pdGJMZm0yWWgzNHlrNUpSMHF4NXRP?=
 =?utf-8?B?Ulh1R0l2d3p4Q1VxcVBlbGFnSi9PUUphSUQ1bFFQbmFuV09laG9JeDlRY25Q?=
 =?utf-8?B?QzdJbWVza0FDSndsbkUyTXlDUVFteTliSklpQnUvZ1BaU2RrUTJadFVqcHJV?=
 =?utf-8?B?UE9sa2YwNXYxYVdtaU1XNmZKWDZ3aHViaU1IbmtPY2Q3TDZFUUpndU1DbFFw?=
 =?utf-8?B?OG5rOUdtMmV5OWZhQW01ZkFGL1BEbmNzbm9TamI1azFVV213L0JvSGJXMlMz?=
 =?utf-8?B?RnErbm9PMHQwUHBtVUFBWmNiU245dlhadXd0UmloT1VxYkY4VXE5Y3E1aVdh?=
 =?utf-8?B?VFhoMm81Vll4U0lCeVZIWURiaENFUzJXSXMvMEVITy96QTcxOW5Udzh2cFpr?=
 =?utf-8?Q?0ITE=3D?=
X-Microsoft-Antispam-Message-Info: b+oq8TZibK/8qDtSGLxwmVJq3aSqEq4iTcOiAnDWzroyibKPFa38tm8so2dJjzSB/LHdmq26uAKakZlofyEjv8cw4t4YIdDwBwzh/fQXiQQuiKIsipeu1E632z3F70RMj1PzQg3SXZHonogucLSk4Cc0qv6U8Dx4xb2rANIEIerw130J2I+aFg2+79o51RjP
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;6:nTkuQq4+gGmMKmIPeRSwKq0J+vMNhoZrLM5URmsbtOd9tlX7Hyw7RxFltoVcjZwt8aFirt63IEaeweH9xosQUYWjMH69DwD+Fy4OWs5Ph8arf40122afINjNoY+lYqJBFZ/+Q0S08FBciEU91et8jKFFzlZBkqieUfk6NEs8ySOqwZAuBBpqi1FEfrGlW2ZC5w7Wji2lRfaFMdQBWu0wtE7pHT1464ZnfkW5B4oLMukbMXP9YVbatr5gEG3PvJKJ04P2Zd9X+HuP9UjyUXDGGvAL2PLSp1S4JJ2iaFYcgynNXeiI0mcP1Ce0beD6XOkkQVcOd43752SCxs6YwTEFWdLfFCcGD7AGymkmn8eWblr+2o/qggNa530alSpybxkHN46l/CifniNZKEBPuU0qEK1CI19zN9rpR5lhyzIOnVezxD6iegBPgn2WmzyAvckYnIA+RRKlQTUVulTiiOXplQ==;5:Pxf7XsfGXHFaHjkvKSXldXCrGnucC+u/Z8xb47ixaW4NbmsZaFOlAiV8j5ImI4bKy/zcOdI0dtQfQH+RJHR3B3Aq3kOrdzCKZJup18Tp+vfYsBUOQCiG/RBr6+mXcG/tHXbovfR47usTjZKLezb1iWJtz0lYC+aTOIIuKfRkTZo=;24:m+nm5T7ns9PgW2ur7ZvZzj4PlErogQmzgJw2ijCaMKVRP4v99oDnmttb5pBlIEHkt01cILLpEB+/VYd1D1iaIUk5uykp8UJW4kpGXkuHKFQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1445;7:8WtYEhO2jAOEg0bSDfjTEl+uHywUSYeXIIlWsiggJIur7P57+W1jM1ZM0Fp6N21MusyrPXGXPT4TF/mfEdpzCnRUOmGaqJi2rYsGi/cxYnRDjEEwKAVVrf/+x2PmyS4vMAUOgSmF27dKtglDJRHcHo0plSzA7O1gnveJzdlTrjeOAdYAl2YJ85cbxmxBLLGQCHb3bItnT2VcDIr+wdV6N1+WbsHS9KMououLAlyDikbeK8UMDVRHBi4Oy+Cya1o0;20:tkhS8p+k8aP4xiZiTyWJm0DC0GkN+5oLd/PlZBJwHPXYVdLjcTI3aCR0DUNGbFjp2WRdhS4Y6ka/+2kTEnKRzYOOk6Va2coqOEzJ6HO3y4TvJ8lGy3hbAeUN5k9OrA9a9uqXZaYFVt57w79i5ZNKV4AyunBFP5jEEFFlvEnzzgea/aug4YwqllwZ3+7uprGE/82nIKKXDglXCyxs0SmWTdjj3e1xXn//gEtcC1FviMMmg3Qf4DgujO3By9BFZhQp
X-MS-Office365-Filtering-Correlation-Id: ffb3ec73-5eb4-4895-e80a-08d5c1d140d7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 23:51:22.0510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb3ec73-5eb4-4895-e80a-08d5c1d140d7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1445
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 04:02 PM, Gary R Hook wrote:
> On 05/18/2018 11:49 AM, Randy Dunlap wrote:
>> I think the Kconfig option would have been the correct choice.
> 
> "Preferred", perhaps. Neither is incorrect. And really, the 
> Makefile/Kconfig choice is somewhat separate from the organization issue.
> 
> So I've made the changes for this. Now I'm waiting on Joerg to make a 
> decision on the code/file organization. I still prefer a separate file 
> for the debug fs code.

Joerg:

*poke*

Any thoughts on this?
