Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/TR0bqq5F7spAF+aUtUU8RDtTmbqYfcdKGE/WZKJqbHtp51CpTRPULUoX4vNK+2XDKkrPn
ARC-Seal: i=1; a=rsa-sha256; t=1523646941; cv=none;
        d=google.com; s=arc-20160816;
        b=CqQO9HrOLHp7/5FENSNzlqJSOnSpQSfpeVkmYOzUX9Ph8lwEBVFm52KM2+QnHxOQgp
         Rr61NySyCJtJBcq9ZwF1ks9PzqYRBs6D3fpTyqySF8oBio/oTOtmcXPh+xbw23tI/4hZ
         U6H7Zo8YcAUz8s8NwramRNVMjmO6TuNVQQYfN6ah4azCkecUXW/YGvZnHSxdPsxGudpd
         NN17wlD2M2fMsGF2ytQKSG4+hVmbovpZYd9o7v/dfiAyy+4L/o0i+jskb/jwC6/0louF
         eqIDYu+t3KVWIhU4PlvTsT56M7U+6KUhqaxTvyu5sxq2ZjTZ2uB7lClOXY8jlzy6PnMa
         //Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=J2gqNgQredrYQfjyq/M9pgHOYHlAG8YsbEs4K30O0bU=;
        b=YdcYM5yVp7BHKLfR9ly4E+j8kqDaBeWJNymS6/Ewp6ECLLuzMizdJOYvj2ua3jlVZb
         rJx/9gXndqszdEQp9c0eD4ha19gbSJpvV8Am5WiPsJp2L2EODZHXNRacHxOocb+AdrZT
         aVUVbMzNCiUWMhwmqpl7sHxWI9NdwH6J+qqY55bughWoYiCXbckOE661B/2evC/bU1B2
         FqbEa8im4z3hUWOiXqNBilDv+IpWAE2KrRe1FMoM36Mu7nPB6VYgL8C0A0e3Sd3HhX3B
         76yOdnOP386/V6EW4IXOKgR4R9EOP4cSA4mdX4BjHjHQn0b8o7yyodCoH6J/G29EzOgx
         urkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=EYSbGGTU;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.0.114 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=EYSbGGTU;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.0.114 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] kasan: add no_sanitize attribute for clang builds
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Will Deacon <will.deacon@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Lawrence <paullawrence@google.com>,
 Sandipan Das <sandipan@linux.vnet.ibm.com>, Kees Cook
 <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 kasan-dev <kasan-dev@googlegroups.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Kostya Serebryany <kcc@google.com>
References: <4ad725cc903f8534f8c8a60f0daade5e3d674f8d.1523554166.git.andreyknvl@google.com>
 <b849e2ff-3693-9546-5850-1ddcea23ee29@virtuozzo.com>
 <CAAeHK+y18zU_PAS5KB82PNqtvGNex+S0Jk3bWaE19=YjThaNow@mail.gmail.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <c95bd92f-bef4-378a-55ed-04439c784e43@virtuozzo.com>
