Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/XdiC1kAMbS7WthKWB2U5wXVZW/Wufe499iVEKEiwinGCSwvNOycM/+Bp0L+1nVz6oGqGF
ARC-Seal: i=1; a=rsa-sha256; t=1522233030; cv=none;
        d=google.com; s=arc-20160816;
        b=GwnWIDOEwY5fm49x0/aIXB0Fba+ChMKM4nj2hYaLy/HRgKjE7xE4qff+Mo9QBAcI7L
         wI1UIn/ImRSy51d9LNRyTEGrCdmkGoNBeZgnGfTsSwDPj3NZCPQTg8ORB96bCXqRQ+G1
         6htoYTT2CJSFniYyqtSyo235UQkXjxZl6GVjc1++kHGecHmHOb3ecI1aBXHW5NnH1qRo
         zDc3r6sYv0P+CCk1qXgJyH/WVXjvy1beeD/0u7OnDpRFZfDdUX47tmFG97Wl7VzfEtYk
         pUQC6JSezXQbUz2gEpFrnGQiSrFUNSHTXeLp84v5mfajkkWyfX6z6SfYzNPqLW1WPg75
         aalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=/gN5EBGZi4/44pW2YPjwDuflgAkGBcngl4I5Lz1c4e4=;
        b=fBbap4j8thnNGaChz9DX2SE+7D76cp7s216bU4gkvL9d0K1y7qqz7K3BRmcJ4RndeE
         LjHQGbeGgiBfyvMrST+ngUbrUKTYOWhRfC48ZJplo/RBp0TkZ2luiiioGd+SScCoEpYY
         0a1qNRcKZDHHVjPdbSYQqMV7oU/kBcL/EbBGPga7Rxkr17FHIqj7hIwqnUoDtBni/P1l
         YXL+yR07l3NXc+OGXjD+HIUMD/F/Sy3WilznG1Mx+74Ou3KEY4VklUAef9JkX7Eh65Mm
         KvHxRtmMmyX1ko5eo6B1jVwnSOviIq70cKPaVDQRcz1IbQzPhUm3804n9UNE9iotkwOO
         XGZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=MBrlfs46;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.139 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=MBrlfs46;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.139 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
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
 <0db2d93f-12cd-d703-fce7-4c3b8df5bc12@virtuozzo.com>
 <20180327091504.zcqvr3mkuznlgwux@esperanza>
 <5828e99c-74d2-6208-5ec2-3361899dd36a@virtuozzo.com>
 <20180327154828.udezpkwkwzcftnqn@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <635e8bdf-9280-c872-49c3-d3e293e1b332@virtuozzo.com>
