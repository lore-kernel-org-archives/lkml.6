Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELvFaJC4MrB0/o9BeJTwW3FOqjIYOzibiX22vEWU9uvQI3EVT1ZnFDrKCHfCwbkOua/8WZ3S
ARC-Seal: i=1; a=rsa-sha256; t=1522078643; cv=none;
        d=google.com; s=arc-20160816;
        b=YO9w5mGd2F36rBOqvBys7hdKg5zAz/MAnnPzyGzPmVP3Zwf94+LRy0FCBk66kxEX5P
         r1XOZyJ7SESkwB8BNYHq62BMLqs8XxcG5sB3PyJ+KClTRMPTmM1UgPAXQ9Uk/41TyNa7
         xqHCU41WjFwEMPM21g0S2IfkR4tHMMmbpUoXF3HJ1zpM8CKOq2rx2tWPDeR4QZaCv9zr
         sagcZpVSzx0RYgOCXRN22kQteYBd8IO2OXFTf/9+K/W5LtzV9XaAKLtpLO9I+EQyaPrY
         p5VIDaB9P9xnHv0M/SAwLDdBa+viTffBQOQd+deh4KCg758Zn0FMOHkvk6mYRIX+tC/y
         q4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=T9yndd6qmkqR/pooiR/3toMCA5ee3IrOQJ414u1ToiM=;
        b=L9VACwwL3ORO8MS4fKXz8bLUAvnTVDSP7kRiL/HQG4gsqi6vEq2ZnRvdrmii9bN0Tq
         rq3Oz9dzUSW8YbRh32zBD2UzwhaybQLi1REnfKfipIq59day1tg/72TGFSCttkcd6Gjc
         LPa5e5G5brs9dFCqBCmQ7g/YZxHiWp4UsQhA+CUkOFzeXzDAe45PulpRlz3aP/hZLA5u
         jvDpPv17b+i5GbjyVgMf1ZobDXwX0WCtZz1DwsrgmAo24glrDs3BGtev8Qe1+Jff9X+H
         Qg5QnxKf+aF7UciTIih6AafJfM0U0wMsJlCjOb4cPO3yrRW0Bkym0a1jz/KygU4HIncv
         RzMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=gFORPWwu;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.103 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=gFORPWwu;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.103 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 10/10] mm: Clear shrinker bit if there are no objects
 related to memcg
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
 <152163858159.21546.2876185232270486710.stgit@localhost.localdomain>
 <20180324203312.b2whjgadm7gwby3v@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <f396088e-82e9-1a49-3ce1-cafc61b6ff90@virtuozzo.com>
