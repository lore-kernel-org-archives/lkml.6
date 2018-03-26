Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELsdx8/HjoMnvi37dN62ddYiSnahTCwVU1CvGe0u2uE3wK1IbFauKe5D+pye1Ye9qYWN21y8
ARC-Seal: i=1; a=rsa-sha256; t=1522078158; cv=none;
        d=google.com; s=arc-20160816;
        b=qqWig+e55mVvhYyEfwV6Kbf8bSvCiJbB7SFfKiX3wBK0HLqy3xiSr2ZidSeQFgtv/C
         BluuvgBISW7VbsefO42DE+3SHkCk9qsiRcV+mkjP1WsOpbO8uzBkMUjjTFwhco/UViCp
         eXeEuLAObTf5RkqaqXl6NepN1XALmptj3D9EYrb8+dea+QgC5J5nUkmLjLbd4j3l12pR
         +lpJB+UfePXeMrs/X7hFwOMxIoZrPZ8gJGIl4ZlyoqBnqi3I9x5cFfFrZwChV3QUlLHs
         +QWxvBMCEUtYTecoYGQ+Fzl9y173p2RgK7FDUxt/KXVU5namElhljM/2hhq0Zd23/lKG
         kNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=3zF6D5/u85WZFjo6CSboPE5iXDyuMXi9CLkU058X79U=;
        b=Au3QWYzJWJyuT/c6pY+DLIHX/neUiWkPcRt7PpZj1QWLn54KvODe/9G5Cd3rIZDAva
         0XGW4+zU5hC6bbUOXM1P0KLaiTNQrCr0Sb8iIMgbwEukqXQyij6elGmW0m0k3aiseVFQ
         6H71+Ia8vvryZGDbKNe+2QAtIpQirVTm9O+TsNSN4BitER7/TLBR5SANK0Z4I3Ebda6A
         gzXh/3iFBAW6yilsqZdfLqIZN81L+zL39HQhM+WoFVfCnjOATOvyDjoJCFzgLzAgXL3E
         J2ueVdTuZlkOdmghPrLYJMwP4/plbbtMiTWt19kyGE93sXxLnFLFt5OqDE0J/2KFUowC
         My4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=SpBKqyRF;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.104 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=SpBKqyRF;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.104 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 03/10] mm: Assign memcg-aware shrinkers bitmap to memcg
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
 <20180324192521.my7akysvj7wtudan@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <09663190-12dd-4353-668d-f4fc2f27c2d7@virtuozzo.com>
