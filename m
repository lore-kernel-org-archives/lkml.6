Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AIpwx49ZTwmfk1tnkzLqsRp1+SKNuNHfMb5oBmmpcU0EbsA68CcgZnMmsyuqr8skcH4upputaNlK
ARC-Seal: i=1; a=rsa-sha256; t=1523377853; cv=none;
        d=google.com; s=arc-20160816;
        b=KDWhoODt9pRIxFhihDI9SZGPuAoyfOBERylYQjsieVjLqI6lzjKxyEA+85y5ZJK9YW
         ihvPv5TOMbagjQkgezyYLMrt1ushZBIWUuw6UXTWtNHvrqaGtKTA4+mGyKJqwPMtUdJl
         JXbl7F1vzCb+d1BgLqC4K90a5r6//a6ZzYFVSwlix0PdeOkOak6Y877/UDUGjFBGCUbg
         epoXCEtV9bNNq0VgJaWkzSboohDQkQ0vcwtzuk4ClnAD4EnxBlryl8WQ5QQkJjpYdK96
         lvk1BYaJWAjVkbeERQTpYCu/9IyvLRmv8NVuUSKUONjEUGhBeUjydBAcO3Tqfvpg5ZyP
         7AZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=5TLPgMIenQU25ufJnNAGqOI7CtqyTleUhRkIDGCZy7s=;
        b=ihqrwy5Gv1b/PGlb2JhfqLhUtct8YBUTx3lOve2VlK64SZ2Qpc7oCiDqC+CIVIsajA
         l0hGYmh/mtScuCuFvEZIjaXeOo6yuv2q8zmaN+1Vls/s7CreQrhVB8plPbJuHIu6n+R+
         cq8pyf9qe8H03A6eAVxo5mXUq4DseWzIvPUiEUofpMr4PLW1yosq2Qn3+bLvfrQ0kXzi
         z9zB3iZwGVf+FvQnYcIBt0yBRfSeUl1Y6OH/SzCZ6j1ZjNM5fa0i/dJAIPE+aP/KG9zt
         +ke+twogy2Aita4XLm88Q0zU1IlC5WqHTFyF6/AUy4KVQLr7nTwsrzxbJq0GD+puzrAC
         UQDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Orvf1AUh;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.3.116 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Orvf1AUh;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.3.116 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [RFC PATCH v2 13/15] khwasan: add hooks implementation
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Christopher Li <sparse@chrisli.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Yury Norov <ynorov@caviumnetworks.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Punit Agrawal <punit.agrawal@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 Michael Weiser <michael.weiser@gmx.de>, James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry@arm.com>, Steve Capper
 <steve.capper@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Paul Lawrence <paullawrence@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Sandipan Das <sandipan@linux.vnet.ibm.com>, Kees Cook
 <keescook@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 kasan-dev <kasan-dev@googlegroups.com>, linux-doc@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 kvmarm@lists.cs.columbia.edu, linux-sparse@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>,
 Lee Smith <Lee.Smith@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Kees Cook
 <keescook@google.com>, Jann Horn <jannh@google.com>,
 Mark Brand <markbrand@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
 <ba4a74ba1bc48dd66a3831143c3119d13c291fe3.1521828274.git.andreyknvl@google.com>
 <805d1e85-2d3c-2327-6e6c-f14a56dc0b67@virtuozzo.com>
 <CAAeHK+yg5ODeDy7k9fako5mcCLLnBrO729Zp_-UtDuzh3hZgZA@mail.gmail.com>
 <0c4397da-e231-0044-986f-b8468314be76@virtuozzo.com>
 <CAAeHK+xmCLe85_QNDam_BVTp9wVzjxgvko2+0JapJCzmciGa5g@mail.gmail.com>
 <0857f052-a27a-501e-8923-c6f31510e4fe@virtuozzo.com>
 <CAAeHK+xnHeznZwofNQVDcBCCMnaEQ6fcRxOcrFM-qQFUsZ51Rg@mail.gmail.com>
 <0f448799-3a06-a25d-d604-21db3e8577fc@virtuozzo.com>
 <CAAeHK+wWN=phNZgC_g5SMf61sCAVM7SGX9GdF1X4v+P3mK=uZA@mail.gmail.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <bfc3da50-66df-c6ed-ad6a-a285efe617ec@virtuozzo.com>
