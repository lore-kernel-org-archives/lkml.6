Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbeDVUIg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 16:08:36 -0400
Received: from mail-db5eur01on0115.outbound.protection.outlook.com ([104.47.2.115]:21920
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753495AbeDVUI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 16:08:29 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Subject: Re: [PATCH 6/8] drm: rcar-du: rcar-lvds: Add bridge format support
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie
Cc: daniel@ffwll.ch, linux-renesas-soc@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1524130269-32688-1-git-send-email-jacopo+renesas@jmondi.org>
 <1524130269-32688-7-git-send-email-jacopo+renesas@jmondi.org>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <11e82e23-4ab0-7441-1798-1eeb4fb96995@axentia.se>
Date: Sun, 22 Apr 2018 22:08:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524130269-32688-7-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0101CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::15) To AM4PR0202MB2771.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;3:nhu6LgX+o2wr1QocuzYGbx75gVCJy8XvPtK5NTmMy5Tr+2t1glG7IrUEi9pUnPsP5jTia7wJp0hNYjJiWBZrZGjS3rXfgFYZfhkUOxnatLtowCUbQPdvxhRNHz3eGbLqpb8YOVrB52FOnWCP5xXgfGBYm9N4Z73/loS3dI1outCPn/Bc+KjVmCuYViOFOjejwSfpWQTbT5dvRvqE5LpL8QbCjchRlHgvPVRREpyLUDR15T8a7WKqXyeLH+5rkRAx;25:260tpOnIJBt8ZouDoojmAgtoJoKW1LAFyFZpU3nbZFL+4uTnspOEvn4vovuWlwWjBlzrRR138jSXWEv+Kd4m+Y4yK/+yXYWOOttJcfCf2VlROMDU/YZ5ett4hCwMYPV2ttgPa+70eXN+VzYxYaIB4UaKCm99i5kYQDFhBywuGw0WF3ZQPeWXJKDE6iV/XNQp7NedZfBvVbyzwz1RszAEUl+QuadIHVdPCjvpv76FePXR7dpKkT/VhBs8kNzuucIvi4+WvyV5KYbJi5rzopTUAIx8e1cfMRhY+c4oiWm9bAZCxPsIf095wL9rgjk0npTCcm5+5rZptkkTLtFjtOzVow==;31:BGLgc5Ivjc4isvjgEj22wLespYKT13r+4nHI0i46lCsw6ThrPiONVnCR3y79ep7KCHi+X+CEtsGLpafmPEhPFzS0DrpACJ8nq0bgHt2rxvXaWCt6tjiRSiIdPxnkyEzZRemyLuePDCukD3u5LOsu2waW7ux0e85cwJxhtT5cb2MMwoDQiQKacnZ2KP2zEKJL1X6onKjXVSkGbwxG8etk2NJ/fc0/lDQQmu8fz3ykLxc=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2771:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB277184614675D5C3C1397393BC8A0@AM4PR0202MB2771.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(6041310)(20161123560045)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2771;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;4:7qA220Ok2J7AAlO0VvTEfMNjPdcBgPtSlR7wQaGIVzOehvjp8bKC9N4lGfrEiK+vBTIg0tDyEkPsJiFdXZjHC5BJhSwUi0pAdtXazOresFUGHd8h50hpbueigr7EL12x1UDM+nKH6xeKkRtxH++IVawT062gKSaGRbYF68utK0ZieVpA9QTk08W0IDb0rz+oWkiZbHKvT0Y3N5ZyNDR1YNac97dgjbGPOt1r8Fe9p7nb8Yish9d/N8GvjeV/NraG/xhAWV0fvqc3RsGkczgyJo85IAu4cH3JO+VuccHsHXG++snKGIgssPlm79NA+Zom
X-Forefront-PRVS: 0650714AAA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(376002)(346002)(396003)(377424004)(16576012)(316002)(6666003)(65826007)(478600001)(3260700006)(7416002)(31686004)(36756003)(66066001)(25786009)(446003)(53546011)(6486002)(53936002)(229853002)(50466002)(117156002)(11346002)(386003)(23676004)(52146003)(2486003)(36916002)(2616005)(76176011)(956004)(4326008)(476003)(186003)(8936002)(77096007)(26005)(8676002)(6116002)(3846002)(6246003)(52116002)(74482002)(31696002)(16526019)(86362001)(575784001)(5660300001)(230700001)(47776003)(305945005)(7736002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2771;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzE7MjM6RVRuWEdNNGF2bXFLQTFVektodmZtY0Fh?=
 =?utf-8?B?VW9FM2VxZmVoazQwSE1UNm1IVTNGaXVWNEdDNm56VHVHaUtsaDlYS2F4amFF?=
 =?utf-8?B?eENyUU4rZUdvejU3S0p6cVowL0hWeDVHYVNMZC9uSGhCTVZ5RXFqdnkwWWVi?=
 =?utf-8?B?K3BDUUZhTVZZSDFXN0JkaFcweDZIWHIrMDdsZkVUMHRUcEEzaW8weTRBc2hl?=
 =?utf-8?B?ZmRHRVJ3QXo0dmVqbzFYb01idUJlUFNUejI0OVhkcWpKamNmZER2QU9nZ0t2?=
 =?utf-8?B?czMzRmJaNVJMSlhodGxubWVLQTdzbGdrZS9jNzhsSmszSFhkdk0wTHdTNG1C?=
 =?utf-8?B?a2Q0QzVpanJEcEhaRk5UbmIzbkxOZVVyTTRDcXg0YnFjUE9LQW84bmhKZUd1?=
 =?utf-8?B?TEZTRWYrRE5Vai9RajRibExEUFQrRno5SDBwdlNLdjdNZjJmcXVVcW4wYzMw?=
 =?utf-8?B?eHU5LzBoNUMxRHpadjNyQitSYkFST3drRG9hSHg2cngxaHJCaDlYTitDVGhR?=
 =?utf-8?B?eWpCR2pTYnhIWUx6TkRUZVJrcUZMZUJaeFhMcEZBY1hzK0VGNnV1elFvYUtX?=
 =?utf-8?B?cjVRV0RZQ2tMWjVwNFFxM2V6T0RpbDJkazJlbGtoMlMycC91ZmZud3E2ekNT?=
 =?utf-8?B?dytaVmVoKytZVkRYd3JuNXlQR25FTHVWL3dOSHA0QXRZV25Tck93Nll1N0J0?=
 =?utf-8?B?YlgxQ1h5bnRLclQ4QVBrR1daVFRDOWd3Wk5TTjIrUnVqZE10YytNelJ0L1pV?=
 =?utf-8?B?VjczYXlUL0kxQTdGTXpHZDlpcHJwUUtWU2ZQNzZ2cUZBY2RqS2RtSTB4ZTIz?=
 =?utf-8?B?R21WQ2VBUTl0NHVtWGM3eXBlcGZQYm1BRjhwWWkzVFJYUWlrWTg2b1orNmdj?=
 =?utf-8?B?RGtRZzVpWUE4WWlMK0RWWng0TlhmdmcwUGZVZ2xOZzVSUkpEaUVaUlJ5aFk1?=
 =?utf-8?B?Mm5uanlpZ1VGS25nZzRlcHBVS2tsblZBQnJweWl3MnEyZ24xL3BmZ3VFbHY2?=
 =?utf-8?B?ZHN5VUFxbzE0UjFGazk0a3VzNFVoUGVpV2MyTFJlUFJybk9mUHljL3c4dHJi?=
 =?utf-8?B?eHpHNkRKcVQvandYZkJMNkJOMG42Tm01RGp6Z1U5SmxuNjdNZjA1SnlXUGRN?=
 =?utf-8?B?d3JOVE5IaytOdmdleUxZYkgzQ3FVWU9WclVGeHpFSEV0ZHZ0QkZ5czUreGlM?=
 =?utf-8?B?WmxJdERDM1RUQ0dNWjBQanZDZmNsRURQL0VNK25BZFdqQ3h1YllQVjdGMVFr?=
 =?utf-8?B?cGpSalhyUDdQa1Y3SUtidXQ2N3ZscXdITzdOOGcrMS92TmxiS2JZcXhVcjlp?=
 =?utf-8?B?QVBIR0l6Q1Baekgxd2VIYzFUUFk2ekpBb3NUNW1rcFJZaWtWdmIzYXpVYTgr?=
 =?utf-8?B?a0FFa1M2ZWoxTS9pQmZ6d1dOM2JuK29mYWRiN0xyaVViVEo1RGxURWMwVGJn?=
 =?utf-8?B?cUNVR2h4VVhLVUZqN0Z3SGpSY096azFMNHZoQzRHblFRMjhTUlkyS1pmVURl?=
 =?utf-8?B?cjEwUjFJaHZ4UVFDQmZDalhrS2kwblVyVmhTbjZNbGdVczZDZngweHVJVU1W?=
 =?utf-8?B?ejJrZURpT29aK3gvTFRObkFJYWFJZzcvVVIzUWg1SVdaaFppNDUydzFzcHp3?=
 =?utf-8?B?aTM5OHpNTjBwYUQ2VGpydTYwcmtNN2N2c2F2RXcwT1BtRUJvNHFwaG1iZkta?=
 =?utf-8?B?TGdGTHR6TXozYWMvSnA4Q3lsalMvSjA2aWlVWUw4ZmJDYzloMDVBTkNGK0lY?=
 =?utf-8?B?QXYzbXhLaTluRXE3OGg5S3h3PT0=?=
X-Microsoft-Antispam-Message-Info: 3rLc4etRpKHxXy+j3wmaG5IOBUUgryrPnjLgvh0re5Av4NTz/V/tiM9H8i6AbD2dPdaqcckuuWZek08A8zBcYAbVHx9tzFZPND9jDTlwTypC/9YxFR/WSMAmRfDmahwCx1MIJh6NzDzyxjuLuTq1n+z9GzWUgffrOAvuzvco4sLSfOuG0QjFiSwpy9/nKCgc
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;6:QZgXXFAOqItjxSsZUTUi9aH1tT06j+GI5Qba//QhcFCM8fTlR0UhJqTuEkTuhwRJi7y0wHkLpzch4NYKs+jVb0zzWtVPOVX3nKiYpnHYYxrRuZZvnKUtk2s4y1TrLqDQHvdADuv5FOyMcb8qcAFY4jiItg8ei5vDRHYafqkE0LLGO9LabXSkG8JNj/+rsbgpd7XdgyyBKR+wSTgMJ3ueBQjrzVy4Mti/oDDgpIDipQ7pEl5ZBiEVvBGGkn9hF6GtSmNM73Bnsr/uXVLSn9vU04m6Uzv2YRnC0z7V/H0gZeeJmmqMIry6/eGAdaaLcirri9tyrrmYTs8+CApteDlJA2/2qV+kplFy7p1ILXUIDHDvj7MdSeB/D059pAdX1sLCyck5SpWgBfFfTwrjnjRD10L5E10Ry5M0gjt2DfEASG2qCkGfTg5H6V3iuII7q8kWLaINYkwEz557jpOZowKi8Q==;5:gjhyOlpEwnaSD8V0OgXqiSnVMoGpYWmi6O37Rz78pEmvG0Uf+E8b0VfTVgguQF8pIpCNePJX+3KJi4r0s8FoQ5SajJlyxRTF6Ah9UJyjd0JQ1kV89w9jw2vRQHpZK5rrmDO9aVnLKGuV9sEgqyxQfhZYRQ+CmiT2hw0lmgnKi80=;24:AnKd4+A2wplThkuZ7RHNVKEqxTsXpVCn8OdIKjKJub903ynF2pVCHoIqZMBnbw7bMDKQIJjkMIqqvGoFmAGG8Qe1KI4GJUGHSoZ0CVVDm7g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;7:mt7bd7qdf4GaVbNslnv5vKQx/ikznqrnyA7m12PlED4DZHWg2pH0MwFNdWl8+DRt2Wv0/5OSGlxxedYs2eO2AcqXekbFOg8Ma9VMnQMM+YRdhIYlmWQGW+G2UdWBy5rtOF9SliIkFog81bw43arf8DllDTCuh7dR9CucE56zfVLJSocyjilDnCD9uGWCPS/YeFNFtsMMnpRs/DOEad1b6OaNApn5BvBeaea84qMSLCdQIhyMglxPZ6G8/E5jCv6U
X-MS-Office365-Filtering-Correlation-Id: c96ceceb-3cdd-422d-b359-08d5a88cce6c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2018 20:08:24.7224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96ceceb-3cdd-422d-b359-08d5a88cce6c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2771
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-19 11:31, Jacopo Mondi wrote:
> With the introduction of static input image format enumeration in DRM
> bridges, add support to retrieve the format in rcar-lvds LVDS encoder
> from both panel or bridge, to set the desired LVDS mode.
> 
> Do not rely on 'DRM_BUS_FLAG_DATA_LSB_TO_MSB' flag to mirror the LVDS
> format, as it is only defined for drm connectors, but use the newly
> introduced _LE version of LVDS mbus image formats.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  drivers/gpu/drm/rcar-du/rcar_lvds.c | 64 +++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> index 3d2d3bb..2fa875f 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> @@ -280,41 +280,65 @@ static bool rcar_lvds_mode_fixup(struct drm_bridge *bridge,
>  	return true;
>  }
>  
> -static void rcar_lvds_get_lvds_mode(struct rcar_lvds *lvds)
> +static int rcar_lvds_get_lvds_mode_from_connector(struct rcar_lvds *lvds,
> +						  unsigned int *bus_fmt)
>  {
>  	struct drm_display_info *info = &lvds->connector.display_info;
> -	enum rcar_lvds_mode mode;
> -
> -	/*
> -	 * There is no API yet to retrieve LVDS mode from a bridge, only panels
> -	 * are supported.
> -	 */
> -	if (!lvds->panel)
> -		return;
>  
>  	if (!info->num_bus_formats || !info->bus_formats) {
>  		dev_err(lvds->dev, "no LVDS bus format reported\n");
> -		return;
> +		return -EINVAL;
> +	}
> +
> +	*bus_fmt = info->bus_formats[0];
> +
> +	return 0;
> +}
> +
> +static int rcar_lvds_get_lvds_mode_from_bridge(struct rcar_lvds *lvds,
> +					       unsigned int *bus_fmt)
> +{
> +	if (!lvds->next_bridge->num_bus_formats ||
> +	    !lvds->next_bridge->bus_formats) {
> +		dev_err(lvds->dev, "no LVDS bus format reported\n");
> +		return -EINVAL;
>  	}
>  
> -	switch (info->bus_formats[0]) {
> +	*bus_fmt = lvds->next_bridge->bus_formats[0];

What makes the first reported format the best choice?

> +
> +	return 0;
> +}
> +
> +static void rcar_lvds_get_lvds_mode(struct rcar_lvds *lvds)
> +{
> +	unsigned int bus_fmt;
> +	int ret;
> +
> +	if (lvds->panel)
> +		ret = rcar_lvds_get_lvds_mode_from_connector(lvds, &bus_fmt);
> +	else
> +		ret = rcar_lvds_get_lvds_mode_from_bridge(lvds, &bus_fmt);

What if no bridge reports any format, shouldn't the connector be examined
then?

> +	if (ret)
> +		return;
> +
> +	switch (bus_fmt) {
> +	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG_LE:
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA_LE:
> +		lvds->mode |= RCAR_LVDS_MODE_MIRROR;
>  	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
>  	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
> -		mode = RCAR_LVDS_MODE_JEIDA;
> +		lvds->mode = RCAR_LVDS_MODE_JEIDA;

This is b0rken, first the mirror bit is ORed into some unknown preexisting
value, then the code falls through (without any fall through comment, btw)
and forcibly sets the mode, thus discarding the mirror bit which was
carefully ORed in.

>  		break;
> +
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG_LE:
> +		lvds->mode |= RCAR_LVDS_MODE_MIRROR;
>  	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
> -		mode = RCAR_LVDS_MODE_VESA;
> +		lvds->mode = RCAR_LVDS_MODE_VESA;

Dito.

Cheers,
Peter

>  		break;
>  	default:
>  		dev_err(lvds->dev, "unsupported LVDS bus format 0x%04x\n",
> -			info->bus_formats[0]);
> -		return;
> +			bus_fmt);
>  	}
> -
> -	if (info->bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
> -		mode |= RCAR_LVDS_MODE_MIRROR;
> -
> -	lvds->mode = mode;
>  }
>  
>  static void rcar_lvds_mode_set(struct drm_bridge *bridge,
> 
