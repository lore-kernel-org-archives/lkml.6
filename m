Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4A72177B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GdAeuNXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392503AbfBOLcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:32:21 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:51548 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfBOLcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:32:21 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190215113218epoutp020ec99a38cf675666673d2dd0225dbe6b~Dhkdv6lQS0123501235epoutp025;
        Fri, 15 Feb 2019 11:32:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190215113218epoutp020ec99a38cf675666673d2dd0225dbe6b~Dhkdv6lQS0123501235epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550230338;
        bh=gd7qhnhNgZz+Mmeewa7vBvl/HT5ywV8LItRlSs+QjLI=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=GdAeuNXGIQqGTTtRDx8Y9KtkRgGh2Er/6NMZAjWw5ayTNAUGenccFf6Zu4MXjy4fo
         Evy4+Tm4NMbAAb1L/vfL52QiEg5DJ3r3gLP9m1fUCCN5vpJXjayTN8HiurJoNw/BSY
         taQPYe5yQyIFVqcPQGdXinWYM3Ner4x3egYl7Ylg=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190215113217epcas2p14db0582d0087209a931662ded10a5c46~DhkdQiWiN0261502615epcas2p1m;
        Fri, 15 Feb 2019 11:32:17 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.90.04134.143A66C5; Fri, 15 Feb 2019 20:32:17 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190215113217epcas2p3c4d51bd6095c910e33d9de08decfb6e4~Dhkc6Pa2T1377113771epcas2p3F;
        Fri, 15 Feb 2019 11:32:17 +0000 (GMT)
X-AuditID: b6c32a47-8abff70000001026-4e-5c66a341c2f2
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.A1.03689.143A66C5; Fri, 15 Feb 2019 20:32:17 +0900 (KST)
Received: from [106.116.147.40] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMY00H3BTDPMU60@mmp1.samsung.com>; Fri, 15 Feb 2019 20:32:17 +0900 (KST)
Subject: Re: [PATCH] ASoC: samsung: odroid: Ensure proper sample rate on
 pri/sec PCM
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <54683fa7-6a07-5706-5b8a-ce7be5d02646@samsung.com>
Date:   Fri, 15 Feb 2019 12:32:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <CAJKOXPd20QPjvEV_TzKi8fcJM-Ws4Te6W0ZRvzNVt2c-60VKAQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7bCmua7j4rQYg9P9ihZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XaI3fZLS6u+MLkwO6x4XMTm8fOWXfZPTat6mTz6NuyitHj8ya5
        ANYoLpuU1JzMstQifbsEroxJZ5uYC3ZwVmzr3czYwPiSvYuRg0NCwESiY4JoFyMXh5DADkaJ
        1RNmskM43xklujYeZ+xi5AQr2vV6KhtEYjejRP+d50wQzn1GiZttx1lAqoQFwiT6Z+1iBhkr
        IhAhsX0lO0iYWaBWYsKfr6wgNpuAoUTv0T6wobwCdhLz38xjArFZBFQl5nZcZAOxRYFaD/e+
        g6oRlPgx+R7YeE6BYImG1f9YIGZqSrz4MgnKFpc4dv8mI4QtL7F5zVtmkNskBM6wScw5fpoN
        4gMXicVdy1khbGmJZ6s2Qn1WLbFrezdUQwejRMuF7cwQCWuJw8cvskJM5ZPoOPwXGl68Eh1t
        QhAlHhILnnZDQ+Uqo8Sn9Q9ZJjDKzEJy+Cwkx85CcuwsJMcuYGRZxSiWWlCcm55abFRgrFec
        mFtcmpeul5yfu4kRnCS03Hcwbjvnc4hRgINRiYd3RUZqjBBrYllxZe4hRgkOZiUR3sIZaTFC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeR9Kz40WEkhPLEnNTk0tSC2CyTJxcEo1MO6PLdP69aZY
        aabSuoZsnm2/+/l3/r2rxCR2eysXy9+VzPG7DLc9/Xh9173Nm9T+/N+lUzl9xbfNqkJiJh61
        L/cqXXDzu3ytxUZuRdG1LqasWyr7j4T26XQ8Pe25MGpl7z3V169+pT1L9F7h3a3R5Dx79c+r
        bVseR789f6nuE+/ar8d/7dW4ESOmxFKckWioxVxUnAgAHMxWdA4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsVy+t9jAV3HxWkxBge7uS2uXDzEZDH14RM2
        i/PnN7BbfLvSwWRxedccNou1R+6yW1xc8YXJgd1jw+cmNo+ds+6ye2xa1cnm0bdlFaPH501y
        AaxRXDYpqTmZZalF+nYJXBmTzjYxF+zgrNjWu5mxgfElexcjJ4eEgInErtdT2boYuTiEBHYy
        SqxqOc4KkhASeMgosXmRLYgtLBAm0T9rFzOILSIQIfH6zj0WEJtZoFZiT8tdFojm64wSvTMn
        gyXYBAwleo/2MYLYvAJ2EvPfzGMCsVkEVCXmdlxkA7FFgQZ9fLqPCaJGUOLHZIihnALBEtvP
        /QeyOYAWqEtMmZILsUtc4tj9m4wQtrzE5jVvmScwCsxC0j0LoWMWko5ZSDoWMLKsYpRMLSjO
        Tc8tNiowykst1ytOzC0uzUvXS87P3cQIjIFth7X6dzA+XhJ/iFGAg1GJh3dFRmqMEGtiWXFl
        7iFGCQ5mJRHewhlpMUK8KYmVValF+fFFpTmpxYcYpTlYlMR5+fOPRQoJpCeWpGanphakFsFk
        mTg4pRoY3fyi2lxWbprIeCjZT1dbvVA1ply2pS2J/cRRqRT/DbNubl5uqNWn/MegcP/Hpw/y
        D7Ee45ogfTFD/2lS0MVbrM85Td55PDd4t2iXzG/TYMOoK599ZXb9eXLb/lt6sufs8IXlXKUf
        qy15NnPkMvM/EGZflSEb8zHBeL3PlY/v94uH7np5/wmjEktxRqKhFnNRcSIAtnhEK30CAAA=