Date: Mon, 26 Mar 2018 18:29:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324192521.my7akysvj7wtudan@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM4PR0701CA0036.eurprd07.prod.outlook.com
 (2603:10a6:200:42::46) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3672631f-1fbd-4a90-be9b-08d5932e52e1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:vtaF47MELrRl9Jr388orFgqBuwzx3vR0rx4AJje/yNE8DZbcKgw30G9cKASrXjUcxCY5cOjSJSGspJWnvHyYWGK2DBL49lK9K3QsxSUglhTYbur6GgtN43otFVqzY2X5GSz/5Ztg1AM6WAJXMl5m42+xapy3oPnpIEWhZNuMMpyQApJTVrdRTM59AQs77nDbsB7taiMNWnHFFn1VHmG6Q6gSCWME5W1RdOSsL1kJbqbiqOEe4zNeOhaEg7XT20lI;25:O05S8UPrIWW2hji0MG0qEwlTbvzxlpdVVkXpag+6OdlDkhDbBeaSnVheqmjNgvNGNrqoKwqO5kUPIhzHJqcgpc2qewOyS8pZP9tOTX1s3L9b0NOyK68kOGreLrCWmUsr6LkrpzXyy9YTdEJXWNPGlYmHherzRR+1wvJWnGu6eNg43X0r8l9yiXtNJt6mYGIHlRNyAxvyopb94a9908GOBSbGAMfLJqD/xB6ryQD/yag/Y3Z1LvwoZ4DwM944nLdjyDgKGLdyoE/364XHNEFlIcfqM0L8FqKNZ0XIDBZLUq7uzQZI/EhICutfZ0+KPY40ntJE9CtgYv3I5FtFegSMLA==;31:r+8iBx4NiIAyOiHAbw5OFTzZlAPRdwzrxyKjkBqhvH9BZP5fMsAVvjwEL3jzKSfPuTheTJrTM4n8S6BL/XqJiO7Hqx8+aU0QN8kQ4KCnp3k6NZSIDFbrLfisjFZOXZVU+9Tnhq5qLEG9WFqiJf4dwgPAdf6j3RsnROA7wivuflzNoL3pCQKKfR5HL+uIBj08n33zs7xEAjOYPpDvXqi+yBtisoQRrR3NEb2S9C1dtKs=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:2kgIRjbgizhqcFnB9DJghIGFNGXE1DUGLpEYxU/uXG3y6LAwZiwzqz/LV6fqroj5CrZyVoJXyIfqLorcG3LZfvJHEPGf8k4zlFjlghAFmYAFlu1LW1y417wQz6S4OoyVN+hFdEtOWSX5xmQBAJBzAOaNHvDa5X6Zl1hhpE47cCl2adCdYspySSJ8FsZaJV//dO5rHEnDw2PXoqGWUrI5RRRJCldGABmx7jOuDm3d+noqifWHAA3SyNos5doF0MVc+aOHnI6b4JXRmg+Hmx0J1Wvup42/f6DQBjLVcyWd8wEiiILaZgVXqbTMyMb8OpYIlv0MSwhjB9y7ZbiHFbPE0VBuIer7zqm/17aYOPh+YFDzoy9zsjIkOWfTGnJ5ufTz/NVJ3BBtLtyTelcxr68MvyvZccalFOv6zA/Rtt4ja+4K/4Qtbh31meuZnZriZqwW72ouhana0C2T7gb1YTTKkAR2dXxNUHUgyjtwkOqeQDlLfgzVPwAiO7Kxu5f6Ru+g;4:LcC/Woc5T4LkV9NSqEM/efVzPlNO3bdVZ0Got+04xo/0aKUicYa8Yb4yWNj7J0pPSmDLGlxgiVe1Ze4f4rc8JPCOSJovhMvE6MfZvgmumW9sTFyLWUlQQyKRwCYtqNN20sBbzBiDDaH6ApEUmdNj8pD0o1fOg8q+aCv5J+qsOWNb6i/A/jGxg3ahtJcHj14Tf84uZ16hisV/FxveQNAhwaKi8qbG9BJtffwTdgcJUKvOcYZ5+CHFUJXNqvXW1NaHU1X0i3ISIORlUUucal8S6Gd4hVIlN3KmZdgzIPeh93vOD/y0GpgBbI0Vc6hEw7jH
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13382D4A7EAEB53270BE745CCDAD0@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(39380400002)(376002)(346002)(39850400004)(189003)(199004)(7736002)(446003)(3846002)(8676002)(6116002)(81156014)(81166006)(6486002)(8936002)(230700001)(11346002)(31686004)(186003)(66066001)(65956001)(65806001)(956004)(486005)(486005)(47776003)(2486003)(2616005)(53936002)(6246003)(229853002)(86362001)(52146003)(55236004)(6916009)(6666003)(26005)(31696002)(23676004)(106356001)(53546011)(2906002)(16526019)(5660300001)(52116002)(68736007)(65826007)(39060400002)(7416002)(386003)(77096007)(25786009)(58126008)(59450400001)(105586002)(16576012)(316002)(50466002)(76176011)(97736004)(478600001)(36756003)(4326008)(305945005)(64126003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6Q1BaNDV6T05tZ3lLRkQ0MWUzODNPd25o?=
 =?utf-8?B?WTU0UVpUakZZUVIzTG5zZUVEWGFGbE5VL09GZDdVOHZkYndPWWdPMVVnWEpw?=
 =?utf-8?B?NlZGZitzQ0R2SGUxMHl5b0xZVU02UStCdWI1TlFvT2w1RzRveUViVnVDQ2xE?=
 =?utf-8?B?dnYzcWVhOHpPdlpQMWwxcm44a0tHM0pBQVlEYWZ1dFN0a2Zsb2EzOHovYmZN?=
 =?utf-8?B?d3RUNEZtc25lbWVhaHlFTVFvRFd1emVuU21hVlZzTktmL2hUQUltZDZaNkEy?=
 =?utf-8?B?YXhJeVRuZHR0czl3SnJ1Z0xSZU5QQWZ2WHo3eUp0cGNIME50WjZCdFNyTXpi?=
 =?utf-8?B?ZEJsa0t5Ni9VWEd6SWttWnZNYmFSZXFmUEM0TkMyV0VTT2hKaHNnR2F5OTgx?=
 =?utf-8?B?YTJ6bHlDN3BDWG9WUnB0VW96MTEzMWptRGhlYkhlUjRxaWZWRUJSWjNVdm1L?=
 =?utf-8?B?SkxPazI2Z0FKUFBlMGt5R3BSeGRVSFNRdXcrM2ZuRTYwYjNyUWV4bVpFczBG?=
 =?utf-8?B?VkhxSlBqQjdwZ2F2QlBITWRjRGdnS0U1UXpPVHhnVGIzcUVIRmN1dWRBU0hK?=
 =?utf-8?B?c1NwUGptS2ZnS1gvOWpFZjFKa1RwQWg3Z2lzaGJvTmdvaW9rVEM5SW93VDhl?=
 =?utf-8?B?Tmh0MjNOb1BUYTY4cE96bjlFKzBZVmdycTkxVHA3Tm8wRTVmYjQwSEFMcTQ5?=
 =?utf-8?B?aXc1QzAyS2owaFBwWnI3blEvVjg5cFIzVDVJYkZ6SFJUdi9WUkpxZEdycXZh?=
 =?utf-8?B?UDV5SjhWL21UNGIycVQwSE0vMlQxUytTa1IwejRiKzUzcWJiNVg5UWtsK0hD?=
 =?utf-8?B?L1VGdTlzeTJFUVR5OEx6a05nYTgxTzU0YW04WXlZSTd3U3oxQmplVTJrTG42?=
 =?utf-8?B?Q1RMSFJPZkZ3N0ZXR0hiL0NkczZTcktYSE1pcEpRbEZlYzBrdDl0VEwrK09j?=
 =?utf-8?B?UEtDRFFRSFFaeC9iUUtmcWorSlhzaGwwSkY0emhxVHBvYlkvMmlRQlBLcys0?=
 =?utf-8?B?c3l2cmc2NWI4bGNyeTFHVTJzcENia0FPLzRRaDAvdWtHQ3lnRll0c2JWcEwy?=
 =?utf-8?B?UzN6eXJLeXFGKzUyenN0Nk5zeHFnTjJ6Q3pUSm0xWDd4Rkk1bE9qQ3haWitZ?=
 =?utf-8?B?eFZzVlBaNGdwTm9nY2I5S3BxcVd0RTJCWmtRQm83aTJINnFNVks5VjhoTzZK?=
 =?utf-8?B?TFJ0NXhCZTVsVDJ5bnIxbmpSM01IdjNyem0xZlpiNlV6ZXphQVhtbFU1bTkz?=
 =?utf-8?B?U3BRQ0c4MFVFUytSd1VGQlBlbUFGRXpSM1QwOHROaU03U3BqRDhZZ3hXdWky?=
 =?utf-8?B?MHNFSWJnNExrTHMzQ3RBNllxbFhsd28zNHNJNVU4SW9sMFZJa1ZNbjhQL0E2?=
 =?utf-8?B?UXJBZkVtZ1UxcFlzM0pCVkJ5QzBaNVl2SStQV3pjVGVhYngzNXFINE9hN1Rj?=
 =?utf-8?B?QzRCUFhOd05DaDcvRHFvOVVrN1g0ZS9pUkcvdFZGbWFETXpzMkthWFFNa1F2?=
 =?utf-8?B?Tk8rMWFvTXF3Y2sxN2wrNnlVMVVUYlVnKytCcjZad0V4QW5HdTRsNktqTXZw?=
 =?utf-8?B?VlBXbnoxSWQzUFFlc3FtdVlMUGN3V2VXL3NLQVlUZFpZc2l1T0dqc2dlVG9i?=
 =?utf-8?B?NUtXZGZVZkxpSVJRUHBVdGNOQTZvK212ajBaUjMvbHJ6d0RFUzdCMkdTRmF0?=
 =?utf-8?B?NE9PNk9uS3UrN21lM1gvOTM3c3VqcXFvQzA2UitzcXdIdnUzQ1ZUcldhMDlG?=
 =?utf-8?B?TkJMbnI2T0dFcW5Td0VCZlAvMnFpc2FmYkE3MGxiMlIydVZ1SHJkekVhNiti?=
 =?utf-8?B?cFg1MXQ2UEdTYlhpN0F0SFVIL0ZHNUJ6c0R4WE5VTys4OFdtcjUwQjMyYWV4?=
 =?utf-8?B?bFhQL2NZaFF6eHhyWDUwNHR2RXYyY0FBUEk1dy9waDFlRWltQ3NvdGQ2Wkxv?=
 =?utf-8?B?aEt0dlhlUlJ6QTFyUG9WTHgvanlOamZmRXJnOURCZUlEcnBOc0RaLy9iZHFa?=
 =?utf-8?B?ZkpuamRscHdrVVpnZGQrNnpXd1pQZFQvMVBNOGtrNEhpK2Z6aVJKOGxpdXd2?=
 =?utf-8?Q?W+QESzxFeeYCzCEk55G3RNTNY6P?=
X-Microsoft-Antispam-Message-Info: 2LliHjtGpJuZyWyoCQUc1FOA9KFO69tyOGaucMYwK7bpYVRG3aVFj6gai8UB5CFiAQwWNNra7fqBlQWGz2Wz1d+5FCtocCUCZ9dB021wPM3mizwFZhtgb2clRH/XbnmQSZXyECqXdTWFZ7mvznyvfAAWVOhmC9L9sTkVH/Rfigv+sh++kxIJD0DyH75hqh6J
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:S4et+pD6o/4Mi8y/ts4hie9cUbSpkvADAe4p78zeB4BdN3M4ppCNSjbFPVv9YtP2dc3rUKUDrVgh6LZpj0cIa9W8kBHipTZb4AbWPaApJag/26izfBpiAI3anCezRztWPi+YSog7mNvLPNOx7brcnadzEomIEZJCiFCvfeKjm5LNbI5t40QHpi+0/NfG1RyGaXjlr7egaQJ8+rQZ8TbitAxDobTIFFcB5STr8VHRm+63m3cipN8mENtt/y+px9b0C+ulwqPoYWgVZkhU8Jya6cqJjfw0oAGxYFEAcfE4hIre/2O1M7oq5yt8lzFTQoSbZokEWs6vfEQsc8eTJqnv5kyvqkrtn6SFtrGQLaoDKVwlBZ+GmHbKoauQHuKCpUxP66qaaBPxtdZobv2uQr8LKBceHHtWY9aPZsHE+Rvm4x22OOa+zSsj/tnontVaQatidqN0pftxcDCVXePd/6WwGQ==;5:MwPER1d7+rTETnVEpTqOC7HEMujg2Kv981s5rebjOahuZuahB3E5s7RzlH2kJGHbeerw65omvPc9uaWJIW+SXfK6nqKP/L3y4h2k0fAoYGe2j7BipDrSRkRDccDqZMADYXZNTRYmBBgbDN0Wqk2MLOq9zNUM/heXD/WEkvhIaOo=;24:VLpqBCV8TP/pMvaTN1/tOdD0vkyF0PY7sc9sxgxbD2Us1F/JB4osqaFIejd/KwDUc28uqtmtQ1df5xQ+QnpBT37axCPd/2DxdQ9PU2T4nmc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:9s4bHO1FT42Oj+qeutI9EbtMll5niROXA6FDKIhbuQB9R0uMNlADmrJOsMNNyx0lttRBS7yur/PRqnc7E5pTooHjozW8B9e0iNUjyPtA2Su8a0X5nJwNeuESpY6Ifuh+vQaV2yf0YoP96AwkKkni9sFmHDvC3/J7ttTRTuK+lKG7NmXMR0nsj0npy9JSUtpR+Tcvd5iVm2+j2AUfjOb7n+BJSGPuFaKXSzKpwIT03vUHlVRIu/sjRSEdvUn2uYfF;20:OM2Wzc2cgaaT+nsfJ4yMKcEZfF9AlCTeXplKbFTUwhq6OAWTklj7Qm4R3chwVSykb70QIBzemL1xb9GF4xqxYdC5omuCQxblHr5+f7NxiVJjqs+G0uabxBInpphSK5G845Me7NRFUBVDh1ZkrePalTyfyV0twpBYF4wwtus4RXQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 15:29:09.0316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3672631f-1fbd-4a90-be9b-08d5932e52e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1596014627459253863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24.03.2018 22:25, Vladimir Davydov wrote:
> On Wed, Mar 21, 2018 at 04:21:40PM +0300, Kirill Tkhai wrote:
>> Imagine a big node with many cpus, memory cgroups and containers.
>> Let we have 200 containers, every container has 10 mounts,
>> and 10 cgroups. All container tasks don't touch foreign
>> containers mounts. If there is intensive pages write,
>> and global reclaim happens, a writing task has to iterate
>> over all memcgs to shrink slab, before it's able to go
>> to shrink_page_list().
>>
>> Iteration over all the memcg slabs is very expensive:
>> the task has to visit 200 * 10 = 2000 shrinkers
>> for every memcg, and since there are 2000 memcgs,
>> the total calls are 2000 * 2000 = 4000000.
>>
>> So, the shrinker makes 4 million do_shrink_slab() calls
>> just to try to isolate SWAP_CLUSTER_MAX pages in one
>> of the actively writing memcg via shrink_page_list().
>> I've observed a node spending almost 100% in kernel,
>> making useless iteration over already shrinked slab.
>>
>> This patch adds bitmap of memcg-aware shrinkers to memcg.
>> The size of the bitmap depends on bitmap_nr_ids, and during
>> memcg life it's maintained to be enough to fit bitmap_nr_ids
>> shrinkers. Every bit in the map is related to corresponding
>> shrinker id.
>>
>> Next patches will maintain set bit only for really charged
>> memcg. This will allow shrink_slab() to increase its
>> performance in significant way. See the last patch for
>> the numbers.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/memcontrol.h |   20 ++++++++
>>  mm/memcontrol.c            |    5 ++
>>  mm/vmscan.c                |  117 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 142 insertions(+)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 4525b4404a9e..ad88a9697fb9 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -151,6 +151,11 @@ struct mem_cgroup_thresholds {
>>  	struct mem_cgroup_threshold_ary *spare;
>>  };
>>  
>> +struct shrinkers_map {
> 
> IMO better call it mem_cgroup_shrinker_map.
> 
>> +	struct rcu_head rcu;
>> +	unsigned long *map[0];
>> +};
>> +
>>  enum memcg_kmem_state {
>>  	KMEM_NONE,
>>  	KMEM_ALLOCATED,
>> @@ -182,6 +187,9 @@ struct mem_cgroup {
>>  	unsigned long low;
>>  	unsigned long high;
>>  
>> +	/* Bitmap of shrinker ids suitable to call for this memcg */
>> +	struct shrinkers_map __rcu *shrinkers_map;
>> +
> 
> We keep all per-node data in mem_cgroup_per_node struct. I think this
> bitmap should be defined there as well.

But them we'll have to have struct rcu_head for every node to free the map
via rcu. This is the only reason I did that. But if you think it's not a problem,
I'll agree with you.

>>  	/* Range enforcement for interrupt charges */
>>  	struct work_struct high_work;
>>  
> 
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 3801ac1fcfbc..2324577c62dc 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -4476,6 +4476,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>>  {
>>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>>  
>> +	if (alloc_shrinker_maps(memcg))
>> +		return -ENOMEM;
>> +
> 
> This needs a comment explaining why you can't allocate the map in
> css_alloc, which seems to be a better place for it.

I want to use for_each_mem_cgroup_tree() which seem require the memcg
is online. Otherwise map expanding will skip such memcg.
Comment is not a problem ;)

>>  	/* Online state pins memcg ID, memcg ID pins CSS */
>>  	atomic_set(&memcg->id.ref, 1);
>>  	css_get(css);
>> @@ -4487,6 +4490,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>>  	struct mem_cgroup_event *event, *tmp;
>>  
>> +	free_shrinker_maps(memcg);
>> +
> 
> AFAIU this can race with shrink_slab accessing the map, resulting in
> use-after-free. IMO it would be safer to free the bitmap from css_free.

But doesn't shrink_slab() iterate only online memcg?

>>  	/*
>>  	 * Unregister events and notify userspace.
>>  	 * Notify userspace about cgroup removing only after rmdir of cgroup
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 97ce4f342fab..9d1df5d90eca 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -165,6 +165,10 @@ static DECLARE_RWSEM(bitmap_rwsem);
>>  static int bitmap_id_start;
>>  static int bitmap_nr_ids;
>>  static struct shrinker **mcg_shrinkers;
>> +struct shrinkers_map *__rcu root_shrinkers_map;
> 
> Why do you need root_shrinkers_map? AFAIR the root memory cgroup doesn't
> have kernel memory accounting enabled.
But we can charge the corresponding lru and iterate it over global reclaim,
don't we?

struct list_lru_node {
	...
        /* global list, used for the root cgroup in cgroup aware lrus */
        struct list_lru_one     lru;
	...
};


>> +
>> +#define SHRINKERS_MAP(memcg) \
>> +	(memcg == root_mem_cgroup || !memcg ? root_shrinkers_map : memcg->shrinkers_map)
>>  
>>  static int expand_shrinkers_array(int old_nr, int nr)
>>  {
>> @@ -188,6 +192,116 @@ static int expand_shrinkers_array(int old_nr, int nr)
>>  	return 0;
>>  }
>>  
>> +static void kvfree_map_rcu(struct rcu_head *head)
>> +{
> 
>> +static int memcg_expand_maps(struct mem_cgroup *memcg, int size, int old_size)
>> +{
> 
>> +int alloc_shrinker_maps(struct mem_cgroup *memcg)
>> +{
> 
>> +void free_shrinker_maps(struct mem_cgroup *memcg)
>> +{
> 
>> +static int expand_shrinker_maps(int old_id, int id)
>> +{
> 
> All these functions should be defined in memcontrol.c
> 
> The only public function should be mem_cgroup_grow_shrinker_map (I'm not
> insisting on the name), which reallocates shrinker bitmap for each
> cgroups so that it can accommodate the new shrinker id. To do that,
> you'll probably need to keep track of the bitmap capacity in
> memcontrol.c

Ok, I will do, thanks.

Kirill
