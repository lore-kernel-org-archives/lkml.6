Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+YD+Wj7JoREr0Ff+EqsSYgDi5LRvifR1g+BbLFO4lgfCUb2E8Fr/YXBcuAa5aDGtqV7x9r
ARC-Seal: i=1; a=rsa-sha256; t=1522426006; cv=none;
        d=google.com; s=arc-20160816;
        b=u0Ip2hCe8dmvNLNT8OIN1CVHafWGaz9CAR1uvnKI/U3cW+aOaMwoGWKEgabpxDHG3u
         uOm6U6nGY4JfNTz8LCGeV8Fpv+Koi6IGfMz/Z0xWqPEpfWb1Q4v+3lOUl69GeTtX7+0R
         jPd1Ni9c/WMAYTbnSjvHRxkMbH79CqwkT/dP+yVXtRVaj8dOsf22Fe6ttNH3rEvfEl+l
         LFjncRvlwFFr14k1XvhJPya2zX0GLwwNDVenEohJKAFewIZxPl1ruYdTcLuZJyMq1wH6
         3bIcyXppuoqJSemMqlcnqOJlOCgaHNt7PE4h2Vi2SXR5eOI/fQmgGgGyKGpZAmXIH/HO
         RmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=F6okySfrZnYQ0SZ6EdEgUbhvCMrb6Wgv6A2/PAE9cNA=;
        b=b7JbNnELg7ZJUakDTZ04GFDCfByJARVs2nzKUbboUHInMKYBieZF0yRcQnt26eAHjT
         Lxyj0sZcks1w+n30z00vSgqZkPaRPG1bWGbd8Nl94POQMu7pO1mcxuRvPE+vKk+gXgVu
         HcKt+QiYSuu3TbVvSvSRe3sJmjlbQq39JzjP74eXLhyJdoQXtec4wFV/pdiJOrg2yAYD
         tGrg/Bb0F96KJ0kpY31MoDMzvZNOGisZR9gyyMo2oej6v+sv9wm5YQ6Rzx5eNfyFAD9k
         VWzdoKVfytxqjo0khUBWUf4e5GowBtLt10g+egV+VeCf1O6Kf2pZqaWVdJNuZu/YRQv9
         cS4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=cpJrTOJ8;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.1.134 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=cpJrTOJ8;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.1.134 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [RFC PATCH v2 05/15] khwasan: initialize shadow to 0xff
To: Andrey Konovalov <andreyknvl@google.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Christopher Li <sparse@chrisli.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
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
 Stephen Boyd <stephen.boyd@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Paul Lawrence <paullawrence@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Sandipan Das <sandipan@linux.vnet.ibm.com>, Kees Cook
 <keescook@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, linux-kbuild@vger.kernel.org
Cc: Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov
 <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Kees Cook
 <keescook@google.com>, Jann Horn <jannh@google.com>,
 Mark Brand <markbrand@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
 <774016f707e494da419a2d0d8a03409e6befcaf8.1521828274.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <2ab69c9c-6e80-ea79-e72e-012753ed3db0@virtuozzo.com>
