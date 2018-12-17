Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5443C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982C62145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H7LLt6XN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbeLQLrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:47:36 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:55395 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeLQLrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:47:36 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181217114732epoutp024cd57cf04365060541115826221148f2~xHEo4_J2V1131511315epoutp02C;
        Mon, 17 Dec 2018 11:47:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181217114732epoutp024cd57cf04365060541115826221148f2~xHEo4_J2V1131511315epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545047252;
        bh=ncdbedac4qRKZRte3d1O0ToPR7ASDw+/zF612ndXhEg=;
        h=From:Subject:To:Cc:Date:In-reply-to:References:From;
        b=H7LLt6XNGRxrzM92v0BsMfXfkVO1oXBGLCVCsrcHsXlsaIyyyLwCMyj58uSwhsdrq
         Cp4XfwbIsswiLIUuLirYvjkui4xjldQx6V5ZdE+E2z5BHCqsFVbPJrCLmrNvpwxIeB
         GrlBBtBho1O6mcLHmUDJ5PpVf4lB52ucmGslFTg0=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181217114731epcas2p191fdcc9250fd6194294a0841ae88d445~xHEodIp5F1769317693epcas2p1Y;
        Mon, 17 Dec 2018 11:47:31 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.7C.04062.3DC871C5; Mon, 17 Dec 2018 20:47:31 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20181217114731epcas2p3c20eea9fbfd1078be41efd456b7b0c73~xHEnzvDnI3165231652epcas2p3V;
        Mon, 17 Dec 2018 11:47:31 +0000 (GMT)
X-AuditID: b6c32a47-2f7ff70000000fde-3e-5c178cd33dde
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.08.03627.2DC871C5; Mon, 17 Dec 2018 20:47:31 +0900 (KST)
Received: from [106.116.147.40] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJV00ELYQ33GT00@mmp1.samsung.com>; Mon, 17 Dec 2018 20:47:30 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] ARM: dts: exynos: Specify I2S assigned clocks in proper
 node
To:     Greg KH <greg@kroah.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Message-id: <e47cd3e3-2861-859c-1d95-90bd325c3b5b@samsung.com>
Date:   Mon, 17 Dec 2018 12:47:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-version: 1.0
In-reply-to: <20181214065900.GA22664@kroah.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZdljTTPdyj3iMwdV72hbzj5xjtTi3YAaj
        xfnzG9gtNj2+xmpxedccNosZ5/cxWbTuPcJusWDjI0YHDo9NqzrZPN4+DPDYvKTe4/MmuQCW
        KC6blNSczLLUIn27BK6M7TfvMhcs46vY9OIXWwPjU+4uRk4OCQETiS2zL7N1MXJxCAnsYJS4
        13KVGSQhJPCdUWJtnwRM0dHt/ewQ8d2MEnuvikA03GeU+LnpMSNIgk3AUKL3aB+YLSwQLPHx
        3QImEFtEwFlix47P7CANzAJbGSX2n14BNolXwE7iwIHZQEUcHCwCqhItXUUgYVGBCImO+6vZ
        IEoEJX5MvscCYnMK6Es8XP8LbCazgKbEiy+TWCBscYlj928yQtjyEpvXvGUG2SUhcJlNonvp
        IRaQ+RICLhJT7rpDPCMs8er4FnYIW1ri2aqNjBB2tcSu7d1QvR2MEi0XtjNDJKwlDh+/yAqx
        gE+i4/BfdoiZvBIdbUIQJR4Sk7e/YIUEyhVQoGxlm8AoOwvJD7OQ3D0Lyd2zkNy9gJFlFaNY
        akFxbnpqsVGBsV5xYm5xaV66XnJ+7iZGcNrQct/BuO2czyFGAQ5GJR7eC3vEYoRYE8uKK3MP
        MUpwMCuJ8PZaAoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzPpSeGy0kkJ5YkpqdmlqQWgSTZeLg
        lGpg3LP7CyvfBLPt9789mC6261SngsicpcUevkvvXuC4nn7obfBXzsrmCBW3+yL9b9iWlM5f
        y53SuXH/3liPnR8eicZo8OfPfMr6tE/7wd9ZtyLOsrz4oyjW9Gr5U48nnI89a4zUz8V0/44v
        WFuhtIHVdaPZveM2M1c5JO6zd+G/93Ei29zExXtUapRYijMSDbWYi4oTAV/qZvQXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t9jAd3LPeIxBt0vmSzmHznHanFuwQxG
        i/PnN7BbbHp8jdXi8q45bBYzzu9jsmjde4TdYsHGR4wOHB6bVnWyebx9GOCxeUm9x+dNcgEs
        UVw2Kak5mWWpRfp2CVwZ22/eZS5Yxlex6cUvtgbGp9xdjJwcEgImEke397N3MXJxCAnsZJS4
        /fANI0hCSOAho8Sjp7YgNpuAoUTv0T6wuLBAsMTHdwuYQGwRAWeJHTs+gzUzC2xllLj3Zzcr
        xKRrjBKXJ/5kBaniFbCTOHBgNlAHBweLgKpES1cRSFhUIELi7Mt1jBAlghI/Jt9jAbE5BfQl
        Hq7/BVbOLKAuMWVKLkiYWUBc4tj9m4wQtrzE5jVvmScwCsxC0j0LoWMWko5ZSDoWMLKsYpRM
        LSjOTc8tNiowykst1ytOzC0uzUvXS87P3cQIDP9th7X6dzA+XhJ/iFGAg1GJh/fCHrEYIdbE
        suLK3EOMEhzMSiK8vZZAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rz8+ccihQTSE0tSs1NTC1KL
        YLJMHJxSDYyr2lSN++7kcRik7bsq0jvPldOlg7PE43aK4LKV/l+rp+yTfjOrv23NOe81H9vC
        Nj0oTnI6sss25vunxyVZDTrvNlnk3zY3fryfK8uIce1Unz93T9t08cRf3s7HJGQvuHbhH6+2
        AlX/xxr2tWtVV3Bn7bItPnKN8dretW7LMvIqPp1i6Lyc9lqJpTgj0VCLuag4EQDd+Z27ewIA
        AA==
