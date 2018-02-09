Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AH8x226HVAyHD606OKPyS1gPgCSVT+xevnMn38clhyabZzWjvwSNwdj7sINtOnOwyTLlpyXoRx7g
ARC-Seal: i=1; a=rsa-sha256; t=1518166408; cv=none;
        d=google.com; s=arc-20160816;
        b=Bh8CUjIvphiBTZbn3kf2Z/KGjD6fEmhYfG69lnfdyTXg8FVQ+1ecw1DzDAn7O+yOm+
         u6maw0s4+4p9O5izNgZtNTGWVsZ9diY24D1uJLuRzWJdsXQBQv5l9DZkx8XDRYawTg5V
         tMcaVd+7qHiC9muQZh70EEYl8AcOjuZk95o5GVSxx2FuBsQBo49zPGDjMrSHrOLBpGQ4
         OqBNkxhuaUy3L7jwxnMNEtNAsM5H2sGsgrcstKPcVwlNPDLOgmwoWXbdF0NUHdNK5hPc
         OMXwPFLDXpa19TP96flE+bnhg0wVWTyEOmVi0l8vmwDm+CKXN8QgbW0iV5liuOYBuvsx
         fscQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=vKmwubXqH297XArX2bQ1oGFXHb1eCn/nLSu3nljYbwQ=;
        b=nSIvhC/EeYBKNnJ+jxPx6cixjBE7zS6wTRI7r8GwGtjwvW5p2cxDF0sxIsw+0SeOOi
         t94+Bww/Kchzb/lElejVqununKSj2fzCIuRGsTgdMJ2T0cDpqvnqczfj2JZc7FQVGNZc
         bvqnOd+VY/JnuztE1wHUJARURsX5SfHtgp9O60JVxLioHMBQkDTmcvACn5lktv2vuPIm
         etcQUwxHp8Xjlqm6i2nkQCXmsYDMnDEHUZ5/Ggm+enhmpyOraXlEZhJvAKD3RboL2Abl
         d04aPuX94zWLdsEXqNIZLRoFVqnjMjmlM323GlH3pzePF62cJCmtXZZ5WhFth5LZK9HC
         Pl+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=WcyYJ7Pb;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.132 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=WcyYJ7Pb;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.132 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH RFC] x86: KASAN: Sanitize unauthorized irq stack access
To: Matthew Wilcox <willy@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kees Cook <keescook@chromium.org>, Mathias Krause <minipli@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
 Linux-MM <linux-mm@kvack.org>
References: <151802005995.4570.824586713429099710.stgit@localhost.localdomain>
 <6638b09b-30b0-861e-9c00-c294889a3791@linux.intel.com>
 <d1b8c22c-79bf-55a1-37a1-2ce508881f3d@virtuozzo.com>
 <20180208163041.zy7dbz4tlbit4i2h@treble>
 <CACT4Y+bZ2JtwTK+a2=wuTm3891Zu1qksreyO63i6whKqFv66Cw@mail.gmail.com>
 <20180208172026.6kqimndwyekyzzvl@treble>
 <20180208190016.GC9524@bombadil.infradead.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e74919c7-6b32-f55c-ff88-c3abd851476f@virtuozzo.com>