Date: Fri, 30 Mar 2018 19:07:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <774016f707e494da419a2d0d8a03409e6befcaf8.1521828274.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0001.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::11) To AM0PR08MB3250.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fac5a1fe-caa9-43ae-a61f-08d596583838
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3250;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;3:6MuCRtRAIeIhg+7NfWKjy7aebKrRG9PNZuHpBgPCfSF9MtVyiEmYsRO6jryxQJolhUDPRg4+k7xsIt1JqcSy4Qdz4REk4o1iaKvGuSdTTZ6zguv6V7/jNYFTsuZ0tFPK69V3mtPMrTg5u3VrNixvRxRIMVzgMIb2LbIx9KvfcyszcYWrQi+lNu9YgZun6Q7/pNfS6sN+AtRvXu35HGovzGgm3+ccDtSNNDl0do0ZTqjsd+PRMY3u4cMwbkcsBpgc;25:F3DEeYeTKuSuZF+P1Sa7y9ckr7LIclgwUnCYNskWXmmShGz5s2Lt8QVPLmB9E/lxP5D13HguYGwsbsw127w12miagG9lBKDxXhlyCxCjc5VYvo1Kk8FuNdvFlXQmdeiAwi3FLDHQsN8jGRCWHn9FRR0LbvjlrsEvVo5VUiuCKYbsfXjKXADAkcAphTwU6YH8TCWnj8CF5okQIfhMg2GjzMjaYVoM84jrAmC26McRmQmWUjMkIFClTpuX9LkZy+U/AAlQSIb2xrhd+olhtzEwTwyoWJkcfub81E9A6Vz9Muc6ArUY1djNA3dKvnZyO+FlRskfHCGPQqiNABhXeXtFJg==;31:k82fZeNGW5bC5k4vISutlzCzx4WfNq/2ZoNV+GEMl2VD70WdbIjRfknGyhdM6syOv9WhnR/qTXYjNsOLqs+DaH/mgopC7QFSHsu7IJ9zPhUwlxOV1MPPEsimPxwyzmMd8Dis4Gx47NmUABtTquUGkU/o1A9YA1M5Z7FnBvsRUSYNEHiMiiP8eb80biDMe5w9zK9qcmVl9vH2zAQIVY9qrm9VSbJskOZSwUKAuMCN3a8=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3250:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;20:DQfzh6dYp7nxEOSqTAkldYYvJwuIjbaD/IuPfEyYvmEx2nQaMaQ6c9IDrSkbH4rg6eX/do9vBTy2N4o4ci+sIyznZtBxreGuXQrRGKdQXSf2OMSrO4keqqIKsgVfZ5aHbR1Fh+C6RGhrUDUbmkyE0bZRFqGbdgvW1W/VIPfqbe7xviDVS5842iwJp8fhhkhWudDFz8eJutMOsxAHuKky9uZ9IcNp+M4/z9nMdvBEYRcL3bs9/TF9KqYcaNUKsxIRDYU/LqxMsTYIvjWoLME83pNdMlIb269BqwAXlrf/t8bAhRAO1K06s2IxjuS2eDR14FI+yxhGg61cMixUaC+s6ewJKbN4rbCKK4PAnNWcpPO30910shUKseSVcsW/as7SGvsBXprx+3nPXXBE2XV32RK3JWRK53ZZH55DffR0WJuhf7koa5lGUxj7NrevQekZwkEbep+NYihTmCO3dSn6W33vO6ZfOsOva3lT6Cw9rEgSpf0YT7XkpVivXFg6EMh3;4:RtkLT1RkW8H4yuVpI4Xoy1vzrNlsuwfoei3W+/Ro402/Yh0Ep3+NZ//8PAIUidOLQs5BHx2dPVi2w3KC6C0ds6FGlAenIgQm3V0ZSjDdLbyZrA7X3LwrwgmFi5ioxuEOrQLtFiN/i4d5OUF3nGA02yRjBuTNCAvYU/d827sk7ELh32mR2/2fmRlOUtQqGP8pIYWZybhjh47/em1ALXwEcpULKUSCkEBacUTJsrPGUkHi1epq2pzLmUGax1vIF/7Gxj0RAbAQA5HEom9mpXbI+SegxPJze123ccIvwttUtXMr9YUncMt+F74xlqMRFq0rACDPoYoBdArUwL/Fg7bVWT77Svx3W8KaSuNOZlN4iBI=
X-Microsoft-Antispam-PRVS: <AM0PR08MB32503E2AACF8428B469C435DB0A10@AM0PR08MB3250.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AM0PR08MB3250;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3250;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(396003)(366004)(376002)(346002)(39380400002)(199004)(189003)(8666007)(53936002)(59450400001)(26005)(68736007)(52116002)(47776003)(76176011)(64126003)(81166006)(106356001)(4326008)(6116002)(3846002)(2171002)(55236004)(446003)(53546011)(8936002)(386003)(110136005)(476003)(486005)(11346002)(6246003)(2616005)(58126008)(956004)(16576012)(16526019)(316002)(77096007)(186003)(486005)(23676004)(54906003)(8676002)(52146003)(2486003)(81156014)(305945005)(229853002)(31686004)(36756003)(2906002)(7416002)(105586002)(230700001)(7366002)(6666003)(7736002)(25786009)(478600001)(7406005)(66066001)(65806001)(65956001)(50466002)(6486002)(97736004)(5660300001)(65826007)(31696002)(86362001)(921003)(1121003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3250;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUwOzIzOk1pK3hoUVpFRnJ0UVpJSVZkODYzNEljNUti?=
 =?utf-8?B?VklmaEx2TzBBOVUwYnhESUxNN01LVGYxclIzM0liMGU5azZqcGxDVGQxV3d5?=
 =?utf-8?B?OVVjNzJWREFqQ0d3K2FCK3Yvb2tFNGd1dnkxR3Y3VXJ4OHhEdTJ2SzU2M2Q1?=
 =?utf-8?B?TzEwTlgxaG8vRjN4VHh4VVg4cDNKcCtZSjR6eS9CY2cyUXJoTi9KKytCdnhR?=
 =?utf-8?B?cXFlWmc3U0RXOHl6OVZ0VzhPY1hVQzk2KzBDTnFsNW84MmxkK0hDVVVMeEth?=
 =?utf-8?B?YW5ZRHlRR25FWVo3OXN6U2l2T0VUb2ltcG91cXUyWThham1OMnlwZzQyNEtt?=
 =?utf-8?B?TWN5emU3ZHVVQ2ttd252dDhRMFNtZkcwTDhwREsyZG10dVVMb1lDRmI4dStE?=
 =?utf-8?B?RXZmanBNOWQvRFBmNEpnRlYyRVRvWmVxL0R4WkxWejZWbEhrK0xkMXJwSTc3?=
 =?utf-8?B?OWoxVGFaYVVFNUdQQVRscVRkSTFzSkNDZUY5UldFaitHeXZVYjJJRXhhRU1q?=
 =?utf-8?B?b2Y4TXFLV0ZmQjBHY3lIN0YzeGNZb1RYU2wrUFhrOTlhaFlnWkFTMXJuVG9K?=
 =?utf-8?B?VEFBRlVTN1Q4Sk9ueHZOS254ZXNjNjVrd0d1c3pmclBaR1NQVDVJNzUrZmE2?=
 =?utf-8?B?aG9nbnlBQUEraWVyYVdGdDlkeUphQzluMmFRY0I4TG1jM2JtSVVFRk5rMDBz?=
 =?utf-8?B?SmpQRzcyMEdEMnJaanpMb3Bzd1g1bXNqSmQxUERNTTRxbzREMlFIUTRMTlZK?=
 =?utf-8?B?TmkwZHljRGhpOXlRdW8zc284YiszM2JjSmVBMjR2Rys0M1cyZ2k5VWw1UmYr?=
 =?utf-8?B?VW1WOU5vR2swT3I5UHI4RGVhdlRzb3AyL2RybGNBWE5CUTRtRytMWFNQMXVT?=
 =?utf-8?B?MFlZbTN5OW5iaWFmUDQ5aHU3Mjh2c1U4eTRFd0dPVTNHQXIvemJaQmtRYUp6?=
 =?utf-8?B?bjVkZE5wNXQ2U3NwY1Z4OE5aa0w1T3lCWVduVDFvRG9uL1dxVFBvNjhJQXRs?=
 =?utf-8?B?YjVJLzJPUmZ6WjhOOUZoNzRSdS9hUWZHL2dMN21vUjJTdDBUNFNjNElGWElI?=
 =?utf-8?B?S3FjM3JQTEk4ZUJ6TkNKaVhtN0R2SE5DRFRHY2dGVlh5dEJHc3k1Y0VyaHZB?=
 =?utf-8?B?YmlPLytKRlJBMGhCMnBhMWRnQ0VlaENZc09tazI0SlZzK0Z4WVNoclhUbGFs?=
 =?utf-8?B?dTBtYVVkR2l3OVJpblVNM2ZCWmxCeTFjb0FkYmdyRDdkQTJVN081ZTZIb1Uy?=
 =?utf-8?B?VEVqcHdhU1VxZDBOOFIyWkcyQUhrdWhZbjFCNEhFakdvY2RJV01VdTc3bzUw?=
 =?utf-8?B?VUxsa1NYQ2ErNUtMUmF5ZHNiY1VVSU5HSnhmSkpSOVVZR0VNZGFLVklXUHhY?=
 =?utf-8?B?bWkyaHM0SGMyNWxQZ0ZnaGQ5V1ByTG5SRjRCRWprMlhiNGlocTIxT1BNQ0ds?=
 =?utf-8?B?N1lkV3JsUTlTZmFYZW5vdSt0WnpxVEhJN2JkNjc5blBMZ3VMN0VPYjBZQ1Yz?=
 =?utf-8?B?aFcyaS9yNEM0dm5CN3cxanJKREVFL1ZxZXNldGdnOXRGZjZNV1F0MEF5QUds?=
 =?utf-8?B?dHp4WjVEWkxZRE82bnJIVFBKU0RMb1FKZWZidEdEZ1hmVDFQQ09CaEF1Qzky?=
 =?utf-8?B?SHZxVnMzcmN4eWdYVVZmNk9pZ1U0S3h4MXI5TkhqQk44NkoveVVxeGE2bUJr?=
 =?utf-8?B?c0VnQ0FZNHRoQkNBdEQ0Z1RtcFROUUQ4NS9sMmtya1JaNndBeFFpd3ZZOUk2?=
 =?utf-8?B?MzNrY09jbEJxd1BQZU81LzBLb2lPZ2dVU1FBWGdTWkFWRmV5bldidlIyKzdG?=
 =?utf-8?B?WktnaWJqUGZ5L1AyejF6eW9OcFJkWC84dS9SeThrbVA3UjEyQmhsWklnMFhY?=
 =?utf-8?B?UHR3WjlFVmRpQzZ0U0lEQjFSQzBFRGpGcnBjSHI4YVAwVUJFNURrMnJyd1RE?=
 =?utf-8?B?cU1XSnVUUGlhTXY4K01aNVpWQk16OTI2WVBjdDRlQ0czT0Q0ZkdJQmVkYytK?=
 =?utf-8?B?WDhrWjF6b2VKcHp0eWxZc29Tb0JBUjRuM0xmSUdFcVBjaEJpTExzU1V4dnRu?=
 =?utf-8?B?VjhGWVhOcXdERUZRNGticSs2ZHBuNldtVm40NkhPOHJESHdhYk45S21nWjhH?=
 =?utf-8?B?WmlEUkJmb2NCaDFEKzNzc1dNSmcrSUtBd1RrTHdWWnNORG80RU9QL0szWm9E?=
 =?utf-8?B?azAyYWJ4VlY3bnZTTGdWa0pGeW9hbzR6NDZlRnRleHdtMFdyNGE4SDN6cEQ3?=
 =?utf-8?Q?HOPNqJvlUo7xQewVzY?=
X-Microsoft-Antispam-Message-Info: M2tlxnCoV8sOyiaSPNPfbtXSKTeypd21FSRX03v3vaBTiIBQgMVrqzIqMksPymm3O5ctSWMVshNc7d/XN97V4FcqDOcPTpZx35m4fkMenYbvoxNFAPPvF3FJwwIT1Oa0obnw+KjAUzZWU7GXL5J/zgR57A/Yc39BTsyjJEAI+lfwCtVkyg2rIbGRWLJNpxtm
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;6:H5Pr21x7H+LeKjmuZh7Pkf0Mygn8hFepYO4gpayt+762rs/K4O+NwFRan9ySTiBFKuvP0n6iRI1bYsp8fS9TQ9O5cvZN6MhHVrVI3sQGJrCL8YbWRtDGEboQFAC6Y9luQ16yfgTJRtyegfPS7M2InqjWenhbPkaaad+YElP53WYrr0Y2gdDgXz98vom9iPg1uA3c/g4R3NID1707XjTtPjmp1qEA6WL92+p+QYsaZNQiw+ER2frmmfJDaoJJ/I2sinZuQesNfbO9eK+l0H9hqzWkf3H1ERKG4hnQ0f92B8xE2GXzb8980RiNB8YRzK34PyCIiJUtbeguYEl7VDc2Ot3qDzXO0WqOZbaSD0QQ8HhHrJ72xNwKWY2g0tQ0y19/JXD8rpS1GNqspg97Wd6mFjmeylumRBjgOSadAUIizwgT0XmBr0cLA2zq8JYO6szMP+wPbf9z6J+PKq6DnJFDmg==;5:Q8e7Atb5PtBpebdZyhtQ2yC/EUnxrROBlevukp1EqsSNHzJDWcfHNIi9l0E4KiSXfHcgiCZEt9+fosTfkMY/eduRBgpqsmyXOBIAoNVTNJvkUqHSyYDPhLDCb4ZiMiZdTzVQMt+HlRmTa0H4ty01bEjGXrlMwNm0GXky7rxl4PU=;24:+i3VTfBEhBWy81TVbfjIVLyHnIorxyx8pB3Qs4fhY4WnkMVu4JQZY6Hl8BbrwRNEqxvRVCvtQaCJqinHqEvKpueJI7vDNp++tutYI+OiO58=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;7:BBM7E7K3ZRIbuLsGsX8TKi7luHaN1qYIa1Smq7so3zwjkzLakvqCWatBM+lNLDw67mzdORzTjPhOHvV5/uyD/Lr7/Ejbsy0sT+R80n9jmtga7HsUOzgbogmhoW+iE3SjclHi/OyPD0NfqjbSAk3PYf2+ovg0GSMEmvdpgyRtmJ8F8NG4XbVwYvHPRzxSNsMNWmXqdBgJx2COL288LFrjKPQMK+zZr/4vWg4/P1VKt9eyOLEMPb0HNoSypZFNSejK;20:Hc7duev28h9kRMjk9QBjLHlS/KYBw+0rL+rZxkEq8uKvq0IkiW6Dujq9IcJFE8rzDstWJTanlB/15JSNxZtDE7eqhyJ/4PUzAnksuE1T35BWmNuSkTitPdlQL+q8Hbhod/gGbGrMQl77y/GaPm48DqkUrJ/IVNIXtRJu5Sg0lSE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 16:06:35.0287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fac5a1fe-caa9-43ae-a61f-08d596583838
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3250
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752704259499318?=
X-GMAIL-MSGID: =?utf-8?q?1596379371914858379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 09:05 PM, Andrey Konovalov wrote:
> A KHWASAN shadow memory cell contains a memory tag, that corresponds to
> the tag in the top byte of the pointer, that points to that memory. The
> native top byte value of kernel pointers is 0xff, so with KHWASAN we
> need to initialize shadow memory to 0xff. This commit does that.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/mm/kasan_init.c | 11 ++++++++++-
>  include/linux/kasan.h      |  8 ++++++++
>  mm/kasan/common.c          |  7 +++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index dabfc1ecda3d..d4bceba60010 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -90,6 +90,10 @@ static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
>  	do {
>  		phys_addr_t page_phys = early ? __pa_symbol(kasan_zero_page)
>  					      : kasan_alloc_zeroed_page(node);
> +#if KASAN_SHADOW_INIT != 0
> +		if (!early)
> +			memset(__va(page_phys), KASAN_SHADOW_INIT, PAGE_SIZE);
> +#endif

Less ugly way to do the same:
	if (KASAN_SHADOW_INIT != 0 && !early)
		memset(__va(page_phys), KASAN_SHADOW_INIT, PAGE_SIZE);


But the right approach here would be allocating uninitialized memory (see memblock_virt_alloc_try_nid_raw())
and do "if (!early) memset(.., KASAN_SHADOW_INIT, ..)" afterwards. 


>  		next = addr + PAGE_SIZE;
>  		set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERNEL));
>  	} while (ptep++, addr = next, addr != end && pte_none(READ_ONCE(*ptep)));
> @@ -139,6 +143,11 @@ asmlinkage void __init kasan_early_init(void)
>  		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
>  	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_START, PGDIR_SIZE));
>  	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE));
> +
> +#if KASAN_SHADOW_INIT != 0
> +	memset(kasan_zero_page, KASAN_SHADOW_INIT, PAGE_SIZE);
> +#endif
> +

 if (KASAN_SHADOW_INIT)
	memset(...)

