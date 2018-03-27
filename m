Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELvUcN9ALRr8mrFa7jLRt5z6aVA3Q6qEWTcBcJesaNtED2/U0Bycy4eTk0lYO8hTr9exWtJ9
ARC-Seal: i=1; a=rsa-sha256; t=1522164638; cv=none;
        d=google.com; s=arc-20160816;
        b=JDUOL+U+rrTx5VUYI01ldMY/brnQxuNNBGrM+SeqQsQkQrR8vb/7x7ibh76e3LN4Nu
         x/uRuZ5OJbEOzqWcA9ZbpTLMqcj3E5o/lDCd+cGFooyPDmJj04p/8j4xrQf7TdraXjJ0
         7t+Qi7GEM1UwEBjczcZxvxTwizIvhCA/C6Smb+R6YJk76xYgwWP6FX22aPEqoc1fYoxU
         2n1FjUx2H8XA6Q6RiaiNXdZ1eMEmlcbA1xKzsntIoBqxq+zvX92+0tFr6uU8Cnxb8MvA
         ROq7ao+RSKeWD1rUB3wdcMjnQhZTH42cvP7hBO3v16gI3Pi2n+5xeqnlfq4lbhdcm9pC
         jsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=aISgJno409fgMPKdDfB69myioIuC44L442OTTiFPGvM=;
        b=ud2535jhK1RFVgXDJ1tU6k6e48WO2lGo7Nn15TJOEJveh3nTTmCPrRKSwErkLnoU5l
         BCfikzRpjiP8X9MPLGhI5X8/3Istz9rU47ZvQhWWcDi2o1MDaOBFICJntEv7AryARGhx
         EzDfit4S155s63QVru63U5GEza19JwTcWjOhvm69CIhZWWRycByIRL4GkOjIbprXffDl
         qwtfI9nPD1pjUPGlz0UsvwMc4Wp+Up9WCpr8PMFiwxeoVCXzkMf9dmeTb9FGuFDtlcPZ
         u7jbF34NUtW8DhaOL42p052nwrW0wnjKXGxkOn8NEeoL3XD3Cs4k/8T3UMpBlKbeksrc
         /FLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=PyPjkaSQ;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.121 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=PyPjkaSQ;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.121 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 02/10] mm: Maintain memcg-aware shrinkers in mcg_shrinkers
 array
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
 <152163848990.21546.2153496613786165374.stgit@localhost.localdomain>
 <20180324184516.rogvydnnupr7ah2l@esperanza>
 <448bb904-a861-c2ae-0d3f-427e6a26f61e@virtuozzo.com>
 <20180327091850.ybql6l6gavhdieqg@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6660e4c1-7a52-9203-e901-fc87be328c8b@virtuozzo.com>
