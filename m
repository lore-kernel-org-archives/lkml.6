Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AH8x227nr1nSPrS58pZtpaaj4qe4Ykf8CMiEg0qznSDZ6CM7l6YKqzsNDbVnX2RDMPpUxZKaMzZ2
ARC-Seal: i=1; a=rsa-sha256; t=1518084241; cv=none;
        d=google.com; s=arc-20160816;
        b=0eqO8IJd/NrQVHaQIe52w6dzID12EvO2VL39W/g0k4UFpXZV1icG5OkRL/G4RVu7J8
         CGN+3HvsXsFjf/GJX0hKA/0aDT4CNUq6oY7WTKpq3rkMXAJ/v17B40r4q9iBQX0B3+ug
         4eFfU7SJMdr7bGb5/XwKjcOr+DGd/AFYCRVvWrewZP/YgtPWq9grDc5cNYmwjveL43eA
         SvrKCi284Hq70dUN6WA1lzWloUgjTplzE0pMFPq3hvAkOdgdXXnHmSH8Lb2b4UNvSmeJ
         CYOstTWWhkiWOCfITR8sAgbuzNuAY3eXxoYklWIeVf2nu7ai+cgExC5Nmx4ZzRuPoOQd
         D/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Hh7nr9yzZUpMeizI9sdOviZs42R8hChyiX+2hqIL5xw=;
        b=q3O/4w1CmEzsWzPpK9LrPaDcDKLcYXC/t50FEx9UgHC8ntIJN8e9S38DEOVQvoEEYG
         rrDtSfR/zwi3Lu2czl82Z5/nxyyomYO1ovZens5SgnFUOZv4Hu198ggaALU2T/a2WKel
         76bnyRn3v/B3Z/SZAkZalLbkUfIWkO24ejn4PjSXkI3rrHU1sX+k3irNaaTKFiMPEV4o
         iy5VYQmNhT8MlofNkZpv96ZbOaKff1w8EE87Dq2KHao9h1Y+k5puGnKST00X04BHnKeF
         bMXRw//8WddrUl2wf9pQjKCAs9r48DiqwihHQxPZ3oxZxuCR8lbeytKtWUyMsR7Kg9MH
         dJ7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OgQkHkwV;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.137 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OgQkHkwV;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.137 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH RFC] x86: KASAN: Sanitize unauthorized irq stack access
To: Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
 mingo@redhat.com, hpa@zytor.com, aryabinin@virtuozzo.com, glider@google.com,
 dvyukov@google.com, luto@kernel.org, bp@alien8.de, jpoimboe@redhat.com,
 jgross@suse.com, kirill.shutemov@linux.intel.com, keescook@chromium.org,
 minipli@googlemail.com, gregkh@linuxfoundation.org,
 kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <151802005995.4570.824586713429099710.stgit@localhost.localdomain>
 <6638b09b-30b0-861e-9c00-c294889a3791@linux.intel.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <d1b8c22c-79bf-55a1-37a1-2ce508881f3d@virtuozzo.com>
