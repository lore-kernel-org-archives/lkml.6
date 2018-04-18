Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeDRICa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:02:30 -0400
Received: from mail-ve1eur01on0110.outbound.protection.outlook.com ([104.47.1.110]:41120
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752516AbeDRIC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:02:26 -0400
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=axentia.se;
Subject: Re: [PATCH v2 5/6] drm/atmel-hlcdc: add support for connecting to
 tda998x HDMI encoder
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180417131052.16336-1-peda@axentia.se>
 <20180417131052.16336-6-peda@axentia.se> <20180418093649.2c304f29@bbrezillon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <0155b3cc-29ce-fa43-5588-b465c6ee064a@axentia.se>
Date: Wed, 18 Apr 2018 10:02:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418093649.2c304f29@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0361.eurprd05.prod.outlook.com
 (2603:10a6:7:94::20) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:y3ACdj9qelMyeSNRRKT/L57kcCP1flNNFtdCxbYc1SliFFmbyJvQMrO+RyihFVIe9xeBubP7AolL8FdokBzZwkq2gD0acGS4u/+DmvNrnp2+E4CkNiGUomFxjd4lSjfgUH4cvGi4qwACfiQqo3OPnKTfkCTcZ1ilBHUfmRMEGxtESDS8unZ2HzzPsnu711n0XYMV0x/eH5FIe7pLT/E3XhUoFyhEDn88uc3MWwd0WedJgmSB6Ujn+fMTEtIbEQ5Y;25:4qd/JSpKrQkzi1thLDzrmFXsXUQpNNannYYGSSugfiUNPPK5pVjnyQNAFZHEqT9xjDkbYOdoO2YKSU1kwJjzfyXnlOnsMZza8IpIx1Gd3BgO+C6IU1eXoKnS1uyJnaKebytgM3lcISJMvKHykETSdo+AbFSE3mpMJwXm53Ug1z4RzZRwL4d7z/2V8aFnlPevTFCDDTu6tRB6Ql9nFoYUpZysOPDSyW7oGSgQZQj3e+90U8W2vq4JKPXrBU+CWTyUNADk4HGLuPJDxaLo58u+5nf38g3XOmv3MYD/Be+Aie/O3jWiZGA0gBC26g+EzUa6hb1GktoTgX22Jx7KqJsq+Q==;31:fUd14Av8OXmRyTP1lx6nL7wxpfvzbeqv5ZfIOeS72RlXMjQq6f1uYaYBx418Zj78MLWA94xHSPo64AF/1/b3DymAI52wi/ephr2/GE21gotswaq2/uMl5sDWYS0eLJWy+wHLzYHkgrc0d1f/tP6sbz92ArwdsjDThinzM4v4bvKta3JvoXTZgNSsqt6cVQBRFY1j0Hdul8tuDk4uIos9NxzLvPfoKz7f5b/v2hV7Nx0=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769CAD506FBB8C684D87ECBBCB60@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501327)(52105095)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:uzRqXWrQMu+NW1RwehurtD3a+hlcVj1MQ3IKYx3afXXQtBtcGvR/g3+L3vqPNHB8K9UECDDvA/T0Kg5SWmJtGhyIXZ6htp+cIWyEOCjj2KAu2Qh6QjUiq4QtfLpuXZzX78b/+RyB+DRoBbbzxesz150xYXkiL7p1DPd49RtC4QlqM02DMFaGaEIZtNzPgDlx8860+dPLDuFXz+a8BAKYr0aENNvL6/FDmeVniETeq92epY0mDCwfTY/WaRo9UJe3P30I9W/Lj0gpo9DnosO8ntCwZXGyA50r13/0PCBa5MClNobRHva21csDzvweKa71
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(39380400002)(346002)(396003)(366004)(376002)(377424004)(31696002)(86362001)(31686004)(65826007)(53546011)(386003)(305945005)(7416002)(2906002)(23676004)(2486003)(52146003)(5660300001)(76176011)(16526019)(186003)(478600001)(36916002)(53936002)(50466002)(54906003)(58126008)(36756003)(316002)(16576012)(6666003)(8676002)(476003)(6246003)(117156002)(6116002)(47776003)(81166006)(956004)(77096007)(11346002)(74482002)(66066001)(26005)(3846002)(230700001)(8936002)(6916009)(2616005)(3260700006)(446003)(6486002)(25786009)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3Njk7MjM6TEY2bjNMR0JxQ3gxWG9wRUVrd2s4UXhE?=
 =?utf-8?B?UjhWM09jQUs0OTVKclUvZFhGSzNOYW4rWm1leWc2c1dlSnpBUmpZZklsaVpQ?=
 =?utf-8?B?NHRadndHbnpUZ3p2N3Z4UFhPUjJORGxXQ2UwOThycTVUcGNrcFpKWUxiR3NX?=
 =?utf-8?B?YjdZdjdPU29pOE5CTXJHa2txb0hwYXpuK3FYLzhobE44bTFsNnp0eW9FSktR?=
 =?utf-8?B?UGx6cXpiUHp4aGVKLzdWZGZTY1pIMndBTkthUkU0NUxHKzVXaFl2OUNEZlYy?=
 =?utf-8?B?ckVSUjFMcDlLcFJDSEpGSlRRNGhIZFNkUjhsTEpycnEzanBzL0JCYmNlWXQ1?=
 =?utf-8?B?am5WZ0syb1Q4NmlKb3YzVitjSFhCcnhqdEVmOUR4MXRVUWNGakdWSjV0MnpF?=
 =?utf-8?B?cmVhbnI3ZXJQTWFNSUdWeXhKcTF6SENsUGdKWEVzRmRaNjIrdHlZaWlMem1X?=
 =?utf-8?B?MXQ2VytYMHY1OEduTHhQcENTeWZvbmxWOGFPOWtNTnZucE5VU0tQSElEYUp0?=
 =?utf-8?B?WEViTlZiMkdraUVwSnZQWWFTdU93LzJwVHQ2MkJTNmVNS28ydXJJU1dPMjh5?=
 =?utf-8?B?TjBjbks0QUVFQWMrYXRxVEM3c0w5UVpJdXA1MFBxQk5meUZjdGVVUXJLSVUw?=
 =?utf-8?B?VjNZY2FIU0l4MVpVYUZSbkxqSFdFMmZpaGdYRWtHQVRYeCtIUHp6VGpuSm8r?=
 =?utf-8?B?Z00wSG9iWStWVlAxSkRFejJYQVg2cyt3WVZ2K0M0bGswZDVvejBuUzJNL0p0?=
 =?utf-8?B?eXpQUExlZkZZQmJIaE13SEoyejZZNkFFNEpBUk04WWNlNndyYVA5alFLTnYz?=
 =?utf-8?B?SlRNV2E1UVNsU1RZdDJEVFJza3Q0YVJpdGZvY0tEMlRQMU11bkcxSXBQcFEw?=
 =?utf-8?B?bFRCSlZ2SVZBWEc5SXBKUjNxU2tlbHZwVS9ndHJFaHVGMzBtRVM0bWRwVVUx?=
 =?utf-8?B?VTNEZTZDQjA3MjhVWlVrTEh1NDJ3bkgwdlhSUVMzTW40d3ZFL2t6M0dUUjFx?=
 =?utf-8?B?eW8yL3Rid1VoL01VNi9OZExEbFN1ajd3dUdqYjFPMmxvUFhmTExhZTNTUCtX?=
 =?utf-8?B?OHFTR1FhaEs2TnoyRGx4dDQwKzVNRVVkOGhVZEVjb1AwYVpsMGxQQk9MSThY?=
 =?utf-8?B?QWVTL2hJS2V6Qkc5WThpZ250U2hhK0Q2OEZZeGo2VFo3bHFQdEhQMXVWVk91?=
 =?utf-8?B?WFNuUzFJc3FQM29yeEJZMlIvdldCaDkzZlZxdjBKNGFlRHZZNUxYWkdZeCt2?=
 =?utf-8?B?cXowWDhoTFBEQUliTGYxRi9EN2syV1FJc2RRQkpzMHhDOEtMQlFGbEpSaVZl?=
 =?utf-8?B?dDF3ZjRGU205L3hQWEJFRGhOLzJhN0tnU2lYMklPZmticmZVNFZEUzFvZytH?=
 =?utf-8?B?NWdwVlpSbUF5RnVvaTNkZGorSThxdTg0cldLRW5BUW5XT3loUm5ueWJXZG9a?=
 =?utf-8?B?U2hCZ3hrMGROLzZxVXdGUVVIaWpJdERmQzlFUGkwdGNURzFXYmtGMi9ndUhN?=
 =?utf-8?B?WWY3SDRpUk1wNWRWSENnR2E1QktuMUIyc01rcHlkY1BUYUx6RUpKaG42M01X?=
 =?utf-8?B?WWYzMGk2V3ZKcEYzT0hkVDAxS1B0ZEpVckM1RnhpQ2c0Q3BERnd0Z3BEd1li?=
 =?utf-8?B?NnY0clBCYktObkhQWlhwSjBDVVd2VEZSSVk2Wks1bUJDNjIyM1RMSDBxNlhI?=
 =?utf-8?B?cjVjWE5mOTV6ODhrWG05c29SL2ZJTytYeklMSHJpWGZ3SW9mb3dSNkE4V05V?=
 =?utf-8?Q?AL8D+s2WLly3bsxja/BTHgWLFnIwvBosuJCfxTw=3D?=
