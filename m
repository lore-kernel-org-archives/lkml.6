Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeDVUCh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 16:02:37 -0400
Received: from mail-eopbgr40099.outbound.protection.outlook.com ([40.107.4.99]:21248
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753438AbeDVUCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 16:02:31 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Subject: Re: [PATCH 1/8] drm: bridge: Add support for static image formats
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie
Cc: daniel@ffwll.ch, linux-renesas-soc@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1524130269-32688-1-git-send-email-jacopo+renesas@jmondi.org>
 <1524130269-32688-2-git-send-email-jacopo+renesas@jmondi.org>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <10891e93-ede5-8c39-b53e-da892e163b52@axentia.se>
Date: Sun, 22 Apr 2018 22:02:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524130269-32688-2-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM3PR07CA0105.eurprd07.prod.outlook.com
 (2603:10a6:207:7::15) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:MxmQWDhEKmC+oIIc02fBQipnFXBqnLGQgyxVW1Wc8VwJzev+WyZlRAZulp/xeMG9i2KaG+DxAZMcqg1n/MTh9wOmROR9IG6hRVGfzlDYfMaVEXZI6yu+qIimhHeqEN6N9KEa8RyUXzJQ5XlbLr/GODzYxTMwhylj7wPzOxprY9A/KExSAxOhnLsQA5yjDeILAHSmdwFhjmwCerbGcRLYRTdm21+k7pP6Epzp/NGFaWlyusFRfZlnRe0WfEH9h9uP;25:sZmbFzDFTDwND66feaQfKPFvwqF/daHaT05A9Lkr+iXetBTF6Hw3g4TAnoSg7ifK6zDYA5uM2RXS898Vl6jD8QT2tEEacm94yA+eRQB1DmR1OlNR05KzZYA5pdgAwOfmRD6pQTcSzudYMyM8cjgA2D1bCrd3fVehg/8IN2UeTjgOAjs/8rJXUjGud301FKKLwUbk4/06zPJI5jd4tkHMXx/bTWk3U33IpKNNtbEoibWgqvGSn8Ew9ZBHvkMNLAm7vIIQsyzkEYKx+A+AlmBifU9o8aPBTX7f46QiL+bhuOyABoU41H45h7Oq4bLp8RY2NXMPZZhL6Zbg6PZyIGbf0g==;31:xU7ucwcz032dw+cT9n3IgJZSHrxf2XxM/lKlGzqQ+Dv3qtoH+O3uTwLGYBGHEOnLvvAlhiWtH2vgYvgmIvY5Ffg97JGKhJdHCEV/0K7BW7/7wCXK42aPSWkz0AJaKQcavO6hcnQ4qwkfVNm9ZzjQ0EbVUL2S7mKGt52LqVVY79dn7NZu6y2MSCiaIzbqGlNvHCSLHmLUnedS/KWLBb8uHr8uwcObFZ0//h8wGFt2+PI=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27840C120D4D1C16F797CA62BC8A0@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:5s/sfBN/S6p3twCa4QX/ifHW/zaRtGd75i+SIoT3AXwpAWVxbu9TFrXyv4IsywevXiPTV5bWybngcXyAxKmiOIJpP9z403M24MLoIwZ7iaKnqkC5uglZolo3Q7uuWXPo8zymCrswvP1/7RiOnIoLiuiX/mllXgYcZ+fV5GwDC0fekqAGGsmnfndTT4z6mv0oedYyy/yQShGE6tWRu1pvDiwSW6mbtuh7UA1wa6wB/Wmn7P72XLA2aGMUlRfG/xwLGEdzqL7//OkQZKfcqG6mi269I3O5GSSxNwMiiCtybyfe16Lg4/GGqkzfy/cdjwBr
X-Forefront-PRVS: 0650714AAA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39380400002)(377424004)(26005)(8676002)(47776003)(2486003)(31696002)(23676004)(25786009)(31686004)(230700001)(50466002)(3260700006)(8936002)(36756003)(86362001)(66066001)(36916002)(76176011)(81166006)(53936002)(117156002)(7736002)(229853002)(52116002)(52146003)(77096007)(386003)(6666003)(53546011)(4326008)(5660300001)(186003)(16526019)(65826007)(305945005)(2906002)(6246003)(478600001)(74482002)(7416002)(316002)(11346002)(2616005)(3846002)(446003)(16576012)(956004)(6116002)(6486002)(476003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODQ7MjM6Tk1va1BNRndCemVzVlF6Q1FwUmpDZlp1?=
 =?utf-8?B?MllSMXJCejMyOXpRdTRkNXRJN1dSWHNHcC9IaVlta2p4S1VjYWhvMjRXd3Bx?=
 =?utf-8?B?UjgvZkszTnJXSEwxNjVXa1pxb2pGZUJxekR5UWpoM2NYNFgyaWU4a0JBbk9N?=
 =?utf-8?B?c1E1ZFFtWnA3eFNEQ2llblh1dzFNa3FHZTVwNjdkWUJzcW9BWkQyK0xLM1U1?=
 =?utf-8?B?Mms5TjZzaVd3VDFlZEgwa3FHbFlkRzFsakRFenNibTBKTmptZDc1UWRCbStU?=
 =?utf-8?B?Zi9wVHI2ZU1rUTJQWUE5Mk54blRPVDhkMWFNaFI1UmVOOVdoRDRxbGJhYW80?=
 =?utf-8?B?R3ZtWWdzRnQwcTdJcEhRbGhpU0IwMnFzbzVuTVZOWHljcmxrVFV6TklqZDlD?=
 =?utf-8?B?aU9RNys2TEVwOFpVSnIrNUdwSlR5MVprdUo3UThKUTBnRUJkdkRxZGltQmVO?=
 =?utf-8?B?TkcxbXZXdXlrSkhLNTczOWIvTm15MjdFZ0VtNjFGODR3S3dLY1d3UDNtMFFo?=
 =?utf-8?B?b0YrVjFadUpiWnFqcExQa2poRVZncjV4M1I3dTFUcXRCWTM4L3ZIWjJzVnRY?=
 =?utf-8?B?RkprNXJQaDJlZTBxT3ZPejhLT3RjcnNZaWM0YlZwanJpQWxTUktqUEUyKzY3?=
 =?utf-8?B?QW15Rko0MTNHaEQ1R2tpN3NoK1R6NWdBbE05d2Nsa3VNS0pWODlqSWprZ1Iz?=
 =?utf-8?B?b1NLaElicGFOUnBjU2hIb25pbVdPMGdFVERxUzFzMWVwYitNSTVucmpBZnNr?=
 =?utf-8?B?ZFY3a2tlc0xqMHVRWWtNNWFseUI3MkFuYWx4aFJ5SzJ0RjYzZ2xTSjZ6bTRD?=
 =?utf-8?B?eFU5Nnk5TTdiNHQwMUxMUTRWSDdYNkxiNXcxTE5WZ1JaZnhUcjZRN3IwNTVa?=
 =?utf-8?B?NVJheU5SRy9rdHgzZ2VMQy9OVGpnLzBvQ1BxczVaY2NGVnNXZlNpclhHOTk0?=
 =?utf-8?B?dWt5QTdDK0ljVFZSY2Q1eHBQZHltVFhidVF3eGlYRGNzU2pxL3dZNWVzdlZ1?=
 =?utf-8?B?S25uZmZrYW9Rd1JpVUsrWGd2RnlEQlNoK1VGcDF1dThmVVJlWi9aVi8ySVN1?=
 =?utf-8?B?K0o2Z1ZZa0pXY0Z3WjBhK1VraXkwTUNnWUtSdGNFN2xBM0VKbzF4SmpXYlV0?=
 =?utf-8?B?RjIzOTB6dGFpd0lQL3k3UHd4RmV2Mms5QXRaeWwzbEc4cjRYbFVkZkNZcnZh?=
 =?utf-8?B?TUFrTElVV0NTeDM0aE1PeHdUeFNBamIrWndnMXRCb0Z6aHN1WStQTjg1cDNO?=
 =?utf-8?B?MU41alRwTVUrZTJ1SjllY09HKzlOK1g3K2xlamtmNW1zUnplbVpMTDViODVK?=
 =?utf-8?B?aU52Yis1R3pNYjFDZFNCaExVR3IzN2did1VIUkNDQUxodUduWlUvcDV1RE0w?=
 =?utf-8?B?Zk4ySUU3RVI3TWRHdVV3Vzl5cXc2a0VOQUU2ZElha2F6eUtTbHphdE9DTzRJ?=
 =?utf-8?B?ZzZZenFXZ1hkM2tLSUR1RlBSV0FBTmNkN0RDaFRsWTJIaGZvZmttMXhIcTA2?=
 =?utf-8?B?elpNOVNjMURlYlhTbWRGQS9yMjlINVk0N09abm5BbjZoRm41emhBQzIvbHNx?=
 =?utf-8?B?bmljVERYSGdoZUQ2YlVEK3Y5MTNRUlJLVVhaaGI0VFB6Y2tlcHgxcVYrK2hZ?=
 =?utf-8?B?U1NQYjBQL1h2TXNJV1M5WjRaUisrNUpWaytPeHY5bi9QUFlmb3lRd3owUCs0?=
 =?utf-8?Q?EMUgDVsD089G+fEjXfM4=3D?=
X-Microsoft-Antispam-Message-Info: MrO+W4EFZZ9ZHmn4RA/U9x7L4SIjxugJoaHuefVuqFG3UY8XGFcQrfG5bCwWHMbNqoqkIM1OOA1zQz44tmkewR+aAKy5g2nDBXNsa1yTFM6hCgIquFEzWOvdp3YHYqdGKhplQCVcT7pyqtL+IHF+5AfJnvsb6Z4FJNDCjZ81fL0Ob1L8jCaUtmBFDz0TNYJa
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:a26cekPV3EfoCL0cY50+aiV/JvDZjMwF5u7mIn+qpbRIglwacOW9yTxFWmVaeVQS610cVECfIZSm5PByK+eUwbO4GT0EUFw4O+7oIcHYByLuO2/pElGTw4jJa8TEDcAFmk/V2XjGR/W4fPbH/bDNTdTsrjXN3UoUZjoBIU8rEOkJq0X0WlNqUBr0TAlibQHA6bV5i7+m3sqLmkkGGUDcsabuoeUIwxUEqGms5MRIdxK5uxbNNblj3Kul7d/vu0mo0z0QgJCnzwsAeyLihWhG7LTCDHmNZRt6HvlGVKlfo2ryh/5ecYyP8fweOJEtJQZ7fHAhagsMmkSnWUbGFC0uVL3YUAyTIoNb/lJiino43Qk9QNPcnQG0vvpGcdNBt7ZhJFsYS9Lkv14dOYMRlvf7rBF51ydbs53yxdWFR0vPsBn+rbYBX7RxG83dURkGhen1voG7gTGLGK9PDPs/j0j8Ew==;5:tWhi6x3aSHiVwm/ZANpoXIHqZ4b50UAVlTlpGO1rTz+X+UBICchr25PbWdcEvBy248Em34kfsFAs6ve9pvssuWaf+Ri3Y/iLQbUgiMgCPDs4Df/uQ8soXTn1aGWToM64sV4dv68M2t3q+LBsbe8eg8ZZEMDh/cRMzctng6yityo=;24:L+YNFxpX6PQyz7Ur6DasuHkAmpB0/RsBlX/6BdzmjXmaypUbYtEk04QYOX/Y2ziYpAN3TwUiKvw1Ed42TjkVU5r75JXqD6bjAOZOtU2S5N8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:73d4rFr9P8uQgscgV/X+rLLpnOB9JQJ862NJ8nyconeS5nSY53pdEKymyLn7Oo1iA3v7pRFK1w0o5k9AjTyMwLl5atmG7kld2QAYMMwg3Y1UL4f9rpC5qs/fMKtcxsrMYVdNcDJZh+h/8UDkNMCXTPCbVwTTqRBxPHezg9KazKUpppBL9S9KHtSwsiO0YH9Cu979dCmQT+IRDxDCsE9qgzayyX0e0XvTvqtqHZZ15ylgUQBFlw2vhNUoCyAWVik4
X-MS-Office365-Filtering-Correlation-Id: 8fb17256-174f-4868-6b86-08d5a88bf916
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2018 20:02:26.8210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb17256-174f-4868-6b86-08d5a88bf916
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-19 11:31, Jacopo Mondi wrote:
> Add support for storing image format information in DRM bridges with
> associated helper function.
> 
> This patch replicates for bridges what 'drm_display_info_set_bus_formats()'
> is for connectors.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  drivers/gpu/drm/drm_bridge.c | 30 ++++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h     |  8 ++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 1638bfe..e2ad098 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -157,6 +157,36 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>  }
>  
>  /**
> + * drm_bridge_set_bus_formats() - set bridge supported image formats
> + * @bridge: the bridge to set image formats in
> + * @formats: array of MEDIA_BUS_FMT\_ supported image formats
> + * @num_formats: number of elements in the @formats array
> + *
> + * Store a list of supported image formats in a bridge.
> + * See MEDIA_BUS_FMT_* definitions in include/uapi/linux/media-bus-format.h for
> + * a full list of available formats.
> + */
> +int drm_bridge_set_bus_formats(struct drm_bridge *bridge, const u32 *formats,
> +			       unsigned int num_formats)
> +{
> +	u32 *fmts;
> +
> +	if (!formats || !num_formats)
> +		return -EINVAL;

I see no compelling reason to forbid restoring the number of reported
input formats to zero? I can't think of a use right now of course, but it
seems a bit odd all the same.

Cheers,
Peter

> +
> +	fmts = kmemdup(formats, sizeof(*formats) * num_formats, GFP_KERNEL);
> +	if (!fmts)
> +		return -ENOMEM;
> +
> +	kfree(bridge->bus_formats);
> +	bridge->bus_formats = fmts;
> +	bridge->num_bus_formats = num_formats;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_bridge_set_bus_formats);
> +
> +/**
>   * DOC: bridge callbacks
>   *
>   * The &drm_bridge_funcs ops are populated by the bridge driver. The DRM
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 3270fec..6b3648c 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -258,6 +258,9 @@ struct drm_bridge_timings {
>   * @encoder: encoder to which this bridge is connected
>   * @next: the next bridge in the encoder chain
>   * @of_node: device node pointer to the bridge
> + * @bus_formats: wire image formats. Array of @num_bus_formats MEDIA_BUS_FMT\_
> + * elements
> + * @num_bus_formats: size of @bus_formats array
>   * @list: to keep track of all added bridges
>   * @timings: the timing specification for the bridge, if any (may
>   * be NULL)
> @@ -271,6 +274,9 @@ struct drm_bridge {
>  #ifdef CONFIG_OF
>  	struct device_node *of_node;
>  #endif
> +	const u32 *bus_formats;
> +	unsigned int num_bus_formats;
> +
>  	struct list_head list;
>  	const struct drm_bridge_timings *timings;
>  
> @@ -296,6 +302,8 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
>  			struct drm_display_mode *adjusted_mode);
>  void drm_bridge_pre_enable(struct drm_bridge *bridge);
>  void drm_bridge_enable(struct drm_bridge *bridge);
> +int drm_bridge_set_bus_formats(struct drm_bridge *bridge, const u32 *fmts,
> +			       unsigned int num_fmts);
>  
>  #ifdef CONFIG_DRM_PANEL_BRIDGE
>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
> 
