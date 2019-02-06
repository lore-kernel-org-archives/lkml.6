Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F90FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB10217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="axj13uwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfBFPre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:47:34 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:62024 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBFPrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:47:33 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190206154730epoutp01e26eca405b05d80de4e593db996d7593~A0Pt2JF1N3096730967epoutp01W;
        Wed,  6 Feb 2019 15:47:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190206154730epoutp01e26eca405b05d80de4e593db996d7593~A0Pt2JF1N3096730967epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549468050;
        bh=eNC6D6N0xRQ/OOCneAYnwI9kOLXNUX5o4yfEDCEYo+Y=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=axj13uwqTzbZBXRlfEnxpWV/j7WEJINHiRpU1HUJtAoVRvjrhO3xeMS/ZhbUK+i1X
         DeTIPBer9UUVD3NGyqAJBiMJ389ROFaKUp1xk0/I4AxqGV7sTp2jT++5WO8k0hztuu
         M/Ugk/lz1MUwHs7hlZEy7ctlDoEm/lVkEmjviMCo=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190206154729epcas1p275164272b0e480c8f893e46df40c68a3~A0Psx2Yic1341013410epcas1p2o;
        Wed,  6 Feb 2019 15:47:29 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.A6.04288.0910B5C5; Thu,  7 Feb 2019 00:47:29 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190206154727epcas1p26ea666eec2e64882e383b4b092c2ec65~A0Prrj9OV0572805728epcas1p2F;
        Wed,  6 Feb 2019 15:47:27 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-d8-5c5b0190f9b6
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.FD.04015.F810B5C5; Thu,  7 Feb 2019 00:47:27 +0900 (KST)
Received: from [106.116.147.40] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMI00G8ZH6Z0520@mmp1.samsung.com>; Thu, 07 Feb 2019 00:47:27 +0900 (KST)
Subject: Re: [PATCH] ASoC: dapm: Check for NULL widget in
 dapm_update_dai_unlocked
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <b61f2293-6f48-45f3-ad0b-42bc2a214a76@samsung.com>
Date:   Wed, 06 Feb 2019 16:47:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <20190206114545.GR3837@imbe.wolfsonmicro.main>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7bCmge5ExugYgx87mSyuXDzEZDH14RM2
        iyutmxgtzp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLzl39rBYbvq9ldODy2PC5ic1j56y7
        7B6bVnWyeUyf85/RY9/bZWwefVtWMXqs33KVxePzJrkAjigum5TUnMyy1CJ9uwSujBe/G5gL
        fvNWPP16gKWBcTJ3FyMHh4SAicS7O0FdjFwcQgI7GCVOHj7FCuF8Z5Q4sKaPvYuRE6yo7857
        ZojEbkaJyb1LGSGc+4wSLxduAqsSFgiRmD1lKSuILSIQLXFk8VwmkCJmgUNMEgsvXGUESbAJ
        GEr0Hu0Ds3kF7CR+TJzEBmKzCKhKXD98lQXEFhWIkDjc+w6qRlDix+R7YHFOAWuJFyeamEFs
        ZgFNiRdfJrFA2OISx+7fZISw5SU2r3kLdqqEwH82iY9THzNB/OAicWLtN2aIp6UlLh21hQhX
        S+za3g1V38Eo0XJhOzNEwlri8PGLrBBD+STefe1hhejllehoE4Io8ZDoW9zGAgmJ68wSnVd2
        s01glJmF5O5ZSG6dheTWWUhuXcDIsopRLLWgODc9tdiwwESvODG3uDQvXS85P3cTIzjFaFns
        YNxzzucQowAHoxIPb8CtqBgh1sSy4srcQ4wSHMxKIrxvnwGFeFMSK6tSi/Lji0pzUosPMUpz
        sCiJ8653cI4REkhPLEnNTk0tSC2CyTJxcEo1MIZOmGnXLnxuvoXFmu2PuqzXfVzd+/yS3eQH
        5uHHvq6TVvbZs/VnRHHJ3ab0KanTFklslRfS0sn8UZR0KmDJafdHaQ9z7SSLNr9lvpWWYvQ1
        vWLGkcalGqLcvJs5w2aeex7eaKYbt+jjPv4jnlEfc1/oruvlidi47dQ8wTC/YwI3/J2nb57l
        b6LEUpyRaKjFXFScCAAfe5j1LQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e+xgG4/Y3SMweGFphZXLh5ispj68Amb
        xZXWTYwW589vYLf4dqWDyeLyrjlsFjPO72OyWHvkLrtF565+VosN39cyOnB5bPjcxOaxc9Zd
        do9NqzrZPKbP+c/ose/tMjaPvi2rGD3Wb7nK4vF5k1wARxSXTUpqTmZZapG+XQJXxovfDcwF
        v3krnn49wNLAOJm7i5GTQ0LARKLvznvmLkYuDiGBnYwSy+81s0E4DxklNmxrZwSpEhYIkZg9
        ZSlrFyMHh4hAtMSLPy4gNcwCh5gk3l++zw7RcJNZ4tbzrWwgDWwChhK9R/vAmnkF7CR+TJwE
        FmcRUJW4fvgqC4gtKhAh8fHpPiaIGkGJH5PvgcU5BawlXpxoYgZZxiygLjFlSi5ImFlAXOLY
        /ZuMELa8xOY1b5knMArMQtI9C6FjFpKOWUg6FjCyrGKUTC0ozk3PLTYqMMxLLdcrTswtLs1L
        10vOz93ECIygbYe1+nYw3l8Sf4hRgINRiYc34FZUjBBrYllxZe4hRgkOZiUR3rfPgEK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5b+cdixQSSE8sSc1OTS1ILYLJMnFwSjUwOr/S+urc7xwk9Oev
        j+WGWJsD7Sd8J3Tof38kwHz/8456Q50HDzLkNwhqH9xZx2Bxbi9TTtHLs6Kb0hfFqtul/OgO
        NVvPPfHQhXmsKr639jXfiWKOcOc58eLhv0NVU09quJwPepZx91JHzMUVBxnqFot4C8g5Mtfl
        yn79Wy3v7XfV+/7RFsteJZbijERDLeai4kQA8ueiW5wCAAA=
