Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeB0UJN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:09:13 -0500
Received: from mail-ve1eur01on0071.outbound.protection.outlook.com ([104.47.1.71]:18559
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751533AbeB0UJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:09:11 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Julien.Grall@arm.com;
Cc: nd@arm.com, Juergen Gross <jgross@suse.com>,
        Andrii Anisov <andrii_anisov@epam.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jbeulich@suse.com
Subject: Re: [Xen-devel] [PATCH] xen: use hvc console for dom0
To: Stefano Stabellini <sstabellini@kernel.org>
References: <20180226110822.13787-1-jgross@suse.com>
 <0d8bdda5-faef-41da-344a-644b5c3d6006@epam.com>
 <58e94cc9-9b09-d6b7-3122-fb4c83e97926@suse.com>
 <b57092b4-e740-e1f8-3885-a817bb7d4e70@arm.com>
 <alpine.DEB.2.10.1802271159070.4239@sstabellini-ThinkPad-X260>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <19afb9f9-a845-e627-8f78-d1fdb349c6bd@arm.com>
Date: Tue, 27 Feb 2018 20:09:05 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1802271159070.4239@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [82.1.229.77]
X-ClientProxiedBy: DB6PR02CA0019.eurprd02.prod.outlook.com
 (2603:10a6:6:15::32) To VI1PR0801MB2063.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8355320-17bf-48d2-0a2a-08d57e1df5d4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0801MB2063;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2063;3:iCwBoXYiRonY1tIvxonzRf/j8uCa1QNJjBz2BUIdijQ2tQkUNjlzJ8QjyAt0eQ2ETCG+C+6we8zzILCuJYaZk/UOmcnXBQMGgYCJMObrLg1ot5dElpU4dFKK1hxvI2Lh6dFaco9OFWa7fEOHqfmXQWMhySduUtJ0A6SK1f7EHGu2l4eArnVNQnjdb7WlDY4azG3/INp7jpcU78IMejC4OqTQ/jq8fnli/GRWcjfZmW5S/aK5o2XeCP4WN/XbS5yx;25:DhKtTmPHVPgJLnnnpwzRSSpnjbrSlz32VqsuTu0lIHZ6BoLXVjqduf123NHkIkwtI+4wvXRuQmaJNSqfoIvbtH0MUixj5Wn1sSeDLJ59CZX8pNFSNSvX8DmEbQUonjNrfPz+F+WBxcmgToOa/hknzIdRgDlpzy7hbCH47Fghue660C1Zz+m0ucc2zlyBe6qbl5BFBpZ4uwd6T+kMyZff0LY70/Y9rF/EhvII0ErYRAzWH/ZxJ3smFVgvBHw88b2sXxX4olsq1vyXW59MLlZEfFjh8brhCHK6k9HiPEj/iCAo06Tyj5SoMB6j4yTkEHpzw653Pds+0vMFVs2qs6T4Fw==;31:QpzeWiVpVHh5ml+B74IGs41tM92SW4yftoCMYGa4kpcZ2taTv9ubb6F9LdXchAyYuhxZcFBx+R6TuODx0cUHKcfynoTpLxEj5CtrGE95imYKNQwe6fdPm7eWIAf5Kxb1ztQdyPIYSJ2AVPKhbAIme66jOVWEc6S3AY5yQ+Vq7L8YZXjFU4u5gjIbfvgoz11qUTRGL2TAgkaFLe/X/J2kPuraajUPr6lHJeaYxFxn1yU=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2063:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2063;20:YBzpMbsrOPnhhR1LnZzI28gzgNq1E/fFxggYAhSkN5tiFooPWyNR1u0DEppohpLfaRLuycBf2clpghayliSJBTvYILOGya7vwUMCFol1KMTzDm0rjXVcU30cpqTUiZRR7vzQX6wBtIIa7JErZ1XXSVJpoEdN3pwNZe9cFry+3Pc=;4:u4M/3SmRxVbIgwO71YlpJcx8/Pd99Xb2nt2jhUWZrw4YMMhkOcO/83y/3Ar/o7H4PGzvYXHyn2AoJqHFCXeS41pqdKQ5CAScw+gVYnBE4K+gP45Tc2zcL1g1I5moEEs9DPNYLRoSjPZS6Vfa58ZZhpQPoHVm5BWxVTRLZGhyqFAsULYug3bcR8omXqlu8dY6ZIskTcBPC8scHBo74b7FNpNVxuwbJv7+uNgxHLspdCgUR1UtcKfrrbl5643RujniMWNmsIl955mhIEohagswTw==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2063A806958B1742AFCDB26F80C00@VI1PR0801MB2063.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501161)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0801MB2063;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2063;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(39380400002)(52314003)(189003)(199004)(51444003)(93886005)(229853002)(66066001)(54906003)(72206003)(64126003)(25786009)(86362001)(65956001)(4326008)(6916009)(65806001)(67846002)(58126008)(316002)(59450400001)(6246003)(7736002)(31696002)(3846002)(2950100002)(65826007)(53936002)(105586002)(31686004)(6116002)(305945005)(386003)(76176011)(6506007)(2870700001)(106356001)(26005)(36756003)(8676002)(81156014)(2906002)(81166006)(16526019)(6512007)(68736007)(53546011)(97736004)(186003)(478600001)(23676004)(8936002)(6486002)(47776003)(5660300001)(52146003)(2486003)(50466002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB2063;H:Juliens-MacBook-Pro.local;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwNjM7MjM6VUk2dm5JSDdNMkdYNXNyMG52NVRldEJz?=
 =?utf-8?B?eDZtVUoxV1BrWnZHNFdGZjk2VDRlRGxqcE44TFJ5WXdnYUtidUVWSGF3N1hy?=
 =?utf-8?B?Y040L2l2OTBkUndjZzB2S0FOMmxtekl4MndVQ3BKOUtRdFJMYXQxWHV4NVdS?=
 =?utf-8?B?ai9MVFNxSlNIQStGZmhVZ0J6UlhnS0ZpY0owVDBhYUY1bEZETmo4V0FwNGg5?=
 =?utf-8?B?c0JPRndmYzRod2ZtNG9MUjUvK05GVURxTWo5SkVRS0p1RmtEdW9VUnhKQUhM?=
 =?utf-8?B?ZDRRZUJ0dktaZ05ObjJBdmVacmtDbDA4b0VZbWVXeEpXcXJ1MDBUTXFEZHNE?=
 =?utf-8?B?WHN6N0VlTjlPa3E4R0xYdHRTcG8za3lhQk83VUpoYlhEQkF0d0RNMHh4NlZi?=
 =?utf-8?B?OC9Fb3ZjQjcwanNOQUttT2d6YUUvWnVuUEtoN1RhUzFadXh6M3RkZWsybVNW?=
 =?utf-8?B?WEtBdWVjd1E2bnFsbFppZWpteFRvalVBODk2TngyYS9RL3d0OG9NQ3hIZGhj?=
 =?utf-8?B?TUYzSXlEN0t3TTlCeHl2ZkVPNjhyNjV3ekFtbG04K3hHMWd0TUo0ZXJVaFhX?=
 =?utf-8?B?aEkrWEM4TEVTZUV3QzFWVWZxVDgyR05jUHVGRno0akcrcnQwVDlMUnFGUWpW?=
 =?utf-8?B?SG5HZzNmcE9MODQ3Q1U5dWljTkxCejJrdGxGb2gwbGZrd21UcVFPcWJzOHk1?=
 =?utf-8?B?T0FzbC96dTB1UHZJU2Y3SEZnSjJqeitPektrR2N3Q1lxOEZlTVlOUzYyaEc3?=
 =?utf-8?B?SnltWWVsWXl2UGdKYnBOSFVOdWJ1a0pUSVJqVDFLZy9adFZINWs0Y054NTNx?=
 =?utf-8?B?U1NKUGhCbGNIVWZyL2hsZmVQZVBHYzFCR1lvNUwzN0VJMjlQQVNYNlNXbEx2?=
 =?utf-8?B?V0pWNW5RVE1Uc1FOalVnVEJHQUhDQ2Z2MWlYSlBLVHg1SkFDc3poVzRyaXIx?=
 =?utf-8?B?SnlpdnVzUGFVRjh6eDUwYTljR1Q0MEtXajB6K2FtSkZsd0FVa2V1a1kraXgy?=
 =?utf-8?B?K21MNThURS9IaVd5RXVmcC9aM2d3UVh3czgxRlQ3OWRabTJPZDY4NUkxVnVW?=
 =?utf-8?B?ZXgwaTdneWJIRW9RaldXLzZPcCtwQmdjYVJRVmZxdkc0UStFTzVBTEFyWUg0?=
 =?utf-8?B?REFUWlVHVmZXTVhoT3h4MkdWSTRXWWpEV3MrSXhXM3M1UjJpbmhYcndzVE1D?=
 =?utf-8?B?QytaMEE3cStkSXdITHVyNWl4K1VIT0tVUjl6ZUUzeEF2bzZZaWNTUEdpS1NI?=
 =?utf-8?B?bXBSQjRrZlBLZllScU9WSjVPMDV5RzNTUkV2VHI1ZEU1ZG9PU05xU2k2U0FC?=
 =?utf-8?B?M25nN0M5NS9HK0lQTWIxbXhKMER1cHVBN29oTXJ6bDBKMmtkemFjd0w2WmZ5?=
 =?utf-8?B?ZkZ5YTlzZUhCQXZzVVhKcXZVQ0hPUjlOUFhyN1I2M3hTa3UzVTRKai93K0dE?=
 =?utf-8?B?UXVUTkROQTJkOWpRcWpNVi9iZmtNTGRzL2dhWmJ5M1lSZTdic29WcWdpNUp3?=
 =?utf-8?B?TUZTMnpJTFdWOVdnNEZQZzhrYjNLQUV0cDBpKzBvNlFRcUJESWJSd3lLZHNa?=
 =?utf-8?B?dU5lcWJDU1A1ZklqMXd2YVZVVTdDTHFMVmVsYy9lTGNtN1lnZWJkaWdtNE4x?=
 =?utf-8?B?M283Mm9SVm1vM0Ixb1Q5dnB6Qk1BVFNRUEk4VkdwM2FDV2xMTE4xSC83RnJL?=
 =?utf-8?B?UFVsWWVXKy9HSEVnclozL1Z2eTVBbElGeWJyalk0K3hxcHZnMFBUR2VXUXk5?=
 =?utf-8?B?Qm9PWHNsejVlYjRHMFkxK1pCem5mSHpXbXYvanhLTFpYRURYSmppNGhpZkx0?=
 =?utf-8?B?WTZVb21KeEMzMmhoM0RPU1pPRmNaeCt5RGFVZ1BYQUdNNEJzekJuV0VqVEo2?=
 =?utf-8?B?SitwTDlEL0dLZlNNaGpmS2QrZ2ZKOWpqZXFzUWRuVkdmSE9vRlNxUk5SV2s0?=
 =?utf-8?B?KzNweldmMzllOVdwVGk1UDFEelBDR0xwYWJWSWNQK2dWMlk2SnpXcW9WVVN6?=
 =?utf-8?Q?8tJFtlUu?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2063;6:MGvodY3UGiDsKDHIOwq3R8S1ytu2Z0lO5fwDhE3cBHVPFV5UxHVJtiiOFc57F7qbDFylsqt2btFPY0L/NogynSoBNXU+qBWla54/yC1/59duKpUY9AhL46Th98FBn5Yf95E6FVTdqiR3ZbfYuXgsP4/5XTiz410MW9olo4prCnR2Wiq55+pkvwv+pFsAu+WWTM1Fxt6JuXC0UWzhp6KT+h1U6XreybGfIAFNnQWCFBjhSMVgvnuGXYuW0swGVD56UJSd+DOERNQw/ZZlnpeuZYmKqbQgf+i/BTe2jm9kCTAev2vsQWllb7KTZAP/cDeQPebv4VUu+9tK4Gl92P2regblGElR2JdKXijyNtweuMU=;5:A36FTqFTBudzjZojGpdcrozKlq9HUVAUYfo7fKLhqavPDn1vRXx8x/e4ZTmRnhjXfZP4WS7xE7oOYUqV/3/Jm2y2WbuRNAqzhT4qTYElxEU82KBU0JdBwvqwtJ5mNR8xEiU6bKTYYlfG2zKKsg/mIbxXKdnC2uM3s5rA9gfXQzU=;24:ul18+e5k/cSjvhiMJTH435RWNdHrMkPECSlOMGtTVObrd0iLq5hSJaavX3ABKKKqAhrVH9BJR7GeBEbVws93ZcM64IyK3wFspoRRwOJYVsI=;7:VoeLGhXXEF7+OKjnIFxTzVi1NcjvtU/vHR9tWolHgSZ5QGDid6mF1UkkR5//wmtroensaHZ8oVl+V+iOicDeqfxYCidZTHrJsTTnXwpu94aMQDnv7w3Yfrf/klH5y9uX40YCWCmMgq6ofHgEnyjF/Ih+Y0hxS1TMaORuwTKE6El9yCOOqnDjFJeJcrEPoggwBEg3ROM3KrqDPhv2AGcY70qI9of49cCmtf7kkOQO+kSvUDn5nFpXcaIfQOJlogdv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 20:09:07.9539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8355320-17bf-48d2-0a2a-08d57e1df5d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2063
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/02/2018 20:03, Stefano Stabellini wrote:
> On Tue, 27 Feb 2018, Julien Grall wrote:
>> Hi,
>>
>> On 26/02/18 12:32, Juergen Gross wrote:
>>> On 26/02/18 13:06, Andrii Anisov wrote:
>>>> Hello Juergen,
>>>>
>>>>
>>>> On 26.02.18 13:08, Juergen Gross wrote:
>>>>> Today the hvc console is added as a preferred console for pv domUs
>>>>> only. As this requires a boot parameter for getting dom0 messages per
>>>>> default add it for dom0, too.
>>>>>
>>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>>> ---
>>>>>     arch/x86/xen/enlighten_pv.c | 4 +++-
>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>>>> Is this something x86 specific? Could it be a generic approach?
>>>
>>> In case ARM wants something similar I guess the test for
>>> xen_initial_domain() should be dropped in xen_early_init().
>> I am pretty sure we discussed to remove !xen_initial_domain() for Arm in the
>> past. But I don't remember why the patch was not sent to remove it.
>>
>> Anyway, I guess this should be fine to have hvc as a preferred console for the
>> initial domain as well.
> 
> Usually, Dom0 has access to several physical UARTs and/or VGA, making
> this patch less obviously desirable. I think that for Dom0 the best
> behavior would be to add "hvc0" as first console rather than last
> console, so that if the user specified something else, this call won't
> interfere with it.

Well, that's exactly the goal of add_preferred_console. It will use hvc0 
unless specified otherwise by the user on the command line.

Cheers,

-- 
Julien Grall