X-CMS-MailID: 20181217114731epcas2p3c20eea9fbfd1078be41efd456b7b0c73
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181212175813epcas2p26f7ec0e0e5e90d1e9cb7aeccd273e0ab
References: <CGME20181212175813epcas2p26f7ec0e0e5e90d1e9cb7aeccd273e0ab@epcas2p2.samsung.com>
        <20181212175744.8287-1-s.nawrocki@samsung.com>
        <20181213205656.GA799@kozik-lap> <20181214065900.GA22664@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 07:59, Greg KH wrote:
> On Thu, Dec 13, 2018 at 09:56:56PM +0100, Krzysztof Kozlowski wrote:
>> On Wed, Dec 12, 2018 at 06:57:44PM +0100, Sylwester Nawrocki wrote:
>>> The assigned parent clocks should be normally specified in the consumer
>>> device's DT node, this ensures respective driver always sees correct clock
>>> settings when required.
>>>
>>> This patch fixes regression in audio subsystem on Odroid XU3/XU4 boards
>>> that appeared after commits:
>>>
>>> 'commit 647d04f8e07a ("ASoC: samsung: i2s: Ensure the RCLK rate is properly determined")'
>>> 'commit 995e73e55f46 ("ASoC: samsung: i2s: Fix rclk_srcrate handling")'
>>> 'commit 48279c53fd1d ("ASoC: samsung: i2s: Prevent external abort on exynos5433 I2S1 access")'
>>>
>>> Without this patch the driver gets wrong clock as the I2S function (op_clk)
>>> clock in probe() and effectively the clock which is finally assigned from DT
>>> is not being enabled/disabled in the runtime resume/suspend ops.
>>>
>>> Without the above listed commits the EXYNOS_I2S_BUS clock was always set
>>> as parent of CLK_I2S_RCLK_SRC regardless of DT settings so there was no issue
>>> with not enabled EXYNOS_SCLK_I2S.
>>>
>>> Cc: stable@vger.kernel.org # v4.17+
>>
>> I gues your format would work (got recognized by stable scripts) but
>> strictly speaking format is different:
>>
>> 	Cc: <stable@vger.kernel.org> # 4.17.x
>>
>> https://elixir.bootlin.com/linux/latest/source/Documentation/process/stable-kernel-rules.rst#L127
>>
>> Thanks, fixed and applied.

Thanks for correcting this, indeed I just looked at existing usage 
in git log rather than at the documentation.

> Either works just fine, my scripts have to be a bit flexible due to all
> of the odd ways people like to tag things here...

-- 
Regards,
Sylwester
