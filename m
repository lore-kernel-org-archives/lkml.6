Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZqe1wzN7qUHHBHJDeH8V/tK0baUW49yFl317CnyXaZMFuKt8lRDQfS6ejnZU1R+XI0DqUMA
ARC-Seal: i=1; a=rsa-sha256; t=1526390829; cv=none;
        d=google.com; s=arc-20160816;
        b=XsOX75/VEu4sf6msH8AiuhCb4JnYHvxOI2gqO8zA6aJ4bhT0hEUJX9nGP9DiTCvN/A
         0/MHw9MgorPSA9XdJsadbhdqsxTj+yXYRMSlw8dFTDS0NU7oGdU9T1bSDE+oEp5p3b0z
         5qWV0NVtcnoA0OvNXWD6RY2uZIvXZh39SwO4/cdjGaz7XhsLWC2qZ36p4VYcM8acPKwf
         Tj0nqlC2uAu92pU3RX/LJlsEE35HhcwTH5ErhSYY+jNCbd2+/kGlKfOMaWjZYFi3wONH
         zcwllxvZhQIKDkJ0s799YehTpNACTJys/1Wj992+E7YLaYCSrmAzJEkBncuwcNBxwUCh
         qXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=sYGizO8D6oQgkZvZyeBfyAdXTex5obT5wgxPyLKndC4=;
        b=HFJAyLh/tJvugXidzw4DC6UPobwoJezSXQBLfKis0Ivj5pYhz8yAtbhBb7gXKFdam2
         nzJmqE+E5cESq6s9VIwYH69sZnBxYS+V8pkZdc93Gqtka5TQUgoLaqLdBMHFbP7DS5ob
         fYodWh8AyhbUy7B4x+5PCQPqwK7yqTkxC6qksCImhWPwFnXoc6TiCzuxHNdzc8yLc+D+
         Ls7eVQxFuWwHTmsvuh2YQTh6Uw/7Pz4vDpuB6ElN6jaPBgUO0hpRNC1pTZ7dt4eT135x
         ni7VAzCnvZQiEe+XNUT4jmL3HOZ9AynEMI8Yi+sx+9EFcH/4Tg/ugXxzEyprtO/SJjz7
         LUsw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=T+h0ljSC;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.0.123 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=T+h0ljSC;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.0.123 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v1 02/16] khwasan: move common kasan and khwasan code to
 common.c
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
 <454315e28d8bdd8e507de2e29f718f1fcae17d58.1525798753.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <69a5a7d3-e2ae-1100-f56f-9edfb0c4b3dd@virtuozzo.com>
