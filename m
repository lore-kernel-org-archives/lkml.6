Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELtvBa1pnq4tixxeq4CWCRk6ye1djqRjzKs+jipGfIQovzuWNWSdnAsHRPHXm9Vq0XVO5RCQ
ARC-Seal: i=1; a=rsa-sha256; t=1522078718; cv=none;
        d=google.com; s=arc-20160816;
        b=C8xlAwWIwc20fdJlaKcJpVeND9p3f3fkWQrAn7mJQ9XHgMEawnvjDveA8QU0A6nCfc
         ZLvwZd0k/XKOmjabZzTuFXxRc7m4rX7PJWQSrquHFVjFgKRxgw5r1bsqzRSvjZ8KXq36
         sVHTGyiVkEwVYNybInoCMJP5n/aGemC3PU0uIHT3HEgg8qSef31I3LEecfxd7dx3rsT5
         MX/6F3VX7m0tmy7N/sqf7EbzGKOpKT9KrDevRNHk8AyYn57VwRSf3ZhnF6yw7x4fJrL+
         vhS4OTIg9M9lKOJuxJ+mN9kkhVatzC5iUOGGRu/qC0WFWpj4RPS9M69pnl97GavRi0fb
         MsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=kLGXdPOg6f2L7FHITDdFeMxH72r/TpUgKaEN02VX18c=;
        b=djNYADZKRmuzWolOMGaEwEU4XcvyylIlWALuD9D5JBHRfYljmViOXZEJvv3vhNjNg0
         yd2VVkIJjwGfyUI2CVtsSVs3t3LxJDkSKwi8QAScTS1I5y2/qvusHBAU0bMp8qUC2Mw3
         IeslL/jatF8yFWMd6/nb/82FTtXnv9z5KSwPXN1wPCEcbRw0G61Npl93jYQjI/OfPvMo
         psld5aUETXiySm8YpOJlnhEKLXrw1Ea7bXWCpll8sx7ZzHrl8eCsx0EfOSkpQSTCZFth
         dkmV29GZkp2UlHuICcN6+DMX79H2R5syTSDO6J2BzK4JDMjptL7TEXVaYDk0DqEwcEke
         9wwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=IXcq1cCY;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.126 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=IXcq1cCY;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.126 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 01/10] mm: Assign id to every memcg-aware shrinker
To: Matthew Wilcox <willy@infradead.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, akpm@linux-foundation.org,
 tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
 gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
 mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163847740.21546.16821490541519326725.stgit@localhost.localdomain>
 <20180324184009.dyjlt4rj4b6y6sz3@esperanza>
 <0db2d93f-12cd-d703-fce7-4c3b8df5bc12@virtuozzo.com>
 <20180326151406.GE10912@bombadil.infradead.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <a0152b4b-28f9-5970-a972-8649a2b81a6a@virtuozzo.com>
