Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755284AbeENRDu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:03:50 -0400
Received: from mail-eopbgr10096.outbound.protection.outlook.com ([40.107.1.96]:54529
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752393AbeENRDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:03:47 -0400
Subject: Re: [PATCH 03/21] i2c: algo: pcf: make use of i2c_8bit_addr_from_msg
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20180514145330.4857-1-peda@axentia.se>
 <20180514145330.4857-4-peda@axentia.se>
 <CAHp75Vcz72q1Oi9hCf1vp32h3GrrYSoR0BR7qacnka9eKB8XAQ@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e9de96d5-a119-74ec-72b5-1965d71e5a42@axentia.se>
Date: Mon, 14 May 2018 19:03:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcz72q1Oi9hCf1vp32h3GrrYSoR0BR7qacnka9eKB8XAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::23)
 To DB6PR0202MB2776.eurprd02.prod.outlook.com (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:sXCskcPp4WgUZyXnmb2HtsiK/SEvE5O8d+GLa0WROPnvNgEft0hFTM2+vUwLWN42sXIkA2CQMTv73FHb7UyRSBCK28jjS6iuGd+E9P76nYAusenerjSf8TXqLElqZ4BouPw734EhedD7c1A+av7UmwuPYPHReTS7WSl7yinmkgITkDJ2NIXS2qCGIlSP6xKtiLthvtCWdj8e7XGOACw+Ovkx2el+j2kCP70rKmFr6s0AZVtLjaASntSiXnvtGZHj;25:6FQvQWnZd0xgN9N0CdWoh9QK+nlvtmrJQe2FkKOhaHbjJjati6/oyBZer+CB8naaVjm2IIQAcmZtRksbFohmo5wj5KETN9ZruS5LfAVqMHHreh6sJDO5je4g6JfiF57LK4eTZVymEF+RKV+oHL/6xGrzd3TH3WjrKuokcOk2ZZR+1RQf7hcz3o9KAmIHNuO8Qm2O3BZzW/wYJ1Kkjz6+RwbXNwq9fV7UKdxgQxqo1qSSTlcBHvXyqtPgkVMiAStKW9W4C3u4P285RZ+xw1tKzgA1BwccWk0HzAy2mJZfpCD1bd7i2WCsHqTGFbMxMeDkK5011YWhGJXbvp5gP/p3Eg==;31:dEwZ9J0/gi4OluOGFb/fOg1jfGdH93ZewV7Gh8USP1M2k7yB4pncuFEuu95mF7vdZaBxTcwTk24mSu0krpEtESE8Zlr00dnRkq9vE+tkJEgaywo4SSGb1OmSbjvwyoAWKxjJeGU+4KiHr8fx0fVi2I1YlB5u+2ex8xqZEe7KXzL8LZYigAZxLJcZWhoGnIcRLMvBjtOwH+wD1KthQBkPvnGlWQa4LuIqEz1wMgM6vlE=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27761636C69605EEA50CF537BC9C0@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:2pkzeN5wMkPgtNg487BVoHM1/9rbOC2q2MrlUCip9jWIXnXsn+sryM3/aZseMDOYgYo1cyKZdV4syxRwCydfeFws2sQtg8MplFn9q07bvqD6TCp5cxh5bVCAesrlVUBqUDE3dijJl5cfg4Hf0cQJDq9SG0HCPogqhtJ0tcaV5zPZsCSb3Qgdm2/LjxxemxqPWaF9cyn6jumsJjk2WMunEfDbrSxYwatJRxHLgRn7tAUGpcuJRDR58AEs1jw7ABejF56Mv6o/WaFxbqxYer6kUg==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(396003)(39830400003)(366004)(376002)(346002)(189003)(199004)(377424004)(316002)(5660300001)(446003)(97736004)(53936002)(50466002)(11346002)(31686004)(64126003)(16576012)(8936002)(478600001)(26005)(16526019)(36756003)(77096007)(53546011)(229853002)(386003)(6666003)(65826007)(6916009)(486006)(956004)(186003)(68736007)(476003)(2616005)(15760500003)(305945005)(4326008)(8676002)(58126008)(2486003)(2906002)(74482002)(52116002)(31696002)(36916002)(23676004)(52146003)(54906003)(39060400002)(6246003)(86362001)(47776003)(6486002)(66066001)(105586002)(106356001)(6116002)(230700001)(3846002)(117156002)(65806001)(3260700006)(25786009)(76176011)(65956001)(7736002)(81166006)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzY7MjM6WHBFdC9GcVVRenRSeXpvWFRhWjM3Y2Nz?=
 =?utf-8?B?V2tHdVJ3SDkvYXVKQWRUMERyejVZM3VUVUh1WGVJY3R1anpaUk9tSXFZRnA5?=
 =?utf-8?B?bjRISXE2QnFWL3lCTnhta0Fsb04xeWI3bUY3OHFYYlhSN0tiQ3hhZ1JXWEMx?=
 =?utf-8?B?aWdEVDROOEx0VlRqc0psTlhUT2JGSHFLM3NsQ0RjNGs3K0V4bmRJTVJRa3Qz?=
 =?utf-8?B?Z2h0QzBEYk1NTVg5UStpejdrMm9LNXZuM1lDb0FoU09VbFFwNHRhL3Y4S2Nu?=
 =?utf-8?B?ZFV4SmU0aHkwbC9aazIwNVJkU3JUUGJxaEJuc1JHbHZEQ1lFaWdBWjh3WFhB?=
 =?utf-8?B?UUlOZ0RrQmp4bUl6VTRsNjAvQm5vZ1IvZ0lvNmtSTTZCOEw3TVV2WjIxR09I?=
 =?utf-8?B?N3VkTjJkcUMrSm94bFdPS1NuRFJpMXdtQjhmeXVVRjZEdTljcSswNjVHZDZu?=
 =?utf-8?B?QTdnQXFlRzBtcEJyeVJ3K2c0cDJ3dXBNcWRndVBkZExQN3NDSHJkWlM3QUVD?=
 =?utf-8?B?M3U5MHlrcDVLbmN2aTV5WXFObFNXTEJSMHIvMllXNVA1bisra1d0VWRzcVZ2?=
 =?utf-8?B?MjJ6R0hGem80UXM5dHd6RGs1cjNIcG5GcFBaOUhpN2JCOWczeGtiekU3a1Ux?=
 =?utf-8?B?RGxQSTFhajJRSWF2MXZPeUk5Z0JMbiswRktsVVpYNmpoOWZCUHY4alBJVmRC?=
 =?utf-8?B?YXlveUJ3YUFLcmtwRlExYkx0cklrUnJGWVJkV0p6RS9uTVhFTTBnUG9IVUQx?=
 =?utf-8?B?NC8xUTFtS3pvL1VMbVNlVVZRUGNGNzJObzk1T2F2S2w1ZzdHVzAzOXVNQVht?=
 =?utf-8?B?dG5XbmFnNnluYlkvYzFHa01LaXV4SjhHc0dqbmxoRUUxRjh6MElTTDluSkp6?=
 =?utf-8?B?K2lFMmtwblRYSkcxaFZkWVI3c0g3cGFLbmsyblk5UXg3S0xBYlNsODJUUG1Q?=
 =?utf-8?B?bzFYdCtiRmRxZWszS2dJLzJHOFZKUW1oZVZDaklRZTZEeUVDcmVWZkRldXJ2?=
 =?utf-8?B?Ky90clhCL01ZNTV2ZVZFN0ZDaUg0bVBoRHZ1WXh3eXEyb2lPTCtJUk44MmdX?=
 =?utf-8?B?eGN4ZWMwV2xlYkVWT1Rra09PaWxzWWs0QmY1cU1GTWVxYXNBSCs0UHVMNGdi?=
 =?utf-8?B?R0t3VlpMSDVUMzYzeDhCYUFUK1dyeDlZekVBQ0NNQ3ExZEFWWkI4ZnpwRTBr?=
 =?utf-8?B?SnJndkJwVnlwY0hBRnJldWpPSENWekxZZ2tpZ1N0eDI0VittTmg0U1JjcFFV?=
 =?utf-8?B?dXVZZVV3VmJ3ZXFUaTNTNDFkOTkxalRYbU9LREd0NThnRHpmYWFwRGZPTzFp?=
 =?utf-8?B?Ykx2TjZCVXBiYTBEd1dLQkt6TzZLZnJ3ZmEwcFV2dVo5K0YyT2pLV1czYW1X?=
 =?utf-8?B?QWpNTGtIQy9mNVdycUNuVEVhWVQ4SHVtTTdXZXVaKzFBME8xb2R2U3RnSTlp?=
 =?utf-8?B?dUhKSVdiUnd3S1FCdTJ0SU1PRURSLzh1Z05Vck5YRWtxSXNLaHNTdGRLV0VE?=
 =?utf-8?B?a1NXUWorUzJ3Kyt3ck1Mb3lGeTdZanNxMHdSbkdOWjJSbkREK01hZ0xwZmI0?=
 =?utf-8?B?NEc1TEllMThVTWdpWGJiWisxS1V4U1I5N1QyaVQyK0JMY3BsR2hhSkFPd3d1?=
 =?utf-8?B?NXFLZy9zaDVUUHFpbkNtSnBwT0w1Q2F1NE42UmFNZ2t5YWRvWHRjOVdQejM1?=
 =?utf-8?B?Y2sxYTFGamk1Z1pFalJGN2VhdzllaFlpdnVlU3pJT3pXa3RwUksvWktlbndV?=
 =?utf-8?B?NUhSd3diQ2hTTHBMaEZvM0lCQ05LZVBUQU5FbFA3OXFObHQrUFk5U3hWZG11?=
 =?utf-8?B?S3o2dHZYR0VRWDd1U2gvUVpIZDZoSGNtWjBOQjQyOWhSdElLWEpnRno3M2sy?=
 =?utf-8?B?bThWYW5jQnBzZ1RPcUhoUGRCNk1GUjR1eVlIZEpacTZLSUZuRmVubDA3SnFW?=
 =?utf-8?B?dU1OK2FtNEd2NnJNbWptKzFLM3BuUUJGOG9RWFhOWnJXbHNidXJHSi9OYW5L?=
 =?utf-8?B?UUlhZjRpdjVvT3J1NDFxbHN4RVV3bHd4V05USGZqNm9IZTNRVWQ3Yjl1SHJm?=
 =?utf-8?B?dG5vZy9KMDA4YkxCaFRrUDExbDhRT2hhT0lDaE5iSWVtd0M1Q0ZMWU5MOSth?=
 =?utf-8?B?T0RXc1h1eVg3MzRjMG5QaXpHTFZpMG11UnorTGZrOHZwVCsxaS9ha3p4Rkhm?=
 =?utf-8?B?NFpabGhTZFpTeG9aSnMxMlNmZEd1SUE9PQ==?=
X-Microsoft-Antispam-Message-Info: 1EuqseqF+UzDJ1eCH3V9PWRSdNIpBzk2C987WSO7HfwWVo6K5AJY+6YDHZsEy3up6rnxRcmYaDAGAukIccnmFoJ4Tot86tzMSzCFJWdzcWxY/wRSkp1gh0CPaMtgqg96JN7Oydfy5Cy0MrzDFUR+EcOHo/9PKe3xc0ondNqN+cAzdJUI5wwAoWc67FtP7qZ2
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:xD6ekIuw8rtce3OZnRFKzV5C0lHv28q3CPb6GcINLA9To3fEZINN9f6dotCXXlYHLXtJZ4YwAUC7rQjkgNrFHV9U2ZMZdH8dwVNSVkqbbjVGP8XrQjN3gOAsllzrleU4q62nbLO9p7THu4p0BPkfkso+0yputdMXlQOi5AVoa+S/AMXZnOLfusNoGiUAERhtq5Bvo8e0TGPVwXh21WxLe5RYh3bwPhBvVxS+EW6D9GKpUiSuso0guWPt/SWpzfL99GMD61D5XG5cTPzOPY9vf8fKLd8Zb24e+cpWcTt42HI1HOBtFsOc4wenT/WfdEpnWr298i6avn4O4ajPkHJbXcpjuGQ0jBa2pUZItC7UD8DdOaqxC14j50aI32PJnQV5p8wV1xDYLRugrsFGE7t1Xpa7sak9xarzXb19dJQgRpoRs4p6y7U5WfmSFCP6gAIIK3krsilQo5Iq4H8CxsIJ3w==;5:n6NroLRZXrLLg+eRWmS69d3iNYp5NpW3m5HeO09hnFjRfQXQl+bcWWhfKyIka2G3N+8mMAgxz2UDO4QceqlvRHzydR1oN8+U5zFowEiJFD7g1Y480W823tHrIIrFDyiTbg/VWddY0jwpyOVIhTZfjXCJ56xOVQpBtRq+tAH+Kxg=;24:pJe/5FJT54Nza9u3bTt85R3gvt/Rex2Z6TmDXBbquFP0uEUqTQTI3m97JGDHxz+Y4y/pus9ydrvzZCgn2aiwPs0xgqqBWed+0wg2y92aQro=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:uHcXe2G83J/90F51y2WSR3TZbUx0VsTiNT7BJ4+jowCpYHYOsffGxZsTHZaz3GHZvpmn/V/TMj6EIXe3u23i2GDfp7tFenQnBgJNuoWgPmeyTc1aV8hAjrI6MDciQ/uYJf1gZlZbfr9TXULEGx+lVi17TlM+aKJJ2o4RUCmCc5uXPKdL/a6Z8kl+M+kBGPuD/81cWDlBRiz/TxcWG9npqjQJx2EpLru9tf71MeFcwGzCSfdv0ALGGHn9pt5nht8w
X-MS-Office365-Filtering-Correlation-Id: c75cde38-4d9f-4fe1-aa87-08d5b9bca6fa
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 17:03:44.5166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75cde38-4d9f-4fe1-aa87-08d5b9bca6fa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-14 18:59, Andy Shevchenko wrote:
> On Mon, May 14, 2018 at 5:53 PM, Peter Rosin <peda@axentia.se> wrote:
>> Because it looks neater.
> 
>>  drivers/i2c/algos/i2c-algo-pcf.c | 5 +----
> 
> I guess for such trivial no functional change patches you may do them
> one per folder, and not one-per driver.

Right, will do for v2, if I don't hear anything else...

Cheers,
Peter