Date: Tue, 15 May 2018 16:28:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <454315e28d8bdd8e507de2e29f718f1fcae17d58.1525798753.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::38) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:mqZt/HgWoDGilNJcSUKPMfJMXiHjfaeOKAgEl2/TM52tmqcf3D1Lyz/AYEuLG9TvH0lUNLdAdcFTD04Rr3XDxL31DHe+Mvlfl18/0u2d94AQ/PEVtldFic0F2EFW6PwAwvq/BBUqQUzqjMR/DGV6Tvbs6d+O4BlDxQJhVxaeKUrwE55rFAF2u86C888TCOCGGIYedbGmgEbR5aI/dth6UbAci4tC+fu33tUTZHiVYB4Jh0dbszTWhuROESigA4dE;25:oQBe35qTav0U1NHzZ7ez0TZqQH28j+0sWxXKxKuNtNASW13sITiSej0B1r57VVink5jnKXt3pCKS4tcvv/PSsfV2+brD0KRIUV2L9uNLQP6xu+8viZMb/3/szpXUzxIc9QQwYr+b8AVu+HlA/DuuG0YrPqNDOMBWuECVMwIvOnSkP/EUbTAAZHQ6ECZAKV5Fk2jGoT/V4cIL1afKY0ZnCoARck29jWtLEENMZl3fBiuoH8jLMNtV7emEt4uk6kTzCULK8cFfjkeHzcuLzB+z5aWcXB7fyyyOPcJEtRajGcSM0A7dBHyE9E3GPLkrorNd4sU4FZmm9+CinAmu3Ds/wA==;31:EUPEPY0lvulqbtSNU0WJC2twImarDyif/QRmWjlpjAwovNhTG7BrpWpLu6qNuLGqD1H8HdGFBJgZy0iMtcNwME6Ztz4vaiozjoib1tKnB62kKb0bx3egjlqN8pOHtUr2BQW34OnVOGrmffaBoefd2kmp1yIrdwFpmYHqu+/CJ/C8g3TSx/s+P0YqBRL1mNbXN8TNvPiR1EhCsxjC77RMCXweSHSasxfy7NiqV/cqGuw=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:ft++nzIEUEtAW1QGBA0kpuC6oJ5DIB8jp18M9uovPgzTkv9bWrfk+qrM7Is5RTrfBcbjRnCWJNTUXsB2qebgij/hnPuG5x6ARto7VVlgzwBywhTFQ/b2HWqCdzLtePXraNKCmwQkOfsFRkH83wSpMrc5//NhqzGN2I7Ec7/GRAZS6D0QYR2PGxzr5tH47I9qAlE8RoYbwb5t6Y4/yJIxPrdDARx3eUmWIsh6TmnIiDY+HXD4bI9HCL4Zz92+6uIJGqOLm0Esiv4wAUPCH3EuSLlchkOKhmUWssyGZKf4c5CB2NaXHlk+WucMNSHn019Fnpf7HBMsnGUnQJkzyWsLmerrg4ktm1tYyVQF5UwUsdQUn3FFv7/TwDl5rgihWo8xut6WfUjHR0Tbz8H93D0ybWQgbcN2EZzyQYzxOisws9345Mw/SHeqp7CCy47B6Vm5Eo/K20sqwEeZCRRxYDKkWWoQul7AE1ek2AsO1D/QKnhHz3+m5LqH2bHaiIQ7Zq9V;4:WQPk32iGNj5FzRTLqHagjttULp0x5efRn8mk5HHoR1bi2Mo23Gf173bHu3Xdsbykcu2D4+C9lQ9txuyKY9IEcTpIt73AOYQxxhIxlVmJ6EC5nQqBIFjFddo0TsJDHd6n+LZeZlVLIlzAEHxE/CX9+mnV1Sm/JdBTLyLRkISIyILelpA0MEQ6bXCd1hkAw8agaPTf0zv4vz18rmzuMlHlbFDIiqHp59yyk466/2CFkd16FJW4E8vpsmjeDYON8BGf5JDIuUUYTyXokgUoGavEVg==
X-Microsoft-Antispam-PRVS: <DB7PR08MB325868A30C8C828F951BEEAFB0930@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(376002)(39850400004)(396003)(366004)(199004)(189003)(36756003)(6486002)(230700001)(76176011)(4326008)(8666007)(6246003)(53936002)(31686004)(2486003)(23676004)(52146003)(52116002)(486006)(16526019)(39060400002)(105586002)(64126003)(55236004)(186003)(8676002)(956004)(81166006)(8936002)(1191002)(81156014)(6666003)(305945005)(106356001)(11346002)(2616005)(476003)(446003)(7736002)(229853002)(50466002)(6116002)(386003)(26005)(53546011)(2906002)(478600001)(86362001)(3846002)(77096007)(58126008)(97736004)(47776003)(7416002)(7336002)(1511001)(66066001)(7406005)(31696002)(7366002)(65806001)(65956001)(16576012)(316002)(25786009)(68736007)(65826007)(5660300001)(54906003)(110136005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOjNHZkdZdWVwRkZoeUZaUUkwanlqZnBxY01U?=
 =?utf-8?B?Z2RZdTk1U01OOUJZOTFPT3JJdUdYeXRwQUdSNGJZb2h6dUZOWWNQRERBd2pC?=
 =?utf-8?B?aWczQVBZN0czRGk1VWNRa1ZleDVla1FkM2YyUitiM1RKMW9TbWw3YnF0R1Az?=
 =?utf-8?B?NHNEck96blgvSVlzQWxhalo3TXhwaXpaTDFhbE1FZlVsR2w5WG9xeTV5YWlu?=
 =?utf-8?B?QkRuNDVGK3ZXVml6ZjBFT2huR1BldFpkdkR5OS9LVVR2dFNRcVBTT09tVTZ0?=
 =?utf-8?B?Qy9MblliQk81UVdwSE03TW91dHFaVFVxdG9MRStrSzZMUnVnaWpCUW1LQWsz?=
 =?utf-8?B?bnk3Wmp3aE83UnplWlBGSWxTbGF3NExpMEM1djNrWVNCM0ZWMjNQS0hkQW9L?=
 =?utf-8?B?dHFXblQwRkF0NU1BSG9mVXpZTnZBc3JlenRwYnh2WnNxM25SZGdqMFdWaVJH?=
 =?utf-8?B?SFdrSzZFUzVOWWJlR0pIRWtWcGExZEczTzN4SjRVSmsvV21RL2oxZWltK0Ev?=
 =?utf-8?B?V3NVWGhVZUNFTUxFT3F2SUJjb2U4b0oyOTg3Uzg0MlBjZStnZWRQOUVJRW9u?=
 =?utf-8?B?UjJwVm9zMmQvUlNTSmNjV0ZueWNLZGhkeGRkWTZHQ0t4U05pSDV1c1ZNM0hZ?=
 =?utf-8?B?c2o4YXBybkh5dFVTNmNZbEVXUWp3eE1rSy9MakJicUJLcGpqeUVwLzhCRXFS?=
 =?utf-8?B?SDJaM0ZscU1pVjI3RlRick91YTFLSzFYTWtmZGJsVlpQWDRnNHpKSFc1bDNw?=
 =?utf-8?B?YjRnV1AvZHhIcTZiYmEwRFpGcUVrcjlkSjhuYU45NDI4czJzdDFNVWxqSFNH?=
 =?utf-8?B?aTN4VUFnLzNNcHZqeVdyakZndXBFSkU3T1dpei82THlOaFJuTUxNUktyWEF3?=
 =?utf-8?B?NWJwWE9Bakh1SEtqRkh4RW1kS1FreC9KcGZYTW42aTNtNjJYNjNaVld2TGpt?=
 =?utf-8?B?NlBPVWZMb3VlOElsc0dCcTRQeXdTNUU0ZUZKc3FlbVBLRU1ZQ083UDV3bFFs?=
 =?utf-8?B?SFN1UnlaZ1lSU3hBV1FMRjZKZllYcmJoMXFQbVl6SldmeE1aTHVLYk1mUGIy?=
 =?utf-8?B?bVRTclZxblF2VldGbHpuelh5ZGdRQlVvL0U4RXoveTZSY3hWTHcvdVBxK1RM?=
 =?utf-8?B?MzJOTk5Kc1BZcW5tNERydjJtb2NDUlJmMGFQNC8vdW1COHlXazkySDVNd1Zj?=
 =?utf-8?B?RDYxWHF1N0lXRHVQUXlGUkxjZlJsbmZsbkQ2OXViaml3bGxLSHhXajhMWjZP?=
 =?utf-8?B?TThTMzE5N1Q0blZDc1lBY05SY2dZUFBBcTBvQmdjczRJbEhPSjg2cWxtZTVy?=
 =?utf-8?B?U2dreU1NbnZEcWlWVVR0eUw4T1RZcWh2NmREYUdFSGc2YzM1U3RFOTVrbDho?=
 =?utf-8?B?bkdVZU43R28vQ0tLOWFlZUEvOXZQTnBQcnFnM2lsNHg3MXltRGowa0I5K1pU?=
 =?utf-8?B?a0xWUEFrbTFpOVZJZWRjSWpiU2VoeWp1eXFScXdMaFN1RGRNVHo5bWJML3R0?=
 =?utf-8?B?REk3ZVNOcHBvYkd6dVpTRDF0RUtJVzJvR2ZkNlJpMHdXZVB5MnZjMUdUUlMy?=
 =?utf-8?B?MnBrdmdnbWlZQ2ZxRmVESy9vUTNaZTBYTG5hYXdzV1VoTmFmTENkZmwrMzhX?=
 =?utf-8?B?dzIzOEIwbnUwSXdWSSt6RThFa3pVTTFBVjJCdmk5TEliUTNGREdPU1pkVnZh?=
 =?utf-8?B?QUZUTnhrZHBDSCtmMm8xVUl6NFpCcWhzdHR1bURWMy84dVYxUUtpekVXZjls?=
 =?utf-8?B?NUNtSERDbjBFZGNSRnhQbjVuUytLQ2NvUi8yTldZa0pZTklidWl2WjB6MURO?=
 =?utf-8?B?UmdEa0duR0RlSTJyZ2VxK2c3Zmg3cHQxVGZiMHhzcEZaZUVMb21zc1AyU2ly?=
 =?utf-8?B?RytyajR3bmNHQmNSVE1DTU1uU0E4VlBIYmZhOUFwSExIdE5BMFFZNk8wSEo2?=
 =?utf-8?B?WnEwVWgyNVdOMU1OU084Y2Y3b1dSL01qejRmWnJ3Y0JkSjh5WHF5UXFPQ3Bx?=
 =?utf-8?B?bWV5eWphdGFLK0wyaXd6aldCQ3FTQzBuOW01SVRrV0JzS0pWWGh5TWxzYTV5?=
 =?utf-8?B?alIvU2JneklJNG1jbU4vYkRybE81UmNabGxvY1c0bHVoaDhUM1NRYjMwZG9M?=
 =?utf-8?B?amxRWFFLRDY0WlNKUllSSmtEdjhLa0Fod0l3bmhJTE1jMk92Lzk3V29jaTZk?=
 =?utf-8?B?NVhLeVNpNGxadEFhcXU5SFJOaVNUdjY5c292UUJ5T2JzcTF2cExrR1lreW9U?=
 =?utf-8?Q?c6fJT5mrWNUSXQQCQZ?=
X-Microsoft-Antispam-Message-Info: ugQXniHOPnAFtDcpodOtsnVHENF1LzP4Sfho7enM9Hdih/VX2shxKN9qYhgC7tgvWarjOy9u0hACtNBKxrQnh4AoEMA8MjI4ptQpUCm03SBW8mQtZGIr3FcndW1kgYXsYITvTSr5/jIKGhW6YrF7RJvHAPES7UbeViyNpDHrc9in9JpUWzHPx5WCaJK9EcVj
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:kQH/+Ag3vPGNqfR64J22Yt/gE62CH7YfY2I/b7814IJFfpHOMUzSbTGi2C3Xy51aoR1S+D3rAggmRLGgRQ08L/c+OMKM01TW4GBdQGs5ri1g9B9oWG5mOpmlpFu+fiTUm7p0NHatfJ2EWR/EXoZRoK9cz3KLkJNvQ5IzeJ1B8HLCkyiGEX7M/iRYmULcxf9RNNV4J854X7cmLT9eZtuJ3PscSLVOjSmLn6TBJQMYrEn0DU2cCiigYk5zsK7Wr4J/bNl11bV0N+7aeIy2gh3npuyprDPl3FoSGIoenaRwdps715Gdk3MuzA/F52ORXphPK3fSoNzEHrcnVmxC9K/5IVa9VYtKCX1qsmAUmLtu8C7YP6bv5lwYx+5KBoRIkThe7q1TpubzHV08CEveZ6FaEXl+dpZK1QS1+VepGOr1GEKBAAwUpo/yxF6kqmLPjhQga1i+RlXC3XujiX/hG2+63A==;5:oP5BwVwAMFLywJvfyuZHX/lSI/DeV9DBjA3R/y+S3AUEpZkL5A2SMx6yWf4KoL1Q0IW9OkMLVvH7MGacZkIMv/sCLlt8ELkij2lea0xy6sGO1wzc7+Y3yZJHIAE4v/ubjVQrlXdjeTfMMtYXxhyjUb0WMXlqh0iFRl/LlP/Z/bg=;24:tVQBS01OwMsRLshZfMSVuVq/OhQEo3pHkwB347B6/ZzI9vmnih1q0r7TI786lCl4rVk0l8VFieQNPPEh1y/QIanzXmVX/cJtfLH+b0zqVCQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;7:1fcncJeH9Eq5KZKh9gtOuiZC1TZjAzQjNeWR4+RadCUlFbjwQ+iMV2r0HNy+e3q5TA9rcDDrTGSSUQOPAoYUyJ6bMnyeQ2egfrP/I83XiQy85ZRD7zmsyIpC7Q+DEk9LLs5vcwwiEG2wNkWY2r2p+BD7jrhG0TdXK3fodlww2tPRu8RD5Vio3gFxody+O1iAJiLknMV4GnkpB2UB2LujCeQERAAhWs2nJFj8ttGDjWbmOqCk3GQwwE8G9kL15b24;20:wdsjdWoqhqq2i7Fk+8Zz97FgiA1f3S3kpm6eJAhjWeZ/TSkrAEKIxQ4gIMgyHluC2pRfzgXekjmRqyUpSdBPO6RKeFwG52c5+jk6EgI05VkaukQdOtaSfxqtzXXEG3OaqQ++XKJv2RODvXF9Fhl9K/0/pdC1H+0i4+QjXyLV4kE=
X-MS-Office365-Filtering-Correlation-Id: b253b631-9762-4a73-b4f0-08d5ba678912
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 13:26:52.4238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b253b631-9762-4a73-b4f0-08d5ba678912
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599917338531405447?=
X-GMAIL-MSGID: =?utf-8?q?1600536790060692570?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/08/2018 08:20 PM, Andrey Konovalov wrote:

> +
> +void set_track(struct kasan_track *track, gfp_t flags)

This was -  static inline void set_track(struct kasan_track *track, gfp_t flags)
and still used only locally.

> +{
> +	track->pid = current->pid;
> +	track->stack = save_stack(flags);
> +}
> +



>  /*
>   * Adaptive redzone policy taken from the userspace AddressSanitizer runtime.
>   * For larger allocations larger redzones are used.
>   */
> -static unsigned int optimal_redzone(unsigned int object_size)
> +unsigned int optimal_redzone(unsigned int object_size)

I'd rather move this in common too.
For khwasan you could just add:
	if (IS_ENABLED(CONFIG_KASAN_HW))
		return 0;