Date: Mon, 26 Mar 2018 18:38:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326151406.GE10912@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0035.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::24) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a4ed713-ee49-4bd3-49bf-08d5932fa2ba
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:nTr8luRO0cJk1NcOusGl6e3PBGnncy7Nb6pJzX/qWcjGZrn22kgDthSg0XBjNbcyb7b3rBKOd7utvYKUGYraDyY2i1wt9MnH233EKrScfOov7QCIF+5gW15dy5/RHtFdo5Ox6lWDAPpklQuXcLjsv+Mf3T0wurneJGVBplrTAjOMgwMblg9+MlLjNmE4+xZlSkvq0aF1gB/XZiof8celZEjgVDkNwwkV/y2Lt6pcF1Fa/F/YSljevDi1Zd9DAYZU;25:eDBrPQM1La2lzbqZBRi4FFn1/t5UAPmmgKO0LCFJfApQ9qkH30PmU4DCuXd63Xn3yvUXsz7vwwKKd9fFUFGuDPDeRnB+NQdfr51/PNUAK49FNo0aAFOiGM3V4PRetJGryBmzJOhm4kNBx4+XtLjXsOZazDnDswMeyxkd3fhGPmEf1FwbGpVUz6kOiCo9Vn5TAVmiGXZ8cFVn16MXqs0T5M858cWeFdmydvPZnv5zulZzFYNGTmMIxdFDMGr1HP3RpkZcQSvdUG8JdFVOW0qXHZoDVNO4VmtMkn8Zl7IEkXfBL9/q93SSIe9lO93/ntz26T+vP9Le1k1EJvvaqlLnrA==;31:+HiuqfZeR3icuI57zMkLdE/gGRJSh8WsnSGt31KHhXh+Yok2etfq3Z/toa8buHCFiYKLfjdWHPy05dd4ZMyglevdCoR8eYNLqgPgePB6jYS4O3PZRB4pPpb1fn0wjocYKGK8HXKRL0gktKvhr0MoFL1wzv2FeQ8QlH8kShZTA+g0vcqx6gtn8EnfW0hru95m5FivQ7zK+hDJXqoXCTdLnGd2ZpMB3sNCF7jukZ7+Ucs=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:QWQYmcYgEJI6VWDNhDCwpjxLKcrmD9TAaZR/h4X9jaVEnSsIJUQGIK8KsP6ZKSYkIGSxZrSPeSk7JFmeW6VniP6bgMBPwyMO83u9AQ7KfGH0oSGE//3L9Heq99FIlOEZnaYxjgqR5xBYQwaPx65sF5Ba3dKIMO/9AaJQFR2Ft0r6kBHr9efR09rOK3gqrI/B3PpYNCpS8G3edr8q6/td8TTN/khvwl4TWH+/cJdS1oHQ5owEkifftzjVMAHxPrq8d68cukDX/ydGxKHtVwV5NZciGsTl3og4CGh/MXMFzlEXzf7xgvynKGfQLDI2gCOXI2AzyFq5vxaww6OVDv/MaEglHl6h9Rzeov5JtSFwhzUcpt/Q25MZfFN10SuWPRz5ccAbu9LH12CO4lg6aFYpcijvB8QRgJWK2R2Y0weAwvHsnZqy+byf8zaDE4HLGQc5LCtQMuagg37nE2QXvsNb4syzluhUln8zKL9o9ZVQ5pfKzdcIVn2G25p5ct5wKoQp;4:HMUMbrjpFABgz2For1bEbzVMRbUQsgeQeMnvffWBKIufqV52V9yChAsC6aANLMn0lNaCIx0BgcFsvm0aX8jzRQNMdo8+3R3AmFg+aE8U5GccEZcBsvDZZ1j08iAgPbqxAUVo+Ta5PebhOSHiyBPH2awLdFMolcmjQAIrHn4OvWekPBMO+22eI8LdmUV0yc5Hp9rYEaoEs8qrlkGj8gZUYKIC5mv/N+vMyLx0vhZQFDgr8UrPAw90O1D40zBN0YDyLwNWwIGg1sXqA7WYzkqRcg==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1343F0178899414C60490352CDAD0@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(366004)(346002)(376002)(39380400002)(396003)(199004)(189003)(64126003)(76176011)(86362001)(65826007)(52116002)(65806001)(31696002)(65956001)(66066001)(316002)(81166006)(8936002)(81156014)(59450400001)(31686004)(68736007)(8676002)(6116002)(229853002)(476003)(3846002)(16576012)(23676004)(2486003)(52146003)(106356001)(55236004)(186003)(93886005)(53546011)(77096007)(386003)(5660300001)(6486002)(97736004)(26005)(16526019)(39060400002)(6246003)(36756003)(58126008)(25786009)(4326008)(446003)(956004)(2616005)(11346002)(6666003)(305945005)(7736002)(6916009)(53936002)(2906002)(50466002)(230700001)(105586002)(478600001)(7416002)(47776003)(486005)(486005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6ZXFqZTZRd05IOWp5WmNBL1ppZ0VPd0Rj?=
 =?utf-8?B?Z2hOWGcrb3pib2pXMXduWlNRVzloclNGZVFGNlRGeGp2RXd5dkpadnlKRkM3?=
 =?utf-8?B?Rzg0d2tsbEpzWGdKdWNKV0ZrbWNucXFFMk5pL0JVS1ZjT0VwZVMweTlqN0w2?=
 =?utf-8?B?N2xOWE5KYVJIeWNaeWh2Z0Z5eHpNMTJxNFJYcG1oZU02NzlxRjB1Z2pDcjBQ?=
 =?utf-8?B?djFzaCtoNmVuZTBaV3B1Uk8yd2VLVlNZTnk3STMyQmJranFQL2tUTkxRVlVI?=
 =?utf-8?B?Ykw5OStkTW5QVXk5UEl3NVNEQk5ZaS9JZTYyNU5Td0N3dUxWTzBuUGxJVSth?=
 =?utf-8?B?aFpPTTNuanZqOHZsUEtsT2RZc1ZXaUoxNk04RkovNnBsRnNpUjJVWnVnUjFC?=
 =?utf-8?B?a3R3L0ZNMlI5eEdJVkptZTF6Zlg3cFNWUVN2emoxdWwzT3oxbkQxNzhFUnFG?=
 =?utf-8?B?Q0pGVlN1K0lORUl0MXZaVkxVL1ZNTGxzR0ZaRVVEci9OWXZjZDkzRlN4eTha?=
 =?utf-8?B?dzVCTGhzbC91aXVuMnAzQjg3QUdVMU9ZZzk3dUZKMjBUNUNTdngrRktpSHB6?=
 =?utf-8?B?UnY2VldpRHlrZzNTeDJPd09sRXlnMVp5TlpFR3pjcGxFYy9GZldaRkpKckpJ?=
 =?utf-8?B?SnhCNC9MbVhnV1RkWjNRS2dhU0dOSEhTekpDSlJNSXc3ZHZneTlycFBENzVp?=
 =?utf-8?B?aGF0cU5rNHJBZzNzY1FRK0FhZG9rNHh6aFBLK0x1MGQ4VHhBZGtabFlHekJB?=
 =?utf-8?B?ZmJkUThxVDdrZ3JURm16Qm1OTEQwNUQya0FCTXpvODJlWFRPRnBrUTJYWTc1?=
 =?utf-8?B?OFBCRzJ3dXR1T2JiYVdWdVdkUXZRdlI2ampVYXBUY29RVVAxT1BUV0hUbSs0?=
 =?utf-8?B?WXpuQ0pFaVYyQ1ErUXIwcFRWM2Jmb2FVdUZHeXdhd0YzNE1oakFHVFZSTDVK?=
 =?utf-8?B?dnBHMTgrZk5mSjY2emRxT1hRMk5GTXNGemRDalA4QXF2VWFpS04zS0N0Sm9H?=
 =?utf-8?B?aWdpeldzRTIxYUNUUmlwSFpXRDQ0ajJLZS8zVFVuQmFlczJNcWxpeEp5U2Jt?=
 =?utf-8?B?bFpQeUN2bDU1VE1CQzNDS00vdVNNMDR2ckZWQ1lHTlM0UlNRL3VncGdvY1A1?=
 =?utf-8?B?QzEwVDVYOXU2WU5XaVBoazEyMUtXVG1VVmFkSnU5eis0RmRQTHJCK3JaRGox?=
 =?utf-8?B?SUZCSzNnQi9vUlZ5NnF5WHhldUVwWkk3bnV0cTkzTUhsa1dlZW1KcXFtRGpL?=
 =?utf-8?B?WUVjU0FxNU1nU05yNWtzMDllRGc0QlhpYUV3YzdITkhYamJ4aHRsT1kxanlU?=
 =?utf-8?B?WVBESlVwSUdaZWgvNk0wb2V1OFdyTE82eWNEUXYvYWtYS3RTQmFIcS9HSnlB?=
 =?utf-8?B?cFpGVGN4MklNSmJCd3lGQzFRQ1VSUUp1MGQxNDRFRTBLbCtXckxPNmhRVi9O?=
 =?utf-8?B?YitPTlltUHNmWkFvT012UDhtUHdCNHdqN2FqQmo0L3c1VWwzZ2NlNXJ0Tkph?=
 =?utf-8?B?V3E5TS9yVG9zVm16TUxnaHllNm1jVDY3QURsY1dIWGdpVENNVDRQZnR2SXJ2?=
 =?utf-8?B?ZkRHd1l1TjFSSHZsYi9ZNnYwaSt5MnhHaGd6am1oOWJUeUNWNUpubnlBR1Nq?=
 =?utf-8?B?OExMUzRodmxoM3ovVDcvQVJYS0V1eElKQ29HZ1JNeVNMZi82ODRtU0tqSDhW?=
 =?utf-8?B?a2hlQXNjLytOOFo0UXh1Q2VhUVJleUE0MDR6YkRlZFljS2owditrM21hTTgw?=
 =?utf-8?B?eFkxQlNhZG0zU1UvRG1NSGhvLzhzNUFWRVlqS29wQXJIbmt6WkNsTXJPQWY2?=
 =?utf-8?B?Q2JCOW1PUXhSenVIZS9qdlMxQWdqenJxUnA4ZnBQaEk0M0ZvNUQrM1F1VTBr?=
 =?utf-8?B?MkMxcVdGRVdyd1M5Mk41V0x0S09sWDlzVi9uTTAyTWxWM3FsZGR1V2U1V2tF?=
 =?utf-8?B?bGpMUlJCekh4aVlTV1hSa0ZvdWoyaUhURUc4NytBNi90WVJFcFhEMEJMZ1Bh?=
 =?utf-8?B?SWorbHVTTzBFQVhzcHRYcEMrK1FUQzJXcktTUEJsM0ZaWkZUd2tWd0ZaL3N3?=
 =?utf-8?B?NzRqMmxUTG52ejhSWkVaKzZjYS9MSld5SUh3OXpiT1FzeGVBeEJLTWRNdnhF?=
 =?utf-8?B?NzloUT09?=