Date: Tue, 27 Mar 2018 18:30:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327091850.ybql6l6gavhdieqg@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0038.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::27) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c169283-fab6-420a-da2f-08d593f7addc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:PJ7+0CZX5jlSvDwBix90L4YLAvOYdFvTAIwa2E2BxLXbffB6YecU2Xvcg8JBfGS5tTR8pLMjR2rqL7fMJxykfkhxIS94Inq39tT9yErEUJ7Bwlxu8oRTL8QGCHWlMolgODLtkYLb3d/1bQE28rJKzPn22PSWwBMSuACk8zSqrUKwN/Y6qlas0TmOiX0k6KGT1+DkIP3PTX+tHRxaKopeSLWhUiof6LTEHUHnigChTDCJbSE15FR6amncuREWyfGY;25:4hhLbo3C3ssg1fgb8Sx7W5/AEjify0YB5IW6OAbaLTR9wDkN9sdXeZ0JLOqBqhYWAprE7snw7MlAlus+8AyYsw3mI3GKFSCeopraibZbXfFztiVI7L9weyj8EghD4tQQvzOXedY4X5CG53PweM1gQogxCcONMHqyD6aiMVSFHOXa6YfP/eG3NPFmVvWlZP1W/769MFgLXTB+BCQzUwcCtgC7ZVYAxT7n2BRBjY2/puM46HZXilZSXwzndcXiqMi1e36qwwSByfYjTk+c+vIFiWoPeg1dojCe8j+CoeCHyjTnyM4giNzWOkRho8YznIdHrlESy5wzWJz+WBLSalk9qw==;31:K5i3LBUP6aFrdZgrMKZD5QNEReMyBlIVkV9Vl11nyGZVOmKp0YUk4lmKM/0+XzUv3YPvHhrAaXTy3t3Tq32onfdkS28ke4UGUK2m1TsuXNzFXdAbkL+fLo8gqffASJbClb7YMkXD4AH7DjggAPK/bMuQP2xfD4aX4IVwqcQNlTX1SXeJ8japVzYeoum9ReQriEDScUxz9dmkvUYo2k81IjGHoblMzeM+7F18cFrVyFU=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:eIkpWiatIky4ABM34j8kYc+Jinj0dnp1FgxHfH2dVTAboCIpBQA3r8AJ7yqFnos7AKgcebDDwjIigz1PxbT+sQBRKO14T08PFpY4CBIRdnNI+TA+K3z6cL6nZnNmzM9M77JvD/OcIRT6jq++ZY/TA//Uv3cC2U3blmHEX/aCue1/y/l6yDkNk/nPZCZEfpqAz6aetSz6k3ZTLzyPPuLJN0OI6nvJXBxZ8SkOw/mo5o6/C8bPubvm2NWiNsYeHwbWG9HkPh1kWugn8+S9iBQDeLAist392bBj2Tn6OtIjU/j4RLgBs5/EQKtltFzsKb6H6H3LMqHdO23gWaqRc/urt34cpxYORNY4klQkm4FoJxIcLAFA44IjiuNVyPseua4yOoUiVG0k+mpPIS8LVi7WUnPNN/Ej6iQq3Vvka5bwbEfkQNlCO73SWdVklBQW7uUmj302NNY2O4UDW3eabpuJhCccXeXaKG65hKYJv/j2AFNWoMwZfshPHDv1vBOxYExA;4:g15rwaJJ/NhC7zvBuPA5wJ84cyq7ZofoClkEdU7ErLNrJGdSZJuXpbZaKYIMUoafUXRySttkjW7QdmtVpDilaixox6h82iZI9w+NB4SQQysXoTB8piEIsge3GKVjWyNY1RBW4cTDJhUOHqE9cgRlKjCzWtHDdlytnlPMczgBvutw7j+gRJ7Yn2rlWTXC9sSJbzuF3vPMWuvQ3qQiB/4eDC8kgNCfzvBx2SQOOezVX5tySXwdKaJmya+dC6VS77H5LeYWYZR895mvOroly5mQTg==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1341678543977F53F539B569CDAC0@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(376002)(346002)(366004)(39850400004)(39380400002)(189003)(199004)(47776003)(105586002)(25786009)(2486003)(23676004)(76176011)(52116002)(52146003)(97736004)(68736007)(64126003)(229853002)(50466002)(31696002)(4326008)(39060400002)(53546011)(55236004)(2616005)(956004)(386003)(486005)(486005)(6246003)(446003)(2906002)(26005)(186003)(11346002)(86362001)(59450400001)(16526019)(77096007)(3846002)(36756003)(6116002)(7736002)(93886005)(106356001)(305945005)(65806001)(6916009)(66066001)(58126008)(16576012)(478600001)(81166006)(230700001)(6486002)(6666003)(65826007)(5660300001)(31686004)(7416002)(8936002)(53936002)(476003)(8676002)(65956001)(81156014)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6OGQvQkplSEttMHBoWlVlYjhVV2hYNysy?=
 =?utf-8?B?b2QrYm1vNlJNOHpDYzgyUWdjQkIzaTRvL1d1T1NEQ3FiZVNZYnpsNXAyZzh2?=
 =?utf-8?B?VjFuRnl6QU1xTFBIQUc0RW5zb2dRRFEwVXZrOGtBd1dIOHdpZ1hjMUsyM3hR?=
 =?utf-8?B?QmxRME1sUTZSeVhHMFMvUVVMTC9KczA2QnNZMWJVdngvN3dLc2I4SXpWbkpE?=
 =?utf-8?B?OFE2WU9NbGlsWkJxWndZR0hvc1RqY1FwL3pYenBLNkp1TEt4OXhEVUphZEdL?=
 =?utf-8?B?cGFwekhldnVyMHFsaVpscTZhZTV3dmlYNkdGM2IrVUluWWUwblQwWU1ZZHFl?=
 =?utf-8?B?R3lISVhLNktlZXhkMzFCSjUvOHJMWnl2S0NyYTFPOHI1VnpBL05pZHI0V3BN?=
 =?utf-8?B?QmxMS3ZPMDNDck15cWhTczlUeUVSWkFGRGErY3dyNi9PaXpHd082ZU9XdG5L?=
 =?utf-8?B?eThIRlJ1T2s2elk4SzBUMG53NklkcmZnSlhub1lTUGNCK0k1cDZMNXVnMWp4?=
 =?utf-8?B?dmFYUTNZWDVBaGYzaDZCaWpKZlJOeVltN0JrYUNidmJySGwrSjZyYmxDblFH?=
 =?utf-8?B?UmJCWGxWQXR1dVAreE81MC9yUGdoaWVUQ3VrVzc0RUJPSkJlTlpvZlh0Y1FJ?=
 =?utf-8?B?R2hCdW15SmluL2NrcERXNmd6anp4TWI5NjI1Lys3MGh6VG5IZTNjWjN6MC9H?=
 =?utf-8?B?cjlIaHZUMWUxdDA1bmdqVzNjMVVqUTZia2VmZTZXOHJMeFpyYUFnMzkxTVhh?=
 =?utf-8?B?Wmd3aG9GS2tRMFBPSXRBSzhGR0lNcHRmR2R2UXJ6MzdQc3IvVUhoejVWUTl1?=
 =?utf-8?B?MURadXdnbEh0WU4wUThGMXFVeXB6QWNyVHR1N1l5Zmc2azYvVFZPOWtjVWUw?=
 =?utf-8?B?NmhGNFNHTnV6aG5SaENGdGF6ZlExWmdnZjZmM3pRT0lKekdlZXZQNm5IUWNS?=
 =?utf-8?B?TGJEMlZHcTVJL1N0WHZ5dVNVa3ppdzZCa2xnRGtNQjlPTm5QVmlYekk5MHFz?=
 =?utf-8?B?OW55MGp6bUVaSUhaZEljeHZLQ2ZlOSs2T1RIMlUrTkRFNE1QN2tVekF2c1B2?=
 =?utf-8?B?Z2VKVXRsOEJpN1grRXdlRlpNSlUvV2tiZks2MzBQZ29IVUdERGNLVXhvOGk0?=
 =?utf-8?B?c3JTUVB3a0ZNR2kzTVQvRGNtZXRTNG1Pekx1aXFpMGdzVGp5NWJzbk9HcG9i?=
 =?utf-8?B?RHpmUVVVKzR4VXVHQ1JSeEVvM2prYjJvZWl2UWZxWEdLQThRcHlURi9UaFNL?=
 =?utf-8?B?bmMwYkhqSlBCZ0doWFpodGU2bEY3MXozaVFzNWY0bmJKRTFpNjdjU0Q1VmVB?=
 =?utf-8?B?Y0ZsV0RGMUF6ZjljVERLMWtDNzlrUHdVdnlsM3dCMEM3WTZnSlRsODV6dzlz?=
 =?utf-8?B?WXV1K1FGWmQwRzhrNlplQWdoNEI5Uk51OHkzNTEzdUE1UmNra0lLb1pocGFQ?=
 =?utf-8?B?ZnE0dmFuWHpmOVNVaUU0S3JlVWdBL25hUGQvdDk4NWMrb2tnWlhKOHIwUWVR?=
 =?utf-8?B?SWZ2VUEreUFVYUwrcExRbW5rVnl0ODVnMGtwYmdtS0cwQ3NWeTNGblNmNU9P?=
 =?utf-8?B?Smk3YU1FeWFCZVduZEtDSnd3bHU2Nmp5WnNRc1pPZWg2bDdjdGxtUVYzWStM?=
 =?utf-8?B?Z2tnSDlpY1ROSWNPN0FvempTTk01QW9wdUZWVTBvSThJWWNGTGtmSnBtRXZX?=
 =?utf-8?B?enVWR09vcG5hTkVzc1o2OXoxVnJZcDdFUTlHVUs0ZGNVdld5WlV6czh0L0hW?=
 =?utf-8?B?TFg0YVo0QWUweW13SXhvVUhGTEMyS2pyZWJXMjdubFdzUU9CaE1ZTGwwZ2o2?=
 =?utf-8?B?bUxKUlRnemg4ZTRhNngyV2d2OVdDNlU4UVR2blR4VUFIRXVXMnhrc0ppTUtr?=
 =?utf-8?B?Yyt0OWxaYStDc2E1WDRLR1Y1OXA1RkwyREJNbTYvNlJ2K3UxNDF2R1dLYVdn?=
 =?utf-8?B?ZWZhOVBHTjdnZ01FRW1TblgzczFNSG1yUGpFOXY3U2hvM3k5b2taM3JkMEdG?=
 =?utf-8?B?QXlRUjRCYXdDSFppRDR3OXJ2QnNjOXVjbzJycnlCNzJBNVRtZFpKSDRUdHVt?=
 =?utf-8?B?d3Y0YmhmSGcxZFlKRTl2ZjdzWWxhYVNESjVuVDg3MUFjRHR3ejQ4c09HUFk0?=
 =?utf-8?B?aFFNUT09?=
