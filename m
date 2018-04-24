Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZq81rcsebIhcY6MMObIC+wQBiPZRdXJOsJEIR8hBeUnSapJTSelXwIJXquqkpV5YHDe8/i4
ARC-Seal: i=1; a=rsa-sha256; t=1524572048; cv=none;
        d=google.com; s=arc-20160816;
        b=ywa9pLUl3jK7KhScQt3/ECDbwYcigh3vNld9EWeiB/p8ZyLU6vhFLsSXD/bnQSVOd/
         fM2JRSIgIZglsCABQKczckB2nC7xt6h+vnxigHZLDTxC+n7RoDAyGoaRMhu/fAiISPoz
         db9YxfqfzY4iHh2Bi9QxGMCgAQa1mdSuhyrTLddtOIemqrpD2eDkBr2X1kZa/iAbxcr3
         DfOpextxGvNXNXIZDAk1PZqX8Xf0nUNeGlKpTq3hi6W9psSw8jShNsSm2W+1LQTNNKnK
         SJCB72+N5fBFZSwtOx4CEub48nd5Qxoq1M8GX2xTpzfgoMBteWpfgBFFG9ww8wPZ743N
         O5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=2gtB19LJO2gXvm7L0XIo+0aOPOuAv+r+hfdVx/DDtK8=;
        b=xdWa7+O32an5UWAl5OsGHJUca2R5/Xlu72GVsjyuNtMw4eG/gn915foJzSyVoDokvE
         MgE5OuEdg5kaahCWpx5mUC7SxQhZ7NMu74JdFD3jZfZmZsEPI6szxnHUW8FLBSlSqCDQ
         BAk4eo1yV7XnqwvXdHgjFo/ixoVFR6NhwsPmNrlagyQ2gvTKslmrJ0VEBMj+2mQNpPtI
         vcJGzoehOZ6JIUXjswn1SLtwPJBSQWWfA9J8eDPO65/AGEHBWNm7sKjZmJ5AhkB5W7po
         lq6L4BDXWPM8zZQ0y/TD6bx8JeJaPWq5sRtlNqWJw32yhWkaHEPWazJZnEVHT451eUb3
         ufMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=X36zv1kJ;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.96 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=X36zv1kJ;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.96 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v2 04/12] mm: Assign memcg-aware shrinkers bitmap to memcg
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399121146.3456.5459546288565589098.stgit@localhost.localdomain>
 <20180422175900.dsjmm7gt2nsqj3er@esperanza>
 <14ebcccf-3ea8-59f4-d7ea-793aaba632c0@virtuozzo.com>
 <20180424112844.626madzs4cwoz5gh@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <7ea19fc4-f8a0-bf3a-8786-9d77e88cd049@virtuozzo.com>
