Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELszHMTS+9BkMOwkoaACT2MN+nrH+NzbJlxuIST3BqpyOcRBc+mRwgsiY4XYlH8Q5EI7iwbp
ARC-Seal: i=1; a=rsa-sha256; t=1522078282; cv=none;
        d=google.com; s=arc-20160816;
        b=BTzu7jCX/9mMXScTtUF1Y4AP0EzTWVGaNJLA38tb/XwyYEThA2o8K4wSMkE57OkKfu
         5QImvNoZxwnJ5j3ebERs9KQm4OPGsjXowtHN3Cwfjpsr++I/xyxYvBMug5OkB6nuiCml
         WNrjVSro+Y///VSuklhpV20tuR03d11EYoIjQY2pSa9Xqmv+c30JXfvH4zxdeGhLAnDI
         IhZLJe3GQQhnKn6SPlmJuXsybQDoCN82uc7Qz8rVIovC7TM+7/lZ02abfcatnWQQwTo8
         uGMfmuOkw7uxaYL8Ys25mg3zEJJ+wpMokK4vrAJckNIfNI73o5Xtf31S1QxEXTAjkyjz
         pZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=W7y4ieRp/jGX267T4DGT4bTelffbn7t7UlDsbn7zPdY=;
        b=TzMZOMTnh9eeyNx6bXJnBamVQrxIvYeAqTlwpiKdryqZcYdj30a1VDMf1ymawvF1jK
         /mo91GjeWiQ+3+7CuCynprilQ45b3ImXx0Q6GUDURlAZrspwa+QzLOqHQyjkiCXZqd3H
         4VP3HOdsSKlrNmPbxF8qFvkxPXCuYR9TiBsSTAhE55ERvFBLkCo6DO1R1gPTjqCubue5
         Q8xl7/PWtBqnnDGqgytNRq9NLRYM36ub+mrknsTplYTLA1wF3z2vqFwUmfj88/TTMnQg
         Gry76N/rTSe1puPilQFuWa54vyOsg8rmEtNn3KJt6IcLw+1TPL7nQ2eJ2sQdWPJbuXBO
         5xiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=SZzUBHPj;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.95 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=SZzUBHPj;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.95 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 08/10] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
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
 <152163856059.21546.11414341109878480074.stgit@localhost.localdomain>
 <20180324194540.rvejbnjg6knkwwia@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <4cd895c4-73cd-935e-2b67-583d8d849b7e@virtuozzo.com>
