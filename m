Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754776AbeDTM4B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:56:01 -0400
Received: from mail-eopbgr40111.outbound.protection.outlook.com ([40.107.4.111]:47892
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754591AbeDTMz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:55:59 -0400
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=axentia.se;
Subject: Re: [PATCH v3 0/7] Add tda998x (HDMI) support to atmel-hlcdc
To: jacopo mondi <jacopo@jmondi.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180419162751.25223-1-peda@axentia.se>
 <20180420085235.GI4235@w540> <6354350.l8DgUyNhLT@avalon>
 <7f709cea-e1f4-2204-7320-5a1075d721d1@axentia.se>
 <20180420113859.GL4235@w540>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <840625e9-42ff-49b7-605a-202b4d980beb@axentia.se>
Date: Fri, 20 Apr 2018 14:55:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420113859.GL4235@w540>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P189CA0018.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::31)
 To VI1PR0202MB2782.eurprd02.prod.outlook.com (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:0D3TmJdatg3PHQ76cYkjrupdP8G5+KzM6afvrgKUdSUfrcxrbo3OdHEtWdNf4fpaAB97f9ik1QOSXKe5V5FAWC9pRLL62umDe6MLFM8LmPOmXBSp6pTSiq9UtyCd6TmnsSRwrIdVIRmAJsgS994f7BeE/FtQD74BlqegTgcs+iBFk4FVl2sf+DoFOZobDwvTQ4KLWV1bsiEgpi5JiES/yGHqY1+tSKXt6FnajKtvVxJ4+Ru3WlrWPnoq2nEYp7tN;25:tCW9PIi2uZo7j9lFhAQ2x5oOTmXzif76KqgjORSKioZVIYnAepRN5pv7yMChCJveTYDr5sJHGROwetI+8wNNygSwWwj4VBRnZn52Yvy7/0hk2zQzAnShBAujRL6wO9C+Z2oPECaVNLG5SyZMILdZUJkU734marrcCRui05DiM2U/dN5wYzxbnxnrItL+Dk44EJ/FFUqJl6g8GcO3jTNsnaovUsWrYUmelLhA4BbVpqO3sKcqxDAZwlZS1eaA9mJ48A5XaJ8NFDdyLcioekf0yYIC0FrItFBgP8XpLiDfyJlkA7JvzVpztfYazDMInOKEfMKEbwOeyp5FGNa6Vb30/Q==;31:HtWXMvnIAo2a5EnWGrfd4pNND2Pl2oSwjFym7BbSO9yEuu3jAw3qmKKrZqnp4IZkyyXBiLRm3NqLNB/CyMrVskRM3bxMxeTbK5ZATHl/RPqHBA9uroi8E++jb85roaCUxtE3t0ITTsKP4f7a0kOv2gf8071SRBxUUMLDxZdm2nRajpHM9z5RS+BO0aWWwHMm/25dyEoVP4yl2Mga2dZEDLMUaoDOrIrs0Za4nT567E8=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27825E3B4D036D276188F4BBBCB40@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501394)(52105095)(6041310)(2016111802025)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:Cxb68b1pxVDqTBh0dHXz0IkUvckhrjrum9Ebbs0iURrwKtsKTXkstbuwXYQoNlsK7aW1yVTOQJN9xYosV1UG4jX14PnMlSTQIdGqK6HHbAUSGVOgIWrVmgixgxwE1wC+crI7FcJo/SY0htW88m4tkxCAwJTQVkpRg9LcdC2VSbN/h/GIoLpHLlLFB+415XmkK3YHbhGszpp8gJ91HmmuN1XrP3/q1XYcSxvWCy1aElORBBXcF75Ltpx04aFN7OC6s33NihN/s5l8NMMeu2Rf+g==
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(39380400002)(51444003)(377424004)(230700001)(3846002)(54906003)(229853002)(476003)(47776003)(8676002)(50466002)(8936002)(81166006)(66066001)(26005)(305945005)(65826007)(4326008)(74482002)(53936002)(6246003)(7416002)(16526019)(2906002)(478600001)(31686004)(5660300001)(11346002)(2616005)(956004)(446003)(6486002)(53546011)(6116002)(7736002)(31696002)(6916009)(77096007)(16576012)(93886005)(36756003)(117156002)(186003)(86362001)(316002)(36916002)(52116002)(3260700006)(25786009)(2486003)(59450400001)(52146003)(23676004)(76176011)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODI7MjM6L2I5VUNqYlVBN2dOQ3hnbC9rRGtza1ZH?=
 =?utf-8?B?TitTNkR4UWdGcUtQTFh0cG5pMTh1U215OFJub0czYTJzTmVVczV2cVd4TldP?=
 =?utf-8?B?V1NvVmdDTDdla1ZJV0hZdC9NU05CMFJISFhPUkpZTXZobTRKVnFaZEVsa1NT?=
 =?utf-8?B?LzFrVmM0bFVaZXNWV1dlSjJnZ0FTbGlIK3VxZ1BaVncxTVJ2K0dXeFRQWERC?=
 =?utf-8?B?RlRoL3VIejBwaTZwZ3hyeWh0eFpqV2ZHRHFKVWlSVlBvK041SWEwQmJRV1BN?=
 =?utf-8?B?NUpVT0lvbGFHUmkrRVFQdkZyeVpya0F4SlVzN3FBcWo4aFpycEFEaW8wOEdO?=
 =?utf-8?B?NVJFV3BNcjNEVnliVEx5c0pndjBWV3pQLzZISTc5akVrYW9vU2JDaVF3RFh1?=
 =?utf-8?B?K1VFOFFpcEpSSXB6ZUMzRkRQRGZGbEhBV2VTYWIzbXUyS1F2SWNpa0NJS1ZB?=
 =?utf-8?B?M2F4OTBocnY0cUpXajZhTnVXNDU1OEQrT3Ryc1h5S1hRYkh1SitQTUZGSlY0?=
 =?utf-8?B?UFZwUy9saU5OVUpueE1sNG9ZNDJGVFNMT1ZVenR0ZE42SmpvL1NjQm1hVVgr?=
 =?utf-8?B?NW42Q2FsQ2pNaUFrNUE0ZXdqdnJZanE3ZEh6eE45K0xOTll5R3NQb2grcDc1?=
 =?utf-8?B?RGJKWTVzYVVoSFg0TllSU2RxVUNIQzNlcjkzWEZoTllnMVYzazVTWVBuQ09r?=
 =?utf-8?B?ZHBHRmZYUGU4aTNtNEYzTnkzbERXQlVjd0tCVysrZkMwTFA1R25tb3c5TkJK?=
 =?utf-8?B?cU5XMmNxOUZNRTNxeWlzZnV4Mm9hNmJrOWp6S1FtOUlreGVuWnRQOC9WY0s0?=
 =?utf-8?B?Z2EwdWJRWDU4eExzc1FhQnlaOUlpRzZWNHUrWis1MlRXWklpSE0vdnZOUWkv?=
 =?utf-8?B?bFhOYWt1aWF1RUNvcEFPNjFHcWZWTzR2dlV2M0xRYlF0MWpxTWxlcWZWSG5V?=
 =?utf-8?B?Z0V1WG5kaEJ1ZmJraFdwS2RHa25HbnVTV2dWWmI3MGNPa0dGYjc0aElRaWFD?=
 =?utf-8?B?RU81bkZZZGV4TWk1WDFmMXBkTkxPS3oxdk84N0pVendDMS9PaEZ4RmUrOEND?=
 =?utf-8?B?WEhHcVNpd29VaG5SM2dsK2ZlMGV1cVY1cjVJSkNYamlSUllPV01wa3dDS1JD?=
 =?utf-8?B?ZndwTzl0WHZvSjgwNVNwTFhTbWEzZk11aktabnV2bVZyU2E3MGdscjN2WHdh?=
 =?utf-8?B?UkdzTGlMUk50bHhERDh2czVjd3RmbjE2eDFiaU9MdUhpS1h4a1NUK0xVSVUz?=
 =?utf-8?B?U1RHaU8zdjkwb2E5NVdFRVppRE94aWNDZkpsU3pya3pyWmwyVDdZZ1creGRz?=
 =?utf-8?B?Z3RsR3NHYTU0MXEvdGYxTUpPT1Q5dGZ1RUQwUkkxaU1HQlBoblJOaDd4clZR?=
 =?utf-8?B?NXg3SW80eG5NOWkvWHhyUVhsQko5OFlCR0svazM0WUNMMFZpVjdZVlFCNi9k?=
 =?utf-8?B?YTlwRnlGaThCZzJTV0ZzMjdaVDJ2Qkd5NUFvQXh2VEwvVUI0TzdHSjRBN25I?=
 =?utf-8?B?VUdFSkhkR09heDJkeGE5M1RWNDJCU3NFRHNPRjFKcldVY2EwQnBPZFdOUmdj?=
 =?utf-8?B?c2FVanUrU1pCYkpEUGlMbXNyTTBKNnRBUGttT0NmeHZJdXRvbENWQlpZbEZS?=
 =?utf-8?B?bmxQdmJvaEFMaEFObmJMYWMyaGl1Vmw4d1lmeVltaW9VanpVNmEzU0ZkM0xo?=
 =?utf-8?B?Y2FnbEJJb0xUVnFmRXBCQjEzY2ZIK1ZZOUozSzh3WklKaVI0TndLclY4L1dX?=
 =?utf-8?B?NGZtbjdoQkQ1ZEQ2ZVJEdXhBbDZOTG1sYXZJK1NKZWNzUXV6U1I2TnBpNDdW?=
 =?utf-8?B?dkE5cG5vSW5kMU9YR0IzYjVSS0xqUzJsTVpIaTVOM0tDSWVZUT09?=
