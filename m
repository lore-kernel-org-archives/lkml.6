Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeBAFLc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 00:11:32 -0500
Received: from mail-bl2nam02on0082.outbound.protection.outlook.com ([104.47.38.82]:36179
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750753AbeBAFL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 00:11:29 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
Subject: Re: [PATCH v4] vfio/type1: Adopt fast IOTLB flush interface when
 unmap IOVAs
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alex.williamson@redhat.com, joro@8bytes.org, jroedel@suse.de
References: <1517391946-7830-1-git-send-email-suravee.suthikulpanit@amd.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <0fd4610a-c3ec-90f9-2d87-a7c2dd78193d@amd.com>
Date: Thu, 1 Feb 2018 12:11:19 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517391946-7830-1-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [114.109.128.54]
X-ClientProxiedBy: CY4PR13CA0089.namprd13.prod.outlook.com (10.171.162.27) To
 DM5PR12MB1738.namprd12.prod.outlook.com (10.175.89.143)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bfbda5b0-c54a-4738-fa6a-08d569323f5b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1738;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1738;3:aaB+sfVTB9qVMEj8e9fqGN1cxJZKF7SlFWEipJ2+IpFVsavwb0S3dT0Qs3cKZqPuiUPa4ojVyfIsh060rZdteQuVY4bSRPVKg8Ogtfz5FSDhuiLry59QrMdRVlsiCvE1fOYAdHQQRUAXj2fA4OxO67x93Asim67wBkDAiOZ66mCgQGgO5xj3O5Q3KEy3VQ13c2kmUK7LuRjvP2PPbEszHoJ/wujyeB76Y4pvY7pwYQ4bjH76EVuDBF5THIiBHZH7;25:Z8cIS/gCtxOQMxhgqJZDOjVxGT2M/8MWudE7ryPvb+cBICMaByxEUfgAFVAcOZMT67vqjHZ7CuOopKkvjQS6Fbl3uPq6diKg1eWOo4eCvSIhE7mGZqq3kLGzEdEia3i3JBhCFuczFSR66DCXdweJGl7REIyFcv8ir4s+ui7fc1VpnRlypT1HeLEr/MdxMbEsYcK44wec3MPKj6O1+MM0aZNjmY5e4KmSIE4QzTqOjIaYsA/+2sDmtMQRGwAi6nKrXIBKG+ubK4LNu0wxnBvB9AJ1FYe1fv4J44L0W2b8bs9dNzE6sYJ6zhIkQgxqRYdtRU21y4NgEcAQhqQpJGn2IA==;31:Uw3WYA2x5hGcyr3+CZ6XjH2oOuDzaFESgh63yZKmRfm1dhRAdh9i0HuS1Jcm+lcrpy3coHpCHRDmCudxoPXhxYBSKdaNowwJupsGbGFDYEP+wzxBuLdiGDYmFs66lUN73unurDTkbzkQJnlYxEQEdw7sleyiwetkaXQUvCFQVYHNhoYc/WSA9YxynXc9qCCKZbjAFJv7UeUIOfQwUIf2Prl2cAIFnCawrZLKyqZ4aGk=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1738:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1738;20:U96RhVU+k0b0bnJxR9s90ZN2sfVTDdgikMzI0f74qTQdBs0oUR+Kp5q41ejQv1NEyl7dVgjUMw+Gh7A2fOi548hQdpeHfNwE+TduwI/D47rQ1it3sIo+bJxnHkdf25r5Zs9+DgHS8SKBjZI0vXuRLrxioAGzZIoZyvP77KV5CO5j8cpazRMYTazoEOejqriE8J0i+LCtLh2u5YgP5b64ZYmeaTnC8lgAJ6blp+gvOFJ2zIMTIXZIrIuvK7QQe8bUHUA1eBoeQZIfOsFALqcJ+hTWLSOwXS2raBDXvXdoqRRuplrDRCHjgGHzSq40SqSBsPCfpFwAXw5LC5/8cHd6AFKyTRKRMixLVYLOXcUSPC8OnSG/NAQoUYsjI1D4Szig0QX5zu0VWBV+COBXaV5N1LlalDfICaWlrKuOLH3fLEQuGbadsakgoiKv7i5JGexyIDIJ2+FhA0fCElznokZRJ4RP8O9rYpMU3HDTNSgWu62xyExBU+DQdeqVPtw5d58l;4:Katejwtm9UoGWd6yXbdpjshcCPEfXKBjUgCXN++jQ1GPcGXBxUIWyv4q+1Cokd7lwWK/nGo+9518UJYlAUxIxuWvl7zqBRZTY24z+IiZkr39Is2A3MFaBUrFyAD76Dwx2F7GXmOjLDAVgJQ2KK9G6pu1rPFFdLkTJAkEk41os6xpfCrGjKtLu4s5CcNqSa+0zyYqg1YA1tyEvRA+o0TrDoUybml3TizfEeHncvjVSm3D6fgpjkD9mxE7SxjrIt281MOyfDf7AflKgzeCFnBTykVqi7nZqXinZ0DFfHDBPqCw32Sa/sA3ARxoPyS33mkN
X-Microsoft-Antispam-PRVS: <DM5PR12MB1738C1501394751C456914C9F3FA0@DM5PR12MB1738.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1738;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1738;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39380400002)(39860400002)(396003)(189003)(199004)(31686004)(6512007)(105586002)(2906002)(3846002)(97736004)(81166006)(5660300001)(6306002)(8676002)(81156014)(2950100002)(386003)(106356001)(6246003)(6666003)(2486003)(8936002)(23676004)(52146003)(65826007)(6116002)(230700001)(76176011)(52116002)(53546011)(53936002)(6506007)(305945005)(229853002)(86362001)(7736002)(83506002)(186003)(31696002)(68736007)(6486002)(4326008)(47776003)(26005)(50466002)(478600001)(25786009)(64126003)(72206003)(36756003)(65806001)(67846002)(58126008)(65956001)(16526019)(316002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1738;H:Suravees-MacBook-Pro-15.local;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzM4OzIzOkZpOVlYRmh6dmVkSVhoNmRtK0RTRVpSLzJs?=
 =?utf-8?B?QlF2WFVtMm14TytBYktQMTV5VENDYUdwZnU2R0JRN1FiL3BjU0xoUVdmS0dW?=
 =?utf-8?B?U3JxTVRxcmZ0Q2kyT2RoakNtVjhVYnFDS2xYUlUvVTJDUjhJN2l1VlNGeHBj?=
 =?utf-8?B?QzJ3S2Z4cmVGdDZ6SXFXTjZJNG1OSGNSVlhkYW14cENoQ1E2dTFLUmIraEJN?=
 =?utf-8?B?WGRlRkFYeUhUZGY2MnhvOURHV0V5Z1FXT1FGSWsyVzBiNHhDMVRRODJvNDBq?=
 =?utf-8?B?eS9GaE9QaUlTREtKWXhDYUFpeTN4SDFveTBRVnMwOGF3YURGeXllbFVoSzh1?=
 =?utf-8?B?SkRVR09PckFVSG9uNGpNOEp1K2pVNVNLVVdaSWZWTUwwNUZSQjhXMFpFdmsr?=
 =?utf-8?B?K3hvNW9vWG1BNVBSYWFGL210M0RWOU5VYis4b2VqRVJpcTNYeUI3djNrcGM3?=
 =?utf-8?B?ODllWDUrMjA0T28yMHU0eGF6cmR4QVlBN2dGdm15OW9aTDNKMHN4MEdERHhS?=
 =?utf-8?B?ak1oY2FiakluWjNvNUNRVFN1WFpYTE5GTWFwMlJtZzg2bGluMU1aM0thT0VC?=
 =?utf-8?B?dVZLZE1QblZzTFVhNU5jN1FPVVowallsaVhJYXA2Z0pGSnJheUtlaGFvUlF4?=
 =?utf-8?B?LzZEaXpuSG9yblZYSFNmNmVGU0Z6VHkyNktXeVVsZGxYUkI4TGJjVUl5aVFJ?=
 =?utf-8?B?dXZTSHJNM1dHQkdrVkVjT29ZSkZZSXdSZkJHMjdPY0ZuOUM3RkJkUE5QVjlS?=
 =?utf-8?B?clRjemVlU0tCd2kvM0p3Uk9PbmVuLzN2bVp0LzJheWxycUI2bkZwZVJLSk4r?=
 =?utf-8?B?WExJMlFwRENkRzZkT3E4bmFHeFlYUUM5NXBIZ3hpUUhvVGNjdktCNWcyWUFl?=
 =?utf-8?B?T1VRaWJzaFVFeFUxbS9oRXZWODBxR3ZNNlp6TmJwQnJEakxkZDFFWUd2NTVV?=
 =?utf-8?B?Y1NFYlllRHBmY3VtTmNPOHBUYjNqZjB4czdmZ09Nc3Ivbm9lQ3BnczhicW5t?=
 =?utf-8?B?OEFnbEliTTZWSXZBbTNzNkM0alhyZWN6WUNyOXNWaVdzTFNBdDlScnh4Tkdo?=
 =?utf-8?B?Y3NaYXZGdUVjdXBrbFdVT2IvTFpsVndUTEM2N0R4U0w3Sm8wV1h2NWxrY0Jh?=
 =?utf-8?B?NkEvbkJTSGxzN2hVeXZabTdTY1grY21VR0E0SWZyQ3B6OUhGQW56UzhOMVV4?=
 =?utf-8?B?dnNMTllvenJGQlhSQWVBWFhJRUVsUjZnckZjdXd4WUE3SnhZekpoT3BGeU0w?=
 =?utf-8?B?aDBUcWJVa05nbDlMbnhFRGV3UmVZYW9KTnFsaUsxQlZ1Nkt1dlkvUS9jdjBL?=
 =?utf-8?B?dm5EbXhEODlWVGxzd0M0d0pIVzJVQ2RUQmZQWU9OQ3lWV0Izd0I5Nkh6b1RM?=
 =?utf-8?B?SGYxUjhuRWJXZkkwUWkzZTJmTEZaT29XZU9LRHY5VUhWb09ZRExXTWZ0L3VP?=
 =?utf-8?B?VFgwQUlSWEFXaEZCbkRzcEZQczJFbGg4NWdQVHQ0eVlzOUJzQnB1aFhVWTJk?=
 =?utf-8?B?TXVvWGtmdFd3VlBCSzlVSjlSdU5qUEpGekgxSDgrcndpcWFTWHFrS3hSUUJG?=
 =?utf-8?B?cEZBdTc0WU9LbHBnNDI4MzdoNjV6MGRIUnhFNjZUa2l6YTRpQ1RtVUpvTmFy?=
 =?utf-8?B?aGROTGgvNURuRmtMN05hVFFwZFdHTzk2SEQ5cCs5eUdOMlZ0a1ArVGF6d3Vz?=
 =?utf-8?B?eTFuMGpaOXZXaXhPMVBFdEZ0VXYrUzNWaXdrUGo0SjgzbkNyVFdSZk1EaXZU?=
 =?utf-8?B?cXYxV09ZOWhOWU5nL3Z3SWV2M3pBK0FEZGt5OFZpSjFjdHIxdjkyNFBNUHlR?=
 =?utf-8?B?M1hNTGE1c0hCNWdUNWhoR1BYVGR4MVNaS1hLL25Da3E0ZkVwd0xRc2U3R2VS?=
 =?utf-8?Q?+A5gCgKhlPY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1738;6:VG2Ko4wMmG6AKHxiFYGIHIe/x6W3R4qKLzf2X+ujyPtkm18u2mwHxEkjzYg9VOkB2wW4/r6iQLfVyAXue8H4vh2zAl97Qdj4PQ51HHdxVCQp45ku2WUqPmxCxRStuMSB2MvPPfnPzYdZpEwhcpA5XzYR+1wIWfJccK8+cX2GX40qjggWSod4uAFK7b92F/d/O4Ri28TgzYzQNwqLfFg55AQqztNvD1jBFpbTFJcO+uEkJ7/mL5J8kybiINe8QsrO5Xx42JRNE1m+HxyEm5EN+8eEqMZsho6r/RzYPkB0cOyBx3eSsV9c0/e7cTvaOEQ8ZcjJAJ3hNhdcbbjOujAqzxtWilqE55IOJrSBi3TLuYQ=;5:OMWw/Szff2ZABxTkrPPMtzkosUjzyn5e/eWVTxelMyv+J0KfB8qqz6GeTxCKsGnbhCIjqwzDfVkya998PK+4S5MyIzgB11lGoGcVdMtCo6fLcTCnTkRcA35AoiJyADIG7by6kCGYlC2A0yY1FxWM6bLdy17F8zNv8a5kA+rPHTE=;24:597F6MT6CjdcCtWQXCn3eazqJUSTCjSE6sqz8EY44ESu0C9DLe9aplfb5IgCVxnTDdGJwLFT6Oxu7YRW0PSkvIgSlTR6xQO/ICGov5tTxn0=;7:4VnRhbU9bA4evzsgKj2Y58M9yA3psB+logbdeKlsq9dy/NLFtmFLn14OiMRvYM8csubmujUa0ymYC/hbbtDqZNTNe1BTVvJ9lBVJthOTGJfBXhulp83B0zwfA8f/bzqJFlM5rNzwRjv5gKZEAPdKuMmCcOsgno3lD/gf8zTHpY72+oh3LkFRw9B3OfmEMLYECk8OoZ20sbzrovBf1+kmv1veoeUh9wJsq+Vuk+afjffuirMHqJsE6Z8payx791gV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1738;20:FqfwOiAiqv99WR9HuUgI1L5lOayTD+2Qz15eo42wPu22A6E6B6J4ej5nkR9D7Y8t+43J49Ljc55ktBpQwsE540HtSxskxZKlrgkM/sA8WycLPqiiRJfj1Utzw/rUb9IUmfRp+CYN/g5GFnK4M1HkTsjW5c9HlEjrKFrcujrwDxbNy0HJtFVnpTyH1oTLSGM6X8JKpyxJOaeNadLyOHydIiSjS4d8ttre0D6S3yzFkQ0vqkgISyWPrSGVZLdukdM3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 05:11:25.5222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbda5b0-c54a-4738-fa6a-08d569323f5b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1738
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,

On 1/31/18 4:45 PM, Suravee Suthikulpanit wrote:
> Currently, VFIO IOMMU type1 unmaps IOVA pages synchronously, which requires
> IOTLB flush for every IOVA unmap. This results in a large number of IOTLB
> flushes during initialization of pass-through devices.
> 
> This can be avoided using the asynchronous (fast) IOTLB flush interface.
> 
> Cc: Alex Williamson<alex.williamson@redhat.com>
> Cc: Joerg Roedel<joro@8bytes.org>
> Signed-off-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
> ---
> 
> Changes from v3 (https://lkml.org/lkml/2018/1/21/244)
>   * Refactor the code to unmap_unpin_fast() and unmap_unpin_slow()
>     to improve code readability.
>   * Fix logic in vfio_unmap_unpin() to fallback to unmap_unpin_slow()
>     only for the failing iova unmapping, and continue the next unmapping
>     with the unmap_unpin_fast(). (per Alex)
>   * Fix error handling in case of failing to do fast unmapping to warn
>     only once.
>   * Remove reference to GPU in the commit message.

Please ignore v4. I found an issue in error handling logic. Also, I need to change
the return value back to size_t (as this was in a discussed in a separate thread).

Sorry for confusion. I'll clean up and send out v5.

Thanks,
Suravee
