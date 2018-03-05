Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeCEI4G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:56:06 -0500
Received: from mail-db5eur01on0047.outbound.protection.outlook.com ([104.47.2.47]:27008
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933066AbeCEI4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:56:02 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [PATCH] drm/simple_kms_helper: Fix NULL pointer dereference with
 no active CRTC
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel.vetter@intel.com
References: <1518511456-28257-1-git-send-email-andr2000@gmail.com>
 <20180219143002.GC22199@phenom.ffwll.local>
 <d676eef9-55b2-a7fd-be9b-4d53d59610a9@epam.com>
 <20180220111748.GJ22199@phenom.ffwll.local>
 <38f46c4f-3c0d-cf86-3d50-cf0f9313b205@gmail.com>
 <20180220124919.GS22199@phenom.ffwll.local>
 <94327c23-af1c-a348-5dd2-dfb963b71c96@gmail.com>
 <12b4be99-9003-d566-bda4-2982d5562307@gmail.com>
 <20180305085243.GE22212@phenom.ffwll.local>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <3ce03594-7c99-cdb7-4f79-8d1ad46e6e9b@epam.com>
Date: Mon, 5 Mar 2018 10:55:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305085243.GE22212@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.56]
X-ClientProxiedBy: VI1P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::19) To VI1PR0301MB1952.eurprd03.prod.outlook.com
 (2603:10a6:800:13::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2428a39a-8a1c-4405-6b56-08d58276ea4b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0301MB1952;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0301MB1952;3:7+Aho6DpC0Y/SFQkxRRgRs/6gikj24A9kDeCEiqlLYeWYNYV7CDNG75iz0LzXuNWXMKQ3A6IwwYq8j4fAASRozYP5NWecqTArZPDapH3Jw1UDZuyuffzXyLh+sQBorjBqIn+zFVWff3OenJU31/Eib6GDpRWTroYzCnO72FLK4/r5x/JQzgETzJw6NBUZdrske9UPvlII6qxoaKpk9AVcS84P9lXoAs7++hAmwCJgeWyZv9GSvdPFFIq0StOe1IK;25:qSB3HCheTMVLj+/E2dn769JbETdRz3QWdUx7mCwON8yIm+zYzctWjXpdc18t1iQhERIsI4z2OH25kirNzvssH2bXe4sks1vXGU+wvK5r5GqwKy+FANNPQ/pNWEgV2zU5NbX4HVZIwYJJvwzXq7MvdFWB3/GRRyoMb8Lapxngg+lKcV476bZXmT2qDgB7Q92Bo2JKTwMqH5otqpYeR0bwrgfM3VJSWj6mUb3a/z/jNbFhRendhJmIOX/gfL5AZ/MTSZTtLzIs+wK+PH7QC3jtGe7s22o/otqMnb4VjGrqS7njbBi1zWuy1KNxdqh+MUUSZTvc6AfGtPfNosoc2FVNFg==;31:+ImsixwKWU4eIMAdAKF3HuB97EAZugA1Ys560+eiWQPrxlopMfrbC1/77UF0VTjK0jvwDZ2smRtZWZu55FZ2vIT7YmufDjXJGsbkpcXJZrMgW6DB9faeeTGWlGiP0hneKfeCBqG7dgfeEF827PlrXeThQlU8wvDfaZ9x7wSqIvtp2gkwQUxaVEXHrZReoAjGjkHVE+mev4eEoghNKzFbqrZ9z5wnoC801byU6EuhtN0=
X-MS-TrafficTypeDiagnostic: VI1PR0301MB1952:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0301MB1952;20:zJOQRWndtuMPPxnacmXYJ+uH1c2BugFSsG06Rl+JNLRPNnwl1KgDblvOMu90ON+w4moHJJQ+aoNNf0ku9AxVB/dAuffYq3RoccHVqMrYvdTUXF1Kgaf/7RQdG7yVi9kFTrW8rSDVom1l8gNCUHbG2NQPAV1Dn2cbo8dfwlDiMNWoS5fYCzZelR8JiNxzsZvUfJvO/QYXQHBIHaQTsUtu3N+6vGPb+trADU7H41KaGAixBSodH5x8W8zbkr8TI8ckf8e4JMk2zUlIGQ1c8DZs9tvnXqgzmWfhh4BrSSA4f4Msep43zRuat068uNDk3X40MoG4t7hwiSj2XBjChq03vdrmYEvJcAKr/CmwozlMJ0HxfakjPCUlOyjElYiGYEW2wz5hvn1JngaDXZvnYTtn+Esjk4E+Uk78HStL0+L1PFWJoYvxGBljlOkjS/Cl3gbDgTfA+8QbrmjZLlUMrXzcnZrDuzdPy6QSGFcQ8u9k4bYIRPc+p001vS+qdVEPYT4P;4:X4IuH9JqghQw8ZqgG5WvUnEtP4J/5wqe4XlQ+pSqSV8Gw7B0wtEu3PoiGxWifv/QeWA5XSG9BHaC6TwtuprvexdK3zbcdntWYeyK8NnDPA25H5Kuchj0V2FKCpeieOGiM5VY8R+W4Ng/tzXTCnvgTDYG4MB2xQyEcIIIznuVrLKcSw3PZo2RTMi7AFokTBzJc4hDgMmr3hFoec6nXlB2+C3+Cbb1kiPiqj9rs/2FubnMohhZsI7QTUG73cTAatYThntj272eKk3RhGdvbmBRYgcRGqp5mmlddcgJV4LTbdYZqekpLn9KUPS+SgpIkP3fAt/k9/4JGVrmhwsb+NSP/TqyFg5KEZ40/FPUB2LMda4=
X-Microsoft-Antispam-PRVS: <VI1PR0301MB1952CD2D82551ABFC7512F95E7DA0@VI1PR0301MB1952.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240)(4114951738403);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0301MB1952;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0301MB1952;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39380400002)(39860400002)(346002)(376002)(396003)(199004)(189003)(51444003)(81156014)(81166006)(36756003)(97736004)(68736007)(67846002)(93886005)(16576012)(8676002)(106356001)(55236004)(8936002)(53546011)(386003)(59450400001)(2870700001)(58126008)(2486003)(23676004)(305945005)(52146003)(76176011)(64126003)(7736002)(25786009)(52116002)(6116002)(86362001)(39060400002)(80792005)(3846002)(5890100001)(316002)(2906002)(31686004)(6246003)(186003)(31696002)(16526019)(50466002)(6306002)(6666003)(26005)(65826007)(2950100002)(77096007)(6486002)(53936002)(229853002)(65806001)(65956001)(66066001)(478600001)(47776003)(5660300001)(105586002)(966005)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0301MB1952;H:[10.17.182.9];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzMDFNQjE5NTI7MjM6Y3NHR25jaEJ5Y1FHcHFZVHYwRVhjNmtE?=
 =?utf-8?B?a2RBcDZWaEpHTGIwUG1nS3h2Z2tmZHgxV0QwNkQ4MUVteXZlQUZUNk52eElq?=
 =?utf-8?B?N2Nrd0wyemViY05uZ1ZOWC9zSkthWFdhZGhpblZDTkQ1RmtTb25VUHJoSlhu?=
 =?utf-8?B?VmNrVXcxWGcrQzl5dVpDc21tdDY2YWtCbTZsQXI3MVNndDA4L0U0RHdFK0o0?=
 =?utf-8?B?S1ZobDIvVENOclJPaXFKbnZKS3pyQzJtUDBwTGl2d2ZLZVhTcERCT1k4akRl?=
 =?utf-8?B?cTNwV2dzU0xOZ0hkOVZYZXZvZHYvSVdyZXhCcUltQ3QzOFV1SEdHTjViMVMv?=
 =?utf-8?B?SU96bm9mdFhVN1BiNkxOVEM3Ymg1TE5INXdmWHRNM2hkc3hnYXlRSHFLaS90?=
 =?utf-8?B?OGt6cXVZbWpkaG44RzZuV3FDYzRsMTlqNGI0ZzNTQ09UYkpWRnU2ZUhtK0VC?=
 =?utf-8?B?VldsM2RaVkpxYUY2MC9idklOQ2Fvc2Q0RER0MXhJNW5PWjBoOHQ0M2tMN29w?=
 =?utf-8?B?REtjUVRybXNvZnB5cnZGL1BtWFlLTU5qNWxtaWNDS3g4OWFja20veFpYeUE4?=
 =?utf-8?B?OTFHUDhTNlh3bXpoVENhbGdrOElCTUhmWkR0WEh4bkxBTkl6Skpjc1JmeEpN?=
 =?utf-8?B?YnU1Z2V4dW90ZkVaa1FVb2Q2bDl5ZW5TZGxXOHlGK3RxemM5RlBXRXBTV2dD?=
 =?utf-8?B?UUFKREQ2WS9TcHJ3NXR1TUs0U1ZsaTFld3hDdmY1MlNMeTlnc0pvSmxWcm9Q?=
 =?utf-8?B?TkxXdUpROFovaUN6YzlQdUFzYlB6Y2cvQ0ZMRktGZE5OWkEwbnZqaTVUc1VQ?=
 =?utf-8?B?bmFZM2VSSzhlemw5YUd3OWxkQUdXeHZkN1N4R0lYOVNzWGk5bGZOc1ltVDUz?=
 =?utf-8?B?dDI5MFRtRnp0aWVlNWNTSkhiVnlxeituNUJrQjd3aDB5NlMrRnVHSE9sbnlO?=
 =?utf-8?B?MkVNZ0VkeU51bnNwTk1iSjhZSkRPYWZSZndpN0xQSGZuQjlXTXJTMDkxV1lQ?=
 =?utf-8?B?RzNKNUZvenZ1OHV3Qkk5WHZCd2xXeHJ6TTRldmpTSlpDZ0VQbG9KRU5kUk5Q?=
 =?utf-8?B?dEQ3RW5PMXFoYjgzM1h0ZnE0ekdsSDNhaUpoLzdDVlZUTWkzLzIrSGVzY2Z6?=
 =?utf-8?B?NmcxV21qc2FhYVF5UVpVS0pFTmpTaDJISXlENTFVQzFmK3RWNUZnQWd2UGlV?=
 =?utf-8?B?UDZxYnhJZnFxM1hTZ2hMWXh2TXBDa3dGbnhhK1dWd0R4dFMwUk5JNWlUSXlt?=
 =?utf-8?B?RXRod05Idy9ZWFRKWU4vSmRuM2QvaWhldWU2Rmk5KytadXgvUGJaYlI3S1d4?=
 =?utf-8?B?RVRqdGVCNnd5R28yRnV1aG5WdDZmNndOM1hxdTlPanB3NVdTYU1BalVxcUFs?=
 =?utf-8?B?Ty80Q1VCeG9sVDNKenFnNStDZTV1eDBsSm1IcUdqUm1PWGdla2NobmFZemNh?=
 =?utf-8?B?eE40UXRLNCtXVXk0L2JoNTc0dGpmOXR1TmlYU2JLMWEvNWdZVzRkT01xbmlj?=
 =?utf-8?B?NW92WEZWQjdubUc3Z2ZDdm00R1hkcStJRmNIUFFsTzM5VXMzTURmWTk5UEFC?=
 =?utf-8?B?RkF6UFloTUlUVU9aNkdYcnNJUnB4NStRYUNMUTVaeFRpeVlXWVlMYTc3NHRU?=
 =?utf-8?B?WFNIa01TU0VVQUZwMktEZlJ4bU5uejBpVjB0TUlTWWt0N1RWcFdaMHNTM1N5?=
 =?utf-8?B?ODJRMGkzd0hzQjNJa2xZcHpyWVBLbHp6d2oyRHp1cE4zR1NaTXNyK3JOY3hQ?=
 =?utf-8?B?enBPTUVacWtwaUdwbDdDV0lsa2N5OWpFSTlZU0dlMlZwaEhzQ2xlaGZZS1kr?=
 =?utf-8?B?WE5KT04wdkRWWnRTbXU5eWk0MUhyeXR1S3BjbnZUMkdzTTdPcVJhREJTSXU3?=
 =?utf-8?B?SWhsRHVia3NIVXkzY1dIZWx4S0Eyczg2VDhSaDZldlNvVDFpbXVaNzNFYk9k?=
 =?utf-8?B?YUpGNnNjOGtFVFY2UjZ0cElMYVV0LzNKMStWTEdDQ0h1emdGWE0rSGpLREln?=
 =?utf-8?B?Qm1rTDBwZ29tTGNVUWxyeHgvdDJHYUhLUlJMMmE2Y241czAvR1ZNOVRlNkRz?=
 =?utf-8?B?dHV6WDYrc0wrdEVTdEFpTEIrSm8vbjhLcWNIWE1NTmUrR3JENDlJbk9LZ0o0?=
 =?utf-8?B?Q2dqdz09?=
