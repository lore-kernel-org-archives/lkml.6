Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AIpwx49dZs8DHsi0qcQq05UIUfpxcOQeh1XTva2MChf82wswEkQCPpxs8Hy+i7gt7mIk0r4yTuJs
ARC-Seal: i=1; a=rsa-sha256; t=1523633457; cv=none;
        d=google.com; s=arc-20160816;
        b=abqKH3RV4GuULjjmaAESWyFIlmRZzFH4IAP190VlgDCo1U9Y0rPFPpb/zctwQqRlIE
         dZcPBwOZX9RHJMcIH1kVTC8sEjWLk7JwbCAbAFyAQ3eYRiIUA/6buhW1qut1rYYM+Nkx
         tO3fYjDKR/OhHUrIx49+xuTn1hlG4JkDyOWTV83oeKaNdkA6/kDupaVF+aQ1idonRxU7
         9hzJpqUfPwoDVnr7dW0+Gpi3HPwe04+laH80jCkMMqvDiiuui2r6SB4Hn2XNmcoFBA+6
         vfo9OP5BIQCHObCocBg2kNz7XjYacqxBkjY0Y8eJy/N+dPLBqwIatgizWr37O4AUHSic
         Gwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=wgnMkHQ2eePxI+y1l9Qxw5vnADzRguZIrbreUvjZzuM=;
        b=rGupP0Mu88K2jgtG/oieXbMT73JFrP86MIjLYm9bIspgZBR2B4kfZOpZXOQvIAnVLp
         pU5yBZSuZFTJu0NSLTj8pLi9UymZxG6bskHipRf5JBs3FScp/oOYTRcTeh2FkNhkIyKK
         UAtG2Z/MHQ8NU/6pOH2PKdQAJIQpYFB7Knve0144WJC9wRHoUopd382MSvJ6QYjcgMET
         REa9SyPP3EZ6yfNfQF30QO057UXcEAPNRFqPVRoGGxcPRcN+jQlpjYILc8hN1k2sw3D2
         XJPTU6CGQazXCH1I0PNJyjcIYcBDKV46Dp8MFLRpEC51WZpQhsnP67L3mtEimchzKYHE
         R78Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=LAsuYjSX;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.0.130 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=LAsuYjSX;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.0.130 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] kasan: add no_sanitize attribute for clang builds
To: Andrey Konovalov <andreyknvl@google.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Rientjes <rientjes@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
 Will Deacon <will.deacon@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Lawrence <paullawrence@google.com>,
 Sandipan Das <sandipan@linux.vnet.ibm.com>, Kees Cook
 <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc: Kostya Serebryany <kcc@google.com>
