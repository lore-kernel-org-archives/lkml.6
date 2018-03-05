Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935120AbeCENZs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:25:48 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34079 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbeCENZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:25:44 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180305132542euoutp0105d3fabb9ef81ec240158486190e9c04~ZCRbKumWG2532025320euoutp018
X-AuditID: cbfec7f2-5ffe19c000011644-4d-5a9d454fc026
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: readl_poll_timeout return
 value clean up
To: Philippe CORNU <philippe.cornu@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, Heiko Stubner <heiko@sntech.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>
Cc: Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <8b47bb1d-ff1d-b85a-18ca-b53b70c1a32d@samsung.com>
Date: Mon, 5 Mar 2018 14:25:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <587f8a32-b9b3-0e81-d91d-69ea256bdc29@st.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHefZefDfaeJzGTipF60IJZULQi5ZEJb4fiqIv6Qht5puGbsrW
        TJPMLHNaXirKnFs1VJRIJe9ZUi3KSruXZRc3TMuSMbrMiry07U3y2++c53/+5/zhYQj5TyqI
        2avdx+u06jQlLSHb7/5+vGJrtEW16u5ZGVvy6L6IvTLci9h8o5Ni820PaPbbYBnNNn91UewL
        t4tmp4fGKNZy6iBbdLLGj23+0E+xz7vMHpljmmAdR0cptu/lTZItLCqg12OuKu8pyT0vLRFx
        V03v/bgqYyXFveu/TnMd4w6Ksx/vEXEtNYe4SdMNkuvoP09wI7+6Ce578/xtc1SStUl82t5M
        XhcWtUuS4njkojMaJFnj9VZRHiplipGYAbwahpzVZDGSMHJcj8B1rYEQih8IxloLKK9Kjr8j
        aLFGzEz0dR5GgqgOwY3ymn+FE8Fly0fCqwrAcXByosvnG4gtFNiOuny+BM5DcKTjnM+Xxsth
        smWA9rIUR0HJ5DjyMokXQ1Nxt4/n4liwnhlBgsYf7lcOe1wZRowj4FUd720TeAF0OM2EwAp4
        M3xB5N0FuJYBd/uAZ9bPU2wCc5yQIAC+9LT6CRwCvadPkALnwMBoPimMGhHY/xTSwkMk3O55
        SnnXEp6Tm7rChPY6uPe2wHcNYBm8dvoLF8jgVHsFIbSlYDwmF9QLwf6wjRBYAbVP3HQ5WmSa
        Fcs0K4tpVhbT/70XEXkJKXiDXpPM68O1/P6VerVGb9Amr9ydrmlGnu/YO9XzrRO5nyXaEGaQ
        co60U2tWySl1pj5bY0PAEMpAadA8i0ouTVJnH+B16Qk6Qxqvt6FghlQqpPHLclVynKzex6fy
        fAavm3kVMeKgPJTZvzF7Ije1Ozrkjswan3FP1hrcZt4aGCPOgomDCxN2hlMhb4siqnKrnpTv
        CIl1a6I/x2RN9To25By/vqf6a66jXZtoaVzDjU4PRiq2GNe8Dm382M1uN6Z8mjJsTqMrlgbc
        shaWrUrahqPF9rBgWEIe/mmoSB20fh6LmlpcGWpXkvoUdXgoodOr/wLEZ0xhigMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42I5/e/4XV1P17lRBiceyFv0njvJZLHxyWlG
        i6aOt6wWTYdOsVl8utfPZrHp43tWiytf37NZ/H/0mtVi7qRai86JS9gtNj2+xmpxedccoLIH
        /5ktHrS8YLU4c/UAi0V7Zyubg4DH7IaLLB6X+3qZPHbOusvuMbtjJqvHnWt72Dy2f3vA6nG/
        +ziTx+Yl9R5/Z+1n8dh+bR6zx9Mfe5k9Pm+SC+CJ0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAz
        MrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mt4cO49W8FaropvKxYyNTD2cXQxcnJICJhInNnR
        yAhiCwksZZRY/C4FIi4usXv+W2YIW1jiz7UuNoia14wS/ZNdQGxhgUiJWW2HWLoYuThEBOaz
        StxZO50dxGEWaGKU+PXwMTOIIySwmEni4bZN7CAtbAKaEn833wQbxStgJ9H79xvYahYBFYn1
        XXvBbFGBCInOlfNZIGoEJU7OfAJkc3BwClhJXF+eChJmFlCX+DPvEjOELS+x/e0cKFtc4taT
        +UwTGIVmIemehaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAhMCNuO/dyy
        g7HrXfAhRgEORiUeXoHCOVFCrIllxZW5hxglOJiVRHilJOdGCfGmJFZWpRblxxeV5qQWH2I0
        BfptIrOUaHI+MFnllcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpg
        rDlxyu5Xbo70GrclItM35X1a37lTeULxOtbAX5fs/mwpzX9dt1f8WeHVoJzTZR8+nja/c6vW
        l+lhxJqKaacv6V6d5Vn9aO/lhixmprtnmZW/TXXV3cufVhx95pZQ9mKf+NIbKbZ3Ocx/Zrcd
        cP52dm+p6s4VvnpMXOkzRHmS/hnmLNpSpix9QImlOCPRUIu5qDgRANk17CseAwAA
X-CMS-MailID: 20180305132533eucas1p1aefe38e25fb8c70ef884e90343a410c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180305132533eucas1p1aefe38e25fb8c70ef884e90343a410c8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180301090106epcas2p3c47f4436b0c8a31ce71cfd3909dc77ae
X-RootMTR: 20180301090106epcas2p3c47f4436b0c8a31ce71cfd3909dc77ae
References: <20180204213624.18288-1-philippe.cornu@st.com>
        <CGME20180301090106epcas2p3c47f4436b0c8a31ce71cfd3909dc77ae@epcas2p3.samsung.com>
        <172e7f68-8f4b-7e5f-3e9f-7aaf10a51dc9@st.com>
        <290c749a-70bf-2b74-1fb9-2de26708d001@samsung.com>
        <587f8a32-b9b3-0e81-d91d-69ea256bdc29@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.2018 14:15, Philippe CORNU wrote:
> Hi Andrzej,
>
>
> On 03/02/2018 11:21 AM, Andrzej Hajda wrote:
>> On 01.03.2018 10:00, Philippe CORNU wrote:
>>> Hi Archit, Andrzej & Laurent,
>>>
>>> May I ask you please your feedback on this small patch?
>>> Many thanks,
>>>
>>> Philippe :-)
>>>
>>> On 02/04/2018 10:36 PM, Philippe Cornu wrote:
>>>> The readl_poll_timeout() return value is 0 in case of success
>>>> so it is better to detect errors without taking care of the
>>>> return value sign.
>>>>
>>>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> The patch is of course correct. However I am not sure if necessary. For
>> sure functionally it does not change anything.
>> AFAIK kernel CodingStyle says nothing about it, so I suppose it is
>> matter of personal taste.
> I sent this tiny patch in order to homogenize the dw mipi driver because 
> there were both cases "if (ret)" & "if (ret < 0)" in the source code.
>
> I did not really find a preferred way in the kernel source code so I 
> selected what sounds the best to me ie "if (ret)" but it is not a 
> problem to make another patch for "if (ret < 0)" everywhere :-)
>
> In any case, the most important from my pov is to have a homogeneous 
> source code :-)

OK

Queued to drm-misc-next.

Regards
Andrzej