Date: Fri, 13 Apr 2018 22:16:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+y18zU_PAS5KB82PNqtvGNex+S0Jk3bWaE19=YjThaNow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0017.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::27) To AM0PR08MB3251.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3251;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;3:CWNTRZeAptXahTWoj2oA/Iawoa43gRlPP1fb4cC/1t1ZFD8OrLukuRE4CP/4YWK2Bgk1a5YebgpsgZX4NpN6GxY/0VT7wngDdcxasInrIx8iobfr4736394a15+atZYfu0RcmrBeMq/ctONzDI72EsLyrmzxkEuBrejyDvbIKUAmEaieE1EZ0CNeaz7b6OgS0YKpDGdBVOqO3Bh7iP+SQ+aL5PXItO/h+RR0VB8guSETZT43g1lWTKwBlOU6evJJ;25:BrxgSr246wv4zWR7XWXXBuh9h9hrpxrYATKFSea4ShxTuiJnkhTF4xeaCnhXrCUJ5q8cgrx+GsqkQ8wVECvQyywbNavLQN6JhdjMGja21WOXE6yqLXcoRa8boZSmdSscFnqD8uaFOEswrCzR0tLoT4AHPWy1m0Tg3Ds2R2efNQHyilVWrMLd3Oh5lhq48z7gaetBf5Gj9UpO+J3j7Y5363wER1c6besNdXOROyKOULG1F6UHRJbLjdJlohFt23YlG3AakUDtpIGU7b6/QgZmG0orNGM/P4C0dBPKyTv3dh2PmiVCZuQZgkaCXmktnyAV+Ohs7kSaGW4G2VrQxUAQlw==;31:7coAv9w+uAl/5Us21F6PuGHJ40igQNcC491FzakJ6tEmUG33vSGiAPBXvvnpQp8k0lAoFmsSO3h9twqGtRSGMxgsO8TRMoEiyx58pjhY52PJ/kl77VMJ+9NAjItXcBih0UOpJtiJn32wQO81C9Pamfq058qXGStd43CYg8o7KFFaVg7uzSlzNqbC1lSCa6Nn4+87qDpOxbgmZx/pnUQB8Tcs/ezxKFzBHUP1QWj+jHc=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3251:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;20:1EI5QMvscf7uYRT5zRAAeE00UWJ8z5qnYGh4qVAcZDK+oCIMzR9KpecOlsRl5Dn0U9D6dVKLRzQ898ZqN5jAAmvtQcNylZLG/21/gOMi10SmaBKFBK0XQXdw+6RU2C0xp8l0A/tP5fFcr1QJbfBC8rebEIqaZJyEjIXqVBhZvW2qVAf8w/n/LdChYYCNJGkWYeZ3aRFu14cRqdFC2M7d7/8v+FxIomdx6KmBuQP0cDaJo47w6uMzXzYVP0MWdA7IJsk1CPrZqVd7C1jmmJ7PUNu7cRRMzSF4QHyKaSVqb1geriA/kK0bT79nLbP7gdQNRTzxKYe3kVIn0C0A4iWGFXv5zE6UspCc9YcnrX++R7MxWrv8Eg1HuY6WEZrQh9k30wowYpx4Ru3Tm2wYASsg7bjS/oTOQxA+KUw8zJNUvnHKWBsobq1fwd387mPeRAqaCSfcGdGdxUauIChd6wR611LOuyz/9hQXKJaYwHknYF0T6wPijVXo11vGggodykPB;4:YVgJ6NyqUsabk4Z/QJt9sIm0mwJOr1WIh6EU3M7Nv/uothTtMnk+ktl42pdBqQEErYFjsQi3sYU5jfA3XKqjD1aZQzmpoSXV1+euWehstCLenrcsk/iYoDulZc2fiZYPTfEiroJ1bQca6vMkIvoQZKR3vRSX0W3lk2Xqz6+Jvd7bORrAASwdnAGtVVfRupmKvACVY4+iKuol8Rgw/G3iaC1DJH9B7rL+Dp0PYLght5oVX1GqX+AytkstHhkfY2fwYXdSTipITgQx8YHuwUIEm91ukm9hTjrUFMOtlvdnCR3qpAIdKoSLsz52V+UCyUkXslvaKoouqLAOhzYoARDFTiDbXiz4iDY6mEhdDdCcRcw=
X-Microsoft-Antispam-PRVS: <AM0PR08MB3251D7312CFFABD7666EAAC6B0B30@AM0PR08MB3251.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:AM0PR08MB3251;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3251;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(376002)(396003)(39380400002)(346002)(366004)(189003)(199004)(64126003)(316002)(2906002)(386003)(86362001)(31696002)(54906003)(8676002)(65956001)(65826007)(77096007)(26005)(68736007)(66066001)(55236004)(25786009)(16526019)(53546011)(186003)(31686004)(81156014)(16576012)(8936002)(478600001)(47776003)(36756003)(81166006)(58126008)(97736004)(6486002)(5660300001)(52146003)(446003)(2486003)(2616005)(23676004)(956004)(11346002)(76176011)(105586002)(50466002)(4326008)(476003)(65806001)(52116002)(53936002)(486006)(6116002)(6916009)(6666003)(6246003)(3846002)(106356001)(229853002)(305945005)(7736002)(7416002)(230700001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3251;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUxOzIzOisvR01aYjBrS05PNmc5MXJkbXZINmlyK1dH?=
 =?utf-8?B?cnV4WUwya1gycUgrZkwybXBheTBuaUdQT3dzT244VEgrUVlyNHNCVnI3ekds?=
 =?utf-8?B?cmx1SmRMNWw5TmMveFlRK0hVZG5LUGF6bW92Ym0yQmE1NW1Ba1Nld2pST0VO?=
 =?utf-8?B?dnNjZnJ4WTNqaUhVclRhVUw3SW1mOC9ScVMrT0xlcDVNOVJPOFhTd2g1b09n?=
 =?utf-8?B?YTVqY0V0bWtWMEo2blVFT2tnM0R5QXBlUmVCZHdhMFBiZUVZd3kxUU9lenhN?=
 =?utf-8?B?dHVTQkpEeTFPeVdqQVd2RUZRZW03Q0VoNFNhMnl4V0xKNkV2VEdjTy96WlFm?=
 =?utf-8?B?eHJUbVFjdCtZZlQ2TXVVc0lwMUNIMytMZmZQRlZqSit5dUFNOWN4ZGM2SGZm?=
 =?utf-8?B?NGJQVnc1VVJ4dnljWHVpZnZYNjBmazNJN1dDenZIeCtsSU9uYmNUK09seUY0?=
 =?utf-8?B?OUhhV0dERHgvQ2YzOThYWkRYL1RjNzVWMFZJbmNwTEVkMnVlbmltdkY1UHkw?=
 =?utf-8?B?NHM0VmkwbnR4bTZRL0pFdFJZc0tpM2Y5Nm1EdEMydTh6emRaOVV1TG1zUmx3?=
 =?utf-8?B?VU5SZkxUODVLYjhLOTJ3T3F5ZW5qSEFSNzYxQkMrVzZ1SE9HMGphcnJuaVVC?=
 =?utf-8?B?cFE1UW1sbTJuL1BTdkxPNUdQcVBNUlRueVVKaHk2QVo3UGFSZDNsZGE4L0pw?=
 =?utf-8?B?Slgxc0RnOXlld0xDc2FoN0x3V1ZGM0hvQWpqaHdDS24zMm05OTlCTFZZcS9M?=
 =?utf-8?B?a3I1MzJPTmhUcmFQaTBZcVFHOEVzeFJWSkg1WG9yd0MwL0lOVk5FZWs4YlJK?=
 =?utf-8?B?OXlhR3BMUnByeDRwRkdmLzhqYmttdW9jZGpOYThVNGk5bEFQUWNUMkZ5dmJE?=
 =?utf-8?B?RUdIcTJKNFp5S083elk3SW1wdmVYc1F3ZnpLRWY1OEVQY3IxR1phR0ZVVlRN?=
 =?utf-8?B?amZPQXFNa292MTM1bnFYb3lWNmVzL0lYZkhkeEpYS3hhMGpzUUtJSW53VTQ1?=
 =?utf-8?B?M2F6cVAyVVZiNVExUkJOL2RsdG05NSszd1lFWkVpbTdremRJdUFLTXVFQnpk?=
 =?utf-8?B?TmoxL2ZFSFB6Znc2bmtMRUZZbTFNYmtwaHpRem0xSzBZMGpqR1VvbkxmWW9w?=
 =?utf-8?B?ano1R2FoWFVwRVRYMTRPWXYyQjd0Mzl2N1FIUFpuRytQN3hER3hTM2ZTU0sy?=
 =?utf-8?B?S3ltR2NPTmVzUHJxU3pHdXl6ek0ybEhTam5icFRvd1BjaGpnQVFKY2lUZW1q?=
 =?utf-8?B?MFdZWmZkajhYckZxdERYVG5KM3JFVUVLc3BUTVV5TTRYOEFMTkZzR1Y3ODZa?=
 =?utf-8?B?NEVNN2x2KzFZOElFaGpNM3I1YkZySTg2dExPdFpURmdBRFduK3VyenQ4TVhv?=
 =?utf-8?B?T1dYTnZUcFZPUUk5QWxLclRBOEhJdDhOMXc5Yi85MWg5dytaaHpzOUQvSnJL?=
 =?utf-8?B?MWEyLzc2ajFrT1NUbkZ1MTB0aitIa1hoV01EcHlrV3R6ZGx6QTlwSU0xQlg4?=
 =?utf-8?B?MVN3Qi95Z1NJWDZ4TC9McU5hMjdTK3dQQldWOHFIaHJ6dFppN3pYS1JETldi?=
 =?utf-8?B?VTdQbHdwOXVZTGdnaHFaSHRRUWgwaGpXR3J1TVU0QjJCRGdBS0c0a2h2MWNQ?=
 =?utf-8?B?ZmJYREpDR3Ewb09nc2hNTi80RURYbVlYbkxGbG50Z1IyMnA4cDdkamhxdm5s?=
 =?utf-8?B?ZzFmNDNzdE5sYTNZMXlka2w5ZG9MZE1tY09MZmxUTUttcHBTbzVON2ZQc1Zm?=
 =?utf-8?B?M3M4OFBzUmQwd2dXcDZ3aHZ2MllmZUM0UUgzOUtZM1B3anhaQVZRb1lVa2NR?=
 =?utf-8?B?UUc1TDBYcnkzWGM0MTUxTnU2QkxRdkgvMUlYdGF4MXhUMHhkM3JocTNFeXAz?=
 =?utf-8?B?cE82eVd6NGRnaFRNRjYwQnRLZXJIeWJJNE9seCswZUJQTHM2MEYyTStxaVVS?=
 =?utf-8?B?OWJkRUVuRDRjMmZYT2pBbVlUbTV4UjBQcmxOME9zUnBmTk1IYXJiMkwxSlp0?=
 =?utf-8?Q?kkYJvM?=
X-Microsoft-Antispam-Message-Info: 55KPO1OJmw2Kz9NbkxiHnPkdD617ISxpRXlmTLSCoQYhMExtTV83YnVv81LceajlcXGP28dnll2eUfaetRoR/GjFOo+ZwdrNrzTNoLrUGNmHo93hAS7wx2YYUaTFaGcNSbhuBpQvDfR2EKsnCvJLev2ZKUijaq0RuQewlQ0JdseHEsIhlO0M/V0LS3pfMRMS
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;6:nFvdoTB98ZnZ5rwHle366IecRT/7CIiFboSgF/zNLF/HOX2uPP4nqEhzRwB1enK90MmicH5qyJF2aIDroNvw9DieLKxr0Ys1Jrs4sdYQ2qpBMvWUlNwK10eBy2IAEISEykQmpL46m8L0vRd/V5Ld2bcXrJ0HEvsn7LYeHxF66STEM9CEO7BEfFWCQXdCztomJzXtM6ZVqQGWGaI0bx0G27CO016yhPSiFtNfmTp43avCpRAQFLT8jNIfzIXmQUDL7YOeioZzME2UHIGN92ZrYkJv817THikkHTUls/+a7sKP9Jb4wtlGff4Ee8Umtv1IQKPVIyyqwRhMjA3tCNK5nj8y6HUh1WVUEIgsLDPyyvspbUD5RhkGmvA50HApoakO2xsllD7hd1dUc+oUh3Wle0GPUlD722yIQOcqCHN+pld45yPcOaOZ8T6ET0Iv6BCgLhL+fkvOHY6nikDSQFRxeA==;5:dblFwGNgmvwSUhdw8FjiAotWxPb98CxSsLIVYYgCBehnbIyVcNxdBjavAmCRO8zRNMHQ97jy0c/jgmC3kKByljKbo5TeU/M8t1Hu0A/yBsmeZrfDTWuv80qQoMFyW9lke43y2erecqM1PUeUWcLKzj1QViPygtVSOjvQOqt20+8=;24:vXbKB+xGemsBUNjIwNKpCQR7tTn5YqcZ7isAZUqbXUudDBx0D1x+SOm1lhDkikoN7wwDnhAPXWtTEvxTlarlfUVbOltnvz3ycg3ZIcggAHM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;7:f8jefi7KSHpoTJuUPQxMdCtgkCdH1cVP75olKbg/jaKz2LQnGTj3aMDJA8JGQxC72xze7UFKI2dHq2u/AGRA8UgnZFbD0KoH45uvMUcegZzy8eKh2XB391psaGff+YCipw3rxrOK7rw1Scn8uDIC/OyMEIOEGMRaXuymeAlnJIpIdcOP0HgZ0kQEsWczDMm2dgmNa4a7/zLgZVMoSoQRgRs5CVlPvM4IJ7mUDu8ClC2o1srujHIb2XXsjqi2/AME;20:hAx2LG/lWxglp1bR4rL8y110/Tuq4+JfbzzSJIHCv3QdHYjmv3dj+4FbAXoIDfadBVSsy1JI0wmM5NJjFbF9cHFzhKhjSOMsmPCwmoY1GJiFx+Av53OrDjm741ecunJ9wZzYxysFvSSy6wePQRKLTLuUjADHAqzEIudsWLBckFo=
X-MS-Office365-Filtering-Correlation-Id: 5cc5af43-5859-4392-ebbd-08d5a172efe3
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 19:15:35.4578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc5af43-5859-4392-ebbd-08d5a172efe3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3251
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597562343326181438?=
X-GMAIL-MSGID: =?utf-8?q?1597659615216346785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/13/2018 08:34 PM, Andrey Konovalov wrote:
> On Fri, Apr 13, 2018 at 5:31 PM, Andrey Ryabinin
> <aryabinin@virtuozzo.com> wrote:
>>
>>
>> On 04/12/2018 08:29 PM, Andrey Konovalov wrote:
>>> KASAN uses the __no_sanitize_address macro to disable instrumentation
>>> of particular functions. Right now it's defined only for GCC build,
>>> which causes false positives when clang is used.
>>>
>>> This patch adds a definition for clang.
>>>
>>> Note, that clang's revision 329612 or higher is required.
>>>
>>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>>> ---
>>>  include/linux/compiler-clang.h | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
>>> index ceb96ecab96e..5a1d8580febe 100644
>>> --- a/include/linux/compiler-clang.h
>>> +++ b/include/linux/compiler-clang.h
>>> @@ -25,6 +25,11 @@
>>>  #define __SANITIZE_ADDRESS__
>>>  #endif
>>>
>>> +#ifdef CONFIG_KASAN
>>
>> If, for whatever reason, developer decides to add __no_sanitize_address to some
>> generic function, guess what will happen next when he/she will try to build CONFIG_KASAN=n kernel?
> 
> It's defined to nothing in compiler-gcc.h and redefined in
> compiler-clang.h only if CONFIG_KASAN is enabled, so everything should
> be fine. Am I missing something?

No, It's was me missing something ;)
However, "#ifdef CONFIG_KASAN" seems to be redundant, I'd rather remove it.

Anyway:
	Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