Note that, if poisoning of stack variables will work in the same fashion as classic
KASAN (compiler generated code writes to shadow in function prologue) than content
of this page will be ruined very fast. Which makes this initialization questionable.



>  	kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_NODE,
>  			   true);
>  }
> @@ -235,7 +244,7 @@ void __init kasan_init(void)
>  		set_pte(&kasan_zero_pte[i],
>  			pfn_pte(sym_to_pfn(kasan_zero_page), PAGE_KERNEL_RO));
>  
> -	memset(kasan_zero_page, 0, PAGE_SIZE);
> +	memset(kasan_zero_page, KASAN_SHADOW_INIT, PAGE_SIZE);
>  	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
>  
>  	/* At this point kasan is fully initialized. Enable error messages */
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 3c45e273a936..700734dff218 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -139,6 +139,8 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
>  
>  #ifdef CONFIG_KASAN_CLASSIC
>  
> +#define KASAN_SHADOW_INIT 0
> +
>  void kasan_cache_shrink(struct kmem_cache *cache);
>  void kasan_cache_shutdown(struct kmem_cache *cache);
>  
> @@ -149,4 +151,10 @@ static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
>  
>  #endif /* CONFIG_KASAN_CLASSIC */
>  
> +#ifdef CONFIG_KASAN_TAGS
> +
> +#define KASAN_SHADOW_INIT 0xFF
> +
> +#endif /* CONFIG_KASAN_TAGS */
> +
>  #endif /* LINUX_KASAN_H */
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 08f6c8cb9f84..f4ccb9425655 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -253,6 +253,9 @@ int kasan_module_alloc(void *addr, size_t size)
>  			__builtin_return_address(0));
>  
>  	if (ret) {
> +#if KASAN_SHADOW_INIT != 0
> +		__memset(ret, KASAN_SHADOW_INIT, shadow_size);
> +#endif

Drop __GFP_ZERO from above and remove this #if/#endif.


>  		find_vm_area(addr)->flags |= VM_KASAN;
>  		kmemleak_ignore(ret);
>  		return 0;
> @@ -297,6 +300,10 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
>  		if (!ret)
>  			return NOTIFY_BAD;
>  
> +#if KASAN_SHADOW_INIT != 0
> +		__memset(ret, KASAN_SHADOW_INIT, shadow_end - shadow_start);
> +#endif
> +

No need to initialize anything here, kasan_free_pages() will do this later.


>  		kmemleak_ignore(ret);
>  		return NOTIFY_OK;
>  	}
> 