X-Microsoft-Antispam-Message-Info: cELE2OE/xffbNBC6CNF64SFsdOU5zfEjs34VehTxS76uqKtyip6j6QVzV7lyCqLFggzvXyxREQrHPGDvUNqbt/d93x7UIYBbYs3VI1yGKl/GcyvXE30CBV+5SFV7ZfDrXgJ9D+UwJPrNc2YmqnhyriBlSR25cMPiNCF8f5KviPkzuHydbppH95qf7eIcxQwL
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:eFIsCNPdzLe/b7SebYYd/89o7tjtDfHndsA8x+3Blch42VQfpu+pNihbIg5/Cx7mBgzGjEabLxtrXiAtrQalptBjlMEkFQBgfgJgRNp6AdwiYPvKR1svxMOzfFqxWT87KurRHfXxC9YRr898Z8GF67Dtcmm8KSsXYVPLWoWzpZ0J6g+G195kyxkXH24M3/rCcnfgrtO3EEpaPkEcpMX7AGfJOiijuz/RgV0aNxkY/3H+KOOPT/Gu2zmy4U/m0IH3jAojf+JIaBMV5eWL9j71IeSdGxGphWuDqd92xT16rNx5TlLUMjt6nIIUHlmjmN4KG4w2Iqv3IrgV789dz3+9u5u3rHeidHHz5Vb0rahjF3LnoGVVDM1GIYghsF/NSJvXhGILh3jzdcCXnTjwp+hEzm2z4W/3Z721YQ6lcshSiZ5+VAoD42XK5y+NAwQOczBZr9X+4rySr3ivn40Q+RJezA==;5:9JxAo5GYU7mBcHBNqUzvAd+JsFRjDU6vZ4Qm0eFeuIcmN7CGMpwUCfQ7WWynenZmphzYIeL9i+e0lQqqdjfjVadrRCWm0YSAIFytgP3/vUScvxNs1bZvpk6VX7b5oM1SNutwywXr1GjaSnxDz+x62W1tqPMbDaAKc9hWLfsvdhM=;24:s4O3DTxPV67pkCEXxFt8bVLKHoKgA1BhS9mIFJOug0gtmIfpPMgFDpHYjGkkl1+TTvjE2hdzUNzEIHiNx35W1RTVzLY3ToJgNNPmx7uDriA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:gtlGpp05t4FffX/6Cdpy1+i42+xEe0ti7+nkcfxo5cSfz+JE4xSU6cthlXcUUH75vLni1MGcmq0bVSQQxZ7tz/htkIXQz2BZadZ7SSxV9rMpMEmIAr3Dc6HJunmETFQv4bbvn3u3dj78dNCHDYe9YJlLYTpfp8SA8YpjamSyUNVJiKwytj/xauizymNZNgciyvkB380EF3biTecJOtZ2NpIg3ltw7MVjEYafPwb56xrgFEeNqA9jVSEGGHSbfF4Z;20:y6sldCTnCH6cSP/QK+X1E5HjWr9IIMu0dcXvRxZ5bKtXBp8quRFLX+k0G4u+4afCbAckfWWkxyqXdJUjVTIhpNzUj6lg0mWc2SFH4coeRzDnTMDzQhsRHIlMwXjKhT96gbi7cZCG59RJLZZLNpCo/dGLxivXKnKrG475ABFjyig=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 15:30:30.1085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c169283-fab6-420a-da2f-08d593f7addc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553609558263575?=
X-GMAIL-MSGID: =?utf-8?q?1596105307838986783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27.03.2018 12:18, Vladimir Davydov wrote:
> On Mon, Mar 26, 2018 at 06:20:55PM +0300, Kirill Tkhai wrote:
>> On 24.03.2018 21:45, Vladimir Davydov wrote:
>>> On Wed, Mar 21, 2018 at 04:21:29PM +0300, Kirill Tkhai wrote:
>>>> The patch introduces mcg_shrinkers array to keep memcg-aware
>>>> shrinkers in order of their shrinker::id.
>>>>
>>>> This allows to access the shrinkers dirrectly by the id,
>>>> without iteration over shrinker_list list.
>>>
>>> Why don't you simply use idr instead of ida? With idr you wouldn't need
>>> the array mapping shrinker id to shrinker ptr. AFAIU you need this
>>> mapping to look up the shrinker by id in shrink_slab. The latter doesn't
>>> seem to be a hot path so using idr there should be acceptable. Since we
>>> already have shrinker_rwsem, which is taken for reading by shrink_slab,
>>> we wouldn't even need any additional locking for it.
>>
>> The reason is ida may allocate memory, and since list_lru_add() can't fail,
>> we can't do that there. If we allocate all the ida memory at the time of
>> memcg creation (i.e., preallocate it), this is not different to the way
>> the bitmap makes.
>>
>> While bitmap has the agvantage, since it's simplest data structure (while
>> ida has some radix tree overhead).
>>
>> Also, bitmap does not require a lock, there is single atomic operation
>> to set or clear a bit, and it scales better, when anything.
> 
> I didn't mean the per-memcg bitmaps - I think it's OK to use plain
> arrays for them and reallocate them with the aid of RCU.
> 
> What I actually mean is the mapping shrink_id => shrinker. AFAIU it
> isn't accessed from list_lru, it is only needed to look up a shrinker
> by id from shrink_slab(). The latter is rather a slow path so I think
> we can use an IDR for this mapping instead of IDA + plain array.

This is good idea.

Thanks,
Kirill
