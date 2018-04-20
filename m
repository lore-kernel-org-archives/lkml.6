Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754627AbeDTLFb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:05:31 -0400
Received: from mail-eopbgr40137.outbound.protection.outlook.com ([40.107.4.137]:56240
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754549AbeDTLF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:05:29 -0400
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=axentia.se;
Subject: Re: [PATCH v3 0/7] Add tda998x (HDMI) support to atmel-hlcdc
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jacopo mondi <jacopo@jmondi.org>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
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
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <7f709cea-e1f4-2204-7320-5a1075d721d1@axentia.se>
Date: Fri, 20 Apr 2018 13:05:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6354350.l8DgUyNhLT@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0345.eurprd05.prod.outlook.com
 (2603:10a6:7:92::40) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:h/HqWMifv3lj4G+xQyipHxFTt6u6RGY9yRuafX10AeF9Y6PeCamVUOI+neVPZP02JlyDX+zs26rV+aeTwYXjSHhs33Xl9C/qhAbjeWukbQqMGYiKhZknJ/QPTTCG50pjPCPgZhDQTiEhzI3H7tSLPQxkixbGH6XDe3YzZZOnAz1o+p8RtPXgrTs58GPobPcyPjvbg/ZfMjchYSoKa8Z0TT5oZVvzUCgHV0EavUs833nX0UmG2Mvm5Jk9D6x7DRqs;25:smEvhyDeLjqyPU5++73A+5bah/lM+S5TApTmWwca/M1J8x1Q+Ajjs5K20vFGGIcbsZC4Mc8iO4TGcBY6ot8HnjRsxO6Q9k09ZAdGGky8n08ou9Yx3tW3urxnhA/zbNvSjxni1vJ9Xq0cM0dQSPzG4yMAXc2uVZ3gwu7jiERyDT0O3H4K+2ukCl+HH3HWAnVAjobz/edEUdd+zBqXceCes2MizK4OB1gUMSmrQ81ds4O/WdY/N+PUTlSKA6ZuCs4wbn+dwAEvMXyQ7B/omrQ9XffI9zoXBPI2F6zJ+5d99KWPH2fbHb6dtH8bnVRFfS3Z07MlHB50v+NgVojrTRdH+Q==;31:Aa1xcwz6Vjwldgtj3QO9BLAvaiz80jOl4s84ZqXiagUp1Hbm+FuW9nd2F9K1jeebTFiBzHFNYDqo5P5ytSr1l03khxoTT51h1jgYisb3rCSPtdFLgQArCeGScIUVD9bMnlB8X1unRu2Z9gYAxjjf5+TYmQ+AyjzFqberrn6K/6xYB64aHfUE5TI9Tg7Dq9lB79viQhnYLeQmrCo/O3ELr8HYy3Lrd/zhrTBT5E+Keeo=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27728473BBE1152D7A51D7BABCB40@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501393)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123558120)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:kNJ4CZXqN8C7Rn6las3aU78jBetxGBpo8a4UdQ00nksdEN7tyaNgGy2CJD6S3oCtKL9YHVzLPe46freNCFfpdnCTH/WAixG/DcNc8vET+jBK9y6mGw5WybXASMJZRcpIyO+F0bEGRS5tvbtwPijBqCjxfRFUZTDTorhC5XnamT696uuiTI9P5KJjaA0X7YocwMXcSu4kSKTXr4jrZ22dez9X4s/uEOAMPirWn6wQRr3vNUwOTnxoOwnYYayBWSijb7yYoKJbjuHlyqrJhOrwEQ==
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(346002)(396003)(377424004)(51444003)(446003)(76176011)(229853002)(54906003)(110136005)(5660300001)(8936002)(53546011)(386003)(50466002)(117156002)(2906002)(3260700006)(53936002)(65826007)(6116002)(6246003)(3846002)(25786009)(77096007)(16526019)(186003)(31696002)(86362001)(305945005)(66066001)(2616005)(7416002)(7736002)(4326008)(36916002)(16576012)(59450400001)(26005)(52146003)(81166006)(23676004)(2486003)(478600001)(11346002)(36756003)(316002)(74482002)(31686004)(52116002)(6486002)(230700001)(8676002)(476003)(47776003)(6666003)(956004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzI7MjM6SUJSMTB2eWhwNlVkV1JhTFFvakIraDJm?=
 =?utf-8?B?Y2NLcHpPK3QwTFZNaU0wd21LK2hPZGVpMTFSVWFRMStiVWp6SWdNTFZlZWNa?=
 =?utf-8?B?N1o2WUEybGwveFcwTk8vQW1DZERGT1FoTzgyU2dZMkZDNkdTL2JFYlR0cWJJ?=
 =?utf-8?B?ekhqWHJUTkcySExLb3o5d1MxUDVGMm0yQUt3UFBLWFpvWWNnY29VdXRqZGlr?=
 =?utf-8?B?cFUwMFVTVFROUkxoUmhDQ3FSMUF5TGNpa3YyajlBZ2sraE1xS1FkWXU4OWRN?=
 =?utf-8?B?M0c3UmRWNnp6MCs0YzlaeS9GeWVxcTRnYmk0SjkrcnhFVkp5U25zYlhEUUdD?=
 =?utf-8?B?ZmE0SDYzTTRMMkFrVm1kLzR6MGc4VGVpVnJSTC9nTngvdGg4NWJuTVV3QzhF?=
 =?utf-8?B?V3daMitOM3FUUndVZEJVSTlQbURmclBBSXYwL01CTmVsb1dBNGVYUWdxa2xv?=
 =?utf-8?B?SzBQYlM2OGp6N3BxZzE1ZC9vRzM4cnozS085U0ZZYVIvbDgxbEQwVzV5ak5M?=
 =?utf-8?B?ZFk4OVZ6MkcrU05ZRUlsbjhZNk02dDJxTGZIREMrSE11VDRxc3NVOE1Od0hi?=
 =?utf-8?B?akZSQ252NjRVamtqdUdNUWdhdG1STE91czl0YXFZcDl3N3p6MWh2WXY0Wmt1?=
 =?utf-8?B?VjIwV0U0VTgwWXNVTkVYczdNdEc2UnZyK1poY29oSzZ2d2FmTmQyblo2T0U3?=
 =?utf-8?B?NVVIODh2bFNoMHNPQy9LYXhKVmZ6UGxzTFhXeU1lck11RDltSllLaGhTeStv?=
 =?utf-8?B?c2RDOGNQYTM1ZTh5dHJIMzR3YkFjUnpDb0xxUmluL3RxemR5UDRWZ3p0RTBr?=
 =?utf-8?B?SGM1OEZ0YjRuY1dYK0NwT3RrUFlKdlBHVjJiK3psWFdMd2N3L2dlSC9RQWxv?=
 =?utf-8?B?Zi9aN0t5Q0R4enYyZDErU2hGdEdEK1JvQmhtZDRDZXNGNXQ4UTFjbVZYaEI5?=
 =?utf-8?B?Rmt6MEhGWEV0cnBSZUI4ejN5T0dOV21XREs0c2p6cm04M0E2QmFaV2JSWVRa?=
 =?utf-8?B?Ukc0dlU0anQwaGNXKzUvajhDWmZNOUJVMnh2SnU4N2RxQlRlWTRYTEhNNEZ0?=
 =?utf-8?B?b0Q4bHovRlY4NGdUa1IyYlBoV2t6VGJaQXpzRlJuaXFUbklabGEydXZMNVJY?=
 =?utf-8?B?WHl3NEZLdVFYN29NN09sUjhWTFJaMjByblNhN2liQUN6WG9jODRacmR4RDV4?=
 =?utf-8?B?MHZCSlZ0SmNPQ0ZEaDlzRHd6VVI4clFrYmxXcjZZRGoyQkhNSDRoSncrNVJK?=
 =?utf-8?B?YWJOVTZwNVpjYWtFbFNBaGpvVmZQV24xTm5mUHJqNW5JNEljUmVaRUtKdWM1?=
 =?utf-8?B?aTA4aXdDSXdOOFM0L0VYeSs4OVFwbG5iRmtSM0xyRmJSVm9RYkRDaDdBdHlj?=
 =?utf-8?B?VzFRU1I3ekQ4L2VYTVp2SU1ncXoxZXZmTHNTRzcvT0dlb0JuZkZPT2ZZaVdz?=
 =?utf-8?B?QVFmdHhaOXFvM2gxcTJPUVZnZ3d1TG1iTHVFdU8xMzNRbG55VDhrWG4wZXhW?=
 =?utf-8?B?WHNrUk9qSmFSUHRrSkw4WnBZajA2TXB2VmhPd3J0ajdhSUhlM09FaVVNcmJZ?=
 =?utf-8?B?ei81TUFJVjVUK0VueEJpb3RiN0laV3d2MEszUEFYbDloWFFENkZ3dHBEUjF2?=
 =?utf-8?B?SEZzRTZoZDdGaGo1SnhLRVNmZlBvak5yVVdUdElLall0Nms3NG5CajVMamk5?=
 =?utf-8?B?ZkRadThjell1Qlh0eHZpU3JrUU9sQWJibDRESkswOFBvbS9ZakxmVXJ2UEVh?=
 =?utf-8?B?NSt4cFA2UFovRUI0T1pEaGJ4bTVBMWFtdlNzSldncUg2TE1BM3A4RXA2ck1n?=
 =?utf-8?B?ME54RVh3WDdWT292SDVzakJOZWVnMjg1azZoT0EyOEtwaXVhdz09?=
X-Microsoft-Antispam-Message-Info: ETGLuVjzTwpwUM3yOnlJwuRjzvczv87OpmUgTJc57JGTJ7zr966EDljBUcSqy1cg6Pdz7fSxVx35mMxGweBCCe+I5PRbRPntwuEmHeWYnVbmhTmU661Avd5WzaXE/8L/IOUnphJZ94nSCBGfwHIGEZbSvclaN+8Kb2QWCTczIm0g/2EiAYI6oAmJKG/d+6sP
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:4kAWIQUDygeDptSm/A/6bxhRAO16HgMstE1QG9kQgriFFQeGlfwJnHRWXrFH/u2m+JEztxgFP+fxCZlw4gcezgFQMqphRW9pNzL5kEva4Z8sO6toxqmfCaDRRmLAzlBf6e73bnD8/ViqhKPZPT2Hu2HNLjnCT+yvcX/V8buvDjikc7Uix3rVIg/vVqQ+CGw9FhfIIE4en8QJKcySzbj7L3OWG3uLaLTYlov/slsB+h+kWASreCHXUNoLGjVCLgzCqKk04BolwqVzKoipmVE8S0g99lo75Mh3YKDIZxRhTf0yrjcGTb+51P/dnuW3lTtBeNfOBYMZ5/PynOBhWPmT02b3/nmJPn2zTmvUWsdxTAdlG49/TgrwOW4lTVTu8bWg+dJW0Eg7G7np2+l1apPQetl+l8YPA2XpRnN3SYX/Wzee6XgyTWjnvAaX7nAW2ulj8cwvWUr4ooNvcw3ASPvqHw==;5:62jypkx05Cq7+kzFLG/kEWLpUdMYrixC1hDb9nLOQ0HQQ/hgb7fJ1syQhf3dDyJxVWuiRh0uaReu+76BQu2L4edFaAz0/cMco7Ncx5Mv2ZBg1+H7jgXquu6wnZU7HC5BNg8MFqjdRcOO7ZUWUdCEVU5DThEQ1ldJnD7YIENqa1M=;24:66yuMwSYSlDAHzFCIJJRRxvfW4jO4FrrdD7Buw7pDTiRxXYAy3JKeJdOL0//CjY2KRaPvj/mfkRxUfVRRiMO6S8IEkLOS0QpgiW+Nwbaj9A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:Z4FkP5Bku2LpdR2ql+/4niNIUchZ4V/9p1jAIYB2dNHds516KdfdfMndWA61jxuIDEi8OTkbfTH+QEq2ah1Aq1HP5ed3tVX04lDuvpA3SojxDYETuRO/7COudJNq6+ftu6gVxLsBUImFt5FIwgK+DpD3mWr8Kj95iV11d4udEWT6fyfs1WwDgaNonpj26QQATfe0P2IXy2l1ltQ6HgcoyUZS8n1czvaDPkkqqgmYYMMp0sP8FCDGxoj8AAnQLZbQ
X-MS-Office365-Filtering-Correlation-Id: 75ef693e-3b6f-4f88-26c3-08d5a6ae9e7c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 11:05:24.5320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ef693e-3b6f-4f88-26c3-08d5a6ae9e7c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-20 12:18, Laurent Pinchart wrote:
> Hello,
> 
> On Friday, 20 April 2018 11:52:35 EEST jacopo mondi wrote:
>> Hi Peter,
>>     I've been a bit a pain in the arse for you recently, but please
>> bear with me a bit more, and sorry for jumping late on the band wagon.
>>
>> On Thu, Apr 19, 2018 at 06:27:44PM +0200, Peter Rosin wrote:
>>> Hi!
>>>
>>> I naively thought that since there was support for both nxp,tda19988 (in
>>> the tda998x driver) and the atmel-hlcdc, things would be a smooth ride.
>>> But it wasn't, so I started looking around and realized I had to fix
>>> things.
>>>
>>> In v1 and v2 I fixed things by making the atmel-hlcdc driver a master
>>> component, but now in v3 I fix things by making the tda998x driver
>>> a bridge instead. This was after a suggestion from Boris Brezillion

That should be Brezillon, sorry for being sloppy with the spelling.

>>> (the atmel-hlcdc maintainer), so there was some risk of bias ... but
>>> after comparing what was needed, I too find the bridge approach better.
>>>
>>> In addition to the above, our PCB interface between the SAMA5D3 and the
>>> HDMI encoder is only using 16 bits, and this has to be described
>>> somewhere, or the atmel-hlcdc driver have no chance of selecting the
>>> correct output mode. Since I have similar problems with a ds90c185 lvds
>>> encoder I added patches to override the atmel-hlcdc output format via
>>> DT properties compatible with the media video-interface binding and
>>> things start to play together.
>>>
>>> Since this series superseeds the bridge series [1], I have included the
>>> leftover bindings patch for the ti,ds90c185 here.
>>
>> I feel like this series would look better if it would make use of the
>> proposed bridge media bus format support I have recently sent out [1]
>> (and which was not there when you first sent v1).
>>
>> I understand your fundamental problem here is that the bus format
>> that should be reported by your bridge is different from the ones
>> actually supported by the TDA19988 chip, as the wirings ground some
>> of the input pins.
>>
>> Although this is defintely something that could be described in the
>> bridge's own OF node with the 'bus_width' property, and what I would do,
>> now that you have made a bridge out from the tda19988 driver, is:
>>
>> 1) Set the bridge accepted input bus_format parsing its pin
>> configuration, or default it if that's not implemented yet.
>> This will likely be rgb888. You can do that using the trivial
>> support for bridge input image formats implemented by my series.
>> 2) Specify in the bridge endpoint a 'bus_width' of <16>
>> 3) In your atmel-hlcd get both the image format of the bridge (rgb888)
>> and parse the remote endpoint property 'bus_width' and get the <16>
>> value back.
> 
> Parsing properties of remote nodes should be avoided as much as possible, as 
> they need to be interpreted in the context of the DT bindings related to the 
> compatible string applicable to that node. I'd rather have the bus_width 
> property in the local endpoint node.

