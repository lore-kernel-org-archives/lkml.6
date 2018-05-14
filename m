Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZpDj90LcWRerBiIh7PWWFE7XX6tPrVwkYK/3gNruGhaKcTSu858quVg4WXeLjBHucO7+wan
ARC-Seal: i=1; a=rsa-sha256; t=1526316966; cv=none;
        d=google.com; s=arc-20160816;
        b=G0bK+jQ0C2p2wLVQ4CPs2VpK7NK259yysM4dgLCf4dj1/Zaz0+89sepfyaleFqFPO6
         W1aqPWBiqnNqdjovwGQzk/deJKNMqlv7qwh7SukdVraNSPhnCFFiOIxlX5hz3eyEtKXw
         7KlvsQE/P5s/ds86UoAz/YSY64DIFYxPRXnH6FhFxnEdjnM4OzPaesYDNjrnwDWiQ/Nx
         XPVMRYOVs67ePrBsTpWl9hx5VVVSCu+Tsy/hkzkRN7iEPWrHK/Xm9P7HOOeMgUfDjk6G
         N7OsGGj3GTeEuIJ40cfKdUnrLWJzKnb5CLerd9S6YUTAIQYd9IpO4mFACTJ7ulh94T+W
         hPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=mToqI71QciK+6PDSihoyIeRBRv/OYCmBNDaXRrAAzJ8=;
        b=N7g0TocupmEVxlUGisICNJMsfbwjbBpAS4nAdvL3UN8LAAT6XqQk1SMgWrobe1Pgh7
         MLUpLIo0klSCGcZ+uvBWZJil5sh+L7FocA8IC384xozBMHJSg2LWszy238XNX5Op4iWB
         5KawZZyZ3hCe9d/hqcraRI57VPva28iTNFUyALzvVSUEXIg599OXrlgWUFwpn8de4NA7
         SPzdqKDnZnvtFw7zZFLZw0cAADJJ9GqGVldNytSZPaXtDgOlzMyfWokYn7yQtSxPJ/AJ
         Xvso9KuDz+xl6yYJM/w/5uwqPBHiPpnaCsbSUS7bOU8EPo+DUmLqr2zPXBd6+W8sbRAo
         dNVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=UVMqnaD0;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.0.121 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=UVMqnaD0;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.0.121 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v1 03/16] khwasan: add CONFIG_KASAN_GENERIC and
 CONFIG_KASAN_HW
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
 <b31260f782783e21ca2e2a45f9b05016998bf9ed.1525798753.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <658f02bd-e647-52e6-87cf-5d91f8243b66@virtuozzo.com>
