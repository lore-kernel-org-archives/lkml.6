Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZoyuR0YkNIsLWT5cQUmXrtsEjmzm91kLbbuo09vYDMzk/NzUkc6quV+BbbyLQtHL5tUvPYl
ARC-Seal: i=1; a=rsa-sha256; t=1526393145; cv=none;
        d=google.com; s=arc-20160816;
        b=FKq6witfgCY1bepFFd6n2xKbGvCfLcAcb0dco6C8Ni1RVe18zdA1fhDQrGJwQGnMnQ
         6oumfrDkDCRe7CfneCWtoBa0197tebPRJkVL1LZ/KWwwvfZUKgrFsqqHIC4YwPE/wEQi
         Yw4vuVUkaH5tnDeIYBhsop87DPOwz7067PouaKxIBN5KRmBV0irAlvbxA3E0tbEDRwV/
         GP/a8SCimisbPhvVVwbWxvx0fq5ft7fnLloxhbiNg4tcxgYhZM6ZoC4/gujLxFdcarpC
         9NbSs5mWvZv26IeIoKAYn/RmFkDzqTslLj60gBMnwu4Xwr6bKbG6Sc0gi11+2z/OIcq2
         9lnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=XSY0gMLCmb5i9IQ9fIaG4WLl7MVUJ7L382jws/5dtOE=;
        b=L8plyti2Da8zdGhbFYor5sWaDjU+HUDFWvD/teVQVlmngBP4VHkfU3ZwFmrYrozZSM
         k2v38YlhJjgGmdC2nw8Yb4VMBqdtmVoPZTryiLQYDC4j6ouTkUMB2RCgo+rpoxZDYFZA
         s5uwO70QPtRwOBRkc+HoQk0pHFBeJdrmtQwUUSpMdeHVLV7SRjqmY5rZ/amTjsdHtGu5
         8t9nJ5fRvG1lRxqtQvUjjYJ8KcGy2UvWXJHDhSJgI4Qw1Z6qWpbynI7grkTbCTL10VGr
         rKJ/tQHMvjpUo3oRcsLaG9OcvbiISBo9OdACPzSwsHGXcBqfznjrJs5GWapaNqTd9u8/
         ERew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=PvJS7VW5;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.3.105 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=PvJS7VW5;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.3.105 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v1 15/16] khwasan, mm, arm64: tag non slab memory
 allocated via pagealloc
To: Andrey Konovalov <andreyknvl@google.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christopher Li <sparse@chrisli.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Mark Rutland <mark.rutland@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Yury Norov <ynorov@caviumnetworks.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Punit Agrawal <punit.agrawal@arm.com>, Dave Martin <dave.martin@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, James Morse
 <james.morse@arm.com>, Michael Weiser <michael.weiser@gmx.de>,
 Julien Thierry <julien.thierry@arm.com>,
 Tyler Baicar <tbaicar@codeaurora.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <keescook@chromium.org>, Sandipan Das
 <sandipan@linux.vnet.ibm.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Paul Lawrence <paullawrence@google.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@suse.com>,
 Jan Kara <jack@suse.cz>, Ross Zwisler <ross.zwisler@linux.intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Matthew Wilcox <mawilcox@microsoft.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Souptick Joarder <jrdr.linux@gmail.com>, Hugh Dickins <hughd@google.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Laura Abbott <labbott@redhat.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Vlastimil Babka <vbabka@suse.cz>, Pintu Agarwal <pintu.ping@gmail.com>,
 Doug Berger <opendmb@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Mel Gorman <mgorman@suse.de>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sparse@vger.kernel.org, linux-mm@kvack.org,
 linux-kbuild@vger.kernel.org
Cc: Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov
 <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Kees Cook
 <keescook@google.com>, Jann Horn <jannh@google.com>,
 Mark Brand <markbrand@google.com>, Chintan Pandya <cpandya@codeaurora.org>
References: <cover.1525798753.git.andreyknvl@google.com>
 <52d2542323262ede3510754bb07cbc1ed8c347b0.1525798754.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <0043ffdf-4a75-d41c-966e-073eac3dc557@virtuozzo.com>