Date: Tue, 10 Apr 2018 19:31:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wWN=phNZgC_g5SMf61sCAVM7SGX9GdF1X4v+P3mK=uZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0101CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::34) To VI1PR08MB3263.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::18)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3263;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;3:wXB1OHAM4kTkLSYYvQXkyCUVJaJRr/gg2qG4Rp0K7kN+KFu0wwAv3+xintcPnHI1kyRKx9IufFM2Ob418Yfec1SwSYbMDNkUWIGk3n9f8O35ZmYhweyAuuLUA7OGvmUAa+vDP5hkHBYVj72Ehr3w5NybI3eydG/yGpta9Wgs1W+iRK5Vm53do8y0w9O5KAFa0mnzmqH7G6myqOO8PujgQhrEkEC6M6LT9qWXQtcz5/VCy2+v2Aqdi4L+VyFguMkw;25:TSrGqi7i14D3DVkz4HMBwVByQgaqPywe5x22tkVBipYDpUJYFZUruNa/86h0UvYQ/RDVo6R71daZ0x3VZjlodgJeQ817TWh7y3WtP+lYEjpN4Dwotq09woKtuPfYqmfd5v9vZ3oli11DsC9IOfE6YUK/e6NrfXJG6uHCPCKPqv8UcJyzfnF85tmOsZ1OhuA/ISvcw5JDAX/HPAG/KyCcJbPjIDsGAARC7/dkU2VqHNx3lQLfgHkNhCKtQcAY45he6HWoEhFhPduQXB8oVAGbSUCasgxfokqTykuit5W1ZxYebFvx6gk6MBSfuWM9jIajXKNZlW5wivlcUbGsOOA8jg==;31:rDcWgPaAj58C4RSuae54gUMpUD/SCUclzvBaxjla9YPOhgpUGu7RDyMHIdsUzMttZNpZBvRe4zbKd8PecCexrpFM9l4lnjQZMrGpoQBL3PTgIWpUSdYhiSs0G6d1r2a/BZB/TjG9aVsFxk7TtZZPyXga38Q+f2Zlo14Iaxai+d4bz2Cs5UIBhI359IQD0lTRpm0ObR2XNFOIK23VkuIBg66rrjsBFfI71Ple2QG4xug=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3263:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;20:BNgFFbQObYbexMVKNmrlM59GZaToobuqSh1TXUv7QR3Kje2LgvfV8KhE4ZbtCI9KTiXUonn7vi0f+Iz7PsundJRP+7kcj1rPH7HKljQSZu3Szf3TEM3DE9QxJekiTx+tNTfW3ThRctzlWI+87D0E0s8687FuU+gVkaT6xX8VHgbSBpZ3IyRiD5i1n4L4V0GTjwDTO69z86a4Iuq2vCh/Crs/7vmx/Vc3iUsaR1PlL0XqFI6CsbutoeAvfB2phY1D98GJgr1P8NuLfFrjAlhqPqLjCaUJJiKqhG1BkDWqSCSG0pfBsaRVumWPC0uYItkZNDyLL12SZ9dCHgX2RBPD9feETAw37aJshmu6uht3FqeIoS5omcIuOs3KqmRUs8/2YTq6PtCQ5+/Mx7bgbhG/wan9F4+u5o97z+MSCKv22HNspukJdH5uhKhJhOTb6cl8EIPmuVYMyyK4oq4lARtlbQeyyQ5W+T1gK1YATbwxBWRLYDafvbKVy3SZFnMfPPFe;4:fAVxLF10wdFSUCjZw3auuU0p7uzCa+pqxRxV6uMsHk9wcD6OJXP/hNZZq0qJtgIdGK3UqU3eF64M9sQgH42kueEdCRFo775qxg5UMfVINWfAyUBzIQOqU3XnHtkFA0zNwug4vLwMZi7kApyWLb533ii3b89r2N8GUW4kLpDdvGcyV8bdBs7gnHH8OsSWx/W75/8+wJ2YDfbsvCHzt++hbDG6ciyUoFheJWoHgYQSfU3DlSa/aRF0COSYNIhZhYxQliYdxeG6YxRbKetNI6ASKg==
X-Microsoft-Antispam-PRVS: <VI1PR08MB32632B972D5ECA4AF0A635F1B0BE0@VI1PR08MB3263.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR08MB3263;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3263;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(376002)(346002)(366004)(39380400002)(396003)(199004)(189003)(8666007)(16576012)(305945005)(25786009)(54906003)(6486002)(478600001)(97736004)(58126008)(68736007)(47776003)(229853002)(956004)(2906002)(106356001)(7736002)(316002)(65956001)(65806001)(76176011)(5660300001)(230700001)(386003)(66066001)(64126003)(31696002)(50466002)(2486003)(52116002)(23676004)(52146003)(6916009)(8676002)(486006)(86362001)(6116002)(8936002)(81166006)(81156014)(36756003)(26005)(53546011)(31686004)(476003)(55236004)(186003)(6666003)(11346002)(6246003)(93886005)(7406005)(2616005)(77096007)(105586002)(446003)(4326008)(7366002)(16526019)(53936002)(3846002)(7416002)(65826007)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3263;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjYzOzIzOm9sbTJSUkw2UG5SMkl1VkFxZjRhbzBUSHhB?=
 =?utf-8?B?QVR4QTVOeWFVZUhFZXZZcE5Zb0d1dERtVU16U2tKNCtlNTdDd2VscEcrQXNY?=
 =?utf-8?B?bVp3Wm5GNTQySDVZaE5SYW9obnhTL1l2VzZ4YlpZUVJmUGxoVWtlQzJsZjBh?=
 =?utf-8?B?VHhuVGJaOXRJdkZrNzdieEZJZHZJc05pR2RnZXZhaGlnT1I1QkRTN3BSTysz?=
 =?utf-8?B?YXl4bWQzUlhMUVU1QzFGbmo2WFQxUTJFMDdObUtWSGI1SThPTzIrTXlvUitr?=
 =?utf-8?B?ZUJGdmxTU3JhbTJ1QnNFc3cwcVhFL3V6Q2hveFZYblpXejB0d3ZXNnhMYnRr?=
 =?utf-8?B?ZzMyM0FJQUlKZjNQL0s3V05rVlRFREF2T3ZDNXFZRWN4K2twYktObVA3cHFN?=
 =?utf-8?B?bVN1L09BSVkxM0h6WUtMVzJTWEVGZDBINGFJMHFxVkRoLzNxbmk2L2hhSUs1?=
 =?utf-8?B?eVVNVTVtRTBtUklhbXBJRWFnSm1nYm93TlljeDJoUjBDZ0pZeENXTWVqeWY1?=
 =?utf-8?B?K1NHdVlReFhIeVJ1MWtGM2VwUXh3a2NOZDRlK05zUnBGWHhvVGtva1hsYUlV?=
 =?utf-8?B?VDdwYTQrTjEvZXE4VlJDTFQ2cjlnV0xvdzhhYTFkMG1TTks3emVpa3dVaTJT?=
 =?utf-8?B?Lzk5cjlhN1lFR0hoUnpYeUJUczZmRFpjNE1zb05xY29HTVArdnVNOW8yN3Nj?=
 =?utf-8?B?TGk4bVd5dXVacnptK0FUc1NZalRJYnNnVWhTK1piQ3pzaXdWZ1REVnZ4dHVo?=
 =?utf-8?B?YkJJanU1YWtXTDhsdkNINkNuV1B0bk5qV1k1SjB0SmszOHRLbXhnbUVFcjZH?=
 =?utf-8?B?clRFeWJvVC9FWWlwelJacmRJZjNneG5HMVRmSW83WHI3MHFTRjZDR05NRUFP?=
 =?utf-8?B?RnNEQkRJY2ZzRm52aTNwVGptTkFnR3o5eElDbCtYT294RWFrUzBIK1M5R1M1?=
 =?utf-8?B?c1Qrd25uTnV5d2cxaEM5cG1heW5GYXdLSlJjUTNUV3BGY3hkdVlZQ25ZdkU3?=
 =?utf-8?B?VC8zQVZOSEpNSklpWU12dVBlRnZMazYwRUlHRVBFa2VXVEhSNHlkWHB4eGh3?=
 =?utf-8?B?WUZxR3ZKMkxEbGd1MDh5RmVvT2FFRzNKUE83aWFaRzhsS1Z4WWpFWUMyLzhC?=
 =?utf-8?B?VitHRk9sbVZIenZLMkFRM0draTNQNlYzeGlsYk0vSDJhdHdGR00yMHNqM3R3?=
 =?utf-8?B?SmlFclVpb3U4dXB4OFNvR0pRLzZmUlRrbnQzbjF0azNUcDRwZjJLQ3piSGVU?=
 =?utf-8?B?NlRsOThqTVFoZGdRRkdiY0ZOWitSME91RWgvc1Vpb0NHRHBUVENiNkQrcmRQ?=
 =?utf-8?B?UEFCUHRRVEFKdFB2blFzSU9BbkN6QnV3NFY5dEkrdWJxd2pXb3Buc09QR0hS?=
 =?utf-8?B?clNJdFpWeXhyaHJwWXFGdDV5aE0wTlROUXkrYU1oNDNGTkEvVnM4ZEEyRVNt?=
 =?utf-8?B?Tjd1UzBqazJEQjdjRnFPMUtRWjR1Mkg4cFF3Y255bEZacDRKTklMMzBVWGky?=
 =?utf-8?B?dmI1OUFHL1d3bDNZb05iL2QwUzF0NGVDaVAva3NXV3pFb0JIQk4xRHc1MGsy?=
 =?utf-8?B?NG5XdkRaSWc2ZjF3WndxQjVHZks4ZUh6cUtlVmFOY25qZGU3QnNKaTB5Umht?=
 =?utf-8?B?UUlHNEY3Q2g5eGNxZEZsYTdWdDJMZFNvT0RqdjE0YUhlOEdvSTRRWlV5TkY2?=
 =?utf-8?B?UlF3bXAzb0ZrN2JpalRTNFdIR3M4c0Q0RFlmaDdVbnBmQ0JRR2wyN2gzcEdw?=
 =?utf-8?B?TkFXMkdFYjNjM0YvdE9xM29ZSUM5Y2xVczN3L1VSMnpaWVo4QlpsRVNkeG56?=
 =?utf-8?B?TVdkOEZ3ZWdkU2J1T0tRMmNpMVBSRmt6SWpFR0hEdE1qdkd5eUwzZW5FMnpC?=
 =?utf-8?B?b0ZsSEphaGNFYzR3cTBPVmpJSWlYcVEyYm9aeFVkRlVDK3B1dWZYWTcvcW0x?=
 =?utf-8?B?QmtKdi9ZMnFQaUc1cWhTQmQ3OHl3cWRvOXRLelUvN0M0SU5IQmtGQUdaYTFs?=
 =?utf-8?B?bmsxcXdUbmxYbzNvck1NWXZvNU1lejN1T1hRTjRuNGJSR3crNlZrRTZJdWp4?=
 =?utf-8?B?QnBJM1NPVmNNS1hhQStRVUNOaU4zRTZYZTIySzdNNzc3YU1oYTRobURmVmxH?=
 =?utf-8?Q?5qEEp3jdVT2OuMHFXESXn98=3D?=
