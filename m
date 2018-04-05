Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeDELwM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:52:12 -0400
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:23005
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751642AbeDELwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:52:10 -0400
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
 <0edfe662-6463-a143-e00a-d3d4bc06a229@vmware.com>
 <20180405101007.GU3881@phenom.ffwll.local>
From: Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <b819de9c-f4e0-82cc-1ea4-21723070cc7e@vmware.com>
Date: Thu, 5 Apr 2018 13:51:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180405101007.GU3881@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: AM5P194CA0018.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::28) To BLUPR05MB755.namprd05.prod.outlook.com
 (2a01:111:e400:89e::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3da5e31-71ac-4723-5d27-08d59aeba848
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR05MB755;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR05MB755;3:StSmFqryrBAlR+7ROql+uU3tXT0JJFlANX51/LZTknwvwbRXXx/chIHT3TdTDkQNkGydxXxAKt6iwfKiSLhY8b/EpYKO6biw1APYvV5tpbnw6MMs8i3Adu3iQPyq22/FpRV70OvYfeCUGgNV6yoSyT1r3ckME3lNx77wvHuslLbyFXb/Zi5xxssJToIiGECrwY+lnx/ABeg4cIhbJfj38HurNNaw/cerF/1z94HPZa6p51xBWEYEq1pF/LhEnLXq;25:GvqX6yJ3QoxQnEqjZ65jYcU8Jd60cW3N4wUGkgpuREf31GyEiVbcVB4u67rSy5HwkAbwQCxonAxS8+kdnMdrNOmDiWzQaMm4+/mEoRK0ROOe7HJzRV2h3RjhLEOl2oxbOTc7OwkewO5RjEwf4d6ReQ62bEskvCVgn2vrOhLY3wUfgycYp7XnVO0iejZpzUqqtBb47zX46npKdhGu36xnjOCGnIp+yp4JrHzXY0socgH6JWyFb5PPF0l2rBtplxU8gr3zeVe7hVVNisxM1YtDo7KRVkvyVCSHOAro9Y15NS2DdC6+TDkwawt2/LNRdHHYLSzQvMLeLtVo820yJVIpgQ==;31:GR/v7YLGyQl0T4W7+x2OSmqoZxIHXwO5XoKYp9VA3e2RiXNDvyn9/aUrGKvdtMfrjyAHmZHBZ7/TlNaScROsm+FcqCXD5HF0KnPl/8TktGbypvOzEOYIUy9j8bEj5NEiHoZoVCCr7rIrssnuRM/niJXl+PnO+RYv2Z4ypXXmoAYOL/OiXQfl53uoBE8fHWG222LP9M1avhRUVToS5PUUrOT22P1KPDGn3BTsGiodZGo=
X-MS-TrafficTypeDiagnostic: BLUPR05MB755:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR05MB755;20:v3/HrzkGJeB2lc4gz512VZZMiqQprBVa9pVJANzyGguV82PmWzSrEI3tNsP6FBBnWZBwNUgePQva/bTtrfwFh05HZwbpsc4Z0n8e9PmLGXx0mKSgtaAeT6CTFCs4hMndIatLEVmUZm0Hi8vsbwbeEfZCNBA28y1qFnQb49WqBWV6Z3YRDKzwjq320epI/AnGTu19foNrQs4xuTjaXfg9ejW3XFlI1WjwW4VUis7XmSPLxGHZOr8imuFF4nO2FN+ftQfBfqLsK4pYACz7/Rn7yrc2AiXPL3ha2Fr9+pjEJ7+PGO3gaCiQpiLktwmIJb0ZpgFab5S5Hw8mb6ZaFVfpNb56/0Jx3YdqkPUdTuFrDTSyySehjHBi7Rd5m2Wo49JS3LWLKWFH5mP2M5YirkXEt1DAOqX8LbNslq14r8V8RdwCszbkExk+GZj615IbVTRFxQZ+O2veAFSB6BOZ46r4peR1eI7Xtjw8asMsLZ6ifYRF7M0hV1ppnjyXvLhZu7ov;4:RlFLcUUcUEn288Sj7cPUCGKSSkQUAW0MzdeiZ1MpTtfh9PBzJjnPZ+CKsiRF8pgsV0n7kMqe1yeQ1ncE4I5nryd9krMXxJ7X4oJoP9sXb9IUERXompsjPlJ5Dvo5cASQMwoFB4N5FHIZU+yNr7IKXG15dJdCzUJ4ecNPX4V51ypT3NCdAKeOiDARXWC7vskyG+M8BCVyefko2PeWGc3GS8KWPBZrZgqArVqgdHrvSkaxShRENj0TxxNvfdEEjT+MgxdSw4j2g+IoS8nfBZ3CuRcd873LXpnkupLfBuZLKpxBMBqzS6ALcqVejW40Qagi
X-Microsoft-Antispam-PRVS: <BLUPR05MB755AA4AFBAC684B0C537850A1BB0@BLUPR05MB755.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:BLUPR05MB755;BCL:0;PCL:0;RULEID:;SRVR:BLUPR05MB755;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(6116002)(31696002)(5660300001)(305945005)(58126008)(478600001)(7416002)(52146003)(59450400001)(2486003)(23676004)(8936002)(81166006)(8676002)(65826007)(230700001)(81156014)(229853002)(386003)(6666003)(6486002)(76176011)(86362001)(6506007)(93886005)(106356001)(7736002)(25786009)(36756003)(53546011)(316002)(6512007)(26005)(476003)(956004)(2616005)(39060400002)(64126003)(97736004)(65956001)(2906002)(52116002)(446003)(186003)(47776003)(11346002)(67846002)(7520500002)(68736007)(66066001)(105586002)(486006)(16526019)(53936002)(65806001)(31686004)(6246003)(3846002)(50466002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR05MB755;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjA1TUI3NTU7MjM6Y0U4a3oxOTRKcENtcGpwNmg1ZVAyNmRtTXVr?=
 =?utf-8?B?WmExTjBMZEgxZkM3VmRZcU0zUXBWV09tZnZ5d3JQTlp5MGg4RWF0b0tBU1Za?=
 =?utf-8?B?NnFrQ3luY0NNYjczRjZiR0pFdXFHUzZINDVrWml2T2pXMzFLOGttaHh6M1U0?=
 =?utf-8?B?N0hDZ3IvNWxMZjRidFpTNFVoOXdOazRMbTcvZTJQak5UUllUZjB2NTk5WVVk?=
 =?utf-8?B?RGQvMnZiS2JLR1ZWMGh1Mi9XcVRWMFhLcGIvS0FqODUwK05aZ0pFZWtVUnMw?=
 =?utf-8?B?eFdZZE83RzcyWmZKR3pNU3ZIODRMb2FWdTZsWk9FeDZJS2lUYU5sRElSOW85?=
 =?utf-8?B?VDRCTU1ONFk0cEoydEt2dzBSb0ROVW1zb0FiYzdyNGw4OTU1ZWVPWFBlQTZr?=
 =?utf-8?B?eXRNNDYxRlQ2d3lVakt0TTAxZ1FEWWEzSXBhWGV2cmd3bStzdTVmaVNBNTU1?=
 =?utf-8?B?M1g1ZDMyU3dUYk01SXd3YjZHUUgrL2xOekR5L3VMWjQ5b0l2TG1qQ0cweUpY?=
 =?utf-8?B?ZnZmRURGSjcraEl1VnE2bXRFUXZkZFNLQmdCcVZDYzZ3TW0rT00weG9UN1Rt?=
 =?utf-8?B?alJTNlo1QWlFbzlRSmlwM1lmeWtkRXNhUXVDczcxUWlRdjhaWHI4cFU0dTl2?=
 =?utf-8?B?ZlZSRnZuaXlJQjI3YitqTUN5bDVjZzNaS2F2THVxbkNiY3Era3ZtZ1gvbzJh?=
 =?utf-8?B?WldPZ29qd085aG9TZUF6REFtWTdpNDhtNnA3cmtYUlFpZlg0OGdCZHVpeWxz?=
 =?utf-8?B?UzVvT2FFcTlGa0RyVHBBVWNMd3BRVUlQMk1uRFhrV21Ka0dGYXBvTDBKZFNQ?=
 =?utf-8?B?VWNSdDFSUzF4WldMU3FNQUI1YUlyOWlqb2JkbDhQamNLZmlOTnI0Z2ZDNFNx?=
 =?utf-8?B?MHRzZ0w2Um45bFlGemUrVXlBbjhMQWNlQlFzSk93ZjBJODVjNDFRTTRIczJN?=
 =?utf-8?B?MG1WZkdoOXg1MFViMnVJcUoxUXhHRmMxQ1NzNDd3MlZKZU5NcTJsUVB4c1F0?=
 =?utf-8?B?ZXRaVHV5MUd5Tjhzb0FzaklmQ05qZ0p6bmNZMTJSdGcrWFBDUWNEMmVuejVF?=
 =?utf-8?B?UWk3b3hIcS9LbUc2dU5XNHUzbGVnLzAvcGEzYUxMTVZ4OG5IZ0JhUDJoNDhY?=
 =?utf-8?B?MDd2TnJRS095N2JWazFhSytjWmljQW01cVNVaysvOHFDVXBYcW44Y2JUdGcx?=
 =?utf-8?B?SjRJdzZWeG9yeHc5SE1rSTViQmdUWTlOWVV0eFBlZGtISjJOd0doa01vVTY3?=
 =?utf-8?B?R3BpdlpnbWtLZllOSkNJc2FNazl4cE5HUExCNXo1WDlUbWFjZ3A1Tm9uZ3pl?=
 =?utf-8?B?U21WUWp4cEFSaUsvQVErWFVXT2xYQ3FibTdFYTZoNU9tdUNlY3BkcHYrUlkw?=
 =?utf-8?B?MkVqQjhWVHdHQ09GakRkd2ZiaUlIb0V3cEtKZkpGa2hpbTI1QmtBTDBUZXlL?=
 =?utf-8?B?M3NQdmM2d04xdzhxdGl1L2hpLy9Ec0ZhbUdVZUdNOTFRbTMweUFMYktYU3k3?=
 =?utf-8?B?c3FWVzBtSEl6aTJ3Q1pwcytwMStYcDRJRlhvUCswSmRrMnVVVnB2UDBOUkZI?=
 =?utf-8?B?RkxGdTFMdEhKdS9hbzYzZFFuUjR4S1lOSDNEY1lyWVNGUzdMWi9HMHJLM3By?=
 =?utf-8?B?R0ZhNE5PT3J4ZnRaaDMrTWFFYkRST0RmN0g0TWplM3p3NThzT2xyK21IVHZ6?=
 =?utf-8?B?RzBHRWUycFpqQWVmMHRCSXdKZ3dpSUtMSXdjZ05BcS84VFViNUE3eGkxTFpK?=
 =?utf-8?B?NThZS0NBRkJoMmR0cCs4cHZFb0U1dnVkZFFGOGxGQVF4ZFlVUjdMU0lEdktl?=
 =?utf-8?B?UDN4SjgxMmFiQU1jQm9TcmJva1hjN25BM003NnExcU9QU1dRWUhKcjBKUXpE?=
 =?utf-8?B?dHdadEwxUEpXM0hoRzZ1WGJabkplaFgwWDBnbVVQc2VsMG9XS0wvQVptT1VD?=
 =?utf-8?B?bVc2S0RjU0czRnQ2ZFUwL2d6Y1NTaEJVd1hlcUtzQ3RGM0NtaE1kTkxYSzhN?=
 =?utf-8?B?ZFNqZDJ0Vlp3aTBSM2JnTHNkbmJWaTFSMk9oTWdvWmgxSmZoeUtCemhNejJv?=
 =?utf-8?B?akZvSnBOU3duVDBXN2NPQUJsMGFZcXBPUkpHcGJ0aitZejBaR0l1Nnk2V3V4?=
 =?utf-8?B?dz09?=
X-Microsoft-Antispam-Message-Info: Mc42Xt76i2o0EZYj2SsZzrOlRkBCaZ6PX9L6oeIi99U2DigbNgFbCb57lR0KSuwKjV6rxDgej5iVMu7IyPt22SmROhPus/PJMe+sFyEGlsWYU01UzYO5q5vhX4WS8s3jTY2uUC/OoM43avY86Fi8Zxpqlqyk6j2UD4qfdK/SjluO/r36EJ5P/b+b9yF+8/g/
X-Microsoft-Exchange-Diagnostics: 1;BLUPR05MB755;6:Ge0bwV+PSrdmNYoZn+gr81dIn4sOq0YR9zoNPeMtdH02OI3w+jsd0keTudjIo+Gbf+4SHIbRdcBokD4BaIt8U6JWwoXspe027WX/2hheDWU8a7sVmI9oEaGxRBw3l1+zhGBM0SnpqDXdr1Aw97ukaWK6yv21mBE3skMuTjW2CG37VqcTGfhFGmjlEP7RNe+8RJs8QIpc0bDWaMybh2/SVfIZMctizvNjDqkaKBdR4T0Utql5vQWoo2YqWpYn3UlA2PeLJ7oDE0+5ZjqUupoxYHpY7gRrZvvn7L9rhyuK52v/Nx8j3lc4sd5ueHQRTVy9m3GUpzbCm5QRi5m8Mba0PiEoOrKIA0SerQOlR4/ZUOCmaH8MX/sUALkPtKNY0alC1hij5BDE3YFtEvH6A11eWX61mDPVUCCnrQqRkXMace3Mm/yMKLyNFSdJhf5j1rnuyqOc6UVIm4xd0tEyQzJfTg==;5:zlWrlfYwpgJm/Fuk+/mvtoftZdDY8U2mRb8BQvHX9xqW0JeMXHGUvDyOYnmjZMUDjwp8RCljf+1Di6dc8j+ndUlr9k2O/b5ZGDPwZKPVeM9RROcCt2bMHcCOwYHmocoFFAioRrPPIHA5Eze4uSZfTVNYghoLHhx6jvfYIdQ6oAo=;24:aYM93G1rLJzse0RxHiLCCyl7uHd0S5EuxJabpjxv/aFedVoqopsl1My9Rd3Y2yNyMhsqGfkjCoeJCg1/9NbHS4MWyrY4/UxQy+v6FytUrns=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR05MB755;7:tewlxCxkPiH5LMOf63YEQPSfz3bDFdNX5wVpCWN4++6oOOx6APfoBe0HTWWyr0Qf7rZXq4v4ZiFaE8juCT1DopLnbTJ0rp4RU3p6BwrOCAKzRoovjmjYZYwEeWYJBKjJAMijaerJFIRdxIluprRDnqhrWtu6OKf5fto4BlqMRnMvgINcGUYAR7IttoP69x12+sayEggJfMHE23x4Ll6TSjrO4gvcXvHg72xpf4qwusHeoh42QkwzLBuQTfIPmLT/;20:5zNkUCJMd+5yS6N//i7QwqDacvjMad6eGYRghxCxzrp3CDRsWTdYFKzCemlHuJ0XErgv8SGpI9LJcwxkSe/6YRi3U40lUAIZhqU5SNfLXUXEkvSdOZQuc+FEEMg7QnInTQzd3z6YzqrhT6pLfakqgtriUr7G0UeUCglgmpGRPO4=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 11:52:05.5975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3da5e31-71ac-4723-5d27-08d59aeba848
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR05MB755
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 12:10 PM, Daniel Vetter wrote:
> On Thu, Apr 05, 2018 at 10:49:09AM +0200, Thomas Hellstrom wrote:
>> On 04/05/2018 09:52 AM, Daniel Vetter wrote:
>>> On Wed, Apr 04, 2018 at 04:49:07PM -0700, Deepak Rawat wrote:
>>>> With damage property in drm_plane_state, this patch adds helper iterator
>>>> to traverse the damage clips. Iterator will return the damage rectangles
>>>> in framebuffer, plane or crtc coordinates as need by driver
>>>> implementation.
>>>>
>>>> Signed-off-by: Deepak Rawat <drawat@vmware.com>
>>> I'd really like selftest/unittests for this stuff. There's an awful lot of
>>> cornercases in this here (for any of the transformed iterators at least),
>>> and unit tests is the best way to make sure we handle them all correctly.
>>>
>>> Bonus points if you integrate the new selftests into igt so intel CI can
>>> run them, seel igt/tests/drm_mm.c for an example. drm_mm selftest is also
>>> the framework I'd copy for this stuff.
>>>
>>>> ---
>>>>    drivers/gpu/drm/drm_atomic_helper.c | 122 ++++++++++++++++++++++++++++++++++++
>>>>    include/drm/drm_atomic_helper.h     |  39 ++++++++++++
>>>>    2 files changed, 161 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
>>>> index 55b44e3..355b514 100644
>>>> --- a/drivers/gpu/drm/drm_atomic_helper.c
>>>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
>>>> @@ -3865,3 +3865,125 @@ void __drm_atomic_helper_private_obj_duplicate_state(struct drm_private_obj *obj
>>>>    	memcpy(state, obj->state, sizeof(*state));
>>>>    }
>>>>    EXPORT_SYMBOL(__drm_atomic_helper_private_obj_duplicate_state);
>>>> +
>>>> +/**
>>>> + * drm_atomic_helper_damage_iter_init - initialize the damage iterator
>>>> + * @iter: The iterator to initialize.
>>>> + * @type: Coordinate type caller is interested in.
>>>> + * @state: plane_state from which to iterate the damage clips.
>>>> + * @hdisplay: Width of crtc on which plane is scanned out.
>>>> + * @vdisplay: Height of crtc on which plane is scanned out.
>>>> + *
>>>> + * Initialize an iterator that is used to translate and clip a set of damage
>>>> + * rectangles in framebuffer coordinates to plane and crtc coordinates. The type
>>>> + * argument specify which type of coordinate to iterate in.
>>>> + *
>>>> + * Returns: 0 on success and negative error code on error. If an error code is
>>>> + * returned then it means the plane state should not update.
>>>> + */
>>>> +int
>>>> +drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
>>>> +				   enum drm_atomic_helper_damage_clip_type type,
>>>> +				   const struct drm_plane_state *state,
>>>> +				   uint32_t hdisplay, uint32_t vdisplay)
>>>> +{
>>>> +	if (!state || !state->crtc || !state->fb)
>>>> +		return -EINVAL;
>>>> +
>>>> +	memset(iter, 0, sizeof(*iter));
>>>> +	iter->clips = (struct drm_rect *)state->damage_clips->data;
>>>> +	iter->num_clips = state->num_clips;
>>>> +	iter->type = type;
>>>> +
>>>> +	/*
>>>> +	 * Full update in case of scaling or rotation. In future support for
>>>> +	 * scaling/rotating damage clips can be added
>>>> +	 */
>>>> +	if (state->crtc_w != (state->src_w >> 16) ||
>>>> +	    state->crtc_h != state->src_h >> 16 || state->rotation != 0) {
>>>> +		iter->curr_clip = iter->num_clips;
>>>> +		return 0;
>>> Given there's no user of this I have no idea how this manages to provoke a
>>> full clip rect. selftest code would be perfect for stuff like this.
>>>
>>> Also, I think we should provide a full clip for the case of num_clips ==
>>> 0, so that driver code can simply iterate over all clips and doesn't ever
>>> have to handle the "no clip rects provided" case as a special case itself.
>>>
>>>> +	}
>>>> +
>>>> +	iter->fb_src.x1 = 0;
>>>> +	iter->fb_src.y1 = 0;
>>>> +	iter->fb_src.x2 = state->fb->width;
>>>> +	iter->fb_src.y2 = state->fb->height;
>>>> +
>>>> +	iter->plane_src.x1 = state->src_x >> 16;
>>>> +	iter->plane_src.y1 = state->src_y >> 16;
>>>> +	iter->plane_src.x2 = iter->plane_src.x1 + (state->src_w >> 16);
>>>> +	iter->plane_src.y2 = iter->plane_src.y1 + (state->src_h >> 16);
>>>> +	iter->translate_plane_x = -iter->plane_src.x1;
>>>> +	iter->translate_plane_y = -iter->plane_src.y1;
>>>> +
>>>> +	/* Clip plane src rect to fb dimensions */
>>>> +	drm_rect_intersect(&iter->plane_src, &iter->fb_src);
>>> This smells like driver bug. Also, see Ville's recent efforts to improve
>>> the atomic plane clipping, I think drm_plane_state already has all the
>>> clip rects you want.
>>>
>>>> +
>>>> +	iter->crtc_src.x1 = 0;
>>>> +	iter->crtc_src.y1 = 0;
>>>> +	iter->crtc_src.x2 = hdisplay;
>>>> +	iter->crtc_src.y2 = vdisplay;
>>>> +	iter->translate_crtc_x = -(iter->plane_src.x1 - state->crtc_x);
>>>> +	iter->translate_crtc_x = -(iter->plane_src.y1 - state->crtc_y);
>>>> +
>>>> +	/* Clip crtc src rect to plane dimensions */
>>>> +	drm_rect_translate(&iter->crtc_src, -iter->translate_crtc_x,
>>>> +			   -iter->translate_crtc_x);
>>> We can also scale.
>> I suggest we leave out scaling for now until someone actually needs it.
> In that case we need to WARN_ON and bail out if there's scaling going on.
> I'm totally fine with not solving the world here, but please no trapdoors
> for following driver's use-cases.
>

Agreed.

>>>> +	drm_rect_intersect(&iter->crtc_src, &iter->plane_src);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL(drm_atomic_helper_damage_iter_init);
>>>> +
>>>> +/**
>>>> + * drm_atomic_helper_damage_iter_next - advance the damage iterator
>>>> + * @iter: The iterator to advance.
>>>> + * @rect: Return a rectangle in coordinate specified during iterator init.
>>>> + *
>>>> + * Returns:  true if the output is valid, false if we've reached the end of the
>>>> + * rectangle list. If the first call return false, means need full update.
>>>> + */
>>>> +bool
>>>> +drm_atomic_helper_damage_iter_next(struct drm_atomic_helper_damage_iter *iter,
>>>> +				   struct drm_rect *rect)
>>>> +{
>>>> +	const struct drm_rect *curr_clip;
>>>> +
>>>> +next_clip:
>>>> +	if (iter->curr_clip >= iter->num_clips)
>>>> +		return false;
>>>> +
>>>> +	curr_clip = &iter->clips[iter->curr_clip];
>>>> +	iter->curr_clip++;
>>>> +
>>>> +	rect->x1 = curr_clip->x1;
>>>> +	rect->x2 = curr_clip->x2;
>>>> +	rect->y1 = curr_clip->y1;
>>>> +	rect->y2 = curr_clip->y2;
>>>> +
>>>> +	/* Clip damage rect within fb limit */
>>>> +	if (!drm_rect_intersect(rect, &iter->fb_src))
>>>> +		goto next_clip;
>>>> +	else if (iter->type & DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_FB)
>>>> +		return true;
>>>> +
>>>> +	/* Clip damage rect within plane limit */
>>>> +	if (!drm_rect_intersect(rect, &iter->plane_src))
>>>> +		goto next_clip;
>>>> +	else if (iter->type & DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_PLANE) {
>>>> +		drm_rect_translate(rect, iter->translate_plane_x,
>>>> +				   iter->translate_plane_y);
>>>> +		return true;
>>>> +	}
>>>> +
>>>> +	/* Clip damage rect within crtc limit */
>>>> +	if (!drm_rect_intersect(rect, &iter->crtc_src))
>>>> +		goto next_clip;
>>>> +
>>>> +	drm_rect_translate(rect, iter->translate_crtc_x,
>>>> +			   iter->translate_crtc_y);
>>>> +
>>>> +	return true;
>>>> +}
>>>> +EXPORT_SYMBOL(drm_atomic_helper_damage_iter_next);
>>>> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
>>>> index 26aaba5..ebd4b66 100644
>>>> --- a/include/drm/drm_atomic_helper.h
>>>> +++ b/include/drm/drm_atomic_helper.h
>>>> @@ -36,6 +36,37 @@ struct drm_atomic_state;
>>>>    struct drm_private_obj;
>>>>    struct drm_private_state;
>>>> +/**
>>>> + * enum drm_atomic_helper_damage_clip_type - type of clips to iterator over
>>>> + *
>>>> + * While using drm_atomic_helper_damage_iter the type of clip coordinates caller
>>>> + * is interested in.
>>>> + */
>>>> +enum drm_atomic_helper_damage_clip_type {
>>>> +	DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_FB       = 0x0,
>>>> +	DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_PLANE    = 0x1,
>>>> +	DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_CRTC     = 0x2,
>>> I'm confused with what exactly these different types of iterators are
>>> supposed to achieve. TYPE_FB makes sense, that's what vmwgfx and other
>>> virtual drivers need to figure out which parts of a buffer to upload to
>>> the host.
>>>
>>> TYPE_PLANE I have no idea who needs that. I suggest we just drop it.
>>>
>>> TYPE_CRTC is what I'd want to use for manual upload hw, were instead of
>>> compositing the entire screen we can limit the uploaded area to 1 or 2
>>> rectangles (depending upon how the hw works). But those drivers want all
>>> the crtc clip rects for _all_ the planes combined, not for each plane
>>> individually.
>>>
>>> My suggestion is to drop TYPE_CRTC until someone needs it for a driver.
>>> And most likely the only iterator we want for TYPE_CRTC is one that gives
>>> you the overall damage area, including alpha/ctm/gamma/everything else,
>>> coalesced into just 1 clip rect. So probably an entirely different
>>> function.
>> Actually for vmwgfx, the display part of the hardware comes in different
>> versions and we'd typically expect both the FB coordinates and the CRTC
>> coordinates. In the latest version the surface backing the screen needs to
>> exactly fit the CRTC scanout area, and if the FB doesn't do that, we need to
>> create a surface that does and copy in the kernel driver. After that, as a
>> second step, we need to notify the display system of the damaged area in
>> CRTC coordinates.
> Hm, that's an unexpected use-case. I'm leaning towards just having a fb
> coordination iterator and adjusting the static offset in vmwgfx code. Your
> use-case is rather different from manual upload screens I think, so having
> a CRTC damage iterator which doesn't actually do what most other drivers
> want will be confusing.
>
> And since it's just a static drm_rect_translate for you it'll be only 1
> additional line in vmwgfx. Imo that's worth the safer/cleaner semantics
> for the core helpers.

Sounds reasonable. We could have an fb coord iterator only, and do the
translation to crtc coordinates outside. But I still think we should do 
the plane clipping in
the iterator, if needed with a big WARN_ON for transformed planes.

/Thomas