Date: Tue, 24 Apr 2018 15:13:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424112844.626madzs4cwoz5gh@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0401CA0077.eurprd04.prod.outlook.com
 (2603:10a6:3:19::45) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:GFQxMSk8XM2K6D2vBv0nOb6qJBUEt28ZqbZ3B2dQhdZ7gdSKuCVL6TaUE7Wg32KnnFyjshLhezrd3bB9xn/oWvp4yTu0tAUA2EAicAYD0e8WDLRefdAAKGKlQnwHlxtmDbHUBEcKoSaC0XorFr5zdzl4Wz+ZQYCdyO90RiNFN7NPo+ihTyFVC4IP+6bkuNZ9iFHVUgmyEiX2I6vx/N+dgDE2A/llF7yPTxjDOiFPEPLIwPhdofNZBtIl1gGgE9MT;25:qZaQH4QRNydDjyGLTCKyvSvVnMal2HUYusJn++g/CFV1WqX397cFc8BM/4Pka9Zj4miM/Y8yy+YsZJlDzEaMZKNblfbkymmBi2hDiFUrAf4vtWLtmexjHLZZBN4J+8jMvqQwWWpxfTznizdA0XPb89bmma/8uTlk3y9t6YzzM2GfPRzYSDbh6cXssRMkK9/eTAsSS2wuXCqHds4h8QyXlAkp2r518GL80EpcAq3jVkdTpdINqM1lcT1Q9IxOWFZ4/CBmVXV1SH0s8whdbTq1F5S3xHeNttUmDXiVuj4O7ENVz5RPbEkDCfd2UWNKbFrdqLCoTnn+FhHFr7uJsBjNCw==;31:oq03SU3cW+6XQ+VSfXbB4VIXh+HwYPjEYAi/pmdT4bDFXjGrdULilmSd0J44/QiCa6en2RiynFx3r62OqkPa89+uKn4GGkl9pHsVc0YZy+zMPvJTxni5aOhOuqWx5QNr4se6hRm9/bnDdUXhwnGtqx200d5Sjcc2qKWkTXfT/BpVZUUDRe8on1XD9DzXMU08h4UfuV3cL3Ma4rjvCi/EqeHgbLLWDNxty1QpyrUIBW0=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:ExN0OFWuvjdL0A4n4kLvllN8Al7yzT2nGYHMoMReAXiBsEyQWn3EhQ7RN0307ns3OKVERRKxIK0iLD8ofCOsKVM7jLboPq8pWbXJCC1lAH3GmQNSNeG7X7r/bxg6/pyW2h6kgX+X4vfUFT5CB/QMJduYWf3FqP6zffuK3/PDkHu1nkR/hea5F/571w0IXyRk9C+nWacO1Dvn9Bsb3Q43u7RGpnHWJmtmrwrM0wpK152MQ/lnXvNL9ivSXPEQdaLV3yw6860KWWSR8HLRN2lsrFQZ4IAvXSeNjDHHmWrljEiIdxO0O0/ER34IcabDZDyfw8LehT50slNnodO6f+9c/z+wxv2Uqv3lxgS8C/c0tlAEaIrNMXczcYVlRX8y9xl5XG3uwklOK5OyOpyUAUxNvG7ItLFIzp00qzN3LImWVisQG5XOzBIHGceGxGeuFqNxF2zhD2KS23vroPlXaD1xCy0op2DX7k6jNmqut0j+azyTA2gFe7FBbB5etGqeh7Q2;4:NUwheyJ69GaG9AM+98hUhwj5KQgn/eY9Ip0H4Ye3/rIAQF0N7u3+8QJbnYSaAQhP4NF0dfjVP95h1JBz2IG08KlXLoTH2xDgsjABfl29L0/OQE2Hxs9iqCfKO0qHRZ06WHoIoqF+fO4HXlg6itozFGGjtlNSv8Db4L9NAySTYLmqGyEwN6rh+7J5oA2fUW4XG0beFNxoRGOv4wCGMsffkj12DxVIE9WS5I+89qbYDr1kEQyh5hb8OKwKTl9kIZ/yITMiTmt5uPT+F7zcg7M0aQ==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB134131F7B13879A3B26BE434CD880@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501410)(52105095)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(39380400002)(39850400004)(396003)(346002)(189003)(199004)(305945005)(52146003)(23676004)(8676002)(2486003)(105586002)(53936002)(106356001)(107886003)(31686004)(81156014)(81166006)(6246003)(66066001)(65806001)(65956001)(47776003)(59450400001)(93886005)(76176011)(16526019)(386003)(2906002)(39060400002)(52116002)(4326008)(6116002)(3846002)(6916009)(6666003)(65826007)(230700001)(5660300001)(53546011)(50466002)(478600001)(229853002)(6486002)(68736007)(7416002)(25786009)(8936002)(36756003)(97736004)(11346002)(7736002)(2616005)(64126003)(58126008)(446003)(86362001)(77096007)(16576012)(486006)(316002)(476003)(31696002)(956004)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6bnJ5Q3JvU2RCOHppWWI3WVlIdWNzQTNX?=
 =?utf-8?B?d0pDNXRHeGZJdmd6VytNNTVwNEdMWDVUWC95MTNabU1iWEE1b2prcGJoMzhE?=
 =?utf-8?B?VmtxSjJyV0JVZURIOW94Vy9LTzhTYXUyYlNrYWVDS2duUDg5Unh5V2JxdmNF?=
 =?utf-8?B?NG54M3Q5dE9tcG8wd2YxQ1BlT2l4ZnNzSzUySFZybTczSndhWnJPTjlkcTh6?=
 =?utf-8?B?ZXpndzFpb2xjNG5JVlAxbThGczVKeFBsYmpwZUYxbWVYUElPZ2tEdlZLVmVL?=
 =?utf-8?B?MjNzOThnaGFoRmhIZWVHa3pSK1o1V1NQL0g4TENsWGVQM2hYQzg2VGxwZkZG?=
 =?utf-8?B?V1JldHhpYTdlcGdqRnE3RTdRZFNpQ3dydE1Gdm8rUGpJckZ2anBSalpnYUNq?=
 =?utf-8?B?VmpUNXljMGg5cGxXMzJESVJUQUZJN0ROUk9vTC9MdFRHNjh5UWN6NnhLeTFv?=
 =?utf-8?B?bml6ejA4L01tMTVDZURYUnFEZmdNT1dZZzNNWDJreHI5SWxieHpVdUJQdGJ3?=
 =?utf-8?B?dG5nUmE3V282aytWNjBCSVBidytCSDZjMi9SRDBPcWtJRDBFZ2dNRmpvSHBQ?=
 =?utf-8?B?YU0wVGhIam9xYnhIUW1JN2ZBOEttQkdIa25FanJRd0NzbWxPdlh6U3VFaTdF?=
 =?utf-8?B?Y0RXNWFKV3VaWjNYVkQ1NFF2M2ZGZkdjZUxrOW0vNDQ5dmZwTzdFSmZjb1Jl?=
 =?utf-8?B?aTcyVGRoK3Rra0ZqSkN5YVNScm9GcHd6UC94K0htczkwM2xaNGlpQmlmRkJK?=
 =?utf-8?B?Nlg1NU1yWVBtMlBYQXpYOVl5aHFBbUpZNEkwb0dZRCtPT1kyUFplWlIwczJq?=
 =?utf-8?B?MXBGRnlXc3J1LzZBVUdzbWVLOW5nT0JkcVB0T2cyOVhGNWRxTUJDT3dpOUZu?=
 =?utf-8?B?cnhUMlVSWkF2NjhWUXFoUGQ4bHVESlVVbUMyOEVVM2lzNmFaN3FFUG8zQi9p?=
 =?utf-8?B?YzJDZ2tvOEl3VjN4V2VSaFVCay9tTzYyc3Z2SzZEekY0SkIvM1ovczZ3SmxY?=
 =?utf-8?B?bTVxMVk4cTQzYytTN2JlSjd3amMreWtiRCs0ZWZlZ1YwMzQwbnllSEpENzJJ?=
 =?utf-8?B?c215N0tieHZhTVpIK3BPNHl2VkVHMWptRmh6VzJxNGJXdWVscXVoVEgvR2Ex?=
 =?utf-8?B?T1VnNXpyYk8vWURhS3Nyb2RKNElrQVltM1Y0ZnNRWjhvdWU2andrdWVZQmp6?=
 =?utf-8?B?di9EQlVRZEV2Z0NmVGRrVUJVWjNaVFkxL2RLclQybTRHdVZMZHlQSEMxSVhJ?=
 =?utf-8?B?dmhQcWQzVkx4YzdJM2E0RWRkcUM1QU15Tnp6NjFZWER4Q0JPUjdZZG1rcVFk?=
 =?utf-8?B?SFNsNXV5U1UyQXdGVWdMTnB3RFdKSEs4cmp5QVJSRXgybVBUV09CbDZ0c0hr?=
 =?utf-8?B?all4SnpFQmh2R2VQWEJGczI0UjZDZyt2UUVTTlN3ZVJ6SENNZldOdGk1RDdK?=
 =?utf-8?B?QytTZ3hDSENuOE9DelE1STVuRWFhTGNvdEhOelRiUHRaL3ZqQS8ra254b3lJ?=
 =?utf-8?B?SEpIWWhjckxKMVdBTXpJNnJBSnpRL05vUmZzdEUrTlRleHNTakU1MVR4aHBw?=
 =?utf-8?B?WkxrTDVmS3d2Y3B3WXNuTkRydi9JNjVWd3doazEzOVlGcW9FWVlvUDlUanls?=
 =?utf-8?B?ZFZwT1ZhWmxqTXFMdW1iMGdxcWFXV3Z0RUIwS1FadkluSHU0d3BhTE4rbkRz?=
 =?utf-8?B?Z1piQjJNY1pDQU42NTVoT0ZaY0s1TldSMFYwelFVMHViQ0hwU1hSN2xyanoz?=
 =?utf-8?B?NmNjR0trbWt6YVo1bVJZS2NlY1N2OHAzR0tpVkpUeXMzVEZaUHFQOVQ0VHVK?=
 =?utf-8?B?YndWWWZzTk5tMC9SVndGWTZrRDEwVzlkbUQzc3FZSDZ0cXVXeVpDWFFTQkVi?=
 =?utf-8?B?VS9abWNWVkpSOWVzMXIwZzdUM2dIZjFjK3NZR2FzeEVRT2dFdEw2UGJxRGpP?=
 =?utf-8?B?aVdoL091Q29IYlJBaXd5aDBzMTNVNWkvMFdWbG10VHkzdy9vMVZ0elN4d0hz?=
 =?utf-8?B?VW0xUkVNWGd3amYycEtOb25NUFFGb1pKZmN6WE9OTkp1WjB5OVg0bGJLeGJZ?=
 =?utf-8?Q?79lCtk=3D?=
