Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbeDPNDD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:03:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50467 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbeDPNDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:03:00 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180416130258euoutp0186276a4bc500676ba6f7bc0f255b3abc~l7DjlDCBr2192521925euoutp01f
X-AuditID: cbfec7f2-5ffe19c000011644-89-5ad49eff0fca
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 02/14] thermal: exynos: Propagate error value from
 tmu_read()
Date: Mon, 16 Apr 2018 15:02:50 +0200
Message-ID: <1533276.iHnOBFtKQV@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <4123d3bb-408f-b0c0-43c3-862e93f4907a@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRT2t3t3dzecXafhQctoYC/wRf1xe2hCpiNQjP7zj2y1i1o69V5d
        ahA+wGfaNLOcpqa0dGKaiakNiSlKWA6fKc3MlCwzDGdRGJnbneR/3/nOOd/3HTgkJmsVepLx
        6lSGVSsT5IQE7xr8bfbdrJ2IDlga8aVrrXvpuokpIX174StGm83tInq8t4agrSUDiL5v7hPQ
        rQOzInpxvpQIESt6dLMiRaPxi0DRYSgkFJYpI6Eo7TQghbXDO4qIlpxSMQnxGob1D74kifvw
        qwklr+9KbzFNYlnoo3MREpNAHYOxCgtWhCSkjGpCMPinHvHFOoLih9VCvrAiqMhdw7dXLA3Z
        jpXHCN4/a3EU3xG8WJoT2KYI6gSU5RuQDbtTfpC9miewDWFUnQBGihvtUm7UBZhv29xqkCRO
        +UC+Ns1GS6nDMNR5l7Dh3dQ56OzLt2uKqWDQv60S8jOu8Kpq0S6DUfugYDzbHhWoLhE0VD4R
        8VFDoWJmWcBjN1ge6nTwe2D4zi2cX8hF8LPbiPENLQJjm4zHJ6F/aFRoC4dtJWrr9efpIKgr
        WhHZaKBcYPqbK5/BBcq77mE8LYWCPIfIAWjXtxPbrkU9zQ4jBTTPlONaJNftuEa34xrdf996
        hBmQB5PGJcYyXKCaue7HKRO5NHWs35WkxA609UTDf4fWutGPscsmRJFI7iztfjMeLRMqNVxG
        ogkBicndpXrlFiVVKTMyGTYphk1LYDgT8iJxuYf04qGb0TIqVpnKXGOYZIbd7gpIsWcWMnrn
        PaWPp3+O9FL5H5S1709hX6Y8b+xonRH3bfSv6kO5ekt1qldeAJ4jmYxyP7sRMXqeYMIL/fCY
        yDndjVxTgZM0Z8JwNVMTTh31WVk4bVYFsS2T6c2v5QOj2WxJchhhLHO2Bk0HVD7SaC01Wn05
        HRJBhvWeeWd98MkpeVmOc3HKwCMYyyn/AYrz7htAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xu7p/512JMpg1mddi3mdZi/lXrrFa
        9D9+zWxx/vwGdovLu+awWXzuPcJoMeP8PiaLtUfusls8edjH5sDpsXPWXXaPxXteMnlsWtXJ
        5nHn2h42j74tqxg9Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
        t7NJSc3JLEst0rdL0Mt48GMFY8EX/orVh64yNzA+4uli5OSQEDCRuLOokbmLkYtDSGApo8Sd
        a6uBHA6ghIzE8fVlEDXCEn+udbFB1LxjlHh54BYbSIJNwEpiYvsqRhBbREBPovF9GxOIzSww
        k0ni5ipNEFtYIFDi9Yp7YDNZBFQl2ieUgoR5BTQljm+ZCjZGVMBLYsu+drBWTgE7iWXXZ7KC
        2EICMxklJqxTgKgXlDg58wkLxHh5iY7LjawQto7Egt2f2CYwCs5CUjYLSdksJGULGJlXMYqk
        lhbnpucWG+oVJ+YWl+al6yXn525iBEbXtmM/N+9gvLQx+BCjAAejEg/vjrOXo4RYE8uKK3MP
        MUpwMCuJ8C5LBArxpiRWVqUW5ccXleakFh9iNAX6bSKzlGhyPjDy80riDU0NzS0sDc2NzY3N
        LJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MMbdqawTdU1dYsGjX791ww7ZBzsbNLlv51zX
        UNbyychUXPG2hO+f5eO7DAVBT0uOu3z5d8Nop55UfcCU+D73kLNfLSvYJma5MrOZFHRqKDqo
        t/H8jVJb6Glgn1o9MTX/xyLXZQX/cj+uPfBpw5Szq16vbSo9nvaW7cujY61TvJb6mwawL8zd
        qMRSnJFoqMVcVJwIACg1dHzEAgAA
X-CMS-MailID: 20180416130254eucas1p24732958e5b202cacaddc69cde747a478
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416130254eucas1p24732958e5b202cacaddc69cde747a478
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180416130254eucas1p24732958e5b202cacaddc69cde747a478
X-RootMTR: 20180416130254eucas1p24732958e5b202cacaddc69cde747a478
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <21168314.MLeXVVoknU@amdc3058>
        <4123d3bb-408f-b0c0-43c3-862e93f4907a@linaro.org>
        <CGME20180416130254eucas1p24732958e5b202cacaddc69cde747a478@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 16, 2018 02:54:01 PM Daniel Lezcano wrote:
> On 16/04/2018 14:49, Bartlomiej Zolnierkiewicz wrote:
> > On Monday, April 16, 2018 02:41:48 PM Daniel Lezcano wrote:
> >> On 16/04/2018 14:35, Bartlomiej Zolnierkiewicz wrote:
> >>> On Monday, April 16, 2018 02:16:56 PM Daniel Lezcano wrote:
> >>>> On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> >>>>> From: Marek Szyprowski <m.szyprowski@samsung.com>
> >>>>>
> >>>>> tmu_read() in case of Exynos4210 might return error for out of bound
> >>>>> values. Current code ignores such value, what leads to reporting critical
> >>>>> temperature value. Add proper error code propagation to exynos_get_temp()
> >>>>> function.
> >>>>
> >>>> For me the comment in the function exynos4210_tmu_read
> >>>>
> >>>> /* "temp_code" should range between 75 and 175 */
> >>>>
> >>>> ... is strange. I would double check this assertion before dealing with
> >>>> the error value.
> >>>
> >>> static int exynos4210_tmu_read(struct exynos_tmu_data *data)
> >>> {
> >>> 	int ret = readb(data->base + EXYNOS_TMU_REG_CURRENT_TEMP);
> >>>
> >>> 	/* "temp_code" should range between 75 and 175 */
> >>> 	return (ret < 75 || ret > 175) ? -ENODATA : ret;
> >>> }
> >>>
> >>
> >> But I don't get why it *should* ?
> > 
> > Because of hardware design.
> > 
> >> Shouldn't be the same with the 4412, it seems having the same sensor, no?
> > 
> > Probably same limitations apply to all SoCs (Exynos4412 has very similar
> > sensor) but the driver currently lacks the needed checks for them (it is
> > on TODO but other things have higher priority).
> 
> 
> I understand. Why the other boards are not reporting a critical value?

->tmu_read methods for other SoCs currently lack hardware limitations
checking so they don't return negative values (which before fix was passed
to code_to_temp() unchecked and was mapped to critical temperature value).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
