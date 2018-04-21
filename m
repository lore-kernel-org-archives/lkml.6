Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbeDUPFc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 11:05:32 -0400
Received: from mail-eopbgr20127.outbound.protection.outlook.com ([40.107.2.127]:56296
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752647AbeDUPF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 11:05:29 -0400
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=axentia.se;
Subject: Re: [PATCH v3 0/7] Add tda998x (HDMI) support to atmel-hlcdc
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: jacopo mondi <jacopo@jmondi.org>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
 <20180420113859.GL4235@w540>
 <840625e9-42ff-49b7-605a-202b4d980beb@axentia.se> <1549346.R82tLOL7eo@avalon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <faed23e9-4bcd-f1f4-77cd-41044f2e7b59@axentia.se>
Date: Sat, 21 Apr 2018 17:05:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1549346.R82tLOL7eo@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0376.eurprd05.prod.outlook.com
 (2603:10a6:7:94::35) To HE1PR0202MB2780.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;3:ShctbB9kR8PL++fH1eXpkNflxkUJbE4kIPkCOvK11VwCHEo7chirHnfdgGOXhSFVXtjayr9gPe60QH3jonLz32ZW5IAU3dcWGvFYu10LBDVq83U7r3IRsGLzUflIW31knwL5Hb8drtkfS8XxDaRFh665rWKj0oMYN4D1Iv7s/0pg82VhC/8+KbChLYtepqWp30Hzl91ag/S9sb8Eokpl0t+ifMGNpFNUvAmAKWtr/VSTkIzs8RFCQqu16kGxNGJa;25:zktcVdOjvmnDaE6kt9LPR5+HGWYD7sl9T2bYj8APbxx9ohpKPYq2nTnRxwqJD9S8Hul72gSOIf5sMexe17mnnNLp4l9AgH2vbySz+q8hAQcq3g31eF9wOfIuBXZwJJLmssCZ7wEu1Iaz+ZQlBaTX/ctJLAVqPXQCtuMcXeUI69weZEJZ9cdmJ6cNLHOsewUK1eZCADKeToVsyH/Mp3gG9IgBDJmuDASmU+IbjrwlWmtoOnqacUReSjseJt7wce6yc8BnCQAOyQ2mDYugdBkr8KJgHefE9477Vaq6kDksK484lAGGv4Q/YXZ7hzNWzNDpbOYKaU10Q49Ynbe1aKX7ZA==;31:LUtiaNPTccwyRLL3dwMY+B3U+fycQ2S4LbaWgvb/gSdRbRAwhKiGgQBE0kEA8jyS+YmSRBDJZaEr9uC/Bl1qfd7EX4rD2kb9S92Bjcn6nZYomvobCzHDEwAWY6GZHy0ARUth0XVng1lGevWjYT/Ycwk8q2GGnfLgMT1762Mvxv32ua9C2SQq560/cbeA09BPoHPGJk1GioUHTULdmG638GWF/4Zro8CKR7OZBqKaUBA=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2780:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2780A6CC1FD4B70ECB2CBA4ABC8B0@HE1PR0202MB2780.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501407)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2780;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;4:OjQ0mHhQ4saGF4uSSYw2J37NJ7JmXzFvs6RHnU8lzXnOkLND/sUZ+YrsNxsPXwcCVDPG1PIkxqzhwhPghq8bJ1ZN89r7VsebbBLiANjlViTt7LZrvrw8qllLoCdy28wfrwCsYSQXmRkEtjcTsFpIPngnXrgKaCXSReBokrv24QJOReULaz5IWiYKw1fY3Rzrf6pJCxsn/Ml3Yf8PMsrVEZymhcbXeSKB2irGCqCT0QcIwZTxpw8cspmTDPNadVe+TVl8v8vq5zUHTTd5PgYzQw==
