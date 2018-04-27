Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932253AbeD0HhZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:37:25 -0400
Received: from mail-he1eur01on0138.outbound.protection.outlook.com ([104.47.0.138]:40386
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757153AbeD0HhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:37:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 00/24] device link, bridge supplier <-> drm device
To: Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org
Cc: Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org
References: <CGME20180426223215epcas2p38fe3b0b7b1ea1c8190805f9e2a89e11e@epcas2p3.samsung.com>
 <20180426223139.16740-1-peda@axentia.se>
 <25d8e621-b3f8-094f-32a2-d22efc2163a4@samsung.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <7d4bceeb-9611-cbf9-3906-fef5db88aad8@axentia.se>
Date: Fri, 27 Apr 2018 09:37:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <25d8e621-b3f8-094f-32a2-d22efc2163a4@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: CWLP265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:53::29) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:A/+d/bU4gV1X1Try5uEKj5CjoqtRx664yXssO/1Ynv1eDYaQutee0KARZpe4rOSfW4UuR7VHAi8ZtlN/82J1SC+RQgpFk9KpkFIoNRiVOQMiXSN/8Hc8ScUoLPfF4p35Zmjf8/ZcDMF5nhtjWwDcavHOW8stlmV0MyuQeY/3Pl73nfGBnQXQX0IaycZVESFjfqv/AJqFoWnC0L/V1onnUjeE7ITelBI80rQ9KgF7TcXZK3yjjB3/MWKzproWzZEi;25:mdNcKs3O6eziIkr+z3x11zjgBVl2zxxxwemW5s/tGZdw7GQQRNDxanGFmJDmTcPSk2j+6RdbbIJEJMsHJLJ5NhWm8JXJtrPgRmrZ4VasjAYwygOV3AsNbeqqxfiYTXaXxHMCaoGZb9NAD72cL+bPJjNBGobsjD7CfR1X6tuwkwG//4zx13BtAiFotzqtT+B0ZvfozbdlYSQeuHgbUnJO4HQlsXl6pldUn6bufu/FM9mXZMk40DVj9hnij4VtGHuIr/VeKV9G6woxmMEeL/QjcJiSz6TuYCG2PB1mNzbNyWP1DgsHHsI9WJOLLWh/62y0xhLielisXsDIrBIjSOVEjA==;31:wiEriwcqc52SXw7lOnr3yEPfZVA6s8xQb/V4zf9aT42naWWkC1iOmpqmXhtIGG+nZQFS3+zrTyrslHsQNckoP6t4OkE8QLZLwPJNt0oKjltMO9dlVa3OuhjdkOdBsiRZuUCi2M+zaOQTEgF0q2FldyRlJZg1+RHdjYh51t6DtFfopOYJ1M2nz4/GteqP1mP7PloHTtLnpHKiRMZOExieVB3MRbf3tG5BEoh2jbm8jCs=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278245F8AD352800EF69F8F7BC8D0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501410)(52105095)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:fn33hWzBMXePNHhyTwkG8oSNEghcgi5vi37XFZcCdbwwFlGSksQ9KQtI7YtTYF/LUBy0Di0j3a22C9p6U9nVQXAUoNcQUcq/6p4nc2tkjY1PeyN89SKvdI42uJWOmnAIstuUlza1fC2vAjWilOCQfCK3L0OdqapkSjetMxFU8KOFYoco9lIYVRnkC3YmvN8uBaNTNcFpyAA2hILR7bd7JIFucxFJwZhSse7jsMpCIZlbf5saEDL1eRQYeUhDOopyJWBARB4dDO81/vn1xi50NBwthmGduEahSCnkOhv30wsMwqdNlFomQtu/q9njX2qL
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(396003)(346002)(39380400002)(366004)(376002)(377424004)(199004)(189003)(66066001)(64126003)(65806001)(65956001)(6486002)(230700001)(8936002)(39060400002)(26005)(76176011)(386003)(229853002)(53546011)(6666003)(6116002)(3846002)(106356001)(105586002)(8676002)(4326008)(53936002)(50466002)(36916002)(52146003)(478600001)(23676004)(117156002)(81156014)(2486003)(47776003)(25786009)(81166006)(3260700006)(52116002)(86362001)(6246003)(36756003)(5660300001)(7406005)(476003)(11346002)(31696002)(446003)(2616005)(956004)(31686004)(58126008)(54906003)(16576012)(16526019)(68736007)(7416002)(74482002)(97736004)(316002)(65826007)(2906002)(186003)(305945005)(486006)(77096007)(7736002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODI7MjM6MUFXR2Z2RjZSNXlaN2I0eExwZDcwMkd4?=
 =?utf-8?B?NlRMeHk3MzRic2djcldldFk5dzVxSlB0dzVzeDMvcG4xb1BTQk5DRVRWWFRs?=
 =?utf-8?B?empOKzdPaXZXelg0bEtFOTgvakE5YmswSDlqNHp2aER5V0Jlc1kvdGkyNHU2?=
 =?utf-8?B?OGMyUS9mUG5VQlZVU2RLYk1uWU4yWWlCSGpIbSt1RUUwS2FNV1BzRWoxN0l0?=
 =?utf-8?B?VXBuSjRGMmhBQTRWdWRyRHQ0Ti9SVG5QNE5hSngyeHIwMklDMStoRTJ6UFJ5?=
 =?utf-8?B?NzVjSGs0SExJbW5FVXcxQnpneGtKSFo5MDlCcnRQdWJLeGtwOUVURm1oZDVG?=
 =?utf-8?B?ZUd1QzN6aWVuWDB6blNib2pGMkVqR0JHTENvTHpFQ0Mza3B5aWdrSlVhL1Jj?=
 =?utf-8?B?TXFybXZTeDc2UmZJeVFFSENieit1Zlc5MWlxVGY1Ukp5ejlvUSs2aVpWenRJ?=
 =?utf-8?B?cFBrWFdKeU9XUWk5Nlp0Z1VwVnQxbzRkU0JTbk9GZ1ZOOUFhUWZZMGtuSm5V?=
 =?utf-8?B?T3lxYU53amhEWkJVNUNEZE81ek1uMDBjbWNYVUhpMEsxQUZWS1UwZ2k3SXY0?=
 =?utf-8?B?a1htcmdhZ3hoRjQ5QXp3TkJpczF0Q2oxcGF6dTNrbmFUaHMrZFZHVG5wdy96?=
 =?utf-8?B?RW9GY1o2Ly9MR2ZtVm9pUGlGQm1PbGVTRlBhSWpZVm1NTmFDQ1A0SWgwcTJk?=
 =?utf-8?B?VTNySjUrQ0NpVVo2cExPWW1BL1IzNnVFa2VlUlNDamFXamM5OTdPVU9vdEtM?=
 =?utf-8?B?Z2kzVG9pMEFMd291RmVCZnMzMGRJT3lWcHZSWWFSN0ZFZ2JsQ3ZOcy9yUEh0?=
 =?utf-8?B?dS9LNE1OSWVRSlIxbU1mT3J3QXRWZU9LVTBFbkVJN3VzT0hJK1p3eUV3R2Vq?=
 =?utf-8?B?SkRhQXc0dHc0SlJjcjFDaDRKZzVSVHFPWjVyRmVvaUpYbEY1NURzMENpTVN6?=
 =?utf-8?B?MytlbElqN21oQmYzOUZOOGc5bEExSHdPdWczSUhUNUZnYVd6WGRKa3ozcFpv?=
 =?utf-8?B?RUt0Z1JUTEV1L3ZTVVdpQlZpNGgydis1RkZBdmprMkpuTGZ5SEl4TlUvN0c2?=
 =?utf-8?B?NHRDeEtwK0dtSHV4ZmJ6cjFDTUJ2SFlEWFYybG9NZi9EZWdKdVZpcWpYZllF?=
 =?utf-8?B?ODk2Ujk1cDB6QnQ1YXVtVjFiOE5mMVkwTGlyeE9ENkVqb3hnMzM5amM4eUJk?=
 =?utf-8?B?dHJLVkhPeHU1akgyMzMxS0NxODNIM1V4TExxSGFOZGd0ajY3RmU2dWNUVlVs?=
 =?utf-8?B?MjQ5UDkxM3dZWk96SnZWM2c2RGphSjVXbjB3am9VL1lKQUs1eHZvTjl2V3d5?=
 =?utf-8?B?c0JnRE1YMGtmSmh0VTNXT0ZwMDdObjR4TSttQ01VQlRMZ21IM2dxS05HeWFL?=
 =?utf-8?B?MG5pNFlnSUlWUHBSbUJuTlIzVzBScmNqVlQ4MG5JaER0R0tTaVp4S3Z1d2NC?=
 =?utf-8?B?U2hGWVlCT1gySDgwU2xhdE1yWmthSkxTZ0o0MnlwamdrN0ZqUWtoR0o1NUZl?=
 =?utf-8?B?cDY3bzY2NHUxYjJRc05xRUtnWjdNTlJEQTBpeFJCdWVmOTRlY3JoaXVmYTNn?=
 =?utf-8?B?ZFNrclpkQlpGSTN5ZTJhV0Rxa0VjeExsTFAzVVA4N1grRW5WNUlqT2ZoYlc5?=
 =?utf-8?B?NUdhUkRjRkQvN0pybWxnNXU2bzlmaitrd1BzcjFyMlhWa0R1VHVHcXVVdzFp?=
 =?utf-8?B?dGN6bUZtZFFJK2pteVpJMklab0NKVFdSQktxMDZQcTJmdjVEc3BTYkNWdFpj?=
 =?utf-8?B?U1JSM21WZ044QUZkKzJEeUFxa2laVFJNLzNPZXp2SmJRM0lYQWtIay9CbGZK?=
 =?utf-8?B?OTR6dFY3cXhhYlVCTlZhU3VFSVU4eU00WjljNFpTdmtKbkp6bVBQdzZaWlNE?=
 =?utf-8?B?enQ1OE8yUlA4YTM0OExWWVBFbExTelk2TmNXc1NBcWhteFNuQllwODRXWGky?=
 =?utf-8?B?T0lSU0lzc1dBM29pcVkxaHd6T0cyTTBJaEtRWFN5YlJzMEZPOGJwOTRqVTg1?=
 =?utf-8?B?UmZGdFd3aFlzbm1XTmI4UmM1VXlLaE02NE9EWUlNNm1kenJNYkF1WkRJS1Z5?=
 =?utf-8?B?ZTh2Zkw1WHhhd1hYRmhWUXVyMk5aZ0JmbXhBNGtzRldDSVdaSTd4aTdmVkFM?=
 =?utf-8?B?Qm5BU0lGc1lDdGtTckRybjdkRGVaZ2ZXdThCeEZCT2swQmJOd3FjM21rMlRC?=
 =?utf-8?B?YzFQdzFCOC9Sb0gvVkV0UmxkZ3hSUWc9PQ==?=
X-Microsoft-Antispam-Message-Info: 74QebRK5jUslMhby5y8T8mKLa2belU2noeICYYs7unWDFZlzKfExJviKPdqqs8TQD/kNKV6Q3otfzKXCMIs039imq3p/fv/xb1MHAVM7Bnz1PgbBlm/XWDSCv+tT0PXk8aYTD6YR4z264ziTj7eb1DubO7bIwnuMVUGMv/mFEH5Cc37Ws9lEO8K/qA8NSrfZ
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:RC+6Cc4IZHP4SWkYYCDSy4e+o78X8HmZYcjgExdIkPCPnpP/Cd6Q21UP9OCx764FVJvB3cVCXgfH9dTAFBaQ/WIXtw6phZnP6kf8VloZeMGBwlR1ekzJ3ePDoB8c3aHS7BseXMTA+vNqEDJTcLoXtHBeXvlLF2WsaE3CWBoXAdpGZt5TmYZg1PRDO4ofXni0WiT6BMf3ZigTbe5r4hb2+KMQM/XWTK3YhUBQrBe++N79TIBsWP04qYsevO5hmFLnK6SqoMZK3jaaUld1soMdrMeTZb124eoESh0ftUbGQDQoQFypGwpHur7bCZxgciL4VihrdVmOFYslaGkW9hmLur9CN7sDuOKJdLHgn4Abf+C0cWleNTJTJcNCS5d8mZfUd9PSav2PSqoDSpUYTUMy4nEpt1pWGsVQ95odiOe8c6HKkMdchNddTNO8mjqKgO7SEU/S0D4zJwp53PyrTvIHhQ==;5:HmulzO62nQ2NP5B8XCYe/kAxm6+wix84bxKcqNmXamU6dBfJ7qwIeRyI8meAVrzMuB8vkedtHqwYDNT+BG0CXd2x2TDu6aUN1ZD3RHXIkK0TjSnZ386EbUyA4z6+3ID7n7WlkUcHK4u67dx/BxTcZoryDSo+T3IPX2I2nG+ZN6o=;24:CjmB4fenjryDcmC18KYJCOzQipZLW/EIc7yoLg71LS2k/a80fW0x6pxDNgEO1LdrbN++yLDEWLj74rPiBX9tY3ZirzRgrMnKszfrljfz+rs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:Rltd6KrFIRVy8QL+tXjXmgcPqUf5V7aGRQ1irnqOY8qGYoJWBQn5vVhVJC0fS7gnNvkTHbZ4uZNgBJ2mS0DrU9dP+419idHiG89IeFArcn9mE61u+yBh6kGkN23y3NH/CR7+LMPLB0oNDa0CQoL+FM0FAY8LX/eqfpTI6x9R9nQFYpPM13uDyZ4erPnb3/Htago+DbOPM16QVtdJR5ztwL44souguN2/SRfA86aV3xoIe5BRDKAosxaxWoJngQXv
X-MS-Office365-Filtering-Correlation-Id: 8e06312c-7a38-4840-1218-08d5ac11b34b
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 07:37:14.3849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e06312c-7a38-4840-1218-08d5ac11b34b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-27 09:11, Andrzej Hajda wrote:
> Hi Peter,
> 
> On 27.04.2018 00:31, Peter Rosin wrote:
>> Hi!
>>
>> It was noted by Russel King [1] that bridges (not using components)
>> might disappear unexpectedly if the owner of the bridge was unbound.
>> Jyri Sarha had previously noted the same thing with panels [2]. Jyri
>> came up with using device links to resolve the panel issue, which
>> was also my (independent) reaction to the note from Russel.
>>
>> This series builds up to the addition of that link in the last
>> patch, but in my opinion the other 23 patches do have merit on their
>> own.
>>
>> The last patch needs testing, while the others look trivial. That
>> said, I might have missed some subtlety.
> 
> of_node is used as an identifier of the bridge in the kernel. If you
> replace it with device pointer there will be potential problem with
> devices having two or more bridges, how do you differentiate bridges if
> the owner is the same? If I remember correctly current bridge code does
> not allow to have multiple bridges in one device, but that should be
> quite easy to fix if necessary. After this change it will become more
> difficult.

I don't see how it will be more difficult?

> Anyway I remember discussion that in DT world bridge should be
> identified rather by of_graph port node, not by parent node as it is
> now. If you want to translate this relation to device owner, you should
> add also port number to have full identification of the bridge, ie pair
> (owner, port_number) would be equivalent of port node.

You even state the trivial solution here, just add the port/endpoint ID
when/if it is needed. So, what is the significant difference?

Cheers,
Peter
