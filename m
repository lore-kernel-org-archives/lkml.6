Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeC1N4b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:56:31 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:23890 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbeC1N42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:56:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180328135626epoutp0298f16ef6896376aed480a7b3c315809a~gGh0xlHKn1256712567epoutp02k
X-AuditID: b6c32a36-f57ff70000000fc2-f5-5abb9f0a5662
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: exynos_tmu: avoid uninitialized variables
Date: Wed, 28 Mar 2018 15:56:23 +0200
Message-id: <11114909.7eTX8MzZjF@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180328134520.1970967-1-arnd@arndb.de>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7bCmni7X/N1RBleP8Vn8nXSM3WL+lWus
        Fv2PXzNbnD+/gd1i02Mg9/KuOWwWn3uPMFrMOL+PyWLBy1ssFmuP3GW3ePKwj82B2+P3r0mM
        Hjtn3WX3WLznJZPHplWdbB6bl9R79G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV0bXs5XsBe84
        Klp+f2NsYDzA3sXIySEhYCLR9mQycxcjF4eQwA5GiWez/kM53xklLvRNZoWp2rzrBztEYjej
        xNeZz1ghnK+MEjcvrmcEqWITsJKY2L4KzBYRUJSY+uIZ2ChmgbdMEpM+XgBbKCzgLrHuyncm
        EJtFQFWi78oZoAYODl4BLYnPG3VAwqICXhJb9rWDlXAKmEoc6JwNNpNXQFDix+R7LCA2s4C8
        xL79U1khbB2Js8fWMYLskhB4zSbR9+8YC8TZLhI9M34yQdjCEq+Ob2EH2SUhIC1x6agtRH0z
        o8S3HXuYIWomMErsWS8EYVtLHD5+EWoBn8S7rz2sEL28Eh1tUCUeEv9/90PD0VHi49lL0BDq
        YJQ4ffE5ywRG2VlI7p6F5O5ZSO5ewMi8ilEstaA4Nz212LDASK84Mbe4NC9dLzk/dxMjOMFo
        me1gXHTO5xCjAAejEg9vQcyuKCHWxLLiytxDjBIczEoivO81dkcJ8aYkVlalFuXHF5XmpBYf
        YpTmYFES5w0IcIkSEkhPLEnNTk0tSC2CyTJxcEo1MBqUTmmc+eu/bOpF68Kqnz3MFieOSKfz
        dq1tX/yrmPPOYvGPOn1lCZWmN5lOizV7/riRePHgjx2CE7aL2jmaFTAGidq8+v+c5UllxHmL
        HQrJs7Nfm80xfLH0rXP8ynW7AxkWiD2rdOzp3xNvP+GsRfcxm4A7D48Ye11tVJ3ifur8vWyB
        pYKeRUosxRmJhlrMRcWJAAmQmMQsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsVy+t9jAV3O+bujDNbstLH4O+kYu8X8K9dY
        Lfofv2a2OH9+A7vFpsdA7uVdc9gsPvceYbSYcX4fk8WCl7dYLNYeuctu8eRhH5sDt8fvX5MY
        PXbOusvusXjPSyaPTas62Tw2L6n36NuyitHj8ya5APYoLpuU1JzMstQifbsEroyuZyvZC95x
        VLT8/sbYwHiAvYuRk0NCwERi864fQDYXh5DATkaJHb8PMEI4Xxkl9m3tAatiE7CSmNi+ihHE
        FhFQlJj64hkzSBGzwHsmiVPX5rKAJIQF3CXWXfnOBGKzCKhK9F05A9TAwcEroCXxeaMOSFhU
        wEtiy752sBJOAVOJA52zoZZ1MUrMWHODGSTBKyAo8WPyPbCZzALyEvv2T2WFsLUk1u88zjSB
        kX8WkrJZSMpmISlbwMi8ilEytaA4Nz232KjAMC+1XK84Mbe4NC9dLzk/dxMjMCa2Hdbq28F4
        f0n8IUYBDkYlHt6CmF1RQqyJZcWVuYcYJTiYlUR432vsjhLiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOezvvWKSQQHpiSWp2ampBahFMlomDU6qB0VWEV9Ar6XDCYqXLB8UiZqZn/ah/qrtwlsmq
        jtVGU/6G7HwUkj/pRd/EzQz+136tUc1oYNupwWy6avrp67+WVucwyRy98jruqtyDWF1tjie3
        d/hzV0YqXmrQvhnyRnvlnPnTvmw2/1h4MftmssSL6nyOi13bjsv/fVnBNed1+0LBLHG7z76b
        wpRYijMSDbWYi4oTAZ3qz52FAgAA
X-CMS-MailID: 20180328135626epcas1p23eea4008cf896f6f3f0918bd7d872e3c
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180328134538epcas2p4bb7a1f273824995e4baeb10d9563ffda
X-RootMTR: 20180328134538epcas2p4bb7a1f273824995e4baeb10d9563ffda
References: <CGME20180328134538epcas2p4bb7a1f273824995e4baeb10d9563ffda@epcas2p4.samsung.com>
        <20180328134520.1970967-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 28, 2018 03:44:44 PM Arnd Bergmann wrote:
> Removing the initialization in the error case introduced
> a compile-time warning:
> 
> drivers/thermal/samsung/exynos_tmu.c: In function 'temp_to_code':
> drivers/thermal/samsung/exynos_tmu.c:304:9: error: 'temp_code' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   return temp_code;
>          ^~~~~~~~~
> drivers/thermal/samsung/exynos_tmu.c: In function 'exynos_get_temp':
> drivers/thermal/samsung/exynos_tmu.c:931:37: error: 'temp' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    *temp = code_to_temp(data, value) * MCELSIUS;
> 
> Let's assume the runtime warning is sufficient, and make it
> return a well-defined number instead of unintialized data.
> 
> Fixes: 480b5bfc16e1 ("thermal: exynos: remove parsing of samsung, tmu_default_temp_offset property")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd!

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
