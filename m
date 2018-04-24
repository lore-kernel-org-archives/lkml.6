Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeDXQi7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:38:59 -0400
Received: from mail-by2nam03on0070.outbound.protection.outlook.com ([104.47.42.70]:10259
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750757AbeDXQi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:38:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover
 from ring hang.
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        David.Panariti@amd.com, oleg@redhat.com, akpm@linux-foundation.org
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
 <8736zkd1jz.fsf@xmission.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <38047e61-6859-14dc-956d-036b26e984e7@amd.com>
Date: Tue, 24 Apr 2018 12:38:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <8736zkd1jz.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3ce0:41b::4]
X-ClientProxiedBy: YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::33) To MWHPR1201MB0127.namprd12.prod.outlook.com
 (2603:10b6:301:55::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0127;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0127;3:DFu+WZYkqW/8KOCJq2wHfHq4iwD5k67dHXA+YtCnbnaHXGNUWgXvO7ggwSKj89uy8lRh2Knkrgynd6X86HvU6UVskzKrQ4fU3ZM6oVJ5LG5c/fcrOJ7FksG9c+oRl4glG4S/jBRcRhHxaRqe5/Scwu675aXz5W8Ck+d8zdQwOxmby9lLjY7O7NQ/EqNDvK7p6MjVCj4Z1dDOybYrAvIg+L/qY1L9zLcXNvwEgeixi2uGHmQfwES8gVZGBaxjqkl7;25:FvvHjt2QLZk6XwaSovRzSmybXytzRJkcDn6ZLRPoY1pF9iWyT0l8uqZHgQYeDQgQfPPMF5X5Avj7beKxG7wgMe+jTPGOk0tap+KPrWseoSnFGe1QV/fxOhUSjxLCsR1TeVK/vfgQjYKopu3cO6MVF8qQsgjbeeHu/IR5pLrQUeFa7uY5e0ubxiowZhOrKcNmxUVqafKG/6zMSqDaRJ4prSjLAdfmh68vo8mLNRtCxrNG24dOCh4osJMEErzUvhg9KisgBHj+p34Wn+NbdrxDvRSVQb5ySbw7mhCbleDE/bjCeBqY71J4PwomD0n4a0yPS9qmkyAHfC39U0Fw46Zq1g==;31:oRDxXURtGWGFTh32LB8ML6o/ZtZ0A/4ewdVubzn/YcQAlW0p+q1PiaVAO6F3H3V+pjEVjYWRhoBx/0jDp4fQzbXEjzoxMrPBAa8bf9RZdR0ohI6ukJusBZmFa3LToSrJtxTSw8rWaeadoXcr/NU7vWMZhDtn6VjnSDFlRbCH96Fef5pdz0aHRDEi+QABRaE0qfKOcteEuk7wvpagHw7aw4GdeCsldaU7cskh4eX8B88=
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0127:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0127;20:R1ug8YNexASXSsqk0f9SkMNQ5GBO4sr8ZTP4dJk9iGdtPwpUR9bh3MIsiyH1lktDs1T+8MWSQkm9jAEYWyxNNGKLYfrtosAdPSumlA7p21xpb/O5pvWHmohmIAq3B39wpga0SHCQ+8bRnSx2suBUh6q8NLRoQIdetUqY4J+jUtuxO2Z0kEcw54VZAt1h/3vqg7YRJvqywK+HAOzTtI54OdgTuolUFTmGvUjiN9dM4z5LNJVNoxygD9W4RFvYe/qB3YFRcPWb+7KR8ZFszAXgkNDij/cpIs1nOPFO5gS+YvxHDDP0RqEvn1cZh0dQQfDSeGyb6m1/Lv/17/EQYMt4YNqUJXZJvVwWRp3JtjutBDViwjQg8yuJe8NkbAv3B69CoJTDcKtrbeMj8seMXzeTSKx5Go80Y9CP3kelD+fEdGxKuyu73PRTmHCk4GK+3tN47BYmuOIjmgoPVLqPcSq/kdycXzymNeYY4gQMy0kfQcNCPMt4NVmeLCjTtu3n946p;4:ATmw+6xkcMJxwGPuZC8ZNYv4ua115pJUzTepADZi4QjPZNAUQm39i2pqP3uriGvYRi7x4NkYu8FvK9IvWDORJsqypciK31pN4NY0SkmYLCmixXXKcrdB5kMht8jw8PjY3wa792FjK1iWX5CDU9wV1yDox/N9Gms1xMc3N0D9LOjzaRpVW435qZSpgr4HQrZNERuXwpAPqIHhm687MhDQmcKn0gibJ09Ozy8rlnTw1vDjnlyl8Ozu/dGKToRQvKVeHTc8HxSXG8y6/nqkOtkuuOmIT1aUgEPzUAjR+lh4U/QM9FmEhtfaFCh6DqwJAFYN
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0127B7B5707C0A72E40944ECEA880@MWHPR1201MB0127.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR1201MB0127;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0127;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(366004)(39380400002)(346002)(199004)(189003)(106356001)(446003)(6666003)(105586002)(2616005)(11346002)(6916009)(6486002)(52146003)(81156014)(486006)(52116002)(229853002)(23676004)(76176011)(81166006)(52396003)(36756003)(8676002)(97736004)(476003)(2486003)(8936002)(67846002)(478600001)(46003)(65806001)(47776003)(25786009)(72206003)(65956001)(50466002)(68736007)(2870700001)(186003)(1706002)(6246003)(86362001)(31686004)(4326008)(53936002)(6116002)(31696002)(2906002)(16526019)(316002)(58126008)(64126003)(5660300001)(59450400001)(65826007)(305945005)(53546011)(7736002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0127;H:[IPv6:2607:fea8:3ce0:41b::4];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyMDFNQjAxMjc7MjM6N3BBb1JySWgvdHdSaE03VkhUQ2Y4QkNX?=
 =?utf-8?B?eDAyaDFrbFRxNVpKSHVJWUdHNlhaK2lvYVlzVFhDdnhOY1cyYmtWNmM3TG1t?=
 =?utf-8?B?N25rMU5WQktmL2FOYmNWV055cC8ycjZBdVNEalBrVk9wTzVESjRHZkYvMEE4?=
 =?utf-8?B?NmtOeldCMStWaDVjelJRcEkrOHVMZTVYK24yd2NnTWo4cmN0cExpZGdXeFZ1?=
 =?utf-8?B?SlBOUWdxMU96Z1Q1Vjk0TzJ0eEhxSkxqcDh1cnJFWEhKSFFKWDdqT2hjQUJa?=
 =?utf-8?B?a0g5bWJvRldRNjRZMjJuU3UwcDB6dVp0N0xIdjE3MFZ6YSttajRDUG5SQUR5?=
 =?utf-8?B?MWNaSm4vbzBoMUd3QzNrZkVUYlJaemw4bkt3YnpGQ2VBSmw2NXdEeFpWQWpF?=
 =?utf-8?B?R21tRDB6aFR6WElaOG9kU1llVmtaMW5lM1Q0eTlFbWNSTEZpRmpmTmlVeWFs?=
 =?utf-8?B?cjhkaWtuSHFjbjdtMXZKTThvcWdBRHhJb0lPVHBBTzBIOEo0cmZadzlmTjZy?=
 =?utf-8?B?Y0pmdWZ2eU94VDFQY1N6clluVW9aa0p3aEQycmRhRDdsK3VTRjNDQjJvWXZI?=
 =?utf-8?B?TWdicmFZRElVR1hYVC9mQWJWaVd0Q2laUDdqUkFYenVhcnB6S0xvQTNib1lI?=
 =?utf-8?B?ZEw1ZzllZDBQeGlRRWF1TitwWDVqbjJkdVFlMmRMSGRtMVdXUDFsbzhwWmZX?=
 =?utf-8?B?TGVSektRRHNTQmdVUHJzazJMOE5TMzg1em9sRDdvdTZCWFd0Y1dtbTFOM1BR?=
 =?utf-8?B?cjhyTU9DV0dxV1BNSk5zbWVGTGVucjlFejY2Z0JwN1lTVHk1MTNVbUdYZ2w3?=
 =?utf-8?B?d2FzZWxZb2xxcklmSGpEY0l5UHV3eUowYXBXZGFiQzdMOEx0eWtBbTd3YlpS?=
 =?utf-8?B?QmFjVjZMeUw5WTZBRGlPMlNsUEZGRG9PcHQ5b3B5UGVsMi9lcm93Q0tFczZ0?=
 =?utf-8?B?SnR4L3hyMU5nU2JOTUMrQTdDbHA3N2pDbGFPKzFUY3hWYmxFU1AxUGhETDhD?=
 =?utf-8?B?OVpjRXZjU3RQWXYyMFF4ZjRPRnU5TlNXWHVEdnFEVEtVTXlmVXY5WktZSm5J?=
 =?utf-8?B?WVVmc2NGN3JiVlJSVEFlc2xqVWNOTHprVHdHYkxqYjVWYmYyWkdFN3JkU1VS?=
 =?utf-8?B?ZktNYXMvNlJZeUh2NjgzM2hpeXJ6bUcvUXQ2bFI1Y0xqVzlpNFRhejdkYXho?=
 =?utf-8?B?a2VJbjdPeWJuZVJJZERRZ1k3M2U0MnJPY0czdllldjhJeTV5YzRRc1RiWFVk?=
 =?utf-8?B?Rm5lZEJRVHpZOERsU0pkSHNxZktGQjdBdjZyZmtEdjlwOCtOMjJmcTRkcWtE?=
 =?utf-8?B?QzRSU212ZFdmaU12cHcydzBEeEdKUTBHVjJCYmRMemRJTjMrZEFPem92ekxC?=
 =?utf-8?B?VDBMZlNnOGVGeXJkbWhXMDQyK1UrQXI3engyS24vQXVEU1V4Y2Z2ekgyRVR4?=
 =?utf-8?B?cktjbzJLbXlEd3ptajFndWpYaGR4ZEgyQUtGdjZOcTR3Vnp2OFl1UHJBVG1l?=
 =?utf-8?B?Qm1qN09zdEF4QUpOWGRVZjc2MXJJWll6djNCOVhWelNkZ1pSaExuczBDZjVx?=
 =?utf-8?B?UC8vWVpmVEVqYVp6Qng1VytvYVl2a1E1TXdPSGtJS0xKRmlmbnZmVldoTExN?=
 =?utf-8?B?aFk0L05MK0c4SjBuNVFFdGNiRUhMOWs1RmJ1U0JvWDZub1drdEVsbDVWdkw1?=
 =?utf-8?B?NmJ0MFR4aW5CRU4yUEtnbFlmTVF5STVhU2QyVFFtVjIrMDd5NUFoYU9GdUdn?=
 =?utf-8?B?ODY1blVyV0R2cGpoUi8yRVBWWWtxN1RZWHBxVVRNQmNUUWJKaVhkdWlaU0pU?=
 =?utf-8?B?V2lvVzdpcmh6ejArNllTZ09xLzVwakR5ZWg1cDhDOVozR2pycjgydXlIaE5H?=
 =?utf-8?Q?DWHLeOmVX8pu+af7q+04TkeQf2lrg0R4EL?=
X-Microsoft-Antispam-Message-Info: 0HPebtQFpQNUwF4WuTul/BaYuW9XiZ0Q3OiRmejRX0sVjVp2jTM5JLj6yA/raYm/MHAJ2ZpmEb/H635QcpzT/02dA827DyHf1vdp+XPk94L+KOOzfBijMyoSTip/4bjvXI1QEDkaFQRH8qSJ75BVpT7axvVgis4ldrcoJmHkbYKVORd1oxaiherVamIkmKG/
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0127;6:dBXq5eQ3T2Yj5MWzzV6t0Rxk6ELlnS7vGqi3rYOrthi8XfMv/hz1q69CgTLe0nIvmV9J8rQgt7pR/qiWXl+TdimzsSQk5DEva4By9vpU91+17On4lbKXHorO6UtslS2SwmYSciFBy9dHavDkXfxHtRre+ntwrnZtcIA0zoIHKdsUPakRFCLJuhMX32GYnXlzeI01sHRh08k04SFInDuT5KFkx+jscUwHiKsai/J+KCES7pVOiF36pVSuPPIH7lyHPaz7KPnY6Ibc91vwe3PiJW6mD3/+pThNEOVAe/a6VM/BfPeQYaDLUDXsjsWvN5gnhmhqxHwGkFUYcDkPm7jmDOyNJhilWzPviEyMNxZ6gDrXklrYaucO5lMNJCV1R3sUJ+pBt/QNQRDG6BB3yZB12P8QEzweYAFaY3cW+j1/DjXd4JnD6q1+WopwP7WyYQKthKXtTT668oVsPDXbh+oXnQ==;5:7gCw/npogImvaeHJOYLKP0/FoJ+wLoc6RmFmD0oZz6GWTqwYS5GCST2RS1ddCSHGltEYnkM+T53TOBwnMYYaEhez+XbjgUyGzS6aZY8JbwubTLjzGKCp3C7th/W/RaaAf6w8+2aPvJVd9llUZBXwVwOwQy0eM4ohrsIwQmXv+/o=;24:NLtBb2/VSos9ihyk+kR9CpAFsSCy3suYEUiny8vVHb0PUotE3qt48AhwF+p3Fjf3nknuOTVyeGZeaRHMwgh4yMApjZ0IWgobr8ToEBzsbM8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0127;7:Ka4xwj7tcgGcmyTnVOB/LVa6RwY18dEijw2VpfEhaGfXFU2G8gL+d6JTKLFye1bq5DCbmKFc3oM5vCHvqAVUlMQAzrFxllzILY5zqbKPkCEivEmMuwtskD2Ds/yrwfWCkzGYKGCmQ17sw4hdfvuyGSiH+KjGLmADRGys0UcyVjx+6PkZU4o1VyWblU5SHKi4U23Ejz95W25/seCDYpNhahd7Wpsu10Pov0lqZaidgW0FfnvMfoo4LPYB66sapaF0;20:scNatIR/QrOcAbQI/wx5vcXrlWf9g8GNWs0kuER9YsWTuNtu8A+qlzJiXpseUgVD1t7MWfZj02H+L/ZPRZ5JSHSs1xFVXKi9ogD1qFTHZR7hyrYhmNylrTUgpMC6L6a/wD7Flh4V8XEaxoeXMgDC50q0HTPiatV2CBcZwwSMlOT2lchhId7BePpWLFKsavRacgKouT9Jpog/F+b9BhvqMuOy+5qpzyZCZmsdWgNUGhDYOW5GoLTo9QT9k7vNJKlt
X-MS-Office365-Filtering-Correlation-Id: ed0463f3-ed4c-4347-d570-08d5aa01df21
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 16:38:55.0050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0463f3-ed4c-4347-d570-08d5aa01df21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 12:14 PM, Eric W. Biederman wrote:
> Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:
>
>> If the ring is hanging for some reason allow to recover the waiting
>> by sending fatal signal.
>>
>> Originally-by: David Panariti <David.Panariti@amd.com>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index eb80edf..37a36af 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -421,10 +421,16 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx, unsigned ring_id)
>>   
>>   	if (other) {
>>   		signed long r;
>> -		r = dma_fence_wait_timeout(other, false, MAX_SCHEDULE_TIMEOUT);
>> -		if (r < 0) {
>> -			DRM_ERROR("Error (%ld) waiting for fence!\n", r);
>> -			return r;
>> +
>> +		while (true) {
>> +			if ((r = dma_fence_wait_timeout(other, true,
>> +					MAX_SCHEDULE_TIMEOUT)) >= 0)
>> +				return 0;
>> +
>> +			if (fatal_signal_pending(current)) {
>> +				DRM_ERROR("Error (%ld) waiting for fence!\n", r);
>> +				return r;
>> +			}
> It looks like if you make this code say:
> 			if (fatal_signal_pending(current) ||
> 			    (current->flags & PF_EXITING)) {
> 				DRM_ERROR("Error (%ld) waiting for fence!\n", r);
> 				return r;
>>   		}
>>   	}
> Than you would not need the horrible hack want_signal to deliver signals
> to processes who have passed exit_signal() and don't expect to need
> their signal handling mechanisms anymore.

Let me clarify,  the change in want_signal wasn't addressing this code 
but hang in
drm_sched_entity_do_release->wait_event_killable, when you try to 
gracefully terminate by waiting
for all job completions on the GPU pipe you process is using.

Andrey

>
> Eric
>
