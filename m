Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+ieqM5YyRZO27PT3uEOllZ5OVE7Ci9gypYDv5u4Tfr7ME0hmCRp19bo1/P9jzx+MHG4rF+
ARC-Seal: i=1; a=rsa-sha256; t=1523553603; cv=none;
        d=google.com; s=arc-20160816;
        b=CCAJH7tCtm6NJLB/BtcFFX+38aKfEfKsUuT8Q5oQdC+9B6IKc162NafpF7pdJF24jx
         nczJqZ5Hv0is1v+rLh+d9wgVON5NKAZEI0rVF1tJUqsv6z3pkH46DjGmRayuGq2Dr6uE
         R/OfBu636nQgEHEqOdrvcx7qgmB+MDbkejFHYgPVDHzc0QEZwBTSPAZd8r0evPNjkA9k
         XH4MdlCRC2rMXQdYgtvaST8V9M/K0R8eH+gxw6QaaiRoiaJeU38smo1S8lqcAnxR5JRK
         +yNpyRo8K4vWmSpCIpg3pj/RiH2F3YNuti0keGVwRD9SP7YwyaGIByXONN/INFbqKZkT
         JdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=VrvkNuZRjFQwXeGcgKa3e6jTOkPlgYz19kBjnHsd+iY=;
        b=Y5VW4G4qusfAP9Eb6gIDDCDIi6QyLogao3CvGK1y/z055HK2fA5f4zBcPnZlDY5nVx
         zBLuMJ/MB43aNa61qWhqf6+5T2XcXY6v3AT5Tcjr0OC45WLfPk69EF4VRTW1aov3qaHb
         rTVOonxfUamnndciXH/UQNyD5HH1bNXG33xj2eMcZiNFvu7AIeH9Wik4dqTegIH2e0GS
         QgoplezbjFg29epbmIanHcJqK6YDY387E/TmYotXbbdBH2JExtLptodmsjRm7OdzzyLm
         vkS77iAYCUd2K2puzus1z4Ao7vqfMOuVjVBtEINQh7yiHNAvhWADWcVaUtFVBSics4IF
         /tGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=PGb8rwnQ;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.0.112 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=PGb8rwnQ;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.0.112 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
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
 <bfc3da50-66df-c6ed-ad6a-a285efe617ec@virtuozzo.com>
 <CAAeHK+wzwXnJh1bbhUN6bm788q52BA2EfC+Q3dMS=peP7Px4Rg@mail.gmail.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <a29d22c7-bcae-ec8d-1810-95eef013e699@virtuozzo.com>