Date: Tue, 15 May 2018 17:06:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <52d2542323262ede3510754bb07cbc1ed8c347b0.1525798754.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0173.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::21) To DB7PR08MB3260.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3260;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;3:p+ZMuBSlDMjMUEMG/NuOsgZioKo3fCtyLGwKIOmCi8nbNpBkv36oH8dW0y0UWhbnO3GyVM8qlnCBFIpdpPAuiymcSy0SBs+SoyPyz4JMd/8kkLRsM1+L9ZeytoeoTiSac2/1Lo+jV0WaZpAwtpluXx9PV8WHUknJvTtDEbxnFSKz4zUWPj/VUEAojJbdYhUNQHd4+rVCRUQpCQpcva5qbW5gpTO+3Jaqi/ko9mktmhpARhA9A5KrApwQYCXdhSRH;25:mp8aQTIM2tumw3ddNYeqhoPwH6Hxws1XIfdQEfR1GuzzDSWTPETAjw5Vx/ou8EhjB/vCMFQw+JRlg3cxfUmJwp03rtmLrIq7aS2NAb70s+ObeTe3RWbaascjuz2GWzWYYyfuOlGaPm+dZGBOdxU+Fyb73f/kMoQxluemxV8IIAXe27wpRHFpLyldngeZohowc0StKu44ySIw4r8Y3NwnDdEBXDC31gDr7BOLtG4e6xZEwT10+nz83eL1uzluRjSVUgHQEeaRT+dETTfs1WkctdeAlAkKiQnUzCNXqblF0qA51Xuyw3jYHtudcx6bKfDmtj6UjjdUd4RE7YUM94Q8Zg==;31:YVsrJcV1jQU7D6g5xwIafKOmgFgLhIRoegYqyb7WGVQu71DcdUb/zzawrcOnNigtDI7xQ1n+kCl3BRwxIeggR7r7cIktgBKfoyfIPAlgAESdJAyrtztW9yWc5qauT7FD0rA927Sc6cMMOAIuMTHJAVznco1ZRGB7F3RbKDVDhVVR4iHPDgVzBtf9j2yka0P4Xy8QNYIByN2nWuvnoKi3QACdi22W717GxRkzHl0O1wU=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3260:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;20:adnQXCc+j+rdJL9JFmv7g627xb7JUlR03W0qpw6kCBrIwrRfYRJGDQdXuU8+ry5XDJ5knvBmmKhJWcUZ6/EweGxTyNVTHmhcfV2z8V3dkrZAq0DPVXIq2BoAvUCNAWzfTJhI+Dnb3AROnp6DfOdm3vJ0MM9sn1wkh/wXEgJPWHuaG+zrcPycCH2uOvivWLoYgSbnyK9PHwFSjlAoU/p7FQvFsC/GVeLeJuRO+RE+2eWDCJs8dm1eWlEEwu48pv2YVrDEcFCicYt8VniIQn8F6xngnOOATDpbSkX70WR9ynGvS6v/38xaqbJRTdLSgHTC6X57HWk17Yp3Uyfz3xljS7FOaZO+0VT3C9RGiPRGrvKjvMIzHrEprr+5Cu/32JlnQdQbuGXEAEo3913ME7OxNpTs6QMbwvYxCyLc3WAbswvUTnC4642ldcvX8zSDLPJpYT+fp6TEaQLovuf+TgEK6UGUyQu/KIBPi9Cc+wn82ax+eKk2/3+j1a4U9jmkj+j7;4:fhlxvJBOMWgC7+amJVJkJbhg3OYxGrzWaal8Lf6wue9746ifGUTpTGzOGuxKZ+KgLaHy6Imkq8wyJGVHC4HhoSBsXdapEb1vavwQTfBmX0PII1bPG1gCmHglJbOn6rKXRRZCkMMhEpETXYt3HgdAgA8uVdIvIdPXVBexgRYgWWKhLGokJc5/jh0xzY8SEhiub+w65CJl4YO9uv7gt14b9mYBItrpvjGCs1kkBpqxjwPdjCyPznR/EKc3kxM3d401B1bcpC2WRTePkeyZHf0/Zg==
X-Microsoft-Antispam-PRVS: <DB7PR08MB32603291AB73D7A127E6A84FB0930@DB7PR08MB3260.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DB7PR08MB3260;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3260;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(396003)(346002)(39850400004)(39380400002)(189003)(199004)(53936002)(66066001)(478600001)(6246003)(65806001)(65956001)(4326008)(7336002)(6666003)(36756003)(47776003)(5660300001)(65826007)(97736004)(1191002)(64126003)(230700001)(7416002)(39060400002)(229853002)(25786009)(7366002)(305945005)(7406005)(6486002)(1511001)(7736002)(31686004)(26005)(186003)(16526019)(50466002)(6116002)(31696002)(575784001)(86362001)(68736007)(3846002)(105586002)(106356001)(54906003)(2906002)(52146003)(23676004)(76176011)(52116002)(2486003)(386003)(8676002)(55236004)(53546011)(8936002)(59450400001)(81156014)(77096007)(476003)(2616005)(11346002)(8666007)(486006)(110136005)(956004)(316002)(16576012)(81166006)(446003)(58126008)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3260;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjYwOzIzOmkxVjAzWnRaN3pxM2RLZ0lzWEhTcUJqbjlO?=
 =?utf-8?B?YkoyYXB6RWwzWjdLSVh0U3ZaVHZYOTRxYmNORFo1bm02NjNVb3hUQ09EbjV2?=
 =?utf-8?B?QjhSOUg1S2hieHFtbjVhMGc1ODZLNlc1S1RONGpxUHI3UWZLQ29WNzk3Q2kv?=
 =?utf-8?B?aWczZldXZWo0bFo0VjBTekoybE0vM1VmbitWUURNSFpJSnN3NU1EM29OYjVm?=
 =?utf-8?B?UUVjdGUrblhVMEI3ZGg0MGQzU1hVaDFPRGdJYlhzNVVIU3dnd3V2UkZCbjk5?=
 =?utf-8?B?ZGMwYzNKWVlVUWRpcWtyaUxSVTBuNGorQkNCdlNHTkRZak1lcEQrRFkwbHRT?=
 =?utf-8?B?S3doRXo0UUFxN2FEQ3VYWVpzbU52SFRyK3FkQ0dYUnhJYklKQTBKNFJhSjIv?=
 =?utf-8?B?S1NYOUZMSVptN2xrc25VMWJmdjI2U0s3SnE0WmJhQ0NHOGVPTENMWFFxMmF1?=
 =?utf-8?B?WFhDTkxTSWthSWFVVkpMMzBIWmg4cVJWU1JaVlRCdzJqWDdVblNXZDZDNWQy?=
 =?utf-8?B?QWZqYzVqaGw2RFpZdU5majUvcUk3cjdzN0VycmhtTVRWQ0p3Ty9WOEVNQWl4?=
 =?utf-8?B?M2dEd093enNqOFpUWFA0eStJS3pEMTJ0L1BqaHRObEhvdXdTMVBaeFIxTFRN?=
 =?utf-8?B?OWY5VnUzYlhCWU9sQ1J6Q01MODdtemZuODdyZnpmR3dqb01JYkVWazBaZjNS?=
 =?utf-8?B?ZGwyWHp6R2RyUzV1bjN6RDd6K2pNQWNmWGtITXhGaFZtSVNmSnd2NVI3MGw5?=
 =?utf-8?B?dXUyY0dCL3pOUEpITEVrTTllQmcvVkNPV2tRUEhqbWtmUmcvMGdaNTlCMk02?=
 =?utf-8?B?RGk3ekZIdWhoaGxOeHMzUWxUL2w4bzhrd0QzbFhXcVJLVkJxOXpleU9BZmRv?=
 =?utf-8?B?T0xOWTJaRDBocE9PRWpNM21vTkNndno3NS9oQnJOeFRHdVhlZVEzWHJBQ1hB?=
 =?utf-8?B?dGtpUFNPaEt2bFNTdmtOeUIxMU1UVlBoT200RTZWOEFzV3pIdERmTWJ5czcx?=
 =?utf-8?B?VnZZeGdLODN3cXN3NDFIL0owdlFjMnNHc2RuUTN6MUI3ZkJrZnZaUmFsaFVX?=
 =?utf-8?B?MnhDM3YrQnFHR2FnREtDK0IvTVR1VHVFRXBWMU11b2ZqSDluWHYvRkJUaHVU?=
 =?utf-8?B?dUZ5K3U3bFZjN2QxUGE5L1J1RFMycFRXMnJuUC8rRWhXd0QzT0JZQkkxdXNh?=
 =?utf-8?B?UnJUM0dJWjk0czRlQU5CemFXenRQbVg5VEZMdnVRS0dRZElieWVDOXl2SUx3?=
 =?utf-8?B?S1Z3UDJwNk5SSDRXU0VWeDNXZHpNMzhmZlF3bks2SWp0MEY4bDdkNkVZZ3Fq?=
 =?utf-8?B?ejlFYXYrUzMwL1k3WUJVVVJMd2RlUnZFOVZzR2VsSUltRDFJQWFKT0RuT0x3?=
 =?utf-8?B?Y0VSa2hOeTZSdmJVbWFnd0ZCZHpDN0ZsWHd3blVyZ1RxSURwYk1jVzlyWk1i?=
 =?utf-8?B?OGlVMjJEREdDS0hiTzkydnFKQmlzTnMwTmlhTXNOZFRreVVnN0QzdDJEeEJX?=
 =?utf-8?B?eG9lODBZdndQc0I2SjRpMytZNC9iMkdYV1NIdjZnL1pNZ1hOOHZKakp0SnJ2?=
 =?utf-8?B?b25jeUVmSDZuVVFSYldIaTkrZ2ZMb1JreGFvd2gwcUQxVlA4MkZKckhxZzM1?=
 =?utf-8?B?WW9NMFhTelFYejhpb1pCNVlHMG5hTU9VVGpBRVZMUjc2dTRjNW8weitEb0Ux?=
 =?utf-8?B?MlpLU0NkM1k3ZUpCQVBDLzAxcGg2cFBlRmJCRkhKZnhLeVp2Z0RRNzgyY3Ji?=
 =?utf-8?B?MXhsMDJmOThiNzdoUytLK3ZiYkZMc3ByMndIRFMxWnhRWHZHRnR4M29RY3lh?=
 =?utf-8?B?OTUzc1hzcGsyaCtNeHllOExTRllZdG9XdytITHVBUUdWYWlPS2FrQzhPSjJq?=
 =?utf-8?B?bTQrSmg1YkV3YUtzM3NrNG5sQmRGa2YzSmdwS1VlcTRSM3QzRzlIWEVJYzli?=
 =?utf-8?B?NWlEaE9ocjRzTVZXeHZETE85a3lJaktkSitBaCsvaHdHRGMwNStwUmZDMjJz?=
 =?utf-8?B?eDdDZjlaelF1TmJLTmNmQ1VnU2lkMnNRb2VKOGdneG1iY3hOM3N4RXF3MVJR?=
 =?utf-8?B?Z09HNFRxcGcyWTR3WTdwUFdKRCtUaGlRWTYvOTN0QUd0RzBMV0F6UlZDZlor?=
 =?utf-8?B?Q2xaZHF0OGVXdnJlY0FESzhPYnpjWTVrSStwOHNXR3hjbE9aTkw3N2VZaXRx?=
 =?utf-8?B?d1RpVUFvTkpuMzJZMXhjNXZ3Z3p4Tm5renV5eGxjVmduS3oxQloxOEJKWWhz?=
 =?utf-8?B?VFNZSUgzbEllWGtMcW1xUGM0QXB3VHpIeThOTDVlOHJ6Y1hwYW5Ha29pdXVz?=
 =?utf-8?Q?bvH/2hR5AErkaBt8=3D?=
