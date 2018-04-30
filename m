Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755330AbeD3VNK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 17:13:10 -0400
Received: from mail-ve1eur01on0134.outbound.protection.outlook.com ([104.47.1.134]:48948
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755174AbeD3VNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 17:13:06 -0400
Subject: Re: [PATCH 24/24] drm/bridge: establish a link between the bridge
 supplier and consumer
To: linux-kernel@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-samsung-soc@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        linux-arm-msm@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        linux-arm-kernel@lists.infradead.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-renesas-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        freedreno@lists.freedesktop.org
References: <20180426223139.16740-1-peda@axentia.se>
 <20180426223139.16740-25-peda@axentia.se>
 <20180430153236.GP12521@phenom.ffwll.local>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e2562f6f-f7b0-477c-db38-a3bf6c956fa7@axentia.se>
Date: Mon, 30 Apr 2018 23:12:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430153236.GP12521@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0202CA0030.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::16) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:1g9+pizvIrhgPsKAf400OkRWgcVtrxDHYHUFQq4JnNSEqmlX5tkZr37pliaGNt80c4LcMz0OxeoSHk0RVNRPuZSl+cs+A0w7bE/YkH7IKOEiV5xem26M/lMf+vPAYicfYT8ZalFNLWvZtNM6XECUMc8hI1yt+/XnH7fr7rsBezr37k1Gf0r31yCy/r48we8FRsSrZAHwMXEP6s9R1OgkK4Z9o2Rb7+oOM/r8gZN1KOcEtkKZ4x4P5r3T2LEfdKg6;25:sEECgLc0IIsa+AtQlE51s3uHj3JzWzLKPYI7YvvCTTTol7Vck3anH6u2qi86A+nnagF+zb8nKp/0OzX4JyYwzOA85f80/MJwA/ScwLgo2DjIYG7YDv1tQ2ltkKf3t1LdatBXzj9C/ws7JHzBPIIyK3+wgXBfgl60t97HPHIA7DEXe0Xrh80U3R8zI/Ymqv9/4A62uTnr4EOJ/cqGYmGWCifaPF5kme27RZNHhjJAithuyeLuLO5Ovsf9X5eSkEj4EKqO5PU6BaUA+eOOjrOP2MjiuT8yS0QfupSZDIU7yHqjnt5F/LcyhnnBsQsV8kPJCoKN1cc6sifuEtfpWvIKug==;31:LTJaabpZ1oKVcwEUqxfnOmPeAkp6tiHGqnrnVHbzp0bONoJ26TRUhgfwzoEopC+g//7w3gVw4UvEFxwOLm3DSxziiNyUzIuLuzddycywnbHkePHjO9z4eF5JEiwl0WVVYyiwSCqgJbPjFSh83iN9J5Zmr102h9S4ySfQFiM14s3EDtddT5jhGEiHZb3CwiRAZGdfUyihDnvQIlrRkVq04mRXMNriX9EkQRbnqJSfw2M=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2776618DD2856C999FDC7DE3BC820@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6041310)(20161123560045)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:7vu2zVdo/B/lfnH0rwtqlLUcK0pdZ4BVovlnFqnAh8LVSb0A0qOO2bf4XWO/fOo4xEc0aIuWQu4ZyBMEuILLj8OCVXmQV7HIg4VT6p6a82vd2bm0s/W1MBLDkXhhxcO+s5zcv84uy2xN7HqFRM8abTnGTsU9XIZuE2rOE7QtShP2uspcpuJmESPpN/UBaRjX/cgytToskM2OGj6x7dKioeO5TEmTR1yCK2XmEt+t4NatQ5QATdZtA2gtz+EyLioriykoQi68EGJ3GAF/YhWCag==
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(396003)(376002)(346002)(39830400003)(366004)(199004)(189003)(377424004)(97736004)(53936002)(39060400002)(8676002)(8936002)(81156014)(81166006)(52146003)(74482002)(52116002)(2486003)(36916002)(23676004)(86362001)(386003)(305945005)(5660300001)(53546011)(31696002)(26005)(230700001)(6346003)(3846002)(76176011)(6116002)(65826007)(7416002)(7736002)(16526019)(186003)(2906002)(77096007)(11346002)(446003)(6666003)(2616005)(476003)(229853002)(486006)(956004)(106356001)(105586002)(68736007)(6486002)(31686004)(47776003)(66066001)(58126008)(16576012)(316002)(110136005)(117156002)(65956001)(65806001)(3260700006)(25786009)(6246003)(478600001)(50466002)(64126003)(36756003)(921003)(42262002)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzY7MjM6dTNWbFFuS240VkV2SGh5UExRTWtvMjhW?=
 =?utf-8?B?RWJCVVJLQ1o2aEZrRjdGeDlIMVh5TWJxaDlnOW0wZmtZMldoblJIUEkzYzFX?=
 =?utf-8?B?OEc2eTgzVGVzSS9KQVRtNmsvaXptQTJwK3lsSGZidThrb3d6cktHK01YeWdC?=
 =?utf-8?B?VnVqVFB6M2o3YnFvanFWOHdTL3FYQ2kvT250bmlSRzVPZmN3VlRBdURMMzNq?=
 =?utf-8?B?VE1LMG5UT2ZaR0E5SzMyWmw5N1VvU0orVHhudGxGSk9yb2Fpd3MydlZwUDlT?=
 =?utf-8?B?WjArTjZMVGlsOERvcDNQeGJadVBKOHlxalRuUVdyWDBNRk1MODA5TURNQ291?=
 =?utf-8?B?OWVEUDlIT0R6cmw3bnpEQmJXSlFnTHFlc2lMUzRCanpETjJiK0s0V0RJc0lp?=
 =?utf-8?B?WjF1QjZpNVdsRXdGZm1ZanBreEVyVW1JaVQwVXZDbzVUUlVjR2hKd1VROHBQ?=
 =?utf-8?B?dk1aUWxCaFErT2dycnp4SEVNc08rSmdTazBqOEl0cUhLNUYzY0NNWUplU0dD?=
 =?utf-8?B?YkJkbDEyWEE4RmlpL0hNaFdsRDhSWVZRSThVRDlMSnZVb3VMT092NDVLWXI2?=
 =?utf-8?B?OUl3T01xWEJUS1FPUTlTMFQ3bTMra1g3UlhRbEFWcDd4MGlwTVFlSTZoa1kx?=
 =?utf-8?B?UTlFcG9oS0ptc29kTXJZaDZjL1Nlb05vTWR1OE44YmZBeCtDQWJhVVVUV1JL?=
 =?utf-8?B?QmVSWHplby9VQVc0UlRFaUZ0Zi93QTJ5dUg4anBjbzNaNklZY2crUVFIdElR?=
 =?utf-8?B?SjB4NytTTmdTRDJQTGVNaGM4L3hUa0hRWUZzQTdPSzljd0dCQ2psME9ycURG?=
 =?utf-8?B?N3BNeFRUcHV1MmtGS3p3QU9lNTVrSk1nYU9qRHN3a2lQbC9BQndMcTNyaVp1?=
 =?utf-8?B?YVhJZFZROXRiRFVIYkliRGJmUFc4NWwvd2wvKzI5bmN1OXFub1N3MG5jVDdR?=
 =?utf-8?B?aHp2ZmlhRW5VQ0JuazhVS3c0MnZwOEE2b1hiQmg4SERITy9oZWFGeXpPWjBH?=
 =?utf-8?B?TUwvYzIrWlArZUtGbWorTXRxVnVBSlV4WkJoaHQzb0hiazJzQ1NxeDJOOEJT?=
 =?utf-8?B?NkNGS0RpQUZaWCtOWUdhOUhYYlJualN1bVlrZWZQcnVHSVpSYUpVdDl2NG9l?=
 =?utf-8?B?dEw2NUZtT3dqVVVCVFJIenBwSzdpRTROZEFHRWI1UDc2NDA3cnBXUkY0VS9T?=
 =?utf-8?B?TDBlNzNjcUw5aEF4WjZHcVUvRUZCRlVRTUIwdGRCNEh0bUZTQlBoTm8xYmo4?=
 =?utf-8?B?Y21OeVlyTHVWayswVmZ4R0VhT3JqV003ZnBDdENVSDNkUGhYMlAxSVNtZ3pn?=
 =?utf-8?B?TEZXdzFsQ3lXL1J4NG4rQzNYRU5KY0ZRdHdHV2sxaW9BUTVNQXBsTnZ5b3V0?=
 =?utf-8?B?RHV5OEZzY1NHTm10elJIUTRYQm5XMDVkV29qMG5VeExzdzYzMWUvcUJjcHNn?=
 =?utf-8?B?WlozYmIxay9SQnNEbmFHQlJBMC9HdGlqTURubGhEWTF2Nzl3U2VWbFdRZVlG?=
 =?utf-8?B?ajZHbFdVYzNvZXUzTzBKd3FOcEF4TWZ6cVNab3ZERFVFcWJkUEhrR0E5NGxq?=
 =?utf-8?B?U1BTeW5sRVJ2ajNzaGM1UUZveTFvNGdpbElSQk9GRlczWVd2dkQvQk9RZUhp?=
 =?utf-8?B?ZzY2SVBRaWpWM2x4OXVwZWJ6VU16U3kwSnd5c0sreEdHMmJHL1lHZHFRTHl0?=
 =?utf-8?B?dEQrdlhVbEVYVTBkaXIxaSs4b2dib21tQSswdkVna2F1NmVQYk50SU5FbTR3?=
 =?utf-8?B?Y0tWUmJ0aXJPV0NRV0ZBZ3ZOaXVMSGVudzA4V2FxREp2YnEvWmtzQTlPMi9S?=
 =?utf-8?B?YmdqUTg3K2JVOFY2VHFtaUpQZ0V4dWhkbzg3a1JDcnQyS0NBbjRqckFDRXlq?=
 =?utf-8?B?RVl2QldETEZpeEhXR3pqb3pXT3JKd24rMW1qZFVZdTZYN1NoaWxaN0QwN0V4?=
 =?utf-8?B?eW1TZi8vckZPYnVibzErc0U2YWJDYWQzUERBNjhzWDg1ZUdqY01mSnA1YW5F?=
 =?utf-8?B?dlA5TFpzRVJuK1lxK1JOQUM5UmNRT3RRZkJWRDE2TjlTc0UrcDJ5WE8vQmds?=
 =?utf-8?B?WTA5Q0tvT25JTW9sOXhqa1ZWRFVaRjdDcDJvbEVQaVZFSTNTUTRKeGZnUE1K?=
 =?utf-8?B?S3k3MjN4d3lzY3lHYU1MRUp4WUpUMWYvN3dnMlg0VkxnNGs3ZnA0aGRDK3VP?=
 =?utf-8?Q?NnWKkZIkslLDf04LjNVDvWaBRqO7h9OoAxZEolb/DRUs=3D?=