Date: Mon, 26 Mar 2018 18:31:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324194540.rvejbnjg6knkwwia@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0223.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::23) To DB6PR0801MB1336.eurprd08.prod.outlook.com
 (2603:10a6:4:b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8994af2-ced1-4a65-394a-08d5932e9ece
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;3:+Utvs1gDPRQkVNEiFSnO4tkO7kXGVuWZ7oMmj/rhKhzWWg0cEAtp3TN5F/Nj/glkQnsa4Vz9vn+LgwOHwFMUrRfwUMsRFNbteCkmVmOCMAn/YkvL4ylo23Hl4INcdi4NZlNu5rA4yFdXtWfqcy4hJz0ULR1O4z3INyDB785cKeOJdBOsyy5XVHlEI29isafXibV3VJIP2NEBgt7RWkjehQgsguJI0nAsasia9kSTvDKWsIk6IVwnqDN9Bb9DLC9f;25:r5ufKgkRTwpgbBPgIBhHFdEEQa3cB+7dvHzhGjr8nOa89EB5X27Wx2XRUj9MxLGUzQ1DgqEviW8ErvLfnTcboEFE6T+QfsyALIOgbnENl3v6SeQWEk/UWfEIeZ6aE+iZZqze6Z4JFQdXnzkX7ewUESbXF/DVk5hoXw/bMa8SgQMqjH3Zco/TP0Tg/HRBcT0snTuq+FptJZx3QRd02h/rkvE+QisYRIcoAzzEZ3L7EHwqRIy9sfyCS+w287madpGI+1R086sSn4Z/ty63G4wtsdi+eZ/MicaafftLPHu9OSX5vnKBONNnyJb8fLIxmVV+Q3uoeczN2M13oEVoMa7Phw==;31:CwbpIpSh53icHPSdfyOwGggJs/LJwHP9LtwIAOLIh5dBPKkUJmLwzl+8EFA9myPidIUWkOAF/t5TDhawU/7kiDaHGROwyMDC9EQj61JuWvGZKDYF9H4wqA/+H2iARstA/9Y4kn+CwrE/XS2tUNhAq50rBU0XCwSLOeBj8rxHBhRo6sp5IQlvNJ4HOx41azeQZkKaPYlk17SyV3uAfW4mCxkpCZp63CAaymorN8+hIqc=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1336:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:daseQzSSzJIK8OMjjwNoju4kTU7qD8OUgAhfeRI31A/Bv4sTGi5Ls6usJ98/Z/+iqDRgWj6JcmlUe14o5ierTjcbdfQr5PmPJNBnHHWnk4mfSR2q8TBKkIU8/YkLiQWcbL3we4i6XXe/n3NtjF+1F0T2zmqrrVhfgvgua/UFCV4F4udH+IvhJ4aYugNorwkFbTyypfzFiH/eXcrWVIS5xgf/cgiAOuMYXW8tJZO73FpQ4qxiCRxqqyRekCVXDFpAGwndqYNKzH9Bq0o0WhhH1kAvouLtbrRRly53fB6uvfaQ/KVkaO9YOfuiufbFlwaxJppeTGSiKcM9o1ZiM4WzZr9NoZoajOm2Cwwo6JN1VrYjdjFwCnxXrlO9NudZXtAYFOp66vgswRO8CyOd0qDmf5YpcuR2ETM47dxv8rXu2VC+rnbVI6dnU4JCtAVYRBV1MK2WSHg7YbU29y5p4El9kTKmyPlOOPfXDzoi+i/W596TeuNnYl11ikiQja1V6hY8;4:fbfIZL+L//Tb4v0nY1mFHAQYfLbpom+X2ss2uXMWmmxo7s6XPQee8hW6MKowIdCL8nYQUD3YB1aSxwsFZwu+eDyrlBRSf5aXJIaR+4odlVWpO9vomYrEGZOD5lZz5ZbKpTdvwsAMYGuvezRkBpPVHN8kpKOFP1uTgzBtD8v59vVJmhYqavaLMVg5m/u9Vvzxd7zEr1F8IukjJHYz6gnboMjFJTYibOol4E3h2amU2ODQcWLGSgCikOTeW5Q1rhlBZn9wI3PDmqrrGggGjNM0zg==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB133638C4857C73246ADABB6ACDAD0@DB6PR0801MB1336.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DB6PR0801MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1336;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(396003)(366004)(346002)(39840400004)(189003)(199004)(64126003)(65806001)(52116002)(86362001)(39060400002)(4326008)(97736004)(25786009)(11346002)(2906002)(7416002)(52146003)(23676004)(76176011)(2486003)(6116002)(3846002)(50466002)(65956001)(486005)(486005)(31696002)(66066001)(47776003)(230700001)(31686004)(8936002)(186003)(16526019)(53936002)(81166006)(386003)(81156014)(8676002)(58126008)(59450400001)(5660300001)(55236004)(53546011)(16576012)(446003)(6916009)(65826007)(68736007)(36756003)(105586002)(77096007)(2616005)(26005)(6666003)(6246003)(316002)(478600001)(956004)(6486002)(229853002)(7736002)(106356001)(305945005)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1336;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzY7MjM6L0FFOWhxUWNUenN3TmVxVjNISExUMHdt?=
 =?utf-8?B?SmFGcnlxNzZ5WkhJbW44NHhZcHJyMjJ0dHRSVDRZV2lXVjUySCtjdkRQaFB5?=
 =?utf-8?B?RE13NTZRSWR3TGJZeTlBUHhmSzhDdVFlSm1ldVhxNGNTQTMzTFltWUUrdzU0?=
 =?utf-8?B?U1R4aXJhTHZsMGQvWiszelBLcnpxSWtRdGJ0T0JQZzdCdUV1NDdKNzF6Z1Jr?=
 =?utf-8?B?VXlDa1RYbW0xdUpjUVplOTlDamRBVGtOSlY0SnA2eHJzVFBMYVlidGw1c3JN?=
 =?utf-8?B?WmNBcmU2ZHZzSk9Ma2xzWWpwdnpTOTR6UEZuQzVjQ0xORDZvWVhqT3E0bXJR?=
 =?utf-8?B?dFY4RXBidzdXQ0xpUk1JYXZKQ0hVeWtmblloWURsYzd3RFR3cHlramE4ZGRn?=
 =?utf-8?B?VWtVN3ZmajYrMC84R1RLZUNvdUQxeWJ0Y2FEVmI2QUFkazF6dEpRWnZnVXRx?=
 =?utf-8?B?KzJkaWM4N09HNVdlWjRRVW5qekoxYXdhQmpIVEZJUENGbnlKSEFKTDNYanYz?=
 =?utf-8?B?NHY1Y28xaWd0NHZTb1ZLbzJ0MEI0SnpXT2k4aVNiZ3RrUU5ZNUJvQWJ0SnBi?=
 =?utf-8?B?RkpVRkRFMzVxSHdFMkIzY094TFczOFhISWpPQ1N1UyszSjdzNWlmeHZGTzBk?=
 =?utf-8?B?Yml5WDhpUW13ZmZkVm5XbWVxK3VHMEZJK3JudnBtd2xNWUViYmhaM0xsNlhY?=
 =?utf-8?B?RnZxeWVHSjUzVG5HQzBFSUR0aHE1U3o2QksvYTc5S09wQ20rQStyUlI1eDdo?=
 =?utf-8?B?Wk1pWk1DUis1S2lJMWZSZVpWOHNuTllZMjF5K3AxN2FZQTFDZk94RVhsVUxv?=
 =?utf-8?B?dFg0Z1ZXTW91akN6V3FsSUV4MmsvSHE2bCt2WGRNVVhqY2RFaGNob2YwZ0d3?=
 =?utf-8?B?bjhaNGx6SDVjWFJTWUtzWldKdENkaVlzYzBKb2xpK1Nrd2pGeFZZYlp3UzMz?=
 =?utf-8?B?MjFFamR5U0grYUdTYnBkZGN2UEc3SVRXWkYvQXdEQ295aGlDQlg3R1owSFly?=
 =?utf-8?B?N3hqd290WUhlbVVDY1RPU05Nc01NUmw5azBOL01MWlpFU0kyNlJnMFo1SC9U?=
 =?utf-8?B?WU1hZVNVZ0dtTSt4dFpEZVR4UW5LRnI0TUJnRVpqWmYxSnp1WjFycnNKQVRq?=
 =?utf-8?B?WlljS1Z0amtFUmNiak9UZ0thc3dUaktNY0t6d3c2ZkplUHhvMEtLN01YRmJJ?=
 =?utf-8?B?dXd0ZGJ0ak9sYWRvMWdPcHpSYm5nOGxuSGVURHdjTkYva2VyZ3VDRVZqRU5W?=
 =?utf-8?B?eit4eUdPSE1vODFFaWo4NmlTRTU4MUtWKzY4WE5iYzFGRDZUdW9mVkJyV2Ux?=
 =?utf-8?B?dzBrTDJBQWRMZURIZ2tJQy9zeGlLWGluV2swQzdFNWRVYkVCcXlNV3hoY05x?=
 =?utf-8?B?OFJaR3B2eEhScWlkRDZTSXR0MmtqR1JIWHNpTExQWEIxS293UWg4RzQ2MUk4?=
 =?utf-8?B?cjlWakhWNG0xcTFHMjk5VzZlTURYVk1ZUVA5c1h1YWhSWGIxd1k5Y20zNTVM?=
 =?utf-8?B?N1BiZU85Q0JMQ3RlUmp2Z0ZsTTMrQlNZUEl6THNNUy9Vc2lJdFRieXVKTGxi?=
 =?utf-8?B?WGs5ZjJ3cWplRExvcElRV2NaL0lHQWZNLzh0M0IrcGdXOUZ3MFpMenNReHIv?=
 =?utf-8?B?THA1c2N2cGtabjNjYnhCS01rcmZwTStDTUM3V1JQWmp4bVVNZkVmbmV4aFB5?=
 =?utf-8?B?dVFLWkZlNnJONzJlMEo4NE9wOGd5S2U5cWcyeitZK2FzRDVFZkttdzEzNUZE?=
 =?utf-8?B?ZFJTTzVZZEtmR0hyTFFIYkNKM3JZaU9ocFZIcDlCMytab2xKcDdNSFczdHdQ?=
 =?utf-8?B?Qkg3ek0yYWlOMGhsN2hkb3MvOGhrYThiMmp5KzBoMk16ZnVzNlc0Qk1SNWlt?=
 =?utf-8?B?aWJmL2REb1NlZ1BlYmVVSFdtcXdmK0gvVFA5S3JMKzcrNHl3a0dUdFVxSnZl?=
 =?utf-8?B?ZjdUeW5iKzF6dlJxcmlUeW91WDFMbVBiY1JlQm5WNkdiZldPL0EyTjNJblAr?=
 =?utf-8?B?TEtIdi8zRlM0NlR3UzFmMnFXUlRpVktnbXZ0eGZYelFTRSsxOTIwdGZsRE1E?=
 =?utf-8?Q?NsFrUAHS2QsN9z8ZTXoR1Gz28NB?=
X-Microsoft-Antispam-Message-Info: cPNMW/KYHxZlDkAQrUHm4YJSvqPsCsLONjP32vZTeJLKvthfHFf0sQQ0Ha/kq8/xKj4a5RwXyJopu5a/ulNdZKZ1o65fY+N/yu2gi7nhKZjnLyejxhhkK+MzOHF+AutP9n+GE9aFQcNmMqtuxHzMNZOD3C9tv2+AhtZnY1nzHDWVv3OWGn+135kypFprpvRb
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;6:QFNH03E1z62ajq319sMV0rH25T3obCQcdS91s1gX8Prkz7tVBsnTM+dwb4OcjwZ5q+NJW6/hKF56rtv5RXcUKdFaEy8Z+rWNT7XuB1A7/qTPqXpnbvX29XHGnGOnMxvb4ELuTvUjChBJYhy1iut5QF7+tS0EvON4Oesp21qh+/rQrUPkSQmyk5xNzrKw+9dyZVJwjzh+7a12SxeijTIjp9Hramk8qe/TfsVx0BtMnE0v+tjWgOjRfpMSJ8SBqNiA9qjZPQ0pWAxHsyyQDNqfOpF1QOX94whvzYy6lZbCRITVmhn5CvejrXkvSuTuwqyC+pm4rA0vI69RH5e8D3YZj/EXXdFrmmL1op0lRAJQU4Zi39Th6HztzvLhA525mFlwdDxu6bcFKh4WEKRa5BZTa/1167laSPnLmaqpPpVKI18VyTc1egfO41fKkpDRYjVZU1yUabXXsVVwTmsvP36O7w==;5:fOJ7DL8A18QkS6Bg2AP6DdPr9AUq5pVjUokjNWasfcZb5YupNK7ZLqrY2tYJf9ZFUc5MLsrF46DeVlCNCenjjjodUYFSVH+L+osr4fBpuRr2m4Zan5Q4WjOAy64tftnMpRjjliu+GjfMXhYkc7RBOr0VzIlxWRYI+3dUkpF7TG8=;24:kpKxPp7zExqrutC3+6k6puRpnDv28B+ASXfqrm+jKpr6R5sxQ8lEeZMgcsSHNs8/5XBMSDt4346JSCaCShFha1+Sqn14n1oJIBB33T23LL0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;7:8caWf5y7eh91yd3EYGPjFmtRUlD8yG44NPs8TraneLZHn7q8T1H/8rjozDxk61ebB+yREX+IDO2n5leSCLUQCmDQeClrtuO1a7YxRPQb+OG+RWGakpyC39XYrZB/n9UR8sPi2KFOXySks4KrkUuCKwcbPydu6HeYhSu86WA50OB2To68LlUWKGbJOGlf+izqR/o9W8uVjZTvmXjQBULv+FLzcRmPWFGaGyTgFkYnibUilfPPomBA8uudrWs4VOvX;20:vpHQ34MX8IWT9y/zX5yQaODE2TxA6WKB71xJ6RvxSaBMJ+8bzfW8c9UR9D0F34+1rhd/HI2+Pv+vD0ZyYoipxXk6XxyHU7L3MrxdJaBDAfUtvpn6csQENb95sq/1fDEIzu7uratL4bmgEAllmw6B/ZhFf40ly4jE8X6puNqqqRo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 15:31:16.0198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8994af2-ced1-4a65-394a-08d5932e9ece
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1336
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553686088522081?=
X-GMAIL-MSGID: =?utf-8?q?1596014756344418866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24.03.2018 22:45, Vladimir Davydov wrote:
> On Wed, Mar 21, 2018 at 04:22:40PM +0300, Kirill Tkhai wrote:
>> Introduce set_shrinker_bit() function to set shrinker-related
>> bit in memcg shrinker bitmap, and set the bit after the first
>> item is added and in case of reparenting destroyed memcg's items.
>>
>> This will allow next patch to make shrinkers be called only,
>> in case of they have charged objects at the moment, and
>> to improve shrink_slab() performance.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/shrinker.h |    7 +++++++
>>  mm/list_lru.c            |   22 ++++++++++++++++++++--
>>  mm/vmscan.c              |    7 +++++++
>>  3 files changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>> index 738de8ef5246..24aeed1bc332 100644
>> --- a/include/linux/shrinker.h
>> +++ b/include/linux/shrinker.h
>> @@ -78,4 +78,11 @@ struct shrinker {
>>  
>>  extern __must_check int register_shrinker(struct shrinker *);
>>  extern void unregister_shrinker(struct shrinker *);
>> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
>> +extern void set_shrinker_bit(struct mem_cgroup *, int, int);
>> +#else
>> +static inline void set_shrinker_bit(struct mem_cgroup *memcg, int node, int id)
>> +{
>> +}
>> +#endif
> 
> IMO this function, as well as other shrinker bitmap manipulation
> functions, should be defined in memcontrol.[hc] and have mem_cgroup_
> prefix.
> 
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 9d1df5d90eca..265cf069b470 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -378,6 +378,13 @@ static void del_shrinker(struct shrinker *shrinker)
>>  	list_del(&shrinker->list);
>>  	up_write(&shrinker_rwsem);
>>  }
>> +
>> +void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int nr)
>> +{
>> +	struct shrinkers_map *map = SHRINKERS_MAP(memcg);
>> +
>> +	set_bit(nr, map->map[nid]);
>> +}
> 
> Shouldn't we use rcu_read_lock here? After all, the map can be
> reallocated right from under our feet.

We do have to do that! Thanks for pointing.

Kirill
