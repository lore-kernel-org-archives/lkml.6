Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeDEIth (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 04:49:37 -0400
Received: from mail-by2nam03on0084.outbound.protection.outlook.com ([104.47.42.84]:60576
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751097AbeDEItd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 04:49:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com;
Subject: Re: [RFC 2/3] drm: Add helper iterator functions to iterate over
 plane damage.
To: Deepak Rawat <drawat@vmware.com>, dri-devel@lists.freedesktop.org,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-3-git-send-email-drawat@vmware.com>
 <20180405075205.GQ3881@phenom.ffwll.local>
From: Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <0edfe662-6463-a143-e00a-d3d4bc06a229@vmware.com>
Date: Thu, 5 Apr 2018 10:49:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180405075205.GQ3881@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: CWXP265CA0027.GBRP265.PROD.OUTLOOK.COM (10.166.154.143) To
 CO2PR05MB763.namprd05.prod.outlook.com (10.141.227.15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ae8ced9-e2de-49da-0c81-08d59ad22388
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR05MB763;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR05MB763;3:u1ZhEWY2CdTYLvizYSUTRI5ChX4Isno52eMKTw+p3K8gB/bGo/1UlFRHSpjW7G1NYscYQ1G3P/wdIFiDCPHiuYVT2WCa37fm1BQGHvILPuzDVku1oY41hMzG1bQVUUNxQZQ1xQrYtBYuR/hTkQn5yZPrLn7rGGttTYUg/WNrXMfUTEFLrcaDPI3C7aS2L7FWJdXTTXB821A2cMbsq1Oom9C8Vg5beHF5Aj431iebbismItNaAasxgET7civVtRuO;25:ZuxdRSACKp6LTA6t946xsI0zM4mDhXyzcaAQsL8SPGOP/e0335i32LpBmWuUowGXFBY5GKS9eQnPHxpJSstE5SYE0yvzFmf/S1P7I6s4ZPIoDdzhwhjSYwivcyVWthMM903zsIjkbZdGXSVGfa1KdTNd67GlADoMJcfvi1L1rXTfRnRdXkaMhYaJ5RtMvGwNbz4zxzu1PgNwVLJb8ZM/61C8pbj3YRjxXxtKDVKBfal39sLEdtG6DBi2ijBvkJbLbNrvcheo+D2b210z/beLRim/xQ4oQbySsrMVqFHXwRxWWBYHxsf+hOmBb1zcXpZfjjiOsg65bvwMl9L/Ax3u4A==;31:1LF2Dj2P7Hl3v6wUvxs/waPM1j06UX4Cbw//1BAUnevp4OYdNVq7485TL4UYh2lWFHC29sK2n8j4KRGtHE9wetCkhye+W/vKuo7gDQGHxJwAgeGT891vR7/muXW5ft1jXJKWoKJWU8ACfRGk739OZ7EY2hO5OUrW9QT0QqgoSFP55HToRnIPkMZ9IrehvjPdRslwC58KDynZwxL+vnf2KFZ9WZx6mpWPgh4rPBxWMkI=
X-MS-TrafficTypeDiagnostic: CO2PR05MB763:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CO2PR05MB763;20:3V76FArvLAr2dNi0YO0Fbw1211D80f7j0XrGbVP0316gNXYm8qUobf+eHkBN8ZICBQBYumC825dzEvZEpOgjdZPZstZ6EfUfbRVlvBXQvc5md1Ya+TT06liByvkHaCmnW09ZEy6Am3zZiM177+AkMxOzObYQ53/nMem1L74N/QIvxlgxkobOMvMDcc8yVJuBOU/nzjelX+KVcyzvc7GleRRGJ7l04OcjsK2kYTAka7J65Up8mUciXJoXkBWURlER+lI/mQObZjnag+QgrINi7K9hZSRVWGAiJH/IQURUrPe1MarczFmODdbfFiP/N95N/VicT5VG528+Tp+DH4i5TEvLUvNZlj+cZ2oKbUagJ5u/qXHzEiG2w57ljUhswf+2dZB4l/KGz1HfqWxzERsnUxSD/8WzuPpaHf2GUBZ7J7hBIbS82nPG5WAgWDMUbCflo9GcxTV3W8gqv/DQ/5kHbsfjZATvWvKKGx1YGLqoU8m+rRdu7vDKwUufq+1fY49A;4:fQHdMWDRVOMqu3k7ZnYDlPhue0L5nqq+HRl6RUkxwZ5VAxclCPTLphtsVxLTBXt/R14dpnG0cEDmoeHDmP796iHow7ibxp9LIZ/mk0IiAa7GjsGkwTFRWAaqzofCvtmTsZRzk9NbH2RN/0KVAEuOjfeaYL7ym/idad3CdjqF64BrF/Lo7uD+6OPdNL2uOMujtyEFd/SXXphroVQflm2tSg5wnqmtqQFrt8vd/2lwGXdb+JuuHJGoysK2enlr4+xnVP6a1mWbClQ/Y2F1yOhoRmODXZDq1Yh3ZiK5ZSJ3YN9f/BnEqF/ltfzyxpnjj1xj
X-Microsoft-Antispam-PRVS: <CO2PR05MB763B6F4567F7724F480BA4EA1BB0@CO2PR05MB763.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CO2PR05MB763;BCL:0;PCL:0;RULEID:;SRVR:CO2PR05MB763;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(346002)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(6666003)(47776003)(229853002)(31686004)(230700001)(65956001)(65806001)(66066001)(36756003)(186003)(97736004)(31696002)(478600001)(39060400002)(486006)(316002)(26005)(2616005)(956004)(11346002)(446003)(7520500002)(68736007)(58126008)(476003)(105586002)(2906002)(16526019)(3846002)(6116002)(65826007)(8936002)(6512007)(50466002)(67846002)(7416002)(5660300001)(6486002)(86362001)(52146003)(64126003)(2486003)(386003)(76176011)(23676004)(81156014)(305945005)(53546011)(81166006)(6506007)(7736002)(53936002)(59450400001)(8676002)(25786009)(106356001)(6246003)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR05MB763;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDTzJQUjA1TUI3NjM7MjM6bHRpaWVFNDl6ZTg2OVhOd1ZwS0M1YjU3cjNN?=
 =?utf-8?B?VkU1VTRZTDFVYXpzL2ZXL3FUUStwTTNhZE9sc3hCUWdubjNDSEJiUnJDNTY1?=
 =?utf-8?B?K1BpTjdFR3o5d2JkTExoK0ZHVXFMVUFIbjhXK0xSRGVjREVoaUl6UlNxaGVn?=
 =?utf-8?B?TTR2aU8wT1d6OHZvc3VyQ0djSXk0N1N4NzYvUEN4MXNIbkwrb0N0QmloV0tu?=
 =?utf-8?B?YWltOFhKUm0yZGZkNllnNDRYaTQrSVZsclpiYWlVTEJmNmJ4VWl1SzA3a2Rs?=
 =?utf-8?B?VlJZN1hKZi8waUtqa0pTbG9HTWtielVaUzd3am5Pck55TzlYaDhEVTNaa2tn?=
 =?utf-8?B?aU9JQm5xKzk2Y0xlNFMwZWxyVUhkbU1vUjY5ekF3djBwZXhBYnN4Q1RVSEtt?=
 =?utf-8?B?VDcranVPVzhoaU56WUxoaGtJdE0yNFVLVS8xRHFCbTZhQ3R4aUtNbm5WREFF?=
 =?utf-8?B?NWFoK0gvR08xd2gwVmlGYnhqZi85RC8yN2NFVGN0d2RmVXd0eHZWeGhoYXB1?=
 =?utf-8?B?Y2hsdlJFRzBmRDJEWUR3MU5jQ2Y1VEt5S2JHQ0UvOU5wNExGU05aVENjbXNl?=
 =?utf-8?B?bzRFZmZEYnJEWVB2d2JlTVJPbEtyK21QSkYvd0daMFlSZ1g3UzNYSXU3MmVa?=
 =?utf-8?B?ZWkzSThlY09QdWcraXExMnRDT0t3b1JaV0w1SHFVRDE3MVk4bHVtcG1TYUFo?=
 =?utf-8?B?ZUZaVm1wdm40MU9UdUFlcGdSNlBpcXNSamdvTGd1NUcrb3RpOHpaNFRXcE41?=
 =?utf-8?B?TGpRMVVyMGR1d3UyQytUUGxDUk10cTRoTm5yZmdUWXBJREkzbURNMThmU0hL?=
 =?utf-8?B?dHQ4dFVIaTQ2eUl3eTZxYk5oZlN4eFZta09lV3oyMzJSZ0VLYlRiTmpudTVj?=
 =?utf-8?B?QjZLazN4eXUzK2pNODBHL1RCM0NzK1gwL1VVZjU4N2xLVEY3bHgzVjNxR1Fm?=
 =?utf-8?B?VzlZdGdlMjdkMm1Ib0Z5K04wekg2bUVaaHp6aTNEczZnWGQ1dHFlcm1iaHhi?=
 =?utf-8?B?WHhNb0pVQXNRaHB0T0R6alZUWFB4R3lkeTBjYlk3bW5hT2pBZzVzaXUrcVUw?=
 =?utf-8?B?RjJlWTVFRUpXTEJNRE1FOFJCR3Y0aVNxTkJkQjFRa1U1Y0I1dmJKa00zQmx6?=
 =?utf-8?B?dVBDUitPcnhDR0VpWG9xMU1JTDgxZStiTHpGTk9QMzRWVEdsWXJqUVVVc2Ri?=
 =?utf-8?B?N1J3Z3NBalkxYXFUSXJNVFVyVGNKcm02SENmc2liNVBsamY3Mm5NQ1oza2dW?=
 =?utf-8?B?WlFNYmhQSEFKKzVKRWpwVGhxbmFWRy9LWDFyamlXNHlXbzVSbmJsM3R4VmZt?=
 =?utf-8?B?MVU1K213d2pYcTNFWW5LaFhvMS9Bb0ZxcWxDWG1hU2M0ditlYllLN3l5a0xo?=
 =?utf-8?B?d256ejFzSlFtbHFxdW1PRnJYd2hNNG5iN0pwRjBxSDlPR29BanUyZmJEWG1F?=
 =?utf-8?B?Ly9INTYraXhYcGtGeTBoRE1HOW81a2lCVmpZR3N1NlNPZHRCK1JaT3ZCL3FT?=
 =?utf-8?B?S0IxOFc0cURrNngybTJqUlhsdTJ3a0RhcWhpVHJXQ3J4OUZoNkZuZlVOZjhN?=
 =?utf-8?B?WXNxalErdGwzOTAreGZhNnBMVHkydjJPQkQ0cVFmQjJhcXozV2s2cFQxbHpR?=
 =?utf-8?B?OUxwaGpFOE4yL29MWkk1RVQ1ZUQ4TXdENEZQYzNhMFlscFZjWS9STVZ5K2pP?=
 =?utf-8?B?VC83Rmg2Smd3d0srekpFQTZCcWJ4azltWlpFcUI2QVhDSkY0LzVxNWFuSHdS?=
 =?utf-8?B?RmRYZUlGK1BHSE51WEwwUlRyL0RlNHZuWEoya1o2RTZZdVArQnZ0aUNoTTZV?=
 =?utf-8?B?cWlhSHdOclRrWldXcXVMQkNTSzZxZGFsZWVvSnBJdTU4VWtZekdBVFcveThE?=
 =?utf-8?B?bkFMUXE1WENOa3JTenBaSmFzOEExeFRHQ2JiZndtaGxGZFowRmFDY0YvNDQ0?=
 =?utf-8?B?V0xxTnl2a3EyeFZyV1FYUWlPK25YNzFibDM5d1dpcEk1VHo0VkJEcVI3UWM1?=
 =?utf-8?B?dmtYZmIvZE5oZzU3M1pMRVFIU3NUUVExWTlNVG0wcGU5UUQzQjI2V2wxRHU5?=
 =?utf-8?Q?yynMavceBPkd7/CZe29rE9F9?=
X-Microsoft-Antispam-Message-Info: hrL4VL7FTqRggZjHja1UEg7r1/My6kn+EfGY3AbasSuHQyymZBGZVjluyts7XDWGbzXCy+FNJ4v3RQd+aVdMGQBchUej69ocToupuv46lvNu7goM3DanVaf5UcLpYRV5kmdIi1CyrhCdzX/tcYl2B3I9GiMrDrm6qMm1ELFobYCLEZQfUpy/Idv6Ffr+ch2B
X-Microsoft-Exchange-Diagnostics: 1;CO2PR05MB763;6:lRod2yYQkqrgewaDWtsfKxh2tW3u2TlVrHcFgx93aS58pSrm/XjbCt7MwR+CHcDpnt6SZ17RamZK+DZtdXe2+5e+yY1a52gRc5Y+sp/3k3wheRyYuRFzs0afXtshyhrDmt3IXmtkodiH7zvft1wzhtXvM4vO/S+NcyppDgvlDhgjbTjI2+51R06utd362rPzS+dv/Pul/2fsbU6EHTlci3MqOJuKSbXDJ+kYl6gf/IoSav6SSRF87f5NTcqNec79/Dm5rYyZ9O9Wzuvy7T26x5r36ijcHNkgWG36Vrp+Q1dUxUQYaLahJ/lW/PkBOpHw+MDQu0l7oM+zc/awIN7Jnn39DJrHhYpIyM5YsZTriGyi40/wIprC9ZmczpDjSrQVvYAdHUig9RZqsTKMMwfRhuQLvu1YXrh1fbtPTqHKe8xwHlDM101b1RNhoThXYcwy6l/c7fjyj8ISW6XMKWIBDw==;5:GynnuQ4nEWO+AZ8n1yrArSx/M++lj6qV4k7ZIHHKnQ8G3xpaGopF/D5vDc90xVoICDJKQCq4eXPj2eMTWVNO4Yy29vBr7jmN6R3ep2jdmvm7Z7MDBBorPaqbvCWB/rawrOzdc9tPO1mQa5kbIt5gUO52MrlyLUeC6j6pbEhIglU=;24:6UczjrM7SWvOF6wY8yFmrSPdeAPmcIus44lYg2ZpVIbO90ycfCJllHJtnEL+Bt1NcUOmvV9vOq+DBO//AVYxJTnEF5Rrwlc+WfZ00mDrE/g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR05MB763;7:W2lo+tXM9a3IevlWhdGkHr0yol/Ia991KKllbKlpd/jYDbG+Sf7oZBqJ7gz5mxhOkT4nvz1cHL6c+6rvj+hLldSSDOte5sn8ZRqT+YQvfVoDrpz1r/dcU/+JIxwVQyWuL6odhkK8VQIbLsv9Ey4Sf6B2UgT7Vk/ywBK7EFPgwVf7376qSRahetLA0BPJHqYTnLCnf213A/dGpPS0h0DajgQHS/xGBVN1hO1d8gEed65wz052pF8qNgPOtSAkOV6n;20:k7Ne/1ZapM1lrKWitDjaQ8WUXjRMOf4hp2WMlhnIQOMfX07aht+nRcIhuMt2oEfhl64A9dACGJvnad1y3TptmrRy54Q6OrgNo27mMPTdRgS94ppQt3LmPy8nBStMC3cAFHpeIzECk/peskLe+DDjPdvCo9nq9TTyalN7UW8tsvk=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 08:49:24.5169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae8ced9-e2de-49da-0c81-08d59ad22388
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR05MB763
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 09:52 AM, Daniel Vetter wrote:
> On Wed, Apr 04, 2018 at 04:49:07PM -0700, Deepak Rawat wrote:
>> With damage property in drm_plane_state, this patch adds helper iterator
>> to traverse the damage clips. Iterator will return the damage rectangles
>> in framebuffer, plane or crtc coordinates as need by driver
>> implementation.
>>
>> Signed-off-by: Deepak Rawat <drawat@vmware.com>
> I'd really like selftest/unittests for this stuff. There's an awful lot of
> cornercases in this here (for any of the transformed iterators at least),
> and unit tests is the best way to make sure we handle them all correctly.
>
> Bonus points if you integrate the new selftests into igt so intel CI can
> run them, seel igt/tests/drm_mm.c for an example. drm_mm selftest is also
> the framework I'd copy for this stuff.
>
>> ---
>>   drivers/gpu/drm/drm_atomic_helper.c | 122 ++++++++++++++++++++++++++++++++++++
>>   include/drm/drm_atomic_helper.h     |  39 ++++++++++++
>>   2 files changed, 161 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
>> index 55b44e3..355b514 100644
>> --- a/drivers/gpu/drm/drm_atomic_helper.c
>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
>> @@ -3865,3 +3865,125 @@ void __drm_atomic_helper_private_obj_duplicate_state(struct drm_private_obj *obj
>>   	memcpy(state, obj->state, sizeof(*state));
>>   }
>>   EXPORT_SYMBOL(__drm_atomic_helper_private_obj_duplicate_state);
>> +
>> +/**
>> + * drm_atomic_helper_damage_iter_init - initialize the damage iterator
>> + * @iter: The iterator to initialize.
>> + * @type: Coordinate type caller is interested in.
>> + * @state: plane_state from which to iterate the damage clips.
>> + * @hdisplay: Width of crtc on which plane is scanned out.
>> + * @vdisplay: Height of crtc on which plane is scanned out.
>> + *
>> + * Initialize an iterator that is used to translate and clip a set of damage
>> + * rectangles in framebuffer coordinates to plane and crtc coordinates. The type
>> + * argument specify which type of coordinate to iterate in.
>> + *
>> + * Returns: 0 on success and negative error code on error. If an error code is
>> + * returned then it means the plane state should not update.
>> + */
>> +int
>> +drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
>> +				   enum drm_atomic_helper_damage_clip_type type,
>> +				   const struct drm_plane_state *state,
>> +				   uint32_t hdisplay, uint32_t vdisplay)
>> +{
>> +	if (!state || !state->crtc || !state->fb)
>> +		return -EINVAL;
>> +
>> +	memset(iter, 0, sizeof(*iter));
>> +	iter->clips = (struct drm_rect *)state->damage_clips->data;
>> +	iter->num_clips = state->num_clips;
>> +	iter->type = type;
>> +
>> +	/*
>> +	 * Full update in case of scaling or rotation. In future support for
>> +	 * scaling/rotating damage clips can be added
>> +	 */
>> +	if (state->crtc_w != (state->src_w >> 16) ||
>> +	    state->crtc_h != state->src_h >> 16 || state->rotation != 0) {
>> +		iter->curr_clip = iter->num_clips;
>> +		return 0;
> Given there's no user of this I have no idea how this manages to provoke a
> full clip rect. selftest code would be perfect for stuff like this.
>
> Also, I think we should provide a full clip for the case of num_clips ==
> 0, so that driver code can simply iterate over all clips and doesn't ever
> have to handle the "no clip rects provided" case as a special case itself.
>
>> +	}
>> +
>> +	iter->fb_src.x1 = 0;
>> +	iter->fb_src.y1 = 0;
>> +	iter->fb_src.x2 = state->fb->width;
>> +	iter->fb_src.y2 = state->fb->height;
>> +
>> +	iter->plane_src.x1 = state->src_x >> 16;
>> +	iter->plane_src.y1 = state->src_y >> 16;
>> +	iter->plane_src.x2 = iter->plane_src.x1 + (state->src_w >> 16);
>> +	iter->plane_src.y2 = iter->plane_src.y1 + (state->src_h >> 16);
>> +	iter->translate_plane_x = -iter->plane_src.x1;
>> +	iter->translate_plane_y = -iter->plane_src.y1;
>> +
>> +	/* Clip plane src rect to fb dimensions */
>> +	drm_rect_intersect(&iter->plane_src, &iter->fb_src);
> This smells like driver bug. Also, see Ville's recent efforts to improve
> the atomic plane clipping, I think drm_plane_state already has all the
> clip rects you want.
>
>> +
>> +	iter->crtc_src.x1 = 0;
>> +	iter->crtc_src.y1 = 0;
>> +	iter->crtc_src.x2 = hdisplay;
>> +	iter->crtc_src.y2 = vdisplay;
>> +	iter->translate_crtc_x = -(iter->plane_src.x1 - state->crtc_x);
>> +	iter->translate_crtc_x = -(iter->plane_src.y1 - state->crtc_y);
>> +
>> +	/* Clip crtc src rect to plane dimensions */
>> +	drm_rect_translate(&iter->crtc_src, -iter->translate_crtc_x,
>> +			   -iter->translate_crtc_x);
> We can also scale.

I suggest we leave out scaling for now until someone actually needs it.

>
>> +	drm_rect_intersect(&iter->crtc_src, &iter->plane_src);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(drm_atomic_helper_damage_iter_init);
>> +
>> +/**
>> + * drm_atomic_helper_damage_iter_next - advance the damage iterator
>> + * @iter: The iterator to advance.
>> + * @rect: Return a rectangle in coordinate specified during iterator init.
>> + *
>> + * Returns:  true if the output is valid, false if we've reached the end of the
>> + * rectangle list. If the first call return false, means need full update.
>> + */
>> +bool
>> +drm_atomic_helper_damage_iter_next(struct drm_atomic_helper_damage_iter *iter,
>> +				   struct drm_rect *rect)
>> +{
>> +	const struct drm_rect *curr_clip;
>> +
>> +next_clip:
>> +	if (iter->curr_clip >= iter->num_clips)
>> +		return false;
>> +
>> +	curr_clip = &iter->clips[iter->curr_clip];
>> +	iter->curr_clip++;
>> +
>> +	rect->x1 = curr_clip->x1;
>> +	rect->x2 = curr_clip->x2;
>> +	rect->y1 = curr_clip->y1;
>> +	rect->y2 = curr_clip->y2;
>> +
>> +	/* Clip damage rect within fb limit */
>> +	if (!drm_rect_intersect(rect, &iter->fb_src))
>> +		goto next_clip;
>> +	else if (iter->type & DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_FB)
>> +		return true;
>> +
>> +	/* Clip damage rect within plane limit */
>> +	if (!drm_rect_intersect(rect, &iter->plane_src))
>> +		goto next_clip;
>> +	else if (iter->type & DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_PLANE) {
>> +		drm_rect_translate(rect, iter->translate_plane_x,
>> +				   iter->translate_plane_y);
>> +		return true;
>> +	}
>> +
>> +	/* Clip damage rect within crtc limit */
>> +	if (!drm_rect_intersect(rect, &iter->crtc_src))
>> +		goto next_clip;
>> +
>> +	drm_rect_translate(rect, iter->translate_crtc_x,
>> +			   iter->translate_crtc_y);
>> +
>> +	return true;
>> +}
>> +EXPORT_SYMBOL(drm_atomic_helper_damage_iter_next);
>> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
>> index 26aaba5..ebd4b66 100644
>> --- a/include/drm/drm_atomic_helper.h
>> +++ b/include/drm/drm_atomic_helper.h
>> @@ -36,6 +36,37 @@ struct drm_atomic_state;
>>   struct drm_private_obj;
>>   struct drm_private_state;
>>   
>> +/**
>> + * enum drm_atomic_helper_damage_clip_type - type of clips to iterator over
>> + *
>> + * While using drm_atomic_helper_damage_iter the type of clip coordinates caller
>> + * is interested in.
>> + */
>> +enum drm_atomic_helper_damage_clip_type {
>> +	DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_FB       = 0x0,
>> +	DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_PLANE    = 0x1,
>> +	DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_CRTC     = 0x2,
> I'm confused with what exactly these different types of iterators are
> supposed to achieve. TYPE_FB makes sense, that's what vmwgfx and other
> virtual drivers need to figure out which parts of a buffer to upload to
> the host.
>
> TYPE_PLANE I have no idea who needs that. I suggest we just drop it.
>
> TYPE_CRTC is what I'd want to use for manual upload hw, were instead of
> compositing the entire screen we can limit the uploaded area to 1 or 2
> rectangles (depending upon how the hw works). But those drivers want all
> the crtc clip rects for _all_ the planes combined, not for each plane
> individually.
>
> My suggestion is to drop TYPE_CRTC until someone needs it for a driver.
> And most likely the only iterator we want for TYPE_CRTC is one that gives
> you the overall damage area, including alpha/ctm/gamma/everything else,
> coalesced into just 1 clip rect. So probably an entirely different
> function.

Actually for vmwgfx, the display part of the hardware comes in different 
versions and we'd typically expect both the FB coordinates and the CRTC 
coordinates. In the latest version the surface backing the screen needs 
to exactly fit the CRTC scanout area, and if the FB doesn't do that, we 
need to create a surface that does and copy in the kernel driver. After 
that, as a second step, we need to notify the display system of the 
damaged area in CRTC coordinates.



> Summarizing all this, I'd simplify the iterator to:
>
> drm_atomic_helper_damage_iter_init(iter, plane_state);
>
> And leave the other 2 use-cases to the next patch series. For crtc damage
> we probably want:
>
> drm_atomic_helper_crtc_damage(drm_atomic_state, rect)
>
> Which internally loops over all planes and also takes all the other state
> changes into account. That way you also don't have to fix the scaling
> issue, since your current code only handles translation.
>
> Another bit: drm_atomic_helper.c is huge, I'd vote to put all this stuff
> into a new drm_damage_helper.[hc], including new section in drm-kms.rst
> and all that. Splitting up drm_atomic_helper.[hc] is somewhere on my todo
> ...
>
> Cheers, Daniel

/Thomas