X-Microsoft-Antispam-Message-Info: BwKWz2gM4Tm+OlHg/ImByEV42ZG/EcFLIzif6Y2p3gT4Mq8KFBFa41uXG5tsJgGPNDLMsq9FvdAdnFiY4NL2+vPv0rqCZdwArb75i/haehc4dPqSAE/qB3N78nsQIbOoSKcr4DlijjA7LRiNwHvaHElM6RihtzPGkCGudyQpjF0Sh+//1sTgRualGM6oZTUI
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:5uGWvC4qQVlpCX0CDSyuF+rMzK2gEf8u5M9RhDqmw80A/UetzR2IzMhHnVyIuu0O7nU/ZypWoZ4tVPBQK+1An7Xb8fFyORtFuUggt9+UvZWttbEqGUje+6eANFGu96py+rf8LCi50/FsmhlhgrChgyO1dnXHcFmmDth3qwOHmg6yiRwe2xsw7NNI8vLhsX7GQyzfj+MrIk5SHcJNsVXyDPuzgyAcNhtUOhhU0PkfJycHvilCja2MeXgaOLMseeOecis6kVABKVhgSGL5KktxB8O/eVmL2kuSZL/wW0CqYJdYph28wOm7E5VlINyrxsVb9pzM7PmMteJ/SQXpAEDYPIPdR6XXfZxDzg/iqj6dDmCgDHuo7hrorMiTU4mWNFYeKkiEJaxSzrFPnO6KGSB04G4swif3sLuQMv+kB9ax6RfxKporh3GRNvPn9nHKDRGet+/B+8pSZszyxmAc5mnQQA==;5:E+i/KygSklla3KJnvYYXBTt6yQS8OpaRGoW0gbFEV/YmrnZeFqYjWYQ+4cIKOciik7GT7TihBt9ZPBphi+UwMzgNBU1GQvfS5z3J8mJVNnkNAzaXRgA+shmP2PmtzQGx3zbFw7YfQncBWUlgiofF8ZLbUBACmJlDsUMHiE6qIXE=;24:0wTfuMuBz8Lt7STpj3qneA3tSzcWoARtC2xpc+VnWm+9y8KBRiH0dKTTW7E/f4DR798R19zG+KNirSTZE+ZhQbJBUyPLwiyKNYDwqO5mKZE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:ESSP3dVWVB83ga9COsEwDtm3128gSDt254uerf3EthcLSZ6yIyo3/y8J+Koaxt+1mEyR+majeytBhynxVv+4eygjR/MJ/zY33QH2vtCwKN/BskO8j0UDlRaZybY7Sz9jW6ATP4oWGfTaS2tSh3cx0jnSkcnuYyvPx+rJRL3ISWVYvEwK8mrQSmPyZIOZ+hKERv7qGe2XPqF1i5sFKj40LX307NIMgoHxB/W0PU4M6WYXdmKGv0zlARMmPtxHECss
X-MS-Office365-Filtering-Correlation-Id: 940b25f0-99bc-468b-7384-08d5aedf27df
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 21:12:59.6126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 940b25f0-99bc-468b-7384-08d5aedf27df
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-30 17:32, Daniel Vetter wrote:
> On Fri, Apr 27, 2018 at 12:31:39AM +0200, Peter Rosin wrote:
>> If the bridge supplier is unbound, this will bring the bridge consumer
>> down along with the bridge. Thus, there will no longer linger any
>> dangling pointers from the bridge consumer (the drm_device) to some
>> non-existent bridge supplier.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Minus the ->owner bikeshed I brought up in the previous patch I agree with
> this approach as the best way to move forward for now.
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks, let's see if Laurent is also on-board...

> One small suggestion below, for merging I'd say pls get Jyri's
> review/tested-by too, since you're both working on the same problem it
> seems.

Yes, I too would be very happy to see a tested-by from someone.

> Aside: Do you want commit rights to drm-misc to be able to push work like
> this?

If that makes life easier, sure.

Cheers,
Peter