Date: Thu, 12 Apr 2018 20:20:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wzwXnJh1bbhUN6bm788q52BA2EfC+Q3dMS=peP7Px4Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: PR0P264CA0006.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::18)
 To AM0PR08MB3252.eurprd08.prod.outlook.com (2603:10a6:208:5e::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3252;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;3:UBEwMIEP7wdmVqSil3OPs/WHRPF0Y0YkyGRkJMu2rxhv7maNd9GWyxNkXOx1RLq3V/Nvq6vcAS1Gx0XTjLMSpxhvq1uwqnMRfxfGGCfmfF1jqL4fnzuUlN9LAfWxkuiiiT4iepuMMWlZ9xiu5DrmIwaa6lsPMnl/w2ubf+srWedSYOu4cAtvOXScDpXTDS4HXZnF1KLXmPHNMun2EdD6buP4UW84qf/NuboOMrldPA7DbbtAiuq+IXkxxIKyMnbF;25:75f5P9ARltQQifxu4XkvisPe2pOudCIa3l3P3RhO8WNGCAoNONURSt13qoPMnp+IHo3YfaMQOXTuTthng1ek9gyq4Ozp/Hx4rrZkXF3IauE+4UzPhy3bBikcICOoHlAsRw50Uem/NGHtz5l64ad7OO+G/1kxaXmpbrH/j246t7RGRrl4xjdKRuF6ieXIK543oZIRmB8mbfG9K5FYIduUW9zNfz/bNuUi8bhraSq8eMyhlH35YbPka6WyqYm9NRj0HV/9zGseOsoAZhEEDuiTuBmjVhnDqsFEeEbbKcw3sCNqYwHSLszjOLruVWFOntir6dOGfjiulVA/4ZK9VOgMZw==;31:A+8O1cHGNoekI1BwEwmR+mQauXvBENgGGrdJkvOH0BsMUHNCLAeEoQIZ49BJNpkVtKZ+3DcCRFTrLZAOH+THblfssJmF6aneqJxsIe0yLv7hprGcS7OqN7TbfdVxRhP4ZqnJjYC1K47au00jNO468+9lZCFftxzBuqouSbLEecay6QIGunkhq2Y0hbyOsCenxZk1OfAuNQ2mRTA7kc9DI+7Hyk7Dw3nbNIrKhIPNo0k=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3252:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;20:1HfWs/qE169obPwhHgHXTsLpPILWa8zItEKW6Ecu3X0/3gpsH5HDkx91Bh7X9vAtH2xhTRcQz5DSdONKq5aDXmhK+P5MvpWhHhREVJj5xBYSRk6cyb+O3MwPbf/FHBKRPPr19wdhFqo8bFvxpkON7s654z4flIhMwO0ze0XfbqbLVmlyU2k4rFYa2Vuv8fhMmTO9FMXbqDYDYrzbgIb1LmHMVlSaf+QclF/5mTWqtDMYIbObYLZ3Kd+QBdi4DNJLhzPg6041QCFUm8C/GQzT76wTXb+GP+xgXIDB6M2gCYaUkGC4oJKREmxTQLilRp81ecxmpSgUq1p7JV5Q8R5bDYhZL4Sh65xsndL4LSF8JaLMVyTTIZb2GKlNnl0IIB9BwDePwJv+VxukdjNzsQ0EWHSIBg83mNzLtgsYXs26M8aRBKYbDArf+QoYFc63POjjs16jJ7hQbO+TkeWmFCdgSOy/SK3ExkAcmk9VPt1reHvvZMvLcZxF4tyin2dONREy;4:sXzkp6tVf45ctJMovHeeCnDHTkZM6/Lk1Drr6lX+gPzikOniRgFD0A2CZv5QpL172/wgmoqeFwZyrnwdREmYqeV23L4Wj8Dz1T9vlJz2ZMqoj4DPmE1MJkgkMiGOjRCnS8AVzm059Zndtqu/GdF7uW3YPXn6vaKegGntlHRPtsBbMUcfnjByMpYfJ0k2sgrXJ9bTC3JhPsZBS+yY2I9o33QZ/7DiIZSKlEKdCiV4qTAuIhhExmC6xOTtkt0StBjdT6Bihe1YNtyX3nfrlcJNVA==
X-Microsoft-Antispam-PRVS: <AM0PR08MB325293DB10F98A76C83C52E4B0BC0@AM0PR08MB3252.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM0PR08MB3252;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3252;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(396003)(39840400004)(346002)(366004)(199004)(189003)(486006)(52116002)(86362001)(81166006)(186003)(59450400001)(2486003)(65826007)(230700001)(77096007)(25786009)(97736004)(229853002)(81156014)(7736002)(386003)(5660300001)(8936002)(11346002)(31696002)(53546011)(446003)(956004)(2906002)(8676002)(47776003)(23676004)(305945005)(76176011)(52146003)(55236004)(64126003)(93886005)(476003)(58126008)(6486002)(478600001)(8666007)(7406005)(7366002)(53936002)(65806001)(2616005)(3846002)(54906003)(6116002)(6246003)(66066001)(7416002)(36756003)(65956001)(16576012)(6666003)(105586002)(4326008)(16526019)(316002)(31686004)(6916009)(68736007)(50466002)(26005)(106356001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3252;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUyOzIzOjg4bnZnTDh1RHVTOE9heUV2b3dlbnZteDZX?=
 =?utf-8?B?ajgrNzREdThpVmpLeWo2cktVeFB1WTlMeUJWZi81ZW5KZFowSFNCeEpsU0Ft?=
 =?utf-8?B?ZmQrUElOcHZqbGpQWGtCbXBINGZ3ZFhWMGNWeUxoUWJ0M2RJV0UzdDFsUjVJ?=
 =?utf-8?B?YkNiczYycXF4M0UrU2hxb3BmdEU5ZG9jTDI4blFiRUZvZm9OalJmZTVXenVE?=
 =?utf-8?B?aEUvTmY0NytiaVJPSFNtMk5zWCtiZm9NK3JoNHVxeUFFZ0dNNDZSeEhCN2Nn?=
 =?utf-8?B?aXM5WWZKMG5UY2YyaGh4VkwwdmhEWVI2VG1id0hydTdoZHJtakpOYlBDWlhk?=
 =?utf-8?B?aEt4aHluQmJwM3lWMUNPa2xyZE5KNmFzSm9MWTUrUU1wSnhjUVh0Y21ITTVa?=
 =?utf-8?B?cDJWTDlxcjhKRUVqbUZMa0M1bDJxeFgwMVVzV1J1UHgxVlBqUmxzNHc0TWg1?=
 =?utf-8?B?OHpaS3dGWUVGcUFtYzh6b0Rucms3ak9HcUFGRVRqaDRRWnpCQzV4UVV4dVVH?=
 =?utf-8?B?VERMWnQyY2wzQlFGalpTUXM0RUkrLzFCbUFaK09YUk0xWnlVTmlnMzN6Rm56?=
 =?utf-8?B?VDUvY1JwdnlOM1F0dDJQVjlhMmJyNXYxZU5YRFM3TzEyeFd1aVo3K3hJTVRJ?=
 =?utf-8?B?Yys5UFNhcDRCcTdjVENpVVJLTWxydUNpRE5mZzVEendlSWx4Kyt4RUlQSGJ5?=
 =?utf-8?B?WE1tQVQwcTFHdzJnUmdGODRxVEphb0pRUTMzb3Fqc3FET085TCszRzVJMXlN?=
 =?utf-8?B?SVFqYWpjWVNPSlo3c1c1Y09PM3haMDNOOXk1MlJkbE9QN1ZsNmM0MVphOE1q?=
 =?utf-8?B?TzJTTm4wSkwvTHJDT2VJL2F4TFI1SnRNYU0zdStLZW4wTVhwWThVUnlpZjV0?=
 =?utf-8?B?aHlNTk0yRjMvN1hSQ1g2aE1obFZycXpqWFpmaEt4QUNLMllaMTBLeXpkS1g1?=
 =?utf-8?B?SmZlVTdnbVhCTCt3ODgxVW1OdjBsWTFZdmVaUkRLME1UL0hrRU8vKzBHY3RQ?=
 =?utf-8?B?Rm9Ia1hGV1FNeEVVNHhLZzNMWjZIazNEbTIvdzZKcTZ4VXlyOU0yK1BIcklY?=
 =?utf-8?B?OEtXZFNOcU1Qb3p1MTQ1NzNocnRhRkN2Ym1MalJneEpVaUVjQ1UxVWUzOW4v?=
 =?utf-8?B?eUtWWHpadlFVMkRTeG1QUEdpME43dWJIK2F3VGFpNDV0aEZ2cE8yYkg3aEYy?=
 =?utf-8?B?ZnJWM21mTkdHL0dDUTZpZjJwS2xSalJ5ZnM4bHQwZmkyRUVwWTBTanR4a21l?=
 =?utf-8?B?RXQ1cFRjZGVJVXlMRE1JeXhQVVN3eE5QVFZUY0dSTzNISFRUMHpsVU9IUXlW?=
 =?utf-8?B?TmtiMm9Qcy9iUHphb0paMHBSbXRSQmNtakZNWXVxTWxZV0l4VXlsNXRqbHJ6?=
 =?utf-8?B?NUJ0UG5VbHpIYjNVZGVuSGhYTGJTQ2pHUVlrQTA2MWQyMWl0d01PZkFTVjNV?=
 =?utf-8?B?YVNkMlI1bkRZeW03a2tEZ3pjczNGWkd2WlFHdG5DZ01zdnIyU0JENVkvTVl2?=
 =?utf-8?B?S09HczFGK0IxK3FPVHVVKzI3YWlualJ6YUxEbnd4SUxMVXlFa0ZtYjZvZ2tz?=
 =?utf-8?B?M3lRV25uaVZKZzFZcGROUHQyY1p6Z0kySWNrUVlaeEJXdVBQb0JVNG1nR2Vo?=
 =?utf-8?B?enMvZ1RPYklkcDdOcC9WV1Z3cFRscXpJNG0zNmJPNXZ5SEdIcE0vMUxHNzhm?=
 =?utf-8?B?WlVqV0VlTTV6VnhGSVdWRS9VcVFVSTZFYis1ZHZzYStyUm9zV1cvMlNNdlg0?=
 =?utf-8?B?TUZSQzZSV2Z5U0l3YWdJcHYrTVZ1Zkp2ZkdMZjFBSnRXS1pDUUoxa1BsKzhO?=
 =?utf-8?B?bURUckNQVW9SSGRzalV2Uk9Ed3RaM1ZWYS9oaVVRNXlzazlVYmtyam9zanJS?=
 =?utf-8?B?Slh3UnFnVG40eXFFSFpyMmRjRTVsbTVCcGFsZkF0OFJmUHlUVmhzZkZaNUsw?=
 =?utf-8?B?Q2RGTTF1OHdNYnFSczJOeVpHVTZSZE56WE9nUmRGRkoyVW02RWludWliRjhJ?=
 =?utf-8?B?b2paVE1FdXR5SzhCejRNdGpXekNKSS8zcC9JNFNSTEJBYzlIMXcvMFM3a0JJ?=
 =?utf-8?B?TENSNTN5dnVUV1pRM2pPanVxMHZOaWJjWjVYV1JiVE1hVStYbWIxcnRnWExV?=
 =?utf-8?Q?pYIGSMMu3/e/WaeXHBNiKdOHGc8qimx7SsNqRDrXDgkB?=
X-Microsoft-Antispam-Message-Info: TcdVKNJ2dzjuh1DMQK6VRrM/dDmXoaDrZwhGMnLPO9JJGWkHPWfsPfUU+9WbwHp7lx89e50/rrjPd/JyM84Dyg+uU+8vhKKiMjEcu+kzF2FA7+hVPUWqN3YiX/p8TxC0kM6o4iqZsNsQibWH0+4JY/MLcM/OcoUJrPJXT09/Yee1s+KTGHU1CSD11rwOwpLp
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;6:gMrzcYC5sKXsZR/BmOXvoPEA21aJ0wv0In6JxxmGtqWycnKVEUblNSftBZZhXqjS6QVQk4btFV9XKg8skmrTNol9XGnRuIBO0X6nKNRLk9Iw4L0L/jOPjQUYpQ6/ceNEkCRxom4YYB03K21Fs/qeykb6G85fJ4gjdn0V6mG0HCZWJHTr1lDGfBwhlhhE88hO+A4WiRT09TjOAseaJQ8PKVrlatAA2RhXfcCV1+dSSvXtTuJZp42bgm3bITC25CZbm0sgy6/WVUoQCZayBNQIuqr+p/EV+1fmVBD0AZT5zcS9b8MhZVgKpGCm2LcgvZD8OGUicRuuI9Fm2U4NlIOQXJE1Zao0HMGTOVFTcejLvyi1dQHYgsJUXsKgGbJ3gDXGxY4wftXUpY4N+hKniXsO3v5Wlw4N1cLZPRe35dZ2qSl44yluBOgnjZW2mHocodl9vCIyXeOpym1zaMEkQ/pSzg==;5:tZi6DgGAcdCjDKOe/9IKUG2mcFE6fzUIjZ7mA7js5/BXl3a5LequBAD1Dl7pmi3SIXy0LMWBo+g0p/2pJPxqHwaPCgdPs9ddm0LsJcrfpTAbWlwoCZ0+hclh8w/AuLLD6Luml42wf8xkgynqfvPQ4uagLEuMwNrtpAdlMDWSZww=;24:wLdfXV+ak7FCvnm+r30O4z8OVOeufhHUlZLl06R2DXGPkD/m2Vj9vHhveJPisqIIUY/NDFop2bTy+su7aux5Tole/edS9+6xFthUNMaUZ24=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;7:7KrvhBXEn0qrjTssNZ5D2O8UsCZTmuMFdroJ4BF56Xxf0o5YPhX1cQ5u8Jf7Uq4F1xvwSpY4BcLMlnj3txtCqyhpwXnLhfs2OKaA5ivkcQTldhv8E0uymsTZH45eYmJ6TPIXGSx8p9SvktVQvY8QO/E2moAbu/Eg1KbXSEi202VC4d1j8pQCj7Nv3yv9elrl3afprw9ij1nTCrKqfINALKGt/kKIBfYFGuNGRAADTVwsst2nEcAGcjSHIwAFQjnE;20:rcCztUQpkoKG0jMcB6xUp/p1+l26/mwRWdhIAa+iJeVFbsgyz1jNA34cNyEEinKqnNCDGZXkqfLzY3QCBagYowVIFO4GOR1/rNMMOO2b/wlYHa7ztRqB7bpzxsszD/ZKOTulaWaYEcwkYTBBUrUoFbQQ9xdi+lZzd6KRxS0Kwc4=
X-MS-Office365-Filtering-Correlation-Id: 5bd571f5-db79-4189-bb6a-08d5a0999cf0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 17:19:52.1099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd571f5-db79-4189-bb6a-08d5a0999cf0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3252
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752721075121286?=
X-GMAIL-MSGID: =?utf-8?q?1597561743300777872?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/12/2018 07:45 PM, Andrey Konovalov wrote:
> On Tue, Apr 10, 2018 at 6:31 PM, Andrey Ryabinin
> <aryabinin@virtuozzo.com> wrote:
>>
>>
>> On 04/10/2018 07:07 PM, Andrey Konovalov wrote:
>>> On Fri, Apr 6, 2018 at 2:27 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>>> On 04/06/2018 03:14 PM, Andrey Konovalov wrote:
>>>>> On Thu, Apr 5, 2018 at 3:02 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>>>>> Nevertheless, this doesn't mean that we should ignore *all* accesses to !slab memory.
>>>>>
>>>>> So you mean we need to find a way to ignore accesses via pointers
>>>>> returned by page_address(), but still check accesses through all other
>>>>> pointers tagged with 0xFF? I don't see an obvious way to do this. I'm
>>>>> open to suggestions though.
>>>>>
>>>>
>>>> I'm saying that we need to ignore accesses to slab objects if pointer
>>>> to slab object obtained via page_address() + offset_in_page() trick, but don't ignore
>>>> anything else.
>>>>
>>>> So, save tag somewhere in page struct and poison shadow with that tag. Make page_address() to
>>>> return tagged address for all !PageSlab() pages. For PageSlab() pages page_address() should return
>>>> 0xff tagged address, so we could ignore such accesses.
>>>
>>> Which pages do you mean by !PageSlab()?
>>
>> Literally the "PageSlab(page) == false" pages.
>>
>>> The ones that are allocated and freed by pagealloc, but mot managed by the slab allocator?
>>
>> Yes.
>>
>>> Perhaps we should then add tagging to the pagealloc hook instead?
>>>
>>
>> Of course the tagging would be in kasan_alloc_pages(), where else that could be? And instead of what?
> 
> I think I misunderstood your suggestion twice already :)
> 
> To make it clear, you're suggesting:
> 
> 1. Tag memory with a random tag in kasan_alloc_pages() and returned a
> tagged pointer from pagealloc.
 
Tag memory with a random tag in kasan_alloc_pages() and store that tag in page struct (that part is also in kasan_alloc_pages()).
page_address(page) will retrieve that tag from struct page to return tagged address.

I've no idea what do you mean by "returning a tagged pointer from pagealloc".
Once again, the page allocator (__alloc_pages_nodemask()) returns pointer to *struct page*,
not the address in the linear mapping where is that page mapped (or not mapped at all if this is highmem).
One have to call page_address()/kmap() to use that page.


> 2. Restore the tag for the pointers returned from page_address for
> !PageSlab() pages.
> 

Right.

> 3. Set the tag to 0xff for the pointers returned from page_address for
> PageSlab() pages.
> 

Right.

> Is this correct?
> 
> In 2 instead of storing the tag in page_struct, we can just recover it
> from the shadow memory that corresponds to that page. What do you
> think about this?

Sounds ok. Don't see any problem with that.