X-Microsoft-Antispam-Message-Info: 4DGT1i1uNcvX4OJ8J1rAgvO+3JN122Wba5rZzO1PffD0DxYPFX3GFLDCrjj+L6KMs58GzQh9SlmKdoD03k68GgK1l++wOudNeYGwspgTO/vaT47449MH16R8XakuT4NH3ZxfpFSoVOKGLm/XJnBEnp46SD5TAwE4t6yIEUbWdIfGB378KiY29zWWF+wmG4rS
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0301MB1952;6:e8AjPxF7oZexnHUif8kQQsaDnubvB9N+75p3p+7R7G8nAxi20VUO1cuQQM+0v6xUcvzbkGKKlAIkpEzIsGHsTh6NculG7ZO669NYopBcq355Xvad/i8NDqHtX665ypbYkAECeWQ7W7+URXFf00zwYDQ5ia7sh7hVdsyMkyo8dsTZLKUTQp+vmnQONFW7E3pQl4wBK71CPScWSFkclsvLnYGezizSAAyR1YiK+Kru1Mxuv2jKzLhqcottJwSiOCQo/KfD4Lc/eZLNWDQFcWu7N8+5fMrD4k3ueJr8fUktykb186FzVHnBGZgl4OROF/2H1/BTGtR3Bp+RK0AawUuY22rIQM5wPuYxy/jC5MXV+MM=;5:LWf/IT2PRA4lTW697eBcXhNDvztEdXIRb7aGUD2OG8jjWnLOaRv5F3Vja5z9HiPrpNzuDAqUhD6zH2tXhDJDF6xHHk4AYhAyI98zdU0GMltIQrD+pZHaQw7gaC8wqKEfTan/brFM+KDAO2SZYe+l7dtZG85Odzm3ragiw89Azx8=;24:ZdqPSQGjss3U3Pfq+mQOzrN9xVrwejiaDURRiaEqKDlbL2fNOjIFCffLkncgmPfYXPy5dvo091o6aTU9nbQoalcQ5KJqLLEVi0Lxdkvnqyg=;7:/0+sp6GUe9nqHpCHwgz2L8CA74FCWWqrLTRLaEqDP52vz5pF4623s0lOXNi/tlfWJSjv9ssIEVHquoU5TdklXgu3eZMk8vC3GAZRlE9BKMp6pl/AgBfAcastNEEkFWh5EC+OByhax2tjPyhX3mmgAVcXUF8nwinF1s7ycaR1O6C2yxD/vmWVcGxjdo8fb/g3h1oiZBLTlRl0nxr7XxNlk0nY2aZSeg4XadUL5nCzH67qenDgATFpfa8feVseC2dK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 08:55:58.6668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2428a39a-8a1c-4405-6b56-08d58276ea4b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB1952
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 10:52 AM, Daniel Vetter wrote:
> On Tue, Feb 20, 2018 at 03:29:07PM +0200, Oleksandr Andrushchenko wrote:
>> On 02/20/2018 02:53 PM, Oleksandr Andrushchenko wrote:
>>> On 02/20/2018 02:49 PM, Daniel Vetter wrote:
>>>> On Tue, Feb 20, 2018 at 02:36:05PM +0200, Oleksandr Andrushchenko wrote:
>>>>> On 02/20/2018 01:17 PM, Daniel Vetter wrote:
>>>>>> On Mon, Feb 19, 2018 at 04:58:43PM +0200, Oleksandr
>>>>>> Andrushchenko wrote:
>>>>>>> On 02/19/2018 04:30 PM, Daniel Vetter wrote:
>>>>>>>> On Tue, Feb 13, 2018 at 10:44:16AM +0200, Oleksandr
>>>>>>>> Andrushchenko wrote:
>>>>>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>>>>>
>>>>>>>>> It is possible that drm_simple_kms_plane_atomic_check called
>>>>>>>>> with no CRTC set, e.g. when user-space
>>>>>>>>> application sets CRTC_ID/FB_ID
>>>>>>>>> to 0 before doing any actual drawing. This leads to NULL pointer
>>>>>>>>> dereference because in this case new CRTC state is NULL and must be
>>>>>>>>> checked before accessing.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Oleksandr Andrushchenko
>>>>>>>>> <oleksandr_andrushchenko@epam.com>
>>>>>>>>> ---
>>>>>>>>>      drivers/gpu/drm/drm_simple_kms_helper.c | 6 ++++--
>>>>>>>>>      1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git
>>>>>>>>> a/drivers/gpu/drm/drm_simple_kms_helper.c
>>>>>>>>> b/drivers/gpu/drm/drm_simple_kms_helper.c
>>>>>>>>> index 9ca8a4a59b74..a05eca9cec8b 100644
>>>>>>>>> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
>>>>>>>>> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
>>>>>>>>> @@ -121,8 +121,10 @@ static int
>>>>>>>>> drm_simple_kms_plane_atomic_check(struct
>>>>>>>>> drm_plane *plane,
>>>>>>>>>          pipe = container_of(plane, struct
>>>>>>>>> drm_simple_display_pipe, plane);
>>>>>>>>>          crtc_state =
>>>>>>>>> drm_atomic_get_new_crtc_state(plane_state->state,
>>>>>>>>>                                 &pipe->crtc);
>>>>>>>>> -    if (!crtc_state->enable)
>>>>>>>>> -        return 0; /* nothing to check when
>>>>>>>>> disabling or disabled */
>>>>>>>>> +
>>>>>>>>> +    if (!crtc_state || !crtc_state->enable)
>>>>>>>>> +        /* nothing to check when disabling or
>>>>>>>>> disabled or no CRTC set */
>>>>>>>>> +        return 0;
>>>>>>>>>          if (crtc_state->enable)
>>>>>>>>> drm_mode_get_hv_timing(&crtc_state->mode,
>>>>>>>> Hm, this is a bit annoying, since the can_position =
>>>>>>>> false parameter to
>>>>>>>> drm_atomic_helper_check_plane_state is supposed to
>>>>>>>> catch all this. Would
>>>>>>>> moving all the checks after the call to that helper,
>>>>>>>> and gating them on
>>>>>>>> plane_state->visible also work?
>>>>>>> Yes, it does work if this is what you mean:
>>>>>> I wasn't sure, thanks for figuring this out!
>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c
>>>>>>> b/drivers/gpu/drm/drm_simple_kms_helper.c
>>>>>>> index a05eca9cec8b..c48858bb2823 100644
>>>>>>> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
>>>>>>> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
>>>>>>> @@ -122,14 +122,6 @@ static int
>>>>>>> drm_simple_kms_plane_atomic_check(struct
>>>>>>> drm_plane *plane,
>>>>>>>            crtc_state =
>>>>>>> drm_atomic_get_new_crtc_state(plane_state->state,
>>>>>>> &pipe->crtc);
>>>>>>>
>>>>>>> -       if (!crtc_state || !crtc_state->enable)
>>>>>>> -               /* nothing to check when disabling or
>>>>>>> disabled or no CRTC
>>>>>>> set */
>>>>>>> -               return 0;
>>>>>>> -
>>>>>>> -       if (crtc_state->enable)
>>>>>>> - drm_mode_get_hv_timing(&crtc_state->mode,
>>>>>>> -                                      &clip.x2, &clip.y2);
>>>>>>> -
>>>>>>>            ret =
>>>>>>> drm_atomic_helper_check_plane_state(plane_state,
>>>>>>> crtc_state,
>>>>>>> &clip,
>>>>>>> DRM_PLANE_HELPER_NO_SCALING,
>>>>>>> @@ -138,6 +130,13 @@ static int
>>>>>>> drm_simple_kms_plane_atomic_check(struct
>>>>>>> drm_plane *plane,
>>>>>>>            if (ret)
>>>>>>>                    return ret;
>>>>>>>
>>>>>>> +       if (!plane_state->visible || !crtc_state->enable)
>>>>>>> +               return 0; /* nothing to check when
>>>>>>> disabling or disabled */
>>>>>> if (!plane_state->visible) {
>>>>>>      WARN_ON(crtc_state->enabled);
>>>>>>      return 0;
>>>>>> }
>>>>>>
>>>>>> The helper call above should guarantee this.
>>>>> Yes, but I still see cases when crtc_state is NULL, thus
>>>>> making crtc_state->enable to fail
>>>> Right, when the plane is completely off there's no CRTC state. Correct
>>>> check should be
>>>>
>>>>      WARN_ON(crtc_state && crtc_state->enabled);
>>> ok, will update with this additional check
>> huh, this indeed solves the NULL pointer dereference, but floods a lot
>> with every page flip I have, e.g. !plane_state->visible == true
>> and crtc_state is not NULL and crtc_state->enable == true,
>> thus firing WARN_ON.
>> Is this something wrong with my use-case/driver or it is still legal
>> to have such a configuration and leave it without WARN_ON and just
>> return 0?
> 1 week of vacation later I have to admit that this WARN_ON is completely
> bogus :-)
np ;)
> Sorry for all the confusion, pls leave it out.
> -Daniel
>
>>>>>>> +
>>>>>>> +       if (plane_state->visible && crtc_state->enable)
>>>>>> Similar here.
>>>>>>
>>>>>>> + drm_mode_get_hv_timing(&crtc_state->mode,
>>>>>>> +                                      &clip.x2, &clip.y2);
>>>>>>> +
>>>>>>>            if (!plane_state->visible)
>>>>>>>                    return -EINVAL;
>>>>>> This can now be removed, the plane helper takes care of checking for
>>>>>> plane_state->visible != crtc_state->enable. Please also remove.
>>>>>>
>>>>>>>> We'd need to add a guarantee to
>>>>>>>> drm_atomic_helper_check_plane_state that
>>>>>>>> it can cope with crtc_state == NULL, but I think that's a good idea
>>>>>>>> anyway. Atm it shouldn't end up looking at the
>>>>>>>> crtc_state pointer in that
>>>>>>>> case.
>>>>>>> It doesn't look at it at the moment
>>>>>>>> Otherwise we'll just go with your fix, but it feels
>>>>>>>> all a bit too fragile,
>>>>>>>> hence why I want to explore more robust options a bit.
>>>>>>> At list with the change above it passes my test which failed
>>>>>>> before. Although I cannot confirm it works for others, but it
>>>>>>> certainly does for me.
>>>>>>>> -Daniel
>>>>>>> Do you want me to send v1 with the code above?
>>>>>> Yes please, with my above cleanup suggestions.
>>>>> Please see the patch under test attached (I believe it is what
>>>>> you mean,
>>>>> with the only change that
>>>>>       if (!plane_state->visible) {
>>>>>           *if (crtc_state)*
>>>>>               WARN_ON(crtc_state->enable);
>>>>>           return 0;
>>>>>       }
>>>>> check is used).
>>>>>
>>>>> Whith this patch + additional logs I have:
>>>>>
>>>>> [   18.939204] [drm:drm_ioctl [drm]] pid=2105, dev=0xe200, auth=1,
>>>>> DRM_IOCTL_MODE_ATOMIC
>>>>> [...]
>>>>> [   18.939681] [drm:drm_atomic_set_crtc_for_plane [drm]] Link
>>>>> plane state
>>>>> 00000000c302cbbf to [NOCRTC]
>>>>> [   18.939822] [drm:drm_atomic_set_fb_for_plane [drm]] Set
>>>>> [NOFB] for plane
>>>>> state 00000000c302cbbf
>>>>> [   18.939963] [drm:drm_atomic_print_state [drm]] checking
>>>>> 000000000bc224e7
>>>>> [   18.939988] vdispl vdispl.0: [drm] plane[29]: plane-0
>>>>> [   18.940003] vdispl vdispl.0: [drm]   crtc=(null)
>>>>> [   18.940018] vdispl vdispl.0: [drm]   fb=0
>>>>> [   18.940032] vdispl vdispl.0: [drm]   crtc-pos=0x0+0+0
>>>>> [   18.940048] vdispl vdispl.0: [drm]
>>>>> src-pos=0.000000x0.000000+0.000000+0.000000
>>>>> [   18.940067] vdispl vdispl.0: [drm]   rotation=1
>>>>> [   18.940199] [drm:drm_atomic_check_only [drm]] checking
>>>>> 000000000bc224e7
>>>>> [   18.940226] ================================= plane_state->visible 0
>>>>> crtc_state           (null)
>>>>> [...]
>>>>> [   18.978146] [drm:drm_atomic_set_crtc_for_plane [drm]] Link
>>>>> plane state
>>>>> 000000006bd50580 to [CRTC:30:crtc-0]
>>>>> [   18.978292] [drm:drm_atomic_set_fb_for_plane [drm]] Set
>>>>> [FB:35] for plane
>>>>> state 000000006bd50580
>>>>> [   18.978993] [drm:drm_atomic_set_mode_prop_for_crtc [drm]] Set
>>>>> [MODE:1024x768] for CRTC state 00000000e5a28f6a
>>>>> [   18.979425] [drm:drm_atomic_check_only [drm]] checking
>>>>> 000000000bc224e7
>>>>> [   18.979540] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]]
>>>>> [CRTC:30:crtc-0] mode changed
>>>>> [   18.979632] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]]
>>>>> [CRTC:30:crtc-0] enable changed
>>>>> [   18.979708] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]]
>>>>> [CRTC:30:crtc-0] active changed
>>>>> [   18.979792] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]]
>>>>> Updating routing for [CONNECTOR:28:Virtual-1]
>>>>> [   18.979877] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]]
>>>>> [CONNECTOR:28:Virtual-1] using [ENCODER:31:None-31] on [CRTC:30:crtc-0]
>>>>> [   18.979960] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]]
>>>>> [CRTC:30:crtc-0] needs all connectors, enable: y, active: y
>>>>> [   18.980139] [drm:drm_atomic_add_affected_connectors [drm]]
>>>>> Adding all
>>>>> current connectors for [CRTC:30:crtc-0] to 000000000bc224e7
>>>>> [   18.980184] ================================= plane_state->visible 0
>>>>> crtc_state 00000000e5a28f6a
>>>>> [   18.980205] crtc_state->enable 1
>>>>>
>>>>> *[   19.022608] WARNING: CPU: 1 PID: 2105 at
>>>>> drivers/gpu/drm/drm_simple_kms_helper.c:137
>>>>> drm_simple_kms_plane_atomic_check+0xdc/0xf8 [drm_kms_helper]*
>>>>>
>>>>> [...]
>>>>>
>>>>> [   19.113601] ================================= plane_state->visible 0
>>>>> crtc_state 00000000e5a28f6a
>>>>> [   19.113623] crtc_state->enable 1
>>>>> [   19.113792] WARNING: CPU: 1 PID: 2105 at
>>>>> drivers/gpu/drm/drm_simple_kms_helper.c:137
>>>>> drm_simple_kms_plane_atomic_check+0xdc/0xf8 [drm_kms_helper]
>>>>>
>>>>> [...]
>>>>>
>>>>> And finally
>>>>>
>>>>> [   19.340249] ================================= plane_state->visible 0
>>>>> crtc_state 0000000036a1b1f5
>>>>> [   19.340271] crtc_state->enable 0
>>>>>
>>>>> So, it seems that crtc_state can still be NULL if
>>>>> "!plane_state->visible"
>>>>> making
>>>>> NULL pointer dereference, so we need a check for that.
>>>>> Yet, !plane_state->visible && crtc_state->enable makes WARN_ON to fire
>>>>> always. So, probably we may want removing it.
>>>>>> Thanks, Daniel
>>>>> Thank you,
>>>>> Oleksandr
>>>>>   From dbcce708b237740158a2c16029c56a579324f269 Mon Sep 17 00:00:00 2001
>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>> Date: Tue, 13 Feb 2018 10:32:20 +0200
>>>>> Subject: [PATCH] drm/simple_kms_helper: Fix NULL pointer
>>>>> dereference with no
>>>>>    active CRTC
>>>>>
>>>>> It is possible that drm_simple_kms_plane_atomic_check called
>>>>> with no CRTC set, e.g. when user-space application sets CRTC_ID/FB_ID
>>>>> to 0 before doing any actual drawing. This leads to NULL pointer
>>>>> dereference because in this case new CRTC state is NULL and must be
>>>>> checked before accessing.
>>>>>
>>>>> Signed-off-by: Oleksandr Andrushchenko
>>>>> <oleksandr_andrushchenko@epam.com>
>>>>> ---
>>>>>    drivers/gpu/drm/drm_simple_kms_helper.c | 15 +++++++--------
>>>>>    1 file changed, 7 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c
>>>>> b/drivers/gpu/drm/drm_simple_kms_helper.c
>>>>> index 9ca8a4a59b74..f54711ff9767 100644
>>>>> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
>>>>> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
>>>>> @@ -121,12 +121,6 @@ static int
>>>>> drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
>>>>>        pipe = container_of(plane, struct drm_simple_display_pipe,
>>>>> plane);
>>>>>        crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
>>>>>                               &pipe->crtc);
>>>>> -    if (!crtc_state->enable)
>>>>> -        return 0; /* nothing to check when disabling or disabled */
>>>>> -
>>>>> -    if (crtc_state->enable)
>>>>> -        drm_mode_get_hv_timing(&crtc_state->mode,
>>>>> -                       &clip.x2, &clip.y2);
>>>>>          ret = drm_atomic_helper_check_plane_state(plane_state,
>>>>> crtc_state,
>>>>>                              &clip,
>>>>> @@ -136,8 +130,13 @@ static int
>>>>> drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
>>>>>        if (ret)
>>>>>            return ret;
>>>>>    -    if (!plane_state->visible)
>>>>> -        return -EINVAL;
>>>>> +    if (!plane_state->visible) {
>>>>> +        if (crtc_state)
>>>>> +            WARN_ON(crtc_state->enable);
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>> +    drm_mode_get_hv_timing(&crtc_state->mode, &clip.x2, &clip.y2);
>>>> lgtm. With or without the bikeshed to pull the crtc_state check into the
>>>> WARN_ON.
>>>>
>>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Thank you
>>>> Please resubmit as a stand-alone patch, patchwork can't pull patches out
>>>> of attachments :-/
>>> oh, that was for demonstration purpose only, so we
>>> are on the same page and see the patch we are discussing ;)
>>>> -Daniel
>>>>
>>>>>          if (!pipe->funcs || !pipe->funcs->check)
>>>>>            return 0;
>>>>> -- 
>>>>> 2.7.4
>>>>>
>>>>> _______________________________________________
>>>>> dri-devel mailing list
>>>>> dri-devel@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
