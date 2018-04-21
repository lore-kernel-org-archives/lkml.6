Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeDUWNi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 18:13:38 -0400
Received: from mail-he1eur01on0114.outbound.protection.outlook.com ([104.47.0.114]:14848
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753230AbeDUWNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 18:13:35 -0400
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=axentia.se;
Subject: Re: [PATCH v3 4/7] drm/atmel-hlcdc: support bus-width (12/16/18/24)
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
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180419162751.25223-1-peda@axentia.se>
 <20180419162751.25223-5-peda@axentia.se> <20180421181921.75c41917@bbrezillon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <894b0408-038f-6bd2-2130-d46de332e215@axentia.se>
Date: Sun, 22 Apr 2018 00:13:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180421181921.75c41917@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::25)
 To VI1PR0202MB2781.eurprd02.prod.outlook.com (2603:10a6:800:da::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;3:UKYvKvNsUu0yNECSirIfrqhf6cncpPSke0YprBt3gM0STdiMuogQkQzS1c0FtjLpp0Hn4/xe90v+Uf0tQwEEVT9df0d7WQJTc4LuBmnlL8f03iZsSPodtfmSUP2VU9/rY7kHmsXg+5YU/9voVE46zID44uaZhj3twpDWS8+Nk8e+JLE9BU6TyrD8zxg11kmG/kv9H3V9dOn+u+khcsbf5wjGP0lpoyDFBAKHuvsnBOlHnAlazPRxT6KZa8QRbmoC;25:sHd6rz0fnygreUtQCRlbi1qMXM+0OYHStYLQHqmw4qbwFztqqAjWaCOGoUW+MBg7sBHu/iuFh7kdoZVxlan2r2qhGf8fDL/NntvtdUT2veifF+7RqvnMWxTk/1zOPwAnTF8ybsmUdPzqLwCqmW1dRRysrLkeqrOu1PAWDh9D9aqxxVgaBFjuGjo5GsASG/EMJxtgUVT+zRxxsh0Zc56YmqQZQWEbWblLHj1z75f+JdocZUxIQNAa75c2azrinGlvFvkBsllBKd7Objc4TMumzRutYLzmroixj2DT1K2FnAE9qv0jXqltcyJe4x09v5+BaprFP8R8X7bNHlpDia73sQ==;31:b3AdebTG3ma60NZ2JbkYkLcs6rpc/fY2/Icd0pV9kq2GbJ9Eei++Jc6lxT9r8/QPcHtYCg0py8oZ3F5rfOEzN5kkh0qTH7v6WNneHuJFwMv34Ho+bgnYZGfucUCnl49dkJUQZfI3UccOQB5J2l8CsjI5IFp+q75sVSzdJFReDv4EjobuDYyjnDP6iKcUD2UKZZkUBUBpiI07tZdiHf1Hl74vF9wDduclJ4wWnxOrP7M=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2781:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2781068A5A0D42A20BC6C918BC8B0@VI1PR0202MB2781.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(3002001)(6041310)(20161123564045)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2781;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;4:x3VhUwDNU+Hrsu9cL9tYg9S1aToNFQXA3gCldQi31Bxig6uesjo+YsXwmJa9ltwnAYKKEaGhsz37mOcfCsX2ra0zlk48A0VSsKnJ3KKrgQGQ78MDJARIegCW+7R0z27dQXb2u1QETPMhKR3hDcMs70YvDv7C0Y4o5vyaV25ju4x79UVdri6pJCw0FvwKtX1SDOmJ7l5CQKoX4Xw6CUIacbdutnzSmVt0nZ8D9u8C+zyI2VadZYiqgIxNCLNccPIkiZbNtTMwqD46IgA61SNPxg==
X-Forefront-PRVS: 064903DDDC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(346002)(377424004)(476003)(386003)(6486002)(50466002)(53546011)(186003)(16526019)(31686004)(6116002)(3846002)(4326008)(74482002)(117156002)(305945005)(77096007)(229853002)(47776003)(26005)(230700001)(66066001)(3260700006)(25786009)(8936002)(8676002)(81166006)(7416002)(7736002)(5660300001)(53936002)(6916009)(478600001)(36916002)(6666003)(5890100001)(36756003)(6246003)(76176011)(2616005)(54906003)(11346002)(956004)(52116002)(446003)(316002)(86362001)(2486003)(65826007)(23676004)(52146003)(2906002)(16576012)(31696002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2781;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODE7MjM6WlNVdSthZ0NjSGxVNG0wMmNpVHMxUDJE?=
 =?utf-8?B?WkpLVDZjeGQzTW9yd3NKemZQaC9RMDVUY25sc3NrQWJUeGFDK1IxQ2tZUzJu?=
 =?utf-8?B?eHNhRVIyaUFUano1TUducTdqMUZ4d0pMZjNIOWNYakdvOXQrRGt2QnQ1Tldx?=
 =?utf-8?B?eG9XNFVURGI3Qm4vTEg3M3h1L3BOc0cxTFlGMExQNVljaUdaQzlpZTF2UC9R?=
 =?utf-8?B?VnN1QnVPc09UTmlWOU5nOHAxSWRNYTVkcUhIc21EOHFzZHJEck9yWWZmcURt?=
 =?utf-8?B?cy9DMnAzbGpmVHVHV21sVXFIRkxFeHU5VXhSWEsrYkY2ZkR1c2dFa0tzU1Rk?=
 =?utf-8?B?TS9rbDExSlV4dFB3YXFOV1NDYkxCTTE0NG5td0FhK016ZWQ3ZGNZbitkK0hV?=
 =?utf-8?B?bFB4ZkYzSmZnTGQvNUNEZ3hmVk10MnhJWWpmaG4wOGwzdjNmRXpSZml3L2da?=
 =?utf-8?B?UWt3MnplMW8vVzdBSGpYanJ6Uk5JdmRtc003aTFWQlZ3ZjVFZEpJTlJNNFFE?=
 =?utf-8?B?VXRIdmJ5bUN4elBXSHVLL00xWlhVNGxtYnpEZENnNGZuMmVoV3Z6RHNyaE94?=
 =?utf-8?B?K0lGOWJlLzZ0YTU2Z00vSk5LdWt3ekpWc1FETm5waVREeWk0cEcxUkQxM0wy?=
 =?utf-8?B?MzlrWW1oSXplNmQzREpCVURXek9FdnNEQVFGeFQxOUswQ1dMRVFpWUxMb3dR?=
 =?utf-8?B?Sm0vWGtEQTNYTUEwSXhSSno5MDJKTytEdU9IL3dSNGE0VWtCSjZtSmhubEZs?=
 =?utf-8?B?VDUwQTNHTFBEZFBaRkpaRWNlbSs4THgyN1lERlZ2UlZEVGNxSjZuQkRUbndX?=
 =?utf-8?B?ZFg2SzFWK3lBOUlCNDVUb0U3Um00ck95NmdzbGhYVTl5R0JUNjFsMVViOCsr?=
 =?utf-8?B?QmxmT3NzcDcvMXViTFlBemY2R01RWmN1a08wVDJTdWFBcHU1QXZyaG5VSHRJ?=
 =?utf-8?B?M0JjdnMwWU43ZHlRd0x3cWE4ZjZMUVh2c0VhRGhheHYzMXdTM2kxclhwZUkw?=
 =?utf-8?B?K1BHR3dZSWh5enRIakdNYVJqL2tXMng4UDU4anlzUVpnYTBhUUVXYi9XZTZw?=
 =?utf-8?B?RnpWRDA5cDExZzIvZ1A4enhoTWlObEtmREJ0c2NCNGRtaWMrejFCb1o3V1dU?=
 =?utf-8?B?bmJnL25GT2JXcU04YjVJY2NONHFVZXBpaWVWR2dvTTA4WWhTYSt4VDlDQmho?=
 =?utf-8?B?eUJ5bHUzUVBoc093RC8xK25JU1g4a0J6WTNwSXIvQXRQMHNhQ3dYeGVUbUFs?=
 =?utf-8?B?YWVMTVhTTTFvajdmWThFalg4TVg1Mkd1V0lGZ1dhZ3Z1d1lqV3RXU3o4Qmk5?=
 =?utf-8?B?YXpOMWN0cWpsTm90ek5kYlF2Slk2NmE3Z3Q5a0I0V1FjOWQ0bko2S1pMeWJy?=
 =?utf-8?B?cVpyOW4rMm1mb1pGengvYkJjS2dZSVVta0pFRVo0bjZLQmFVRi8zUCtrY1R2?=
 =?utf-8?B?MSsrVlRhbzJEN2xrZDhBME1IYTZnNGQvMm5mbnJnZ1hZMCt3QzFBL2FPNGkv?=
 =?utf-8?B?eFBjT000aWRMMmhjQUZxV25kK1hsazVBMzVzUStWM0tKWlN1TVByQS9TS2pp?=
 =?utf-8?B?R0IzaDhHeXJIMzRMenB1WFZQaDlYVEd3TDBFYVptQ2lpWnBqSlVyNmF1Yy9G?=
 =?utf-8?B?RXUzMjBVZHROSDVUaVhhYzZTUHdXeWhMcVJ6ZUR4OHNFMDMrYmhkb1BNWVV0?=
 =?utf-8?B?S2p3dGZQY1RhUHlqQjMxUUFXWnNmSGNSQkJlakxmZ2ppN05LTmRwc1lJSDkx?=
 =?utf-8?B?NGc3d01DK0dUY2dmbGZFd0ZQNVB0VWNBYzc3Zng5ODZzZ1NTay9uUmVPK0Rz?=
 =?utf-8?Q?7BJm3NQ0ynETf7T?=
X-Microsoft-Antispam-Message-Info: R0gBjK4vHWXJOiUUW+tn8zhY/YioVdWlK2ghG03laAaoCY1admDDwa3dximOLm8DxozcnOYiFhR6AciaNmnf9pcRMKM7wnHjaOSm7LVLP3BR2rSNLBVhx4Gll3a9eDlsKnSj41nWFjysmOLLWLk6HkF/Zz0dWtMF7PMA9uFKjSi3CbLu5spp5GhSR/MMwOAx
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;6:2SgZZbahSh+5F/AO6suRsb9HHWqe114gflYijNU3niIDgzQXCG8oDWpoi2B6czbBrBARM4GBQTrmZmeKy7ZWBhLP/NGNFR0yUVzzTqN9TdoCH7nuSH1elS/YACnsoGdmUaWBQTakEkuANL0WL8lNSNSCGDPhB7joShr4jBfhFhkWr+MHQzsv9QxxMukGKxMyqftYwPoX8vuuseRqRPwNjj8j7Gxz6ls9WqCrWyGJnlUSnroHhRlBTlSD6ImOo8KtE00MK4Y2RKv2fofE0Ohi+aMixKB6nhjO+zS0CyahAVPpzYESXr6hKdknDMtemaoPOBc2ZXbIFxt78legY4pFF4V90HtFUdN/gq3u85hS3a3yrt1RaEBVEmXTB2E55WEh8YMbxiS9DblUgJXvLt42mxv0+/D60d0fIuV4klo/EnYF7v2PIrTqMxoyZyg6AwL7QZUW39m1fe4bAiLSZKbrew==;5:FNZ8i7JPXjP8rCtdk+2Q1wMN8dVl+EAKSQ/wYwD8XEfX+yo1HYZ4S+ajCSWEmzj2PPeJaYvqDL3MMG5+uN/7+4m1+ETtk79VSmgiTHAwhO/wIAy/MvDLvK9TOMLW6EztLM9fgKBkanNOIFE9LtygeyW9wdzVbIOxEEHA7BFD1LI=;24:1N7Zh3mgy1Rq+t6Xq5VeQ8fDx7ccq/Vm9SfOG6Ke536YxG8j7IjGsUEgTzLshcmXEYc4HVr2Rr418qoKxOBsbyuQqZu4tR44eJnOzp1Fwg4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;7:wjjesuG6KvxkChKf65vZwbE9iKKPObeZKI0feVoSKsD1eI0qByrNGP4MzcPADZHJT+7SQvzHT651o1ESmMdh0ZI4JGJEgzB6GriRInYxzTHMBxTpX9yqjVg1Pg0wPfKS0Pw9soJr/a6xvWn49PPBGiseqx6PjnmkrPB50vpXU4rbGP2WI4JnLZPy4HF9zxOos97yUAarB7uHHOrB2k0dvib9s2z31HCqMwg25WSCJvazW+NBSTahoxKfQA+W89FK
X-MS-Office365-Filtering-Correlation-Id: 06950663-0236-4dd7-9d65-08d5a7d51e05
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2018 22:13:30.0881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06950663-0236-4dd7-9d65-08d5a7d51e05
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2781
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-21 18:19, Boris Brezillon wrote:
> On Thu, 19 Apr 2018 18:27:48 +0200
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
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 71 +++++++++++++++++-------
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  2 +
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 40 ++++++++++++-
>>  3 files changed, 92 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> index d73281095fac..b4e7f5b6f497 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> @@ -226,6 +226,56 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>>  #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
>>  #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
>>  
>> +static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
>> +{
>> +	struct drm_connector *connector = state->connector;
>> +	struct atmel_hlcdc_dc *dc = connector->dev->dev_private;
>> +	struct drm_encoder *encoder;
>> +	struct drm_display_info *info = &connector->display_info;
>> +	unsigned int supported_fmts = 0;
>> +	int j;
>> +
>> +	encoder = state->best_encoder;
>> +	if (!encoder)
>> +		encoder = connector->encoder;
>> +
>> +	switch (dc->bus_fmt[encoder->index]) {
>> +	case 0:
>> +		break;
>> +	case MEDIA_BUS_FMT_RGB444_1X12:
>> +		return ATMEL_HLCDC_RGB444_OUTPUT;
>> +	case MEDIA_BUS_FMT_RGB565_1X16:
>> +		return ATMEL_HLCDC_RGB565_OUTPUT;
>> +	case MEDIA_BUS_FMT_RGB666_1X18:
>> +		return ATMEL_HLCDC_RGB666_OUTPUT;
>> +	case MEDIA_BUS_FMT_RGB888_1X24:
>> +		return ATMEL_HLCDC_RGB888_OUTPUT;
>> +	default:
>> +		return -EINVAL;
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
>> @@ -238,31 +288,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
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
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
>> index ab32d5b268d2..be2d180dd169 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
>> @@ -365,6 +365,7 @@ struct atmel_hlcdc_plane_properties {
>>   * @hlcdc: pointer to the atmel_hlcdc structure provided by the MFD device
>>   * @fbdev: framebuffer device attached to the Display Controller
>>   * @crtc: CRTC provided by the display controller
>> + * @bus_fmt: Array of bus format overrides, per connector.
>>   * @planes: instantiated planes
>>   * @layers: active HLCDC layers
>>   * @wq: display controller workqueue
>> @@ -376,6 +377,7 @@ struct atmel_hlcdc_dc {
>>  	struct dma_pool *dscrpool;
>>  	struct atmel_hlcdc *hlcdc;
>>  	struct drm_crtc *crtc;
>> +	int *bus_fmt;
> 
> Looks like this bus_fmt information should be attached to the
> atmel_hlcdc_rgb_output object, since the property is placed in the
> endpoint representing the DPI encoder output.
> 
> You could then parse the format in atmel_hlcdc_attach_endpoint() and
> provide a helper to retrieve the hardcoded bus-format attached to an
> encoder:
> 
>   int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder);
> 
> and if it returns zero you can fallback to bus formats
> defined in drm_display_info, as you do in this patch.

Good suggestion. However, it appears the atmel_hlcdc_rgb_output object
was removed in 4.13. But I'm bringing it back like this

struct atmel_hlcdc_rgb_output {
	struct drm_encoder encoder;
	int bus_fmt;
};

and adjusting the code to match that. It all looks nice and tidy, methinks.

v4 coming up Monday, if nothing unexpected happens.

Cheers,
Peter
