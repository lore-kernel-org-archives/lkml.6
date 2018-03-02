Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946482AbeCBML2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:11:28 -0500
Received: from mail-eopbgr50091.outbound.protection.outlook.com ([40.107.5.91]:21568
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1423004AbeCBMLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:11:23 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH 2/2] kasan: disallow compiler to optimize away memset in
 tests
To: Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Jeff Layton <jlayton@redhat.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc: Kostya Serebryany <kcc@google.com>
References: <cover.1519924383.git.andreyknvl@google.com>
 <105ec9a308b2abedb1a0d1fdced0c22d765e4732.1519924383.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <41d0e9bd-9102-6a50-e0d6-c193696381c9@virtuozzo.com>
Date: Fri, 2 Mar 2018 15:11:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <105ec9a308b2abedb1a0d1fdced0c22d765e4732.1519924383.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM4PR08CA0071.eurprd08.prod.outlook.com
 (2603:10a6:205:2::42) To AM6PR08MB3256.eurprd08.prod.outlook.com
 (2603:10a6:209:47::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4033d822-628d-4751-55d4-08d58036b53d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM6PR08MB3256;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;3:EB3kqht/GFibnMeGOAPsCuOo2S8jTiQ4HX1kb+VxG1hBJWgfzUut0X/98GqeX55CS6iYxCLsib9ypskJl6QbigEknUg0Z9VziptxuCpcq1bS1GDH27wcN6MfW5FJha0xFvzjyM6rm4kGBo17OWgFrmMkNwrngmVlrSlD56GcmTvPtkeQwJtFt1q65MO5R8mpViQUlr0XfKhRX2IfwVNAX1hN83ZFfZWebzxNWIJw10yusxh1E0SMdJworZitqI81;25:4XCbNBCtjilmA8o+OC3F2EqoEt3fIPUIKAJ4VqHywdO5mc1umZnjdK5JkgEWcrDBkgqtTBpDRSgiMsS1TCstKs7ioa7OuKER2Ioej8M3lvKJhZNNtvcM/bZjGd8WYaeW1NtKpmrQ+17iJKz9hqGBQC59w059njOM4qylUqOBrt15JN2kR2Nsj0dayLh7gs3kykW9YgpplzabHCsC31Bw5EumBzylsRHX+NvBGhpK2ShRXtWL37vUZ3EBCGRxNLuXvNwaVuNeI3B3ML2XpAoVIu/U0XJkBdpAH19CVmDIfzwVYUcgmKkPMvxPv8zfCDXuaBSMasnbzhZlciGDjYQmpg==;31:4GVZjUE9/9o0qhfjK9rOgKAjfHgEQLfZ4/HWQPJuz9m/fqUAzSDaH02gz5kK7RuuoG5g2PxEw61gWSVIeZTyddHJfVmApQcAPKfpOZdWGsPTxSZvog8MqOogxBPXYIhIkvD7+6/tk8UPNXnyBA0KspAJNlgt3ok6esiGNoS2JEV/QcnBzXBy8lLG7zfHQYHHDsWpuedYS7hck0DS4nrAxEpXKTz6jkGrMRcfHIJax58=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3256:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;20:3L5ge2k0a2rlG5JzGGVg5VJk/VENcS+2S1oKw9u69xQDY4xikPGAhzEXleTpVGmCN0HOgpfc2NT4QVkW5lTkIQx2jah2EdoTihutFvEIjBPpGCCzkuqZScVqafARf84YcpAxt/UagJ6ix+ojqeembib2/IFg91BBLoMHoecCCmZhGpAyjFHAobNeC9v/uaSYFd16CZBbNWHngN2QfwZOJY84wyhh5l1d0GuHEnoy8slQAu2Vesqlf6NSYem4YUID9KA5OzNbVqe5ipdNvGZxBoXszn0TWkwheDhNSGmOD10UlW9razvhlNj5oi5LNTsJuD/9N5anhLHuoJl7ME+T+czR9Z5XLYgpPGJvvMjfhtdaRIv5NbjcHK+dzKQFCgMwz2lo6o1ZQv7sGhT/qYZ52dslNCZhKyRXBuH4TFb+HVMR+YG6XUh4R5v5hXq9nBkngWbl1uqKOTkTj2n29So2w6sf93d+NRyl1fY4fdAo7ty6G4Dj/aZ3qD97JYQXN6oh;4:WPGt48yZ0lBkczNY6xoCOl8sU/3qbHQRvmJbR19xaAig27Iy/vJBc50Q22xQfQWUTG4fyCaytrpqjGBv/hSZj7Mbxixq6Q264gWvoD8aKb3J7bfhWAlNMZAYBnGE2WIKI6niphPuepTWawv9C1l0ca6b4LJMoXO6mFqPF2uiNoXmqIGYonANsZVss3gycz743lFzUaZWcPHBqYB/qdA5A0MlhCQGb7Kyl95dSGj9nx5RzHURmh0BNaQdBnuMv9Sf/TZGphH0/2R6GWrqxDFpZV0+7P1Y9LeOPSoECwR9nb6HPxONoXp6OYTnseDM0om9ZFtaa/pxfTbcsgElZbV8+A==
X-Microsoft-Antispam-PRVS: <AM6PR08MB32567C51CAC835A3D9E8E358B0C50@AM6PR08MB3256.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501239)(52105095)(93006095)(93001095)(6041288)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM6PR08MB3256;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3256;
X-Forefront-PRVS: 05991796DF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39380400002)(39850400004)(376002)(346002)(396003)(199004)(189003)(86362001)(81166006)(50466002)(55236004)(4326008)(65956001)(64126003)(68736007)(386003)(6666003)(65806001)(76176011)(105586002)(31696002)(53546011)(47776003)(66066001)(65826007)(478600001)(230700001)(6246003)(23676004)(25786009)(8936002)(106356001)(7736002)(2950100002)(305945005)(31686004)(229853002)(53936002)(58126008)(81156014)(8676002)(7416002)(5660300001)(36756003)(6486002)(316002)(16576012)(110136005)(52116002)(52146003)(2906002)(26005)(2486003)(186003)(6116002)(16526019)(3846002)(77096007)(97736004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3256;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU2OzIzOmd4MTlsNEhaUTgvV0ZRNk9nZWVkVFJDYTZj?=
 =?utf-8?B?clU3eWVOOTdBV0tjb1dLVTQzM1ZXeTRheTJyWkgvRDU4aXJ1aU9XVUlKMllI?=
 =?utf-8?B?MW5wTEpNTUJhSDRNVnZma01PTTNZeERNaDNpbm80WGpSME9mSXFJYURaWUpN?=
 =?utf-8?B?aWFqVC9oTkVKU2d1SWJPMERISGsvWVU5NC8vc2QrWU01STc2ZFYySXJlUkdF?=
 =?utf-8?B?NmRLRlFGdnpDMndPenpLTGJlaHl5Z0RvRFJWc2o1YnhqZy9TOHRnU1hQM0w3?=
 =?utf-8?B?eVkxSGVWb0dadlp5Z0ZXWWk2cHYrMlcrRGVXbTQ5eEN2MjJDcUU1d2l6aDZD?=
 =?utf-8?B?NDV5bHJ1clphYzRtWEloSHBCZTIyMDBaOGlCcmtMenEzWEcrdUs5Q1l1S3hL?=
 =?utf-8?B?ZUlMMTlZbDI3MCtLb1lqNGpTRFVXNWF0MEgyelZMN2J0Unl4YVA0ekIrZUpS?=
 =?utf-8?B?QWRtVUJuVm5IRUxxUy80RnRtR3BOQkROc2lyMkFYeW5zYTlsbzJIWjI0UG9Z?=
 =?utf-8?B?MDRNaEpmUEtvTm1xOG5XOE01Z1krVWh1dmVWYkszRGZmZGw1REtzbFJyaXQ0?=
 =?utf-8?B?ZUF4YXppaW5kRTJPaERjcGNPWUJiK28rWGtPNzNwNWJ2Y3g2bWo3RlNZcmky?=
 =?utf-8?B?UGVYTjZKczRvV2JKWEVRNmpuT2JjTE15S0VBWTNPd0ZrNlp4R0p6RW1DYXdE?=
 =?utf-8?B?T3JmaEpPMkl6MUVkbmxvbXk0ZEluZXlUdW41aHdPeXdyWklzZ0xWREQ3ZGVs?=
 =?utf-8?B?NlJ4Z0l4cEZkRk9nYmNpTnpXRlhsQTVMUExpazVuelFON2hjcmR3Tlo2Y1o4?=
 =?utf-8?B?bHpvNlR3V21oT0kyd2EzcktqdjVEdzFUV0lyY29KbFovaHBUTHJtOElrZm5j?=
 =?utf-8?B?TEdTc1pVWitOcWxhN1dyUjZMR21OWkNJbkpHcjZhMFJIQ3BBNlh0YmFjRHA5?=
 =?utf-8?B?TEhoaTY3NDU2STl2cEI3NnN0bWRmeUFnUERZY0pDdmtwWnFDa2ljQVppTFEy?=
 =?utf-8?B?akFIMTF2dytmVkJZOUIyWHc1bDB6MnJSaE1jSXprLzRNNDNpNHhLSzJtZ0du?=
 =?utf-8?B?eTk1ak5wN3YxSWcyZ3dEV0NvM0hjMDVuY2xjRDN2TXU3TDlhUGZjcmdybStQ?=
 =?utf-8?B?SUhzaHRUWlJpYTVzc2JxYW5ESVozSGVpdmk2WDNkY045Sys2WTJuc2lNYjNp?=
 =?utf-8?B?NWdGb0xsNWpZa1phekJnQmU3NnlxSlhFMXYwSVR0dU1jbkVHOXVsemxKellR?=
 =?utf-8?B?diszc2FjenlBOVVuMnpmSjJWUGMvRzlVcjluVDJ3NWNrS0FlZjZMTmFMbkND?=
 =?utf-8?B?cExtOGE0Mjl1U0RYVXFKbVlhbXp0RzlKMXcweXlaUlpNanpwUjJJd00yWWFM?=
 =?utf-8?B?eXlpWlhWVVVMa211SjQ0MjVKcFlRaEtqOUxEejJlZDVjdHpzU0NvNjAxQjFN?=
 =?utf-8?B?cnhZNmdleWdEZWlMTkZHTWVwWDNrWjV0MXBTNU1ROXRDYmEzeFVzMUtLTDV0?=
 =?utf-8?B?YWpEOVNMd3RJQkpWb3hPWDNDOVJ1M29QQTlHWldGWkltZjhXTXh4Sy9KSGt2?=
 =?utf-8?B?WC81bTRpbVZPT29RNFZjOFA1QnJCa0pCeGtZVmhrVk1Gd29pb2RSeVZ1U1BN?=
 =?utf-8?B?c1B2UlVJZVduRGgzaE5iZWdCMkJQYVlKRTR1VVhmejRJbWZEOGZibUU0UHd0?=
 =?utf-8?B?MERudmxFUnlxdmwzMkJQbkE5aFR1MHBuTUdKSGNUWFE0aE4wYVQwWGdnVXJS?=
 =?utf-8?B?ZzJqdmdNRjBtT3VrcnF4cGU5bHhuOUUySGtsc05Od2wwTjk1ZFV1K3ZGTGhi?=
 =?utf-8?B?V2NISWZVOHNyNVdyQ0ZSeGk1T1d0N25saWJsOXBEY2NMd2lUc2hEZkpmSGxy?=
 =?utf-8?B?VWRyb01yQXo1bHJGWmxXMVhoekk3RnRoYjFNaE5OTjkyWlllR1VmcFBhYW9X?=
 =?utf-8?B?NDRRdTNHRmZRPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;6:NwsvbGaafYHprEXn//BPAFLPPRAzZsqHeQ6KHrpXM1vLwgMbmaWIKMRxS1AssldjNluNgJGw+cPGnZxlS/EvkPsWHK9AcQHocGPqx6mIhg5gaIGUcT2cOqRd4QlqydiW90HcZyqgW3EN84B13IVorbjrxJjyGvelKO+9FJ+7iTazEaj2RDl66P/O5h9WMf1bvcFHf3crkKcIrfzJYDG6tZK0AV1VYyVDA8MLihBcG92Mc0tFIOzUZwiAKLf9brefroQdJmNnPiz4ltAQF6Fl/0hgYcIMPd0fy8PI9nfxHjhnl5uRJKGIeOHwJHn0Uaj9UNluAlcTCWcCiDF7CTJlDxoB/roUWU3Yqzyqrao/1OI=;5:B+ZH+UI2X3lq5P7Af1fFoHSspznCa6oSLa+MWPbNwK1a261HKXz53FJ2TU2IU32/z9DmA+8Q1W12eRpAh8QeXwhRE/q33ZYvkd0sfubgBOb+q9dSbOQu4g2emoI+7PWOCvdLDRgssieYI508Lpdd4YpYG1rAsRQsn2P+tYbJJ1A=;24:/qKS2hNWqxiiAvuOsnneSV0l/dIThevJlxR+y96SowtQ4h1igTnohY4fwq7iFUlmvAOSMI2dnm7Qszga5oHh7TNhrSbyr2ufLkeSO/aUrEY=;7:LGKIJr3z5kpU5mmjGV5Vx5AmG4UGdRiLhkqKRtYzp+1TuBaoXx9CFcmxhMJJj71tjGS3p+iJImA/IW235cR5sTKHz0H3Aksyl5yogyRNnqXizthTRIdE2vB1oDlzgSx0F74TX1EY6LZPJgixvGl+BLsL1Cu9I+P1STYZu4MJoQdxMOgZjj1bzYZF5vdQHKMKxgSKlbzU41vdg6kSPcZOKHachLqBhDUHuWdmT5uP5v+s+7YcnDm2oATJY1hOm26N
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;20:flo2gUFK7NtYFo5OlWeeA0vTPTHdU9a4qNcv7qzF08HxCHuv/NAOIcxG0seSVYa1VuBALz2ylE9nD65m5QY8d300z6D57bNDZOc6F97+3zHmstDYGjl/yg+Kp1LaSHU8qZo++aLpUOT6KGzcxlHkSgy0w8tgpP/QpA49+n6Oksk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 12:11:19.0546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4033d822-628d-4751-55d4-08d58036b53d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3256
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2018 08:15 PM, Andrey Konovalov wrote:
> A compiler can optimize away memset calls by replacing them with mov
> instructions. There are KASAN tests, that specifically test that KASAN
> correctly handles memset calls, we don't want this optimization to
> happen.
> 
> The solution is to add -fno-builtin flag to test_kasan.ko
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
