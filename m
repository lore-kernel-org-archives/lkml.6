Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B42C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516702084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZTa2ElwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516702084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbeJ2RvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:51:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57267 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbeJ2RvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:51:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181029090327euoutp02d4bb284e1d088664c3bceeee2ad68683~iCOZW-WZo2237322373euoutp02W
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:03:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181029090327euoutp02d4bb284e1d088664c3bceeee2ad68683~iCOZW-WZo2237322373euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1540803807;
        bh=tbAvd0hhl3/rClXQjXy6nTgh18OqP/lNA6O2r37YXCU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZTa2ElwQq6Ls2Pqf1bfR+DTqsubkt2Ebk7JVMDXdBbPAYQnQiukxDh1dAJdwY48+1
         KQNH39lw+PxjrtQSVccdb5i9tRZlccNPgLMhqXxM8jWk1dCStXmG/cfu+6H5Kbz6Xw
         igFjIkst8BnUz6vY4Lhb/C7ynzNdm+s4mgzkjkmw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181029090327eucas1p142045d4c4b273c3336b3e680a42abb6d~iCOYh47yf0458904589eucas1p1z;
        Mon, 29 Oct 2018 09:03:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0F.F8.04294.EDCC6DB5; Mon, 29
        Oct 2018 09:03:26 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181029090326eucas1p2cc9332612ef5ce14e6a9ac924a7f972e~iCOXypLq92150321503eucas1p2a;
        Mon, 29 Oct 2018 09:03:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181029090325eusmtrp197a79a3c85a5aa11ddecb8d4ba4f8729~iCOXdObrF2428624286eusmtrp1Q;
        Mon, 29 Oct 2018 09:03:25 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-9c-5bd6ccde411d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0A.B9.04128.DDCC6DB5; Mon, 29
        Oct 2018 09:03:25 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181029090325eusmtip26a72a512a951c5d0df12fd80d5298e8b~iCOW9cp9B1838418384eusmtip2U;
        Mon, 29 Oct 2018 09:03:25 +0000 (GMT)
Subject: Re: [PATCH v2 4/6] drm/bridge: ti-sn65dsi86: Remove the mystery
 delay
To:     Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        Archit Taneja <architt@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <f3f86ecf-0d97-1b6b-e638-1780fef929f4@samsung.com>
Date:   Mon, 29 Oct 2018 10:03:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025222134.174583-4-dianders@chromium.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djP87r3zlyLNnixXsei99xJJoumjres
        FmeXHWSzuPL1PZvF1lUrmC06Jy5ht5i4/yy7xeVdc9gsdt74ympxd8NZRouG3hZ2i5+75rE4
        8HjMbrjI4nG5r5fJY+esu+wesztmsnps//aA1eN+93Emj8+b5ALYo7hsUlJzMstSi/TtErgy
        zt3cyFJwR7zi9ATbBsaPQl2MHBwSAiYSd1ZodjFycQgJrGCU6OjZwgzhfGGUOL59CyOE85lR
        YsL5V2xdjJxgHctu72OCSCxnlJj+5iIrSEJI4C2jROcbRhBbWCBAYvOU02DdIgJLGSWOTb0P
        1sEsMI1J4vrl2WAdbAKaEn833wQbyytgJ/GgcxsLiM0ioCpxbk8b2CRRgQiJIw8WMkLUCEqc
        nPkErIZTwEai42YbWC+zgLxE89bZzBC2uMStJ/PBlkkI3GOXaP/+kBnibheJ53NPQNnCEq+O
        b2GHsGUkTk/uYYGw6yWaZl5hhmjuYJQ4sXg51NPWEoePg/zJAbRBU2L9Ln2IsKPE06ZfrJCQ
        5JO48VYQ4gY+iUnbpjNDhHklOtqEIKoVJe6f3Qp1gbjE0gtf2SYwKs1C8tksJN/MQvLNLIS9
        CxhZVjGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgQmstP/jn/ZwbjrT9IhRgEORiUe3gfc
        16KFWBPLiitzDzFKcDArifD2ngYK8aYkVlalFuXHF5XmpBYfYpTmYFES5102b2O0kEB6Yklq
        dmpqQWoRTJaJg1OqgbHs6MMJS36tOhB/syL//faWz+w75qQWrH06Y3Z5wev43tCS/rbvAh8V
        Hy8ofLa34uf7XBXDupvcpTdDKjpln185liJ7WvaJbl6XTK/o1cIdMRGGnYd52fYc3/dn9/yt
        PGmqyVXHqy1XfKyLq5+foBYf/+avs9/kPTsZXqdOOtqa5h+0cs3cNkElluKMREMt5qLiRACq
        4LGbYAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xe7p3z1yLNui8Y2jRe+4kk0VTx1tW
        i7PLDrJZXPn6ns1i66oVzBadE5ewW0zcf5bd4vKuOWwWO298ZbW4u+Eso0VDbwu7xc9d81gc
        eDxmN1xk8bjc18vksXPWXXaP2R0zWT22f3vA6nG/+ziTx+dNcgHsUXo2RfmlJakKGfnFJbZK
        0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZ525uZCm4I15xeoJtA+NHoS5G
        Tg4JAROJZbf3MXUxcnEICSxllJjyYQUbREJcYvf8t8wQtrDEn2tdbBBFr4GKnn0GKxIW8JO4
        s/QhO0hCBKT7Ye8JFhCHWWAak8TEV9NYIVoOMkq0bzvLDtLCJqAp8XfzTbB2XgE7iQed21hA
        bBYBVYlze9oYQWxRgQiJ1ctfsELUCEqcnPkErIZTwEai42YbWC+zgLrEn3mXmCFseYnmrbOh
        bHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzB+
        tx37uWUHY9e74EOMAhyMSjy8D7ivRQuxJpYVV+YeYpTgYFYS4e09DRTiTUmsrEotyo8vKs1J
        LT7EaAr03ERmKdHkfGBqySuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fE
        wSnVwBhdGm3vdG3xOt9DXjHyUmbMZlJvCtZyBSw/teY6u+2jl4lTLPYZLMr6wGLRtva7e4qg
        kNbn4mk3F8+6KnaN/4F0YVaTV/my0Lw3p/rt+QrYvlcdZpHa1v7o5eKbCVkfNF3ypkpN1v8w
        Xfh1apr3C9XlB31YjsTc5C/d1HcuJV9cN2GljlO3jxJLcUaioRZzUXEiAOZnYc31AgAA