Date: Mon, 14 May 2018 19:57:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b31260f782783e21ca2e2a45f9b05016998bf9ed.1525798753.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0501CA0009.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::19) To DB7PR08MB3259.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3259;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;3:420c/K4PEKqPlf0Vq9fcx7gtF0E+DdrATgpeeAWohOMJFe049CGdI1DmdJe4DzsWHzvM95fm7XBY3AJzofNG/TXUYILYwurKqUcz9qle+oJmTKxp630cjutL+ckjdqhy1EU5Htlj+fmvcqobEMr281e+5kCcbNjudfyhxtIv75j6pN7pVUg17m7QBRAuoSxr+Y36w8n+GsIAv+x1vPvuQFG2NmoDX8GmAvUXUkBxZCkgqSVvUh+QJHi7MbFfQcMF;25:zQ56jCrqihSw+axqL+JQsZdS+pYGoC7ViX+GVvAw7hWuAnFKrm2bEYDVg1HipMD0SVuWTRYXKcWf/OX3/FpD+nH4/Y+ZUKLxIGzIqkT116G/878RiAkTjk0+6sjCBb58WZ7ulUH4atck9agMpwFAqA7KkRNcMYtlUx8MrMr5JHlt95oL3SNzxYIEiJZ6q6O+hstftkd4f2z1U+rnKKdPcFt4HepkhO3dBpDId+zkRbtWVB2Zd6hErRzZ3peu4Q4iLMPSKyNY7mQ0OhYNo57fo39Kj0rWzc9DQlzzA9crRlO2IHTU/aQg/btd0wIgUVc+OeNxUYNcdY+00ua0t4DvTQ==;31:pxAjMWek4kr4+JtGO66Ohkz+LcLv0IgI6X5e0Yy/LJjpUULNXT1w1+hogJpZUpx2y1nDd/LXcsVZVklavxSTtciSpaRlxkdga6v4xKh7AcvsnNlRH/gqFXsZQ78vILKUwQ7/WrV3ri+e5hHZUHWbjZ1eV4UQJb/kVtrEJLIol+oBL4f67FajFy3O193LmynC6GKEkg59V4cbHJX4oohpQP1bqyFlPF7Z6nA8YRIHkD0=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3259:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;20:0HF4lgwTcC2/bb92mUOjEojh76p1JzDKsMzNhLF9hFeWXzk9pmKdV0+9QPsJN4fe+PaW3Vy5mc6ZTpbsRUaiZS8wdF6S8AZLwgyKVIsIyR77/7uVekWCEhgTsaaAonIpzj91JSgJ6k/tn3cJ4jrbN9qMW3L2o2TssFtRzru+Q0q4+gfEk9qhrYy/p8ZyV3yS34plgP7v5X+ZrBIrFNayHKgZi0Q71g4GnQneDhUlQ6pHb0Bt5G5frJRjyqN8+GjOrp54reljWtrAJ8f455u5tFPZR9yXEdY7H0ngSqBXTySrXDUI+rFxL1yM2u17AxVO299TZUzobtm95SFMDwRMDr1BLDXA1FELEPERoENK5vH4VjJEPQWOKNQOW5ivedJ9HJ7D4UGxnPxHF/19QkPRXqmGZWyimuSwKGPGfd9qdXXRbEZqbK0ZXG5B4ZEif2GkjkojpLLGkaHL6QG/PPH98WGyLNdCrSRP8grKw7xJVUYnliMZHAjhLjOrWKocfk30;4:koppj35lYwJSoEMnq0MhrGOn+IP3nhcYLVr9Pv09HKInXzUjnoCC92q0NjYo9dcPA4X2WP1fqKUME5qrIgkcPIUBX7AQZcyOotpBT0pY7zrwEaauCkE6FZh/521qLb+EZvIcRN918GLTQRbt66qrEE8G5UPZ7/YB8UcS4Kd64uxjK2R+ts7vH0cYW7iRXFPRJQowGQ5Rg1/g0zfBb64XNiEJxiEGqnonJsRZre58L38XAvHJ1eYy5/scnkyIm897sJwztfhd3SWg7giZUxbicQ==
X-Microsoft-Antispam-PRVS: <DB7PR08MB325945C656EFE48DA1F0AA8FB09C0@DB7PR08MB3259.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DB7PR08MB3259;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3259;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(346002)(376002)(396003)(39850400004)(366004)(199004)(189003)(58126008)(6666003)(8666007)(6246003)(478600001)(5660300001)(6486002)(31696002)(230700001)(86362001)(47776003)(110136005)(54906003)(1511001)(8676002)(81156014)(68736007)(16576012)(7336002)(7406005)(7416002)(65956001)(66066001)(7366002)(65806001)(8936002)(81166006)(229853002)(97736004)(316002)(53936002)(31686004)(105586002)(106356001)(2906002)(53546011)(386003)(59450400001)(55236004)(7736002)(1191002)(446003)(476003)(2486003)(65826007)(76176011)(52116002)(36756003)(23676004)(52146003)(25786009)(50466002)(16526019)(3846002)(186003)(4326008)(39060400002)(64126003)(11346002)(77096007)(6116002)(305945005)(2616005)(486006)(26005)(956004)(41533002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3259;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU5OzIzOms1QWg5NVVQMjljVlFNRWprZzNFd2tmOGpq?=
 =?utf-8?B?VjBZRVRYMHlLNE1tbEVGZWRGUm5kRHRVOERobmlwQnYwc3I5NlhFQno1UDk3?=
 =?utf-8?B?V1RkYW9mNWE0UVFkbnpXb05OTS9QcnIySGNGZWhERGtCbHV5V3AxU1NqdUlz?=
 =?utf-8?B?a21OWEY1QmdYZUNpdlZiMHFBVFhNNHlzeWNMRGxEc1hmcE9xQkdhelQyZkl1?=
 =?utf-8?B?bUdMcWxvUTZtRHZZdkxyODUvMVQvWC9UeVZxYTNMazJicVFaZTYyUzU5VndT?=
 =?utf-8?B?T1U3VFplN2RaSWNBd3JzYzA0anNvRTMxdkE0TGswTy9Lek8vVnBocVYvTFd1?=
 =?utf-8?B?dEVQTVplM0szdi9DSTFxcy9NRGpkYWNvbGZxMkRwbGw2VzVFZzlVNWF4cnVT?=
 =?utf-8?B?K3dGbGZyeTRkQlB5NUdyQS9FMml3Z0hScENsTk1DaWtMRVkvb0FISzBQK1ZP?=
 =?utf-8?B?aEo0UCtCRVNPeEVUbkt5cGxpMEcrUHRXL1JIOFFKUWhpamo1U2lmRk1RbHFl?=
 =?utf-8?B?MTdBYXF1bmJOKzF3VDBwYXFrZ0RGUklSN2Z4aUk4LzNGSStjMDJxWnNrMFUw?=
 =?utf-8?B?b0NpWTk3akNHVERnRERIeXcyQTg4VG90dWxOOU9JNzN6VFpEWDF5MVAyZGNu?=
 =?utf-8?B?REc2R0ZJZ21CMHZtb3NibzIxRlVZdm1wNWZ6UDU5NUhSYnFiRzl1K2JZc3kr?=
 =?utf-8?B?UlJoVDlHQ2duZWtjRGFBRDRtek8wZUVxMmhGaFZwaWhwQkFlN1F1NW14NVVj?=
 =?utf-8?B?QVdobjZzbkFMS3JISmtQQ3JmZ3VQOE05ejNpMFZMcURyS2VWYmgxejV6NFdk?=
 =?utf-8?B?VWlDbVlqYUJSeE9yMHlZampqa0hDVVJuUU1BOTBSUEJOaDBiUHQ3djFHM09X?=
 =?utf-8?B?dSs1d2Y3bVEvSWFjb1k3TldQbDhZMmtJWFpEbFdYSWp2UTNQZHZLcG1HTGY5?=
 =?utf-8?B?UEtCNFZGdHg4M1dDWFpKM2Q3SURnRjkyeE85Sk5XUCt2VVlPcDdYenpCOEtS?=
 =?utf-8?B?ekN2c2pUQ05DTGtodFpJLzBnZjFhaldGeXpDWDJFc05XMlJqRHMrUGxzRGRP?=
 =?utf-8?B?UFVVMHZ4MU1WY3pUWU54aHZUZjg5YTBkbVhCSDZqcXdMMS9JZ01pWUQ3bzRX?=
 =?utf-8?B?a3lmcXpTSVhSVFA2bTJQd2M0SnhTanZEalFPN3FQNFBDZTMycDBuY3ZNb01M?=
 =?utf-8?B?Q05qWGtDeUltaWp4T3N4YkxSdUlQbXJiZjNsWnpLZ2k2b25IUVdhRTdDbDEr?=
 =?utf-8?B?bTJDeEhnU2VHVnF3ZXRrcmF6UEd4U3B4Y1h3YmQxSFNrRTR1RGhBSDhNemNS?=
 =?utf-8?B?QUxlK0MzLzRhOSs5bVR6VGpKdnlXaUlYZUhWYUhTOTk3RFVISkpXc3RVVU5R?=
 =?utf-8?B?V3BtUk05NHgxeHI4QkNKZmxMenpOWnFjcTVTNWowSTFnTEhDeGdPSENHc0V2?=
 =?utf-8?B?enYrRUs0bk9TTit5SzJrTlNVZCtwd2ZsVXN0RWhXbVVIQmlPYUdsT096NTdr?=
 =?utf-8?B?NGlrYVlXNE04UVJaNEZsQXRwV3I1WlVWS0tRMFZJQ2xOV2VDRkxEVGJGMTVW?=
 =?utf-8?B?NkFqY0FrRmcvbElSUDhXM0YrNStwWStPZnphakhDUVN6U3BIWlc1WjA0LzEv?=
 =?utf-8?B?MmV4N2dnbnV6Mkd4RVNMSUlHcnhTTFIwZU5ybjlJREFiWHNYVDJvM2tia29Z?=
 =?utf-8?B?aUd3UXJQaXFhTWF1S3BkZHo4ZG1QUlJPb2xERkJTRkp2eTZBM0N3b0FtWGZ3?=
 =?utf-8?B?VDVab3BHeThLaU8zeUFsWW9mK2h0UEJlMVZvRldKQkdHa09Hb09Xb2NicG1U?=
 =?utf-8?B?MURJd0h5UjFyczRRTDJuOWpkTk5YcXlBSDJaSlBwSkp2WXQ3NGl3R08rU0Rm?=
 =?utf-8?B?emlmM2tMdHhaMy9tZjBJNWp0d0pNYmsySWxqUUZLWHdlZCtsNk5GRkpPMGJE?=
 =?utf-8?B?VzZIbHdpc0pjTDlwblVpSjBQYjd4UG8ySXhWYnQ4RnRKZmhsTkVlOUZuV0pS?=
 =?utf-8?B?VWxoR1h4bHBBSXFLUkFQMDY2aGdCRE10T1BZakNaQU1kWlNPck1UY0FRQmIx?=
 =?utf-8?B?MlQ5SHdBMnhHRlhqMkdENHUzc1NVbEp1ekxjaEJqVkRiZS9RN3U0S1E2VldP?=
 =?utf-8?B?eEN1YTBRazFwa0lwak5zbHFwTjZ4aFROWDhUQjhZS1lKSVFWcUc0eGp1Y2lp?=
 =?utf-8?B?cjNDWjE0N25UcXpVdjI3aVozRlAvOGQ3OHROeGczQnJuVUE5ZWFlRytXV213?=
 =?utf-8?B?Q0o0MlVpTk5Gd1hjb1VTeHAzMzkxaDk0MUsvOG5QeXl6NGJzZlIzT2VPN0Nq?=
 =?utf-8?Q?lDjMRcbzDBUMxZA8=3D?=
X-Microsoft-Antispam-Message-Info: jsgLAydDMO1yaxSzEaaogFCvXPcUABQ3Rbsc0d8oCenqHvuCj5ZN5I1PBVJOBIFm8rby2RqXsB8Ls0GsVQ7j1CrlKKBXDAAC51ZQcLoRKJTiUio2ktBysm+fb8vM88/u99/zL5BDOQ9LkGpfisqlof3yjSWY6lbgAeaDRv1/qaVuHFNJZLd6Cn/R2Eq0dMqq
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;6:fXCreGVvvkR7QMoWhK51C3+qPTrZW+lLEwfEzzXLywzXOBTTIY0G6diBemcOztB8qk+QMnhGRwGuBf0+8DhhZXLCsrxLYE6KW9GVDpsxMAnQAxO/WA6hASzdzx4kyIAlasMu39ye7PyCXJjGhytHlOhy+HpODd25pj1V078wcrhNFMXdxBAId94awJYyk0lKelvuXAwoBbYQKoQZsj6Dngk9y1yclk/j0jD6Ax57wEXPSGxj3uMYvOiwS9bNJmDIl6TPJaYddWirbA8/LmAIrhq46EFNtcrVHfU1NhBieHHaV4/SfLRJcHidrq/xnqqCD5tpBrXRsZ3B0B/nIIz/wpsOtWhvnA1K9ZDcBiuc3Al/qE7UlvXE1bX13yH9/NSokl1o+Lmt7raNQDbWSF1VmX0XcD9f/ca7vfglnpdCucpS7Q3loew+xzbD9n/6najaxGBy0xdy7bHrpQ5t+1MNlQ==;5:xgqXi28X6wIdh+gLd9x3MthcB0f/if4WdzI0lfcUMrL0wdiB4CXGqJnX0Xffr9jO6HYSv+qgjs1Hnvfr7JCg6XGePvhz+JT6bWjuksdMuPmfvO+Gp+HT6jMyUCNfVJWheU7viWAcfS9ru0aim6Oub4CfHBsXUIRESurfPJmR7sM=;24:aGC8PcOTuJ4Wn2+HJeU7xNNArQcFM65t9PAfvifv3jFJDfJ3Q2HKtXuN6AmabA5hh2fGqBPpEc53/5juDNcfRX0q4imX8UV8c/Yle9mtb74=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;7:yMaCvk5BaORSP1AI0a6zNReof0EU2leegomPOQmFoF8L9tt0Sp6e6Rpq589wIRjZdd8PKFzFEvmcVSTe5rVBIVv4CtWshiQ2Yj59QdDMM0jZVbtT/uDjiV9gIpIQR54GEw+pdeETULxPtKtQ2FEyqQVTCEhcWUnGXr2XgHg+o6x+EOp4I6D442C+dVmhctKqXKxeddLn9mXPnFRPdd9BsJYsYNyvhPMG47wArBxnAN2UV/QK1vVIGFiswOTpNTeV;20:rOsnX424nJX0C/vUcCUyDwwJj08QqV+8Wd1ui52B5gTCVPWvxZ1vk5qI1VfUTWBFWJpM/qQcBoDZTEl4ASfxfxaJ7mfTOoXTKYe3WDyMxSnsoX7+yMFPz8E7YfO2dQiTQ0SGsGr/IZm0Bkmkiqpv/FVVznSbE/EbL0jffR9ndSk=
X-MS-Office365-Filtering-Correlation-Id: a59993dc-5a6d-4822-6350-08d5b9bb91cf
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 16:55:54.1134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59993dc-5a6d-4822-6350-08d5b9bb91cf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3259
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599917339726074425?=
X-GMAIL-MSGID: =?utf-8?q?1600459339012956794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/08/2018 08:20 PM, Andrey Konovalov wrote:

> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index 69552a39951d..47023daf5606 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ifdef CONFIG_KASAN
> +ifdef CONFIG_KASAN_GENERIC
>  ifdef CONFIG_KASAN_INLINE
>  	call_threshold := 10000
>  else
> @@ -45,3 +45,28 @@ endif
>  CFLAGS_KASAN_NOSANITIZE := -fno-builtin
>  
>  endif
> +
> +ifdef CONFIG_KASAN_HW
> +
> +ifdef CONFIG_KASAN_INLINE
> +    instrumentation_flags := -mllvm -hwasan-mapping-offset=$(KASAN_SHADOW_OFFSET)
> +else
> +    instrumentation_flags := -mllvm -hwasan-instrument-with-calls=1
> +endif
> +
> +CFLAGS_KASAN_MINIMAL := -fsanitize=kernel-hwaddress
> +
> +ifeq ($(call cc-option, $(CFLAGS_KASAN_MINIMAL) -Werror),)
> +    ifneq ($(CONFIG_COMPILE_TEST),y)
> +        $(warning Cannot use CONFIG_KASAN_HW: \
> +            -fsanitize=hwaddress is not supported by compiler)
> +    endif
> +else
> +    CFLAGS_KASAN := $(call cc-option, -fsanitize=kernel-hwaddress \
> +        -mllvm -hwasan-instrument-stack=0 \
> +        $(instrumentation_flags))
> +endif

So this code does the following:
 1) Warn if compiler doesn't support -fsanitize=kernel-hwaddress
 2) Compile the kernel with all necessary set of the '-fsanitize=kernel-hwaddress -mllvm -hwasan-*' flags if compiler supports all of them.
 3) Compile the kernel with empty CFLAGS_KASAN without a warning if compiler supports 'fsanitize=kernel-hwaddress',
     but doesn't support the rest '-mllvm -hwasan-*' flags.

The last one is just nonsense.


> +
> +CFLAGS_KASAN_NOSANITIZE := -fno-builtin
> +

Does it really has to declared twice?