X-Microsoft-Antispam-Message-Info: TbO/3/qAepuNB8DuYfhLJCiSix6VfQUub+OAC2nU0iM2jaOL/9qH8ziF9geIfbE+fubKt31Z6WoN0PuEluOhdMBp3nQvGV7jJQaY8cnSt6AawDgcGVMHj/2c/L4554zJB9xzXDKTyCg/IeER9IsqVMtJVyWd5oVxn8uffY8cho3Z5lt/D1a7QpI37FRtGz54
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:aoeUXOrZ+o1cfITi3o1dZzQ0j0rbpV5mGHs963CRvu4+Dp6OD2tqhLK4pX+rnC7d3xuRvykm38CQioQYASz4Ky1pCv+XScF8PlWDSduT9jsfweACJ9owtSo2ZyPQLpaorSzOiEBS2rvi1XsZ0XCjK3hScD7ewJC2LiQelXzvsLG6XOpV4COdW4wNqk3QIsyUxv9PDDYSFMZiAWtIrhdB3JImd6MtLGlTQ0p0MIDW3CuneYlH+yTTcA1uXvZBzB9K+uMW5CYc8SsVVyLXNB4bK5qnh1bxoh4hrQEV44uuYzZ5TpApew+1SxNxpY/aXc4b9ZNVtaQFrqfK0v7WsjEiLaNr4HrX3BiZ3lGmRabv0o0wspPe2M7IG7LKXghrqdIQW/q6K0l1KlLlzw8r/2GYNHEovVdCU/jKiZUACwmHVDu5sRSJRiWkGUdp8lnG4luQQWQ/ja5hdPRQ+sGkb++C7w==;5:ivWBJM3zKrMgg/oNLKDQuQIAEBuwnCh6RvtevYX2sfsF12pV0i51hUX6ZQ0ej4DbfCvNk16dEO32ec408EPjnvjs0IHK8Ufg8EfpSwWf3QoPcOmRT+DxRgYuJ7lOePF+X98ds7Fbzkry8F+kBFrtWo9/+RN7dY6xuwCvVr0I0y4=;24:fYuvIdEFQlOCBuJR0DEaRSb1DighIBDxCCo2mpUbC5/0rxwpebQTydslkevAAhdW1jSgGuBWEkyuQP4yZ1XWwVO1sD6l8tlcvZTwlOAf+QI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:t+f2VH6/11+ZWMuIR04NritTIiMFzeAFJrX+p611IDB4GjeL07lVTb3+nv14jxpuPYp9U7ic7e4sro4FrFvWmEMWpBRoKDZIAOwfrZpkFMAfE9iF3X8ffzGUYb1SJ00ofqcA2JkG1szXLYjU3YGjvvvZS7tll70Nyz8XJcyXLf9LaVkjDuu2ZB2YZZRDms3INxNUmAiQh+wPfKCoC5U0IdjjXe8ywDvyhMrnkf12Iuv6w7MlrSxQqlB5EpBkjRYV;20:/0ErWfzQyECDQLr+hUTwZPl2vncB1kHKGgE/zOCbYijqF6bX9v3UMjoV+WRCwgDseIOSy9wOAHDuMkmPAXiEXS3B7tr3T9PeeLQxekL/YvyloCWsCdrHycuEPx4kqRRimlQi7iufz/ONz/ZzFU4Z77ZVdWx+qG4vo1kpxEez1ak=
X-MS-Office365-Filtering-Correlation-Id: fe42e59e-aba9-4ce9-607a-08d5a9dcde6f
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:14:01.3157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe42e59e-aba9-4ce9-607a-08d5a9dcde6f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1598629661006446542?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Let's discuss on code with changes after your commits to v2 to have them made visible.
v3 is on the way

