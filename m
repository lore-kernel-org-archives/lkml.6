Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeBVGNF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:13:05 -0500
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:21680
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752569AbeBVGM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:12:58 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [PATCH v1] drm/simple_kms_helper: Fix NULL pointer dereference
 with no active CRTC
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@intel.com
Cc: gustavo@padovan.org, airlied@linux.ie, seanpaul@chromium.org
References: <1519279759-7803-1-git-send-email-andr2000@gmail.com>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <1f051697-468d-76b9-a2be-16a281f57249@epam.com>
Date: Thu, 22 Feb 2018 08:12:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519279759-7803-1-git-send-email-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.51]
X-ClientProxiedBy: HE1PR0402CA0028.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::17) To AM4PR0301MB1937.eurprd03.prod.outlook.com
 (2603:10a6:200:38::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99736cf7-9975-4c1a-e5cd-08d579bb50a3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM4PR0301MB1937;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1937;3:03JVHu6rIIxliLn/lykaMVD7qoMkgZGTfDQwiP4NDUYc0GgcohZmWlRHWbtckubHfMHq09FF8xX2rY7l7w13FhL+gGEtxCJjUCHk7/8F6qLmpNkp6JaY+P5PRBOasvU6+lPXDU85Q6qMxkf6TysGNrtbZc6p0vBne7lFJbxSGF9v0HEpQLBcDu5Pn7s2S/wSY1EEo5dpAuPKJ8LZ3HMBg8U+bC+4eK0jLgHyV3aTV7PwQBOI037DGm9oSJ3xtd0t;25:rY1B6bx6QSB/+0mJ0ENbzGoMgLU+1PjcannvLz82nEdtdKhCB1ZSqoQsCRQZsrcVjl7iYjC0yDZAxFMWju9cgYRirm/94G0XNMGPFUdSNQDMyGGycGKvUBg2aD0pKaaqScV55NN/ep1zlPIwEfhlc/vUfAMegUIUxHL9VLibg3ce7zlXDTa0AnbBo1D9Rg7eJjOuJZg+HsziWoGeDyPRm+0Wmm5OVzLGjSTFcAl6sSOZ1kkIEA+eOsCGGk8wJdBdCN0mDQ0m6RexcxyQR3RvhN0KXuOx9ms0pLSeL0FyXUG1l6OT958VaSjqdxUYGyqa1KHvafP/1LiZkYj3Mk5Wug==;31:JffO8SWMC0uN4rIi9YWZl+PFb5ozPh5vCCvN2oilFRH6PxRwtDKRQEjzyLkdq0DeFBIL5GQT0taZB+E8AqNluCbybdSbfPNxJqaal8vraOhb2IX/cmb2DSIKIvaROMbCvd8JTMysi7xJ5udaFTV655L28alCe0QX7LpTzLnDtlz8fcg8q+CEV/W71hYLuttbt+tyXSeqqGAp+U1DJm3Euu+YSa9kUJW5O2fsvn43Rzw=
X-MS-TrafficTypeDiagnostic: AM4PR0301MB1937:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1937;20:2fKA3NTUZJFAxI/9AbIiEtAoiMlnrhHLPaIgFDtPz1re2ZZC78ATPPSUVK5/xbm8czjVRITubhgriPc9fbMwC2bIcCUVQiEiafuT+6rl8tcWIdbo+VtoDQn3etM6wTnjjSXTbRK5ceZngdBFBEpGt0dvHlDaSXSyAG8qWOI7zaBhdzr5k+f7Yz6Yhovqk6A0cK8mmDNHxbeVlXIEE7kXWkAESKhJWjOIGZl8SKGrprRaoVEkAuA9/AjfAskWqTm3OEPXP5IE26+7mtlyuIekZ7O7fOUBRAk2+dQNhAZxxZZpdjO25GeSiTlVNHV+I7gy+qCqdyUFvOcMqFSaO9phN1LsNdXIrNVHyjU8/ZCbfwXYl7oopsypvl+DdQ59FBrn/Dade/on4AvjiV4mno4dXKx/gaaAWoDEAw2o2TdM+jxw62KF/Cq+33PToRQ/vH1ettKvD6WxGC8UYjHhKizpfKJ8eo1NRE2Mp6kzIDhkHQJv7fiLGNxd2Ap+oWSJ21S3;4:Yuvpp4PidWjywbn4wAIEp2bdb8dxub8JYxTY5tFd9k2jL9eVwURDHY0oqJ5SkNi5DelrYrCDMBrnE6YV7m9wH81Up6P2pzMTHKbyYcbOu87LlkQOqqd5d4XaV2rZznW1fw4vPqd4HhClONBdbYyhrLcIew5IUBX+1loWqnOmkE2BlDP9xe2qehTyzEjR3YKZ8bwTozU4AU/e+6VK9vO8B0Daz9SM3It6SlQN/WJ8LSIePhbve6O9vQWgT7eEdCYmZYn4ArZ+JNbwla/K2az+ynq4KXRoXEWP3+UrCh+U8Bmd/CMU+GNaNP3kFVmmZ7SI
X-Microsoft-Antispam-PRVS: <AM4PR0301MB1937EE52BB024A17A14713BEE7CD0@AM4PR0301MB1937.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001076)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231101)(944501161)(10201501046)(93006095)(93001095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:AM4PR0301MB1937;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0301MB1937;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(39860400002)(39380400002)(346002)(396003)(189003)(199004)(65806001)(59450400001)(16576012)(58126008)(47776003)(80792005)(65826007)(105586002)(106356001)(66066001)(65956001)(229853002)(26005)(7736002)(316002)(97736004)(81156014)(67846002)(64126003)(305945005)(4326008)(36756003)(3846002)(6116002)(5660300001)(8936002)(39060400002)(86362001)(53936002)(386003)(2486003)(52146003)(2906002)(2950100002)(16526019)(186003)(52116002)(6246003)(55236004)(478600001)(53546011)(23676004)(81166006)(31696002)(6486002)(76176011)(31686004)(25786009)(8676002)(72206003)(68736007)(230700001)(77096007)(6666003)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0301MB1937;H:[10.17.182.9];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAzMDFNQjE5Mzc7MjM6amVRN2RNSnlWeVpRMm9OREVqTlIvTEY5?=
 =?utf-8?B?cFR4c0NXOE9GVDRyQkZFREpzSjcydGZwclN0OVN4TVVWbkN5Y3NjMW9tTnhi?=
 =?utf-8?B?TVZETlVkRmNKVFJuRnl2RmFIYmlNbHRXZFo4TTJhZ2V5eXJBTUlVaGxnNnFy?=
 =?utf-8?B?bXUwMmthMnVBMXFMN0RNYkphTXI2MlVsMTUyVFl2Nm8xbmVKRWdXL3NsdlBh?=
 =?utf-8?B?OUVZOTVJYXJ2dTYvbFNEb3VqUVVJemxIVkdkS1d2aDZXUGxIeG5wcEZob3BM?=
 =?utf-8?B?WHo4QzhpZ3ZvRXovcXFpYkxiWFlEMWpOV2hjcWxibDRLc1d6dU1yVmRZRjk0?=
 =?utf-8?B?RFZES2RtQUR3UnJSbUJKRDdyeUU2Vzd6MVZpbWw4MlpqNWxLMTZoMWxsWE1s?=
 =?utf-8?B?Q09uQUkyRllFejNlNzRoTGRFQThqUXF3eFl6TGtLeGFBRVZ2WjkyOUtMQ21P?=
 =?utf-8?B?TGU5SmFMSHM0VkkyaU14VnY5dGlqUy8yclVwN01TWmlpQ29PNS9JSHIzWGt1?=
 =?utf-8?B?eEdya1QwQXFmdXNTWlNUUGRaMUF4Qnp3MG5sQ2dwNjVNRVJMNXZ0aFZOcDBm?=
 =?utf-8?B?SlVsZGx4Wk1qemhpVHBRYWJnUWc2YjFlbWpYUkJ4bDY5TllQMDNxUWlEOCtJ?=
 =?utf-8?B?VXBwbDJoL1Q4L0VYeDAyK0x5N3FDYVdTdzdvWk5wZmY3OXZIejE2VWtueHNZ?=
 =?utf-8?B?U0R4eHVjSDVIM1U3eFZ4eVR1S2Y1akV3ekxUL3puYXpuT2FzbGU3Z0ROZkhC?=
 =?utf-8?B?MzhDbSsyaFpGR2tYM2FJeFF5MWFoZ1pvbEpNUGg2ZXVLd0NHSVhmMWxwQWMy?=
 =?utf-8?B?UEw3Vk5xR1FnTzFlR0d6NGI0R05tMWlGa3JWeHhnc1lNOUpQTUlRMnZhTitO?=
 =?utf-8?B?QnYxczl0R2lrNjd6a0lGcjJUUmRTUzl5MTZBcG9HK0JEWVNsNno2dmdHVWRp?=
 =?utf-8?B?MjhqSlFHdjgvTHhlQW5KY0Z0dUN5QVNOKzNZM205T1pjVWJVVG5BZXpnbENI?=
 =?utf-8?B?MlhQQVFOU2ZMZDVwZXB2WkdWYlBObERkRHF2YTg1Qms1T0RLSVhPeXJYZXFJ?=
 =?utf-8?B?eS9oTzNYTW5FU0dyNmppMVNJRStiU0R3MWtORXBObTV2T1ZrOTB3RXRLNytC?=
 =?utf-8?B?SWUzTXhhUk9MZk1YeHNadGdmY1hRTkNQbXJucHdwT1A5RVBBRjdnNmpqakdj?=
 =?utf-8?B?TVZYYVg3dnN4MXNGaHUyR2MyNnN0d1NlcUQ5K1VTOUEyNzZKQzg5WGFtVDNH?=
 =?utf-8?B?MVV5WjZnSTZsT0tXNTNwRXRFbFc2QVRodEc0L3B5VGhuaVNZM3RRWTM0VUc1?=
 =?utf-8?B?K2dJbERoZUJtOVljTW1XNDZhMlFwbUN1a1pWQXpTWGtnQzFkanloaFlOZStF?=
 =?utf-8?B?MnMzblRTaFBkdDZwYllUVDdQazQyaHp2dXhDY2NScEVKVHkyejJ6SmJnNklL?=
 =?utf-8?B?c1h3RHdFRFhFRm1idjBWd3dNcEpQUTY0SHpxbzVwQjJsbUhXQjZINVpVN1ha?=
 =?utf-8?B?ZThZZ3ZFY0crNzJiT1IxKzJZeVpwSldlZlJCQkVmSGErZThrN2p5eUhUQXlD?=
 =?utf-8?B?MGRJbGZPOW00M2JFTUVKelcvRlA0UEUvTWpCNmZjNHVmNkFadnhpbHpjVWVs?=
 =?utf-8?B?OXQrN2plWE1xZ3ZjU3JPUEFFckE1QzFuQm1BSEdLeURISUd1Y0pZMDRWZ3FQ?=
 =?utf-8?B?a3NyQWRTUHAxQ2lLRFZsQ3ZQblEybGxMTkxtd0VVU2hKVnJYZzFaNlp6eXp1?=
 =?utf-8?B?Y2NCYmRvV3cxZFIrTE5CWFRzU0pmVzRaK00zVEZWbWFkdEl6WXZLMkI4ZGJr?=
 =?utf-8?B?K3lUNys3Yk0vVE9GRkhuUWJpT2IxYkxCeHdhVFUwZThNYUhCWTQ2YkZpL3R0?=
 =?utf-8?B?NkJuTzE4OG5rTnRURGl1MDRRTHZxOXZXS1o1VUFFNFF6SStyZlVPa3l6VEEy?=
 =?utf-8?B?MnU3SHVkZlY3MElES3pTYkdNem44aE85L1FZUTZtQXlSYU03SFJOQkpIYXVn?=
 =?utf-8?Q?Rv2acW+I?=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1937;6:IY8TqWpTJq71ssLPAr84x20jcBJnuoqsNxuWsDCs5QINZxL0OfKZ90lYy1EkUEsxVe00GrMgE85ub5Bw7+QLkQ/FLHVZu+pZmz9ko8G+9d7cOJEY+BepLs1CVXq9dHKpavGRCfNLBXuTHjjgoiOQcZrnNJMdXPwprEeUDz8/2+WlcTjBC/neLH7v3HWwq3LiMVgpqxB2YvCe61eIkiSNPLf8UtIskjtiFg0uaQ+HKlSJAOs9w/abh1K9oVbIOPu3/zEItPUHx+5IZoew55JbpNyEagkxSL/i/lYn+FMJS/x1rYuO4cZ+vEwsvbs3Wn5OH68Qrt0Aen0m182lwrr4+3W+wZIHxAWywwL+VYDmoc8=;5:BrOfzFAnefdre3yvIShjMPZnWEADlhQRqvz2u+sqAZCUXuCxrLIeyQxLGU/fGRr8LzaKOzdLexP+bNGZ4yWebiReJwQb3ju8h2kJ/+ZlMk8CWYPqPYtNSrfx9Z/OT6k0GfgxnO4C//2yOf6/4PO+NoBqqnZY9IXfLWezzrMigWk=;24:ZF5yrruyKXxGTcaouSTocQdmAkIiQgR1ibb7xSjO1m4kxggiJqGnXEfDPuj0L2dj82yiVaVFwoO1p91F4L1pl7Dd0VW9sHgmaCvUr/D1120=;7:B2ttiF3s8UX69vFxkp/KMLqI7PP7LRdtFHkE/wgpiS8SjEKmGemvMhAltHWvewaR0EMghw0Qw0bmn31s8XQa42lwkOzsdUan+dXEQWFcVAwBXsBDDSSi4MLCQRDSVEofN7C4fMbDHTJPjU8tSvcPq8QPTBYq9JWJMQ6y26EltXDylwTI2BoeL3Bnbg6M8nMSoSvZrXxh4kullDj7fpJrTjd6roPJo4EMitxgLafqkZ9PUBsrRUvEnN3QHq6KdzSI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 06:12:55.2337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99736cf7-9975-4c1a-e5cd-08d579bb50a3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0301MB1937
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 08:09 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> It is possible that drm_simple_kms_plane_atomic_check called
> with no CRTC set, e.g. when user-space application sets CRTC_ID/FB_ID
> to 0 before doing any actual drawing. This leads to NULL pointer
> dereference because in this case new CRTC state is NULL and must be
> checked before accessing.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> ---
> Changes since initial:
> - re-worked checks for null CRTC as suggested by Daniel Vetter
> ---
>   drivers/gpu/drm/drm_simple_kms_helper.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
> index 9ca8a4a59b74..4a1dbd88b1ec 100644
> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> @@ -121,12 +121,6 @@ static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
>   	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
>   	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
>   						   &pipe->crtc);
> -	if (!crtc_state->enable)
> -		return 0; /* nothing to check when disabling or disabled */
> -
> -	if (crtc_state->enable)
> -		drm_mode_get_hv_timing(&crtc_state->mode,
> -				       &clip.x2, &clip.y2);
>   
>   	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
>   						  &clip,
> @@ -137,7 +131,9 @@ static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
>   		return ret;
>   
>   	if (!plane_state->visible)
> -		return -EINVAL;
Daniel, I have put your R-b tag, but I had removed suggested
"WARN_ON(crtc_state && crtc_state->enable);"
here as it fires each time when crtc_state is not NULL.
Please let me know if this is not ok and you want me to remove
your R-b tag.
> +		return 0;
> +
> +	drm_mode_get_hv_timing(&crtc_state->mode, &clip.x2, &clip.y2);
>   
>   	if (!pipe->funcs || !pipe->funcs->check)
>   		return 0;
Thank you,
Oleksandr