X-CMS-MailID: 20190206154727epcas1p26ea666eec2e64882e383b4b092c2ec65
CMS-TYPE: 101P
X-CMS-RootMailID: 20190205211638epcas3p409823d4acac8073473153d745151ea5f
References: <CGME20190205211638epcas3p409823d4acac8073473153d745151ea5f@epcas3p4.samsung.com>
        <20190205211622.GA5891@kozik-lap>
        <844c3f34-f7db-6b26-169a-994922367c78@samsung.com>
        <20190206100549.GO3837@imbe.wolfsonmicro.main>
        <CAJKOXPejBO_9iBHg1R8M2=tcuTck72DjxTYEUyQOp8cPV-0xTg@mail.gmail.com>
        <20190206105955.GP3837@imbe.wolfsonmicro.main>
        <CAJKOXPcQfsNnuns1BprEPy4=ggW7fU+_-O_VksrWuT4GPPgAwg@mail.gmail.com>
        <20190206114545.GR3837@imbe.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/19 12:45, Charles Keepax wrote:
> Looking through I think this is an unrelated issue. Assuming the
> driver in question is (sound/soc/samsung/i2s.c). Inside
> i2s_trigger, there is a call to config_setup(i2s), which in turn
> will call clk_get_rate if i2s->quirks contains the flag
> QUIRK_NO_MUXPSR.
> 
> The trigger callback can be made from an atomic context and
> clk_get_rate will take the prepare lock of the clock. The clock
> prepare lock is always a mutex which shouldn't be locked from an
> atomic context. So it seems like this will fail whenever that
> QUIRK_NO_MUXPSR flag is set, no idea what causes that to be set.
> 
> It looks like this bug was introduced by this change:
> 
> 647d04f8e07a ("ASoC: samsung: i2s: Ensure the RCLK rate is properly determined")

Thanks or having a look at this. I somehow overlooked it before, there 
are multiple issues with that clk_get_rate() call.  Apart of the problem 
described above config_setup() is already called with the i2s->lock 
spinlock held, exactly same spinlock that is passed to the clock API 
when registering a clock of which we try to get rate. :/ Presumably 
it works due to clk rate caching.

Whether QUIRK_NO_MUXPSR flag is set or not depends on the HW type, 
it is not set for modern SoCs so most of the time we will hit the
problem in I2S master configurations.

As we are not using set_sysclk() of the CPU DAI I'm thinking about 
moving the clk_get_rate() call to the CPU DAI's hw_params() callback. 
The clock rate may be changed in hw_params() of an ASoC machine driver, 
and the CPU DAI needs to adjust to those changes.

It feels like locking in that driver might need revisiting, there is
quite a lot happening while holding a spinlock.

-- 
Thanks,
Sylwester
