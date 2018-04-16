Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755407AbeDPMRz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:17:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49199 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755396AbeDPMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:17:50 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180416121748euoutp02ab60e524aa1d11e92a1089c02b70ca98~l6cIWHDmX2259122591euoutp028
X-AuditID: cbfec7f5-b5fff700000028a9-25-5ad4946a6026
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 01/14] thermal: exynos: Reading temperature makes sense
 only when TMU is turned on
Date: Mon, 16 Apr 2018 14:17:44 +0200
Message-ID: <60958515.5KCaPvLZ9i@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <a49d9651-bb52-85bc-ffc0-2ba012e66dd5@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7pZU65EGXzcrWMx77Osxfwr11gt
        +h+/ZrY4f34Du8XlXXPYLD73HmG0mHF+H5PF2iN32S2ePOxjc+D02DnrLrvH4j0vmTw2repk
        87hzbQ+bR9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGWcXfGOteAdV8X1LT+ZGhgbOLsYOTkk
        BEwkTu/dxtLFyMUhJLCCUaJ/+j1mCOcLo0TXzXNQmc+MEjde7mWCaXn79wwTRGI5o8SSg5eh
        nA+MEm/erGADqWITsJKY2L6KEcQWEdCTaHzfBlbELDCfSeJc92IWkISwQIbEtnM/wcayCKhK
        XOleD9bMK6AlcXfNOmYQW1TAS2LLvnawGk4BO4nnR44xQ9QISpyc+QRsDrOAvETH5UZWkAUS
        ArvYJZoXXGCDuNVFYsmlZcwQtrDEq+Nb2CFsGYnTk3tYIBqaGSW+7dgDVTSBUWLPeiEI21ri
        8PGLQFM5gDZoSqzfpQ8RtpV40XuTGSQsIcAnceOtIMQNfBKTtk2HCvNKdLRBDVGT2LBsAxvM
        1q6dK6EWeUg8mtvFNoFRaRaSb2Yh+WYWwt4FjMyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLz
        czcxAlPR6X/Hv+5g3Pcn6RCjAAejEg/vjrOXo4RYE8uKK3MPMUpwMCuJ8C5LBArxpiRWVqUW
        5ccXleakFh9ilOZgURLnjdOoixISSE8sSc1OTS1ILYLJMnFwSjUwOtSfNbbbZi8dmJN7auZF
        TpeHgSf5pkvNb03y4J/u3O6fVGx95U5B1jTRrX9EjVv/ftl47LVim3aK2tcYnm0by/Xmd6l2
        hj1elD9jMfuVeVxmJ7fHbinQDWYRPZY/nduJfxNzYE/ptZaIkwVlnCskdt60TvvNeLhmi9EJ
        76xV6YcafvnrLapXYinOSDTUYi4qTgQA8MJCzUEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7qZU65EGZx4aWox77Osxfwr11gt
        +h+/ZrY4f34Du8XlXXPYLD73HmG0mHF+H5PF2iN32S2ePOxjc+D02DnrLrvH4j0vmTw2repk
        87hzbQ+bR9+WVYwenzfJBbBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GWcXfGOteAdV8X1LT+ZGhgbOLsYOTkkBEwk3v49w9TFyMUhJLCUUeJu
        83MghwMoISNxfH0ZRI2wxJ9rXWwQNe8YJX6efsoMkmATsJKY2L6KEcQWEdCTaHzfxgRiMwvM
        ZJK4uUoTxBYWSJM48PYcK4jNIqAqcaV7PRuIzSugJXF3zTqwOaICXhJb9rWD9XIK2Ek8P3KM
        GWLZdkaJx+1z2CEaBCVOznzCArFAXqLjciMrhK0jsWD3J7YJjIKzkJTNQlI2C0nZAkbmVYwi
        qaXFuem5xUZ6xYm5xaV56XrJ+bmbGIERtu3Yzy07GLveBR9iFOBgVOLh3XH2cpQQa2JZcWXu
        IUYJDmYlEd5liUAh3pTEyqrUovz4otKc1OJDjKZA301klhJNzgdGf15JvKGpobmFpaG5sbmx
        mYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBsZzy2JTpfSyrlsc+pgZrfc64at5V823VRfv
        zGW4zPbyupjy7E1qPVK/F/39fnfiad+pawS2B54+dUfqseabzmdvqjkfvit765n7fPqh20Gh
        ixPUZu/MLGCa5bmOeZFJ2M6mDxw7VPhtjpydp/vi4omAdKObJxlqVOd9K3aZO6cmeJX0Y/Ul
        0Q48SizFGYmGWsxFxYkAzRaUAcYCAAA=
X-CMS-MailID: 20180416121746eucas1p1de1cf16bcf7d8fdccd87ac41db735ef6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416121746eucas1p1de1cf16bcf7d8fdccd87ac41db735ef6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180416121746eucas1p1de1cf16bcf7d8fdccd87ac41db735ef6
X-RootMTR: 20180416121746eucas1p1de1cf16bcf7d8fdccd87ac41db735ef6
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <1523873525-23718-2-git-send-email-b.zolnierkie@samsung.com>
        <a49d9651-bb52-85bc-ffc0-2ba012e66dd5@linaro.org>
        <CGME20180416121746eucas1p1de1cf16bcf7d8fdccd87ac41db735ef6@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 16, 2018 02:06:41 PM Daniel Lezcano wrote:
> On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> > From: Marek Szyprowski <m.szyprowski@samsung.com>
> > 
> > When thermal sensor is not yet enabled, reading temperature might return
> > random value. This might even result in stopping system booting when such
> > temperature is higher than the critical value. Fix this by checking if TMU
> > has been actually enabled before reading the temperature.
> > 
> > This change fixes booting of Exynos4210-based board with TMU enabled (for
> > example Samsung Trats board), which was broken since v4.4 kernel release.
> 
> Why not move the thermal_zone_of_sensor_register *after* initializing
> the sensor ?

For initializing the sensor we need data obtained from
therm_zone_of_sensor_register() so it cannot be easily
done (especially since we also want the fix to be
ported to -stable kernels). For more detailed description
please see:

https://lkml.org/lkml/2018/4/10/376

> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Fixes: 9e4249b40340 ("thermal: exynos: Fix first temperature read after registering sensor")
> > CC: stable@vger.kernel.org # v4.6+
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