Date: Fri, 9 Feb 2018 11:53:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208190016.GC9524@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0188.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::12) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56a51c25-7676-4abc-af26-08d56f9a935e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:WQMJbUTg9b56WzTsUOva2e/KiiHNJHbz5RDkSawKgO1DPC/m5OajV6Rx36ZOlnBqcWSQHQ1HI+hGOkAljZUu0e1acE/2nPPXQZVoXlZ4c/GOlws/08u9riJex3NNHuV5sb0/TrxLR6NzJyMXt2q43vFGfNzbqBEU+g4u0F5k4g/D+jKgMthuaa5WMblsSyG7bt4wW31v+dxyMO3rD72fylEsQeJV6OKynWcaxRhvnuubTjWVedT/BHWeJHBUfnQu;25:TSMlQPPSYJ4WjrzvS76pGDt0YZer/7bBPUYXHqMMkJn9VZbG8ly7nA/1vSJiSiDUL6Ac4cawwr+Fw55M6OhXhsuKEyE6TE4dwnNjbZKPtBFan/t1TWu3HiAZxjDStpPWqa70k8nU38OsLuhIiX/Qoli5Lu9V//Is1bZw2lyP36Zpm89pvLarO/UwOl9cV2c1ZMa1lkmkRAHMsV6pmj67djvWDnWZUEllqYInMDe+wJyMb7XAsI8es3tSkNE5km5HcdLiwF6TBBL55+FP5KZw+xBrR02tjpzaomQ+2vc5oQEoCa0iW9bQJZ67IMMDlEyT2kENiIh++z0+Q+JQ4dIvGQ==;31:Vqbmy20ukLE7P5mCIjJaZiwTaGvW5/kPFk9dC0pimF9NvyCBBsyFbhMVHTrfVvMaqNCNKHgJOTvSe0hok/ap7YD7sUrOzhh8+Sc77iBRwvh+8vlQ4w3NG2kY54l5K/erHC9J7paLzSrBmDAJdJznB/ktfPJfUlqcjPodbBgOE/VUaVtvTjhQzFFlU9vCh2ANW9oxapOim3y6CmGJCIZ4j4iW3udXRe335kFl1CwK/No=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:Lui9ZM3O1QnOFqLHwx15kmpI+aiW6fziV4pWH0RndyL4j59Op5dor8TZk1yU/0DiGdAb+lJBmM8gWZivk1HPMRAzAyqdahPFU0Dt97e0EVq9vd76uDw9P9vczblhDOz+KjFduTLWIxURcnsU3cQu63EGBTDMpyPgG0CJzhcJCx/xVgo6oVBBEppv4dqwTtw30fA2VPBOwcXAYm188j8oOVsba8Ch4ILZp4suIBLhq4uLBb0ff1FTJ7YE+Ley9SjlxQjbsliY4uYJscPk12EbE9XbLRsfCt/zgZvSVIQbHVNk8EPh2TgLgnGvbAR8cV9bVw2U8O4JhF/+dI5S3sLwWYy+i4fMxCwEn/fPPdb2yIdi14vGxfcotwSck9zQvzr8G4Ln51qfbNuzYz2LPbO2zBg1aTc1Bl5YamNFajnQNes=;4:uX88QSRiV69k4Oh8/CNuBY9Nc0Mpcd9YW0+Vao/2+4cg2coL6HbCkvVIIjczUmdWHVDiLkTNPGIwmnE6KTbDz7tR+ue64+H5B/zSbnnM9gXVSayuZp92ZFQ5RDFjPF6rq/4Vi6NDbOYPexRULT5joH0Cc/X96+bxQgkca52T0Bzo426S5+XegAuZoJR/mTvCNdmXlyxOTucSRuuLeRqUiZtGUwYsY6a+A+7p0ty6LoMmwooZCW9LCunH81n9xf4owJW8iplOzAKbMNZ1TgI8PA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133878153F8FC1D83D3B4903CDF20@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(2400082)(944501161)(3002001)(6041288)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 057859F9C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(39840400004)(39380400002)(396003)(366004)(199004)(189003)(23676004)(6486002)(31696002)(53936002)(229853002)(305945005)(54906003)(7736002)(110136005)(58126008)(7416002)(316002)(16576012)(478600001)(65956001)(50466002)(66066001)(65806001)(186003)(6116002)(93886005)(16526019)(36756003)(3846002)(52116002)(86362001)(47776003)(64126003)(65826007)(97736004)(5660300001)(106356001)(2950100002)(6666003)(230700001)(31686004)(59450400001)(2906002)(8936002)(83506002)(25786009)(77096007)(386003)(26005)(105586002)(53546011)(81156014)(8676002)(6246003)(68736007)(76176011)(4326008)(81166006)(2486003)(52146003)(55236004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6U2xPQUlNSUlLeFlGTGM3YnZUNnFkZGpw?=
 =?utf-8?B?Uk1kbFNwcE56SUorNnR4emJGVFh2aDcvWHlMdkdGQXhMUExqZTBZZStsQXhY?=
 =?utf-8?B?YnRjRDdmRy9sZy9nU3gyb04zU3BLbTZrb3UzS2RnSlkxT0tra3BlRm11OVBl?=
 =?utf-8?B?dEdiY2J1aTRzajQ2TjQwdHpPNXdPbFB3bHJTQ0M3bXF4VlAxa1JBZ0tkcHh3?=
 =?utf-8?B?djZNTS95dVIrc3lSV3pTd2trbjBxRHZ5SDlLUk5Vc1hWWVNDWFk3N0c1aUxy?=
 =?utf-8?B?UzZOMjFvUy8zVTNRSldXanJOb3hiZE9qRklrTnZ3V3AxVmdhL0F5YTNFbmRC?=
 =?utf-8?B?UnR3UnBqOXBmU0VKUnhRS3JtOVViZUVDcmF4cDNEbHpEL3padTUzMm1PaUZa?=
 =?utf-8?B?UkZmVHNBTldWWHF1Y3RHQVZ3bDcxYWplekhPWDN0bVpuOXZCRTlwMDVzZHVP?=
 =?utf-8?B?Nk82YUErcGJ1dVVIU0lIazFwVEx2VkRlcTBYajlqd1VUN1hkajFtYm5tMzkx?=
 =?utf-8?B?K3RUdzBzNE5EdEU5SmN4MTdmSm95UEFCUHVvUGtrSXBrVmY4WmdRWC94cDhG?=
 =?utf-8?B?QlhxN3ZDRlJJaW1oT0pCK3YzOEpkSHJLUnduVU9Nczd4U20xMnkyTzVsTWx1?=
 =?utf-8?B?dzVMZVZ4NklGU2R2Z3JRZUFkRjNFL0sxM2g5d1Y2RXY3QUU0Q1F1bFVjaXZC?=
 =?utf-8?B?SlZJNDdxMnRNcVF2ZGxiU2ppVEl0cW5VQUc1aEltcm9NaU90SVM2REw4RlRF?=
 =?utf-8?B?YUZ2N1hNczAwVnBsUGhUQ3IycjI0WktYL1lRa1M3NDd4T3AweXI5ZlBCSjBT?=
 =?utf-8?B?alZ6VVA4ZkRFSlpJZGlMSFNTVzQrOTZwYThVd3NjRnY0QXo2bkluR3dhc3Zj?=
 =?utf-8?B?dnZiS29xaGsxbzVIUVlJUG13djM2anR2VzhweHczWjNFaVRMRmpmU0h6TVBM?=
 =?utf-8?B?bU9oMzhkM20vRHgyaitBMGpVSHlBeElmeU55YWVGSXFXKzIwNTB2cVBwcVlv?=
 =?utf-8?B?UFdMdVVZeEFQR3R4YkRDTkRIdlg4SDRwbS9XbHdkYWFuVnZ2NUEybEEwTmkw?=
 =?utf-8?B?TG5xU2RhekRscTNYVkFhWmFaNnJjckE2aEx5VXg5YjNpZzQwMkROZkZYMjB0?=
 =?utf-8?B?azF6OUJkeHJhVEd3eXA0WUE0SjZ6STIrb1RiYTJXUTFmdVZkcW1HSkt6NWdY?=
 =?utf-8?B?T21Sa0I1V2YxcGM2QU5qbTdpSndqcTh1M2sycjJGQjQ4NkNGS04xT0Q3c2Vh?=
 =?utf-8?B?OTNpTXF6OUVvNndyNXNFbXJLNGp4TTdCamV3bElhK1k0TVhhcE9UWEtkVDJk?=
 =?utf-8?B?NVl0ZitZRnpDdVJmQmQ0ckRncUdYZ0dtbEt6dEl5U1o5OStqVnNPQTVUTkNq?=
 =?utf-8?B?UUJ4bm1sWnRZcGlJUnFDTlBYLzhzOW1Id1k4aHVmajhvODdIVEk5YUZreFp5?=
 =?utf-8?B?MkJ6bWp6blNCUit2MjFmOG1EVVdMTmwwUE45eEZuendZQ0dLdkZnVWkvMFpB?=
 =?utf-8?B?R0lYdExKc2daSytMZ3RaWHVWSDMvRVBvVzNDR0t4eEoybC9haU5od0luWEhE?=
 =?utf-8?B?ZE1lRFowMmcwK2U5Y0xrc1dDME5WcHA0Uk0zd1dzSE51TWkrQWtXekJ3anYr?=
 =?utf-8?B?d3hwcmdYTDd1UmpheklHMFRSc0xJejNKRUkwYlphYWtNSTNzYkVuUTFyTHBI?=
 =?utf-8?B?YWNFZG1QTjR4Y3I2M3BDYmV5cUxoRVBMUlY0REJvS3FjVVBYRm1KL25kZUtX?=
 =?utf-8?B?NDN5Vkd3YnoyanFtSzk2Zk5yY0lKV09jNXN0bWpJRHJNWWVycXdpSm9GYkVw?=
 =?utf-8?B?S0dibncxbmVFOEhOSlZQSHlnWTZFLzdqYzVGelZOSDk5dzVaRFpkU2ttbmxT?=
 =?utf-8?B?dkFBNTkwVS9kME1KeE16UXk2WDE2b25MMEJ6TUFpZGR4MmRqWklNS0IwZkxt?=
 =?utf-8?B?YmZzckJKZFRZVkZ5ZkIzeEpHamZxU05tRkFnaCtZN210Mkl4RHgxL0hWTkZr?=
 =?utf-8?Q?tlAXipiS?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:/dsLLCHVDzOdxmKJ8jS0n9gcNPzq/hyFBLIXGj4Gh/TWjGTNK12cn7XXeIJKUxkhBrfQjY8mbUsK675dLaq+thQ6QesP+iPDYaMpMIzy2MNQPpx7kqjWUDb3eysF5nkHzShjKXiNJATXbBdhr0pMK3EMpVaQopp9K1yT5sXN1BVAzqqRKQBKwDlumD5p7K1RjhlRh/fQfQSW8OyR06HIlzHfs5cVnJHYPyXzzoEWk3JfnBBVYCQaKzFfISxDl0ZNKtjZh2vLBsB+vKRyihFHKOge2Cz2FQnF+grMtOeZqB6ptlZVI49V4dpYXK/uHZYu0XH/tK7HRm3ig15nX+gmpm7SzOoaKXv8oSLKMd7jUrQ=;5:XsTkxPP4330WDMHO58E8ieK5SQHvFmj4vCJzapAUjhbojg8xv8CTuyueGNVqU5WjCZN37fWtt+1hoawZ51sLppRzFUOPqi94v4CNHdVz10TqHTsAaKO+7ftqrjb9psG1Q2eFU3RgUkN6Bcn7oxtUHDsx32rOWyM4NMghoXq60EM=;24:IXN18LlnhZLlqle8QeL4Ypo36DL/WZhT238XOxZCgOjCBgHPgnYqbcQWVSi3N5Hh5cYNWxZ2t33tu3rhkSJFp3SQ0ihFB9cZUf+SA4VIzgw=;7:2f8gENBrKxQ45y8qwCedAJI9OmTfF8SzIoQnVr1237yDW+Kfm2P++q4Gy7iSqGw+QC0qlvZmyTscXm4hKlIIy0fKUSyhUy2rVOFZ05Tks46y9LzObJ3XSDdKqLIaJTS5zlzGuUiVfOFNYVbsix37cOQ4uEP4cL2wwhLs4sIg7ouyKj7yT2eRQBg9BUBdPg4Yz6/gjrrfKQPcB1OrK4Rq0LzT8sLGjWmJ46mc72PxWMHmKvU4Grthd/0yPqw86xXr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:NFSmBgbfUygT9rr59Pl64SsS0FltJ+MMNTMTE+rL4kE01UzFexHWw8tq+tsxOvPPC0Rs86iOdoSUoBqy0TxUvmaQ2nPWh8JtCUXyzjtDovdtalFcrlBxGVF6KjWEuM4XTPSgW7XmK7J4TZGF8S/DXBTzBwWiw9FHVwALXjHk2UE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2018 08:53:22.3708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a51c25-7676-4abc-af26-08d56f9a935e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591759437440105803?=
X-GMAIL-MSGID: =?utf-8?q?1591912859423079133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 08.02.2018 22:00, Matthew Wilcox wrote:
> On Thu, Feb 08, 2018 at 11:20:26AM -0600, Josh Poimboeuf wrote:
>> The patch description is confusing.  It talks about "crappy drivers irq
>> handlers when they access wrong memory on the stack".  But if I
>> understand correctly, the patch doesn't actually protect against that
>> case, because irq handlers run on the irq stack, and this patch only
>> affects code which *isn't* running on the irq stack.
> 
> This would catch a crappy driver which allocates some memory on the
> irq stack, squirrels the pointer to it away in a data structure, then
> returns to process (or softirq) context and dereferences the pointer.

Yes, this is exactly what I mean. The patch allows stack modifications
for interrupt time, and catches wrong accesses from another contexts/cpus
(when there is no interrupt executing in parallel).

It's possible to catch wrong accesses in interrupt time also, but we need
to unmap irq stacks on another cpus to do that, which is not KASAN thing.

But, I hope we may be lucky and catch such situations even if we only check
for accesses, which are going not in interrupt time.

> I have no idea if that's the case that Kirill is tracking down, but it's
> something I can imagine someone doing.

Kirill