X-CMS-MailID: 20190215113217epcas2p3c4d51bd6095c910e33d9de08decfb6e4
CMS-TYPE: 102P
X-CMS-RootMailID: 20190214160039epcas2p34b9e3b3ca5f9b0aa1fb5ed59403a6fe1
References: <CGME20190214160039epcas2p34b9e3b3ca5f9b0aa1fb5ed59403a6fe1@epcas2p3.samsung.com>
        <20190214160011.3940-1-s.nawrocki@samsung.com>
        <CAJKOXPd20QPjvEV_TzKi8fcJM-Ws4Te6W0ZRvzNVt2c-60VKAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 08:24, Krzysztof Kozlowski wrote:
> Is this the fix for
> "aplay: set_params:1403: Unable to install hw params:"
> which appeared in today's next (so after your last round of patches get merged)?
> https://krzk.eu/#/builders/1/builds/3093/steps/24/logs/stdio

No, but I have just prepared a fix for that one. I should have done
sound playback/recording test for a scenario without DTS updates rather
than just looking at card initialization completion.
Without DTS changes there will be 1 or 2 DAPM routes missing. I'm going to
post a patch adding missing DAPM routes in the card driver for backwards
compatibility.

> Also, since yesterday (so with previous rounds of patches) the audss
> rebind freezes entire kernel:
> https://krzk.eu/#/builders/1/builds/3093/steps/25/logs/stdio
> https://krzk.eu/#/builders/1/builds/3093/steps/25/logs/serial0
> 
> It is not important test but it was always passing in my suite.

The reason might be that I used platform_device_del() rather than
platform_device_unregister(). I will post other fix I have for scenario 
with multiple "multi-I2S" devices, it should also be a solution for 
that rebind issue.

-- 
Regards,
Sylwester
