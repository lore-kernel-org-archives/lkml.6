Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeC0MM4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:12:56 -0400
Received: from mail-db5eur01on0103.outbound.protection.outlook.com ([104.47.2.103]:53486
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752271AbeC0MMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:12:53 -0400
Subject: Re: [PATCH v2 2/5] drm: bridge: add API to query the expected input
 formats of bridges
To: jacopo mondi <jacopo@jmondi.org>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180326212447.7380-1-peda@axentia.se>
 <20180326212447.7380-3-peda@axentia.se> <20180327094743.GL27746@w540>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <fcc47402-d758-4062-0565-f5977b85b206@axentia.se>
Date: Tue, 27 Mar 2018 14:12:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327094743.GL27746@w540>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0901CA0065.eurprd09.prod.outlook.com
 (2603:10a6:3:45::33) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0cf4495-d200-4bdb-3ff1-08d593dc0deb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:XukSkkzFCnOnoN6CW3AItYl8uDj4F2marj4u/YB2iKhiG+XpyfIBDR4oAgqQ8jgSCHgSZKMuxM2iL1b87iGH/GeuoQpny1iU4sANqcqpHVfJ6xREV+S1LS+Fh2MfIRBhXGbDYCAXVADiN5SfeiME0w04ifaoAtF7vcDGL5FJYk2jdUeQHZQcopZvBTPQeNbtxvchUtlaN2zNx49tJrz/dDrTbRC3+MAxvKMXJDeIbs8HxbY0BikxwcCwpolUNrR1;25:4P23FNcw/7KchikuDw9LAKlyL2FyJ5VCa704wyCzLwDomdGhLuVcINAidzFpaMaAWSb0AeQRJFb2gNvxgAT5Fyk95l0mOzH+4sEGjfwroD/2kVZBSGaPVtJM+CPhTQxkrFccd2B5aeHjxDDPPWRlCjtW9aQd22OCOCZREfwQCFXuhYKZ6GWGQNQAqQuNE7Dtz1r1HM2/Jblg8oudWc4dq8TccT6ifTcry6/KmwWQWY65KZIK/ZvGiChJudScMPxM+dmwJFwup6ILncCtodfu6YUsHwVioR0l0t7HvAHxiohYZr0d1xGyRQOmbvkPDCE/phTtSVkfI6eoU7kLb5pOcQ==;31:CuiPhnAUr6fQfEdNj6RPt+10jEEIl5WuXjLPdPPf6YQHm5uWfgGHMaG28DfISqVboBreDtzwuW0cw7vzV3vSUIpxEsl91TIJjEtmofcHrS6dJyZxXI70P99/y812JOjhKqKgN0i5f6maUTdXxZVJEsRwJKebKi7npRwd5ZS6p2FIGiep7QGIqP1rQAWdLRzgQPSpkhx6qDifBzTyHtwzQgRXXDwY2sewhmy1q2ZXHlw=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2776A9EF493F4ACFD98BF929BCAC0@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:taRTFbhf+5v7e9zpKCdLDgEsL+HtpdYCgvc8V3gj/phJFvE5i06a/ML6S47fG6EbHW56PcIMmlIy/y7YFh3XGoRHhWOy8Y/m8K2s+Z0TbsbcZNMivQ8Zgfa5Ji2X8yHeTHWqFalkz24JTlucacJpzUFtJC2TGy3pN5JxMbXeTk3X/7IePIWjUsaM/r3VEwM4LX0Vkm7QxKWkxl15q4wDw1ja2BaRPGSshEiX9jW9DwLRr4YIvGTBmBjaYL6lIyD4sx9nlnWjSLpbKJa13qSPmFm/wRNR3MxysdYCdT+ZH+u0x9bLgzOS3NFGt4ndDGWB
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(39830400003)(396003)(366004)(39380400002)(51914003)(377424004)(189003)(199004)(59450400001)(65806001)(7736002)(53936002)(446003)(68736007)(229853002)(186003)(16526019)(81156014)(8676002)(58126008)(476003)(106356001)(305945005)(66066001)(47776003)(97736004)(36756003)(65956001)(105586002)(81166006)(8936002)(54906003)(86362001)(575784001)(4326008)(26005)(52146003)(31686004)(36916002)(50466002)(2486003)(3846002)(6666003)(6116002)(478600001)(16576012)(386003)(6246003)(77096007)(23676004)(52116002)(230700001)(53546011)(74482002)(64126003)(11346002)(117156002)(316002)(6916009)(31696002)(25786009)(5660300001)(3260700006)(2906002)(65826007)(76176011)(956004)(2616005)(7416002)(6486002)(486005)(486005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzY7MjM6cmZqVGFXdDYySnJSdlV2cEVUSlN0UGFD?=
 =?utf-8?B?b3p6TDZVSThUeWlkaWVmNFhkbjRrYlV6eGF6SXVyNHVrbWxlWU1JSVc2OTM4?=
 =?utf-8?B?eUx2cXhHejBtMm54UlJiUWZwNVd4aXVab25QMHBLNFNmSjM4TXBpeW5QNktq?=
 =?utf-8?B?MUcvaVFLaG5qeFQvZzM4Wmd0azEwV0JCRkxDdGVRWjZoSElLdXlOSVA1MVZP?=
 =?utf-8?B?VGgrOVBrbzdkOWpBSzZnaGpFcFZENzdablIzK0JIbG5pbS9EUlpObStkNEdF?=
 =?utf-8?B?dUsvdXlIRk9vK1RRMnVvQjcvcHludXFJaFA0R2w4aG1sYkNhUEpZWEJtUlk1?=
 =?utf-8?B?aEx2bVNkaDFYSnREUG8vUURXMzdYd1l6N2hhaWFTbkYyNUQyYS82dTZJYkpk?=
 =?utf-8?B?ZTQyZDA3R09BaXE2RWhjalhOOWZwWUF5Z3dKSGM4QW9OcTk3M0ZJZ2FRL2w3?=
 =?utf-8?B?cXFEdlhZdEppMFhVUWo0Q01PbFNlbGNNQytVSVJWVGE0dlMycXo2L05paDZF?=
 =?utf-8?B?VHArcmZwZHpyNTZBN2F5VENoVXMyWDl0bm1WWkYyZVZMMHBVWlhBQ2s2V3BC?=
 =?utf-8?B?dUlURHRIajB6QmQ3YjA0eEtoRVJOUzZtc1BadUxza2s2emlRZi9KeGRuU2lK?=
 =?utf-8?B?cnhMWGp0UHlTR1N1d0NEank1ZjArc3RZUzBxUWd0dnplaHRmR1I0ZzVtTitE?=
 =?utf-8?B?MWlzZTg1aGNTOXErUnpqZ3VPam83RFZacTNKaE90QWExUTBnOG8vMUQ4RjR5?=
 =?utf-8?B?OVJoaHFVa1lIRm9tMzVwRFYxOGFiUDQ2QnVPZ01yT0xVazIwTFg3cVBJRSta?=
 =?utf-8?B?d2lKbmIrbVBaeXd0b1F6YWw4V0VkZ2didUg4Yk1mRkIvWHB4WEdyaEpEaVpa?=
 =?utf-8?B?amlOVFgwS29HUnh1YVV1TUpzSzhoeWdoeW9ONmZHM0psRHlVd0pOaTFZalRw?=
 =?utf-8?B?c0hGeHM0Qk5wNk9xb1R4U3JlK2J5SGI1Wmh6ZlBSUitFV2V0Y3ppVFdjdEF2?=
 =?utf-8?B?OVIreGhJaFVUd3ovUlUyb1ljSGtuNnc4azNaZGZiSFNnNGZXS093S1FmcW9l?=
 =?utf-8?B?ZTYzS05Sd3FuNmxjdDM4anBLaFNmNFRWcmVEN2NERG1yZGZ3ZFBtVzFrNGhs?=
 =?utf-8?B?dnZUemRRV0dMcXpveVpGQTdPd3Y5VVpIRThUdmF2Njk5UVphcjdmMXhZV2hs?=
 =?utf-8?B?cXBCQUdmNi85MWFNdldicGVnQlZSZHZQaWNpSEFrd3lRZDQ2dXJ6dVpvbGxw?=
 =?utf-8?B?YTQ5MU1QWE1UTHNDdklHbTMyVXdnTmF3ajBRTGJBRlhVeWVOZGl2aVJNZStR?=
 =?utf-8?B?elkyWHhUR2M1WElZR3lzWXlxdDZKMnMrZERmVXZTTTNIR2JHdVg1THdwakJ5?=
 =?utf-8?B?MnBNUUZvVTAydm9hSE14c3ZMeXFKUFl0dHJTSityOFVQLzFXWlptanBvOXB5?=
 =?utf-8?B?VjJ0UTQ0TnBmL3dVc2ZOd2JvQ3lrd3NyWlZvSEYveUp2SzQzQnJDUVJwZ01h?=
 =?utf-8?B?dzBNQmJST1NtZllMZ1Rzd0tNRzMrU2RINGZycm5VendROU9XN0xpcFd2N056?=
 =?utf-8?B?ck02VHRkOHIvM3lpVVpJUmxVQ0xLUWF2a1Mxajl1QkkyUDhLcjNKME53WHpp?=
 =?utf-8?B?bkFzRmRYYW13Z21vbGtGeklndFVzYVN5Nnp0Q2dGd0l3N2t6d0NvZE56cUwr?=
 =?utf-8?B?MTcvRXN4ZHVvTnpLNkh3dzJOV3c1Tjg4dFg1MVUzQW9qTFpaV1RSRFdhdUk4?=
 =?utf-8?B?T2FMUlJiN1BlcDk1Y2kwemhZOXV3K1JPNzFqUzZlbVpyeEVyZFFucFl1UitD?=
 =?utf-8?B?eWFFNDQrbUhxRDViNVpzelNyeDk1dll5S0NuMmdCYU9hbDZTano1TjROYnpW?=
 =?utf-8?B?N3RKWXluRmlzNW5QTUdkMjAzY2NidERqamp5Mml0YjFZQlBaU2phbis4a0hY?=
 =?utf-8?B?SlhwbEtGU1dpMmZVUC9zNDlGRGFsNkEyL0RvSEpwWXl6RW13NHV1bzM1M2xG?=
 =?utf-8?B?aTl5RzFjYVJSaEE5K25XZ1FhSW0vb2FKSndvNytKK0FJc012U2c1L1YvU0RG?=
 =?utf-8?B?cTBObGYrUG5nMUw1K0ZtWmwvV0RWN1BQNVlhdkpBUWVZdkxJYkJVa3NIbTJp?=
 =?utf-8?B?VVRPVzlRa01jVlBSTzVYV3YrVmdoeFBNQmtPSDVYTnIvWklpSUVTYkFQdVEz?=
 =?utf-8?B?OU91NkRIbllRckh4R1E5NnZWYjZZYkV3RGJQUXV6VE81Sk5zaGNyRzdjVmRV?=
 =?utf-8?B?dTFBN3B6WkVFZnJ4OXlBSXJrMUZPWllYT0RSdU5tb1hFd1plWE1zRFZBPT0=?=
X-Microsoft-Antispam-Message-Info: ZbWEf3OMVWyC0iiXQ7f/96tTxNnObLasvjEmp/J4vFwrfWMim0w+ecPGTkUdho3Fc8senVSI7bZy9QHJJZTwD18SGiHhHOUWLGTxpowxWOaWSsTy/QdHHS3hp/m6Vw9jeHW48wSo7aGaF1D7fD6MeP4+o3RtcVc0QUlY1s3cThqMWJ2UecMg7vG3wpInpYkQ
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:pR7kJOQ8OCaHNDkSvTZ+xAyFd8CHQTGh13gWOTV8zMDDfTUz/oxl70ri3oeEgc0Ivs+4wa2oJlyy89f7E8O5DdoZa/mdBRjF477mLxODQ4CAuhnmqr90JUtVZuPMHLNnY7yerxa7ACxW8i+uBAacjMhbs9+0hwkBbKhO9TCLmSFsJfh6kta3ZFheBbF7JajI88ZeuF/bp4XCrCYljZPONzd9OtJNGa+xrimz/1IM/gwGiyRmbOrhYDQLZ9Q9Ptjvr91LMU0hO0WBe7PO8eSwADkVEzuN2DUTVi9zhysglrkmBaFDlJzXfej9JlP4YrWtngTzyNUOPbh/zGSGJvndtVDWy0WMmXefLQjNCytJ/Yz8NJ5OU/svMZUGhSwDP4DtI9KtKC0e9+pOVhbF6SQqcV8UNC59Co7l+4uoniezCdM8A1TI4/ik7w/ObxGb9oPRsGeRuPGRyN26t2FT1TTzTQ==;5:KE7F6Lc9KxrZTu+fDt0SRsyYmDfIxK6kVhoDQA0zLAvnOHBYCNOKyskkACE1YAFG2zXqOBvybRPoDIjVLVPQQRBd7UDijzJbEmdzx1qDv2witKtV4Y9IZDJ/JsEKbQ7HAKfjLBuqqL1CJHznFDBTKZ/RdEmPbpZpEnwGUCE5a1s=;24:X2FB6Aoor7dz2asPgNeXU89dn15AOFuhrb3HvIt/yrV3NtEk5seVOFJN59LDTUp5HC0wmBy5UklP6IytizqcWESFVHY9I5fveMFuMoCupus=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:UyWEzOuBawOYvY5lHVI9TSAsxlJjXpMCKUBq5lbPnG6ZioaxCnkgSNUlI4HXrEhkVzY4p/fokre3c3eE9px9miUCJElsRxxG04145xev0K7gXbsq7UksSVzzYdCh9CbrbMrhH3HmyT/o0o5vNIHzzUd2gAGSX+0KxZFsnbwcYG3muX3+48MbjF4DRkH2Osjsbecnz6g3ueHi9KCbHRKdn2p+sGAORicqWRE7pFY/7J06vjP2LsvhY9ZnmFLxYMwB
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 12:12:46.0746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cf4495-d200-4bdb-3ff1-08d593dc0deb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thanks for the feedback!

On 2018-03-27 11:47, jacopo mondi wrote:
> Hi Peter,
>    thanks for the patches
> 
> On Mon, Mar 26, 2018 at 11:24:44PM +0200, Peter Rosin wrote:
>> Bridges may affect the required bus output format of the encoder, in
>> which case it may be wrong to use the output format of the panel or
>> connector as is. Add infrastructure to address this problem.
> 
> Bridges not only affect the format expected by the connector at the
> end of the display pipeline, they may perform encoding/decoding
> between protocols and their accepted input formats may be unrelated to
> the connector at the end of the pipeline as there may an arbitrary
> number of bridges in between.
> 
> Eg.
> 
> ENCODER                                                CONNECTOR
>   |                                                         |
> |DU LVDS| ->lvds-> |THC63| ->rgb-> |ADV7511| ->hdmi-> |HDMI connector|
> 
> The fact that THC63 wants a specific LVDS input format is unrelated to
> the format required by the HDMI connector at the end of the pipeline.
> 
> I would just state here that bridges need a way to report their
> accepted media bus formats, and this patch extends the DRM Bridge APIs
> to implement that.

Yes, I can add some words, but I would like to clear up the naming
before re-spinning.

>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/drm_bridge.c | 32 ++++++++++++++++++++++++++++++++
>>  include/drm/drm_bridge.h     | 18 ++++++++++++++++++
>>  2 files changed, 50 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>> index 1638bfe9627c..f85e61b7416e 100644
>> --- a/drivers/gpu/drm/drm_bridge.c
>> +++ b/drivers/gpu/drm/drm_bridge.c
>> @@ -348,6 +348,38 @@ void drm_bridge_enable(struct drm_bridge *bridge)
>>  }
>>  EXPORT_SYMBOL(drm_bridge_enable);
>>
>> +/**
>> + * drm_bridge_input_formats - get the expected bus input format of the bridge
> 
> I may be biased by the V4L2 APIs, but this seems to me very much like
> similar to g_fmt/s_fmt callbacks we have there. Bridges have an input and

g_fmt/s_fmt says nothing to me. Graphics format? Source Format? I have
no idea if those guesses are even close? So, that seems like poor naming
to me. The only reason I see to go that way is for the sake of consistency.

> an output formats, and that calls for something that takes that into
> account, as well as they may have different input ports with different
> accepted formats but I would for now simplify this to just 'g_fmt()'

You mean rename the function to drm_bridge_g_fmt(), right?

As indicated above, I'm not that fond of it, but don't really care
either. Maintainers?

>> + * @bridge: bridge control structure
>> + * @bus_formats: where to store a pointer to the bus input formats
>> + *
>> + * Calls the &drm_bridge_funcs.input_formats op for the frist bridge in the
>> + * chain that has registered this op.
> 
> I'm not sure passing the call down the pipeline is desirable. Each
> component should make sure its output format is accepted as the next
> bridge input format, passing the call to the next bridge is not
> different that getting to the connector at the end of the pipeline and
> return to the initial caller its supported format. Do you agree with this?

Not passing down the call does one of two things. Either all bridges have
to implement the call or all users have to walk the pipeline "manually".
I don't like either or those options, so I still think it is good to
pass the call down the pipeline.

*time passes*

Oh, you do not think it is useful for the bridge to have a callback but
still report "no format change", and that the call down to pipeline
should only happen for bridges that have not implemented the op. But I
do think that is useful, see below.

>> + *
>> + * Note that the bridge passed should normally be the bridge closest to the
>> + * encoder, but possibly the bridge closest to an intermediate bridge in
>> + * convoluted cases.
>> + *
> 
> As I see this, any bridge in the arbitrary long pipeline should call
> this operation on next bridge if it supports different output formats.
> Ie. I would not name here the encoder nor refer to the bridge position
> in the pipeline.

Ok, I can change that, it just seemed like a convoluted case to me.
I mean, if this was a real issue and complicated pipelines were
common, something along the lines of this patch series would be
available already. Right? I guess not, but how the &#/%# have people
been coping?

>> + * RETURNS:
>> + * The number of bus input formats the bridge accepts. Zero means that
>> + * the chain of bridges are not converting the bus format and that the
>> + * format of the drm_connector should be used.
> 
> How do we get to the connector format from a bridge that has maybe
> other components in between in the pipeline?
> 
> If a bridge do not report any supported format, it won't implement
> this callback and things will work as they work today.

Unless the bridge optionally changes the format. If the bridge has no
way to say "no format change" even with the callback in place, it
has to juggle different ops structs, which seems like a big hammer.
So, I'm in favor of calling down the pipeline in two cases. A) when
a bridge does not implement the op and B) when the op returns zero.

Maintainers?

>> + */
>> +int drm_bridge_input_formats(struct drm_bridge *bridge,
>> +			     const u32 **bus_formats)
>> +{
>> +	int ret = 0;
>> +
>> +	if (!bridge)
>> +		return 0;
>> +
>> +	if (bridge->funcs->input_formats)
>> +		ret = bridge->funcs->input_formats(bridge, bus_formats);
>> +
>> +	return ret ?: drm_bridge_input_formats(bridge->next, bus_formats);
> 
> See my comment on the call propagation down in the pipeline.
> 
>> +}
>> +EXPORT_SYMBOL(drm_bridge_input_formats);
>> +
>>  #ifdef CONFIG_OF
>>  /**
>>   * of_drm_find_bridge - find the bridge corresponding to the device node in
>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> index 682d01ba920c..ae8d3c4af0b8 100644
>> --- a/include/drm/drm_bridge.h
>> +++ b/include/drm/drm_bridge.h
>> @@ -220,6 +220,22 @@ struct drm_bridge_funcs {
>>  	 * The enable callback is optional.
>>  	 */
>>  	void (*enable)(struct drm_bridge *bridge);
>> +
>> +	/**
>> +	 * @input_formats:
>> +	 *
>> +	 * The callback reports the expected bus input formats of the bridge.
>> +	 *
>> +	 * The @input_formats callback is optional. The bridge is assumed to
>> +	 * not convert the bus format if the callback is not installed.
>> +	 *
>> +	 * RETURNS:
>> +	 *
>> +	 * Zero if the bridge does not convert the bus format, otherwise the
>> +	 * number of bus input formats returned in &bus_formats.
>> +	 */
>> +	int (*input_formats)(struct drm_bridge *bridge,
>> +			     const u32 **bus_formats);
> 
> Consider g_fmt() here as well, or a function name that captures that we want
> to know the supported format (and possibly configure it as well one
> day, if ever possible).

The naming here should obviously follow the naming of the exported function.

Cheers,
Peter

> Thanks
>    j
> 
>>  };
>>
>>  /**
>> @@ -263,6 +279,8 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
>>  			struct drm_display_mode *adjusted_mode);
>>  void drm_bridge_pre_enable(struct drm_bridge *bridge);
>>  void drm_bridge_enable(struct drm_bridge *bridge);
>> +int drm_bridge_input_formats(struct drm_bridge *bridge,
>> +			     const u32 **bus_formats);
>>
>>  #ifdef CONFIG_DRM_PANEL_BRIDGE
>>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
>> --
>> 2.11.0
>>
