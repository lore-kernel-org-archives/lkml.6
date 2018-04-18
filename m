Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeDRIJW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:09:22 -0400
Received: from mail-ve1eur01on0102.outbound.protection.outlook.com ([104.47.1.102]:45630
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752597AbeDRIJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:09:18 -0400
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=axentia.se;
Subject: Re: [PATCH v2 6/6] drm/atmel-hlcdc: fix broken release date
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
 <20180417131052.16336-7-peda@axentia.se> <20180418094428.6db785dc@bbrezillon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <3de958e5-c63c-6935-d577-1be626661601@axentia.se>
Date: Wed, 18 Apr 2018 10:09:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418094428.6db785dc@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5P194CA0007.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::17) To AM4PR0202MB2771.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;3:m2/qtgDJCAScYq+PDplxegVCPsU0ibzIQrOTooljjKKUJC70GMLPVjF7y8DErnSBu5s0fWcFU8cbA8BP85x+cReT0jbfsC9vTqfA3h7XmYT31n19+ryPnjOvSyrYTDfOYf8ltQ3w8Su5PuWkDBOjVqybxyHyGVsq43mB+dJHdr1+X2TSsnYGZ47ixVTUYRI4jKv6IgBo18IfmcjwPl//qhe4qJ3TyubiIwXmfdqvPz0xg75ATjh95s4yj5Q9TZqX;25:rc5cIB/FdIer6tC49hxXN7cPu079ijwO3KvImaJjGiegMv0q8iCdcaUmOkW9kdzY4Rkw7MfECkx6j48KQSLjx5gEHaj1G/8QESq864iuEV+O7CuJxVQLFcKLi8XF2vU4iuisxaFb5z3IZdrp7w4MVCKNXtFRJJ01j+aqC0o+4v1jOjUZW7CX45p0h0qBNs/J57gIPHxjI3HIayB7yK/UIGjtHGS7S2luwvwLOYoA3ew4nMlfyW0DIstejWlzp7dB35k4JnWsf369UZQTs2hiZimFdI0HgkdZACowA7DjMi33f7GO3SfjG7SWWS6Hv3N9qdHGx95Gk3LCYEWLTBAwOA==;31:u9febBdveS0q94obImOIp1K6682qVSN2/8c4b3bR1pofSogVg+FX42HrrGKugVLbaohgWpO4sFpUckEMZoRdCYHgwF3l4tdT7hCqhczxo0ms6giSHgJUsCi7WpUWHCXY7qYeziakVpvkvufTFWIr6cE4JGzdmewWIEasEJwtIy+dcr9ganM5SMoTWfpZbnzBpcayyB9guk4gN6fD7sreDgekONj4WjW3NOm/aduRsH8=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2771:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27711823A9EE25F56584593DBCB60@AM4PR0202MB2771.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501368)(52105095)(10201501046)(3002001)(6041310)(20161123562045)(20161123560045)(2016111802025)(20161123558120)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2771;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;4:ftk2PeuT8/YvW6gA1OWnjvc3swK8i4u4w2VvzTVw3nxRV1ig+Kt7Hf0Qm4J7p4RkEIYpxMDe54xAK4vH/5NQmijzNRrscMMnI8hEutvCOdbSIh6eSIMpsKYhFC9CT3OyRQnOJfTk5jqD2UhT7B/xJZ82AD+g7SRv6U9BkdlXhUlGiXOlPmnwNkIjWJPv7WYdb6iFCfK4UxhuKam0cI2vyYsPDabSC1I3eGcwuMgioAHTBlaPFK2E+P8D784FrGV6+29QkHeJH9ksnT7vWPl5asABH9iBmI3wbBgY+ffmvjwsHsQ+za+vDr0E7H20WmWd
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(346002)(376002)(39830400003)(396003)(366004)(377424004)(66066001)(26005)(186003)(16526019)(77096007)(65826007)(476003)(2616005)(956004)(11346002)(446003)(7416002)(36756003)(47776003)(2906002)(6916009)(6666003)(305945005)(53546011)(8936002)(76176011)(31696002)(16576012)(59450400001)(58126008)(54906003)(386003)(52146003)(25786009)(2486003)(74482002)(117156002)(8676002)(478600001)(316002)(6116002)(23676004)(3260700006)(81166006)(31686004)(36916002)(4326008)(6486002)(50466002)(6246003)(5660300001)(53936002)(230700001)(86362001)(3846002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2771;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzE7MjM6TWV4cHg1ZGlxNUtJbURCdWE3am9MaVd3?=
 =?utf-8?B?aG4ybzhLTFQ2Rk9ROG9HT21Wa0x4TmlUaTErSldaUDB4SnArVkMvVmFSMzRk?=
 =?utf-8?B?R1dYT25QQkM1UFNWMmxaOE1BWHEzTzZMeGJWbFZTbmdYTFNZT0ZPSy9QL3dq?=
 =?utf-8?B?Z2VZVm4ydVIxbDN1ZEgxWVhBYmdNd2hlU0k0SkZWTkEwRkdLY3ZhNjQ2alNr?=
 =?utf-8?B?VE5jU2tqa28zTTQ1cTRpT1VSRXhoSXFhMlB5YzJSblVMZmMvVVNUQWl0OE9w?=
 =?utf-8?B?dkFZSFBNbEZKLzBzZHhsaDhidlUzSGtNVC9GTTdXNm96YWJHOFNVUFpGeGhC?=
 =?utf-8?B?aTd3azQ0Ym5ZZDZja2RvalczQTRTWmVhSisrSXBnTk1VVjZtbEdTa2VxMmlL?=
 =?utf-8?B?WUhOY044eWdQUXVEMHVyNDNaVGxGMTBMcmFaUGE0STRQbXQ2Y21KbVVNVDlK?=
 =?utf-8?B?c0dCMHhPWVpCWkFUVTZKNHgxSXVDbDFyZlE1RHZIUFZISnRzSGhrSEc1R1ps?=
 =?utf-8?B?RXh5S2kvQW1kdmFJVjNsNWk2QkNxbzM2SStKUndHbUZzcmFXRVoxZGlBK1NT?=
 =?utf-8?B?elp3d1d3UjBtRlF5VWM3ZVU4TTVDZnNHNFVMUW5BSUpYSUdyMk5NNmRXTW5w?=
 =?utf-8?B?MWJZbnBhTlpvVHdhZithWWZzbithK3h3WGM4Qk9FREozSzRBQ1FXTmNiMHZ3?=
 =?utf-8?B?TEpaS1poamtOVG5xUTlJN21uS1BzZmtNUHowdjdCb3hKd0g5NWcxN1ZIK0Ez?=
 =?utf-8?B?Y2ErdEtXWVRzVzV2eXhpakNLN2s4K0FkTnRoL0VmV1JjTURGZmZlL3B5b2dB?=
 =?utf-8?B?ajRXSG4xNDJiRi9BNXVwdENPM2pVMDJ2Tm9lcmlkYm1SOW84ditZZE41YnlX?=
 =?utf-8?B?THZaZDFjQ2N4SmlmcXJjajJYUUtQb1Z5SlZUYW5hZ1pUWHc5OUIvV2hrN1RE?=
 =?utf-8?B?NWpYN1BVWUt3ZlE2OFZQMXQvZ2NMaEUwKzVkdHpFTkExV05xL1Y2WEFxcitW?=
 =?utf-8?B?WS9nandTT1hDZzdZaE82ZXdyY0pxcTNhMUJ1bUp4SEdvVEZzZFVjcVBsNVRo?=
 =?utf-8?B?RXJGbU9GRjFrK1VYbUhiN0ljaitKam8wN1VSTXlxVmFTUm1zZ3ViYWpTZDRE?=
 =?utf-8?B?REdsaS9idmFPR1BsK3Uzd1dYeDZqM3FNL3R3K3JidTI5VjNCNnAwcWprV0ZQ?=
 =?utf-8?B?ZitTRFZTdzNIdUowbHpQZHZvUDBVbW1ENlgzMzJjNGZrd3NCb05oTG9tcEI1?=
 =?utf-8?B?M0NCVGNCUkRBcWQ2U0FmbGgzSlRURVhwd2J3WXhIR0hQQkMzK056R3Y1WVdn?=
 =?utf-8?B?Niswcmt0Q1RvMk5vS0hCMFRSVVJDT2FCZDQ5QWZmTjJwMDM2Njl5TkJGR0t5?=
 =?utf-8?B?OE80Vks2N0JiQU1JRkZKQWp0Q1NXK2xNU2dRTXE0MzV3SEJIeWdvME1SU28w?=
 =?utf-8?B?ZWsxOE9ZcVRhSkNOYzZDT09pVmYxcVdhUEllZUhnWTFzQ29jU0FTUDdXNmlP?=
 =?utf-8?B?L1lRb1dXTmVjUklXVW5LbkxqRndObEdWWU53WWExNDc4SmhPYTJwN1VSOERa?=
 =?utf-8?B?cHFVREsrdnZKc09hcFVRWFM3cUw1UzQ0Wk9nc09CRG5tWk1jcURMQ3VYSlZz?=
 =?utf-8?B?dTRkOGVDeW5xNHUxMC9iWnY1LzMxZUl2WFBnTnhvbGZVMElmTkh0OEk0bk9n?=
 =?utf-8?B?UmtUYXRvMmlDTUt1SkRwaDFPczRHOWtzS0lIT3BnM2l3SFVQamZMUDloanRu?=
 =?utf-8?B?UVFPY29UNHcxM3FQOWlYb1JBTWx5RjBHai9hRjZsNnhWVjgyc2NLZjQ0Ynk1?=
 =?utf-8?Q?TsmlBn9wX8Vx7lM?=
X-Microsoft-Antispam-Message-Info: lWH0mnwObOnqWBDNoqRK7JErn32eCOGYLZ447BwOjq+EjOaDtDn08vcz4VhUCyU7qZSyvmo/ka3fzGJo0xt2dWGwQKn067t8RTBIXyrLDh+4IvolZ0WTLDG99E1yCOJJiZ6Ka7puyTGm8rov3ZF+DUZCStrtYZLNnfrsy0a5SOhzT2MYv/hgZBI3PAhIExBn
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;6:OAibLxNDJoPWd9alfkiU6YdZpCho6jNIP7FLW666u2H/srgf+QwlqQjkhEmenuxSCAkIVcBjTGIW0OEMXkvIKn7t/xjxVZNfWjoZhggiUq/vbvNpKD3q2amE0AU3Z20DZUKFLU+gugD8LbLoW+3qVT+QM62qC/FjHuNPTOYBPC0ZItaArFWyZLvLp7GsgwOyJUKV8329poZdjUuFeGD8XxpiBxp2Q9gszslt1d2zm5i++9sQeG2QIFnxxqJrp1mB++SYGnAyiMlIerN5lKMEO+0GdoYDSwOEI7IRcqU1xg2xyaMflVra0vbt8nYyyJoH1bADynV71PI4ptCABOl3+87aUL2S2bVogWP3AmwhLpIATVqkdTsyscFe4Hv9pgpIiKNvLLXadHMUCU3zTK+hPyUjlPaAjfzaxiiYvpNJdbOpATLvTWodBuFS9eyPejzjnLkWh6mb47lpR49Gq0ezHw==;5:kfZ7s0YAy0VuRRxSoi9eKKf38BLy0809GVJPiyECjMhxpoWOn/sayeHy18s3gynns3V3T3qKGMOozB+uwt5KSnJHIdc06sD3P7AsJ/zlGKibVr92WIKFAnqoFfERAyWJDU262mNSl1dsdi+Y+UDWkT2md6uo5PPJAzOwTpzthOI=;24:dnEvkraxAd3n67g/Kr1VT8oxhpk3VV/3ehAWPRzm/6y928z3EjDlbFHtH1La45cwAFYJhVOB790+/lRNSCpbfO64ex5zn9CqWYZWP7XKEO0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;7:IR93jmdOUbip4kT2O00HXIyFJfqH5u9SGqH0MlGBnX/PTCjcUKliQJqfWFDUgBayU0H03TuJwiupRw20SWFq01UGgNPDp9NK7DpDesvotGqEkPHubBjZ0lElf9iHk2U9G/rPe9wxyTlEdRpmQXIuafQoLE34lNCbqcQLPFAOzk1udXhDa1QZg+lJV9CTDVuQMiHmeCprNieKDXg39VfydhmYfVCdf1XrfCNKZz7ukkTgVNSRxcn62xtEqqx7rYpZ
X-MS-Office365-Filtering-Correlation-Id: 9e83b676-5d50-428f-733c-08d5a503adb4
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 08:09:15.5478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e83b676-5d50-428f-733c-08d5a503adb4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2771
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-18 09:44, Boris Brezillon wrote:
> On Tue, 17 Apr 2018 15:10:52 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> Bump the minor version while at it.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> index 8523c40fac94..aa48f287b5ca 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> @@ -763,9 +763,9 @@ static struct drm_driver atmel_hlcdc_dc_driver = {
>>  	.fops = &fops,
>>  	.name = "atmel-hlcdc",
>>  	.desc = "Atmel HLCD Controller DRM",
>> -	.date = "20141504",
> 
> I guess I used YYYYDDMM format :-).
> 
>> +	.date = "20180409",
>>  	.major = 1,
>> -	.minor = 0,
>> +	.minor = 1,
> 
> Don't know what the strategy is regarding date and minor version
> updates. I never had to update that before, so I guess it's not
> important to userspace anyway.

I have no clue what strategy should be employed. I assume it's
for easier communication when features are backported into stable
or distro kernels and users wonder what to expect or for easier
triage of bug reports or something?? Anyway, I don't really care,
the date just looked really odd. So feel free to only patch the
.date to 20140415 or whatever. I'll drop this patch.

Cheers,
Peter

>>  };
>>  
>>  static int atmel_hlcdc_dc_drm_init(struct platform_device *pdev)
> 
