Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELtyHELqERKsq1aICD9q+UVjCBXl7FzLrhDpHXfh/142uJOrWzCoWD61pIy6aLfzUGwqRDxR
ARC-Seal: i=1; a=rsa-sha256; t=1522076986; cv=none;
        d=google.com; s=arc-20160816;
        b=G8rC7m8JFO15A8DuvdhyJAybMWLZkH8kthPH3N9rZhREuupD+de6K7AMfCcDDPBL9s
         Wlfq7GK7Slst603i7tHR8Cm1OsbwCdjlH/F6Fq4lu1E7MLPHfDYNN11yNsOrNlxTGWJG
         ahwr4yhMKXwlVWvwsrT022Hd85Y/qEhxCHaEm8eMzlDHI4BF3hcYVf2nApHxHi3cab5M
         FkGdgSdPxKCULlW76oto+JQFHaKu3b8ym1XWIlgDfgvrb0Taf0RO5q2wn/cX45VPgPG6
         HltikwqhBRses4pKf0D5WsAxLZ/2mWmdcysIYmApLDoRRDy25e6JeXPx6mmFMQPlWTBS
         2NrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=d0inlIS33wiWRwZuaRe14/0SwbgvKB2NV58Ak5657Ug=;
        b=jvS2kl0aUdVgNR5ijFTdEiboLe9Kz2KSnnM/GsEkrtsookgNRvpnyPvwiW767yqUvg
         ICk1xLXOA0R56ThxYTFQW1mVMWi+JWVUufMgCIXCQZr3+suzj4nAtB7xWbGy3BFNltjW
         1lSTsbWTwLvELnPq27DvAbOYOkEzfEKK6LDpBSEZdaa9CIRejw3cWRjd8Pts8F+S4Eaa
         KUkY7NChO03vwMfd2TzI4LYSFwM46YsjaPtvR4byAJRQXvayxoFhvxLbx8l20A27OeJA
         gxcRBf2rwSuOkrHZ6VDm2F+kp3vzJEfu4cZjh4VTFd/jeFNbDPgDXa6Q1eyWQM+e5GKS
         STcg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Og8IUHWT;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.0.112 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Og8IUHWT;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.0.112 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 01/10] mm: Assign id to every memcg-aware shrinker
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163847740.21546.16821490541519326725.stgit@localhost.localdomain>
 <20180324184009.dyjlt4rj4b6y6sz3@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <0db2d93f-12cd-d703-fce7-4c3b8df5bc12@virtuozzo.com>
