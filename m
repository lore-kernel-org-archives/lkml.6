Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeCMS0E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:26:04 -0400
Received: from mail-eopbgr50105.outbound.protection.outlook.com ([40.107.5.105]:11664
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751660AbeCMS0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:26:02 -0400
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nokia.com;
X-HPESVCS-Source-Ip: 10.151.73.41
Subject: Re: [PATCH v4 2/2] ARM: ftrace: Add MODULE_PLTS support
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
 <20180313135314.18780-3-alexander.sverdlin@nokia.com>
 <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
 <5d3ae760-45bd-3588-500f-1b352e1722de@nokia.com>
 <CAKv+Gu-Z58VseyCQBe_3KqgKn4s9dNBxR8wGyZ7JFrLB=EX8jw@mail.gmail.com>
 <60156300-b74a-628c-d296-7fb71a0eeb4f@nokia.com>
 <CAKv+Gu9G9UNf_jif4ySw9iM9mYW_LNzKXyVv7mEAQP_Laaq3UA@mail.gmail.com>
 <ec84d8ee-8b90-5365-5be4-4b08d274c6e5@nokia.com>
 <CAKv+Gu8WeV+7U4omoMvECPa0LhF4Nrusvy+V0mirWVfejCebNg@mail.gmail.com>
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <a6a2afaa-566e-8376-7999-410c886211c6@nokia.com>
Date: Tue, 13 Mar 2018 19:24:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8WeV+7U4omoMvECPa0LhF4Nrusvy+V0mirWVfejCebNg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(93886005)(81166006)(8676002)(106466001)(81156014)(8936002)(22756006)(186003)(53546011)(31696002)(77096007)(68736007)(64126003)(230700001)(50466002)(26005)(4326008)(36756003)(53936002)(6306002)(6246003)(26826003)(356003)(966005)(5660300001)(305945005)(65956001)(65806001)(2950100002)(6916009)(229853002)(97736004)(31686004)(478600001)(65826007)(58126008)(2906002)(316002)(336012)(47776003)(23676004)(2486003)(54906003)(86362001)(76176011)(106002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM3PR07MB1121;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT036;1:+x1fcnZpAp8xea40lTVAjOt50kIJCbbOelcgYGa9PyIm7zNe/k26KLsK7BwghSV2r0dtLgYBDIxWW3KlolKMD1pPHaAol+dMFS7ojAbOdtKk0eum6/BEMtk9nx1y7QhL
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70a0de3d-bb1f-4e73-c844-08d5890fde43
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328);SRVR:AM3PR07MB1121;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB1121;3:d4J9d1W6RWLKc9dcEn8Xw6QHjXOoKvXF1CQw9AGtzXjkGC5S+kfMng/lQfq1wJ0/66/apsmgvPETSgj70pHUlabdInn7phMMNEGOgkbe92uRwb0IhsBCMFwqrCV6CmwOIUTYVPWfWQMxrSbw2siYNHNNpUIedZX9zDyoxCrtihNiD9CM1FG4L/xELlGYyesqLZoPULrjwS4ogyHiXoHkqfG4TihdGjqx4aTCFsrhVzpWwGDLBDb4lNPnQ+K5Ct1EpjS4Y4bCfLzNY8z5bX4U4LNm5n4tEbWc7Z9+9AHEs/41pdeC0+PbG2QQ8nfeXkW7QmJ4T7SSjjDQL8m7MpyEB9r2gY7Bc24YpBVz3FZ/WgU=;25:Q9UbnonJyajqYUQCoDqQw+lOZQVGuPdGMUsRwCdZ0inxaY1HCbG8hYsHZ+sTflYi0W0Gj238eSndZGTB233mvN+h8iyCQbFO3vuxCjsquZDHmMEzQabqTIVkrHqd+hgK1iXXE8ZUYkvwS7hy9qlV+DogmcR5HFhNci0CW9b9j94cEG0Ney/WaZ3wfI+IiJy2XJRyOjGGkO5C4JdH69pdKUtTEVK0Tl92XrLom2VFvkmqKZ5fpx0bQWOlCiuNMq8VdWWmhmoxTGDKz5n9soqwbE4zzU9jWsHvcdJang6jghCKNExzcqf3/ZbEvBRu269lPfm1J8suyENVQjy0abpb1A==
X-MS-TrafficTypeDiagnostic: AM3PR07MB1121:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB1121;31:wkvvupG3iBIvnpkqgfIyY2OmLydmXAZZM0bMvFqqStKZ7fA+c/AgGPsQkuogwkYxD9WinL4sxcjXeOsgW7C06qsDUFG4yMiXRkOy4W3aRbYbANT0TjZVwPtXreLgVqcF2idn0jWD7pJciWhMAsTWFOVkw/86icMMMEb8G8dNxnCwieWHgplNNapwjUdpCGXRZgOxXRO7CPcSVTSH5FdslONa6KZuUxv1w+O47QTkPC8=;20:HJg/GYDyvPOoV3KptbKlq6TSZ3dXT7XgUpcYoAjFWwKkAd86k0xGm2YNV9A4NO9NweP2gg3L31dPjHB1JDcfYL5wZVmQsuIxSj2c6ornZpzs4a5l/1pesQR+WukcdTYE9MUzZdETxz/BAVZ2oZTISwC59Pxqh3K5HeiK74aIkbbs2n5ySzSuOjNI3p1BZVlyKGDazSRnIlkj3vlVderl6gt+MyHP/+7Hnq0++kxEjZ6wQOZpiZmwE5dGBpTfCQYkXfx0RgmNH+xQQtrI22vsJ8k2wka1w/KBlvRCAPlAjMGh7Zf40/4rsuPHDYddfM1dNOaLW2BbQzA890IoXJCd6+9xK+u/D41nYE5oXhUY2fF9oxA1LA9ntIIGpryvNwEccxdA6lbqSZYgaioBFe8Ssk70jUN4l6MgU4N7BSna54IeqcAftxTZyFbnhdTDqwwhkCK3Dz8WhqYewEcGt4JPaJXAaa/vwldD2+IchE24CR4y88OhxzakzuazpVNYPJ9kltnomEzS9dGwPk9X/MbxRYQBXnfqY7zIYT/60l0jFh4p+9LOxLzxb3orOU1eeckXmjooGpNCRAWv3SgDjQg8ul8UmleMeg6XDkEG+3yPmE8=
X-Microsoft-Antispam-PRVS: <AM3PR07MB1121EB748932D393CE6FDF2788D20@AM3PR07MB1121.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(11241501184)(806099)(944501244)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR07MB1121;BCL:0;PCL:0;RULEID:;SRVR:AM3PR07MB1121;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB1121;4:FlEgII+6zv8uwUKfFv2h292hsoR2PDPunJjK75jBs0CRx0NES0gUPTpBMBdZQcfKMflrX1ZZ/W6EJgbuHJxbxxBKZhnAcIgaOolMqgCiFTaw2yt/pMpJud3K9VrHjJyImetSoISoiIk2Uo0L6t5QWWjd50pp081ds3mVvF155z6pBmcIPSrh9i+YKPb4R/TFnEHsZ7BtT9xn7xPVB7SqcbCegNv22gJtMLRpiOro3fonYgdNGKY1rOyLvzlNoKUZJE+iKAli3bF6NFIEmAUaAhf9Z110Gw6vg0xuQL+wiulueWf4QT65cQr60l73lHTl
X-Forefront-PRVS: 0610D16BBE
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTNQUjA3TUIxMTIxOzIzOktrdGVIR0RuZUdpWmlmYUtyMzZSSUhTamlJ?=
 =?utf-8?B?WkVHMzM2UEFoSklGajlCbGQyY1pBbkwrUWl1Q0tNQzNDRVNqY3hxV1J4a2ZX?=
 =?utf-8?B?V2ZSOUlHeEU2UjVjR0lsZisxRS9lZ2c4SW43OXdTYWE2YXBHUXZTclpaZEJv?=
 =?utf-8?B?NzNNejhoaW5tdzNkWjl6MW1nS2luUkJrdFN0dWNKYjh2T3BWeTNscEREVVRi?=
 =?utf-8?B?TG4rdGxYaFNLSGhpTXgwVFl5cW51eFBVcnNsUG40QmhhSytqN2YyYkpVY1cw?=
 =?utf-8?B?QU5reWtlQWRBK3oraXIrSms4TXNOWmV6dnNidmpkTm9XbStEc0VwckZCL3cv?=
 =?utf-8?B?c3FZMmwyTTdoS3ptWkZFbkJ4ajFtTDlPK0RFK0pIOWk2K1ZjM2YzajFyQnBx?=
 =?utf-8?B?VkNOYUdDRTlDeGhDdXRxTFVlNWFsU1pJbmZrazZST29MNkM3SnkzeGtYaEsw?=
 =?utf-8?B?bDlhMnJzcDlCVVdUbWQ0K3NKMTZLcEFZQjExZjZUb2dtOXFuQjJEemQwM3Fi?=
 =?utf-8?B?V3l5UzVBRkpubERqQlV1Q2xybjh4ODdrT3RJMm1vU1RJWmZSS0lnZkh6Z3BW?=
 =?utf-8?B?QmpUM01aOFhzSXVLZEw2TmRmb0tDc3JJYVpELzViaXZRUWpwT3BEaG9QRjVx?=
 =?utf-8?B?K3c4U0RVUHVMczZzbEk2eUM2bDVCbGFHdTRSNjBaUkZyL1Riclh3TG9Jam8y?=
 =?utf-8?B?Q29qM2dSMitSWmZ0TURRb2I0VUNDL20zTjhQYU1CM2M1Vm14aWRCZS9aUEZo?=
 =?utf-8?B?bzJEYzl3dU1SQjZSbEptaXNSeVNPZUlXdmxOUjFaSk1sUTdtaEdhejFSTnRJ?=
 =?utf-8?B?cWVFNlE4VFIvZzhVczlCemFFamp6QnFwcnFycWFMaHo0a2w2V0lRZ2JVaTJO?=
 =?utf-8?B?Tkhzbk53TnZoZXJ1REdLVGVoazVFY2pIUmEwemphN2lvVlczUlZpWWZmWXJi?=
 =?utf-8?B?dG13UGF2ZEhRUVFUcGs3TWRneWFrazZhYXJSVk5TQXQ5V0oyMDg3Zzc1MTNM?=
 =?utf-8?B?VkQrVWFlbUZLWUp0WHZLeGJ0U3BUMWszd3pEeFFqRnlUZWpJamNRMHhyRGpW?=
 =?utf-8?B?NHgyYjAvQ2VVU3ZpZmxKdjI1eGlRNGdzcSszeWx6TDdPQllpNytqV2Yzc2Jr?=
 =?utf-8?B?blhaOTZaRHlZcS9SOGE5KzB3NmNvNVIwSVVLVFVBaWRWaTRFQUxiSEJlaUI4?=
 =?utf-8?B?cTZybHFHakROK1hweXFkdjAxcWhsVHBxZVlrUjh2RGlHQ091TjRuOFJVRkpu?=
 =?utf-8?B?cDM2Y2hvTmpaS1E3UXk0VU5TR1FaZFV6OTFWUVVINEU1TXVleGJFWlF1SDRW?=
 =?utf-8?B?ZTRHL0RQOXRTK3ZIWTRtSEdPTGkxOTV4ZkQvaUo1a1FNZVBoOTRLN1Axbmp1?=
 =?utf-8?B?L2lwbDhxSnF5cUgrSW5JVmoxakRCNnNiZ0JiWXViVmRNN2NVZGFobWRjSmVh?=
 =?utf-8?B?b2hFVmF4WWhiZnlQNVlidnJKR01UdUZLKytWVnZYQVRTQURSclMxTTcyRktv?=
 =?utf-8?B?TmFsQUs1S01JNURIZllCN29zbjN3R1B4MVVCdXVzNnNUTTFCSnNhcTBQUVJx?=
 =?utf-8?B?K3ZnQUwyN2ZVTDV1ZkptU0prRkk5ZnRCcTZRWC9oZ2FCZmtWdGRYYUtzckQy?=
 =?utf-8?B?QTl6SmNNdHNmUzFyQTNaeDA2KzNXaDhFS3B2akFyVUk1Uko5RVFSLzl3YXFv?=
 =?utf-8?Q?2XmBKOyAjciR+ysn9Y=3D?=
X-Microsoft-Antispam-Message-Info: 55kCdNf3M3m2gvxTPqkThKNE5I+bVk9znK8tMz4FR6BfJdT3XX24b34E7ChHYTR89wglvgdbKrnG/6p3dXTE1Tku4saUNlaCyqEbbB4/EihZWijeWh8+RKBiPRI8J8J4LxpP4lbv6gmGmS4huQMfHZ8jvQjOPg8GkSmUYD0xANOIdJqRm2bogupOZ58RdXFguDIZnGsXzn0G3ou0Lb2o6vPIgpW1216noNEY29X1LrKN3hOLiYqsONGJCkXibiGTn319cwWQLBKV/dKz8jDPlUpFYpBGY9/WiXk3GUo7SmC03A5bN4rKTjZzVzy4oglHjI5wCsVljF6QaWIER5yVVZ5l7zNp9/eWNXT6LFtR7TC5PHncjtL4qlO2ZV1tQ/m3
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB1121;6:Aqvfc5OsXqofC79nMq0U0OTxdrVWSOupORV1nv0Lf00hfLHDdrS3T/gxEIVhOr34JU2d1FSRV236Ofn45oJ/7eVTcObJzMXxcbbsPzW5VXnL08Dnr8D2E7jn9svxNs7EGumvEMbMXzPlJiQxuYywMWmDeit0sxwWUzUHMY8IhAbbIM1xZ/4gZlKR2E7oIcCpaSMgioTJPgJ0DgIkIdqR3NgCrqRqD+VIiIbB1K9F971eZSxmrZBqioVR2wZPiLTm6wjubnyj6WZSBM44doM8y7n7FDL2Qa93D7ro05Bz0ROJc4wvWs9aAp6b4mfEHghrYLVwFFdcR1a8pUSNuk429VEUjveT2c8EHelCQsHfDiJQbMc98/zAtMqXLNJVPWfMTbkjyGQiikX10KCoWWhO8w==;5:nHye3DiKtdRkL2sQwX5skk1CnBph8qzn5dt3qGlPcj3mqjptu4gkXScjZtV14RfNIscKbioLOM8MfE6IRBSnuTa7/vIJ7zuCcHZHbRoEIc/0j+9meejD0ZINnTUNIExNtBKL4V9Xl3bkLmPs//qCrNWxM5n/fEv+iXoEhUObRNk=;24:bQEnwsmsmCjoT0zyMF5YuNUbVkfQLr7llMobq1SF9UqsB/l4DOLYSPQ2r7TX4wmneSlCxIbiPyYWFCK3lcjc13QUy+Xe3LEkgJwsGaoGD/k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB1121;7:GcBArAMKt6SWkxkuzJjkGm3hWFEOvuFryba9UPVqLbyzDyjfQ6N0j9mpnSQPbPdhKYFwZRCggODjXKvdHOe90Pe1JvHNg16xG3CHY+dOPjrZ/Nxoo82u6rDf+2rx/v5CDXBU8dbPTauNBbHWBeLesZzUbSuBl7JCETV0+wvOCaPPcI2Z4LvEOjPg/SCXg9Om2e1zjWB6V8eAR4e4/kJ7mBZRBhawXjSWk8pas06M3H2+/J1apifyylGJV0ic5/UJ
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 18:25:58.7104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a0de3d-bb1f-4e73-c844-08d5890fde43
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR07MB1121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 13/03/18 18:51, Ard Biesheuvel wrote:
>>> if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS))
>>>     module_plt_alloc_fixed();
>> Do you consider this a legal C code if without module-plts.o the function would not exist at all?
>> That's too much relying on optimizer I think...
>>
> Yes, we rely on that in many different places in the kernel.

https://www.kernel.org/doc/Documentation/process/coding-style.rst:
"However, this approach still allows the C compiler to see the code
inside the block, and check it for correctness (syntax, types, symbol
references, etc).  Thus, you still have to use an #ifdef if the code inside the
block references symbols that will not exist if the condition is not met."
 
But we can of course ignore it.

-- 
Best regards,
Alexander Sverdlin.
