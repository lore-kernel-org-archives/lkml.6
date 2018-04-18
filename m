Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeDRHqX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:46:23 -0400
Received: from mail-ve1eur01on0099.outbound.protection.outlook.com ([104.47.1.99]:45343
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751256AbeDRHqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:46:20 -0400
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=axentia.se;
Subject: Re: [PATCH v2 4/6] drm/atmel-hlcdc: support bus-width (12/16/18/24)
 in endpoint nodes
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
 <20180417131052.16336-5-peda@axentia.se> <20180418092948.6dace10a@bbrezillon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <8c5847d0-cde1-73fa-9ed1-4f4a5420afbd@axentia.se>
Date: Wed, 18 Apr 2018 09:46:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418092948.6dace10a@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR02CA0071.eurprd02.prod.outlook.com
 (2603:10a6:802:14::42) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:HoE7G1wmKbA/i1h6DNygMXuDgIpj5DSOvVl3FQOBPcZz+Q5y1+umkb5qdmcY1qSRAcYBs5rn6uxYd8/E5JvpbsGX2+SWekp2VvBsgGeBWkJl70btZcjKs9Bqo8y7KlJXm9f3ktUDRSo3p6Bfq4rXYos+xUARosk7bhYblcy3Woc9bGqkrqVsN4NcuSBm54qmkUK4L1k8xEk4xmKvJSf1NWXKwGzbEz4EETnDB3n4LuaaJp8EQN1z/AHJsyR0Dkn7;25:76vP+EFKoLzUtXFmCXnA6qpK8YtRN/FxUQ02tLQlKWOdnNK0kcoynrWHCQZYSneARJdTAai2VbjiZx7eipcqcVBTtwyj7513krklYCvrBcmZAA4sq/RBI5lQwAYwhuhLMh6iaRzHSoXcfgk27izgLkY8S03+a6AWbhhBDKm2YZRTJvGVg/RZTqICsD3JbBPLts06YyA+8jBGATZ5X+W2EkefqJrgB3phk6ZrxqsETnNjjmG//nPSnssscR9XiHUGNXNviN2ZsTe0gjjA23zEXaRaN6CKpK104u4/YIEugqc34NJI8qdEWG1Efvl66vBrtaj1isOpbJSqvWZWlfxNVg==;31:L5bcscY3KC8W6Cc3F/ytJ0Vr6qG00PAGNjM7q8FeM16bcE+DVCGv7a9Ni6DI6HrEDJLnlqejIyIqSVQ7UllaoaEGtpHNwgFb7QiLZmW8MZefWUNEXZvrPm0zBL8EelJm5b421Fsp8dLsck1EBBOaXo+JnwLi9RjCGvOMhlaO7jPA83PsQb416RV6ZsTDRwLGe64c4lRajVATUCkggt0H1uHgM3JmbrIw7rWaXOeYqLE=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2778A8731AA2C6FEAE69E9AFBCB60@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231232)(944501327)(52105095)(6041310)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:nS+EINVetCNWtYlKW+zFV332fk01F+hi7PxJ6oIk6Qe9qAE5rxx8s/x57NGdt8PLNppLN5hOxsKtH5HEzKJ/OzIiTJyznNgbbE991vCxwI3gkAJx90JJLyJ3SEZNKCVmzkrG1ZGlnKsW0htL8MASjA7nU74SOLpLo9oYVvHjfPQNjSaWfL5t/1lsksgLlkmPzQWtYe6qIQP0s1Yf4vWcmwqjDt7icV7DrAz76q2loCR1c5eOODgHA6LevHbNV50xCEMrar/G0ebRrBC3B7xRgw==
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39830400003)(376002)(396003)(366004)(39380400002)(377424004)(31686004)(47776003)(8936002)(66066001)(36756003)(74482002)(5890100001)(50466002)(478600001)(54906003)(65826007)(316002)(81166006)(25786009)(16576012)(16526019)(186003)(58126008)(5660300001)(117156002)(3260700006)(6116002)(77096007)(3846002)(4326008)(956004)(476003)(11346002)(6246003)(446003)(2616005)(76176011)(23676004)(52146003)(230700001)(36916002)(26005)(2486003)(53936002)(7416002)(6916009)(31696002)(305945005)(6486002)(53546011)(86362001)(6666003)(386003)(2906002)(59450400001)(8676002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzg7MjM6M3ZXT0ZPNHpDWnpnUyt1d1hEeXA5dEdF?=
 =?utf-8?B?TjZUTStabEFmQTBvN1oyTmlHVW1HOXpqaW9JelUvVGNJQ0xqaTZYb2ZnMWJ1?=
 =?utf-8?B?S1pvYXgwQ1hOUzNWdFkyaGh2eURpbTFJUDZsUERQUVM4U1lySlN6LzE2eGkv?=
 =?utf-8?B?WWhIVFc0Tzl1T05GYTc1NnVMbXBIOHppRHFzeGN5MUFmMGxOTVdPbVZBcExu?=
 =?utf-8?B?d2t4Y0VSZXJoZzZTNVh3YTRYNXlIanFEbk55L0g5cE1ZVzVNZWliWmh1T1RP?=
 =?utf-8?B?eHRXTlZSUVBmWkI2Z2lhR01PTVRZZlZRUTBhODJEVGpwWGkvT3hzdlpvdDNM?=
 =?utf-8?B?NmM3eW9vbE01SXR5SVhERmNQTmhZR3pJdDRGbmVJelQ4bkNkUjRYMjBaUHhU?=
 =?utf-8?B?ZHhCYStLWisxcVlVaitNdUpSYzJZMm5icmRhd1B5VDVESmFFVndza001RFVt?=
 =?utf-8?B?TnR6L0hzbUticVRGZ1Fyd05rMERQa2UwU09xNTJPQlpvT0t6Zm0yMFZqUGlt?=
 =?utf-8?B?d3FXUlhOUEFLMERMNlpzTjFXSEx5WGdpYWRhUWJtVU1ralMyekZtZE1MNVdi?=
 =?utf-8?B?ZzdjWFFkb3pHdmRUMW9iTTBYYlZvU21ZUk90ajRCbmRDaGttQW9Ma2JuZXFx?=
 =?utf-8?B?VG1GdEo2OTZHaUJPSnVTN0N3YXh4RCs2MW0xcEkybTVETUNhZnhudkNiNHVD?=
 =?utf-8?B?NEgrcFFSSDVsWE14K2p6cmVRcytIV3h3Wk1FL2VIQTNyNXJDYmsvOGF2T0Vw?=
 =?utf-8?B?VThZSWNaOHM2dzVhWE0vYXVHWk9vZ1BIbUV0a2NtRnZjMU5nZ2NjaTNCamJ1?=
 =?utf-8?B?NE9nYThDM2JvUUlTY2o1VEFkcVluMENzbFRSd0NxaHdxYVNuUEp1UkZCUmpi?=
 =?utf-8?B?ZVd6SzNYQmlGZ1NhRDFVeElJYTVidkJRUFliYVp6ZThzejRJUit3R1FvVjRQ?=
 =?utf-8?B?TUFaUkl2NVRiekIyQVY0YnhZT2RxaE45WFZqQTRMU3Q5WmxtbzJTc00yT1Z3?=
 =?utf-8?B?R1orOWdsYzVFdTdGZG50c3pDMW5KTlRlU3REZkVPSHRlSFNTVUVyNmNFd3or?=
 =?utf-8?B?ZHNYZUV6SGx4c05HSHA5S1BVMFZiQS9sOVAxU21oc2R1VVhpQXJ4VXZpWU55?=
 =?utf-8?B?eS9GR3ZHMW9WdUk5RldqcWFzRVNwQVdSc0xabmJOa3p2SXgwTWJuNFZWWUdO?=
 =?utf-8?B?M1VvWFE2alF4Z2VKYWNYM3NvcGZ4MXQ1WUZxekNySmR2WWY1Wks5eDVMcmhU?=
 =?utf-8?B?dm8wQ292RzUvdXRPUXZwLzM3T3lxaEc0enRFei9jZEhGdDFQVm8wVDJ3c3Yv?=
 =?utf-8?B?amN0K1VZa01PNjV0d1lxRzhGS3I1VE5lY1RHQUEvUG5US0N6UXZKSzhJdWN1?=
 =?utf-8?B?a1BLR2JiUTlMK3VRNy82cXVSTW1zeTh5Zi9hRjlBOHQ1bzNJaExQKzJReXdH?=
 =?utf-8?B?Q3lmdjV5YUFBb1psVnhwOC9OVWhIRmxpUmJUU0RYSkIxbWxnZzlLTFJTb0Y3?=
 =?utf-8?B?RTk4ZzFEOG1ybTVERkFUbldJNkQxNHdIVnkxa3JCbWpUVkFJby9meEJoTVdX?=
 =?utf-8?B?eGpmeFI3R3dCRGFRU1Z6dklkV1R2VEdVOGl4aHIyYm1GTHlRWXNEeHkrMTBq?=
 =?utf-8?B?WTlHeVlVbzlCaTJsaU9VOEFIdS9uU2NNbFJ3Y2tQbXRZS2RvZEx3U0xhUElO?=
 =?utf-8?B?Q2hHcXd6bjd1dXUrSmVoR1pBZmRTVVFiMGZ4QmUvUUVkenJTWmVqMkFkckJv?=
 =?utf-8?B?OHhXb3pSRHZhcmVvbHlUQVlRNktoWGRFdTVWcjZ3Yk4yeFV6YlJwTmVtcWFz?=
 =?utf-8?B?WW44Yklsb0FaOHBBSjhrTk1uOHdQU0JSOTl3L2pkZENQN3F2Zz09?=
X-Microsoft-Antispam-Message-Info: rUBBNDfSCTGYIbhbymtB9WOIrreS27sAABaZADbSXxtLP5RTEXlLXIyIeMfUW0Ln41uTC9ckAoxJeOnMJdqkPapd35LKoVZl4PK6Y/7k8bauj9tEt5KyXaVB2sBI14+7Sp5YEKGM/AGTXHi+iUyHwadjzYfFC5wWsQg9WV2hJBJZI9wSPa2KMFuVODtDdTQ5
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:K9NKMjWt2Z1ZAdNbJGsMjdkZGFP92bNxiq91F4ktNFWHvHEHk1NKVFH+SJkEe4fzVr53POj3l7GnOJXhUhocvHCBNDHuRgYfbV1vhBTQMSGjzQMUShdbVtPs+vVP46eGSd2cn7vGury2DewHUdOsxK07Fh7gJVoAwSuFL496QMlD5FN/KniC0qX2/jJcCb/1BXcyjDz+4LYgxw5Xv5UkOr3ezjV4bNOY/4KuAZa+vAOvHjyr9lYchmSBotiaEKtJdePaIY1H35V5kWwsb+NQPeYCVRc+XwL2R+WqtyH0G+xcf6vtq8Knl4Sil4iGEL7KbTGPgjEtxODnn7c9n2M3NFPWXvNSF7YWglVYnJ2nW0JMYCacv/FYq9h5Mg8XkCmm1G6l+DG9zjkDykCqU2fpjb4m42jqq4m3uNg3eTyVnFc1aPktT9MOkZBClvfQY674ZsyQhtcyVQXkUiwKp3heoQ==;5:UNtlrgOVSNSFhqoAqQsZp+RXqE0RX8hvgGrva590OomIHKTIzITEeJTPAYDCAagpS5R/hGHAIyEl1ad2YAxSCge8ShGSg6tZ2SnmYjLMxFt5zZp5yZ7/YMF5hXQNGg0qBeFm8vIgsd2JXsLb530leQcOeHzkI4SSSBtYk/HukKw=;24:CBlk0Wwqm425ZBdQAxDamUk5en9HuUNumCWIA2/R2WGDRQlKiz2mqrkR6r/cEwXhxaJjXl4IiF23FF2ywgb972e3H5xnHl9OrSA2NnF5nMw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:+K20G6DSx+m8kA7sydrr/w6Sob9LijWcYiaqA3lSmVX2WsRxlFoLCxmzMj8LAlVYUKZiHxNONpxttLn7YSRoNOl8+fQRhxxiZR3Dx3rdZz3bBusWf9DdPbVWtu4vnjFxbFukx3R9G1b8+9wtIKprxRdfeh3j4Ka12qc5G43W1CTRw3Zqu3NGKK6LhwyHn6UZU8sW39wslmLlVoqXQROUYwjG9PcJf3tN5UNDOVerwrR6qiwFMrVxP2yLh1XxX1WB
X-MS-Office365-Filtering-Correlation-Id: 58123b7a-9ea3-4f7f-b198-08d5a5007700
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 07:46:14.0879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58123b7a-9ea3-4f7f-b198-08d5a5007700
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-18 09:29, Boris Brezillon wrote:
> On Tue, 17 Apr 2018 15:10:50 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> This beats the heuristic that the connector is involved in what format
>> should be output for cases where this fails.
>>
>> E.g. if there is a bridge that changes format between the encoder and the
>> connector, or if some of the RGB pins between the lcd controller and the
>> encoder are not routed on the PCB.
>>
>> This is critical for the devices that have the "conflicting output
>> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
>> RGB bits move around depending on the selected output mode. For
>> devices that do not have the "conflicting output formats" issue
>> (SAMA5D2, SAMA5D4), this is completely irrelevant.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 85 ++++++++++++++++++++------
>>  1 file changed, 65 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> index d73281095fac..2e718959981e 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> @@ -19,12 +19,14 @@
>>   */
>>  
>>  #include <linux/clk.h>
>> +#include <linux/of_graph.h>
>>  #include <linux/pm.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/pinctrl/consumer.h>
>>  
>>  #include <drm/drm_crtc.h>
>>  #include <drm/drm_crtc_helper.h>
>> +#include <drm/drm_of.h>
>>  #include <drm/drmP.h>
>>  
>>  #include <video/videomode.h>
>> @@ -226,6 +228,68 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>>  #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
>>  #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
>>  
>> +static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
>> +{
>> +	struct drm_connector *connector = state->connector;
>> +	struct drm_display_info *info = &connector->display_info;
>> +	unsigned int supported_fmts = 0;
>> +	struct device_node *ep;
>> +	int j;
>> +
>> +	/*
>> +	 * Use the connector index as an approximation of the
>> +	 * endpoint node index. We know it's true for our case
>> +	 * depending on the driver implementation.
>> +	 */
>> +	ep = of_graph_get_endpoint_by_regs(connector->dev->dev->of_node, 0,
>> +					   connector->index);
>> +
> 
> Hm, this sounds a bit fragile. Can't we have a reference to the of_node
> attached to the connector? Or maybe we can parse this earlier and set a
> constraint on the accepted modes.
> 
>> +	if (ep) {
>> +		int bus_fmt = drm_of_media_bus_fmt(ep);
> 
> Hm, you're extracting this piece of information from the DT every time
> an atomic modeset is done. I'd really prefer to have this done once at

Yes, not happy about it either. I looked for other sensible places too
hook the info at probe time, but this was just the simplest. I'll take
another look...

> probe time. Since this property is attached to the connector, maybe we
> should overwrite the info->bus_formats[] array or mark some of its
> entries as invalid.

I find it very wrong to mix the connector format with what you want to
output. In my mind it's a broken assumption that they are related. It is
only correct for trivial cases. Also note my comment about the connector
index and the endpoint index, they are only coincidentally the same
based on our implementation. If the driver has more than one port or
initializes endpoints out of order for some reason, this is no longer
true.

I think it would be better to store this info somewhere near the encoder,
since that is what I find closest to what I'm trying to change.

As I said, I'll take another look and see if I can hook this in at some
other place.

>> +
>> +		of_node_put(ep);
>> +
>> +		if (bus_fmt < 0)
>> +			return bus_fmt;
>> +
>> +		switch (bus_fmt) {
>> +		case 0:
>> +			break;
>> +		case MEDIA_BUS_FMT_RGB444_1X12:
>> +			return ATMEL_HLCDC_RGB444_OUTPUT;
>> +		case MEDIA_BUS_FMT_RGB565_1X16:
>> +			return ATMEL_HLCDC_RGB565_OUTPUT;
>> +		case MEDIA_BUS_FMT_RGB666_1X18:
>> +			return ATMEL_HLCDC_RGB666_OUTPUT;
>> +		case MEDIA_BUS_FMT_RGB888_1X24:
>> +			return ATMEL_HLCDC_RGB888_OUTPUT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	for (j = 0; j < info->num_bus_formats; j++) {
>> +		switch (info->bus_formats[j]) {
>> +		case MEDIA_BUS_FMT_RGB444_1X12:
>> +			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
>> +			break;
>> +		case MEDIA_BUS_FMT_RGB565_1X16:
>> +			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
>> +			break;
>> +		case MEDIA_BUS_FMT_RGB666_1X18:
>> +			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
>> +			break;
>> +		case MEDIA_BUS_FMT_RGB888_1X24:
>> +			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
>> +	return supported_fmts;
>> +}
>> +
>>  static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>>  {
>>  	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
>> @@ -238,31 +302,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>>  	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
>>  
>>  	for_each_new_connector_in_state(state->state, connector, cstate, i) {
>> -		struct drm_display_info *info = &connector->display_info;
>>  		unsigned int supported_fmts = 0;
>> -		int j;
>>  
>>  		if (!cstate->crtc)
>>  			continue;
>>  
>> -		for (j = 0; j < info->num_bus_formats; j++) {
>> -			switch (info->bus_formats[j]) {
>> -			case MEDIA_BUS_FMT_RGB444_1X12:
>> -				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
>> -				break;
>> -			case MEDIA_BUS_FMT_RGB565_1X16:
>> -				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
>> -				break;
>> -			case MEDIA_BUS_FMT_RGB666_1X18:
>> -				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
>> -				break;
>> -			case MEDIA_BUS_FMT_RGB888_1X24:
>> -				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
>> -				break;
>> -			default:
>> -				break;
>> -			}
>> -		}
>> +		supported_fmts = atmel_hlcdc_connector_output_mode(cstate);
>>  
>>  		if (crtc->dc->desc->conflicting_output_formats)
>>  			output_fmts &= supported_fmts;
> 