X-Microsoft-Antispam-Message-Info: ngHfHY1r71LZHSu5Ee9DA5jBhL4v8E0y/vOlEDWcM6R6I7ap7XZEephqhW/zxlAs1+Qlm4z7WYUpFsFErHyp+KoxMgM3Om3OlIwM1tY5Svm/HbpaEuiQ9/BoN/AaKjK1Vq3QJRz5EjLb5TxrZvkVdGQCTHo3R96zScXoihGm24EcyppCna5AuZ8S30CdJabX
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:MzfPMgTBI+c96cs/aj4sjsVTqcPhSggva976ZXIyj3KDfnk7vj1Xv7MS+bAWbojB+RH/hP4Gdm0KSQ2oZIWjJKxrN0OcQpiy46lch6YkfI1olld/u82gpAts1pBRCGdqmgzYV6gmm7+zDvAginAI5BeLId6GZ3FjNZqVwNRmZMZ5F6D8vB/VXsfkTx1UOBBJTMN4Cgfo62l84fJi5tQn89q1VLlWZ4TDHOivp5PEzy/Ha/EVySUYFLXajsKgn0NBNAIt4uufSM/aKxf4zPIbDYL9FYM+9gE8KuK9c8V/v+3ylrSMugPnn4oBZRYicYCk2kybMel2MFM4ZEmUaJo3GO1khtMF4uLz4sDYgvtbuuYBhji4Ng4EUDkVn0378icN5nmZR1j359BRyjZKlJZkSGrh0TJ3VkptDf/RXVfARP6fSNe64EX8IT2rr7J+ZwbBRFR8zZKwai/VZM/Z94ikCA==;5:KiXmv+9ELo3E7SEGwUMWUKqA0BTlW381BTCsj/z8feWwDpYSeMInl9PrwyKvEYpeRfGhpvZr54955RSCz7gnQ+Fglr29WRwPk3BL4wMwSmGIDd3Xp8c8q+zSvyneEeuk3T/unYY4X0jWypZF6gnq2MYHgvZAYsVZbSztzgmOhX4=;24:tUYZ+0Mv6vfwJn1JXw+8zAXHCCLdIwflGBUHZ4Hl+xSnQTpjgs3LbMawB2tq3nlS9Y4JUjFKkLDKHBEM8CGivmrDGuDBl9/g4QqvyH8EHb0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:kSn5rSOFLGNTKyY/FkDyGKKZE6CFh6TUe7FcdxXqersDT+QQC7dVANo/Hyot1sPU1ZnwPf4SrYlNkadYH0MPfhaYUYI/nQfVt/h03OPdBH0oOeqyAQnO7aBs0iuIc3EXggxIDcKpjJI+kI9eYCWKiWce6Ugjtr+XNjZlI0kZRYw6XeV3+aQix4SRTVZMBCYM+8nUlMkSz6A4E2IsJTJ3t+SxdFBmfgiaj+s4QuN+cR+Gj6C7QggwOR+gHze44tp4
X-MS-Office365-Filtering-Correlation-Id: 5a4b065d-50c2-4526-b205-08d5a6be0dd9
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 12:55:53.6660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4b065d-50c2-4526-b205-08d5a6be0dd9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-20 13:38, jacopo mondi wrote:
> Hi Peter,
> 
> On Fri, Apr 20, 2018 at 01:05:21PM +0200, Peter Rosin wrote:
>> On 2018-04-20 12:18, Laurent Pinchart wrote:
>>> Hello,
>>>
>>> On Friday, 20 April 2018 11:52:35 EEST jacopo mondi wrote:
>>>> Hi Peter,
>>>>     I've been a bit a pain in the arse for you recently, but please
>>>> bear with me a bit more, and sorry for jumping late on the band wagon.
>>>>
>>>> On Thu, Apr 19, 2018 at 06:27:44PM +0200, Peter Rosin wrote:
>>>>> Hi!
>>>>>
>>>>> I naively thought that since there was support for both nxp,tda19988 (in
>>>>> the tda998x driver) and the atmel-hlcdc, things would be a smooth ride.
>>>>> But it wasn't, so I started looking around and realized I had to fix
>>>>> things.
>>>>>
>>>>> In v1 and v2 I fixed things by making the atmel-hlcdc driver a master
>>>>> component, but now in v3 I fix things by making the tda998x driver
>>>>> a bridge instead. This was after a suggestion from Boris Brezillion
>>
>> That should be Brezillon, sorry for being sloppy with the spelling.
>>
>>>>> (the atmel-hlcdc maintainer), so there was some risk of bias ... but
>>>>> after comparing what was needed, I too find the bridge approach better.
>>>>>
>>>>> In addition to the above, our PCB interface between the SAMA5D3 and the
>>>>> HDMI encoder is only using 16 bits, and this has to be described
>>>>> somewhere, or the atmel-hlcdc driver have no chance of selecting the
>>>>> correct output mode. Since I have similar problems with a ds90c185 lvds
>>>>> encoder I added patches to override the atmel-hlcdc output format via
>>>>> DT properties compatible with the media video-interface binding and
>>>>> things start to play together.
>>>>>
>>>>> Since this series superseeds the bridge series [1], I have included the
>>>>> leftover bindings patch for the ti,ds90c185 here.
>>>>
>>>> I feel like this series would look better if it would make use of the
>>>> proposed bridge media bus format support I have recently sent out [1]
>>>> (and which was not there when you first sent v1).
>>>>
>>>> I understand your fundamental problem here is that the bus format
>>>> that should be reported by your bridge is different from the ones
>>>> actually supported by the TDA19988 chip, as the wirings ground some
>>>> of the input pins.
>>>>
>>>> Although this is defintely something that could be described in the
>>>> bridge's own OF node with the 'bus_width' property, and what I would do,
>>>> now that you have made a bridge out from the tda19988 driver, is:
>>>>
>>>> 1) Set the bridge accepted input bus_format parsing its pin
>>>> configuration, or default it if that's not implemented yet.
>>>> This will likely be rgb888. You can do that using the trivial
>>>> support for bridge input image formats implemented by my series.
>>>> 2) Specify in the bridge endpoint a 'bus_width' of <16>
>>>> 3) In your atmel-hlcd get both the image format of the bridge (rgb888)
>>>> and parse the remote endpoint property 'bus_width' and get the <16>
>>>> value back.
>>>
>>> Parsing properties of remote nodes should be avoided as much as possible, as
>>> they need to be interpreted in the context of the DT bindings related to the
>>> compatible string applicable to that node. I'd rather have the bus_width
>>> property in the local endpoint node.
>>
>> In addition to that, my view of this binding
>>
>> 	endpoint {
>> 		bus-type = <0>;
> 
> bus-type is used by v4l2_fwnode helpers to decide which type of bus
> they're dealing with iirc. Here it seems to me it has no added
> value, also because in your bindings description "it shall be 0" and
> it is not parsed anywhere in you code, but no big deal....

bus-type is indeed parsed and verified to be zero which means auto-detect
according to the video-interfaces binding. An auto-detect bus-type with
a given bus-width means a parallel interface IIUC.

>From patch 3/7:

	if (of_property_read_u32(node, "bus-type", &bus_type))
		return 0;
	if (bus_type != 0)
		return -EINVAL;


>> 		bus-widht = <16>;
>> 	};
>>
>> is that it always means rgb565. See further below.
>>
>>>> 4) Set the correct format in the atmel hlcd driver to accommodate a
>>>> bridge that wants rgb888 on a 16 bit wide bus (that would be rgb565,
>>>> or are there other possible combinations I am missing?)
>>>>
>>>> I would consider this better mostly because in this series you are
>>>> creating a semantic for the whole DRM subsystem on the 'bus_width'
>>>> property, where numerical values as '12', '16' etc are arbitrary tied
>>>> to the selection of a media bus format. At least you should use a
>>>> common set of defines [1] between the device tree and the driver,
>>>> but this looks anyway fragile imho.
>>>
>>> This I agree with though. Combining the remote bus format with the local bus
>>> width should fix the problem without having to parse remote properties.
>>
>> My thinking was that the binding with bus-type = <0> and bus-width = <bpp>
>> would mean a parallel bus (type 0 means auto-detect and with a bus-width that
>> auto-detect means a parallel bus) and the most natural/common interpretation
>> of that bus-width. For bus widths of 12, 16, 18, 24, 30 etc I think that
>> would be rgb444, rgb565, rgb666, rgb888, rgb101010 (or, I'm first so I get
>> to define the default). If you have some other interpretation of a bus with
>> that width, you'd need to extend the video-interface binding with some way
>> of saying what you need, perhaps using some kind of data mapping or something
>> to say e.g. bgr666. And you'd need some kind of indicator if you have YUV
>> signals instead of RGB, and LVDS isn't a completely parallel bus, so you'd
>> need something for that. Etc.
> 
> The fundamental issue here is that you're tying the bus with to an
> image format. Why <16> can't be, say, MEDIA_BUS_FMT_YVYU8_1X16? it
> spans to 16 bits, doesn't it? And I'm sorry but the 'I'm first so I
> get to define defaults' argument doesn't apply here.

