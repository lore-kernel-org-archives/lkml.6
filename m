Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeE1EAC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 00:00:02 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:25069 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752967AbeE1D76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 23:59:58 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180528035957epoutp010843443773b6b09b3b96da68624f0f36~ysvbkFA3H1141311413epoutp01V
X-AuditID: b6c32a37-a71ff70000000fec-47-5b0b7ebac2a3
To: undisclosed-recipients:;
Mime-Version: 1.0
Subject: RE: [PATCH 02/11] PM / devfreq: Fix handling of min/max_freq == 0
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
CC: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180525203043.249193-3-mka@chromium.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180528035953epcms1p87bf2a4ec589bd860034032e091820f69@epcms1p8>
Date: Mon, 28 May 2018 12:59:53 +0900
X-CMS-MailID: 20180528035953epcms1p87bf2a4ec589bd860034032e091820f69
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmnu6uOu5og4ZjbBZ/Jx1jt9j08T2r
        xctDmhbXvzxntZh/5ByrxdllB9ksmhevZ7M42/SG3eLyrjlsFp97jzBaLL1+kcni84bHjBat
        e4+wO/B6rJm3htHj969JjB6zGy6yeGxa1cnmsX/uGnaPvi2rGD0+b5ILYI9KtclITUxJLVJI
        zUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulZJoSwxpxQoFJBYXKyk
        b2dTlF9akqqQkV9cYqsUbWhopGdoYK5nZASkjWOtjEyBShJSM/rfnWIpuMdd0bv3CmsD41HO
        LkZODgkBE4nOiyuYQGwhgR2MErd7TEFsEQEZibmzH7N2MXJw8AoISvzdIQxiCgt4SWy/6Q5R
        rSTRcHMfM4gtLKAv0fFgGyOIzSagK7F1w12WLkYuDmaBJSwSSzb+Z4RYxSsxo/0pC4QtLbF9
        +VawOKeAucSH881MEHFRiZur37LD2O+PzYfqFZFovXeWGcIWlHjwczdUXEriyduFUPX1Etc/
        L2ICWSwhMIFR4veN/1AJfYlHV2azgdi8Ar4S+x9+ATuCRUBVYvKco6wQNS4St49tAIszC8hL
        bH87hxnkYWYBTYn1u/Rh7m/Y+Jsdnc0swCfx7msPK0x8x7wnUL+oSRzavQSqXkbi9PSFUPd7
        SDTPnccygVFxFiJ0ZyFZPAth8QJG5lWMYqkFxbnpqcWGBcZ6xYm5xaV56XrJ+bmbGMEpVst8
        B+OGcz6HGAU4GJV4eBt+c0ULsSaWFVfmHmKU4GBWEuHl0gUK8aYkVlalFuXHF5XmpBYfYjQF
        +n8is5Rocj4w/eeVxBuaGhkbG1uYGJqZGhoqifO2mf+LEhJITyxJzU5NLUgtgulj4uCUamAM
        /773mHtXq0RIST7Dt1Vu7/b5uP71Sgwwuhm7VYNvdxhbv9SD9emHWY9UKp5au/vu5wwprjCD
        osKGsNTzpR7FP2U3GrrXrdQtWtfMt95mcor+Ka+Si4n78/Y6vM4RmXCoTGDBZsaiu3tfb0jI
        P5jFM0vx9ClhiZm7lnDECLLYcP1y3HZDrlGJpTgj0VCLuag4EQAPeffpxwMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180525203120epcas2p429d60dc21e16f0b53c58e7b1f942858f
References: <20180525203043.249193-3-mka@chromium.org>
        <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203120epcas2p429d60dc21e16f0b53c58e7b1f942858f@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the
> devfreq device") initializes df->min/max_freq with the min/max OPP when
> the device is added. Later commit f1d981eaecf8 ("PM / devfreq: Use the
> available min/max frequency") adds df->scaling_min/max_freq and the
> following to the frequency adjustment code:
> 
>   max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
> 
> With the current handling of min/max_freq this is incorrect:
> 
> Even though df->max_freq is now initialized to a value != 0 user space
> can still set it to 0, in this case max_freq would be 0 instead of
> df->scaling_max_freq as intended. In consequence the frequency adjustment
> is not performed:
> 
>   if (max_freq && freq > max_freq) {
> 	freq = max_freq;
> 
> To fix this set df->min/max freq to the min/max OPP in max/max_freq_store,
> when the user passes a value of 0. This also prevents df->max_freq from
> being set below the min OPP when df->min_freq is 0, and similar for
> min_freq. Since it is now guaranteed that df->min/max_freq can't be 0 the
> checks for this case can be removed.
> 
> Fixes: f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Thanks a lot! Nice Catch.

Acked-by: MyungJoo Ham <myunngjoo.ham@samsung.com>

Cheers,
MyungJoo.
