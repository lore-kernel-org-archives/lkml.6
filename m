Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeDWH7q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:59:46 -0400
Received: from mail-he1eur01on0105.outbound.protection.outlook.com ([104.47.0.105]:40983
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753005AbeDWH7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:59:41 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Subject: Re: [PATCH 6/8] drm: rcar-du: rcar-lvds: Add bridge format support
To: jacopo mondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, linux-renesas-soc@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1524130269-32688-1-git-send-email-jacopo+renesas@jmondi.org>
 <1524130269-32688-7-git-send-email-jacopo+renesas@jmondi.org>
 <11e82e23-4ab0-7441-1798-1eeb4fb96995@axentia.se>
 <20180423072815.GM4235@w540>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9378eadb-1dbf-ecfe-9bd1-40bec21c4648@axentia.se>
Date: Mon, 23 Apr 2018 09:59:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423072815.GM4235@w540>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P192CA0015.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::25)
 To HE1PR0202MB2778.eurprd02.prod.outlook.com (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:ciB74vgH9Um5JbFozTgcLlCToZcrXK4SSR5BQDsnDQVos9vead7WSie2Kj1gGNU/+9PWWVi7tKqGAsDfuu5B8SpviiDYFAnIF50KikFSgBZl4a0X/d+UxwNZYl0m2LqAKyLFMclG887WQJhgURFgWQdLXeFybDFBrkr0/OAUS5+te9PU66SuTCqP0yT/N1EPj4aybOWzwnVUdZwcIf8J7mCE5nt3Dp5DwGzHLt+w5cBL9EotPExalPWMGNFj2ja1;25:FRX6Jc50t/NnnzssH566iAQagFajuqUGEc1j4tSqpT6TiipGE3sWaLjbq10ZT5fkuFfIp+RauiH7UWpEjxk7ayCcX1jRokluGJdJO/nPcvy7MnU1yQp+Bz0b7d42NjnKcUomUODpfZmR4nGqSz2eFnliDwgWoTUAFS4KB7iBPgFWEVi0t3kshSPsyal5qP8o5BSsv1DrJGYpDnN2pTh6y1y4B6oqAUzh9WBi6u1JO/oNFp+TgNtiyAOgIjCvG29zYK3AlGxjxzMZQLuBzBRmTfES26hyv4NAtElX4uIkLshwifeojWvomMkDP64+hSQvFoL/rUH9O7LfihO1+F7UFw==;31:x4CUY+7YfXE3I4qQga9pTldN3jrNgloKZwRrWKNMooS+/WbR9T8xQJxaE6RapMGA617uDjSHhtZzpztpzb1OjI2S1asKcIkm2z8M7jSVICtF5O7UQy7GzfaFnWCv8NacqCbSURvbNyxPWf2mSHPqCmgCsPbpkEcJVGega3EPEpu9+MWrguiqGUiEG7xWVA8c+hA7PqNqjv+wP692kMQ9+F/iTiBl4q1RvmfUJnpDc9c=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27784E9BF555E4C020F3B2ACBC890@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123564045)(2016111802025)(20161123562045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:Tpcn23VhmrCbusueTvIElX+aziOfjkrkT2zYEZOcui0tbDmA7FByvSU0EhqjhYgqGKANcbQV6bQ4tdg+xqv9MgwFzv9XYCZJahrq5dL4KFIQQoQ47Fq5uo0QdYt52w6OYw2bElx7gv+XqexXiKou5nofxMN4EgWI3wAv+WAosvFhejxtKzxb+Bylr7BvnBzHs7jcx/6v8v0pfSW0Jy+rCivTFAye+ZxR5uBXD4+5YvDa7uZP0QdBj7NbHCavyfXxbDnWDeepakS9pR9MafRlPJ5l2GYyoi+kqkuyBpIBkkmeT30oLD7ZeytjzneVumbd
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(366004)(396003)(52314003)(377424004)(6666003)(4326008)(6916009)(47776003)(186003)(5660300001)(7736002)(16526019)(229853002)(2906002)(53936002)(117156002)(3260700006)(25786009)(478600001)(7416002)(93886005)(52116002)(6486002)(50466002)(305945005)(74482002)(6246003)(65826007)(316002)(16576012)(23676004)(2486003)(52146003)(6116002)(3846002)(81166006)(36916002)(8676002)(77096007)(230700001)(76176011)(26005)(31686004)(53546011)(386003)(8936002)(31696002)(575784001)(956004)(11346002)(86362001)(476003)(446003)(2616005)(66066001)(36756003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzg7MjM6ZC9SQ21hdVVEWC9CTzk1YmkvdGZCcVBT?=
 =?utf-8?B?VGZjNzlxM29pMWR6cGFvTlR1TkREZmpyeHRLTmJTb2xPd3k5Mm1wM2hZRTQ1?=
 =?utf-8?B?RzJ5UGlHZGp2N0RRNG5uOVR4bkp2YTlxeWVscUlRYmdybjVYZ0NwV09vK3RX?=
 =?utf-8?B?dzcxRVdWTGxaeElXSStZTlJ4blRBZmsxcXdud2M0TzFXakFKTmwvNnNqMGtY?=
 =?utf-8?B?WXVnR1FMTi9SVkxJeGhwZkNrZzIxalVDVit3RGlQYVRUVWUyWUg2MHBHMVc2?=
 =?utf-8?B?Mk9jODZUR0tFempHUlpCMXM0WTRFSUsrbFZvc05VQzhTdzNRcFlLL0J3SDd3?=
 =?utf-8?B?eHFmK0RCN3U0MGxuL01JRHhLZi9taEdBRHVmaU4zNElCVWdBZjBtamx5WFlX?=
 =?utf-8?B?SkdMaWNhNDFlYWY4RzQrUlI2Z2VpTTZlOXJYSzNtNk9DRXJhY0xqWVBJelVD?=
 =?utf-8?B?STdrS0lDT2w5MnJPeWcvR3dFWnBLM2VsU1JkWFArRWp3TUJKU2tidklDNkxI?=
 =?utf-8?B?SVpLSHB2K0tjeHM4YzBsS1BiS2hhQlc5d0R4OGlBOFB3U3FmTzFzV3ZqaEt3?=
 =?utf-8?B?TWNrKzh1d1pndXE1TU12WmlBcS85a2tjY2g5aDJ4QXArNy9WSUFSVW9EUEtE?=
 =?utf-8?B?NTdDUkFOaG5kNXNoR2k1ZTZzWnk2azFGR0tSV0tqdjkvZkxNcm5rMHUzc0Zn?=
 =?utf-8?B?VDhKK1duc2VFU1lySGZzd0hwSUtPcnN0UmkyS2s4Yk96cCtibk1JZDRDb1pM?=
 =?utf-8?B?TmFaanQyN2xzZjBTWHJXU1BGcFZYZmovZmlFTVRDUkdaZER1V3VaN0JMOUdK?=
 =?utf-8?B?RTFuQW95QnA2T2k5OFptUU1sQ1h0em5QTEg2Y3Q0ZkxKNG96LzgvekpuNFZP?=
 =?utf-8?B?aHdzczFSMDkwYnJpRkRKd3VOaTd2Tms1dFpCdlY2d2ZhcEN6dVVJS1JteU9O?=
 =?utf-8?B?RkdJcGI4dS9WeDBXUVF5cFB5WkxibW9wQ0Rla0lIN3lIQ3FwRTRzcmQvSHFu?=
 =?utf-8?B?dk5RaklzSEx5bkhaZTZJQmVlcHY1cFh5TzFib21Nc3E3US9sYTgyMkQ1aUxR?=
 =?utf-8?B?REJPcDF2b2diVzREVDN2L0dtaFlDdzhQdGthVWJLV3JEclNyLzdqcy85OWM1?=
 =?utf-8?B?WXBtVHRVNWl0Z2U0QU9QMTVMNDlFTVlYaldycjNScVNWdWpJM3djSDgrbWxS?=
 =?utf-8?B?cTZOclRUbU1mSW9sQjZFdWxiMkxQR2lwZUdwTitpYXZGQ0FLZlpRWFFaY0xB?=
 =?utf-8?B?TjNpaC9DUXVmZ1RiaXR0dFU2OHhVSmpTOUNmVkRMeDhvVXJiMkgzSld3eCtk?=
 =?utf-8?B?b3gwaHlJRnF4ZlFraCtHcElmYnR0cFZYUmxyRFhlaWplUXRHUGJGVVVjZFlS?=
 =?utf-8?B?U2NucTZIb05KZFJLQmlxS1BuNldDaTdlY0JYQ01OTCtOc3dkQWNjeUNIRUlS?=
 =?utf-8?B?WitHS2o5UTFWUHREMkt1dmlaenZEaTlwUFRqZVhpQU44WjhhUmhxSzQ2ek5J?=
 =?utf-8?B?a3dnN0hXWGMybDBDMFYwYVZNd3d6Tzl1U3ZpSjB4MHlvU3MrZitoU00ycEN3?=
 =?utf-8?B?TnN0TmgvaWFEZFM4V2gzNUY4NVhvOWRteGpXZWp1MDJLcWNMV2xQS2MzMFFO?=
 =?utf-8?B?eTh0MUlPdU5rVHBOLzVqcDA5VTNrQ1B5czVJVll4SmhLSkFGSXpqMWsrZFZK?=
 =?utf-8?B?WTJkeTlSVjBTdDU3U2gvNTZWbDlnckppOFNZcjAwYVpBVWwyR1RwWW13VHhW?=
 =?utf-8?B?OVZHZWRGQ1BtbmdzSU9vbHJEMHhCV1FSb0xyM0p2MUEzQThZSFB6NmYxQkJn?=
 =?utf-8?Q?YCGI6ND220osyGv?=
X-Microsoft-Antispam-Message-Info: pUtlf4jyTD/dh8oyT3uwsgrXp4ropaheYCqhttcHLVMaajBLW5aBKJ3dZdKZ9HGL3BKvqkLvguaL2JnHHBPGB7QgT5AKrEkkITrt/86kd4ZQuJdB5AyqqmRRwSaenhLI9f8zubQb2SfAl+sOoQYSXZ5i7hKsZCi9D3Npsr/dWywTzxd9UiQclcoXZ2Gn/6xT
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:l8aOTMu3FLRV2lMRzqetyUISw7IuTSBKU8umZlc57+G2EU/qo05gFJDMY8yzJTYuq7dZuHRfB2i7FS1tSO7JNNvG7isJee5YBCRQOZLXc5Rv21/LaiKjB2nuuJxB/b4kZmupPBtkKkoYzjwfgEh8W1EqVkiUm26/Tx/U0RRLa2bBN9ylDNi9XxewLxYBGiMrf9/VMy47faJPeUiwxHfJtNT+DZNMfN+XdNtsOprAQH9PY40OUmQO+FfTbjtvRTF/WuAfQqAmVgJmaAmzkyb4mJ6xvHjU142P7P/+eGsxqr2Piy1QWTV+COVqqzopsfIQx88ex9rCCsfxu9wzpfLbHBFITTxzG6XgIKz4TuGfPtzOOvTVyUEaU2otB2H196pVmJTyeUCgG8pqfcQZ+ZhATpHp8yPKGiENCCbFfWnvPXZrsMeEmvTG4B7OoRXk00GVVXXEMwowehb8WxqDFAIJkg==;5:Vclc7XMc9/hnxYyqs2nXzxBWlSZu+7297d6qNaGnFZqMa7R3yfE9IUrWW2yJ8jxVd/gtSEcBajisooZ+VigqoX1CX9oGipRFWwpNnnAYmE8E5J0j4X6R7QNuJjsyaLTpar2oGjtbtmn3i+zjSYMB2+mVIVnxB09JV1N2R5ywXpU=;24:JnwklUUyyX4z+apDtq5VMW137WmXdH5RcVk1PFz++duIAJ/fYk/6NTnSk8T0Y7bx/bJXDa99aSqFIY7Zqk5yyEFUkAcq1InlZQrUOXZDOrA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:QliomEV+vO44akXnzBZZi4L5qgKcIKuiCOkx9eg/VeG+S8dcXAWvtr2hrjVk8KyZnv90UtvZzYrkDhqJvwAfyTLq43JAzMYHuO/n5idTjG3eYJvLe19tJxv/bQPAfsxEJseyxlwQ2kacLUxksRiZXg7TwT8I7cHFCr2G8KuObTa8DVhaPJR+Wu7WHvnbP7WYQ7esFsiGYqgyCa1sPhFhh2jHO9+4G+zZpvYKtsO9wcQ8AeYP5CMjVg7i4SDPig1a
X-MS-Office365-Filtering-Correlation-Id: 107eafc2-1abe-447e-3853-08d5a8f0263b
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 07:59:32.5919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 107eafc2-1abe-447e-3853-08d5a8f0263b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-23 09:28, jacopo mondi wrote:
> Hi Peter,
>    thanks for looking into this
> 
> On Sun, Apr 22, 2018 at 10:08:21PM +0200, Peter Rosin wrote:
>> On 2018-04-19 11:31, Jacopo Mondi wrote:
>>> With the introduction of static input image format enumeration in DRM
>>> bridges, add support to retrieve the format in rcar-lvds LVDS encoder
>>> from both panel or bridge, to set the desired LVDS mode.
>>>
>>> Do not rely on 'DRM_BUS_FLAG_DATA_LSB_TO_MSB' flag to mirror the LVDS
>>> format, as it is only defined for drm connectors, but use the newly
>>> introduced _LE version of LVDS mbus image formats.
>>>
>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>> ---
>>>  drivers/gpu/drm/rcar-du/rcar_lvds.c | 64 +++++++++++++++++++++++++------------
>>>  1 file changed, 44 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
>>> index 3d2d3bb..2fa875f 100644
>>> --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
>>> +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
>>> @@ -280,41 +280,65 @@ static bool rcar_lvds_mode_fixup(struct drm_bridge *bridge,
>>>  	return true;
>>>  }
>>>
>>> -static void rcar_lvds_get_lvds_mode(struct rcar_lvds *lvds)
>>> +static int rcar_lvds_get_lvds_mode_from_connector(struct rcar_lvds *lvds,
>>> +						  unsigned int *bus_fmt)
>>>  {
>>>  	struct drm_display_info *info = &lvds->connector.display_info;
>>> -	enum rcar_lvds_mode mode;
>>> -
>>> -	/*
>>> -	 * There is no API yet to retrieve LVDS mode from a bridge, only panels
>>> -	 * are supported.
>>> -	 */
>>> -	if (!lvds->panel)
>>> -		return;
>>>
>>>  	if (!info->num_bus_formats || !info->bus_formats) {
>>>  		dev_err(lvds->dev, "no LVDS bus format reported\n");
>>> -		return;
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	*bus_fmt = info->bus_formats[0];
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int rcar_lvds_get_lvds_mode_from_bridge(struct rcar_lvds *lvds,
>>> +					       unsigned int *bus_fmt)
>>> +{
>>> +	if (!lvds->next_bridge->num_bus_formats ||
>>> +	    !lvds->next_bridge->bus_formats) {
>>> +		dev_err(lvds->dev, "no LVDS bus format reported\n");
>>> +		return -EINVAL;
>>>  	}
>>>
>>> -	switch (info->bus_formats[0]) {
>>> +	*bus_fmt = lvds->next_bridge->bus_formats[0];
>>
>> What makes the first reported format the best choice?
> 
> It already was the selection 'policy' in place in this driver before
> introducing bridge formats. As you can see from the switch I have here
> removed, the first format was selected even when only the format
> reported by the connector was inspected.

Well, *if* some bridge/panel do support more than one format, and your
driver depends on it being the first reported format, then I can easily
see that some other driver also requires its expected format to be first.
Then we might end up in a war over what format should be reported as the
first so that this multi-input bridge/panel could be used by both drivers.

> And, anyway, as DRM lacks a format negotiation API, there is no way to
> tell a bridge/panel "use this format instead of this other one" (which
> makes me wonders why more formats can be reported, but the
> bus_formats[] helpers for connectors allow that, so I thought it made
> sense to do the same for bridges).

Since there is no way to negotiate, I would assume that the other end
really does support all reported formats (in some automagical way). To
me, the only sensible approach is to loop over the formats and see if
*any* of them fits, and assume that something else<tm> deals with the
details.

>>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void rcar_lvds_get_lvds_mode(struct rcar_lvds *lvds)
>>> +{
>>> +	unsigned int bus_fmt;
>>> +	int ret;
>>> +
>>> +	if (lvds->panel)
>>> +		ret = rcar_lvds_get_lvds_mode_from_connector(lvds, &bus_fmt);
>>> +	else
>>> +		ret = rcar_lvds_get_lvds_mode_from_bridge(lvds, &bus_fmt);
>>
>> What if no bridge reports any format, shouldn't the connector be examined
>> then?
> 
> There is no fallback selection policy at the moment as you can see, or
> either, as it was before, the LVDS mode is not set for the rcar_lvds
> component  if it's not reported by the next element in the pipeline (and I
> should probably return 0, not an error here in that case).
> 
> The connector associated with a panel is only inspected if it's next in the
> pipeline.

But by not going to the connector for the case where no bridge in the
pipeline has any info on the format, you effectively demand that at
least some bridge in the pipeline should report supported input
format(s). That excludes a lot of existing bridge combinations from
being used. Or do you see it as a requirement that bridges must
report their supported input formats? Perhaps only when used with
this driver?

>>
>>> +	if (ret)
>>> +		return;
>>> +
>>> +	switch (bus_fmt) {
>>> +	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG_LE:
>>> +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA_LE:
>>> +		lvds->mode |= RCAR_LVDS_MODE_MIRROR;
>>>  	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
>>>  	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
>>> -		mode = RCAR_LVDS_MODE_JEIDA;
>>> +		lvds->mode = RCAR_LVDS_MODE_JEIDA;
>>
>> This is b0rken, first the mirror bit is ORed into some unknown preexisting
>> value, then the code falls through (without any fall through comment, btw)
>> and forcibly sets the mode, thus discarding the mirror bit which was
>> carefully ORed in.
> 
> You are correct, the second assignment should have been an |= and not
> a plain assignment. The variable is 0ed though, as 'struct rcar_lvds
> *lvds' is kzalloc-ed in probe function.

The code would be clearer if you explicitly zeroed the mode in this
function. Or do you rely on this function to not clobber other bits?
In that case apply some bit-mask.

Cheers,
Peter

>>
>>>  		break;
>>> +
>>> +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG_LE:
>>> +		lvds->mode |= RCAR_LVDS_MODE_MIRROR;
>>>  	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
>>> -		mode = RCAR_LVDS_MODE_VESA;
>>> +		lvds->mode = RCAR_LVDS_MODE_VESA;
>>
>> Dito.
>>
>> Cheers,
>> Peter
>>
>>>  		break;
>>>  	default:
>>>  		dev_err(lvds->dev, "unsupported LVDS bus format 0x%04x\n",
>>> -			info->bus_formats[0]);
>>> -		return;
>>> +			bus_fmt);
>>>  	}
>>> -
>>> -	if (info->bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
>>> -		mode |= RCAR_LVDS_MODE_MIRROR;
>>> -
>>> -	lvds->mode = mode;
>>>  }
>>>
>>>  static void rcar_lvds_mode_set(struct drm_bridge *bridge,
>>>
>>