Date: Thu, 8 Feb 2018 13:03:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6638b09b-30b0-861e-9c00-c294889a3791@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P190CA0059.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::48)
 To HE1PR0801MB1338.eurprd08.prod.outlook.com (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 224202b2-0907-4b82-e561-08d56edb443c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:4jvxz0Nic8xdGUPQjeaUtp3MKW4Qpki2teISN3AZj3LZVDS08QWY2Hqa6Bf6QT1NZJebvPvC5MEd5st40aI2aK19ypi9/I8kGiYekDaIN0EIlj1gV5v24QU7abqSneIBxCXps0x3gB2eJMAfj+Ob4Z+uoI1doNu+M01wXc/PU4IXSx2Ie65Q8u25pDRIrYn3msoTqJfUn97cvjVuLPkBA3Id6HEwUcW7iY9+jmsoV8pIhDFvncrMhWllglwX45St;25:GDUqnjoU8uZvFcbkVIBZfacxqZAy0GM8rxa5yy2zvt88J+4ryhfDbXCy0AMBizW/nH7qZ73mrBBFo0d8yGpN83IO9XCcFMXcN5mggQ1P+kIYSBrfVpfiogkBb2gk6DIL6arpX4oHWCR0rr+KCGWrBZJwbrO9sOXpy3FuTJcw7XiOzI0U1JhFgE6UzB2K9o7mgMb+yyNvX6KK611stXj85rA1Vha9p2I8YUWoIe9L1pJfrzuuofWmTq4w5AIr9h0DxyvhbtG96724YlVG9ZzdJtTGm8AXD4zdNSKDFdEXQYqOmeBzvfRxN9l4xna1roj1sl4kuEXzSyvU+rsJixKwHw==;31:WubW/c01oucgfOCkAC8xsc1JPM6P+bqaCY//TzP8j27iO7CkC31FGUDsJW/gTRDTqEOY1zAEfJ6xoZ38oOrzsBV/hwu0q9cNd5tEN+pXBhzbDaomXHmGfz0PXEVp83sQW/PdHGggS4E7T2+JawRzIe8xX7ODMIL4QsCEAiunMEaqj/jvnhS3/SG9pLNOnlqONOV199GudzZcHDebgH1tUXQ9HbrqFp+1puA9a3VI1+M=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:aDgxHBLbghYZ3hBNBNeivtjvKwuqxrc3x2bj2ytddyHrJNpzE4LmsR0sBgCu7zfKZe9XDvR8jce4YY8iJPR4hzrIFADdwgK1dkkyVkhHmGB80DG6oSX+PGi7phKHdD4ktFNNAR17F9wN2K3pFToFVGgitdK9O7jiaG4B7LX1oyENQn5fSE4gcBtO6ud5MFnJ2Pxlq7lpGtaLzeiogHtqZIIlmbxtZy9h0+B8rnUbW5X4MYcCA+cmkjTeukDIaconAcY7FZ0FeCVqY+0WBAFZzn0DUp1NMoSv+9ZojwEbtOrqulayGNMp3/7p+QakJcGaxSmhsehzTwhJEilx+OfYpStkAI2yiabymksZXd6KnxhDMYHuu9lD6ToIH6u3yoJH5FoW2RfgIo7gqo6iZZcPs/C7Wg3yWx6m0wS1OGh0Ynk=;4:PDYU1grKsKJkAfnJ9dq30gegIdrBRdR21rwXP8TuUf17Fw8pVF6BolmdrNM8WIhh0zqt4zZNTa5RhIYx5H+oXMpbVQe1Sdj+3ifpJal519sNm+fb+cPFXj1EPIzWYLPA0HJRaKwx5kkkfwMVAjJf4FVUULR4k5mZiN9XXiNpq1Jg68XuiNwQPHmICQsr2m9bSsf+TVU+h6rZdj2JoO9tu7jiZ0QTrds3TNpvkzf6bp6D20R8jzEtheMg7sRtnViQ8gUrpEEeSCy0o8DHHmglRucXWoFhnf5Z0S1q/PJk9XKT+e7qs6tWOjFFvFNrqOK7
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338A33F3C30DB54B0C0855DCDF30@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(396003)(39850400004)(366004)(39380400002)(199004)(189003)(53936002)(6486002)(229853002)(305945005)(7736002)(58126008)(316002)(16576012)(50466002)(65956001)(66066001)(478600001)(65806001)(7416002)(16526019)(186003)(3846002)(36756003)(6116002)(47776003)(86362001)(97736004)(64126003)(7520500002)(65826007)(5660300001)(2950100002)(106356001)(6666003)(230700001)(2906002)(59450400001)(8936002)(31686004)(83506002)(25786009)(8676002)(52116002)(23676004)(55236004)(81156014)(6246003)(31696002)(386003)(53546011)(81166006)(2486003)(52146003)(68736007)(26005)(105586002)(76176011)(77096007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6N1NCeTM2UkExOGRaS2REZmQ1clhQUW81?=
 =?utf-8?B?NDlONy80Tmp5REtBd0lQSGZleWhHdnZ4S3djL3NYazV4anZMVXNyaXFwM0px?=
 =?utf-8?B?UEZUS3J0VjFvckg2T0x0R2dmSkU0RUxrUHVTUmw0QWxHNUFWOHlFUXVSVWpk?=
 =?utf-8?B?NnhvQzJkSFppazI0bkZCZlpHSGRpcW1CTHRiVUk0V3FkTkV0RmZmYmxtdm1K?=
 =?utf-8?B?Q0hnUzVNMWNaR3M3b082M042dUxwR1ZXWWR5V3o2NjFNcjJkV2RNUWlLODBz?=
 =?utf-8?B?aEdFTGpoVUdEMEprOGhWcHZXL3ZCREZoUERpSXNIZnk5MHh2c05MczArTUJZ?=
 =?utf-8?B?RTFaR3FxZGRlUDR1ZU41bGJJS0wvbjlZRHgra2xMdSt5cUFuQU5vem1LcWJT?=
 =?utf-8?B?dGhobEhqSkFwZlF4ZjFFYU54WmFqWklSL1dmK2tmNjJrWWYwVjRMTnpDdUcv?=
 =?utf-8?B?V2tIOHJQL0ROdm5jSTRFSTh5S1dBZ2drWitHVVUwSzcrSHdRNjhpNFUzQ01a?=
 =?utf-8?B?KzRpU1VNeHcwZ2pkWWRad0NsOFlwcXhnTVc0REp6WktGNGI3MFBsR3lyS2ds?=
 =?utf-8?B?cW1vN25QWlNSdlJTbGtJSkRCRTZYbzIxbllzemNQTjB1alk1QjBvYVVPcjlJ?=
 =?utf-8?B?WnRTd1dibjR5T3dUSTFhR3QvTGpWY25VZnJOMEFyMlBrYktvenJtRW5PVXF4?=
 =?utf-8?B?bFVKWmViN0FsaGxiUUxFSEdFcjZUL2FDQTJ6WXNicllGSkwrZDB6dDgzNU1P?=
 =?utf-8?B?OCtxSTJrZVBaaFV3NzJOVjd0S2JtZXhRV0MxYUtVcGU1QXpvUS9jQVlKNXhS?=
 =?utf-8?B?SEdubnhIelE4cEVyKzdlaXU0eitDeHVWckNnUGIwdnRNZ056dkJSMlBUand6?=
 =?utf-8?B?b0dPenlYNDBXOG1mUW5UcndQMFhab2pqdzBCTVRpMDJWNjd6SHIxaVdWemVs?=
 =?utf-8?B?WEcrNUZPc2ZZZGEyaTVQL1p2aTJVRFpjS0pwcENkck8wRHY0SnJTeXN6ZU5Y?=
 =?utf-8?B?RWp0RDd0QTV1Y1pUdWt5VGZHN3haU3BSTEI4b1hUQStTRW5GRDh3NlloNzVq?=
 =?utf-8?B?WUtiTWFhL0F5VWZmRFVJREJYWFpRSUhTR0JKeVRybjdQd2wybjdvWXNwUFU4?=
 =?utf-8?B?aGFINmswT2VIdkVGbldhMDQ0V2dhSEFPUm02TDN6ZU1GRVBuY0tHRkd4Y094?=
 =?utf-8?B?N09WMk0xQmtWY3NXY20zT3EvcmZjR29LSjBjc2hDSTJUaU5hZnhFRDJjeTkw?=
 =?utf-8?B?UFN5REN6aU81WHoxZVNRWFJaQ2JibzFlZHNjbVJXam5yWkhZOHdDTUk1R3dW?=
 =?utf-8?B?dm1xTUZJOC9rZXFqczFVazl4UTFSRittR3U5eUZhUldSTkwzSnVqUUxldWt2?=
 =?utf-8?B?RHdtUFNQWWNDM3ZFcE1zUHRvMEN6dk9YMzk3MUhKaGRvcStqMk9lbHlxVXNm?=
 =?utf-8?B?dVJpYXVvRFQ1dERod3lVdTM3SlprY1BzK1p6cmJ2NG9DaWR4T1RheDdva3lF?=
 =?utf-8?B?M3duR0lrS1BGQ1RiTHZoS2NLS1BQQXhIWDU2M1lyZndNRWNtcndLQ3hPUk9z?=
 =?utf-8?B?UWRYVkpPekdzT2tReCtqMDZXNzJpYkdLNWttdU5LUkJpQlVsVkRvam1wbHhC?=
 =?utf-8?B?a3ZreW0vRmV4bG1ydjFPb1o2eXJMbEtuUDdvS1VrME1HenR5UllrNEpDb3Nx?=
 =?utf-8?B?UEFMd0NGeXozTlJoZmx6ZCtPcHpNazNGWHNtZ3Zhdm9NSXlaZFZUMVlRRG5E?=
 =?utf-8?B?YktENjk0THdTcVMvcUZaNTB3Ym9OcCt5MGc5ZEJaNHNHaTIwWkFlVjl1aHR0?=
 =?utf-8?B?RFVzRWJHc05EcWM5NlBFdndGa01JNnIvMG1mckRLZ0xoS1J2c3Jvci9HV1RZ?=
 =?utf-8?B?WlM5RzNSaDZUZnRqNXQ2b0FjOG5NbjQrWXN3b1BDLzBtZGNjemdlalNoN3Ns?=
 =?utf-8?Q?nbXQCUdC0P2z04HFVSTlLfto0KAhKhxA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:4sdVNe/mwLCg1qLmM/z/gG5Tbgx0EbYgpYiUJ3FU6YGMBAnt+KHm1xOKpVDx1VOJlJW6IOPz0irUGQutBsbzmjwhwOcMFAT5C/4YZnic5nqWu8RkmmWfccYiXkhF9fdLKwb+gH/4OwikOHvsQsinMJWQQRZ5yed8VgHNIHxrsPrAo8rFV2ycTX+Ub4wo0x6GC5lwq5NBh8Yif0Kx9AhE9LUV4Je3oDJ7xRtaF1ua7sBZ74H2rzkmir5tA9lYcqKxxyckvPyidpMWFABE6RuzTk2OnHmSHNIQxMcTsIQF9Ruu42ILL2Mg0OEHpzTA/7XM+79SAKnog/ur7blPr6XuLzSBgLl7o9co6mYmyO8fqgU=;5:XjJx6DJQp897TLTJBClJrd9W9uWp/e5cW52T2jJmeiuiov5xuHH/BR/uLduzSSLOnkbSAJzwU+3/gUhJfeugAXzxbcwgzWOG5fX0FM6Fwj58/4ZDu+fSKY/erNbgbH3pPPPFfg3dXCI2vLVsE/Hc1jl4hNfYBU9ly/2eiqUErXo=;24:1snM+szuc6HmaL2vV8HmsUGM6+xHD1VwU009y4QYsyIAe8DVnBaE7Ni0r3BTnDlunkNFVCPJTrWUxAZaee95ep0z9nwx9JLZUWh8A0LPQNM=;7:/U4IIydwCzZnaSR5AGbnn1wgs3zo5opcLACfSORTFf7N3cy+cOKx3W9jfUJ3pAJuBplFQuuPYFFBl1TQ4SFxMS4/T1cbwyvv7rX/Jr1/rzo5f4gkfmAPm8p4YTxDGcmLM1yCyN88QJVrqIPcsL3iIfjBjdKipISGwXPMewjw4lGlzoBSkIOuuoa4VCgEcrXuTleJ+LLbFuIptmGh2QnxpJHVwCD1X6WRxBe/N/amnvgWKqmcWZjzaK7HrcMIhkgZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:qjayOh4U3a5awpPkVHp53wNXt27lV9XMQxBs13BYvfys6bTZepzegxftTyy9r2yInJgkdgptdOe+XOL5NoHvEECM9tRrp6SgPYnB1+c3B1jj3aRb+Wf03/pySWKNipOc3r8GSLnY0ILECFqZh4MiHfRk49dljRZ6hqqBbke6tmo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 10:03:55.7652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 224202b2-0907-4b82-e561-08d56edb443c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591759437440105803?=
X-GMAIL-MSGID: =?utf-8?q?1591826701673842276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 07.02.2018 21:38, Dave Hansen wrote:
> On 02/07/2018 08:14 AM, Kirill Tkhai wrote:
>> Sometimes it is possible to meet a situation,
>> when irq stack is corrupted, while innocent
>> callback function is being executed. This may
>> happen because of crappy drivers irq handlers,
>> when they access wrong memory on the irq stack.
> 
> Can you be more clear about the actual issue?  Which drivers do this?
> How do they even find an IRQ stack pointer?

I can't say actual driver making this, because I'm still investigating the guilty one.
But I have couple of crash dumps with the crash inside update_sd_lb_stats() function,
where stack variable sg becomes corrupted. This time all scheduler-related not-stack
variables are in ideal state. And update_sd_lb_stats() is the function, which can't
corrupt its own stack. So, I thought this functionality may be useful for something else,
especially because of irq stack is one of the last stacks, which are not sanitized.
Task's stacks are already covered, as I know

[1595450.678971] Call Trace:
[1595450.683991]  <IRQ>
[1595450.684038]
[1595450.688926]  [<ffffffff81320005>] cpumask_next_and+0x35/0x50
[1595450.693984]  [<ffffffff810d91d3>] find_busiest_group+0x143/0x950
[1595450.699088]  [<ffffffff810d9b7a>] load_balance+0x19a/0xc20
[1595450.704289]  [<ffffffff810cde55>] ? sched_clock_cpu+0x85/0xc0
[1595450.709457]  [<ffffffff810c29aa>] ? update_rq_clock.part.88+0x1a/0x150
[1595450.714711]  [<ffffffff810da770>] rebalance_domains+0x170/0x2b0
[1595450.719997]  [<ffffffff810da9d2>] run_rebalance_domains+0x122/0x1e0
[1595450.725321]  [<ffffffff816bb10f>] __do_softirq+0x10f/0x2aa
[1595450.730746]  [<ffffffff816b62ac>] call_softirq+0x1c/0x30
[1595450.736169]  [<ffffffff8102d325>] do_softirq+0x65/0xa0
[1595450.741754]  [<ffffffff81093ec5>] irq_exit+0x105/0x110
[1595450.747279]  [<ffffffff816baad2>] smp_apic_timer_interrupt+0x42/0x50
[1595450.752905]  [<ffffffff816b7a62>] apic_timer_interrupt+0x232/0x240
[1595450.758519]  <EOI>
[1595450.758569]
[1595450.764100]  [<ffffffff8152f282>] ? cpuidle_enter_state+0x52/0xc0
[1595450.769652]  [<ffffffff8152f3c8>] cpuidle_idle_call+0xd8/0x210
[1595450.775198]  [<ffffffff8103540e>] arch_cpu_idle+0xe/0x30
[1595450.780813]  [<ffffffff810effba>] cpu_startup_entry+0x14a/0x1c0
[1595450.786286]  [<ffffffff810523e6>] start_secondary+0x1d6/0x250

>> This patch aims to catch such the situations
>> and adds checks of unauthorized stack access.
> 
> I think I forgot how KASAN did this.  KASAN has metadata that says which
> areas of memory are good or bad to access, right?  So, this just tags
> IRQ stacks as bad when we are not _in_ an interrupt?
> 
>> +#define KASAN_IRQ_STACK_SIZE \
>> +	(sizeof(union irq_stack_union) - \
>> +		(offsetof(union irq_stack_union, stack_canary) + 8))
> 
> Just curious, but why leave out the canary?  It shouldn't be accessed
> either.

It's touched in several more places (e.g., in __switch_to_asm()), and I'm not
sure KASAN is OK with this. Does it?

Also gs_base is touched from load_percpu_segment(), which could be called from
different cpu, and this seems it would required some synchronization between
the handlers and this primitive.

>> +#ifdef CONFIG_KASAN
>> +void __visible x86_poison_irq_stack(void)
>> +{
>> +	if (this_cpu_read(irq_count) == -1)
>> +		kasan_poison_irq_stack();
>> +}
>> +void __visible x86_unpoison_irq_stack(void)
>> +{
>> +	if (this_cpu_read(irq_count) == -1)
>> +		kasan_unpoison_irq_stack();
>> +}
>> +#endif
> 
> It might be handy to point out here that -1 means "not in an interrupt"
> and >=0 means "in an interrupt".
> 
> Otherwise, this looks pretty straightforward.  Would it be something to
> extend to the other stacks like the NMI or double-fault stacks?  Or are
> those just not worth it
I haven't met NMI stack corrupted, so I don't have ideas about this. If
we need to check them too, one more patch should be introduced on top of
this.

Kirill