Kirill

On 24.04.2018 14:28, Vladimir Davydov wrote:
> On Mon, Apr 23, 2018 at 01:54:50PM +0300, Kirill Tkhai wrote:
>>>> @@ -1200,6 +1206,8 @@ extern int memcg_nr_cache_ids;
>>>>  void memcg_get_cache_ids(void);
>>>>  void memcg_put_cache_ids(void);
>>>>  
>>>> +extern int shrinkers_max_nr;
>>>> +
>>>
>>> memcg_shrinker_id_max?
>>
>> memcg_shrinker_id_max sounds like an includive value, doesn't it?
>> While shrinker->id < shrinker_max_nr.
>>
>> Let's better use memcg_shrinker_nr_max.
> 
> or memcg_nr_shrinker_ids (to match memcg_nr_cache_ids), not sure...
> 
> Come to think of it, this variable is kinda awkward: it is defined in
> vmscan.c but declared in memcontrol.h; it is used by vmscan.c for max
> shrinker id and by memcontrol.c for shrinker map capacity. Just a raw
> idea: what about splitting it in two: one is private to vmscan.c, used
> as max id, say we call it shrinker_id_max; the other is defined in
> memcontrol.c and is used for shrinker map capacity, say we call it
> memcg_shrinker_map_capacity. What do you think?
> 
>>>> +int expand_shrinker_maps(int old_nr, int nr)
>>>> +{
>>>> +	int id, size, old_size, node, ret;
>>>> +	struct mem_cgroup *memcg;
>>>> +
>>>> +	old_size = old_nr / BITS_PER_BYTE;
>>>> +	size = nr / BITS_PER_BYTE;
>>>> +
>>>> +	down_write(&shrinkers_max_nr_rwsem);
>>>> +	for_each_node(node) {
>>>
>>> Iterating over cgroups first, numa nodes second seems like a better idea
>>> to me. I think you should fold for_each_node in memcg_expand_maps.
>>>
>>>> +		idr_for_each_entry(&mem_cgroup_idr, memcg, id) {
>>>
>>> Iterating over mem_cgroup_idr looks strange. Why don't you use
>>> for_each_mem_cgroup?
>>
>> We want to allocate shrinkers maps in mem_cgroup_css_alloc(), since
>> mem_cgroup_css_online() mustn't fail (it's a requirement of currently
>> existing design of memcg_cgroup::id).
>>
>> A new memcg is added to parent's list between two of these calls:
>>
>> css_create()
>>   ss->css_alloc()
>>   list_add_tail_rcu(&css->sibling, &parent_css->children)
>>   ss->css_online()
>>
>> for_each_mem_cgroup() does not see allocated, but not linked children.
> 
> Why don't we move shrinker map allocation to css_online then?
> 
>>  
>>>> +			if (id == 1)
>>>> +				memcg = NULL;
>>>> +			ret = memcg_expand_maps(memcg, node, size, old_size);
>>>> +			if (ret)
>>>> +				goto unlock;
>>>> +		}
>>>> +
>>>> +		/* root_mem_cgroup is not initialized yet */
>>>> +		if (id == 0)
>>>> +			ret = memcg_expand_maps(NULL, node, size, old_size);
>>>> +	}
>>>> +unlock:
>>>> +	up_write(&shrinkers_max_nr_rwsem);
>>>> +	return ret;
>>>> +}