X-Microsoft-Antispam-Message-Info: vUcmHokArXdu1yJZSRnEcDTZLWGGXGFeDr7Pg/2reGTDEUgUP9TQru8/L8qcNfhR0tsRLjXnTGVhQVa12ZNh6D2m2hn+xyQ2KkBYX23BIRa0f/+/yowb++MpAZ2RoRbZ3QxKvNFZUk2dYnZEqR2YZArali476QDZVVYLVzur7NPHj/FJZZDNIRnhOjVPbNvF
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;6:w8pZZnjI2xiouKC+jGwUy3BfqOVmyNFURTRy7Mkh5b/43RiuyaIJmxGzpCYwyhX9XO4puV/AkmWa0HoJ5Yg/ZdQ6FJDq9mkdt3Y1i05Tkyp158VRzEvnue+X73Xe+dGQEg1XrfpdRzc0IZuQlrUfjYlXmk980foBjdOatczcJvRSBcpYS39RoqLNCj2PVm4evzIG7/FIbyG2GDW7bfLMPw/N9QsD7hBHopC2xo7bU3cZLhu9lXxaTeDtGY8v/C225Sa7z5H2B+ZMJzOOt2XYd9WvbtolYQJbJo13g7XGf3UyFA8pdBBzIedWYoxZPqKBbw+VuaO7TZLwHohOgtAsg9hcxALbrlxdrxcF2nCGvm1hfk7xsi2las6R7sTt1RXXnJCgDYcOKeqxIKLh7HqdFU2cub2K/y2PSu9/6t4Utyz9Emd8ZB4c+6bul5wzvsMhFJZQutlbE4csVrfateNPdA==;5:UdiM3GrO2oWR/jk+MTzJrldtreqN+f3V5EoGXHDXRSsTPTaxXbvS7kKl5F6HiWw7PDpFfqVWzZtQJ6gGCpvL5Iom5zdzmIo6y+OL2hJFGwWEo6jl6UnNLgERV3yC6toCwBfVzK+Xb6SbYH/vHJHRYTw4IC/TCCqSGuf1c0FVMVY=;24:rYjD1g9ywD15vRNNMpDu5bg8eGu4AlcWni8GoJBtKrokX7UeLVFNmP0oct5IfvhveL4gG2pM7/jl9F/R8he0C2yf8qKIHO6GssR3XsKuISg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3260;7:Ff0cuN4VJO5RCMVPCTetuI902t30Wx4RfunL9oOuTyk/UoJUOgE06KclfHoziI6G5Z129zmAUmECgODulm/cjsk/ARBqIPgau5JtO6uDOEI7LpZZO6iUq0tq79J0cKIeMVRLEl8Q6fBybBInvybD6c28BCUPdZu6wVPQIrUDbgOD+c+JuYu3Jq8OVqZiWzwtf2Yy/JE+OUgiVAT6eS1ofcNkrAfBjlN0Mq0h1BVpkSGic6xzGVKDBLH+7xne/l5q;20:eaazj2VQ17aDFxFzjDnC/DSiwFnZABl0/gzLyHxXMHV37dkZ+FnIjmjcpqsFscd8pk/+qgwONLTLOw9sb5X/eOlpGarTMlxHg1wAfqGUokj9ZrxfVeRQeEuJLEMwy5muYMRjCxF7ZKhinF0gL4xCawzf+89bBmSyfQyCoAQkjIk=
X-MS-Office365-Filtering-Correlation-Id: bb0a4fc5-3f0b-4768-226b-08d5ba6cf01a
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 14:05:32.9021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0a4fc5-3f0b-4768-226b-08d5ba6cf01a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3260
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599917369470122405?=
X-GMAIL-MSGID: =?utf-8?q?1600539219083852852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/08/2018 08:21 PM, Andrey Konovalov wrote:

> +#ifndef CONFIG_KASAN_HW
>  #define page_to_virt(page)	((void *)((__page_to_voff(page)) | PAGE_OFFSET))
> +#else
> +#define page_to_virt(page)	({					\
> +	unsigned long __addr =						\
> +		((__page_to_voff(page)) | PAGE_OFFSET);			\
> +	if (!PageSlab((struct page *)page))				\
> +		__addr = KASAN_SET_TAG(__addr, page_kasan_tag(page));	\

You could avoid 'if (!PageSlab())' check by adding page_kasan_tag_reset() into kasan_poison_slab().


> +	((void *)__addr);						\
> +})
> +#endif
> +
>  #define virt_to_page(vaddr)	((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))
>  
>  #define _virt_addr_valid(kaddr)	pfn_valid((((u64)(kaddr) & ~PAGE_OFFSET) \



> diff --git a/mm/cma.c b/mm/cma.c
> index aa40e6c7b042..f657db289bba 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -526,6 +526,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  	}
>  
>  	trace_cma_alloc(pfn, page, count, align);
> +	page_kasan_tag_reset(page);
  

Why? Comment needed.


>  	if (ret && !(gfp_mask & __GFP_NOWARN)) {
>  		pr_err("%s: alloc failed, req-size: %zu pages, ret: %d\n",
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 0654bf97257b..7cd4a4e8c3be 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -207,8 +207,18 @@ void kasan_unpoison_stack_above_sp_to(const void *watermark)
>  
>  void kasan_alloc_pages(struct page *page, unsigned int order)
>  {
> +#ifdef CONFIG_KASAN_GENERIC
>  	if (likely(!PageHighMem(page)))
>  		kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
> +#else
> +	if (!PageSlab(page)) {
> +		u8 tag = random_tag();
> +
> +		kasan_poison_shadow(page_address(page), PAGE_SIZE << order,
> +					tag);
> +		page_kasan_tag_set(page, tag);
> +	}
> +#endif
>  }


diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b8e0a8215021..f9f2181164a2 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -207,18 +207,11 @@ void kasan_unpoison_stack_above_sp_to(const void *watermark)
 
 void kasan_alloc_pages(struct page *page, unsigned int order)
 {
-#ifdef CONFIG_KASAN_GENERIC
-	if (likely(!PageHighMem(page)))
-		kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
-#else
-	if (!PageSlab(page)) {
-		u8 tag = random_tag();
+	if (unlikely(PageHighMem(page)))
+		return;
 
-		kasan_poison_shadow(page_address(page), PAGE_SIZE << order,
-					tag);
-		page_kasan_tag_set(page, tag);
-	}
-#endif
+	page_kasan_tag_set(page, random_tag());
+	kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
 }
 
 void kasan_free_pages(struct page *page, unsigned int order)
-- 
2.16.1


>  
>  void kasan_free_pages(struct page *page, unsigned int order)
> @@ -433,6 +443,7 @@ void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
>  #else
>  	tag = random_tag();
>  	kasan_poison_shadow(ptr, redzone_start - (unsigned long)ptr, tag);
> +	page_kasan_tag_set(page, tag);

As already said before no changes needed in kasan_kmalloc_large. kasan_alloc_pages() alredy did tag_set().

>  #endif
>  	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
>  		KASAN_PAGE_REDZONE);
> @@ -462,7 +473,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
>  	page = virt_to_head_page(ptr);
>  
>  	if (unlikely(!PageSlab(page))) {
> -		if (reset_tag(ptr) != page_address(page)) {
> +		if (ptr != page_address(page)) {
>  			kasan_report_invalid_free(ptr, ip);
>  			return;
>  		}
> @@ -475,7 +486,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
>  
>  void kasan_kfree_large(void *ptr, unsigned long ip)
>  {
> -	if (reset_tag(ptr) != page_address(virt_to_head_page(ptr)))
> +	if (ptr != page_address(virt_to_head_page(ptr)))
>  		kasan_report_invalid_free(ptr, ip);
>  	/* The object will be poisoned by page_alloc. */
>  }
