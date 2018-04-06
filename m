Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+540Xrk9FzM9N7qDRwH87W0tYXBXNwqCLB7QKHc4DYdgmV0AZ4jnugs5rIJAGnjjf38ZfP
ARC-Seal: i=1; a=rsa-sha256; t=1523017635; cv=none;
        d=google.com; s=arc-20160816;
        b=Tn/xydjbmqZw2Vp2yiCqE55mTZ9MYOgWAanBQt/9TwImd+r9ZceohA64661T23i1Iz
         /kNiUNGP2ExkM5S3oVpBkWbXud4DLhRh8iQayeWHzfTMclrLBRpL9ewMn6/O+64W1zQ0
         0L8YgOzNLM52FGh4QvDewnlWzsIS7yehMaQDwOCFyh9nSZm6gEJv7njANglto3KUKQow
         913mahZeezRFshncvfWxjrUA9ZjYLeCYnAIZq99oPmABDhmZdbk2oTL2HEhtsZD6KRuS
         EatvRHtdKmH/5PWDkr4jA7SXnjI9hhiFdB7EcxOiODDiV9D4XWWJJh7fZjDFYYvvZIBl
         jmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=AmEUT7zJFd8jL2reVbSCEIwa0kIkESghJCC5P4nRhCM=;
        b=y6oD9Pb5R9KIjMmWk5qtzkpvFVBYjy6I4hJRJag51g0UKYp+kFnrL9so/8jHOuYdlR
         n9cGkVdSYriwXESVv2JVULglvJ07IFg8EpqKkleY5CQl79PPcjUypImfhfWH917S8TRn
         Tl1DyylTf3Ldk+b11Zp5z8Qy78iohqLVXD/sfR5gOllEDRg499qfO82ZggIeO5KUHS4d
         BKlBNaP0ejwKu/wv2USdvWqkmDrQWnKyKhmJNOtf/M4k2fjPaOqrfSbB9qBEg4aghWcj
         n5GI0camGfp4vY8pzUbYrLvEg1+scercDIN/bgHnpAh20+Wf+Xxrh1tjLQ+PlgdtAGh5
         fN0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=dvAt21nZ;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.5.129 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=dvAt21nZ;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.5.129 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
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
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <0f448799-3a06-a25d-d604-21db3e8577fc@virtuozzo.com>
Date: Fri, 6 Apr 2018 15:27:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xnHeznZwofNQVDcBCCMnaEQ6fcRxOcrFM-qQFUsZ51Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0501CA0015.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::25) To AM0PR08MB3250.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a458f2d9-e343-4174-69c3-08d59bb9b74d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3250;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;3:1dCbt5EddQil7/WL1VHJzJMfEoBjL8hkpFCyB/JZ5WE5Gv1lmEuSSF4CZUvt9FzU90gYO6TjuW5zeZWaWH2glZZLvM+eYFuGlc1m2jCmFuK7pzowdhSAqzy2p6KW8MgQa4Ixo8NalzQioUywTZ8N6aH9Dodu75cxUBcx+onF1wWXLrvEMkBvLcQCmQD4lX55idETIZ5ebb4o1GIQxW087O1F8PlYlMIXPDNh/4e5hmMC5LjgJx0TVBxfwqjheNwd;25:tToqD46Iew5vHxKIAHxfq+9kB6dEHhauNUpQKLoNmj/Zgre2GQoqhk6eZXmKBdZ1iIT5bOffkp/GiDZnNfDlZwNqhBdf/6yyraQl+fMHkrOemDEFZrDvBYQktMx8h+b9XBuEMILg1AWso5gg+xpDCfCd1kRJCgrId4oYR529wcHBrvqrimJ4iIGVeLFJOhM5QgZLX4BHfXxkIi/8QzbBeBtq1jONP+48Dm7zGIA5RdgONlL7pB80sadxCjRcyJG9opCQqqBqP5xNerL1MzjSbjgceEXRi+Nl1DisgCLAj+Q5AZ+fjojMb6nQMDdBaAYL7fZP4xhWpfcpQXLwRO1YGw==;31:qsTYiY635p1silFpTaU1SGiNR46AOePDI3oD/U2SpSPQttaTorM08Tb9TP7G/ZMQZeYQTk/ny7dTEruVr9BsVCNed6HkeDDZYzYywtuPGm7kSvLvGGeO3vFa3qzU4y0WF3v+dyDwAVNdffSbbbA1Hdipe6Q09ljvm3q06FIBDG1yqmo6FzRnFb4Y6Sm1HrCdJeONo0VXShm8waA5TI7EPcZBWLdCDDpKAOnBj8QaTHI=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3250:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;20:3x9M0S2Qb49nSXlg9T8XqKAexjw/e7qQGvwZ1kRAxsHbnESqQoHjAMQhJARMy5/uzp57ZwuhQkLCewBxzLIR4s/8pLDQB2djIluI6RiTJcQkjSqGGjQwVetAgBMXbbduNZeDsPf2D+l34j32eF1RxhJH+KhIJZKRRkB3k6BfbBVjbu4iaTlHo0cORx2wLEU1Jeo/90a5srnJrCfr3tkJGaoKtSWBo3AVXvVqZEWcKBV4og+A0J2Jp8RSgaL2P5TpB/Jdb5ruH9TryrV5jqtKzWlnd9b2TJKNkbDhmsAf0rRlV8NyNlGirOPFvTuB15/jm6H9abpnOY2hoGGoCEORsG4z+euKrrMHjBxSuI+hMJ7BOSYrUMHtXAEor8A9oGeiTua1asGTTwc8tLBOIzfhnQfUFrc5/euMO7GM571OCZzpkOgABNMW0NJLsQ8Ndv/T/7lvKFDh+vLM7ud7XLlpxBOXcDgozbewJKFNquMS3LzGVLrdYM7hBrp1EwMUVyoP;4:5Uk9xH3KfsR+5G9N5WX7RH+mSNn8hxW94XZKOD4vVMy3UI9nLmZ1BJ497WhpBrQpA74xsbPOEPlKFjISfZJcesfrFsad9QO83otFguo8sELZifTDJtFZdr2ZbAiFUvEjN+TtLgsdTxGJ0QRva+j48mUMTR68CBiBoPpTI2J+9zsKbTOC5+UMHTLuywdbc9J7uMhrJxUU1Le1/k0/x1SfjSylG24gwrR+Ga15BtyH6GPDQZjwDFZVQgFD3DP57+IVQAO5qG+b5SoXdR+3UnhQ1g==
X-Microsoft-Antispam-PRVS: <AM0PR08MB3250416647BF2E568E0252D4B0BA0@AM0PR08MB3250.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM0PR08MB3250;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3250;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(376002)(39380400002)(366004)(396003)(346002)(199004)(189003)(478600001)(956004)(6666003)(65956001)(7416002)(65806001)(2906002)(7736002)(25786009)(66066001)(230700001)(305945005)(36756003)(6916009)(31696002)(7406005)(229853002)(50466002)(7366002)(97736004)(6486002)(2486003)(5660300001)(105586002)(86362001)(31686004)(55236004)(53546011)(6116002)(26005)(3846002)(58126008)(64126003)(106356001)(47776003)(186003)(16576012)(65826007)(4326008)(386003)(23676004)(68736007)(93886005)(81156014)(2616005)(53936002)(52116002)(8676002)(316002)(77096007)(11346002)(8666007)(446003)(486006)(52146003)(476003)(59450400001)(16526019)(8936002)(76176011)(54906003)(6246003)(81166006)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3250;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUwOzIzOkdJY3dCUVEvcXVEVVVOZVRGVjJvenhjczFH?=
 =?utf-8?B?T01sa1JKTHlyTzRHK1pjSjdENnl2SUZaV204cjFLampRUDg4eG94VkFpcjl2?=
 =?utf-8?B?a3crWC9mZFFHS2lQL3BnVlFPU2t3WmRRVzFVb3h5OUJ0anNXMjgvS3pETUwy?=
 =?utf-8?B?ajJycXIycms1ODhYKzAvMkNkUmxZRzJYRzZFWEQ1OHJRM2Z5MUVLcUdqY1FC?=
 =?utf-8?B?dFRFdXR1WC9XcTRDYTZSc0R3eE1XV1UweW9RbjVlY29ieE1ieXlON21Jc0pJ?=
 =?utf-8?B?L04yQ0h3YzRvRWZXc0NzOHRxQWVTYkVvOVI5elBCOXdmRng0NW8yVFdZN3Y3?=
 =?utf-8?B?M2Q5cDZJR043aHZXYTNDcXZRZDlmU1FWS2tWT1pOK1hYYmpZMk9aY0VjalE4?=
 =?utf-8?B?Q0U4NjF2Z3FzUlFSWkNsYkJ4MkRBVGxkZjBHV2taSkpHNzJ0MHR2L3hWYXRM?=
 =?utf-8?B?UGxyZGowNDhjaTRNQXI5RHc0QThlb09uZVRjRERjRDNxUk5Vc0h0bHd0dzF2?=
 =?utf-8?B?cHhTQjYwL3QrLzJzd0MvNkdCSzRsQlN2MmFJU2djM1JlWlRYeXd6Z1VWUXRa?=
 =?utf-8?B?NGhqVHNLcWUzbDV3RWNIRGpHOFZKcE5YcUtLbVl4Mng3Z2dOdlZjUkV5TTdx?=
 =?utf-8?B?THlrcEFHRWVKVXE1UkZPMHoxVTIwOFdvelVYL2l0RDVONGJXQmhvZHJncHg4?=
 =?utf-8?B?d2IwcjFEbFh2bVNSWTZoQ012Q2ErcTZ6UDNVSHlRZTN4TEpxeFBFZmJRZmlF?=
 =?utf-8?B?OXhaVFRZWHRjRElkSDlYYmdQYS8zQTZlRXJlVlJ1TlZ2d3o3dzB6ZFg0YytB?=
 =?utf-8?B?UFUyamhXUE04V0FSb0dLZmVPUjhQMk9QMllYTWZ2WWlZaE9MRzVibWFmdXJD?=
 =?utf-8?B?MTE5QjNBRmtUVmQ2VnoxVStUSGdleVZGZE8zdzJPeTJlVGJ5TytxcnM2Z1BH?=
 =?utf-8?B?MU1PZVhYejNJU1ZXeDNWQ0czTFloVCs2cWpvb3dUbUM0VjlUUXBmN0FDWFhx?=
 =?utf-8?B?RHNEb05KWWFBbmdFTVpYQ0xHRDdtVHRaNXdhZU0zd2hyUmhiMHlQNHJERCsv?=
 =?utf-8?B?SXZiN2d4VjltalQ1NzU5QmYxNi80ajJ6K0x2QmwyQUpRaHFzamFIOXlCcHl6?=
 =?utf-8?B?Z2VxQ0htWnkxWnN5TzhjR29RQjRWQXkvQ2NJMG54bVJLTkNCZE9MV1ZpVVVq?=
 =?utf-8?B?bkk4Uk94UnRlTkNRcVB1OVErU3JvSGJSbHgwYTZvMnlnbm50dVlNQStYUktI?=
 =?utf-8?B?a2dDalJjWGVwbTZyRjIrOG5hRCt3VGxLbHdyL1VHSXg3R01TMTVsNVdzM3lq?=
 =?utf-8?B?YlVkVXdJVFNjdG1KR0s5dTQ3M3VMRjFWajhVRWZXYmNrWE1PQ2MxL0hTVFM4?=
 =?utf-8?B?MWx5REhXeU5JbWY1UlJRemJJVVNaYWZEa3VPU0lLMHJHZFNOSWVETkhmU1lI?=
 =?utf-8?B?bzA1S1ArbHh4YVJvVWRjNjJVK2MxdGdBL1E5empQemRNS0lubURDNkQ3Yk1H?=
 =?utf-8?B?cjNmMW52OWlZMndacDVwK05VMkhOZms5WU1KeXFEbXFjNC80ZXlpWGJXbDZC?=
 =?utf-8?B?c3BIa1pRNXZHRytvZkFSR3kzdTNEWU5uSHJxM0hDN0pEZ1UyRGFTUVRSemNt?=
 =?utf-8?B?VGt5QlBwUFpMT0NPcDExMEdEc2ZyaG1idDN6ZzZkUkVQZ2pPUVJCcU5IY1RM?=
 =?utf-8?B?V0x3b1daWm5DTU1jaS8zRDJ2N1BPMVd3Y1E2Y0xBK3dyODZZQTM3ZDc5RGRQ?=
 =?utf-8?B?dElUMjc5R1ZPZndNcHJJblpzRmZuenhrb1M1WlhGYjRCMkNFcEJDL1M5UVFL?=
 =?utf-8?B?Qlc2aHp3SUV4ek5Xb0tFTlMyZUoxN3UzdUVNZnF3V1pBa1JtaThXQWpPNFBQ?=
 =?utf-8?B?Yjh3SjBSbjh0cXoyQk1URU1VQnhRVFZuS1RoVVZob3FoWFY0VHIwNmg2ODlS?=
 =?utf-8?B?M0xUN1Z5bmx4THRQaFJLanBnb3NGRHpDYnhHZDZDQWdlS245QTZqa0J2WnQx?=
 =?utf-8?B?NE5PRnNNa2kwQzB4VUJoWW9HVmtjQmZvSVpCZ1RlbUI5UExCMGhvRWZCZzlE?=
 =?utf-8?B?R0tLNytOQmZOSjg3NzRHOWZ2dlRqSjU0YW1RWUJZd3EzQ3A5ZmVsbW04bXhv?=
 =?utf-8?Q?fjRUxjmFo85fOS5t6KkAefR1qB0RXLR/+P4p3NGf+fdz?=