X-Forefront-PRVS: 064903DDDC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(377424004)(51444003)(229853002)(6666003)(386003)(59450400001)(6306002)(6246003)(53936002)(53546011)(36756003)(50466002)(186003)(77096007)(26005)(16526019)(81166006)(11346002)(966005)(8676002)(446003)(476003)(74482002)(2616005)(7736002)(4326008)(956004)(8936002)(478600001)(305945005)(25786009)(117156002)(76176011)(3260700006)(5660300001)(6116002)(3846002)(2906002)(31686004)(7416002)(93886005)(52116002)(2486003)(230700001)(54906003)(316002)(16576012)(65826007)(36916002)(52146003)(6916009)(6486002)(86362001)(47776003)(31696002)(23676004)(66066001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2780;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3ODA7MjM6N2o3RVNoTUpFUGdtNkpDK0pGWkVFWDNE?=
 =?utf-8?B?Zy9wWTQvRE5TQ1VNanIrUExEZXBzdjEydnBUcVM4cW5pbFU1R0VrUmtxTDRW?=
 =?utf-8?B?dDF3N2ZDVE9XM0IwN1RNdjFVYmRvajJLQ3JDdC9OMitManZZQlBkNVhQME5Z?=
 =?utf-8?B?UnF1bHRiaFRDN2gyMHcrMnB3MnhTb1ZxM2VPSkVucWd3OW9VMVRUZ3RaVE50?=
 =?utf-8?B?RFhxbEVJNU8xRVg5Y3FFOHZIZWhuRy9qaVZjMEY1bmFEZ093TTlJbW0vYVRV?=
 =?utf-8?B?c3pQZ2Zycmw2SUEyT3FrWjZJR1RlOFo0SXBkdHkrUGpVN0dnSFozRlZqbHFw?=
 =?utf-8?B?OUNXanU4UC9zK3lzbmQ5V0NWL2xwSkh1QmVXT3JlbGE4aVpsVkhUR2hucG9t?=
 =?utf-8?B?M0RqTzczckFocHRqMk9kc1hVVjJsYjZBeHFtSEh6WmVuRGJHU1pEUXVxMzZT?=
 =?utf-8?B?a0NiTUh4NGpsWTlwWUpVWnNWLzNLRm5uWG9YS2JPNjI4MmlpcUo3Umtlc1gz?=
 =?utf-8?B?SzhENkFOQVUxWXd2Vm83Mm12ek01d1VUelM2TGJUVWMrc3lqa2JYRlRBazda?=
 =?utf-8?B?Uk9zeXR6aEVmL0RyMkNDcTkvRndIRzdIdWVSdFllVXFBa0VuQ2ptSTRnaG81?=
 =?utf-8?B?NXY0d1c4cnFqblRWUWNZZmpWSW93Vm02c2FUZk1GUFZuSlcwQVB3a1d0ekd4?=
 =?utf-8?B?UEZjL285NG9IakJKTkVxbTFJQU5ERGZOelZMTHAwRnQ4UU1SRE1sM1RHc29m?=
 =?utf-8?B?TTc0NWtDSFB3V0ExME01NlA1MFo5c0RYekRQT2RXdWcrdnNtSGd0aEVqdGZk?=
 =?utf-8?B?bGhkcHFnaWprTElQeUpUMXppSjZZS0hRN0JGVTN4MFh4VmpBekJrajZ2Zmhs?=
 =?utf-8?B?UFgwNGx1Nkl5Y0pSTkQwVkhtd3UrblhWeStmZllVR016VFlzaTNYdnhjU0pp?=
 =?utf-8?B?ZnhaaDZjZzF0V01PNnczVmFGTStrTFdNTk1WQWtjdk1acDEzUHpsZnVIN2E1?=
 =?utf-8?B?M3dVMmpyMUxkTXlDVWN4aFNKdUxMaElWUll5aG1kcXAzZWZIamtwRXFMc1Js?=
 =?utf-8?B?eWt0TW56YkErKzJkcVhFRXJwRnhub1VWNW0yUU1uRUNUNzhxaVBvWFVlalZB?=
 =?utf-8?B?V01qR0drSy9TMVA5OFl6eXNNSGp0UWJTTmtjRjdiaHk0OE9iT01xV3dEZk1I?=
 =?utf-8?B?ajRLVWdUUGFoTlBGZnlta01OVjMzWGd0S2FkaTRNU0dOS3ZvdGdCWnVIU1ZY?=
 =?utf-8?B?MkRwenhjb3hLRThybGlqY3RuUHpadEVQczdrbGdKWWVPZTJLRmxWOWxnZVhU?=
 =?utf-8?B?WU15OU96V0tWT0tqK3hxVkQ0cjM3Y25oVksrazNvQmQwMFcrbVYyM3J1UnNO?=
 =?utf-8?B?a2dXMG9nSnNpbTk1bDRqOGpZM3pLa3lTZmUxa2tTUnlaeVhtNXlFOEZQT2xD?=
 =?utf-8?B?UE5XVkFOdWdTZkJqckdobGY3cTdFN0lqazYvNEpDQUxTSi9tTlpFWVZKS1Rt?=
 =?utf-8?B?aWdENEp0cHpDUG1EVmcxSjZtSXdCVG5Rb3I2U1JrOGFqZDhNS21NNmhzTTlG?=
 =?utf-8?B?Q3E0SmlKbkxRRFVtTlB6ZFlvVjRmZHE0REUyY0xBejcrZHFkR0VHOTA3YWlD?=
 =?utf-8?B?QVVjTlNOdXhVNEJLaVkwY1BnU3dMRXk5VytRdjFtTTdzWmtHRzFEUll2Mjlt?=
 =?utf-8?B?ZE0yWmFEaFZSUTFINkdTVlpaOTZwZnA0T2ZWaXZVNkNkU3ltVlVhSnFobVQ4?=
 =?utf-8?B?bll1MGZKZFlPVUdqSDZZTWhmQzViWVM2MDRYc1RDdXJWZTB5M1hac0N0Y2ZY?=
 =?utf-8?B?WnZxWHc0c2NuOStpNXJPam1nWEk2SHZLMFJnb09uMnRnN2hLK1p0bmV5cU00?=
 =?utf-8?Q?qw0PRbnBeK5WpnCmJwXAQIAJNtnDB6fujq?=
X-Microsoft-Antispam-Message-Info: JtfWSa1rz253odUQbvPCzwEGoPP7FNY9L+61pWgolc9UnnjHKp+ygOCOw/LGk4viTW3nA8Uw2DAq3ARxDoAV2zpqX15ZjeDJU11vw4yIBFio/wpHsetsttQ9PmGlKh5LQHC7/n3bZ9QXDMRV3lGsOdG66MRqkQWj1r6zatG89pnhI3mRwQzavIMYKcgGp3t8
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;6:mEPxTaBknddg85LLWXxHFMpIFb8Wciopw4j4Khz262Cmfpeu3jy98g2/JvzqTwrSFdM35+1t4BfhCbYjit3lSOQlriTVRpdZCqyMHlJrJRLk+EJhZiMUukK02dUOs4ejHJ4NyslGXOESXvo+QvVkFwsXBba7bS2tq68i/ddILOZuoNBZe6ZjQVP/vDQ0amnYet5SDY+UX2XkN+gXoam27xgIS6ZSUYihDQfQiSvY7BI9cEs+5z7/r5i9TMbka6UYIwGBwZVw0S86TVJVj9GLSDduREyVzFQR5JE0E/gKD4yOsIyP6IbNkCSAUjMMJKfdSeRtsEr9N913fjKQCIZ5Uq6QUKsRWLfFwuUU3NLAT5mpy/L0FQYP6jtC9EyUG0qaVJCGvXSujH/jhIZ84cyUY864doBYDa/TKXK1CGBvdmoIE78llkXcCl3uuH9+tvP6vabogkdTuR2zKL41g8YtjQ==;5:hmgRyARN+I5ArqRCBauPZyKdf//PKZSY36qtOqqfsgXV7aS7hTUqp0SChY7B2NVgF7N2h+VVKyWyAt6iE0l3LRsfWOT+g9tXntpp/KlPMat3EzGdWUkVkvxoIlZsq0rl37W970JYzBTq5S6oxbWjR+sGDQk7FOpeOehnWElDrCc=;24:xV/+njs2y3+8RO385UTi4hboVqioKfbfAxN8s9EhdErYqFFTqucLoF6IQSV/G/0umi0sRY41jV3u3gacGOSphxm3mv3ajixKz/gevb0lcB4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;7:xwrXidpaeS9XZUf4TcyY/iH2QAh5S4dClBCddRAnD6USUV+gBPqlVdmO+VsrQMx55vXU1Z6iNwgz/C8PF4Ggm53u18yKn7uoLiKnjaRhy8utLdTO7/yzK2ZdaS/K82uotE+B6lS5fvK0xg8WHiqlPcNKKZ2XhmzcAiDqYRaqHCf+QJ02Hjc0ih8tKVqZsKJqk7wwoIH++zjyfWmAavO/AnABOTI51/DYLJ1JW/vqEmab/uyMcLgQApPmTg6YmvsX
X-MS-Office365-Filtering-Correlation-Id: 58520591-5f1b-4785-bea5-08d5a7994f20
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2018 15:05:23.6861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58520591-5f1b-4785-bea5-08d5a7994f20
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2780
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-21 10:38, Laurent Pinchart wrote:
> Hi Peter,
> 
> On Friday, 20 April 2018 15:55:50 EEST Peter Rosin wrote:
>> On 2018-04-20 13:38, jacopo mondi wrote:
>>> On Fri, Apr 20, 2018 at 01:05:21PM +0200, Peter Rosin wrote:
>>>> On 2018-04-20 12:18, Laurent Pinchart wrote:
>>>>> On Friday, 20 April 2018 11:52:35 EEST jacopo mondi wrote:
>>>>>> Hi Peter,
>>>>>>
>>>>>> I've been a bit a pain in the arse for you recently, but please
>>>>>> bear with me a bit more, and sorry for jumping late on the band wagon.
>>>>>>
>>>>>> On Thu, Apr 19, 2018 at 06:27:44PM +0200, Peter Rosin wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>> I naively thought that since there was support for both nxp,tda19988
>>>>>>> (in the tda998x driver) and the atmel-hlcdc, things would be a smooth
>>>>>>> ride. But it wasn't, so I started looking around and realized I had to
>>>>>>> fix things.
>>>>>>>
>>>>>>> In v1 and v2 I fixed things by making the atmel-hlcdc driver a master
>>>>>>> component, but now in v3 I fix things by making the tda998x driver
>>>>>>> a bridge instead. This was after a suggestion from Boris Brezillion
>>>>
>>>> That should be Brezillon, sorry for being sloppy with the spelling.
>>>>
>>>>>>> (the atmel-hlcdc maintainer), so there was some risk of bias ... but
>>>>>>> after comparing what was needed, I too find the bridge approach
>>>>>>> better.
>>>>>>>
>>>>>>> In addition to the above, our PCB interface between the SAMA5D3 and
>>>>>>> the HDMI encoder is only using 16 bits, and this has to be described
>>>>>>> somewhere, or the atmel-hlcdc driver have no chance of selecting the
>>>>>>> correct output mode. Since I have similar problems with a ds90c185
>>>>>>> lvds encoder I added patches to override the atmel-hlcdc output format
>>>>>>> via DT properties compatible with the media video-interface binding
>>>>>>> and things start to play together.
>>>>>>>
>>>>>>> Since this series superseeds the bridge series [1], I have included
>>>>>>> the leftover bindings patch for the ti,ds90c185 here.
>>>>>>
>>>>>> I feel like this series would look better if it would make use of the
>>>>>> proposed bridge media bus format support I have recently sent out [1]
>>>>>> (and which was not there when you first sent v1).
>>>>>>
>>>>>> I understand your fundamental problem here is that the bus format
>>>>>> that should be reported by your bridge is different from the ones
>>>>>> actually supported by the TDA19988 chip, as the wirings ground some
>>>>>> of the input pins.
>>>>>>
>>>>>> Although this is defintely something that could be described in the
>>>>>> bridge's own OF node with the 'bus_width' property, and what I would
>>>>>> do, now that you have made a bridge out from the tda19988 driver, is:
>>>>>>
>>>>>> 1) Set the bridge accepted input bus_format parsing its pin
>>>>>> configuration, or default it if that's not implemented yet.
>>>>>> This will likely be rgb888. You can do that using the trivial
>>>>>> support for bridge input image formats implemented by my series.
>>>>>> 2) Specify in the bridge endpoint a 'bus_width' of <16>
>>>>>> 3) In your atmel-hlcd get both the image format of the bridge (rgb888)
>>>>>> and parse the remote endpoint property 'bus_width' and get the <16>
>>>>>> value back.
>>>>>
>>>>> Parsing properties of remote nodes should be avoided as much as
>>>>> possible, as they need to be interpreted in the context of the DT
>>>>> bindings related to the compatible string applicable to that node. I'd
>>>>> rather have the bus_width property in the local endpoint node.
>>>>
>>>> In addition to that, my view of this binding
>>>>
>>>> 	endpoint {
>>>> 		bus-type = <0>;
>>>
>>> bus-type is used by v4l2_fwnode helpers to decide which type of bus
>>> they're dealing with iirc. Here it seems to me it has no added
>>> value, also because in your bindings description "it shall be 0" and
>>> it is not parsed anywhere in you code, but no big deal....
>>
>> bus-type is indeed parsed and verified to be zero which means auto-detect
>> according to the video-interfaces binding. An auto-detect bus-type with
>> a given bus-width means a parallel interface IIUC.
> 
> I believe you could leave it out though. Your display controller only supports 
> parallel buses, so there's no need to specify the bus type explicitly.

You need it if you want to verify that you conform to the video-interfaces
binding. And that verification is only needed *if* we want to build upon
the drm_of_media_bus_fmt function so that it eventually support other formats.

Where I'm coming from is this discussion with Rob:
https://lkml.org/lkml/2018/4/9/286

I interpreted that as is seen in patch 2/7 and 3/7 in v3 (and v2). True,
I might have read too much into his desire to have something generic,
and that the generic bit only applied to the binding, but 2/7 and 3/7
was how I interpreted that conversation.

>> From patch 3/7:
>>
>> 	if (of_property_read_u32(node, "bus-type", &bus_type))
>> 		return 0;
>> 	if (bus_type != 0)
>> 		return -EINVAL;
>>
>>>> 		bus-widht = <16>;
>>>> 	};
>>>>
>>>> is that it always means rgb565. See further below.
>>>>
>>>>>> 4) Set the correct format in the atmel hlcd driver to accommodate a
>>>>>> bridge that wants rgb888 on a 16 bit wide bus (that would be rgb565,
>>>>>> or are there other possible combinations I am missing?)
>>>>>>
>>>>>> I would consider this better mostly because in this series you are
>>>>>> creating a semantic for the whole DRM subsystem on the 'bus_width'
>>>>>> property, where numerical values as '12', '16' etc are arbitrary tied
>>>>>> to the selection of a media bus format. At least you should use a
>>>>>> common set of defines [1] between the device tree and the driver,
>>>>>> but this looks anyway fragile imho.
>>>>>
>>>>> This I agree with though. Combining the remote bus format with the local
>>>>> bus width should fix the problem without having to parse remote
>>>>> properties.
>>>>
>>>> My thinking was that the binding with bus-type = <0> and bus-width =
>>>> <bpp> would mean a parallel bus (type 0 means auto-detect and with a bus-
>>>> width that auto-detect means a parallel bus) and the most natural/common
>>>> interpretation of that bus-width. For bus widths of 12, 16, 18, 24, 30
>>>> etc I think that would be rgb444, rgb565, rgb666, rgb888, rgb101010 (or,
>>>> I'm first so I get to define the default). If you have some other
>>>> interpretation of a bus with that width, you'd need to extend the
>>>> video-interface binding with some way of saying what you need, perhaps
>>>> using some kind of data mapping or something to say e.g. bgr666. And
>>>> you'd need some kind of indicator if you have YUV signals instead of
>>>> RGB, and LVDS isn't a completely parallel bus, so you'd need something
>>>> for that. Etc.
>>>
>>> The fundamental issue here is that you're tying the bus with to an
>>> image format. Why <16> can't be, say, MEDIA_BUS_FMT_YVYU8_1X16? it
>>> spans to 16 bits, doesn't it? And I'm sorry but the 'I'm first so I
>>> get to define defaults' argument doesn't apply here.
>>
>> I never said that <16> could not be something YUV. I said that <16> without
>> any further information is RGB. But you are right, the fundamental issue
>> is that I want to specify the full format in the endpoint node, while you
>> do not for some reason I don't understand. And maybe saying that "<16>
>> without more info is RGB" is too presumptuous, but then I think that the
>> right fix is adding something clearly indicating RGB is the way to go, so
>> that there is a way for endpoints to specify RGB565 (or whatever is needed).
> 
> I think that would lack genericity though. I could easily imagine a setup 
> similar to yours where the bridge can accept different types of parallel 
> formats (RGB, BGR, YUV, ...). While the bus width is a property of the PCB 
> routing and is thus fixed, the format wouldn't be a property of the platform 
> but would be dynamic. I believe that combining the bus-width DT property that 
> carries static platform information with the dynamic format reported by the 
> bridge (through the API proposed by Jacopo) would then be a more generic 
> approach.

This is a valid argument.

> You don't have to depend on Jacopo's patch series though, I would be totally 
> fine with assuming that a 16-bit width means RGB565 in the atmel-hlcdc driver. 
> What I'm not comfortable with is hardcoding that assumption in the helper 
> defined in patch 3/7. I would thus propose moving that code to the atmel-hlcdc 
> driver for now, and creating a generic helper that uses both bus-width and the 
> format queried from the bridge when Jacopo's series makes it to mainline. 
> Would that be an acceptable approach for you ?

I just want something acceptable that lets me set a few bits in a damn
register to my liking, ok? :-)

I'll re-spin with the meat of drm_of_media_bus_fmt moved to a static
function in the atmel-hlcdc driver (and squashed with 4/7).

Cheers,
Peter
