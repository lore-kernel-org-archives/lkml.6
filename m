Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbeEKMlF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 08:41:05 -0400
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:17891
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750726AbeEKMlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 08:41:03 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Igor.Russkikh@aquantia.com;
Subject: Re: [PATCH][next] net: aquantia: fix unsigned numvecs comparison with
 less than zero
To: David Miller <davem@davemloft.net>, colin.king@canonical.com
Cc: pavel.belous@aquantia.com, weiyongjun1@huawei.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180510125201.19707-1-colin.king@canonical.com>
 <20180510.175358.1296757435086922873.davem@davemloft.net>
From: Igor Russkikh <igor.russkikh@aquantia.com>
Message-ID: <a6f112f6-d3f3-4294-0b3a-5f8e440d474c@aquantia.com>
Date: Fri, 11 May 2018 15:40:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510.175358.1296757435086922873.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [95.79.108.179]
X-ClientProxiedBy: AM0PR06CA0041.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::18) To CY1PR0701MB1664.namprd07.prod.outlook.com
 (2a01:111:e400:5289::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:CY1PR0701MB1664;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1664;3:uyAkEKsYEIWTsWu43K+VsTcYFxF7Q4CtNCs0VzqON/QU4t20igj09zD5KfHCo4j1Ntep/xczh3TzdYoL9rDTcsl9x5/ID17cUiAVamOhQeI8t6Bz8TsHfCBwDnPiq1Jp1011EyukLybHv8beUhVa3F2i354JxWjlWDpQ8hSnlKVI/S2Xt0ZbgIqe3tdsYJvOneqQP4WTcFJvQr60m9fYw1TMXd+ov/VrJbsadG6yCa420tIHyx75BdJ9gGk2s31N;25:bGkXaUyCK0t2P0ZkfqeJlBBsSGLH+qFlydAlb5APMi7d0C23PqGLjwjTJL+7EBdXF0zseoYxnFjhILUvEInKJM1qaP48H5SASAP5abaQJgYh2w/gMp9hIA4C7F3NmKQ4gypuFlbv5fAEFQz80hlXDLTioWt8WWTmo48gKArm9c+Rs873kMccjsX2ybc43Dh/ZgXO+DTx7rZg1swLSGcvFh6xmloD/V+HVs1xMTwuCQB8qfMky87hUmuH5wB+cUzluIb05c9vulB74Po25th5qtK37BjgKEJmQA3NIYdohKzOjjbR7RgNpBQjMXjWmbZsXb+O8dyDTKBFjb0YQYJ7QjLUOba5bHOT0onbuwQmZRM=;31:UnHsnCeGCB/Aw8RKIrO3ZniddUgtyw1Zu/OEE6NJOA/GXUX5F8NuSGmLS6JNOdla+mimPJ/MEzj+iSMnGtrCR/sn0qCPDvb00V8YQhk4B4uo8GBk7++WX5WUU4untzn6k+Yhz2pc/mcptUDrr4WUBOM2klUxPsuUc5jVEX3njvbZ7Rzoj+JkaTMY2LM9Z/sHOv+nIGFBUOGT+05WiPp7uWeWoaNFoFGzOZdmRl841po=
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1664:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1664;20:6NYKo7rCbM6z4lltutxPZQOkkz4Psikx5fgbJEcbf82UzqFkXj1plyxy5c30j7d0zpeeRfqNc7CGCrVWVheWpFjZbTYdmMWRuxJ/kIHQCTTlbvSPc0CSESwJCqAJVd5eEBNle6udSWXUw9oCqlOfuprOByenvAjTLFr2OaXBWziICyDJzI6a+uz4JEorb3X7p2a4Z3SAPeemDpo8BZY7xA3MbK2g7MuqqMYoqGnVAdmN4ZqHPgfJ/x0ZRQpqnjUAjJvzZ5dIz2CHvGRTJrC7lAU7eP4Vp8h0K2nAMLdjutKQcheMUQaN9/+Cy4DaHl99idfjPHtR5J94GbVS5rDKgHDmG6gtjKTDfPlDnvmeSz06dhQ+aNjBXawjKOwDEggIUYZfNRcdes3WYDiPUJzHDYSYcLQB05J/xmFWlivXs6jsBxHxc2RkPg5Og4uvJ7bSkL+n9l0RKKVh3gr8oVxeXdddEP9b/whZGMoV4aTx3xV/L9zVMkDVJ023rQIUXy5q;4:9AysdZxfc8lLBkRqsx8vh4w9LrSas3D8QgRJK6vs04HjSy8I1EqSwdzEryHdMw/+aygJaZk8N98r8IkEUuMVF1e1gTVhKVHGcMz7FbF5YQd88Wn0TPzBL6ZG6kKq3yrLPkbX7OJn1s9JoQ5b49J0cwb/VLiCC+BxiMD/uVtHTH6PRPr9Juw1edzO2GH4ZXKtx9RBDzjjWflyfNCwk0Zbu0ODloFh0XSLnbRB97dGdmRY3A1q2lC0Rdcuj00xYqoB+PB/rCj1QrCYXW0Zso1ramBPt8tqctkhSbFwXS4E6TIsa0KRMSUQ0IW4nlINjsdW
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1664F913393B4E3D096B5A58989F0@CY1PR0701MB1664.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:CY1PR0701MB1664;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1664;
X-Forefront-PRVS: 06691A4183
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39850400004)(396003)(366004)(376002)(346002)(39380400002)(199004)(189003)(6486002)(8676002)(81166006)(81156014)(8936002)(3846002)(97736004)(53936002)(6116002)(6666003)(478600001)(72206003)(25786009)(230700001)(6246003)(5660300001)(65826007)(558084003)(305945005)(7736002)(2906002)(2486003)(386003)(76176011)(59450400001)(4326008)(23676004)(52146003)(52116002)(186003)(956004)(2616005)(476003)(106356001)(26005)(446003)(105586002)(16576012)(36756003)(86362001)(47776003)(64126003)(58126008)(486006)(16526019)(31686004)(11346002)(316002)(77096007)(44832011)(229853002)(31696002)(65956001)(65806001)(68736007)(66066001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1664;H:[10.0.3.15];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjA3MDFNQjE2NjQ7MjM6OVNoclZlSDB6NzY1QXpyb0V2dE1xdVIv?=
 =?utf-8?B?VEtERkE0aUhQQ0c4Q2xrN1phbUtET2NYdlI1WUs3eE5Za2lFVWxJUnJ1Q2t0?=
 =?utf-8?B?OWI1eHViTnhycEJyZGpNNzN4TS9IMWZOT0tBdm5UMnZ3TUcwR3NlOHlkdGg4?=
 =?utf-8?B?N2h6WnRHVDVUMWxwYVZQY3MvaS9EZWtpWC94NkNibEp4S043bkZuWmFuODg1?=
 =?utf-8?B?UGIvWWwxSnJCSzdLYmxqL1Eyc0k2clFoMFFPK3Q4NWwvWCtHVUlDWHZ0bEtv?=
 =?utf-8?B?bWhUTWhKS0dUWWtzdDNrT3NpNkRFWHF5ZUxIY2UrazhPYlZIRThNajZrQkpm?=
 =?utf-8?B?UW9OQlNxY0RUaVdPWkM4RXN0Q3RPdU1lWnpwZjloaDcxd3c2Q20wRVBSVDU0?=
 =?utf-8?B?OUo4OWl6SzhpUktYckdIWWY1TjR4VlRHWUQ4K3lGYzZueXRtRmRNR3ZPRUNO?=
 =?utf-8?B?eHlFZDZ1QVZjcytkV0dzbEpOU3BxZzVmcGU1VjFNbXA4WWl6RiswRm51N0c5?=
 =?utf-8?B?cUp2NUNUeEhWV0phNmRqdlpIendDc1ZFNE9KQ2RuYVFhSjhaa0ZnVWR4QVN1?=
 =?utf-8?B?bm5jQmUyck5oQkE2dnE2Q0pNdUJTV1BxeEUyU0xXUDdXdEhPRnhFSU9paUg0?=
 =?utf-8?B?dW5Kd21CWVBLNnNsMGNjc3J4aEpMRU0xUmtEeHNSdWVGSEwzVWk2d2FjZWwz?=
 =?utf-8?B?UVVYYUZUVG84OFpRWTBOaC9aUGlubk93cHNHVVBsUjRvUXF6UGZnTUVSQlBL?=
 =?utf-8?B?LzhETWRUNTNzYk9TekhUajJMNExwT2E5WVBHNE4rVkRyclJ2YUg3bVdxOFVs?=
 =?utf-8?B?SkJCYlExdmk2TkJnL3BsKzJNYzZ0MlNnMlNkMGQvOURjN1BCejdHWDJiWjFB?=
 =?utf-8?B?SUZzdjdEVytJdGlXQytnRStPeWtFM3J4NmRmNXlOMmk4K3JqK3FyenJhSEgv?=
 =?utf-8?B?NE1TU1FXcFlGa1pSNnVXdkozckI2N0xhMlpaT203Y1Y1ZVJjQ2VBOWU0TW81?=
 =?utf-8?B?M3NzYmptc3VvMVM3QXRPbWg4K052NmJ6eVM2QWNFOHFzN0VqaHZBenJqdXM3?=
 =?utf-8?B?QlBYb2FhZ08rQTBqN2VwOFh4TGV4djZpcUMvRVZZcG9wZTF4ZjBpRGNubFJY?=
 =?utf-8?B?VnI5NkVxMjFWZTl4WWpSeVlyTlkvbUg2d25uVDZHOUlkNzNqY3Vqc0hTUW5E?=
 =?utf-8?B?ZG5PUzJ3aW8xaUFRS1dsYXBlZGFZMGJxS09UR2wxMlBFd3d2YmZMM2Vuako1?=
 =?utf-8?B?QS9YaUJDeWJESVoxanNtMW4wd2wrZ2NHNHc2aXc0NldBdDhQTWlPZ3c3TFRn?=
 =?utf-8?B?Q09HdFNkbU96Ymd2UUtqN3MvVE1OTGpiOGlqWElXZEpWcklYYjZCZnM4clJx?=
 =?utf-8?B?SjZCUVArbjFNY0JzcFllY0JjT2tsaEFoNzJlUEdvK3pob05WUnQwS2JITGZZ?=
 =?utf-8?B?ZmJhVFhJTGQ4SjJ4aFB1Z2JaTmpPaTBnbW9QQURVd0RUaXNnbnlIV3k5MFJZ?=
 =?utf-8?B?eEVmTEdvU1J4M1E1QnBZN1lCcGFpRE0rejFhbUg2ay9iQ05aRVYwZzFoWGFP?=
 =?utf-8?B?LzlGMzFYUklEMVpkV0lxeWtLSlNlSm5yem54MmkvK1lXMWg1REVSd3JsVjZv?=
 =?utf-8?B?MDEwN3ExRXNHd0VCdEVsMitBQTZydFp1RFU4NlU1UHg1R0Z3NEVnL2k2VDg2?=
 =?utf-8?B?cUxRdmwrT0dIQk40cVlxRzRXMzFzVGZ0Q1FuVVR2RG1LaGpUaDlBcVA5ekts?=
 =?utf-8?B?Wk8zSnBqVmZkV05JYktMektyY2FZbXBsMnlKd1VOVmo1Q3EwZVU0MDM5R09D?=
 =?utf-8?B?TCtJcks1cnREYzNjMTlBVEo2Qk1kbm1GTjFrMlFMMVVnQ2RYNG5JTng4SUtC?=
 =?utf-8?B?ZkZhd1VyV2pYeVR6OW1YVGZhODdmZU5USm1naWYyc1N6b1VNZTl1VitjSk1T?=
 =?utf-8?B?dWtjTzVJSXVtZzBoSUNlVW11ek1hUEZiVXlPYVFOWkdjK3ovRXZ3WkNyR0hE?=
 =?utf-8?Q?AwFiLpN+?=
X-Microsoft-Antispam-Message-Info: 45Qnopd8BfMn4alhNOcE/yL4z8xTdMzbl3pIw6uwz667CJOu0EAM0WYBoaHJh2MQgx7kd3LDoawBD3Q44tbk8O+ohC5VIttao+61ME9L2KmjNB68jroDEwGY94N8CiWFeaVtMhXCEU0qHtNLMHv8koH0oWdhQ+DGi0WdutDKs+bMGUCvw+UwcTa6qV62XIRz
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1664;6:ZEIDs/ORpH61y8ZTYHmpB+x8RAWxDq7lMoO10DA7JTPX/OB/nDPEVgxHDiz/LuZUGiQrL1ZFpPpLHVgpWeTEyhjsxgBi7p8i1MWiAw3Bddsh/ebKAMzoPm89OiPE/XZFK8djNgsQ6P/wZ4ae5Z5DMx0JPuDylX+TTdHvQdCHM5/07YF6sGpDIC55ztN9yCDKlNV8ZEtZvykIOqoZUUnUPf6eqv72ld83rCBhrfEF25vn+75BkwRiuDb5VcvJ8pcE93W2b9pVrytJ1dTEZmrupMA/ZTl1oook1KX+1S+s8uvDe/BmpZjAjwWYYBr0IRB8QteFhsBhol/fGP+XQXlVjGv57T7mEPz1lZbR3Bv1neCO/b1EyAGTk7LUPxtkXfaYCEj1bUapkiphDV1uQGuvcjVckcxWKFxRMN4snp214JHOxUCWG4RULpCWUekz+QdfKvJkSEigTxcBU0HrNJ13bQ==;5:WMPVHSiwe2D/xjjgxCfVbDLLT1DhJe/j3CTjFavLPAnPbW9JKISWVjjlJcYd/3wcDD8B+pGGSxWQzFWKGLloAP8GFzpALOsuEzJBLcSZ2TcQRN65St4HcFBAuV5O/tOahQb3iSpF4wsxg3esH74nyJL//oxSqMdnBns7++tz6AQ=;24:1VmEm08lzXM1CFfwQRkNLov7k4CIPdwWOhkf6KIqq86rQWp3yVHsPTR6oLU31t/joS25jWjKCosNIgJA/y8ka8+9hp80VB27oLSjOGNaGgs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1664;7:6J9XC17wLo3ugGUkrOTRhoLDHc7+mHDjeoM/ROuDPYKkILZiUDBbTov7z96Jc72H2WhmgTwaB+OjRwGBv9MD0QKz7NfbA1kxuLU+SmWSgkY0bJR/NewxKvOjvubl3SKkCs9xRfovX3hC7qqTakE+w/gPbJ86qmz0BHViB/bPqKGeOg7/ihQx+EDBAgDRNti9IYoENnn6TnEjEoEHkg2m4uzHbqU++jApxvYyJzNukh8G21IDyjyLuKgCU5dWq1uS
X-MS-Office365-Filtering-Correlation-Id: 481f7404-e715-40ae-3913-08d5b73c7349
X-OriginatorOrg: aquantia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 12:40:58.5235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481f7404-e715-40ae-3913-08d5b73c7349
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 83e2e134-991c-4ede-8ced-34d47e38e6b1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1664
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Fixes: a09bd81b5413 ("net: aquantia: Limit number of vectors to actually allocated irqs")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> This doesn't apply to net-next.
> 

Colin, believe thats because you should target to net, not net-next.

BR, Igor
