Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933233AbeCSNRb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:17:31 -0400
Received: from mail-sn1nam02on0062.outbound.protection.outlook.com ([104.47.36.62]:44608
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932883AbeCSNRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:17:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 11/13] dma-direct: handle the memory encryption bit in
 common code
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180305174655.9878-1-hch@lst.de>
 <20180305174655.9878-12-hch@lst.de>
 <114e27be-5814-4258-4985-af08763c8a74@amd.com>
 <0c9d3e4a-8407-282a-73eb-21d28047e0e3@amd.com> <20180313131005.GA6260@lst.de>
 <69e98163-beca-fb8a-a26b-66dfeef2f689@amd.com>
 <20180319103939.GA23333@lst.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <e9982425-b003-9be0-8359-2fb85c5ae76a@amd.com>
Date: Mon, 19 Mar 2018 08:17:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319103939.GA23333@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR2001CA0007.namprd20.prod.outlook.com
 (2603:10b6:4:16::17) To MWHPR12MB1152.namprd12.prod.outlook.com
 (2603:10b6:300:e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82b4168f-cbf1-4327-dc73-08d58d9bb753
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1152;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;3:aq5r83YZEMlOaM+G72fr5shtJTFM7Em4wPMZ5wSNZZZh9u6ZV6xFtECaqvneUBmcsxCW9EATtR0WwFDqKrzVkw6t0I/1bDt3+g0PjisrHBioIob/7cF6VQDf7M62A7oeojvTaMNmPfuZAa52IfhUMHEn/3qGI+hRiEmDUiJpQInOr3GQqVr9Ihja7E4Zy4jqXHx7kbP4IdJMG9Ut8D35+vGXPt2+JTwOJB73Z/FF/N7vGG20tcf7I2bVV7ujI/Hn;25:2jQ7gzIzqvdL7xMla2YIwYaKz62OAQiEqEYEqwc2SYTUaF+EjxgqtJ9PHOQjOHCFSVni+0AU/aFOB8p9md/ChO+6e1koVp4S/etSeJJ8LnB2FgY+I7g3MEhvWyFSM+oxcGYjpUSTTVFpsUDsBu+wBtkZIfF6UZsApkw8QkltmyUhZoHteCAvWqcUGLE9Az2Zh0RDSopPqkgvMaK51z4ziHOo3DchBPgRXLDiZYJuH/yz8ppBEBMpfBzf/9xq3KvoJQqdD8iXWAV+SO2MS4AsC26+lrBOdeq6UbAPchbIXkremgRJTDOEiJ+EpZJbqDUVWPsHi5OygKGXuREh8XF+KA==;31:JHyrTZ/3J1/kjoX6FEHGIayaD5AbctTQPIp4xIJ98/oowf+am3u/dmX8llhJ+xPCbb+JlM4Oz6pSGuTA6/VsUb8/6vj2pUc2MQGjZcpZoAbGcR0ycQ6fK9QPCpm9mab0RNBxbWQoRyPn7M8eJBKMaVhUzfEWYZ36lEl6rPgEs8Vb6eKHzWrNki1Yo/WtcdnEfvb9kL/SSwlEgdIKZx/nlTAvpdL8tZSxEuQxOr5dbNA=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1152:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;20:z59Zg0bdDwvmwVwiqAg7DCapdOYdcM+ZW9U+gVsnC16yrCmG0KiCtM1y7apS+R2oEfLJXzYXHZuhMv8zAglpcMX3NJK6RXzWpuA0vfZZU8fVFG7MnCvYeBgLse1Or8V9H1vSvZONFJWdD1K0amRoPj+J7//8ybMNsstU09tFBtajI0wJBA0egmtTgOt98C5V04BaMiKSKfsD4POP/UrUEvB9ookaEANSNgTfR/ybdCopN51qLhpi/yZgQjiTuFaxTPtWXg+PT7AGZLCxi8Z1A8Y6Z/MO8F7w8jFOY8/7qppXYOIx9uJWVqjDKHOmaBDtSXspqJeiKOxdRyqv+CKtI4kz0rRz+UVzsbAXMBNO3slaJPBhXAbNKlJaf4nXhFwL7jDQ1ZyNSjcQcvC4gBmxNaOOPZhsuvZB+H5Ai6xMMo7UasFsvqAOde/nXdorDIKPbIdpJXv2CI9kDysqYEcYvOQere0BmMuH1IMeL4X7hJ4JmCqSGC17KSQXLl1Zcf35;4:Oqu6fyjbEJV3aY0kN5gkrq3rF9fuyvjNq998ZvJPFz/MbQLi1UHzEQVysVZnxuOWBq9sOMrFs1Z1B5TXx7JC1E9A8W1BTH+AkBbeyUnpfLsb8/9r4rTOb61h5EvvkQeRB/A4ypbnPhIe2LOS9QxRLD90/fkK7MAkpKs4LwdtcGuSeFWNj05Hvmm7WbP5jqkdySGOCNjBU31j0zWiGz5ptPVe07z/1TB0xx40Ikv1Add7gwOnTMHOe0QDIzm+7E1uLESrEN1b9JwyJh52dy0Zwg==
X-Microsoft-Antispam-PRVS: <MWHPR12MB11524953F86FF516CC7A0D6FECD40@MWHPR12MB1152.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1152;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1152;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(346002)(376002)(39860400002)(39380400002)(396003)(199004)(189003)(105586002)(2486003)(52116002)(65826007)(8676002)(4326008)(53546011)(68736007)(52146003)(76176011)(6246003)(23676004)(386003)(31696002)(316002)(16576012)(97736004)(7736002)(305945005)(6116002)(36756003)(6486002)(5660300001)(31686004)(93886005)(3846002)(25786009)(3260700006)(6916009)(53936002)(16526019)(186003)(58126008)(230700001)(229853002)(50466002)(81166006)(54906003)(64126003)(72206003)(81156014)(2906002)(2950100002)(6666003)(478600001)(65956001)(65806001)(66066001)(26005)(558084003)(47776003)(86362001)(77096007)(8936002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1152;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMTUyOzIzOnVpcXRBaFA4T1BqVGFIWmsvMmlKK3RaYU51?=
 =?utf-8?B?SUY4aGhaZ3NwWUpWWFJRK0o2MGpvbG9ocU1UQUora0JOL2M4cWlxUUVidkpj?=
 =?utf-8?B?YnFQRWlsaXY2aG9DZUtmVG04akFDTlZhU0NGTDVHZEp0Qk9LVFlwc0JBRjg1?=
 =?utf-8?B?UW9XUkFrR3Q4Y1VnNGg1ZU83UWlyQm15NzFLSkRsbm1RL1RVUHl4bGI1TU5h?=
 =?utf-8?B?ZTQ4TDRHYmlaM3FLNDlSSHFhRW55RFMwTUNuL3k1YWdEVTBVNGNkc25qc3FR?=
 =?utf-8?B?VC8wNGFCU0pRM0hMMDNkY2pvaHY2QjFwVUtiYWtVZFZmaWlacGpnY2dQd204?=
 =?utf-8?B?RUczWm54VUIxR0g2MjNFRUpsWVFUQ0loRVZFcXR3ZXdqMUVQZnV6MFQvTUlM?=
 =?utf-8?B?QlJSd2FrYllDWExhNE45MWlIaWNBWmtaSmdUZHJFN0pHWmxpa0k1c25xbHRH?=
 =?utf-8?B?Tm5sUXRGaHB1TjdBQ2dpQ2Yxd1J5NnNZdWFQVXJyNWQzeWFYV296ZU5JQXZ3?=
 =?utf-8?B?R2hKN3g4a3ZQNXlOa2Fwb082RFlKL0dNbnVzSHpIbTdEbVlrcHIzdkRCdHFa?=
 =?utf-8?B?TEY4Q3l6a2JrYnpMZ3hCaGdjazNVeS8vYTVYais1MUFuZ2ZMSDd4eUd4NkVk?=
 =?utf-8?B?V3g0VzQvM3Yxb2k3SEdEU0hOa1hXbXNRVXY0YXQ4allXaHc2SVFCU0tiZldu?=
 =?utf-8?B?amVXRjZQUWNxTU53Z0dSZFNPVGdrekxTSXlOTkpjYWc0U2JXNURRQmdLU0l3?=
 =?utf-8?B?U3J1VnJGZk9hcHdHNVZGSWZMejNpekIzN3JvblpIMFlYRTZ4Ti9LQXFmOXhL?=
 =?utf-8?B?TGF4L2hXRU9qVW5HUGVmQnMrWjBuaGtRd2tWUDV1Y29Ka2h0MW55UVo4K3I1?=
 =?utf-8?B?bWtLQW96djc1QmtwRXRib1VkWWY4Z2MzVERIazRzVHpyVHFmaklUSTNlekJ5?=
 =?utf-8?B?VTZzcTI0QlFPUG1KRXkvNm13UCsxMEVNU0Z0T0NoL1lMVExueW5qb1hUUFdF?=
 =?utf-8?B?bXFPTGU5aitVNDF2cCtUL3FWdTV2U2tLV29OV1lmc2U2Z0NvODlJOGJsRnB3?=
 =?utf-8?B?TnBRMGIwQnVlSXlGcjdZT0FML3MvT1VzU09tMHhSczU2NFRmVEpPdlg2SjZo?=
 =?utf-8?B?RkdaZVgxQTJmZk1NNDg2cjB6VVd4NTNLdCtJT3FFZzhSYXZIN1A1MFVnWEpm?=
 =?utf-8?B?bWNkYUY2S09hVXlQeTJNcGs1Vm9vYWhNNGtUMitYdE5PRHprQzZybHhJTlJG?=
 =?utf-8?B?dGNqRXNTc2lQMEFib2JNT2NSb3Z0Q3JMallNZXloV2dGNG01RXRGaWwzRFE0?=
 =?utf-8?B?SVRGRzArdWdSVjgzcjd0OFV6TjFZZVN6V3kwL2xxMEoreG1odHBjQlozNXBH?=
 =?utf-8?B?YWhzZmRXcTFmM1ptWkRIVkpJbEhIdWdCNmw2UmZsMXhwS0JlanpoYnNUSVN0?=
 =?utf-8?B?Sk5wd0FCTVJZL3piYjNVaDJyVlhEQzZPUmZmeDhGeWk5TDZQQnRIb3N4dVRG?=
 =?utf-8?B?THBQUUxyQlE1K0ZLRFZWWURIN2dib2VDUlkzeG4yTWtsWmlJenBybVlzb3dB?=
 =?utf-8?B?ak9mQWsyOXgxVlkyRDNFODdQc2hVcTdQZndzVnpkMjRtMVhFV3Z4bHVJeGtI?=
 =?utf-8?B?WFMzaUtFWFRVSXIzVXJaMTN0WUhhVkc0Vmd5aTVpNGN1dVJpM1ZsdXQyNXpL?=
 =?utf-8?B?WGJXTVMwdjY5S3cyMDNVbERhSWhaZ0NRVEhtVnNIMlhXbHM4Y3dwR2RqRlRP?=
 =?utf-8?B?MjBFWTVLY3ZLTERjTThUUHZTaUpsZHZqQzFVZWE4M2dId3pnK0U0T0ErQnFK?=
 =?utf-8?B?M2thVkpST01hYktSNXJjcmcwc0ZqeG84N3V5VmdVV1FqbmU5V2NLRlY4VzRo?=
 =?utf-8?B?VmxMb25McURVWW1UQ293NmtuVy9OQkloVXgzU05iaW5HZUZFd0NlMzIrZ0xy?=
 =?utf-8?Q?4lRVzwqES37ZMRzOsR3X4hD4R+4OWw=3D?=
X-Microsoft-Antispam-Message-Info: CL5qfRqg8p4C20gygcndkT9TVTYw//k0rJpU+kHP+qgYZ/dJCMUeW3OxeMKWyuU9ZOJN6vtg2wC8cZ9FFO9Gf1DwAC7Y+MHvdJ/nlSZcgMfUKYkFRGX8nfDODfGcTuNmWgELL0DkcU2IkBrm6b8xagXcJdUOHKVvjghTVAhdbYiv+Hx8KeDllcU+C2gaDjjG
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;6:Ab8zqofYqvAv7uofbZz8owVmMIHtUIUODQbjK9gEbbm4eSPXiJVhv7/+bs4jBI9bSCAm74gPSQ6yPqbvQ7BmZSib94ZWXDQzMrIu3iNSmDLKiLulXCpjcLy+qeg52Gt1q97K3IEkUjnXRrVZRdXJLawnQbZhzOSVWbrDefQVKCuJ/B+UvrtTTYhpSEtrbOw7vA/oh8JK/HwR8g4TrwCXk3QlB22d/0Zc+jAZa19wvKrWf+FYSkmQnOG33xTTLH8lB1dGcQ0FkgGnMib+sBUvQjjmPfCoYnHDFH2aNMS8/ZqR2mbImfE6YY0aK4CldcezJ8Spi8O6hPCHNZkWSYwvYNgdaCBPnYm5y+7pS4Bxo3w=;5:yzp09pCvXQgs6c4sCWky5zvRnFTyKUmys9LWpl48UFGtvX86XFF1GOGGBPhoH0FMzfD7BYWbY6BS8WZNwCAjgK+4IlwKhVqi51Z97sslMvy0yVic+/x2i8uufWNDq7hk0B0+G2gRdAKQZmmdrzCs9bM/uibo0VNuzLCoJkdG6lM=;24:BZKBlFpuZLIy3yfpAGUPuqP5Z/pUbNCgsgSbkD/xSHSbPVtqha91VqdjQF6uxHbUcztsyakObGGUHRfbXd08uVUraN40s7xs/dsrj3w14rQ=;7:Z9dQuDaC2ltFpUsGUWepDSNWCMCjlIjp2j9ULSxVZgvvnk4ChUSB5QbxuuF1i56OiVFLs3ZlisQls7FiJ70DCTBkAN/BDurkXNlj+R5EHFjtuMfpguCeZPXNX9ZPH8kjzJ+/veg+asWNhSXCYFxkohJFJbCBgEUK0bzg5KcKmB5dayJ04Znb7OvH31+2+gviolvZJZDeuKHPzhng9F4DK/tEUaEkA6AW0sfS2qF2MpH4Z1Eba+t/lZ0hvErqXSdQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;20:FVCirqF4ppazvnv6CHI/meqBXBPgLOc4xUoPYBpugz77n6UpAcwT1m8h1vhW/Zkpqp/d3cNhHyJ/tMGLNNi1EpCpDOQAgZaKTNltVy1aHs8iv5KpH/TEabr7Hgu0+FGgwMl9dwetVsOrZKymB8uE3GFHlxFsCMJSlxxZYhMl+SPC5PTqkigKfHv0ER1N4iL5Ru/gqqspSRC/npOZF7z3lA5H+XcShXsE6FuQCxas85J771CY2RyMjk5VVxz1VI7g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 13:17:07.0310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b4168f-cbf1-4327-dc73-08d58d9bb753
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/2018 5:39 AM, Christoph Hellwig wrote:
> Can you test and review the V3 of the series I just sent out?
> We reall should get it into linux-next ASAP.

Can do.  I'll get back to you on V3 thread with the results.

Thanks,
Tom

> 
