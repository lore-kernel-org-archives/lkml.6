Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeDXQva (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:51:30 -0400
Received: from mail-sn1nam02on0073.outbound.protection.outlook.com ([104.47.36.73]:64539
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751592AbeDXQvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:51:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 1/3] signals: Allow generation of SIGKILL to exiting task.
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        David.Panariti@amd.com, oleg@redhat.com, akpm@linux-foundation.org
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-2-git-send-email-andrey.grodzovsky@amd.com>
 <87y3hca73s.fsf@xmission.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <e371e586-0859-adb0-6666-d40a909d0b22@amd.com>
Date: Tue, 24 Apr 2018 12:51:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <87y3hca73s.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3ce0:41b::4]
X-ClientProxiedBy: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To MWHPR1201MB0126.namprd12.prod.outlook.com
 (2603:10b6:301:55::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0126;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;3:qHksISvrhvwEgoSehki78rBhZzAV0ndPlhlm+uiHxw2wI7ACFFcqPq0g+AmZHcMpvHFGYLbtf6ZJP+L4PLu4i4V6H0tYLhDmaXudSUmgZdX693W/cMd482qjFaVXUROHK0RyLN/lveyj02MJHr0Zq6e+Mtvp8+pZKKn2KN4tPYGDoENMpOGoU1jfpeJnDDBefJV6ZsU+X32gUooSDbUNWbByoeoMU/Uy6c905HhCroU6PusWGCK6LYFflAT5KtdS;25:rSOnSSFyrXGu5pYiDpD1+TfEs6B/+H5V/AHl1SmfIPA5vDoWAc5kmCECSLJKKytc1YmRTCzR/4fmB2esdLlhNAntQfyPzPFjRUWXGvRCEgxdS56SR/HCm9Q9wa/UT+fniSxX3Bfnh1ePo1U03tBZp5r1MVU+qD6QVAum9VSXLY5sXxXVomX3CWeT1DVge0xv/vnCcdSQ7N/fd7MVGq3i+QoJR/SOQUoamZpbPYbnNIUGSBomUY5+XLsyVtMSoblsaaqg9FJvj7LUevhj5zT1D6ssT/ibq0tqMl0oJfX5NH+94d+jrEnpozbKh8tqZpsXTkaC0w2Nx7QL+8UHz2d66g==;31:yp/abzMLgCuZgl07tDxRV+FcBCVQFc5v5POWxZc4ge1J9/48f8deaexIdhCTH4ZfaNpvSVdL6fA3pqjJlwTJYJZv68ZldtiesgcO7iURtwIt/lVtuKAVIKaFrd7718koqjPiAzExNjR9sPjbJFuzV/gua68YFC9wxnXcLtGbDm1JMq1GwxFvgdNukSb3ogf0bHaMlWEH/p5SW4eMEgqZNWrz/LmRt4GhOlcFpzt7sy8=
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0126:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;20:05AQWJzIPnm4t74Giqh2rSH3lFfD3yafbSDvv+r4Zi5jZj6KEex4ATZ6I6HRIUF6wRZP2rap9Lma86dCfgwcMgQMKrUW9niQTgDhhttNcUodcfZLQ28Zbr0+VHRCQeTUcZ2VSDqFQhKIeuMLC69/UQMCGpxwylCcm0X2OI3IiQ0inMfBuBr0vAT76NmM/GwPLB+PiKeaaG/2hA6laSrstngUOYQvHjLmwhb7cT7DGD4mPk454IWWORob1WdThWWIN8H68M8we6cBFyvVrrG1EHL0DqRijOhl8QSXLse1nZT3o5YLb298J0lEUnFGjyl215U+/yGW4jk6pNd6kuwn5ukPzNZt5tahwOEeRpeSXma8jqvkvwdQuKyqzop6uDiTaKVMMXYlQ+RYWQtdUCEtmmMA7adwpCIxDYOBS9u8rY5lx96EBUhPSOVCvoDWSQDlSwBAEoXchoKWizfKWccqsbf3vV+Buf3ONmatHK0vTLqCclgINghMSGyH3IL0M5ZK;4:M1Uxtr/Yryl4sf0C29bIUjZ8gR9OjE47fJ+cvKQiu45IMScrEYcR4eK4Yq1+6/b6ZqjKQ9Cfn+ZXNFn7R25Yu70T+ohavwFSEKE3C6N5yeBTacSEBhGm1SGvq7S07Z8DeQY1Uir4RK1g+za2Z3ulYgqRTZwhUR/UuwmdOMLpCyiQ8HyZqssfRQsLxQDUe9iVZYpEnaRRChvj0+szAE4RcOV6ALu8C2wUUEqGzuvdiDxNASYmNyz+JiarBaVqtOr5EVPkVuC2cyBHzWNwVI8sYtRKFRpvyDJNDcUK7WS22wiQXvpmytXEY8vkisGvy9sk
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01263B04B9B8503E303B27C8EA880@MWHPR1201MB0126.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR1201MB0126;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0126;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(376002)(346002)(396003)(189003)(199004)(59450400001)(106356001)(105586002)(305945005)(31696002)(81166006)(81156014)(76176011)(386003)(52116002)(31686004)(53546011)(6486002)(1706002)(5660300001)(86362001)(229853002)(65826007)(36756003)(186003)(23676004)(2486003)(52146003)(8676002)(8936002)(52396003)(68736007)(230700001)(53936002)(16526019)(72206003)(2616005)(11346002)(446003)(476003)(25786009)(486006)(4326008)(478600001)(6246003)(64126003)(316002)(58126008)(50466002)(6916009)(47776003)(6116002)(65806001)(65956001)(46003)(97736004)(6666003)(67846002)(7736002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0126;H:[IPv6:2607:fea8:3ce0:41b::4];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyMDFNQjAxMjY7MjM6YjcyNXpOZk5YaDZNOVczano5YkN2Rmw0?=
 =?utf-8?B?QkRrMGc0Tm5PVytMQWhpck5YdlNWam96clllbHE5UDJRemZNL2pmZWo0NEpq?=
 =?utf-8?B?cEFJM0R1amY3M0VBSi9jeUg4VjAwU3gwNXFYN1l1MzJrU1J5ZlFLREhVWXVh?=
 =?utf-8?B?Mm5hY0NjQlNMZG5hSXU1UU8zSTlTUHdIcVRrR2tiSkhyTTdUb3BHeHEzdWp4?=
 =?utf-8?B?Y1NQYWdVSEtNa0xSWkxhR3pLdkZWdmRSK1pDNWFQTGk0VVJscFdocDBkdXdV?=
 =?utf-8?B?a2d0Vjh5Y1NXenlZV3ZhRnZkYWVpK2pvWXVwVkwyWkV4VWRBUEtabHpBcDlP?=
 =?utf-8?B?blYrRjZhcW1RZk16WVpJaEtpdjdjNTA3UDZKVGdWWGpDbXhUeC9GamxRditT?=
 =?utf-8?B?MEJqU3hCTWd3MmtUZmJHSUZieWxFTVRuVmxvTTdXZ0VSRFVxSm1qUkE4dUpW?=
 =?utf-8?B?WWlFUGxaZ3p4QVBOYVIxSUFVRktxNlkrOE53eUJYaGdDMVlaeXhwbHR0THVi?=
 =?utf-8?B?Ykpad0EwY3dTRWNvM3pOQ1FnQnNPUVNaWkI2K3BqS1ZhWEJzcTR4bzdQVnQw?=
 =?utf-8?B?S2dvbTdGMXZwYjhoYllXdzI0TVFKNk9YbnZ0WW9YanBOTm4rN2kxeHo0Z09X?=
 =?utf-8?B?TkVHNE93S2pxM2pmQlBlb0l6MVdxTjJZOTFUUHFCTkYrbzFyZGxsV1N6U0N1?=
 =?utf-8?B?cXhrZ2IyNlEzTmZ3aEc5L25hZUFEeXRWZXBPcG5nNVpzNHF3TkFERnM1Rks5?=
 =?utf-8?B?YVZmcGxpMGZOWmhnanVRcXczZ0hnd2tQMDFHYjBsNyszWndnZDYvMTJnSk9s?=
 =?utf-8?B?cGJLaVFvVVlRL1pnVDdWMzUwcXc5OUJSU0VGZUtZME9jRmFwK3grWTRwU2VM?=
 =?utf-8?B?K3ptZ0VtM05vc3ZJSVM2cWIwcXl1em1ZajhGREdrY1BubTlLKzhsdTBKQUlM?=
 =?utf-8?B?RGxUZjdzbGY3MkpUTDBZZXZxcW9NYnVvN0p0QzFxNlo1ZTc3cnRhWkRoVmtL?=
 =?utf-8?B?U0ZpaTlDK3BDSjlxcGNBbFBZMzZWU0plUGErU0d0L0tBRjkvWWh3bEUvTXY3?=
 =?utf-8?B?czlHbldib0h6YnI1VFBoSU1sYjRXY3NGcVZrVEJ0OEhHamNtdnFRM1Z6VG1G?=
 =?utf-8?B?K293Rjl1OVdkV3pnZ2RORy9RYXpFdEs4Vy94YUR4d0JSN2FhMS83Q2tDZHRx?=
 =?utf-8?B?RmF4VVlWVGdGRlpWbnZsN2owSmxVd1EyNVA5akpmN1NpV0FST3pMVUJXZHRB?=
 =?utf-8?B?Q1dzRndRQXlDZ2NLQklBZ2V2SDNDdTI1TXhUUmZrczBnOFIxREVCemZaeTMv?=
 =?utf-8?B?L0FVL2M1VDdrVmVqOUF5bDVhSXgyazY0ckNVVDNBNE5RZFFBWmh4R01JOFpr?=
 =?utf-8?B?d3R0VWlmNEFQZC9nVW1xcjk1cWxKUStYdnVSK1Y4WTh1T0RncGtzL3V4QWlh?=
 =?utf-8?B?dmxYQXR6R0NTOHdHbWtCMWp2VDN4eWxUT0kydW5XQ0IxUEIvclpBSUwyc2Jv?=
 =?utf-8?B?bEtQQzJ1M0VkSjMvdXZJMkZmVFNiaytIdnJScDI4VUx6NzRSdUdkNzFOcFBk?=
 =?utf-8?B?SElqUVFUb05qOVdoWUdBa2V0a3E3VzVnVThQVCtNQmxoU2dQQUxWY1N0QTIw?=
 =?utf-8?B?MzQ5Q3Z1NDV5UFFKUWhjemNhUThFcVk1dEsyT2VzRkhSYnhYemdaQTMrZ3U4?=
 =?utf-8?B?K3RKcUhRcmtiaFhaWHJOWXI1RTFycmYyZkFYeXZrMlhjSmVmUnB0YXNvVkNP?=
 =?utf-8?B?dnlMUFJRaFdBeEJrZEw5ZFRDR3hpWXJ0d2o5NTZMeGs2dnpmeWVWbTV6Wmxr?=
 =?utf-8?B?MzVWeStUWUJLSi9mdDlPaG52U3ZzUXRRcXAvaEhCNitWNTVHek0xdUYrVjV6?=
 =?utf-8?Q?0uZxItQ9t6llecK+7UUrlNff35PZfpRe4A?=
X-Microsoft-Antispam-Message-Info: lW2YbsmAlMFYZciYdnp/zLB1xiWsucv4MqkgMnqcKfrrdm3yrH7ahmpH6XrHbiI7/FI6gL3m6naYUmEaTpsN5ec7diMo/0SepITBtaKfUQIvbZlmaVu3Kc0o6B8ALjZTuM0AXWhJbPjPCwOIcpYa7H7yvv7RGN2jZ/sENLxovuoiYcnua0LxTBpWt55Twh26
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;6:ilsARRFSnWHfaOrl3lPfYBT+xXv3q4Jl+lMnTtcSL8S5KH/5N2OH/SwTnYgzBDIj5Ya/jdS1/JB4lcQbyFDoxMsG7f8dzZn1UY66iVb8K4AQIH1i1Bm0GgFvLaJc3p2I8jrMdPRKQVHt/Ffq8ZWPbbI3a4nxFdl6MVON6zwyZ6bZlpRwxrKSlrV6pJIGtcv6/O1d+dhZbdnmb88R05lmgmuwFEwHJ/vwCPqjJ9/eqXxXkmPv4vQcx67NYTVk6wI7X6uMnITuPvRlhSgurHjIhsfGM0S/NkF707xceu06Idfwe2nvotILVeL2EJ85BvffauLK2yyv0EeDijbVuSC4OPOKJBGku3hGTVk8e2f64pyZMYW90RlAVcO2uR1IXCyPH5/p5ScUOjKOZ8w/Pp33+2ZhaSkM5XzgKQ+alZmjIH1K3DxLV1ddOntvm5m6LSnameXz+mO2VY8PKsLGTPxUiQ==;5:SL2Gxly/KxJ3wHvambZh7dBL4m5GoDX77hzaMMiSjcMoLIhLmv4Km8R4A7Xi+zNuUQxdRr2Vb3pljOeAXDBS/5VgMsKQAA6kQgzYAdTT9iQa6fd+n6YEMYn6pdTql3rZ7W1VbdJl7To+oSITjpqCcyivgYkNr/U3++4J7A/scxk=;24:BS/9tCPaVE6h599feWdESVebxoJ1ZTadTsQYXn2GZNRMZRucns+Xm2F18Pa24KC2UcpzJTgLSyZRryzpA3hOIvWsWOEYb8XJ2Fpocueirfw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0126;7:h2JrhHvdDanUNLeY+pOWy5ghbaVCgOCK6+5hp06SnlNj9vlkw5VKtv92S6T17xX1O9m1VCiw/7bs1Hxa9ZVW18I5IvWP84JQUGG+x79FpIj8SUJ9Cy34a4bkRCrOm9zdD0Di9pWnJWI7Itrtn4my55PRJK6oiH9D6d+qECKk5jeo414XlO8yykiimQMAqgU4sBZwIC/8vgaZiaRp0OUaZrYNQfBDcAUqazT3VVoE5Bq0HpcKZWaKP0ddNa2KCssE;20:0eYCJudL+6L4l6oQjNDDPFLMXniN81CWnqCHQZDRpHLyMUjiq9Q3+vA33XNcuUH5JSc6+BEc2C1wMpMJQJ6yNJNDp9QZnQrstbXrTpu+Rgtb+aw9BnCFnqQn0CT4V76a/DFcygaXoClG91rmlgQYNVkAFuGJfq47dMXY8OT827+DAn3uP0HONr2/tAuTZPxPM17YQouCgT22b5m9vzRCT2V6wzsvIpoWWF9Vwh7ALKVG/iwyqvRhRW8xPexhb20l
X-MS-Office365-Filtering-Correlation-Id: 115c33ba-246f-4a0e-c8f5-08d5aa039a5b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 16:51:18.5998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115c33ba-246f-4a0e-c8f5-08d5aa039a5b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0126
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 12:42 PM, Eric W. Biederman wrote:
> Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:
>
>> Currently calling wait_event_killable as part of exiting process
>> will stall forever since SIGKILL generation is suppresed by PF_EXITING.
>>
>> In our partilaur case AMDGPU driver wants to flush all GPU jobs in
>> flight before shutting down. But if some job hangs the pipe we still want to
>> be able to kill it and avoid a process in D state.
> I should clarify.  This absolutely can not be done.
> PF_EXITING is set just before a task starts tearing down it's signal
> handling.
>
> So delivering any signal, or otherwise depending on signal handling
> after PF_EXITING is set can not be done.  That abstraction is gone.

I see, so you suggest it's the driver responsibility to avoid creating 
such code path that ends up
calling wait_event_killable from exit call stack (PF_EXITING == 1) ?

Andrey

>
> Eric
>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   kernel/signal.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index c6e4c83..c49c706 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -886,10 +886,10 @@ static inline int wants_signal(int sig, struct task_struct *p)
>>   {
>>   	if (sigismember(&p->blocked, sig))
>>   		return 0;
>> -	if (p->flags & PF_EXITING)
>> -		return 0;
>>   	if (sig == SIGKILL)
>>   		return 1;
>> +	if (p->flags & PF_EXITING)
>> +		return 0;
>>   	if (task_is_stopped_or_traced(p))
>>   		return 0;
>>   	return task_curr(p) || !signal_pending(p);