X-Microsoft-Antispam-Message-Info: 6/AwTAGTy+OeynykrRYcJVtTCDmgIJ2YFNOU9iYbiL8p+Yxmx5AJuLJrDFT/R2OC8B3TO4YWomF5wmYJecNF8EfL1qOMJYqrF6o9WvIMdF6WnSvXmPLV22czImpeFrRY3Zk8L9NmXmOV958Kl/OyfvpKqzAE1DZtRpb2A6CF64xHkqhNuLwAqCoVFOrhjDVM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:DjButDcwQIdSS/Z4Z3vsIZ9luPB184BOMDhfCaiWUj2b4ekq4TfCByNrJI216kbtf6iE5mDvy42HQaPBJlPzVqaPn1rKbdQOWgewWt0LMvWx9rrgbEW5aMENcRuSstJMvoz9Qwy0Emj4arj9oPU2I//RuHhdRZsUrv78gs87msFiyrGUw7yf/EQnBBstTqTDGnyrJZVdCFn8aAbt845h2WEm5tFXAMMWhTOiZNVh51oKuZIkC4C59dvMEhvLmrrBena7c+ipYGRjWKLUJ2HdxUk5aHG/B1fn/WPOoxDnKwvwEg1eph4P8i7B2WSlcamvvcaFRU3CtUOlMUE+x8dkwsmCIShP/ANva1uXaC/kH+sk74aHgFWGc2Qk5DCyQ1ggPbTsFYz1BxO4x7GY0DGEWbC2PAa4A5g4aLuqOXWgFcV6LZeQhCuYpC/o4cdquBT+jZQ0gcRi0b5dcJ4fArfMnQ==;5:svrb/q5+4fBwOOqFHVV+k7lf3WioZ3bzl1jcK+ZgSOG/d0ff1WlSnvyiOVBVbHEOF5gdKgxom+GdkS5Wm2sx9ApHArYvV3Y3Ghv5rgS4L4Q7NSbmc9JUYqtvmeAPRKf7Nk6Y17YLP5yNHQI6H8KvcTdUywooZ9PBHpNLcqHvI9s=;24:5/qz0uZ5q7fnlHwm655RIWD837z907IV+mX80sa4GHBV5qDaz9le09AvDY/pC8F8Jz56JRrzVBVr37ZWNF3ZTGEjDyzU761pYv51t/e7oMU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:jBGJ7C+dKd1nXtQYsInL1avB6Lq+KMOo4BtobwY6gzexX22P/VN3JkTuLPOooxsp1b1NJG6HsDFfoK2XsmQWDl3ZqbW8cu3H5zULt2uUB0ejwu1ecQi/ofYlO/c3T/uoY+ABcyp8ZDXzyrpZBdTuHGhARNxbzcoZmQjxVNh9Fb3FUnzwUtCu6Xz68E8ucO2ELGGXyy9Pea4DVmj1W/Jn/j9I9mm261AI5k5Bjrsn0W2nM/T0PgZdxcK1nK4o4bAs
X-MS-Office365-Filtering-Correlation-Id: 06bf74a8-5785-4d5f-e1d9-08d5a502b77e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 08:02:21.9948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bf74a8-5785-4d5f-e1d9-08d5a502b77e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-18 09:36, Boris Brezillon wrote:
> On Tue, 17 Apr 2018 15:10:51 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> When the of-graph points to a tda998x-compatible HDMI encoder, register
>> as a component master and bind to the encoder/connector provided by
>> the tda998x driver.
> 
> Can't we do the opposite: make the tda998x driver expose its devices as
> drm bridges. I'd rather not add another way to connect external
> encoders (or bridges) to display controller drivers, especially since,
> when I asked DRM maintainers/devs what was the good approach to
> represent such external encoders they pointed me to the drm_bridge
> interface.

>From the cover letter:

"However, I don't know if the tilcdc driver is interfacing with the
tda998x driver in a sane and modern way"

So, which way is the future? Should bridges become components or should
existing bridge-like components no longer be components? Are there others?

Cheers,
Peter