Date: Mon, 26 Mar 2018 18:37:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324203312.b2whjgadm7gwby3v@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0045.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::34) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1465741a-2b1a-41d5-708f-08d5932f757a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:9Xp28+7mFnzucxeNTd6xlSZji+JUu3XJkd4tkZNSGGMJB+mF28tx4FzVJ/mf+WrOMjq49AaRrty43QRUuGDj8gc8Fl/NAN/wBhwfmSU6h6647snlxRFQNP3qqsEQ2ZUvYVRdhgfalWobgKoCEn8CMfjvuRj1Jqj8AX2v8xVaW/I00gJD6JBs4XOZiKuq8Wm0tyPBxYiRXUkE/VmL2j3ZBULwhX0NDQVykZaxFBqhdNwUWwl2YQxSAVa+DfA5bEC1;25:amYvWmhAfd/+nA2jWw8qa4lBbUynwt2WOmDjZjYFhb/bh1eqiInOXvJIlbYrYE9m9LvaXLHFKMs+eBIAkJjjO4K7e15xNQL6cJCjPgeJiNJfRMiI134axhJF6ov+mVxh/TCgz5YYoTcSXon2VNN+hF7NIbQduG3y/AEUseo/OPqN3xUPKH0VWKwKNb5RcrvVuU+5bNK6LV3jSW3WP3AMmaDuObzSPOy19Ru5wzwsONl+xaaX4G5q/qkYhoLkX+n1LAD83tZaEZQrZWJPbQp9eJ+zWhBpe3f7YSlA/Q3apuJMITcE8ibprckswH8mgj6mNyqPbFR6vg8W+oVyr/1R0Q==;31:fsxXFnsGudpJQPXKVsFwK/SwSNsg1jcWiq4DJTQjbQ1Dwmq9liix5FyCXg6egQk6zv9MIr18X1VGaEplLXFjyNnRLCsCeKWKBWd4pKhCiKqN97hBlOuYJs5vE4JBIp/xoZrQSla78HszGf3jaTRbSld7eLtVeBOpJKU5o2kW9SxIMVx4T4IBlPAw4LUeKSiwgQRxZJUsKgS5AO2B034d0GmR/IvyIf9d2nEmznvUQeA=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:KDMAlQ9Bpm1/1+EjXukNpgYKrWuLiND68XTncnqWS9eRVFiH5EZqMAbCW1EB6tFQLD+tWpo2LBrsnU0ERaCKGxZl9tgrVtsYNNmq90fnotj6r2jF6HVn4qSLXC3rdc6mRW0BjqeYFCJLpamILcAS4tzTbBRVI15YiRGYs/liVefAI6/RvjF9UHienxt9/1a9fS33DnzBkawedvGfxe8mG62FLtMVvWvQq2Cdgn16hU/r/bDT3I/aBaXkt39Foghe7IleaJQ5EqMHeHoRaBD+ivZUEZ+hro2zouuPPHJKZRguQDiHFyt2j4an9kEw8nm9GmH+rFtZvnVcMUjgaUTT3wON9tIpTDHRJQH1+Y2lnfInygzckN/5f/AazeT3ND/2GSbbkyIj8ERtpmxLBqdSsz46qZK4G64r8reNDaBJrZJQQLQqUBA7f1zJEf04iL0iulL6jlCmyiqE5H4xDS9XTtL6GVwamJVR3qW+dDQR2ND+QbjJVxUXf9DxQMTGfE/f;4:FSWjyFYys/ikqmJI37PLssk0Z04g0TsqGuujVhgSezjpT90b01lq9s31oqOSheujDGmTB+uWd33mEEjAj88N9EqbnWNpJAJv6p7gZS7egLqaU1kgLcqauP89tkqxPdzfvreTFp/aHRZ7iT/35XJSUuF+rfOEH0C94CrfdYROA/4SvTcIf36/LQVOETubaUA5SnpoSdaUDIGyKFH8JnF8hSEJuHjEa0qlEsaI5KMZj2S9CTMvNRfK3MhDoYl8r2IwrOWJCbb7fJiIUYUyTfK4Jw==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1343336E864EEE6A3F73D47DCDAD0@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39380400002)(396003)(346002)(366004)(39850400004)(199004)(189003)(52314003)(11346002)(6666003)(4326008)(25786009)(2616005)(446003)(956004)(7736002)(305945005)(58126008)(39060400002)(6246003)(36756003)(16526019)(105586002)(478600001)(7416002)(486005)(486005)(47776003)(53936002)(6916009)(230700001)(50466002)(2906002)(66066001)(65956001)(31696002)(316002)(81156014)(59450400001)(81166006)(8936002)(64126003)(76176011)(52116002)(65806001)(86362001)(65826007)(106356001)(55236004)(2486003)(52146003)(97736004)(26005)(5660300001)(6486002)(186003)(386003)(77096007)(53546011)(31686004)(68736007)(8676002)(16576012)(23676004)(229853002)(6116002)(3846002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6NEJHQVkwSWNaVW9zUmF0RGVnL1l0bGpX?=
 =?utf-8?B?bGFxUythd0FYSFpMZXNnY0ZwbXp2NlQ0MFRYWFJOVXllQ2EzMC9JOVRvYVJI?=
 =?utf-8?B?aXNyMlY5T204VUdvNFhVTG9kdDZpZVhzS1ZISGg2bmpteW5palVxTkVBWnZs?=
 =?utf-8?B?MUc0cktsZTlpTy9kVXUvYU8xNXp2NTRKRlBUUCtBVE1mbllTQ3FWMUZvQmx4?=
 =?utf-8?B?R0FDNHlTTG9zcFRySHRuQjVUZ2t6NTQvY3phNXhxbkpHaGRpQ0pZOHd2VDlN?=
 =?utf-8?B?R3RpVy9GZENHQ1RRK1RTaFBYejVqTTVDNHRxT3UrallyVklyaW85cVVYR2Ns?=
 =?utf-8?B?NVI5MFplVjBRZmM0UlZyQXFmRG41TEs5NTBYMzZnc2ViVVM1eG5lUEJKa2Vt?=
 =?utf-8?B?WGFQT0pueGxJNkZGaDhCUjljMWxuUU1PVTdzV1lRdDcxWGd2MFhra2lTanFX?=
 =?utf-8?B?VitSdzZHZTByM1BnNFhyNjBHL2lsaUZkaTZLSWRFSE5INE9KMndTVDJZclA0?=
 =?utf-8?B?TnNlN0YzY1Yvb3hONXE0cTBjblhuRHUzNTlpU0NiL1hzUldwbU4zVTFodjkr?=
 =?utf-8?B?SmYrTFpKdGxpVXo2ZHc0TzY2Z2hzQ3NjMmNRRGh3NFN3ODBtc3lyR3BsRkJi?=
 =?utf-8?B?WVdWL2dVSVhMeFI3cHl3bjRQakN5ODB6UlpaZnJwOS93Zng1ODRrNndnYmdN?=
 =?utf-8?B?Vzc5WCsyazdlUzR0S1VoWG1DWWI2WGxXYWFCdlJwY0phc0NmclJpY3NzaE51?=
 =?utf-8?B?ZzRISDBkQXRpUUxBaXhhODJ2d2lPaHh2bHdLcUMrTHZzaFB4SDdSNXRjSHBZ?=
 =?utf-8?B?aWxMc0oxSmM3UXNOVVVsQzBKK3h4djQ2MG5RUG04cVJBalhlYlpiNG1ZNGF6?=
 =?utf-8?B?RWMvTVFhb0hwQktzdTIzdktWYzhTc1dabXVsNUtFQmw0Q2Q2Lzg3NHBEanFh?=
 =?utf-8?B?blJzZmp3RHBVaUhJUkI1bzBURSs5aXdIbUN3c1ROVGxkc0Q5bXpybEU4aTgr?=
 =?utf-8?B?QU5CVVpFek4yeFZhaG0xMW5Zd1AveUljcWE5RXl3YmxkMUhLbUNiNjVnOE5Z?=
 =?utf-8?B?cWJhQkJkK1FzckhYVE5ZbThSakVvaHp3aXFrREVBMWE0bTNUclVRTFJ6Tlhy?=
 =?utf-8?B?Uy9sQUJMdnc3NzNkWnFvNTB0TzFOdm8ySXB6aE1tOHFDNTgyaU5HUDR3a3gz?=
 =?utf-8?B?bFJnU09GYjE3Z3lJSEZZNFFDbHJmM1J3UFJhU3FSUWpSQ0swUWJyNkpmN2s2?=
 =?utf-8?B?WjJ0VTZuWjB0LzMxRnBiaWZORXdVMUxSWUJCMWo1WXM3K2lBTjEwYXhHSVY0?=
 =?utf-8?B?VjN3RlhibCt0MTZXOG1XL0ZyQXJiY2JZazNONTFaU3k2bWo1cW8zZzl3QWF1?=
 =?utf-8?B?cUs1cGJsN1JkMWNPRVI2Wkl5clNZMlJKVVV2aTdLaTZKeW9sNnBtUFhQY2lK?=
 =?utf-8?B?c0wzblZLMnQxL2l5UGcrWkNWQ0JIU2g1YXYyMmpPVEd4OWgrN1picVlmRUZ5?=
 =?utf-8?B?WW0zYXltMFlKdmVIWi9DMzNlMTB0dXlpYjdPaU1pb2hWZ0hjekpPVGJGQVVu?=
 =?utf-8?B?bkMraGIyNGt4ZXNERG5DcTV2THdpSkZTbDE4YlFmQlpSbVRUN1Y4YWZwampU?=
 =?utf-8?B?YTUzYzNmaEdZSFZ5bmh2WGMyRldTRFVrVDErL2lpSUMvVnphWUdLd1BySCtW?=
 =?utf-8?B?d2JxWkVzNE9mdE5XM0hFTlVZOFFrWE53NHdNSURHN0NINzkrcEhvbTFvdEZt?=
 =?utf-8?B?QjNUZUhHeWdNOWlkR1ptOTBvaFpMaldaMmdWUDE5NWtCSXlSQW5ZdWJ0V1pI?=
 =?utf-8?B?T2ZyRDE4SVFDQzRPTDQxeTMzdGJUYnJZM0U3NTdFeDNSdU1HUmtrRTE1MmNS?=
 =?utf-8?B?M29HNVdGQUhnS2VQVWhtTEorenMvcURzRkxuVCthVXA2cUc1ZnBGeGt6K2tC?=
 =?utf-8?B?T0FzdExVdDFaamEzOUpNQ0VNaUpxVWNiTXc2SnBXOXZpczhnOFNQL0FzalpL?=
 =?utf-8?B?T3ZwWU5BNHdXbEVONmIrVW5ycWRKajVvb0ZmeUV5VUlqTDRHZGdUbzQxblNj?=
 =?utf-8?B?NzZvdUg1SlNJeE1ZT3gyeENsRXBVM2gyTW5mOSt1T1hHcXdrZVVOemxNa1Np?=
 =?utf-8?B?K1I1Zz09?=
X-Microsoft-Antispam-Message-Info: pDuDoMq97Z8IIOcv0TS/wEIg7I5loTKTaUzVbtLopmwy7bKnfTruXA0pQNwx8WpDHEUx5zzSry/ef5ptJ8rcis//+2/6UcLO/j5CfjVRpwFnSA3zcXXaODHdL8f9rtOJI2tcfVszuYVhXGu8noVYa0w+4rZxzmfo2vFRR8XGVXyeYNU1UWsrNYDWfOyX7eJP
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:WSNJd+5vj8DI8EtfrgvQ6klYBA57NtA1F4Ipikw9mpZaVC9qieh+ppnWXa8zjVLY7Pc3mkCNUPzR7KTu2JYTMj6kaZQFpWrNM8Zga5pLsVGu1L2p0ioT80IHpzzUvp9ZYEqeTdkSuWyesQ/42+ACH6FtfonR2+v4j3kW1qZZO4jGOmVpeSR+QrdnUOZSvqhKmIxSkd4Si5++3qXDd+b1FWxksWmgzGgoC7xyWeu1PTY4kUmr27vnqX/pxsnZSkzJP/XQikiMWc3XMeiv+3Y7fVYqCUIy10S6vFQStVyZ5V0W9/6GReH5iaW7xpP4LQSvzkyWkR+nIp4laKt1+BVLeGOSA+4iOmYd5Jl6Zp1Yy512bN2dKmD8W4euCXnAinEg7DUA5jI725st+l02ybgwPZ6HA2HgC3KlQ+1flXOJLb5B5XWTZvlJei5ANisiWx1k4D1oTp+TSYjY77LBZ9T2Lg==;5:fxHiqqM5vGpXf2bzX0YfU2WuoaouxfRVdGxpfQ8Be+qAERn6UhWcEtgLZzLGmyr7K44S4koUFrHGK/e1ut4ttXZvKo9zzTSvXYYm94TJb4N6GS89yw1TyePwnwf9mJojscz9pfCJeY1JNd+BUNnN8EMSjzj6CddPtqqQ9koOYjA=;24:UCcoxA+6iPeQfa+sqTI4piHNKTupR1bTjf5M0WTICncUJDtMxwRhwG+FqMDjBjLvbf2/r9huToNv0OVV+2z0OAq77lvppYxboBc89efstXY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:XLJarluV16y9aVslf+BN1TgEswijpAmVQhBKIt4IFodpkrccnyzje8CqAWKS75wy8Y8UVDu2XzmjkmIiokqNgccfvfy/td14HqFFIZPMj2IhBPYcz2MBxmculiuhTNC4w5AM//3dZPctOFTHgzCo6R5Yyz6axCdiPq6M0uTako2DJsmzAaroDo4+DtOkDfvwsCNqTMq4SilHPhMZIZGiyrmMVNnXrFrhgEumonNm3Q2ULMMbB5BgoZXmYIGn3q1H;20:1gFLvpRZuRu7OhwiJvIv9ISFA1QWddg2J3LEMbAIIDvUefqjzNoxAH3zZ0tlk6JGYBtCZozy4WJBA0KSl3SLzAngNIpKsKT33T9vAr8Ret15pSxC+1pRqESIEjL97jI5GMHAmtTVaNROULTCIukpleZn0VFq0sAQ0IEaxWk8bbc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 15:37:16.7274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1465741a-2b1a-41d5-708f-08d5932f757a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553705818183633?=
X-GMAIL-MSGID: =?utf-8?q?1596015135204302536?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24.03.2018 23:33, Vladimir Davydov wrote:
> On Wed, Mar 21, 2018 at 04:23:01PM +0300, Kirill Tkhai wrote:
>> To avoid further unneed calls of do_shrink_slab()
>> for shrinkers, which already do not have any charged
>> objects in a memcg, their bits have to be cleared.
>>
>> This patch introduces new return value SHRINK_EMPTY,
>> which will be used in case of there is no charged
>> objects in shrinker. We can't use 0 instead of that,
>> as a shrinker may return 0, when it has very small
>> amount of objects.
>>
>> To prevent race with parallel list lru add, we call
>> do_shrink_slab() once again, after the bit is cleared.
>> So, if there is a new object, we never miss it, and
>> the bit will be restored again.
>>
>> The below test shows significant performance growths
>> after using the patchset:
>>
>> $echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
>> $mkdir /sys/fs/cgroup/memory/ct
>> $echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
>> $for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i; echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs; mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file; done
>>
>> Then 4 drop_caches:
>> $time echo 3 > /proc/sys/vm/drop_caches
>>
>> Times of drop_caches:
>>
>> *Before (4 iterations)*
>> 0.00user 6.80system 0:06.82elapsed 99%CPU
>> 0.00user 4.61system 0:04.62elapsed 99%CPU
>> 0.00user 4.61system 0:04.61elapsed 99%CPU
>> 0.00user 4.61system 0:04.61elapsed 99%CPU
>>
>> *After (4 iterations)*
>> 0.00user 0.93system 0:00.94elapsed 99%CPU
>> 0.00user 0.00system 0:00.01elapsed 80%CPU
>> 0.00user 0.00system 0:00.01elapsed 80%CPU
>> 0.00user 0.00system 0:00.01elapsed 81%CPU
>>
>> 4.61s/0.01s = 461 times faster.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  fs/super.c               |    3 +++
>>  include/linux/shrinker.h |    1 +
>>  mm/vmscan.c              |   21 ++++++++++++++++++---
>>  mm/workingset.c          |    3 +++
>>  4 files changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>> index 24aeed1bc332..b23180deb928 100644
>> --- a/include/linux/shrinker.h
>> +++ b/include/linux/shrinker.h
>> @@ -34,6 +34,7 @@ struct shrink_control {
>>  };
>>  
>>  #define SHRINK_STOP (~0UL)
>> +#define SHRINK_EMPTY (~0UL - 1)
> 
> Please update the comment below accordingly.

Ok

>>  /*
>>   * A callback you can register to apply pressure to ageable caches.
>>   *
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index e1fd16bc7a9b..1fc05e8bde04 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -387,6 +387,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int nr)
>>  {
>>  	struct shrinkers_map *map = SHRINKERS_MAP(memcg);
>>  
>> +	smp_mb__before_atomic(); /* Pairs with mb in shrink_slab() */
> 
> I don't understand the purpose of this barrier. Please add a comment
> explaining why you need it.

Ok

>>  	set_bit(nr, map->map[nid]);
>>  }
>>  #else /* CONFIG_MEMCG && !CONFIG_SLOB */
>> @@ -568,8 +569,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>>  	long scanned = 0, next_deferred;
>>  
>>  	freeable = shrinker->count_objects(shrinker, shrinkctl);
>> -	if (freeable == 0)
>> -		return 0;
>> +	if (freeable == 0 || freeable == SHRINK_EMPTY)
>> +		return freeable;
>>  
>>  	/*
>>  	 * copy the current shrinker scan count into a local variable
>> @@ -708,6 +709,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>  #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
>>  	if (!memcg_kmem_enabled() || memcg) {
>>  		struct shrinkers_map *map;
>> +		unsigned long ret;
>>  		int i;
>>  
>>  		map = rcu_dereference_protected(SHRINKERS_MAP(memcg), true);
>> @@ -724,7 +726,20 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>  					clear_bit(i, map->map[nid]);
>>  					continue;
>>  				}
>> -				freed += do_shrink_slab(&sc, shrinker, priority);
>> +				if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>> +					sc.nid = 0;
> 
> Hmm, if my memory doesn't fail, in the previous patch you added a BUG_ON
> ensuring that a memcg-aware shrinker must also be numa-aware while here
> you still check it. Please remove the BUG_ON or remove this check.
> Better remove the BUG_ON, because a memcg-aware shrinker doesn't have to
> be numa-aware.

Really, we do not introduce new limitations, so it's need to just remove the BUG_ON.
Will do in v2.

> 
>> +				ret = do_shrink_slab(&sc, shrinker, priority);
>> +				if (ret == SHRINK_EMPTY) {
> 
> do_shrink_slab() is also called for memcg-unaware shrinkers, you should
> probably handle SHRINK_EMPTY there as well.

Ok, it looks like we just need to return 0 instead of SHRINK_EMPTY in such cases.
 
>> +					clear_bit(i, map->map[nid]);
>> +					/* pairs with mb in set_shrinker_bit() */
>> +					smp_mb__after_atomic();
>> +					ret = do_shrink_slab(&sc, shrinker, priority);
>> +					if (ret == SHRINK_EMPTY)
>> +						ret = 0;
>> +					else
>> +						set_bit(i, map->map[nid]);
> 
> Well, that's definitely a tricky part and hence needs a good comment.
> 
> Anyway, it would be great if we could simplify this part somehow.

Ok, I'll add some cleanup preparations for that.

>> +				}
>> +				freed += ret;
>>  
>>  				if (rwsem_is_contended(&shrinker_rwsem)) {
>>  					freed = freed ? : 1;

Thanks,
Kirill