I never said that <16> could not be something YUV. I said that <16> without
any further information is RGB. But you are right, the fundamental issue
is that I want to specify the full format in the endpoint node, while you
do not for some reason I don't understand. And maybe saying that "<16>
without more info is RGB" is too presumptuous, but then I think that the
right fix is adding something clearly indicating RGB is the way to go, so
that there is a way for endpoints to specify RGB565 (or whatever is needed).

> So, it is my opinion you need to expose an image format somewhere. And
> it is my opinion again, which can be very wrong ofc, that this place
> is the bridge driver.

I don't see why the input side is better than the output side when it
comes to specifying these details? The input side is as likely to have
different options as the output side.

> You need to adjust the output to accommodate wirings? You can use the
> bus_width on the hlcd side, as Laurent suggested, but the bus width
> does not tie to any image format at all, even more if you're making
> that decision in a drm-wide function.
> 
>>
>> Because the word from Rob was that there should be one common binding that
>> describes video interfaces. I started an implementation that interprets that
>> binding in a drm context in
>> [PATCH 3/7] drm: of: introduce drm_of_media_bus_fmt
> 
> As usual, one should try to reuse as much as possible of the existing
> bindings. That's a totally different thing compared to assign to a bus
> width property an associated image format for the whole DRM subsystem
> 
> ot: those properties should be moved outside of
> media/video_interfaces.txt sooner or later, to a more generic place...
> 
>>
>> With that view, any input format specification of the bridge is not helpful
>> for me since what the bridge specifies (without help) is going to be wrong
> 
> No it's not useless. I can have an encoder that can provide both YUV
> and RGB formats. If your bridge accepts RGB I want to know that, and
> the bus_width is unrelated imho.

I didn't say useless *period*, I said not helpful *for me*. What I mean is
that since I have an encoder that can only output RGB formats, asking the
bridge if it expects RGB is rather useless. It adds nothing whatsoever.

Cheers,
Peter

>> anyway. End result, I need to specify the format manually on either the
>> bridge or the atmel-hlcdc side, and I happen to think that the correct side
>> is with the atmel-hlcdc, because that is where my issue originates. In short,
>> the "drm: bridge: Add support for static image formats" series is unrelated
>> as far as I can tell.
> 
> I may be biased on this, so I let other to judge and provide more
> suggestions.
> 
> Thanks
>    j
> 
