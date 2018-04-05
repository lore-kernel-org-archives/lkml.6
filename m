Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbeDER6z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:58:55 -0400
Received: from mail-dm3nam03on0086.outbound.protection.outlook.com ([104.47.41.86]:62357
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751285AbeDER6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:58:50 -0400
Date: Thu, 5 Apr 2018 10:55:11 -0700
From: Sinclair Yeh <syeh@vmware.com>
To: Deepak Rawat <drawat@vmware.com>
Cc: dri-devel@lists.freedesktop.org, thellstrom@vmware.com,
        linux-graphics-maintainer@vmware.com, daniel@ffwll.ch,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/3] drm: Add helper iterator functions to iterate over
 plane damage.
Message-ID: <20180405175510.GA10092@vmware.com>
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-3-git-send-email-drawat@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522885748-67122-3-git-send-email-drawat@vmware.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [66.170.99.1]
X-ClientProxiedBy: DM5PR12CA0049.namprd12.prod.outlook.com
 (2603:10b6:3:103::11) To MWHPR05MB3295.namprd05.prod.outlook.com
 (2603:10b6:301:3d::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d47815b-59d3-44ef-09e6-08d59b1ee052
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:MWHPR05MB3295;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR05MB3295;3:0lknWRnZKmRY3SPAgllmqgu4cQjpu3xONx3FVQNY+IONKnG6xXm4WtZTAHGaX3HFUJ9RlppjoY/x6bVxAeusT7ZlTz2E9bHlOFdOWymd+AxV6RQv+33qbXJML9+8g8AtFJAVwd61R7Y+jeLvRppJJgljP1oJ/Umeyw2DkDez6BFv0NIRy/V1mixEbIqWxRlVk3/WxgBEmu7WRcPPmp0zRCAlvWrFbTw7NE1ll8HrdFfGOeUnQQksdAIrinimXP4I;25:4/4v7Dzhkv9UPiv8TPIiWZosuEuMgnYjCGvnAi5EiU2XRfMwK0BmBSQENWCfvCb00P6ITB0H5t3h4aAQtti//MtJp1L9p7WS7lcedlGbOg+DZoYrQhDELzCs7uPmqTJes3grgGRYUJTewH3DuuatKa+qpWpWWf9GCtjodUmgOcqKkivQavMALOzi3XsIc+rVh/KhpN+azNIGzODEEZbeIfh42IFhLlLsSL1xSBLYv+HXb3hkS9ZNJZb98J1em8UsYvABYHVyVLgQWbEatq2aOe/sMPxDN/yldmWW7SryhJgQ2/MObSe26Rh05yI0apyigEsvptx9NtcDI8Ybr4U7dg==;31:9Fd9AIHJfuyWxIkhe2STowdVFqgTTvDHdiLFILQWc4W/lC2wQkAuFBqe1hunE9KnrITSoO74XvFpu5tT+pAZbAZwlycXDGh5cdEWQ20Fq/GyKIjH02Q26pCt+vS9g6gnvhiphzgUZcVat25ccrZaAraVt7xq+VZ/z3Dlt08JQOX+dQfUxxoTm2niVLXOj8+orPLMvz6pTn97DAZcMDl4zvtl3htF073M96n++3Vqo9w=
X-MS-TrafficTypeDiagnostic: MWHPR05MB3295:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR05MB3295;20:QvXGmd3W4kh62sNlL0PevFmtSdt2tjVq8ze54w76KCO/ZKC+UVhpuZyO/2DLNrxrO0gpl+g34mfvHvLZMyRMQv94nSnMWPKuBQRPEfgU0d1A3rsLJyxIHPaAJ9pt26r+l5rQCH+cW6om7qmvT0x8tGr4oGZku+r+AcYvFESvIzBIGz+vDhDKS5QhFv4gsH0mfEXFHYhuIGYq4yaXgBoFWjbH283gm+SIWGIeVQLBYY9y+xgqpUJDzP/9+9WyPHb637xFRkkPPc+Fy+UZRv+xivvQCJxr3i+wU4z27s9nbbTNWQ4ADczqUzLth3NFqjhuDac5W3nT+nmr9M6/6v5Ya9HPVDES+2b7FZwU9Vzpb+y5cOygoKeiXL5OKPR0bZ/vVVMO6WpiHF2CNOLLHPCPhfd1kKyelWsfxIUn0ivr+KyxTZmOFoZNr38bNd/S7uVgC1UcTU6nxqNP8qVx/uyFSfAJyMmdzV9w3lQf237diBEcbXdoxM/ZHu/pr4HKpXBt;4:pnaDkNcH0PW+tR/8/9DiKq444g7GYd/Q5lFZY0UDVXu8ufbFP4hYnHqkZ4YqYHjYMwFxj2sLuIDYPfWfp2USPnmd41svw0jk0QyqXxegRpSM/d1pA5peWcnVSFZe95dizIFQ7LnYW7sl+Dc18z5NIXBcOQT+HpZ+DiCfy+rbyghw0+v/UvN6C5XoJz76pVVZtWXHDZsuA75Zg9zzlpfkOtGY+He3j5Tk+XcgNYtI4FDw0xfJ789ca9QNXQgMqhbK+c1oG5mjovzfYvWa6+TbFOHxoK6qiq6WeDXvEWsgvB7ReYn+fkI+Zum7hso8UEtD
X-Microsoft-Antispam-PRVS: <MWHPR05MB32953D320516A3A7DBA7AE7EA8BB0@MWHPR05MB3295.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR05MB3295;BCL:0;PCL:0;RULEID:;SRVR:MWHPR05MB3295;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(7696005)(7736002)(6636002)(47776003)(4326008)(68736007)(25786009)(6246003)(229853002)(7416002)(37006003)(66066001)(1076002)(52116002)(6666003)(33656002)(16586007)(58126008)(6346003)(316002)(305945005)(386003)(39060400002)(6862004)(21086003)(59450400001)(2906002)(76176011)(86362001)(106356001)(81166006)(23726003)(8676002)(8936002)(105586002)(69596002)(6116002)(11346002)(3846002)(446003)(50466002)(5660300001)(16526019)(26005)(97736004)(55016002)(36756003)(53936002)(33026002)(478600001)(81156014)(2616005)(956004)(476003)(486006)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR05MB3295;H:vmware.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=syeh@vmware.com;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR05MB3295;23:SNlJgILWLty7MhyjsGBvB7IKRZEmDHf5KCnhnqLyr?=
 =?us-ascii?Q?hSuelT/rmHKJCTQwN8olFKyz0Ie9v+aopY/uRTGXJzguwW6a24VYfSse6exH?=
 =?us-ascii?Q?oSyEcE9cOJa0Kb1uGbKTJWaTvAXj4B/NUIIYc+sCmza1eQfuGZoAGwuVifXf?=
 =?us-ascii?Q?fFaSermjM50fMqXx2/TYlpfautO65SKmYSxKX4JwvxG9MjnoAoUsfLiGrWy8?=
 =?us-ascii?Q?LdKszmLkFlz989LE/PRUphdIODYq92uftO6hUxaoPPK3qz6CVF1xyG7qFxZg?=
 =?us-ascii?Q?PbjMiLhFC3uHG4NKa6kVkHY6aR7zN+uL8Z3TxdPTeuzp0Z9vpCsM6YL5AKnG?=
 =?us-ascii?Q?xOBHOMcUH9jj+mEYnxjfOZXIsLSKTaLjOsZW9XPPZb+yXf6VfFzjrpAytwsb?=
 =?us-ascii?Q?dw6A1EApVFvCSyQpi11gvbBKEW8C3cVYUnQ8Aam+xrAziR+KsOozWqpSJAGc?=
 =?us-ascii?Q?xKeSsIhakCwWrMiDgjy8hLLqnK8z5OUCLwR4mh8D7lUuPgXJd7L7RCJU/bfQ?=
 =?us-ascii?Q?CEeLH7HLgC7BnXehlS4/KeJUEY3dEKyovF3t/hJJHIlTBP6/EhtA9yQpvUts?=
 =?us-ascii?Q?rox5UjsDI42N72X79MUo4AkNLm1dnRTiPWL1gdwAqZ4BTyso9TNS+XNotQlo?=
 =?us-ascii?Q?ytGatM0yLBcc3HTpXBndtQumPQvQ/1zohb0BICKrskBAn7r+k+ZwVBqpYPu+?=
 =?us-ascii?Q?jVt3sqpbmypDYqScwIO4r/aN1x+Nz7CQ4R1cqmeCVjYMydOddG5u85rco9/O?=
 =?us-ascii?Q?lnDkpw7oZKvH62jap8xu7Rf0mf9yKg1+RTzCkjmzDAFy15+TU2LpGJfF0Tuw?=
 =?us-ascii?Q?G9BmJ4bT/IHV/GKgiTaSmOctQ2X2ZkzDTFHjdbp1+OVNeGU2ZGA1Xf0RvUAy?=
 =?us-ascii?Q?5N7pZiHNCsK8oh7pWz3qR8dxriyVPtSNn3Hl7eMKKqX3RVGkeO931dyx4ShH?=
 =?us-ascii?Q?acZaeFDdTmE2F6Hl/lvAqRYoYIB8GScqTx5LF7YFstwGh09lymQ5ILl1eRjD?=
 =?us-ascii?Q?aTKF7RqpBdjZLFFDsys0RKu7eHQMv3XgzgMmkVXyzkaOjGhxOjamKy1LEREs?=
 =?us-ascii?Q?TFKnyooU+OEkJ5G81i897D81PvRtaoKfFgRH0Ra47c2adI9+02xtSkS/tk6n?=
 =?us-ascii?Q?iJLA8vGCpEzTAQ7G0ggWcpdtizcWMCb87J+zi3wTaslKMSwEQL3EHq99wM26?=
 =?us-ascii?Q?phwYmpdNX0oE8G7v8221JF/1j4vR/n5RIU710yzlKHu3oJ7vCARQQXZG3ZTu?=
 =?us-ascii?Q?j6mizvPzIunnjaX5mXCLYfpirBR84RfsBnO5VB8dhXR+7lZ6DA/H7RcDN/Gj?=
 =?us-ascii?Q?yYrMRUyYFefFBtL4ncBu6e3pBz1IUgjQ0zEcIX60tMwu/Yf69I5l9MBqunxR?=
 =?us-ascii?Q?GmthCzmS5o2MXYWTP4m7XqzheEzaArJYVHyUhaKPad+FGgbHlLRrmEnty/18?=
 =?us-ascii?Q?YHd2CnDQw=3D=3D?=
X-Microsoft-Antispam-Message-Info: iKHGfe/8XzMXnjv5EQllG1o0QDE+ACAaohL+peZSIyzHwxPCGe00Opb6obGkwAOZzSPJjRX4i20SqghiMwhv0Qt00zfGxywMEyacSnCDm2RcN1FkqpbvHq8H3h8dnZwjKoaKJMc9GZ1grFnixtG8ZzNwCvbHzNhjkKmNBK+I9IzqAZYzwwEdVoV1yihL/lI7
X-Microsoft-Exchange-Diagnostics: 1;MWHPR05MB3295;6:1/K5bMK7+8sQeVKnrQRUNSK1VcMey5gbMdahlQG3h6+RCp7hP6KAhJK8aCRKd3TaaUY2W5+o0rfsjf/k223C5P40Tc2bhBZlsv2lWXezwlleuL7VlQBj84NSrobmH1DKd03+j4Sl25Z7rz8uARuHJPRbgtiyJaFRJgkcbK0uOlepSRCm4mQr/UClb71DB7cVtYCnVqYcuYYuMtf0NwOvQU/7+eHPpmrcHiv528cYzznOdmhSsOa8fxRzIzonbzKKBBzs1B2JMfOFIy7Jv1oDIgEnvZW+sSVaoEFEvv8IhNbjbasKE5K0Mzp2Ap5rWPu3XICbE/NvsdAI6EaTf00V1WlpJ+Ndt8c1awTYKfhU/opM3X0k1iOrxMpJA5vLEG084U2chhP0LTq/px/VQ/rfSXfCjr/ccmD9spd5v8ID3Jt7swgWZG8Vj0IO+jB7RlalATyz44TTdMsF9OSRfpfTyw==;5:q1HZOFOqx/bSzqYOTfsuYfTN9298Bc1FQnk7llOKoplGEXEu6Ep1dxURV3284LVfxS4huet8z+5VjYNCQ3i/OuDgb0yEu75CvRJVbpZl+SioG00tWGPWGwI6XpRhi4mRNtyh6xIQTKi0KJ4wh8nEeYYzi/0nejFEqkdJYql4bFM=;24:dGdbRMGIirftO7TlNp490QW8x1HXVWJDBqO99Kx517khisYvlWVxVT2c7yp0r3VXgW099kRXgqIuLkd/iuV6NCUPRtY7LA2N0tfiynenodw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR05MB3295;7:EskBKqQ2Jx5jPexqUjIK1D5sfJufLOWoHj56xPKE/PMRb6dk/Ku+ho96596tYAMnMCibwo9RJScCKFhoPqZbqu6iS+d5paUHys/ILmOzbwrjsL9fTNthdCBX4oC6TPuQHLZQJIiyiKhAsuUTneE8UHS/LwJSXC4POueQS2/lTRmKroh9zItaVEt5r1NFZfEWQlNCayhuuiqVliGyudA0FoA7wTk9CE5Hok96IJB89n8902R+4arFvVJ8SFynx8pm;20:k1we3ojVORJ3jqzKxZO+FJO2CQYqNAdKmpCK40YCBtFK/1mYFkdjPwQfsjQU6a00Wkpq1hS/n2zyKNrNzkGJvwVEILhuW6331wdGX5mJwtEgTBzR7lvxOSAP1EhXF95bIaC1qe7EAjzlUpm1/otaUCVbobgpIJGYDqWrZca76YM=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 17:58:44.3840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d47815b-59d3-44ef-09e6-08d59b1ee052
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3295
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 04:49:07PM -0700, Deepak Rawat wrote:
> With damage property in drm_plane_state, this patch adds helper iterator
> to traverse the damage clips. Iterator will return the damage rectangles
> in framebuffer, plane or crtc coordinates as need by driver
> implementation.
> 
> Signed-off-by: Deepak Rawat <drawat@vmware.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 122 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_atomic_helper.h     |  39 ++++++++++++
>  2 files changed, 161 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 55b44e3..355b514 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3865,3 +3865,125 @@ void __drm_atomic_helper_private_obj_duplicate_state(struct drm_private_obj *obj
>  	memcpy(state, obj->state, sizeof(*state));
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_private_obj_duplicate_state);
> +
> +/**
> + * drm_atomic_helper_damage_iter_init - initialize the damage iterator
> + * @iter: The iterator to initialize.
> + * @type: Coordinate type caller is interested in.
> + * @state: plane_state from which to iterate the damage clips.
> + * @hdisplay: Width of crtc on which plane is scanned out.
> + * @vdisplay: Height of crtc on which plane is scanned out.
> + *
> + * Initialize an iterator that is used to translate and clip a set of damage
> + * rectangles in framebuffer coordinates to plane and crtc coordinates. The type
> + * argument specify which type of coordinate to iterate in.
> + *
> + * Returns: 0 on success and negative error code on error. If an error code is
> + * returned then it means the plane state should not update.
> + */
> +int
> +drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
> +				   enum drm_atomic_helper_damage_clip_type type,
> +				   const struct drm_plane_state *state,
> +				   uint32_t hdisplay, uint32_t vdisplay)
> +{
> +	if (!state || !state->crtc || !state->fb)
> +		return -EINVAL;
> +
> +	memset(iter, 0, sizeof(*iter));
> +	iter->clips = (struct drm_rect *)state->damage_clips->data;
> +	iter->num_clips = state->num_clips;
> +	iter->type = type;
> +
> +	/*
> +	 * Full update in case of scaling or rotation. In future support for
> +	 * scaling/rotating damage clips can be added
> +	 */
> +	if (state->crtc_w != (state->src_w >> 16) ||
> +	    state->crtc_h != state->src_h >> 16 || state->rotation != 0) {
> +		iter->curr_clip = iter->num_clips;
> +		return 0;
> +	}
> +
> +	iter->fb_src.x1 = 0;
> +	iter->fb_src.y1 = 0;
> +	iter->fb_src.x2 = state->fb->width;
> +	iter->fb_src.y2 = state->fb->height;
> +
> +	iter->plane_src.x1 = state->src_x >> 16;
> +	iter->plane_src.y1 = state->src_y >> 16;
> +	iter->plane_src.x2 = iter->plane_src.x1 + (state->src_w >> 16);
> +	iter->plane_src.y2 = iter->plane_src.y1 + (state->src_h >> 16);
> +	iter->translate_plane_x = -iter->plane_src.x1;
> +	iter->translate_plane_y = -iter->plane_src.y1;
> +
> +	/* Clip plane src rect to fb dimensions */
> +	drm_rect_intersect(&iter->plane_src, &iter->fb_src);
> +
> +	iter->crtc_src.x1 = 0;
> +	iter->crtc_src.y1 = 0;
> +	iter->crtc_src.x2 = hdisplay;
> +	iter->crtc_src.y2 = vdisplay;
> +	iter->translate_crtc_x = -(iter->plane_src.x1 - state->crtc_x);
> +	iter->translate_crtc_x = -(iter->plane_src.y1 - state->crtc_y);
                           ^
I believe you mean translate_crtc_y here


> +
> +	/* Clip crtc src rect to plane dimensions */
> +	drm_rect_translate(&iter->crtc_src, -iter->translate_crtc_x,
> +			   -iter->translate_crtc_x);
Also here                            ^