References: <4ad725cc903f8534f8c8a60f0daade5e3d674f8d.1523554166.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <b849e2ff-3693-9546-5850-1ddcea23ee29@virtuozzo.com>
Date: Fri, 13 Apr 2018 18:31:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4ad725cc903f8534f8c8a60f0daade5e3d674f8d.1523554166.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0039.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::25) To DB7PR08MB3259.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3259;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;3:sMpSS1Zi8LEqOHM0RYmkbaU7k553q4t2uKHUp+lufAGsPrC28A4RafR/i1KPRiDwsz4RFHVkVi6biDSbdC5DU0fUzCMO8E3eadQ2ECC8gZOPVxaDYt4Gv0a5irfsBCedsBfT6tyEx/wm2js/WyqdTeF7CPPNhjcBA9O7FhJVAyZbOaRgGzqnIgzDBt4fIy7WLxVYghnwP+atLfUAuU5K+GstsoRYBg2PX0g4D+lHjIcZ7xCvu8Z3368MJ7O/5yDb;25:u3rvueZUxTWUW7dSYFHKh36k1/JFcDK92AjErMibkmr1ndzqe8ZNFUnNke061xUcfT6h9G6YdreK/7sSjhPxTiTtuvuok9rbOypTp3Oj9Dj+8c6CecF2JnV/Ty/j/R6atE1ovHg37gnOD2cvNMRu1e8buByuEx4dRsZ2Y+I6NlQj5c+vZgGHMhpWEwYMjfaRqSxLvTsfA27KAh6cz2y7UQNvsmj+/i8MCvEYik37Mh14Sdg+aczI1kSxsRRRg9gshXPDjJlPIX397jaW9dLeZApCUeJEOJt8bR4sXsdyYx2dWvF5J1lA3rikmXr/QL2BsWLuKpckYCtLShE8kJj+mQ==;31:QQaaw9oMzFsrjGQ/OsGt8RKx4TsXadvFRBLNBWTv3iIQtFCwXFfk02mBBmAUESFTu0TRZjUPTxuFB8w8J+sAKTu5ehJkR07XLmGuAl8bJiuaTFjU6BKsf5NbIWy4A8heE5ZlulZakiLpQWE1HQNzkQ+AXy3e7/xl812tlFQc86TWKjQr4AEp3qqfYUCz/X2t7/Psm3dSqiocXlbEdEO8EEpw5YCC9lY7rcSBdinAjx8=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3259:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;20:wdp7vBD3XqjiFxbJZGf0FhvIm0lctRelV7SBgaqRL/pTzrhPGerOftyf88xz2buJC60p1zRE0ur1awqF1PZ4LT0Dkys4KzSgXmA6E2BwFrtqgSeBxdhFer8H+GdxQW44E7YKMZuDeHwjMpQvXDh+pbNbzbgjZA0ps0fSmZrXyOeKIDXwemuRlHTVZ8IhB8bq//zyH5wNFgGWWPpsxb6VZaYUGJGyRao2sF0js6Rrn/dx2LShVYIp9fjMxsLHeOBk0+2EfKQIlGrj++2QfjkR7kz10hizw9VwF11gMNeXJac0Ieou9JzTD1wzjERDDgaionUvPBiEWHoNXE7ggu4VCaVw5EDya+/tUux/cBCl3u3/SXjgw4fCYutk9hITQhAYuZmHlfPk0v1lyCknKNhFy7/tY0G5mVTVkK9eJ+2iNVwfNobFecfDXcNtSL788A/945OLRssBPC3VhvwudUZneex3Z0a6oW7EbqF/UffFxz4uvdu9sCd+jFafrZRCvAwT;4:anmDYsCWABqk2rSPnIPJv9DLcYm1GlxGkY2HMkYODcRiV3y96rbO+iZprega6ylnpkn9TXrlnnghwV1WWI5Bw5Qa89PCCypNZnWVQJXyrTmPfKLSiRyikJpXrgWIPcY9tDsdCh+iZJZ2a46TWo4LIuK4QvtFnDjR4sQW4j3UCYFZuudpWDuhs9KAWGi3MQZunp6QssKOGjoTA+3ep+vO7WfjIaPzJJddnkBeYexzJK23kiWbuQnI5l4oVzMvBP2bkuVDBKinfy8wdqbAWOAEZ86ZktRI39M93aH9SK5r1AHuihfoHH2h+7kYuM2koDRma0/544UK7rw+tqWmaBDOVvem5iRHM45XFEoHI++Nwlc=
X-Microsoft-Antispam-PRVS: <DB7PR08MB32594471AA8D9D45CBDF63EBB0B30@DB7PR08MB3259.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(3002001)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3259;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3259;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(39380400002)(366004)(346002)(396003)(376002)(189003)(199004)(6246003)(81166006)(53936002)(65826007)(6666003)(76176011)(31686004)(956004)(50466002)(8676002)(5660300001)(8936002)(2486003)(68736007)(52116002)(53546011)(52146003)(81156014)(386003)(25786009)(230700001)(7416002)(97736004)(7736002)(11346002)(446003)(64126003)(106356001)(476003)(305945005)(3846002)(478600001)(229853002)(65956001)(110136005)(66066001)(486006)(4326008)(86362001)(77096007)(6116002)(55236004)(2906002)(186003)(23676004)(47776003)(316002)(31696002)(6486002)(2616005)(58126008)(16576012)(105586002)(16526019)(65806001)(36756003)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3259;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU5OzIzOmJOUnBGNjJiOEVUS2FMNEUwVmFBQUVjRkgx?=
 =?utf-8?B?S2lqNHMrSXJlZFA2eVl6QVVBejBzMjY3UzNNc1dNQXlHR0p1NXZXTDJqQ1Bp?=
 =?utf-8?B?YlpNVUYzdzBwYWdBY0ZXeG5tYjBiUFN5ZHNTK0dSVHNaQWh0WHRUamg0SFUw?=
 =?utf-8?B?cGdnT2kwRThMZzg0RXZOeVdXZklWSk1EZEtaOHlmcHpKZHErNncyenpPMXlQ?=
 =?utf-8?B?WWpHOHFhalFGcCtDeENIWDdSdHd0S0FxZ1BCbGd0MkNaMHBuYzNxSGRESGFo?=
 =?utf-8?B?dFUyNXZsSFVadi9WYVlBWGpRc1BDc0NhZVB5QTgxWG9rOTFacUlPNytINXV3?=
 =?utf-8?B?MTVoampORWYxMTBvby9tS0IyZTIrM2RZR3FmT056QU1NS1pScHc5L2dOZEVh?=
 =?utf-8?B?a2VlU1YrZk9PSXhLZndwQXRBaWJhOHAzelBNY3phU3NQazRLZzhsdU5sUHZK?=
 =?utf-8?B?bitZY1hqN2ZvVVRuUVEyUFhCNWx3aVZpZFl5TVV2M2ZpUjNoUkh2bmRMb3J3?=
 =?utf-8?B?ZkJ6VkR4d3ZZMXJ6SlpWNXhuaTFyZGpBazhtSUdGS0tQN1R5Z2dRTXczRnNa?=
 =?utf-8?B?YndvRjRQNzVKVkxmcHR5N0NaRExpaWxwZDcyWUpVV1JRU281VVJLMkpNTlBm?=
 =?utf-8?B?b1VZY3dRUkRsYU9TdGE3SE1yRjVCdDdGVW81SUZhOGlOZk4raFBBWGpsTHFt?=
 =?utf-8?B?K1FIU2xRbWlWQTB3cHRlUE5uUzQxYThlVFZLeno1T2NTZVo0cnl2QzFkMytI?=
 =?utf-8?B?akprM3FZNXNXcFR1UUFRcURjbllqNnV3SExUKzI3L1dRMzh0UG5NVFZ0ejBR?=
 =?utf-8?B?dUhKdzQ0RFNzRzN0MTlFVXZZS1JzTDA1aFNnb0JYNFFsVWY5ZHJUTHFqbTBU?=
 =?utf-8?B?ZjQ3NXhwUDBMdDhxSkJQZkY3ZVh4TFFOQkFtamFpRzZ3UlB1ck5DbVF1SHhT?=
 =?utf-8?B?dExIMjZ6aEJqRll0OTloY1FVS2ZyL1NudUJRZTlTTEhDY0tldy9OZGozNTcv?=
 =?utf-8?B?VXFWNVZNN0czNWxSNTdqZ3ZMTDF5K044c0JjU2xTcHNxb1NOV1ErVXFjMVBk?=
 =?utf-8?B?eEZ4RkxVUXo1NStTaTFJazdjMW9RTE1JSFp2NXk2YSs4TUZzYUZSMVd1OUpp?=
 =?utf-8?B?QlFJdExQR0lvdnZFK2NsVlV2TVRaN3ozRis1MUFrYlhGN0FKTkNpdFhIWjZF?=
 =?utf-8?B?Q2lCQTV1SHQ2bFlsZFhaNHhiaU1HN0U3UisxUG9BYTFqaEdXMnB5MVdwblBX?=
 =?utf-8?B?TlBSTitvMXFtdkR0YWxtcFdaUGdsc2V1NDdYNWpCemNhenJZTkxhZklJUHJQ?=
 =?utf-8?B?ei95V2o0cnhhZVRoaFVpRXZDRWdKZ0ZwOHprN3cwK21oUVhQMW5nN01kVVA3?=
 =?utf-8?B?QzFJOGNSejNOWTBvNHlXdFdEQzFyT0g2NWpwWXNKWE9ndU9WMEQ3QlIvVjhv?=
 =?utf-8?B?RCtMNVFaTUVCdmJUQWNFNWxqM3YxeVJ5bGtPVEMrRnZ6eXhwdVpzSWFjdWxR?=
 =?utf-8?B?UU9KOEpsRmhEckRPR1JucmNGUk9hTUxoVkg3NHlpQXFuWHdsaTE0cjVZY0d5?=
 =?utf-8?B?dkt5eFA0RjRZVFo1NjF4YlVIMDkwbEJlVVBTckJkV3dBalFnNFJubnNCM3Q3?=
 =?utf-8?B?VTluRnVybHJ6R0FvZDdBc3dZMk5rUDhrTWhtMkpYRlpRMW0veXRhaHBxLyta?=
 =?utf-8?B?OTVvMENKUXZlQkNrZmtiNTdHRkhsR3dGb3FaT3JDSEVJT2tFbnp1OHFZcC8r?=
 =?utf-8?B?K3lsdXFHVFVzTjUxbVJiWGlDR1hnYmVaMmNoKzBGWWNIWGIwaXp4ZHRDTGM4?=
 =?utf-8?B?RnI3c0pVUEJQNnRNL3kyMGdMUFB4WlYrOGpkV01DMEVnNno1Y3NYVnNoU2Rm?=
 =?utf-8?B?Vy9TR2pCQXZSRkVGa3cySjZneTNBd2VYNUVib1FoVnd0Y3RveG5Qd0tDQzRG?=
 =?utf-8?B?ZURGb3hYWnQvSHl2eXl2NHIvT0xoYVgwMndkL3Ixc0RlREdsSzVpYSszQTF0?=
 =?utf-8?B?N1phcFJFRVF4N1k1WSthUWJwOFVYN3BYUlArdz09?=