In addition to that, my view of this binding

	endpoint {
		bus-type = <0>;
		bus-widht = <16>;
	};

is that it always means rgb565. See further below.

>> 4) Set the correct format in the atmel hlcd driver to accommodate a
>> bridge that wants rgb888 on a 16 bit wide bus (that would be rgb565,
>> or are there other possible combinations I am missing?)
>>
>> I would consider this better mostly because in this series you are
>> creating a semantic for the whole DRM subsystem on the 'bus_width'
>> property, where numerical values as '12', '16' etc are arbitrary tied
>> to the selection of a media bus format. At least you should use a
>> common set of defines [1] between the device tree and the driver,
>> but this looks anyway fragile imho.
> 
> This I agree with though. Combining the remote bus format with the local bus 
> width should fix the problem without having to parse remote properties.

My thinking was that the binding with bus-type = <0> and bus-width = <bpp>
would mean a parallel bus (type 0 means auto-detect and with a bus-width that
auto-detect means a parallel bus) and the most natural/common interpretation
of that bus-width. For bus widths of 12, 16, 18, 24, 30 etc I think that
would be rgb444, rgb565, rgb666, rgb888, rgb101010 (or, I'm first so I get
to define the default). If you have some other interpretation of a bus with
that width, you'd need to extend the video-interface binding with some way
of saying what you need, perhaps using some kind of data mapping or something
to say e.g. bgr666. And you'd need some kind of indicator if you have YUV
signals instead of RGB, and LVDS isn't a completely parallel bus, so you'd
need something for that. Etc.

Because the word from Rob was that there should be one common binding that
describes video interfaces. I started an implementation that interprets that
binding in a drm context in
[PATCH 3/7] drm: of: introduce drm_of_media_bus_fmt

With that view, any input format specification of the bridge is not helpful
for me since what the bridge specifies (without help) is going to be wrong
anyway. End result, I need to specify the format manually on either the
bridge or the atmel-hlcdc side, and I happen to think that the correct side
is with the atmel-hlcdc, because that is where my issue originates. In short,
the "drm: bridge: Add support for static image formats" series is unrelated
as far as I can tell.

Cheers,
Peter

>> Have I maybe missed some parts of the problem you are trying to solve
>> here?
>>
>> Thank you
>>    j