X-Microsoft-Antispam-Message-Info: u25k7VAl/AvFo6wNOPjZ/J1aHlM06WZUzmi2oBg6y7OueiyZEQGu5pWWptdkAbValoz5eWrEXoFOOUKTULo6uxkHF4rbCR2Fzz1DA3fyJO8u2UEQF25qGOTpnoH38ySUkeZWdDGTovg2rhv4VcytBgu+Rn0LKE1scGGzr6+Oj5oxMuVJEBD3JucfnD0mfBY2
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;6:06LrJedWbrXeUwbr2P/9h66WdVudl2JomeAHBPm0NzjkSk8X900NuVRx43GtW/lflBM2ESpPx35Cz2IT2q8sS87puroMEWnhQcqFgXOc6OmSB+s040NohpmfcUOH0Z6FkblZV8gYJeyPneM0BNaoeE4qKehnMOLm0W7Qrujb9bNDm2CSBstJuPb1QyUpDgbzarRsJ5p4h4Wu2a1BmFo7yQpUOkxLl3smYiF13of8tlX2VPqMENnkyi1BxBSUjiYG9YzQk9VpeIcnHZR1orFrdg1FJNx/pkM4fCqUycnIN3pEadmS+a18sHpybrKWdI6Hziy+chah7NA98K+DCkmt4D2Vhf9Inn9T62XdlpKG1kN5A9CXL2tdcpvj/uw9mWxOuD3LjBLRxM1uw60etljmu2aVYpXepu3sLH21O1/e+gvf4sOHRuFCFH7IoCR6FlnLCGAzEOvdfbh5DrBv1wN/aw==;5:e3SA/0zv9OLOHDNepmdGx586Im1Qg7wy/7JsBaeBhsYrUO379anJVsp5xuhiLBcexs0+23VnVeVDEI+SVBMGDYPHGCbiwGYSm4TIkqO3TFEzRCV/8vAMjZewE6k3RkI3p13yHzFqa+ijKBzTosvMBqc/qbvs6+HkEWXY0AcCRgs=;24:9KXjzZbKyVuS7vYFX29zkkuoDnHsDHW6kCCzDCTuRucn7qp0p/4G3C7EkQmpAW5vJpDxSgS12hz6uy3ZexueqrMGW4IqREuKxV3E6IoO2vA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;7:TVWdxtdnCSHHOpnUddg0wD1fRlZYia23rTGT3uerKynXaxYSfHkwFN+ftFTd9DdiaWO+TDMmAvfDO9WaaRneI+xKPjH88M3FKZjT9CPnaEHB6AgHFNxEg3/X77WCV1jdppeUVbKE9u+Mj/nWpUc+uZV+7mjgfaBSab34cCrqxq8neGHizNE6T8tWTdy/6c2Icuq8W+RL/6P7mhZ663+HnBiochrPtHt178D6iUEQ3tECfJcGerpZOfNuxdCFbkRG;20:DDKW7Yt/+rvh8Yh6gaIbZCcJUiMYNtEjSZpP12wFHLgInCTYuMg+IFuKsH0LqIE6j1EGMLxZAvB2K68wQ2k/UV1mI0lCd2V4jZMZQ/M3ouYSk5dB3OZAPeEzGTSz581u/Ejzo47vt6zEMkCpDM+f1EWEMOJA2GlDz5XtJ7gXyi8=
X-MS-Office365-Filtering-Correlation-Id: bdf7a7d1-d07a-4491-7441-08d59f006869
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 16:30:40.2725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf7a7d1-d07a-4491-7441-08d59f006869
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3263
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752721075121286?=
X-GMAIL-MSGID: =?utf-8?q?1597377456079850460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/10/2018 07:07 PM, Andrey Konovalov wrote:
> On Fri, Apr 6, 2018 at 2:27 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>> On 04/06/2018 03:14 PM, Andrey Konovalov wrote:
>>> On Thu, Apr 5, 2018 at 3:02 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>>> Nevertheless, this doesn't mean that we should ignore *all* accesses to !slab memory.
>>>
>>> So you mean we need to find a way to ignore accesses via pointers
>>> returned by page_address(), but still check accesses through all other
>>> pointers tagged with 0xFF? I don't see an obvious way to do this. I'm
>>> open to suggestions though.
>>>
>>
>> I'm saying that we need to ignore accesses to slab objects if pointer
>> to slab object obtained via page_address() + offset_in_page() trick, but don't ignore
>> anything else.
>>
>> So, save tag somewhere in page struct and poison shadow with that tag. Make page_address() to
>> return tagged address for all !PageSlab() pages. For PageSlab() pages page_address() should return
>> 0xff tagged address, so we could ignore such accesses.
> 
> Which pages do you mean by !PageSlab()?

Literally the "PageSlab(page) == false" pages.

> The ones that are allocated and freed by pagealloc, but mot managed by the slab allocator?

Yes.

> Perhaps we should then add tagging to the pagealloc hook instead?
> 

Of course the tagging would be in kasan_alloc_pages(), where else that could be? And instead of what?