X-Microsoft-Antispam-Message-Info: YXSsccD1qyFfiivxgHd/IANRett0OuGcv6GodEKAXcjgN/RtmEqRS86cuI7X1F+zNSICaP2S5mdjI7VThcNzjY8E1ek81ruLboj98gdT3a1/LRdCEQSNWnyTVXgpkE3W5LMy589S+JybHucu0CDaN9evMQTZf7IuPeeC6muEFu6mO+BieSCxG6FirWBcXIha
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;6:xYA62/K9sTxr5k4hT1n1M78bZX8Jm8xlwrPie0UqeRDgu3LtXH//3brTa9ZzUDOhH7EO1qMEahYlRfeBFJbSYIDRJX6l/1esmlw6CEAm7kkrSEkbnUdnK4kR80XmjhxGk7JB7nCyzNiheV34OQT2nw2oMNYUIV2BgsXXB/9iKiiFcGtq9YIcVFDp8vrMNt02f1PkLLOTVxeTrqi3+kRdq4lideVo4+kCv4ax1draLNF8uvbgOBC2NXUIC+hALV8saniAqCpWqSCQmprGt+QJ54Omwwrmcf8K16D/E/yoVZv+zzgqJ1uh97tfwX8Z6FOyzOt+fay1klnOqRgbFEX4D3dOhEFfbSSoyVwDMkno5My24W+7BYutZg+3fH0A4Ffopbk1SP2qyugcL5uAecZ34N2m0VAniyzPpTRyRShTekOPQIXObssZmaa9fWCnjCFdb+6yL+qItI2VUqpJDzQagg==;5:5vWHbmultwXD7qDR5qAmiN8o10Unqe5iE1rbWUILkeQBkIEichWie2KozpW2LvQ5vzA9YgF76VAZMvPuV0gwFIrVHzISmudGt6nGYvDZfHaM7teTemIhyNcuB4Izmm7MzZjQvUC/k600Q0rIl54cLUz+uhZIOtcGs6JbOpsc/Uo=;24:4FrMjOYyYx2f5RkHCspA5jQzM0A2R1+Pcg2NF0tzSEiIvqAoS6QFjJoKoJft+t5nWvKI4jNNc3UEd5no7yHY4c+gHMK5YUrqag4ynS/uPKE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;7:JDkllTQ2CxwQsJLmTnVZfFQQPdz4fa8YLxyi8wYqSCTb0BdAhW+H91YtYYb4L403PMF7VzEl7AkIBvLUq6P0CROHPIHHxwQYDU5xR/j6ceJBfbkx/GLmJ3/opOnn3q4ejrcAdaBxTzZOKwHuyVZoWMDabjdjQpEFOhP9vMpzSZEbBSyvfXan4F/cYarpsjVB3T11QUFdl+57d8ZXfTtADQvya2524GaMEZWoWH4bKLsPnUp2/xFOVl/preQhjH4e;20:u+J3QFGQBn1nufy3sz6brjtkt5zfK+4RBUGXeEpOOu954OIN8jw+FjBMAtaHl9w5hdDxGn4l+/a47bhDy+OnpO459/PZBP3f9LPPLxM6EMl3KcLuvtjOOZuyhmIBfKVIr9WqmDABm8z1vFJLEqp3SqOGCC1jlTVivZbH+Za0tEo=
X-MS-Office365-Filtering-Correlation-Id: b0b48eda-3bad-4ba0-ad44-08d5a1538b0d
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 15:30:51.4611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b48eda-3bad-4ba0-ad44-08d5a1538b0d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3259
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597562343326181438?=
X-GMAIL-MSGID: =?utf-8?q?1597645476279634643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/12/2018 08:29 PM, Andrey Konovalov wrote:
> KASAN uses the __no_sanitize_address macro to disable instrumentation
> of particular functions. Right now it's defined only for GCC build,
> which causes false positives when clang is used.
> 
> This patch adds a definition for clang.
> 
> Note, that clang's revision 329612 or higher is required.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/compiler-clang.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index ceb96ecab96e..5a1d8580febe 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -25,6 +25,11 @@
>  #define __SANITIZE_ADDRESS__
>  #endif
>  
> +#ifdef CONFIG_KASAN

If, for whatever reason, developer decides to add __no_sanitize_address to some
generic function, guess what will happen next when he/she will try to build CONFIG_KASAN=n kernel?

> +#undef __no_sanitize_address
> +#define __no_sanitize_address __attribute__((no_sanitize("address")))
> +#endif
> +
>  /* Clang doesn't have a way to turn it off per-function, yet. */
>  #ifdef __noretpoline
>  #undef __noretpoline
> 
