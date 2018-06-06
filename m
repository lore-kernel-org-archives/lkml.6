Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dio5ZWdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B797606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbeFFI2K (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:28:10 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55104 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932444AbeFFI2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:28:09 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180606082806euoutp01fb078d39482ac59c69f3b84cc211e0b5~1hNIrJRCW0593805938euoutp01S
X-AuditID: cbfec7f2-1dbff70000011644-06-5b179b15781d
Subject: Re: [PATCH] drm/vc4: Enable the DSI module and link before other
 enables.
To: Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc: Kevin Quigley <kevin@kquigley.co.uk>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kernel@vger.kernel.org,
        James Hughes <james.hughes@raspberrypi.org>,
        Archit Taneja <architt@codeaurora.org>
From: Andrzej Hajda <a.hajda@samsung.com>
Date: Wed, 6 Jun 2018 10:28:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87lgbtt6em.fsf@anholt.net>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87qis8WjDf49NrJo6njLarHvVD+L
        xZWv79ksDjReZrTY/P0Bq8XNd0/YLC7vmsPmwO7R9P4Ym8e8NdUel/t6mTzW9K5j87jffZzJ
        4+DJbkaPz5vkAtijuGxSUnMyy1KL9O0SuDJuL/nCXLBFvmL7or2sDYxXJbsYOTkkBEwkPjXc
        Ye1i5OIQEljBKDFzVycjhPOFUeL8p242COczo8TSc51MMC2Tjv2DqlrOKHFr/z0mCOcto8SS
        jc/BqoQFQiSm3N7FAmKLCDhJfNywD6yIWeAco0TTgu9sIAk2AU2Jv5tvgtksAioSSye9ZgWx
        RQUiJDZO+MQMYvMKCEqcnPkEbBCngIZE/9oLYPXMAvISzVtnM0PY4hK3nswHWyAhsI9d4uui
        u+wQzWUSr3fOYYe420XiwJpljBC2sMSr41ug4jISpyf3sEDY9RJNM68wQwzqYJQ4sXg5G0TC
        WuLw8YtA13EAbdOUWL9LHyLsKHHsSj87SFhCgE/ixltBiHv4JCZtm84MEeaV6GgTgqhWlLh/
        diszhC0usfTCV7YJjEqzkHw5C8lns5B8Ngth7wJGllWM4qmlxbnpqcWGeanlesWJucWleel6
        yfm5mxiBien0v+OfdjB+vZR0iFGAg1GJh3dFt1i0EGtiWXFl7iFGCQ5mJRHexEtAId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rxxGnVRQgLpiSWp2ampBalFMFkmDk6pBsbcgj9vIza985ByVQzy
        vtQed2DqKuGJB87U58bfDPsazBL8/kWcgXpUU1lhUo8Ex91WcTmhK5sPvDB5e2R53F7XG2xL
        fjMofeiUP29/vfxu/0W7zMdylqXMwf1MPqv3TWa7INWh35iwQSX5/lXJaff7Ar76i4tf4HlX
        tl/r57EJPezS7fKdtUosxRmJhlrMRcWJAJEoTg5IAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7ois8WjDa4d1rJo6njLarHvVD+L
        xZWv79ksDjReZrTY/P0Bq8XNd0/YLC7vmsPmwO7R9P4Ym8e8NdUel/t6mTzW9K5j87jffZzJ
        4+DJbkaPz5vkAtij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMy
        y1KL9O0S9DJuL/nCXLBFvmL7or2sDYxXJbsYOTkkBEwkJh37x9jFyMUhJLCUUaJ50SRGiIS4
        xO75b5khbGGJP9e62CCKXjNKtDy4xgaSEBYIkZhyexcLiC0i4CTxccM+JpAiZoELjBK9W1aA
        TRISmMwksXezP4jNJqAp8XfzTbBmXgE7ie3P1oLZLAIqEksnvWYFsUUFIiSa5q1hh6gRlDg5
        8wnYAk4BDYn+tRfA6pkF1CX+zLvEDGHLSzRvnQ1li0vcejKfaQKj0Cwk7bOQtMxC0jILScsC
        RpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgZG47djPLTsYu94FH2IU4GBU4uFd0S0WLcSa
        WFZcmXuIUYKDWUmEN/ESUIg3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgUkiryTe0NTQ3MLS
        0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QD4x72NZYpm1VrLqda/Ttj1ntm00Fu
        +ycX2jdXbraLnqJ7hNvg5g1P4UP/5qr+vON7XerKtH3PeLany25fFOD0TF+HZW1B29xYuUC2
        yxvcGjxO59yaOV9Iua5ZWMDs7JabBW/Yow70ra3b5ew1U2yG1RRRuSOLXR40dcWvmsyaXeu6
        qE7j/l2r90osxRmJhlrMRcWJAJx0uuraAgAA
Message-Id: <20180606082805eucas1p29c806a82abbd8bdb9879c83211976fb9~1hNHMfcIE0348503485eucas1p2R@eucas1p2.samsung.com>
X-CMS-MailID: 20180606082805eucas1p29c806a82abbd8bdb9879c83211976fb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180604194448epcas1p29627759e2d8c0b1388c6700a7da77a45
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180604194448epcas1p29627759e2d8c0b1388c6700a7da77a45
References: <CGME20180604194448epcas1p29627759e2d8c0b1388c6700a7da77a45@epcas1p2.samsung.com>
        <20180604194437.13790-1-eric@anholt.net>
        <20180605082532eucas1p21328ec5bea7d588c81480829f862bdfd~1NhnMydDJ0562405624eucas1p2l@eucas1p2.samsung.com>
        <87lgbtt6em.fsf@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2018 20:49, Eric Anholt wrote:
> Andrzej Hajda <a.hajda@samsung.com> writes:
>
>> On 04.06.2018 21:44, Eric Anholt wrote:
>>> We want the DSI PHY to be enabled and the DSI module clocked before a
>>> panel or bridge's prepare() function, since most DSI panel drivers
>>> with a prepare() hook are doing DCS transactions inside of them.
>>>
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>> Cc: Kevin Quigley <kevin@kquigley.co.uk>
>>> Cc: James Hughes <james.hughes@raspberrypi.org>
>>> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
>>> ---
>>>
>>> I'm not sure it makes sense to enable CRTCs before encoders on vc4 at
>>> all.  Why start scanning pixels before the encoder is ready to hear
>>> about VSTART?  However, this patch will hopefully unblock people
>>> trying to attach other panels to rpi
>> But this patch is about enabling encoder before panel/bridge prepare. Or
>> am I missing something.
>> Anyway I would be more precise here, MIPI-DSI bus is used for two things:
>> - control bus - accessing DSI device (configuration/detection,...),
>> - video data bus - sending video stream.
>>
>> I suspect in prepare/pre_enable phase of DSI panel/bridge only control
>> bus should be functional, video stream transfer does not make sense.
>> So the best solution (I guess) would be to split DSI-encoder enable
>> sequence into control bus enable and video transfer enable parts and
>> call the former before 1st transfer request from device and the latter
>> in encoder enable callback. Of course there will be a problem then with
>> disabling sequence, ie stopping video stream should be performed in
>> encoder's disable, but when we should disable control bus? If we do it
>> in encoder's disable callback we could not perform transfers in
>> post_disable cb of the bridge - in most cases (maybe all currently
>> present in kernel) it will work, but it does not look ideal.
>> All this recalls me discussion that hardwiring bridge callbacks into drm
>> core is problematic and maybe it would be better to call downstream
>> callbacks explicitly from upstream element - the callback order should
>> depend on the local bus protocol, and should not be fixed in drm core.
> It does seem like for DSI encoders they generally would need to be able
> to control when the call down to the bridge happens.  However, from my
> experience with panels, drivers are bad about calling both prepare and
> enable, if their particular panel only cares about one of them.  So, how
> about:
>
> - encoders can call drm_bridge_disable_midlayer_calls() (any naming
>   suggestions?) to flag this bridge as not wanting the calls from the
>   atomic helpers.
>
> - atomic helpers WARN if bridge midlayer_calls flag was set and
>   drm_bridge_pre_enable/enable/disable/post_disable failed to be called
>   by the encoder
>
> - drm_bridge_detach() clears disable_midlayer_calls flag for the next
>   encoder


I like the idea, I guess the flag should be placed in "struct
drm_bridge". Since I plan to propose flag to avoid device links in
panels/bridges maybe it would be good to set flags directly, or by
helper similar to irq_set_status_flags, instead of creating separate
helper for each flag.
I am not sure about warns from atomic helpers, maybe it would be enough
to track and verify state transitions of bridges similarly to the ones
proposed (and abandoned?) by Sean [1].

And little off-topic: all these duplication of
ideas/code/functionalities added to/from panels from/to bridges and this
crazy code:
    sink = drm_of_find_panel_or_bridge...
    if (sink is panel)
        do_something
    else if (sink is bridge)
        do_something_similar_but_with_different_functions
laying in multiple encoders/bridges, provokes me to raise again a
question, wouldn't be better to merge drm_bridge and drm_panel into one
drm_sink object.

[1]: https://marc.info/?l=dri-devel&m=150827480716580

Regards
Andrzej