X-CMS-MailID: 20181029090326eucas1p2cc9332612ef5ce14e6a9ac924a7f972e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181025222215epcas4p23fe857a510ce3d42d69bddc363f96978
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181025222215epcas4p23fe857a510ce3d42d69bddc363f96978
References: <20181025222134.174583-1-dianders@chromium.org>
        <CGME20181025222215epcas4p23fe857a510ce3d42d69bddc363f96978@epcas4p2.samsung.com>
        <20181025222134.174583-4-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.2018 00:21, Douglas Anderson wrote:
> Let's solve the mystery of commit bf1178c98930 ("drm/bridge:
> ti-sn65dsi86: Add mystery delay to enable()").  Specifically the
> reason we needed that mystery delay is that we weren't paying
> attention to HPD.
>
> Looking at the datasheet for the same panel that was tested for the
> original commit, I see there's a timing "t3" that times from power on
> to the aux channel being operational.  This time is specced as 0 - 200
> ms.  The datasheet says that the aux channel is operational at exactly
> the same time that HPD is asserted.
>
> Scoping the signals on this board showed that HPD was asserted 84 ms
> after power was asserted.  That very closely matches the magic 70 ms
> delay that we had.  ...and actually, in my testing the 70 ms wasn't
> quite enough of a delay and some percentage of the time the display
> didn't come up until I bumped it to 100 ms (presumably 84 ms would
> have worked too).
>
> To solve this, we tried to hook up the HPD signal in the bridge.
> ...but in doing so we found that that the bridge didn't report that
> HPD was asserted until ~280 ms after we powered it (!).  This is
> explained by looking at the sn65dsi86 datasheet section "8.4.5.1 HPD
> (Hot Plug/Unplug Detection)".  Reading there we see that the bridge
> isn't even intended to report HPD until 100 ms after it's asserted.
> ...but that would have left us at 184 ms.  The extra 100 ms
> (presumably) comes from this part in the datasheet:
>
>> The HPD state machine operates off an internal ring oscillator. The
>> ring oscillator frequency will vary [ ... ]. The min/max range in
>> the HPD State Diagram refers to the possible times based off
>> variation in the ring oscillator frequency.
> Given that the 280 ms we'll end up delaying if we hook up HPD is
> _slower_ than the 200 ms we could just hardcode, for now we'll solve
> the problem by just hardcoding a 200 ms delay in the panel driver
> using the patch in this series ("drm/panel: simple: Support panels
> with HPD where HPD isn't connected").
>
> If we later find a panel that needs to use this bridge where we need
> HPD then we'll have to come up with some new code to handle it.  Given
> the silly debouncing in the bridge chip, though, it seems unlikely.
>
> One last note is that I tried to solve this through another way: In
> ti_sn_bridge_enable() I tried to use various combinations of
> dp_dpcd_writeb() and dp_dpcd_readb() to detect when the aux channel
> was up.  In theory that would let me detect _exactly_ when I could
> continue and do link training.  Unfortunately even if I did an aux
> transfer w/out waiting I couldn't see any errors.  Possibly I could
> keep looping over link training until it came back with success, but
> that seemed a little overly hacky to me.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Sean Paul <sean@poorly.run>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