Date: Mon, 26 Mar 2018 18:09:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324184009.dyjlt4rj4b6y6sz3@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P195CA0015.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::25)
 To DB6PR0801MB1333.eurprd08.prod.outlook.com (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c76867b8-078d-442c-4a8d-08d5932b99a4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:i8zSPi8iqhrk7nxh9x0PbAw66Qv4AJL1+VWhElqfXv+nASVAY+y4IBR2PpmxWexHVlUeqkZbxMDBSfZUGxHPc5P1Zkako2qlp9pkasvx4t0X8TIAqWYSlER2NwUbeaOdsbAs9xmRah00Grbtq+5qH8ARpgosO4EDJfWd0Z23QmllAGRU6xiZkhJezgjIgrIkr4a7WMV2WU+B7AocnOf5KIi9+CDEw7UAd5I2DSPqssNZddRwkipbhXOJVmiXCzwq;25:TcIifSfbhkn4NFlWkVzYDbq7mrqdNLFiY9ICGY3pjEns+ZQXZP66opK8kmIhp6aPkEzUNDK5L3gODjdBaJzuFIOI6chXmRJFXXB6Zdrl8kYGuDXFfbOgxcjdC08xuuFbnvdG3eqpQBqGXayxVwqNR+kS7PZOMKSFMAAyju8B4vWfvnK+6mxl9iWR5K86QCTaxVCjvpPuoIfydoYnrqMvj5nFvT/v7zanwxNin16DRdCeuMkap3xOhddwfE7htHltQQEQM9eEcEmqb6Ou2OLaiW7GEFwma/XJ9CBh2mEmGojWYkL3SNPyCgt4oXwXpS3P3Nte5XyJJV3Ubi0Jws70iw==;31:IKASKPTFSdn7EebAmMFjW/AHrTejaPw+pn49C72pl/cgbks5PYY+RhjjrXj38Pa4Snnr8C+uIeL5xj35RfvG+dzT+fLUHBWEXmd2pGeWVI5TBDkrToC/Hov5RE83x8gXkl6JrSxsLWBymm7FagwHCO3sP3/c2U2RD8MvlphuO52f7Pg5WwKK/STA9cxVIBGY1QXhJvHeLkRtWdFeyhzlbOgsySla9g0uciZpElDIsKI=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:No3FR1V37U81nxR77RD8OwLKUbalAhn7I7SDkCx88OJFcQsVPGLOM0p9jumV4ZkgaWr9QbXQea4uzQQd++m+PKb7MaVtuuJWfpuH1IqtJFTtAeLCJ7TrcLpuqjmsuLuuB2RcK9sV3uc3f0+jZ4g7tjxcjOb3vlGbNUwaqJbAY2UgMkbL1KvPgSEGIE7tWj9PBdF53YHshf+gg/vFXf3vNtecT9PFr/jFbuNJau4hF3wZxq0pRPfcdT9MawliQjnsyM52YO2WITMWgFpWSz2i/2xRFZvlSfs699QSAyVYkAzIa8hLcO/9cWuyyhgPZ869rn/hJtKd4ILrOnnSCilV/jAcBrB7QT4BgO5UgDbM2y+K6fBSLd9E/LpdAzH9K8DdJi26zFPN30OK/5Fxg83hQNfqCSAd84LTI1ptBab24I6AhwFBFdofizlFBC9DxV5Zu7gmRwco1MHra3VFU/z2IY2i/sxx2zzxVdd3kwA0dIWBOkrgdBHoUBUrQJnJX3TA;4:QU0O7nEQIw9MKH38b5Y9D/7B9nrok3lNcvO5IpxLfHM8q+ci7wvsiY6SzB/uWxmUOgJB7B2h4k7CsRzljSeHRfOTarmPRvZplXPgq/QkY8VeLGvXDn/OnXcKDlvMl+zQX6Up9HuKhWg7y1MwRHvECrd67GN9SOpq8T4xHPnbVfriCdjSyqQwmazGFwd2Rs9rbNJJSsIuvgePPf+aFciAUjou63ebw8ji3kKtGBNXhpbUQAERSgK2FE+nulUESUOqIORY0KV6ZFcVGJIvTR4XuQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13338803B442F1292174A782CDAD0@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(396003)(366004)(39380400002)(39840400004)(189003)(199004)(81156014)(6486002)(81166006)(68736007)(64126003)(16526019)(8676002)(229853002)(97736004)(186003)(31696002)(31686004)(478600001)(58126008)(16576012)(316002)(106356001)(105586002)(3846002)(6116002)(55236004)(25786009)(77096007)(4326008)(26005)(50466002)(36756003)(476003)(8936002)(66066001)(65806001)(76176011)(65956001)(39060400002)(2906002)(446003)(230700001)(5660300001)(47776003)(7416002)(52146003)(86362001)(52116002)(2486003)(53546011)(386003)(305945005)(53936002)(6916009)(11346002)(2616005)(956004)(65826007)(7736002)(23676004)(6246003)(6666003)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6bGNSRXdtbjVIbHAzbm1SUVN1NUtZK00r?=
 =?utf-8?B?UDlJT0UyNEJZTWxhdlhHQ01NM1hxYmp2blBpeGtwb2RGMzB4ZjlQTGtZRUVy?=
 =?utf-8?B?N25HWGMrTHNwSXhBaWt0Y2YrK2JnUUxZNFFUTHI3MTVvT0J4MFU5aVBFUEkw?=
 =?utf-8?B?NmttKzhKM2dKZ0o5NkVmTW1URzZKbTZSUTc4dm5XMmt2d1JDUDIzQ2FXdGxH?=
 =?utf-8?B?d0NFRmt4amxiQXh2d1FNQjdGVVJUazlnL3o1TlltcDEwN1F0a0xGalNPYmJv?=
 =?utf-8?B?eVM4RWJsdjUvd2JhN0MrOXJNaHh0eGwvYmd3YnVnYkhnNlFoclFDaGJOZThQ?=
 =?utf-8?B?eXhxdjJGdUlSaDBDWXpHUGp1cEM1U20wTWtqMTBQVnc1dWwxcTRnZUNzZEQx?=
 =?utf-8?B?MU1BSjAyNVZCaVAyMFhIMDVBQ2VyK2E3d3k0WStGalhVeXNHK3NRWmtJenNy?=
 =?utf-8?B?UXlPWTh1ajFvZFIydmpVdGcvSEUraWtoVVBONUlzTlF3MExiWFUwSldLWUU1?=
 =?utf-8?B?My9hdTdHSHRLS3EwT2UybUY2REhLMGtBTk5iQVROZGZEK2RneFVLT2t4Z1dP?=
 =?utf-8?B?MFRYMFdCR28xd0F2Nk1RUzNjb2JJQWJxcHZhRjVPVlYwWHdUeW9MNEFsa1ZE?=
 =?utf-8?B?QTlUMlIydERKSjNsaGs2WFg4YzZsWlhGZ2N3VFh3KzVzNGt0THUydlc4TS9I?=
 =?utf-8?B?S3ZodUR5ZWpJdVBzR3htQnJsaWtUSWtkTVBKMU9TbXhGYWU0VFBDTDFFczVi?=
 =?utf-8?B?bTRTL2h4Yll3OUc4MktQYTJwTjF3WnhxTjlLVWRLSnJnSkNjUGJWMGcrZG5l?=
 =?utf-8?B?UldyMHYvYm5HRGFHaG0xcHRMU2ZiL21aY3Z5dUNUdVU0ZFpvaWt4QU1tNklX?=
 =?utf-8?B?Q3hmRXVMcWFLNTRSUmk5dDhHSTRYSjVpcGpSdnZIYUo3YnJqMWsxMkMwTC9w?=
 =?utf-8?B?OHhPWU41SXpEQ3djZ200dzFGNWVPbUhEY0pGRjZjaDdVV1QwUnhESzN2REdH?=
 =?utf-8?B?WkFYSzJzcHpWTWpEbjZYZUoxaTk0NE83ZWMwTEVvWCtneXVNNGlUS2Y1dTVs?=
 =?utf-8?B?OGxxS29zb05jM3hoWXFPTHNVZ0V2L1c3eFZ6NnNDeFNRNU1yb2lwbGF6OWZw?=
 =?utf-8?B?TDE2d2JFNEZGbW52VENUNXE5WFh5SjV0ZjdkVEp6UWxFUTRmUTBuOVppM1Fo?=
 =?utf-8?B?UUNFVUdFb1lYREVPbXhVMkY4MjZkSjQxa0l1aUd4M2llWnBzUWZNOUlxbGFQ?=
 =?utf-8?B?VWtqcU1EVyt4TXovekFOaWh6OUhCMDBwQ0dQUkdoeUdsZjdhbDV5NzFKOENX?=
 =?utf-8?B?aVNuWkZWNXNSL1NzVE9EZENSRWNzUVhCRUFrc3AveXZBSE1HNjArT2NmRzhB?=
 =?utf-8?B?OVBiSnhXcHV3c1M5bzFVOENCMk5EcGR4TGVrMHFXWXZSZ2pHbGdydW0xd3Rs?=
 =?utf-8?B?cGdhOHMzUTVDUWxVSnVEOEk5YlFqNjBGZkFTV2NYMi8vNmgybitVdy9xWThQ?=
 =?utf-8?B?V1czOHc2Q3ptN3RZZldCejhZcW03VkZ5S2diOXV2Y2UxT3BKRDQ1bm5Wc0pi?=
 =?utf-8?B?Tm92eUxqNmUyMDd1UXcrUWk5MDhmMDRLbTc5eEpqYngxcW5tbC93N2xtT1lo?=
 =?utf-8?B?K3dNTktxd1FCdDFzS2J2WFoycUtnVTc1bGxyZWgyV0JIaFlDcjhzZEpIUCsy?=
 =?utf-8?B?bkJ3a1ZzamhqQkF2SEx0ZEtobEJOMG5CUVZLN2pJei9MYmgxemxlamRDTUIx?=
 =?utf-8?B?QW1YUllGNTYzU0g3RGwyRHFJRmI1cTRyOEZVVCtLUGFSMzlLdEhESTJWZFBU?=
 =?utf-8?B?SUMwUlBtYlYvLytidXR5cVhFbmo0VkhkVUl3c2gxSEV4cEI4N21XSE1YVmpr?=
 =?utf-8?B?STJFTmhKS3FDdTlJanF5THJxVDBQNCtLdjZIOHVOMk1IM09BZ29BTzIzcWd0?=
 =?utf-8?B?dnFzRjY5ZWQ3a28waEppYnJYTjZWWG9xbUMrNWZVTXYyaFZEMHc4UVg3M0Zo?=
 =?utf-8?B?dEdJM2xOOWYwenFzZWVQaDNBZGNnelEwTThGU0ZBPT0=?=
X-Microsoft-Antispam-Message-Info: vgZEAcj8nJiuAjFagpN8h+xjr7Tr9+TMZrrwcfxfxi9b4+fXT6mrDDpfyhVQomJGZsC/e6YCPD1YAMsBofPQn4soGymkq2VbVvg81yS8qkBnro2HUJ8OvKAUkJw5hvyfWx5R/ZaIz7RN6wLm4lkhviON2SPZ7tMlXrzKUOYD94qUqMUr0zv7J5uQLj7ZEdvc
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:gxdTGusOJ8KR16hVqERrYLktrYPn88psZoqK41OLpM85Ud2dfVK6dBqCKrfJG1QElytDZUPXXviU1+fGAdZo/AjmjpEF4adDBYp1e91Wrdn9Bcj57YIMopjg/VEdafr5k4U/b5WyBX0pZECQvJ5crdzDnFB7os80VbL3a2Q0FrLpIRp9iLW7Q28mV5Wyi7XDg1WkQOUD8bZ8DPXVqRfAFPb2rHFAmRGkw/0CtErs2N0M8Xvv/yo3YLKHC6a94fXu6wMOT9yZzlreagk5a6bgs2Z4Z3Pr8mBxAUUdvKceNagv7gKOjruKAEsLv4J0NBVfW0w7VRpMqTJ1t5w0+tOUxN1NobeVXrhW0cyAK3vfh2DZJcuqL3Gyqeoe9LhAEnICsJhy8lhL2lIoiqFB9Djuy1dAOxUweF23gTr3AQ+13hQlA5feF1joEV6sMmslSOFnMnQ4eyxhnJ8I7TsPkk0ppg==;5:QF7EItS9Zcyvib6+9w+swluOjbNtF+rvlWahSi8FHyF15QqyTIE8KWRCRdlFrTIOLNiwa7nuoNpbnG1/ucVu+/27EhFjP+qBJsKYp4Zu7ygpj931Juy6gUfHRVxTrz0F62wc/KwoHHA7Y7PM+abRR4MpC4Ydsn+HBzd3P28PW1U=;24:xrMoJCbMavhplUVg1tFnme2/Gbj5QpczwO56++jWh65qNdpgF4Nr5TW/t7BYfhu8hlQFPRkc0wTSKI3FU13aqatNakFHSiDlDYQNtKZk9Bc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;7:t22JKQRbI3rEnUM7tpKxjH7YL0xJrC1CG3IRlz/D2gzAYCA3H6rFXPaEi/MaJrzWPC7Oi0hV6Mh9YsEwwjq2LUO0qOxTxhcqJYVrBDb58cj4mWWcduxVxXcM44mRkcX65US3sbnMfqxTcEX3a8cnTwuRjHIX00Zk/xef21RGbvINs7/VVjA+8Jqa7sECLeO2J3cBTF3ZHOk1PYnRzJb7NINUPVGbQwhAVbAp++fAb4z2aEWMpYmoIs9oR8Lh6EPI;20:I3gN6woKfMPSwHVcbxlicZOrPA9ne6CNI22mZgBUjEdAp0r3HzO+lz4oAHbto24I97cg1z6J2iYzJSgB/A/YuXyjGkfTRvYNTXnCZHo+HSTRGJqyOtNumMwTwGe06hvKkRQ5cXQHtrJX2Ws4BzlVwm5OfFCxCdiW6IpsGbro0O4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 15:09:39.1787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76867b8-078d-442c-4a8d-08d5932b99a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553598792007322?=
X-GMAIL-MSGID: =?utf-8?q?1596013398194559948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, Vladimir,

thanks for your review!

On 24.03.2018 21:40, Vladimir Davydov wrote:
> Hello Kirill,
> 
> I don't have any objections to the idea behind this patch set.
> Well, at least I don't know how to better tackle the problem you
> describe in the cover letter. Please, see below for my comments
> regarding implementation details.
> 
> On Wed, Mar 21, 2018 at 04:21:17PM +0300, Kirill Tkhai wrote:
>> The patch introduces shrinker::id number, which is used to enumerate
>> memcg-aware shrinkers. The number start from 0, and the code tries
>> to maintain it as small as possible.
>>
>> This will be used as to represent a memcg-aware shrinkers in memcg
>> shrinkers map.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/shrinker.h |    1 +
>>  mm/vmscan.c              |   59 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 60 insertions(+)
>>
>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>> index a3894918a436..738de8ef5246 100644
>> --- a/include/linux/shrinker.h
>> +++ b/include/linux/shrinker.h
>> @@ -66,6 +66,7 @@ struct shrinker {
>>  
>>  	/* These are for internal use */
>>  	struct list_head list;
>> +	int id;
> 
> This definition could definitely use a comment.
> 
> BTW shouldn't we ifdef it?

Ok

>>  	/* objs pending delete, per node */
>>  	atomic_long_t *nr_deferred;
>>  };
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 8fcd9f8d7390..91b5120b924f 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -159,6 +159,56 @@ unsigned long vm_total_pages;
>>  static LIST_HEAD(shrinker_list);
>>  static DECLARE_RWSEM(shrinker_rwsem);
>>  
>> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
>> +static DEFINE_IDA(bitmap_id_ida);
>> +static DECLARE_RWSEM(bitmap_rwsem);
> 
> Can't we reuse shrinker_rwsem for protecting the ida?

I think it won't be better, since we allocate memory under this semaphore.
After we use shrinker_rwsem, we'll have to allocate the memory with GFP_ATOMIC,
which does not seems good. Currently, the patchset makes shrinker_rwsem be taken
for a small time, just to assign already allocated memory to maps.

>> +static int bitmap_id_start;
>> +
>> +static int alloc_shrinker_id(struct shrinker *shrinker)
>> +{
>> +	int id, ret;
>> +
>> +	if (!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>> +		return 0;
>> +retry:
>> +	ida_pre_get(&bitmap_id_ida, GFP_KERNEL);
>> +	down_write(&bitmap_rwsem);
>> +	ret = ida_get_new_above(&bitmap_id_ida, bitmap_id_start, &id);
> 
> AFAIK ida always allocates the smallest available id so you don't need
> to keep track of bitmap_id_start.

I saw mnt_alloc_group_id() does the same, so this was the reason, the additional
variable was used. Doesn't this gives a good advise to ida and makes it find
a free id faster?
 
>> +	if (!ret) {
>> +		shrinker->id = id;
>> +		bitmap_id_start = shrinker->id + 1;
>> +	}
>> +	up_write(&bitmap_rwsem);
>> +	if (ret == -EAGAIN)
>> +		goto retry;
>> +
>> +	return ret;
>> +}

Thanks,
Kirill
