Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AIpwx48XloDnJH3HabNVGVttsmeNWJRq5iyPg55cXGis2JAJjNpokfYG6biTUczVWm+scGLB3SHL
ARC-Seal: i=1; a=rsa-sha256; t=1522933298; cv=none;
        d=google.com; s=arc-20160816;
        b=MaTeFjG/omZ5BYViQgGTTPZrp1DbMg5M/lE4rDYxm/fcRXZ0gQ5h2K/u5hho19eN54
         W//s+Bxv/x03SRA8LFSVFhnvG73+18U78gCxpuzjazQ4W8qcikvZiVWeJzcmJAUUC4kQ
         Hib0iOUXTyNHsyVghPTbF+/NyRrmaUrsbxt9GzOCbss6SnMwH/Rtg28MWT4OABwCe1O/
         DzOCvbxErstNnG30vPQnWgFAH4WmWoUC3lXAYLsEP7crkGHsAHgGUqGa30Nev29AbAkC
         W5h7kP1z2v5h9o8BDOwGuUuloNYK2LidyqVbgRLJxkHUfBRyeWQPaJRLvnnbHnqvY134
         swdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=AEDxis6v3JR5Z6c4bguND8YB59OkDdvfyr0YKtVecoo=;
        b=cmuPgESHTxZudJ7DWdpvs6/yhBtFjx9p7aDX37WMevem0r0FjcKb7mlurZvjWgAxea
         4SU2sLyYqPNkSMqwgUg6QTN0fkPo8v0peQfUiyR8iFkHkgzrMmSWyLzoe4rpghePf4zf
         OFP8SW/985v9M/Hf/P/Qy5Q4Ap3feBcAU/xApNfHJaHV+8ewD7QRmTunezvxkQfF7dNh
         OmHWpr0+RdN3NwVl6+JEg8XL4vP6/Y6itahC1+GV/FHnDV+TwCRqFhhQvlHyLk8O91nQ
         pXlIuwMIyqdrRSamBFGf+F4ro/kRATVAwpwjFRU5XASMS/WWa/lWdFJeTBMdpG03BWw1
         fUMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=LxWPdg7L;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.1.139 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=LxWPdg7L;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.1.139 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
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
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <0857f052-a27a-501e-8923-c6f31510e4fe@virtuozzo.com>
Date: Thu, 5 Apr 2018 16:02:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xmCLe85_QNDam_BVTp9wVzjxgvko2+0JapJCzmciGa5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0102CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::37) To AM0PR08MB3252.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b98c39e5-7b45-4d81-4b25-08d59af55aa1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3252;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;3:vqQ7putJzgmfDm3s0/6HqvPAhrbUh9xlrApojc/Rmh4Y7HU8Z8ZcO9y3fJSzEI8IbkUfOZRsUsNMjLQrkHvzFKKQD1Ugq0MXzhLyLQsbIY0Jn5fbO0JNu/WHFgSrXx5UE2eBz2079E1yUy6rOMxz4Gk+2zuz7pF3SS79ViprgbDzXCHXgnPtv0/1c/57fgJX9AybjRmVVvzh7r1g7opfRajio1NjCr8HLsiF+Mf3/mN3JFZ9MBZVcJWWkuYRkyrx;25:Evx9G02pgcgRN4QW9NjDIMxd40nSlNoTTFnU0OVN3wg6jEq8PXP1pgPQBTYRePmxKXfgKszULXY4YaOmuiu+tx8lbee/U1saJfAodwFGE5okZufS7UWgcVDkiW7pdwC6HQzOXG9IzoIOhlXh1gcu06A6gVvbUTfAiEGreLY49XrTi6VYzUZWsc6KwjmcKUObLmEnPMKofxk3v8mJaxpZiVbv/poQmIAeDWZyeVxpX5NFgbjdPW0ad7M+ThjIUQ5gcrXXu9SBNS5oGs90rmh6QNgV9vKCl4vofsi3KSyxs4BR2ZFMXseeYkTYsoFzTR1BgrIDKNxOR5hMNHcS/tqh3Q==;31:QFzEFCE5ddotxOonVy9nVDQ/OjwrtfXpHN7QFdU3b+/eWeU/qbzAtqygzZw03Q9MzRsQbvkjpub7SV/UCipry4CNu42L2gI20s1+Q+WHOODbQxULIziuFgdVgOJGJOo4M+g914e1fY+Nh99NnR8syppe6A9beiAxxwerV0dsCAd3JYfWg8llMkPnezYx0BMkL3Bo1cFqKJStM8oblsYQLiedZzVKQ5IU9izfqCuduFw=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3252:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;20:xeeOeclsV3IjLq7B3rmUtU7fOvHeaHC4Ed/fktLkPE7P+C7GE74LdIWgmcOOntJ3H+QGSfo/crJk0Xk3rPwPjAojr3afEgbn1/RrIswchFlNU5mBFoul6VFQ69YTXx/Bh5X1LMr8Oa472Oqr1fahAtZBeMBkx9UudypQHfTMou+DgMwtAUFKMgCwsSDyVdV2ggVLMkXhG3orRlkGKzIGXZZGohcYP903/6mqRqylQsgOA7U5yn+ke96jsitR0/MsEnQvdJcYHxa9P6Oq+XmkhRrw054/2/lUCD4Ygl915i9uu0M44Eju49flClUmg5wSdSd1mQka+ixIFec7K3Ztn7E4b3fSY5E+40GJQ1EI9GVJ98GbJQlDuLsJmhU02jMN5vZm7sfJzqr0WSR/432m9Njlmw5SmgbIB/4JLQLUufvyv2XH0lU7XO9amA39u5UBF/BCd1Mhy3YbT+naVBJQu3duCYGQr247u28wKDfkeAKhzljbbukbVInpkBGLtOEO;4:IvMURAeRUdQagsd9LDKW4rUTStfBjhPLmwiiYWKCNPOo1VRsBfJzoeaMYX3nZN+LF75qVXL9pflD6WEclOzK5+VHFYNIOhjwSrgpxDn66T4MjcAYEJJ2ZtKdtKlPqO5uF5vGVFJX8jsEltfYqkbicn3ypj7LYCmjLEezIA0lP5ywHM+d/LOZ3cBX5bMAQ/MPozex+fERj8ZRZywZyUemDjB/U7muJ1m1OcxWCGyTzhI+30oahlZlJHpbpeCjIwa6cuxJoD+GMcpDhezJVa+zYA==
X-Microsoft-Antispam-PRVS: <AM0PR08MB3252F2550CDB579D7C29B7CDB0BB0@AM0PR08MB3252.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:AM0PR08MB3252;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3252;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(396003)(39850400004)(39380400002)(366004)(346002)(199004)(189003)(23676004)(47776003)(25786009)(54906003)(26005)(64126003)(7406005)(53546011)(7736002)(6916009)(53936002)(68736007)(97736004)(7416002)(2616005)(2906002)(7366002)(81166006)(6666003)(8666007)(8676002)(81156014)(50466002)(52116002)(2486003)(186003)(6486002)(77096007)(58126008)(5660300001)(16526019)(52146003)(230700001)(8936002)(36756003)(65826007)(956004)(476003)(305945005)(59450400001)(76176011)(446003)(105586002)(11346002)(86362001)(55236004)(6246003)(65806001)(386003)(65956001)(16576012)(4326008)(6116002)(93886005)(486006)(31686004)(3846002)(478600001)(31696002)(66066001)(106356001)(316002)(229853002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3252;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUyOzIzOng5OXY0MER0dktkQU1NTEVhQVUyc2tza3RF?=
 =?utf-8?B?WnFPMmxIeCtPc1htS3ZkZDZwSVV6N2QrbUNRL1RjMnEwaW00UHBFdXljL1di?=
 =?utf-8?B?VGY5UlE3eGdPaTRNTVFhVHdOa2NDV0UyTmpOc1pLeDNMMWsyL0htRnZqVGlU?=
 =?utf-8?B?bHJxaUsvSlJ4U0JpTE1mMGhGNGIxQU04L1AvQlFsMUNQZU4vVlJzaGpXZng1?=
 =?utf-8?B?eUNpUHQ2d3FWNUVZUkRIRUdrdFFmTWJySU8rK2s0RE9IS2RyUkczU084eDJp?=
 =?utf-8?B?ZExjM1BzOUNiTWlMTUpkVGpiVys2bGFYK2VKUU5aNTRCYlRrYzF3VWlwR0Rk?=
 =?utf-8?B?VWhHMTZCbTBJdUgvaU13UGhNdHI4empkNXJhMlpuTWlPRmlvay9Edy9HM3lt?=
 =?utf-8?B?ZmhMVVpqZW1YVVpjLzJKUEtVa2lLWUhWcUNGTnVxTmthbEg1enUzL3BZanNH?=
 =?utf-8?B?c2l4cjlZTG1JYXZObXk2eEZWa04xTFF2UmtQb3QrUWRnTUVDSHRaaytZbVIz?=
 =?utf-8?B?ZGFnWDhpY3VPdGhhT1BPekZCNXJiWitrbGgvZFFaNVJ0YitNazlKYzRlYWpZ?=
 =?utf-8?B?T1BGaTBrcUxtWWpGT1BUOXJhYkJsWHc5Z1BaT292b0VoaGUvL0dXcmlwOHFS?=
 =?utf-8?B?UlhiLzBMcnVZc0YyQWkvQ1p5Tzl2MWhhdXJ3T0dZNnRZaU84QWxadDVNSk80?=
 =?utf-8?B?VzZBVW9SM0hTREZxZUVvMnFoMnFWK2d4OGZaZmdaNjdQZXIvdHpHKy9STUov?=
 =?utf-8?B?M042WXZsdDdDY3dhZkMyOWJXV2dTU1pRNjFkckZxWlBjYTNGTnFwblpYUUlM?=
 =?utf-8?B?UndPZGJCZWRsSzhqYlBKaEgyV09lSk1mR243OStuYjgrWFVGQWQxRE1Lc1Ri?=
 =?utf-8?B?Rzc2UlNTcEZFd0p5UG9RTmg5TW05aFcwM1JoRUVkcHVMR0JLSEJrRGJzL0lM?=
 =?utf-8?B?eURhdGtEVXB0TXhKTUNJWGgwY1laVTc5a0xrWEFEcUg1bzkrUDFOL0NsajZ1?=
 =?utf-8?B?aTR2c2lsKzcvaVBCamhYd3N2MmQ3SU5OUERpNCtrMGpoVklsQ3QvTFFmV2c4?=
 =?utf-8?B?ajkyd2ZpNkdNOUJlYjExaHVUekl5L1Z1MUYwNmFDcXNINEh0K1JXWVFLTE9z?=
 =?utf-8?B?V2xBLzFWU2JPa0M2VGpDTGZoNVQxeE1ncXRqQmNwU1g4MEJqVVdhSkxDMDRM?=
 =?utf-8?B?cVpxOGRHaWM2YzhiSDl3eDlheXgwenBJWmhic1hqN1pFOWE4QnJzcW9kajk1?=
 =?utf-8?B?RTJWdDZCcE15NFJrOTJONTRqcXVKd3FzM0VhM0tLWkVyU2lTei9OUjRsNTlC?=
 =?utf-8?B?M0JhOFVDaWVROWRHeXRJRTNhQ1d2ZHREa0paRG4vYkdVaVcvRnl3VWc2MTAw?=
 =?utf-8?B?U3R5a24yWHFsTmtsS1FYYWhOcEdOTnF1azJjT0VMVmo3aFlUZ2VaOXZXalAw?=
 =?utf-8?B?M1lySjlSREtlelRnL29tSFB2WXM0K3dMdzFEeGRDckxrajE5aWwySExMd1d6?=
 =?utf-8?B?RFFXZjdJYkl5S0Izd3BhckYrOXpFd0gyTjJidzUyVGpCZ3p5ZXpmeHg1Z2Nh?=
 =?utf-8?B?QmdmU05NbUVqWWxlVDYvTFA0T0ZuOFhWTjV6clR3OVY0ZGZXVW9DN05VdVNi?=
 =?utf-8?B?aTYydXFZYmQ5MHYxMmhXNU1UNlZvNHJ3T0xuZDR4NFE2cllPbHpvaDhmd2Jv?=
 =?utf-8?B?ZWFYM0dqQ0dEWVFqWmFuR1NEUXdOVXNqTHJCU0kxeHFsbjhIbkRFRE9KVDhE?=
 =?utf-8?B?MXhuWFZhVjNrT2dsVE4rUUxCMTJ4OXp1dEJqVFVaNDBhcm90U1lVRklnUkM1?=
 =?utf-8?B?R2QwSFE0MVdQSlNxNnFCWHl2R3VjVzQ1Z0NJdGNTVm9wMkp3OXNOU0Zaa3la?=
 =?utf-8?B?enNacHRKeEF5QVdONlpDUjI3OXFHUHl2YkJ3NGR0Rlp0ekk0NnU0RndBNFRh?=
 =?utf-8?B?bjByVkJmMGZOV0E3eWtsRmxiL3J5OVZnY3J3T1Ayd3NwSmFiS2ZIR05ET3Qy?=
 =?utf-8?B?Y1h2cXpMVHpMNmc0NGRublBzcUNxZVNVSjNUWkIwenN2ODh4Y2xubzRDR1lJ?=
 =?utf-8?B?aDdwaUFmVmsrQ0kzemgvbS8xRjh0azFCNjd4VUdwRy9tMlkwWXpGbWtVQ3Fj?=
 =?utf-8?Q?xVt6i8nLx9N3FTB4Ni4uKiVyzjRHfYuX3bGQcn+NdFxD?=
X-Microsoft-Antispam-Message-Info: +bz9B7ze1PpwewJYFIPX6ug4fYgYPMC5MyxG/R70WpN/IX2X1mkPZTc0DIgYho5okcYjUgmc7z4qX4sdx87Pp1WCYVi+oe7iToU/+P2fe/iKw3v187Pd/P42sjATLM217Q1PvwWuJMEsDHwhx5JHPq1ifMTIpGaVUTCMBa9EungU8rF4e0sjxjF73WjHuEQE
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;6:IyvAyyKE9QIUbcHJjg2WDHV2xNqgIGGRJLqvHnbHUviOM0ocEETCDP3JKI8TriYTfiNPUBhzH+3K/Tq6Cxny/PtaWPY/303r+gLX7Zi91QDOPGRRhEahVQ0xbxzJEpe+gG/vm4/ZDc+lHEmViOBNxvQG9ubCo16VAkfr2MkqI9QLZmIn4M0YF8dN24XPRbiE7tPvl6M+ScnqITscn+AziZnfEwbbmDHLu6toaBnReGlgMIrrJTkuinUlTvp+av5uVygxxvRqtEsrAfNE25Rw2ZSvjaUzGmD8mZJE0Kee9LCcdZAEwSk5jY3tpsYjeNZUKBmsX8pDfbWnGnaIKQDpeFKAbmpzlWnBvqEmKQsqD4A/CrLRykPK50eiQhFnwipsj4vCUwNGFtlC5NktuC6/AN8kTXAuisRlUox+LPlBAzZZ7d9RrQhHQN0wKmeDGNnZoqw4UJBQ0S3IoOreU1o5kA==;5:tV6e3uSug7J84Z4DRzOViYo8RuwheMCX1bd/TiZEasC3xSX+hOa58LJUTui+wvGFmA4sB4CL4/lx0chxxWGqzkfiIa91yKAVSeVP1zjEIjtGLcHeUhfpHMBPl7D9IPPtkBWCGbfixtPG4aYg20AoZtgQk0TOwvwmvLZ6hoviOqE=;24:hJDzrzSTo4z96XhjOkD4kJLjBBA6Xq+10YN4bRboFt8QXFh7mV3jmfMMRqrCycqGFMYHtzb/u2MtokKiYt1Y1Vx5a28vprrQfP0Nq63Y5Bk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;7:auxyvFo4DCb0U0UKV4HLCnqCb3wuztFov6MKUTnUPMSYb8z/ZTnJn0WvGCKr8LUSyXu62O4pfgVA3ux1kSiuRAllCENIYRdWgrBGztN6XsOn/sfyYZjEZFGDI8C5d2JsMZ2vczOQ0Sd7zicdCS1dqb8t2Umxs5RhnluCCBfeN94obM29gTg6jbF4rcv4hzxNc8U8t6utz0oKFwxVzi4aH7nYS6/XklbOSxcRIwiW+R93DLGW1Y56n9po9xPDA0My;20:vKGOfA/o3OaDMwDKCXFaoyMeDqDK5kJj/wj/aqY6m7fXG14+6Abs4EiLhwKXm7sooX+vH7we1RJf5szuSimsUHD/eewOVodjFIqMVKbzMMB+XVSZcmAiHRE1TFYKc066jdWPHY0fMz8JbnHCh1XpQsxxXzwk0Ma1ucFugRQm1v4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 13:01:28.3946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b98c39e5-7b45-4d81-4b25-08d59af55aa1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3252
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752721075121286?=
X-GMAIL-MSGID: =?utf-8?q?1596911306498759905?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/04/2018 08:00 PM, Andrey Konovalov wrote:
> On Wed, Apr 4, 2018 at 2:39 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>>>
>>>> You can save tag somewhere in page struct and make page_address() return tagged address.
>>>>
>>>> I'm not sure it might be even possible to squeeze the tag into page->flags on some configurations,
>>>> see include/linux/page-flags-layout.h
>>>
>>> One page can contain multiple objects with different tags, so we would
>>> need to save the tag for each of them.
>>
>> What do you mean? Slab page? The per-page tag is needed only for !PageSlab pages.
>> For slab pages we have kmalloc/kmem_cache_alloc() which already return properly tagged address.
>>
>> But the page allocator returns a pointer to struct page. One has to call page_address(page)
>> to use that page. Returning 'ignore-me'-tagged address from page_address() makes the whole
>> class of bugs invisible to KHWASAN. This is a serious downside comparing to classic KASAN which can
>> detect missuses of page allocator API.
> 
> Yes, slab page. Here's an example:
> 
> 1. do_get_write_access() allocates frozen_buffer with jbd2_alloc,
> which calls kmem_cache_alloc, and then saves the result to
> jh->b_frozen_data.
> 
> 2. jbd2_journal_write_metadata_buffer() takes the value of
> jh_in->b_frozen_data and calls virt_to_page() (and offset_in_page())
> on it.
> 
> 3. jbd2_journal_write_metadata_buffer() then calls kmap_atomic(),
> which calls page_address(), on the resulting page address.
> 
> The tag gets erased. The page belongs to slab and can contain multiple
> objects with different tags.
> 

I see. Ideally that kind of problem should be fixed by reworking/redesigning such code,
however jbd2_journal_write_metadata_buffer() is far from the only place which
does that trick. Fixing all of them would be a huge task probably, so ignoring such
accesses seems to be the only choice we have. 

Nevertheless, this doesn't mean that we should ignore *all* accesses to !slab memory.