X-Microsoft-Antispam-Message-Info: rUZuxXM74GX2+7WExiov4PztPOXJpnWgxU1NrWBIafPUIU99dNX18bmIJqv6H4+da/+mecrPTNrn7k5X5np0IbQXy1H5Lc8KNnzWCEL3S6UZv4ZxrFBT7TFZUw5Pu4usYhmZrTygEUNl6tckPhnW+pjq2y7HEzZAPev0HiHIzuBvKpi7MvNKIIB60p3gLE6N
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;6:ShP0YHAUZqOCR5DA9xsSDhzNqYGE7ou7RnhmlQczPaAhE3VMKf+pnapVu0Cv5y0cOUv0BYd/WkLOc1vaFADQfihmo5ssYiznnVYM/bZuugFIlNuCS4aHXZDTzNVXN9fjhJJcpkTfGIRCNm8l+mnbHHF83xITv6ca8EshUN3aGxNZviZPufKJ7SX0l9EzMIoPxBUJ8TXOhKRbSJVt20MBDrw8xUwwKE3mdwh+SJla6fD03dD592PWkxwMLU4fAYSNiblg2KEiQhxw2B0T/ytka9+AdGB5eot0IASzfVYVCm2fi6tkyd2QqEl1WOzwNvjIgAQ88K0Xx3BVSzk/YFlOq9ZM1EMytWaB4fY9kePqiKZpvDh/3/QTN8o+nZSi2VejH50PbpbbeI5F0NPw6yWiJC4QYATL9rL5UBJlz2VJmgcqvlCkXLfHny7SuamzuUP+yRnhJvjMORMBC4trU8hhiw==;5:nk8+1hcsSSwQ7ZZVng73Br5PpJWENpTbMH+sZ6T3VWNIiCjwKrWUjs4xp//0ALyYQ/+5aDtiT3LmkjVOiW2EdsMcTA9315x0Ba3oEHYoCc+g/xn952A6IxFVnno0DR4QmCCIapD8xR5Y4bz+EchluJPVhoyMGAzPSWhTxb6kesw=;24:9To4oC0gy+PGxAxtbCLthjzD0X4Cxtdmq73xDJScybMeNNiwilVwC8Eb3DyGgLlixio6YZ7e2Y/uNe1JZFPpWzqyKysnLAPye2s6BVw3o+w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;7:04enarDynARqaiLEpxZMfKhJUXnlzaKoG+ygU7u+F5StRKOEm31Cn1MgcoPKxWRe00JUerOBhxROjjeORpdmT5Wy0NwhqgFUSUzb2+lLAlMcc7AeFLh335GXDtfUcoD8dAHq8/tcUZUPtNYx83vry6r2OoszTU4SL1Qm7Oq4MQVjdLHdUvn7jMYq90nv1ze+Dyrar49gqZymEo0xzMnU6CkqYtbqtmvf6q2XBs5E9YE7UOusIFrPzbRndyOZTpee;20:RMYyoL72O7bCbN2c3XYfHBpeH+naoJjPuKTDmZvuVp6Or6xaX1opGs5ZpVEeX7bnBE1m3bxc1ojAdq2vqu5AKf1Le5UFSuKSbFhCzcamHyXBKwAQby/8P6nNRpbl08SjbTCOiikF5uWab+qlYXJ3tb5NL5WVr3GGiypbJWLDVFc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 12:27:05.3258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a458f2d9-e343-4174-69c3-08d59bb9b74d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3250
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752721075121286?=
X-GMAIL-MSGID: =?utf-8?q?1596999739679907934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/06/2018 03:14 PM, Andrey Konovalov wrote:
> On Thu, Apr 5, 2018 at 3:02 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>> On 04/04/2018 08:00 PM, Andrey Konovalov wrote:
>>> On Wed, Apr 4, 2018 at 2:39 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>>>>>
>>>>>> You can save tag somewhere in page struct and make page_address() return tagged address.
>>>>>>
>>>>>> I'm not sure it might be even possible to squeeze the tag into page->flags on some configurations,
>>>>>> see include/linux/page-flags-layout.h
>>>>>
>>>>> One page can contain multiple objects with different tags, so we would
>>>>> need to save the tag for each of them.
>>>>
>>>> What do you mean? Slab page? The per-page tag is needed only for !PageSlab pages.
>>>> For slab pages we have kmalloc/kmem_cache_alloc() which already return properly tagged address.
>>>>
>>>> But the page allocator returns a pointer to struct page. One has to call page_address(page)
>>>> to use that page. Returning 'ignore-me'-tagged address from page_address() makes the whole
>>>> class of bugs invisible to KHWASAN. This is a serious downside comparing to classic KASAN which can
>>>> detect missuses of page allocator API.
>>>
>>> Yes, slab page. Here's an example:
>>>
>>> 1. do_get_write_access() allocates frozen_buffer with jbd2_alloc,
>>> which calls kmem_cache_alloc, and then saves the result to
>>> jh->b_frozen_data.
>>>
>>> 2. jbd2_journal_write_metadata_buffer() takes the value of
>>> jh_in->b_frozen_data and calls virt_to_page() (and offset_in_page())
>>> on it.
>>>
>>> 3. jbd2_journal_write_metadata_buffer() then calls kmap_atomic(),
>>> which calls page_address(), on the resulting page address.
>>>
>>> The tag gets erased. The page belongs to slab and can contain multiple
>>> objects with different tags.
>>>
>>
>> I see. Ideally that kind of problem should be fixed by reworking/redesigning such code,
>> however jbd2_journal_write_metadata_buffer() is far from the only place which
>> does that trick. Fixing all of them would be a huge task probably, so ignoring such
>> accesses seems to be the only choice we have.
>>
>> Nevertheless, this doesn't mean that we should ignore *all* accesses to !slab memory.
> 
> So you mean we need to find a way to ignore accesses via pointers
> returned by page_address(), but still check accesses through all other
> pointers tagged with 0xFF? I don't see an obvious way to do this. I'm
> open to suggestions though.
> 

I'm saying that we need to ignore accesses to slab objects if pointer
to slab object obtained via page_address() + offset_in_page() trick, but don't ignore
anything else.

So, save tag somewhere in page struct and poison shadow with that tag. Make page_address() to
return tagged address for all !PageSlab() pages. For PageSlab() pages page_address() should return
0xff tagged address, so we could ignore such accesses.
