Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/DKpDuXgTHFDyNQjcfxAXcBmoI2znjs234qXHIiz93tz12k81iy7BYJ4hBb1HMRrWOo97z
ARC-Seal: i=1; a=rsa-sha256; t=1522845548; cv=none;
        d=google.com; s=arc-20160816;
        b=qXNb33MgZ87aV8Tp/bGJtdSDcaEN/pt4DYtKsdwmNQX9Uq7gZrqUlKZejJiL+UShX3
         JHTO+lLwPMMjoM5F7fEBzDvjkASmNICnBpozhEj88ZgGsfuLTf8TM6lAt1NPsGvXW7/z
         hf4Qid8PiP6gRKgW/4xgVbHG+Wl8yMnXtzvv5yqi2lzZbwXAKFJF7DmSR8FZfYoqGplw
         0MScTn8x4mHQKEv9o3huy0KhvKO5/YAhPRukkgtMyl8FCusq9N6QWh2v6LWF6e1UbSot
         5cqQlX1iu9OkdyO1BfciMJz+XAk6CmBzdNPmzoNqq0XCp+ZpWb7tbp0eqTRkqD5Ei+yb
         IBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=olt+XCJWzdDbuVMDtl34YLjY9f6W+FF4JEFTdEjzz48=;
        b=qC6SXq83voLoAuCtUgZqi2pRWBJQMgg5L9Qd2wMP1WKfLVJt8fjSp5NbhbhsBx9nk5
         je22UzuJzmac5jez8iudQjtBXZp35xyjGDG8FM0l7Zjz9+u5xYbroOy2iaXfJGcGctRb
         YCQOTRUeYV8ye4ZaRqPV2frJ77T9lVdm7NYsM1wU1LO0gG82fVvOJDseYt6QlyRqoCrN
         1NAW25K3L7/JHs6tSWnUZMfytCMurLXFvuYqff6PgkjpPiw/kU/OcWIGZIRwH/HBAUuO
         gZDPlLwADR/LFOqNK0nZNMtM9aXK+7C67T0fXZNvFoJfDeUM92DyCN7bYIJ7YNr/MFy+
         y4fQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=aKx6m3V7;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.0.110 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=aKx6m3V7;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.0.110 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
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
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <0c4397da-e231-0044-986f-b8468314be76@virtuozzo.com>
Date: Wed, 4 Apr 2018 15:39:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+yg5ODeDy7k9fako5mcCLLnBrO729Zp_-UtDuzh3hZgZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P18901CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::16) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f32ecd54-8a70-44df-bc78-08d59a290d61
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:fQutipeZs6og9ZHsGJepOiKtKzKR+L1SuUPmlZAbOVS8KzR/uf21KNmFOul3aaXhGu+HogOmluU5iVAtfeQ4hv7/pV6bu3V4hqmCBEjwFpKa0gZs3sY3QwzRerUXvQmGiVkAqg2t2GN1Z6/9bO6xa1rxeBdfPbqJJjEy7jacKxUGP887ARq66xJdDUf6/5aBDliiKjcJ1tb+SyGkC3LpP6cOZjZWHYJaABYmuWMJY87RyG+w0ide6ZPPMI4X9C1j;25:lL+lpErQJLaNuPKrvpVOocY3N1byyXLEgE/T6h/h5snV4BTN6FWNRysE0+KhUO1SDMty3m9DJ5x47n0XjNqRgJ7p7z24PmS8hrp8z5lwpPvYURh/AD0zDNwN/51fAdmT6E57NPqRCX2cgubITE99kGMl8Y0agZ8xF5mk5HgKUu7q0EzaWxo+qmGwool3Dq15RSJ+PaKdc/irn6Y5eAxUelWsMFQaJSNjZ84xAVsP0oKTu6pxIOUptYVFGSHe1Fhx0nBX9I0eXAQSFvjxnSiFS/ECRLEUlLCtW/ZJzSTfsV0mRuETnrzitTa3VkYZbG+79ATz56cOAbR9CEPjA1o3mA==;31:+vZrrRaBTnNcq9ifoDMf374Zw8swqMGSuAY2WirE3h0k6ZNaTv2xo00r3zTVq41F9e3GhfjcS1JSTz9Xjmx7pE6tNjbv23gi7fVeXZAW9yP94GaoD40RKG1HRpnMA+ga+zOk3BEa0sVTKNnEhje2uUNRVWcZ3axiHM62rDwyVfR9i3TKTqITEQOpDLQc3uWTrbI4N1kxP2L1IerIQJxhBISrmxMTS8LHhERMGs0b0Cg=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:e6zRDEdWZDylkzzptamCY+lo8pZTvfs3iIdzGdJfcSJPY5BwAJd+YKKXktQqTgl0Pt8Fgoeh/I6TYliigl1NCeYuksPJAK64FJBR44I1+hy/cKP0F86Zy+ywgU/NC5+FAnscFtdZVA1T9EuxWwMp8RM54FmUzntVTsuqbYUunQq0S1u+uv0BnQ6sKSXrKl4vK0l39VtsHeSLc3vP7BVuU/ovDscdHUaqCnr3IsPDXvnlRsdEq8v3aVY8Uwc9vh6J0uKGXvOibV5g3bS38onc8o6Q6NlcemMaClDNLR5LoQwejYtRkkCy1DErM50fSwSaBheNNpiUkyC/wUTACK9E5Q3THEQcHg7ULA1WIoa9ert59r8scpx1cFvug4tkIS5tF1NdyvnMJMVkcJsFCXY8FZ1Sc6nzEbJunlxZzuT3FtywjSnX4QjjGCT0/6crUwt6S68Rh13s0NoEwBGLA8O6RUeqtNygtGEFRtK4VBzFvdlKgmQdF+jmB1ryAkPBK2xe;4:Ttj2E0jf0TXK9mPbR8YJ6Lr64x0HZxDTypUdRzxcx/LPfQ4sCkNIM/WLIdjlX9yXglKGn1KANnZpz2FLi0XZU4UP1X9Q82YSf5H39Co8Ni+yqH5LWmUmVhKYj+8g2cmIZI3BpDH6XNkCoV0W6Me6izlKY842jgQAUCxFr+2fCSPRn792SfTJ4NwvzhLbMaXr+DMUDzvhuRGSqesCrB0fS3v0QAoRrG8xi5+6SM1Y/4hxiWtYkKBBzu9sz0QP/w8t6R9DIRGEBfw8NTQawV9W6Q==
X-Microsoft-Antispam-PRVS: <DB7PR08MB325862B76A81AE974EB13A6DB0A40@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(39380400002)(346002)(366004)(376002)(396003)(189003)(199004)(8676002)(23676004)(31686004)(55236004)(54906003)(7416002)(16576012)(50466002)(58126008)(316002)(476003)(6666003)(6916009)(6246003)(65826007)(5660300001)(6116002)(68736007)(53936002)(229853002)(8936002)(25786009)(81166006)(4326008)(86362001)(478600001)(93886005)(486006)(3846002)(7736002)(2906002)(36756003)(2616005)(81156014)(6486002)(7406005)(11346002)(64126003)(97736004)(8666007)(446003)(7366002)(956004)(105586002)(66066001)(106356001)(65956001)(65806001)(305945005)(230700001)(31696002)(47776003)(386003)(52146003)(52116002)(59450400001)(77096007)(26005)(53546011)(76176011)(16526019)(2486003)(186003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOk95R0l6WG42VzNUTDNRS1E5Wkx0YVBIdVhu?=
 =?utf-8?B?YW5oZSsyYllNWDdhVmF2bTg5SUdWbzJhRkVkOHhZdE5vM1ZkQWlHbFJEYldP?=
 =?utf-8?B?NE12aWhhT1ZKUGxrbHNNY3h1T0d2aWswT2VtUklZdmtKS3ZzRTh4MjBIZzdB?=
 =?utf-8?B?aVBvZ1Q2dnJWb0dLVXNoUWxPOHMrWjQ0YTRSbEVISkR0KzkvZmJwaXJ2dk45?=
 =?utf-8?B?Y05Na1FTZk1aVUdMRnpKemRHR3Eyc21pdGN6elViSGM1eThNY3ByeE9XMlYv?=
 =?utf-8?B?dzBCdXFaVlAvS21XazNVOFJwTFUySkVEREF3cnN4VEVIOXBRWDhlOTc1d1dP?=
 =?utf-8?B?blZCWCtmRDF4TktKeW5nOTJ5ZkMyNVVja2FISDAwTUZZck1uMDlaK1FDZVRv?=
 =?utf-8?B?eDQvM2VOT2d4Nmk5ZlJDeUlzNjJDMmgzazJ4OXBhY2NNRTVTYmhQUEIrdHBT?=
 =?utf-8?B?MGIyTjBoWmt3US92MFcvdml0c1N3RkFYdTVUMTlyM1MvaHVKVXFybWs0dHhC?=
 =?utf-8?B?YkZPM25oVEtsVnRsRVE0M0Y1TU5LRmNabmxtRG9HQXFKeXAxN2MwMDd0ME9T?=
 =?utf-8?B?MVBEaDhRN1RvaU55Vzd4OE16ajc4VmRpcUJ4bkQveVRRbGlXZVNiVWxQM0hS?=
 =?utf-8?B?RFVlUDJMNW5aWG5nQmlRMkZTOE0yWlpzQmVtU2ZFRFdncG9EMEdEOUxab0Mw?=
 =?utf-8?B?VGd4K3lBd1M0NEg1dzQvVUh3ZlRCK09lbVEyTTJqbExDbWtna1hJWndlVGpx?=
 =?utf-8?B?dzJJcmY5WVhtNXV1aHhaSFRYWmphclZzam05RnNaelVIVmczdDR6dTdGWUdo?=
 =?utf-8?B?RzYrNTJjbTU1cHhIemlSOUxvNnN3bEoyQlhIWkhDRnUyVXZJQnB4MkdOVHRI?=
 =?utf-8?B?WHhTTkUwalI3dU5rRFNqdzNDQmNvSGZ4TzN0V0htUlQ5OXNCd2huUjFUYy9P?=
 =?utf-8?B?YXBBR1lLYmwwSnpGSHU2ZTc2aGt6bXpidlBHMDN6UGZwaW9MVkdrRXpTazZI?=
 =?utf-8?B?VStVRlpwd0xHM0Q3cE9BcUtyQ1B2bU1vZ2xSSFZlTElwR3JNV0hQSmdQTktQ?=
 =?utf-8?B?MDY1Vkd3ejRuSmFkWjZsOXZselJ2SE9RYlNyQ0VBclRBY05VV28za2sweHNU?=
 =?utf-8?B?OWFyVTdGQm5QeXZMTUlWVElubjl0WkUvM0tzN1poZFZwWXN4dGgxcnh4bXJX?=
 =?utf-8?B?UjRsZzZDeVRVRDQxRW1rRm1ZRTdhTjNZa3oyaDNvUjZ2TTI4aHdsY0UvY0lX?=
 =?utf-8?B?dmVQcGVIZ3JxWGVMVzNkWEIzOW5vVXpzbzBpYklDTzRiampiM2hIdC8wVTh1?=
 =?utf-8?B?VUh5VXZzbkl3VGs4YTUyN0JDNXhrTVZkb3JMMnRIQ0s1TEFEK09kYTArZGY1?=
 =?utf-8?B?dStjQWhrNkdaUEorTlRyemg3M1JYN3lqQjR2RFdQeFUrZkJDc1VteGpsU3B3?=
 =?utf-8?B?endUdDk0V3pPdUpwOWpJZC9qaEk1UFpzMUEzNmplTHVnUjhVYWNrczFyNG1h?=
 =?utf-8?B?b3M4SisxQzQvVXNabkNrYmV2YzdLeS9odXlmSWlLRUE4eWl3cjF6dGNqUFJD?=
 =?utf-8?B?SkFrM0FkSjRQQ2pLaXg1cGVlbE50MGpIR3lXaGNJdXRvK3djdVhJS2g0K1FT?=
 =?utf-8?B?N0Y5ZWVkbVlSN3hOY1BveGRpUWlySjUrQkdqSW1IRUJSb1VERmd2Y0dOWHIw?=
 =?utf-8?B?U3ozZVZjTW1LbHl3emtCK2RrZTZKK3pyODlXWVBOazlXSDArQlAzbHRLU3ZV?=
 =?utf-8?B?cy9TNmxDak4rMUt5S29FVHNObXhzZ3BRWVBxdm80T240V0dYSkx4UTJzclB5?=
 =?utf-8?B?cWhiNjBIVENFR2FYRUhkY1lFQXA0VitKVzZ4eGFPRjFlQlY1LzQvcHN4WFZQ?=
 =?utf-8?B?b0kwTGh1L1F4M1o1TUZ4MC9RY3BZbEg0VVJvd1R2eWs5ekVlMTZpeUlKRUh6?=
 =?utf-8?B?T1hCMTZUdDRxeGRMNUV1bHNidHRPQTg0NThoejRRMUJjaEZxZG01TXJFVFhm?=
 =?utf-8?B?WGc2T2tWWDRDZHNuQzVKSmd6UlYzS2xWdWxPS2x2VVp1a3ppVnMzUmVOSGlq?=
 =?utf-8?B?NjFITmJGOSsyQUE5c3dBMkdqaWNJVGIwYTh0Y3RPNTdwdnIrVzZwZVRpNDNv?=
 =?utf-8?Q?6QNIsyOZolD70JT/emvTIE2mtfnZOKtGqTT3kaNuuCd+?=
X-Microsoft-Antispam-Message-Info: GhVYJTvvS9lyGubrMYTWajjQrrXWCOACtFPHWqd7wasuENZEWgNm6lrT7EEymD6We+cvfaiCt5ZxU7oTYSgP8PesKPT4pO6/amh9CQr8vkrnm9gIDPuk+slR9kl3LnnboKij2fFbO8j40jq65MW+tbjh3vyT8ewoRSqkdzL9umTJPR8LHq42OGlZRlX6n8wE
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:dpPPO0MsnqcG2UZciSSHVx5ofUjKT5PoedsPsssWIFN5g4laE7p/uDIxcqeF1cB4B38tPdGT8CC4Pk8OCxj212vdGOePt4enIDHRVgrdntWNEdb0iittQUhguyI+HjnrgWbsbfE7KsTJxCMXWbWNycEP86z/BMGFHXlu1P3BeHbws4ojP8TnroaNNHElmFWkjy8zVWgTFqwNnZ40gYZYb6mOoPydk10ECcnRKbO7s3vRqy4ADoQOXWIh/aNwlLQFbA669x8A68bV9lcBZII3RpjGe26ZzLGxfMeD78vJG3pJDoY001QL+bU+gFRc8OYKiAk7AHGZw8kxKrk1tDyRoiJWp4NgUVUBVrTF1k2ckfpSZykyAH+yI7KRmnpbpU/l45+U6UGQJfupHG4nKamC75j7cQiZ8j1BgkZMVHsMgVHm/W4Jr3pN+3mDHyZAHOV4r/SNcRMOft23RiRzVaDfKQ==;5:5Zoyu5nRy7/odp5Pfg4WxNvdLpVq/cgda8DdHWNJp57CTuVLu+2wRSDJNRWLOGXTu9vOkV2N3HXKj27SjMsnhDG0s9YpXHCTmAmUAN3x6AccF9bnoDFc5+pu7jEZjqgu0LR4twgNEwW5PwZhCANcu0Uggsb4GIcqcubQH2Zn1Rw=;24:RnbV5JHBjJYf7/yvEEndbc1xgsF91VJxN6F/kfh8cj6utPEUHS4fzanzKH+wkhBPtnKpg132Z6jjN5biTsOcZL8BOBVg1GniSmbqqvNVWXE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;7:yzOyEcZD8c+7Sbq7QXf04Qoc6aJlpW9T1qnsQvW1jw0ZjHeROSjhPqcvgnQOXJQc0JhroMHMzWzjMOn+QNyKcHwFlZHDOnt6djPDL637fQo6bmJLvm0wW9zhOcHpPlCC/FGQV3lNjRTrVlUTnSD3ZZJ7I4tHbhrBp424q3mt8XNsmRmr+FWrFFzO0OwckI2y+YjfrZZSDdVmtNSKZb/0W9TWvokMxIC8GRRnWOCGJn/m0abiIpHKg9oVuyo1km99;20:z73kr90pg+rmAO0hTPhy0/QZt8gwNGPV1w2EriJyIyB8pM6NN4G9+3pN4P/5BKRcSDEAA3ywObqyvcGIalsQBqGzDVphi87sFBFAjDbNU4y+RqoB+fYskw/LkINvBh2M48hNzvru8HiiYkfm5pItJi1fS1kFAuSnn239pNn2BcM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 12:39:00.5075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f32ecd54-8a70-44df-bc78-08d59a290d61
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752721075121286?=
X-GMAIL-MSGID: =?utf-8?q?1596819293597133984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/03/2018 05:59 PM, Andrey Konovalov wrote:

>>
>>
>>>  void check_memory_region(unsigned long addr, size_t size, bool write,
>>>                               unsigned long ret_ip)
>>>  {
>>> +     u8 tag;
>>> +     u8 *shadow_first, *shadow_last, *shadow;
>>> +     void *untagged_addr;
>>> +
>>> +     tag = get_tag((const void *)addr);
>>> +
>>> +     /* Ignore accesses for pointers tagged with 0xff (native kernel
>>> +      * pointer tag) to suppress false positives caused by kmap.
>>> +      *
>>> +      * Some kernel code was written to account for archs that don't keep
>>> +      * high memory mapped all the time, but rather map and unmap particular
>>> +      * pages when needed. Instead of storing a pointer to the kernel memory,
>>> +      * this code saves the address of the page structure and offset within
>>> +      * that page for later use. Those pages are then mapped and unmapped
>>> +      * with kmap/kunmap when necessary and virt_to_page is used to get the
>>> +      * virtual address of the page. For arm64 (that keeps the high memory
>>> +      * mapped all the time), kmap is turned into a page_address call.
>>> +
>>> +      * The issue is that with use of the page_address + virt_to_page
>>> +      * sequence the top byte value of the original pointer gets lost (gets
>>> +      * set to 0xff.
>>> +      */
>>> +     if (tag == 0xff)
>>> +             return;
>>
>> You can save tag somewhere in page struct and make page_address() return tagged address.
>>
>> I'm not sure it might be even possible to squeeze the tag into page->flags on some configurations,
>> see include/linux/page-flags-layout.h
> 
> One page can contain multiple objects with different tags, so we would
> need to save the tag for each of them.

What do you mean? Slab page? The per-page tag is needed only for !PageSlab pages.
For slab pages we have kmalloc/kmem_cache_alloc() which already return properly tagged address.

But the page allocator returns a pointer to struct page. One has to call page_address(page)
to use that page. Returning 'ignore-me'-tagged address from page_address() makes the whole
class of bugs invisible to KHWASAN. This is a serious downside comparing to classic KASAN which can
detect missuses of page allocator API.



>>
>>
>>>  void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
>>>  {
>>> +     if (!READ_ONCE(khwasan_enabled))
>>> +             return object;
>>
>> ...
>>
>>>  void *kasan_kmalloc(struct kmem_cache *cache, const void *object,
>>>                       size_t size, gfp_t flags)
>>>  {
>>
>>> +     if (!READ_ONCE(khwasan_enabled))
>>> +             return (void *)object;
>>> +
>>
>> ...
>>
>>>  void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
>>>  {
>>
>> ...
>>
>>> +
>>> +     if (!READ_ONCE(khwasan_enabled))
>>> +             return (void *)ptr;
>>> +
>>
>> I don't see any possible way of khwasan_enabled being 0 here.
> 
> Can't kmem_cache_alloc be called for the temporary caches that are
> used before the slab allocator and kasan are initialized?

kasan_init() runs before allocators are initialized.
slab allocator obviously has to be initialized before it can be used.