X-Microsoft-Antispam-Message-Info: 589XH4iZM48Ktm9mAEybLApW6IUJTYyZQ5bi0JOmsVWaGUyqJ6Ns6c2XOOLpuoSEUVSHWhHQBegT0cxpshPay0J+M3mrtSvWvUFr1K7ckrvO7KIqP0yaKxzwsi56zjytj44HrNu8wITWLYAoDeNxDMwi/SDybSsAcwreOTSJhalR3CDdVku0UyV/1VRTQeLj
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:ie6pPExYgJXmCJ14HG9Zy11sdEDyLkj3fJ8Xxcuk5mvB6CHe5BSis5FonAcFNc/Gps5TBPG39eiOqTPcYxkZy7TTjMwGhKSiGAWqt1p9aj8FVABktWY9rymyvKAAFx4b8u1vJ8z21ERK57sCBqv8sib+sOYnzt9P0H7kTZYw3ZYd43UjguLnLhvkngA4DWrqBwYSvKZXv9GA4odtFd17wH8X1uXRDsb4qhR7U9hWig/1YdnI9kPH7dTepiAU4Cnp+Cq4U7r4w6FEeAHPX+ieM9X0+yt3atJTAEP58z4NxA+NmiX1U9TXsU0kmQC3mUHTZv0Nj8x0w3ezeqcjW+rD6pd9/evS6k8rAbOg26NgFejhHlmtx33DOyc9fiNnOZwk6r0y3QwyiIv7I/hfESKEpq//NDF6piCRWzgoI1N9BDkwdFCxOEm1MpJMJJsrXHI4EBCYNnJmohpCTbq8o1DcrA==;5:d50NGZE7PRNCeybYEQGbrqlGk8XYLkgrprynK2eW2PW3O6cnCdg2a7U21iz7/wbp78dX1U1k3PpSFWAYneN79yrqmFCmV+zO9uSvuXSF6LrFCyr7yAhrb3KFroMyAA9FRY9ebZagipAKApq0ycxiIG+6vu6fO6J153Fqjb3PBYI=;24:JvmV9Za+u4EMYVhz+9ime+acZ2fQh08ec4fja50inIzbyx5ObysrtCeGl+q8oxdanFW/v549ogvNEZlmSGLippOqJeCwfupuwBdZmX8DyYA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:iUKulsbcegTuo4k4/vs0qL1sKgqQXpNXSlUng2uTD5KJGeIm8KD8dPYWs1R5tryfoDtULt6IUult6RKSS6wwrzRU8/XWo0bWJnFtis/dIPZdZv0yYrkVK81vSC6y0DzBrm7O7faCCtwHhGjalO7kY3T2BcVHSj+9/Rqp3pfl0zNAiNAa5sUXmdKmwzMysq18O92QX9ABvl/Dfg9zvsrT0xHD3oYYobh3sDNYvb7mLTz+no7ne/ygrQ+XrB8vccC/;20:QBzsWBdcYQbp+rq68jVvA3bY4GPg0+EynY7K255KB6rTS+C6xk9T30LMdpFl50/MnD//6UfbfGEQ44EXfUIrbRPEmCghYZpjVDrOnOXVFjeu9iu3/HYAShetLROONhhr+x+1sQp2V7kAJ0L5OIhAIs3Mg7dHCaVwti2YCMaWOU4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 15:38:32.5498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4ed713-ee49-4bd3-49bf-08d5932fa2ba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553598792007322?=
X-GMAIL-MSGID: =?utf-8?q?1596015214119076223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26.03.2018 18:14, Matthew Wilcox wrote:
> On Mon, Mar 26, 2018 at 06:09:35PM +0300, Kirill Tkhai wrote:
>>> AFAIK ida always allocates the smallest available id so you don't need
>>> to keep track of bitmap_id_start.
>>
>> I saw mnt_alloc_group_id() does the same, so this was the reason, the additional
>> variable was used. Doesn't this gives a good advise to ida and makes it find
>> a free id faster?
> 
> No, it doesn't help the IDA in the slightest.  I have a patch in my
> tree to delete that silliness from mnt_alloc_group_id(); just haven't
> submitted it yet.

Ok, then I'll remove this trick.

Thanks,
Kirill