Date: Wed, 28 Mar 2018 13:30:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327154828.udezpkwkwzcftnqn@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0127.eurprd05.prod.outlook.com
 (2603:10a6:7:28::14) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 781606ce-d404-4dc7-c64a-08d59496eaac
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:wE767EDEzyu0yva1qlzbsMLoMqTbSNuwcHMKJK33vy9oJWwiLty0wppk0UHHKUKza+mmYNNpuLHUWMfRBMrbJ3FXXC1060g/LW3iGXZoqRW16IiyAjJVTdvrT8VJJwLkAnC1fVxEKo5XoeMrVb4s76KqSHY1FTSuxoKnim38hz0GfhZg06eweWiO5w8MT+s7N1yhB8AiTBrPrMTit/8TbSdBBK/wimi8R2Bcz+T2vV8EHr4W1S8PCb3bLSUerzaK;25:LWtUw+WpAOg/ous9Lc4neXw7wtlD63ru+KEgckxRVrHOFINqcUFKkTJSPqc+HsVV/Gnphorgxj82kDJqUkOTYnoZQ1Z/WIX+94MP5HXPInSpU7MAG/zM8hzlOcgYjIMW4dQrhsQ7QvSxjzTbCd9+Ozh/e/B5dsM0RnCRDRppuO3ftyf/MaZdslD//LnAJwGKNIhbfcpX4mPmjbYSuiNK/3VlFn5UeU61HspObhOoQBxN/oI0K1VogTn5r3SvvL0dqTw/qcc4q+mB+qam9r1XaJdxxHoJC6RxASq3cZWyv7yce29vVkBwFIqWyCO6qjPxAsTbI98628ye+RtG9ZcBOg==;31:dskCzcsOjDfR0EP0VvQipVHBeDzx+ZCrxYvMJif/BbMckC6XGK4NZihh4PsLyPW3pkTDHGtTNZnZ97WU/WdZ4ZIBCJxmPJeUKHmCGI6aNWsQBM5Pnfpo5vBBVPvtugFa6odFeFwWWLQcmfAP0MqThSq7V2XfowsJhIFuryvx2lIRMq1VFhPRG1xtH790GT9/FCyAjMk4FpGJCuNn0Eaid/gaj7iu4Y/TFEOJUzgBQYY=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:pw2LGH4jlYfRd86e2u03SwAZgkwTWzByf+PBbekwqZQX/m+rq7XS4tqPl0msktb9jgETSiskKNaM4aCzUdYyAoNqw91niczoUOo7TzydqfNVotz5o0vZJnkQH1x1iQmhwpZe8U+IlyzahHI8WG4ESwAYpmArCTFj9D0Uy/9yacJtU0aICrhuN/Ai5R9A8ugeVU9CkDJ65JekzTnPRUiekVN9mFKe6fIivxT8zUf+5cASTRbr9AVgCGSF3gq4KoAFhk4Zd0VShJ7QJrgOrdorkIxB+GkRL8zexYJWB44J7Rj1PHJLHATCf78nTW8NMNh6F0ftrYaYJJsQA7G3b/qbAoHNp5A7Vuhi8BpVgmnkGuBkxh6VqMm/xy09bDlKRvJyjN07nFMeDeVHKbWfwUoO1E5pRQyj/SNokN7O0PdweEc9vJhNMYwLN084/uHwozVXNqz45F0UIxSmLgVEqvO1SvCVA9c5yAotVQaXSbuMCprFkuzUfMLl6Z0WfcKN3giJ;4:NmJ3NgO4Vyj5Am0zBQ0dnmwZfjWm6O8F9IDN6IAk5W9enJPvihG1/qPC7Go5tyzPrPZqd62VdtNeE+97OVMz5V/SW5BmTnWN7lbYNvZEXP7VANG5A/oaw6bhxc5kHgnaFdrJ8RuizmgmPE7mAlmuwoBPDFTs1g2Ajc2pJjqUijXrBsLSPW2ATCgpRBzKG0W18jB7J/FKAwfUQWkkS65WRhX2SC+kOoSBP+QCBrSLePD/gkmEQ5fShZvRj7f/76Z4++d1UBpKV+LoMpML55o4jFd9x0VDDfEqdi6BJleSM3++oWu4YD1oWsQN9ENqIFSo
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133997AF55E928049B1007B5CDA30@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39380400002)(346002)(376002)(396003)(39850400004)(189003)(199004)(52314003)(5660300001)(230700001)(6246003)(106356001)(65806001)(6486002)(66066001)(25786009)(229853002)(316002)(65826007)(65956001)(305945005)(47776003)(7736002)(476003)(53936002)(7416002)(11346002)(6916009)(2616005)(956004)(36756003)(478600001)(50466002)(64126003)(446003)(55236004)(8676002)(3846002)(8936002)(97736004)(6346003)(2906002)(68736007)(81166006)(81156014)(58126008)(16526019)(26005)(93886005)(4326008)(186003)(86362001)(6116002)(76176011)(52146003)(2486003)(52116002)(59450400001)(105586002)(77096007)(31696002)(53546011)(386003)(486005)(16576012)(39060400002)(486005)(31686004)(23676004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6QU5FUDBTeTYya2VPK0dYd3BCbjNrdk55?=
 =?utf-8?B?dXgvakcyTlBLRTVrQUMvUWVTTG5yUnVVQVEySXg0M0k1aWZsS01yTHloYnJV?=
 =?utf-8?B?WWR4ZXM5K2J2L2pwMm9obm9UQkkrU2RVdjl6cytmVUNJbkpNWTd4bkVsd3Za?=
 =?utf-8?B?RGxXdFcwQjRocUcxK3BCbzRpbitGRmp0ZjNDTGNSdEtVNVdEc0djSE96eitw?=
 =?utf-8?B?bGExaXhNelZoVVNETTk5RFBKdFhjeVlPOWw2ejRQQVQyWVpHbGJCZkwwQTdG?=
 =?utf-8?B?VUcxdW1RNnIyUHorZmVHUEVucGQxZ2x0TU52TkdkWVJBcE1ZZmtPZDJLdTJz?=
 =?utf-8?B?RzFDcE5Id1JUS2kveit0OGhPT0dZWStscG12MHJOeE5hOVkzdEpnYjBNK21B?=
 =?utf-8?B?UllBc1BaeFRoa0dyMnpidVI2L0hsS2xUNFFLazJ6L2NUUmpSb1I2VFRQWEJX?=
 =?utf-8?B?N25iNWkwTUYzVlF1Z1ZQeGR6SjRRU2hJSVRVM3ZiMWRITVpQNlZuZjMwNmV2?=
 =?utf-8?B?T1JDU1Vhd1lqNXUzV2x3dUlMRFhDenhUMklCV3hwWFNiVEVoU3VKbDRxc2NH?=
 =?utf-8?B?MzZITUtJMjBBb1psbE9HZGVVcVI4aDUweXkwRG1NcVI0L0hubTRkRm5LcHJI?=
 =?utf-8?B?a2RVaEpTaU5HNEFNbC9vYytZVXdNZ2lFVytnQlJnMmpHZ1Q0Mk1xV3BQRWY3?=
 =?utf-8?B?T3RucjU4Vld3bzVNaXhwdXk0WXVjbnpTNGFtaDdWTEpSbDIwb1puWXhzc2dO?=
 =?utf-8?B?SGFkc1B5bFZjTDJaMmNHZ2pDbXBJcGJFbVdhVnp3OXhTaVE2bHp2S3pjWWFz?=
 =?utf-8?B?N09YekRpRXpJU0Q3elhmSHBWMWhBTEhRUW13UEZVdEF6VEcxSFBSeC9md2hE?=
 =?utf-8?B?YndqQ0FHL1ozUHJZS3dtanZlbkRjUWhncFRoTnZQdnBwRXVwUkJvRGY2cHQx?=
 =?utf-8?B?b0Fud0NSeGx6TUNNdEdWdExSbUJ3MWZjbzFrdHVpMSsyOURRRklhQjN6RkJm?=
 =?utf-8?B?VkcrMFpsL0ZJemFiU0ttSW92NlAyOG9VVDlDWjBTQ3VSdHR0eERuaVhWOTRF?=
 =?utf-8?B?OTZNREhMbjNWTVJPbk43b2NZOFp6YjF3Q2dMY2JtVTlVYjh2dTFXVjJad3VP?=
 =?utf-8?B?dVVYQnNCd0gwR0JsRy9hVkJ5RjJMUlRvaVkzeVljVU9sTlhBUWYxMXdmL2dk?=
 =?utf-8?B?NVZidUMxS2lRU05qMVdVYUdJWmt2NTZKVTZLQ3NDSkxoRUQwbDZtR2g0dUlD?=
 =?utf-8?B?N3djSFg0SXczMVh6V092cFdtbXdRMHE3amtGRzVydmNuK0Evb3QyZGV3WDRF?=
 =?utf-8?B?cW4zZEs4bWI3Z1pnVEE5WFlwNys1ZWtqL1lPWVRMelczWUluQ1F6VmNMbkth?=
 =?utf-8?B?RmNnaFpzcXZ6TEVNQUhKcGdiclJwWVArVHhYN2VUT3hnYVVMR3oxVTExcm0w?=
 =?utf-8?B?K0hJMzRoVERDQXhJdGNGUUwyY2MveWszMEJnOE1ONGtVaVZCTXhBMkpSN0VB?=
 =?utf-8?B?bU16Y256K3oydG5HRk05LzBWNGtaSFVKajkxak5lUE5mVXZjOEhtSFN0MG5N?=
 =?utf-8?B?WGx4SFpzYVFFMllTK2VQYnRCeTV6QnZUcnJzckVyVHVubDVJOFdxbks0VU1J?=
 =?utf-8?B?NUR5K2t5dXl3eFVNQW1GMXpGdFJ3blluQmJSZzdjeFdMLy9ja24vWFE1eHFT?=
 =?utf-8?B?OGoySWFxYzJWK0FoV0lRekwyS3FnZCtHTnBCL0VycXUwcGY1MDdCSzBQcG9H?=
 =?utf-8?B?UU15R1ppWXNUdGQ0eDkyUisxZkFjSENCMjBEcG9xNVZIQ1dRaTdKMmgreVBQ?=
 =?utf-8?B?Y3IzWHFHbWJjNCtwaXVzUjEyZFhzNWdpbEptbjJqcDNyTkc0bklKcjVWM0F4?=
 =?utf-8?B?aldPbWNkZUlFTU9UbjMrc2FaNVdPMXFOUGZLb0Vzd1hrcVlmcHBOeWxkQlZj?=
 =?utf-8?B?c1hTQTdPUGdLQnRQZE1PeWJHckEyYTl2T08xS3ZWUWg4L1ZCQlFES3g4d3BH?=
 =?utf-8?B?TDQzeWZreWZ0WWM3ZjFKOVQyWFM5Z1dOYmZYZWN1TDgrOWVaNkxLZ05CT3JT?=
 =?utf-8?B?aG9kaHpyVnhjWHlYMmRqb2I0QWx0Q0VnTHQ3NERCVEcvaWJndzd5MWErdUU0?=
 =?utf-8?Q?sFUo0pNsq/BSiz/RmYwT5ZByg=3D?=
X-Microsoft-Antispam-Message-Info: FiJGVUJYsLMGt3PWn1tZJgKHfnNSE3PHGIcOlnXgtTLNjIqgJCqIaH2YOmoxvIuKfaJpK4nagpAwB+762u81ovJXEWA1O2sZkIJr9WUanljq/9y2aFBLpng4yXbsY0UXRBnrYB21bODGLDvFjsKa/D8w64EnYtHWo6wXkXO2m0wAc6xUYZ97Kxsp4x3dN9XW
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:lXQUrCmDaVpgJYNxfxkIeFYzlNWT9EQmhl2PLiy4AJIrH/CO6KBo0vYOPggu2wROjDm/hZLp+aSl5zSDouwNJ3Kor8gFHfj5xU3LB9nvv4ayj+Qp51TdyHnG8fCKsMDNLD5XPNQOjjyvHeHctJM8IAjyynhCO4Aj6qHEHyrulaL3ArnCIMCY5mSxVV3Cm26+63tWbNafnKB5UDtYHL3rVzmvWKb9E9ael/W1GFkTytawCUo4SxCwyVGJVMTQYHSDxSsL15yk5pppILjSk6o3XYCHTGgusbFj4p7bgujV9f0iPsKC5sa8be7MeE+kE0aIEbs7G7MynB4hvkMk0DTtEqpwtx54rg/XcfTAqoDfz2KyGzUsE5wSKR4ZWkin9yzEhWhyeUUB7J0lp6cQgESMCuq3RZB9AgwclyqrFPM2VoWdZ34i8rE8nEapxCho0AXXYoVNAvdddG/Fl25rqeuaSg==;5:mrwKRKQRLH4oIpztoU8Sj/O3hlqunK8p6x7TayRKG4Qgm0qRFLwM4atXQf+SMRjYr0GE617fDa/kw9pBbhrqL39ZxY5yrFKvhYqFNxcRp2j3PCuHLmrSW7jHlN46BB4Pr3V3ap4DoBkERlmInXAYxvrTxe6Q4RlNAi3bQORNLB4=;24:/1XzLqge9k+sNthIMoY3LZBg0cr/eE6Yj5NZCNVxXF0YQerV90F9Ak3plTAcBCGwm0HNuYFbJd5pgQ3pMS3IuE8Nq36ulYVCPNAKVt4jSYc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:K94CWhrGgYFvtSmTiXKjyFLrQSQKrhC2FeGWT1n5c+kpU/6TBzhD8nKYOoE9D3Yn5cz2F/DlYcSNNHagnVIUlqter2LZElHG8CBG/cH7rjAGFisL0St4HxeZha4xYaXM8Ra8ehd+opqFhQ7DECE7RyvX7jjI3tqgeTEnNvKGcubdrcD+I/AKVaVbtiCy4/Xiy/8Mutsy1UPQmG4HjXQOp+iDMT8hTtX9IUO8zI20siv8xBZebOMEWEhFbKHgQVCP;20:+yhOGuLwrwRvYrckCAdTzFd+37DD+dhNidb4rmJkt9Mhf1vjFnhvVoTymh000gqdJtBqHn2/hanYOn5PIqn1+qUxUCOA8l6gMoeUT+SGuwet7CXQEpuKEo6+RkUK5b8QYvzYe3XkyEKqjhpL/inAaTDcG+aRksqvSyIURORe2m8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 10:30:23.3020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781606ce-d404-4dc7-c64a-08d59496eaac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553598792007322?=
X-GMAIL-MSGID: =?utf-8?q?1596177022056665035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 27.03.2018 18:48, Vladimir Davydov wrote:
> On Tue, Mar 27, 2018 at 06:09:20PM +0300, Kirill Tkhai wrote:
>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>> index 8fcd9f8d7390..91b5120b924f 100644
>>>>>> --- a/mm/vmscan.c
>>>>>> +++ b/mm/vmscan.c
>>>>>> @@ -159,6 +159,56 @@ unsigned long vm_total_pages;
>>>>>>  static LIST_HEAD(shrinker_list);
>>>>>>  static DECLARE_RWSEM(shrinker_rwsem);
>>>>>>  
>>>>>> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
>>>>>> +static DEFINE_IDA(bitmap_id_ida);
>>>>>> +static DECLARE_RWSEM(bitmap_rwsem);
>>>>>
>>>>> Can't we reuse shrinker_rwsem for protecting the ida?
>>>>
>>>> I think it won't be better, since we allocate memory under this semaphore.
>>>> After we use shrinker_rwsem, we'll have to allocate the memory with GFP_ATOMIC,
>>>> which does not seems good. Currently, the patchset makes shrinker_rwsem be taken
>>>> for a small time, just to assign already allocated memory to maps.
>>>
>>> AFAIR it's OK to sleep under an rwsem so GFP_ATOMIC wouldn't be
>>> necessary. Anyway, we only need to allocate memory when we extend
>>> shrinker bitmaps, which is rare. In fact, there can only be a limited
>>> number of such calls, as we never shrink these bitmaps (which is fine
>>> by me).
>>
>> We take bitmap_rwsem for writing to expand shrinkers maps. If we replace
>> it with shrinker_rwsem and the memory allocation get into reclaim, there
>> will be deadlock.
> 
> Hmm, AFAICS we use down_read_trylock() in shrink_slab() so no deadlock
> would be possible. We wouldn't be able to reclaim slabs though, that's
> true, but I don't think it would be a problem for small allocations.
> 
> That's how I see this. We use shrinker_rwsem to protect IDR mapping
> shrink_id => shrinker (I still insist on IDR). It may allocate, but the
> allocation size is going to be fairly small so it's OK that we don't
> call shrinkers there. After we allocated a shrinker ID, we release
> shrinker_rwsem and call mem_cgroup_grow_shrinker_map (or whatever it
> will be called), which checks if per-memcg shrinker bitmaps need growing
> and if they do it takes its own mutex used exclusively for protecting
> the bitmaps and reallocates the bitmaps (we will need the mutex anyway
> to synchronize css_online vs shrinker bitmap reallocation as the
> shrinker_rwsem is private to vmscan.c and we don't want to export it
> to memcontrol.c).

But what the profit of prohibiting reclaim during shrinker id allocation?
In case of this is a IDR, it still may require 1 page, and still may get
in after fast reclaim. If we prohibit reclaim, we'll fail to register
the shrinker.

It's not a rare situation, when all the memory is occupied by page cache.
So, we will fail to mount something in some situation.

What the advantages do we have to be more significant, than this disadvantage?

Kirill
