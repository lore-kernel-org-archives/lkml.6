Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E55C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704CF21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qz9HzBGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbeLRMho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:37:44 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57678 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeLRMhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:37:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181218123742euoutp0212a393580aec65e8f35afd0917fa04c9~xbZu8p2rd2385423854euoutp02O
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 12:37:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181218123742euoutp0212a393580aec65e8f35afd0917fa04c9~xbZu8p2rd2385423854euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545136662;
        bh=OyBRWm0JJnobOY2Z5eCg8+D/ocDksLLUXcr4jGsmJSg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qz9HzBGeuth/oqu7EruSg8QOz87pyfP9irH7H41VvnlWHQcdJeNDeLgMVxp7XCqL7
         53Zcq2Lbb21D8Dzss92ZAobYYQHMKhnRe8OdxyKPAyn3rLZjwjmVgyj5AmbC4M5Hsw
         ShtquxcmcECTLDymDHXaPxEwEYQV0XndsKH4sqG0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181218123741eucas1p2f221cf36d0860cfbadd783ac0cfbeb02~xbZtxj_FP3061530615eucas1p2L;
        Tue, 18 Dec 2018 12:37:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 86.4D.04441.51AE81C5; Tue, 18
        Dec 2018 12:37:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181218123740eucas1p2aa6e1be00837c57319b0d06fc5ff3e4d~xbZs2FKoD1194711947eucas1p2f;
        Tue, 18 Dec 2018 12:37:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181218123740eusmtrp22679c11fe873495bb73e08bca8667476~xbZsnjsHf2146021460eusmtrp2Z;
        Tue, 18 Dec 2018 12:37:40 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-58-5c18ea152345
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BA.4B.04128.41AE81C5; Tue, 18
        Dec 2018 12:37:40 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181218123739eusmtip2be94f6e0f24be0d33c1dd1506db0619c~xbZsR8ead2039520395eusmtip2f;
        Tue, 18 Dec 2018 12:37:39 +0000 (GMT)
Subject: Re: [PATCH RFC v2 3/8] drm/meson: add support for HDMI2.0 2160p
 modes
To:     Neil Armstrong <narmstrong@baylibre.com>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <ee77da70-e16b-1d98-8169-8461ec3a3ff1@samsung.com>
Date:   Tue, 18 Dec 2018 13:37:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130134301.17963-4-narmstrong@baylibre.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djP87qiryRiDA5uEbRo6njLanHl63s2
        i86JS9gtFszmtri8aw6bxaG+aAc2j/c3Wtk9Lvf1MnnM7pjJ6nG/+ziTx+Yl9R6fN8kFsEVx
        2aSk5mSWpRbp2yVwZax/vpCp4AN7Rfft52wNjEfZuhg5OSQETCTeHPoJZHNxCAmsYJRY93kC
        M4TzhVHizIofUM5nRombT58zwbTcnbmFHSKxnFHifPdVFgjnLaPE+4lTwQYLCwRITH07gQXE
        FhHIlPjZt5QdxGYWSJO4NeMQK4jNJqAp8XfzTbB6XgE7iUndT8HqWQRUJX48/gZWLyoQIdFx
        fzVUjaDEyZlPwGo4BWwlOvbNY4GYKS/RvHU2M4QtLnHryXwmkIMkBFaxSxx5tZYZ4mwXiVML
        /7JD2MISr45vgbJlJP7vnA/1Wr1E08wrzBDNHYwSJxYvhwaTtcTh4xeBruYA2qApsX6XPkTY
        UeLD5i8sIGEJAT6JG28FIW7gk5i0bTozRJhXoqNNCKJaUeL+2a1Q14hLLL3wlW0Co9IsJJ/N
        QvLNLCTfzELYu4CRZRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZg+jn97/inHYxfLyUd
        YhTgYFTi4WU4IR4jxJpYVlyZe4hRgoNZSYT3VqlEjBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        aoYH0UIC6YklqdmpqQWpRTBZJg5OqQZGlpYzWwrtXz1cvXVnuDG3gNvTrBmJSbL3VpXMtmZ3
        2zon8H3gxIPZ1RfbdINKxY5OXrpOdlpjlFUfs06P14V1tuHnHZayG/Pv3r1GSrLLVv5l1Ll0
        AVvW+pazdpZKjrOrvfIzrHZ2fDE77fJgRyFPS1jx3PsHa01e7Ks6uODY7IdFi5tqO58rsRRn
        JBpqMRcVJwIAjgJSbTsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7oiryRiDGZ18lk0dbxltbjy9T2b
        RefEJewWC2ZzW1zeNYfN4lBftAObx/sbrewel/t6mTxmd8xk9bjffZzJY/OSeo/Pm+QC2KL0
        bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MtY/X8hU
        8IG9ovv2c7YGxqNsXYycHBICJhJ3Z25h72Lk4hASWMooseb9WxaIhLjE7vlvmSFsYYk/17rY
        IIpeM0rsPr6UCSQhLOAn8fj+QbBJIgKZEg+mXGQEsZkF0iT+PAVpBmk4zChxfv9LdpAEm4Cm
        xN/NN8EaeAXsJCZ1PwXbxiKgKvHj8TewGlGBCImzL9cxQtQISpyc+QSshlPAVqJj3zwWiAXq
        En/mXWKGsOUlmrfOhrLFJW49mc80gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE
        3OLSvHS95PzcTYzAiNt27OeWHYxd74IPMQpwMCrx8DKcEI8RYk0sK67MPcQowcGsJMJ7q1Qi
        Rog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgckgryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQ
        QHpiSWp2ampBahFMHxMHp1QDI+Pba8efTPNc4XTKpULfSpW32VL18OwNaz/8NWbKuPT0ufyc
        15O2Lre+byogURP5fNPSJouYuf+WcxwOq1p+qqRp/mFDZ4H5j1im5/B/3801r1Y9bvbuH4ed
        /Pv5P1qeq7v1rjJ/Z9COeJeYxGP9+85EMGUZmq9ynReesLHuXMFumS1VE9kKm5VYijMSDbWY
        i4oTAZwnlxTOAgAA
X-CMS-MailID: 20181218123740eucas1p2aa6e1be00837c57319b0d06fc5ff3e4d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181130134343epcas3p10313babda35e397cd1218af8ba3e1dbd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181130134343epcas3p10313babda35e397cd1218af8ba3e1dbd
References: <20181130134301.17963-1-narmstrong@baylibre.com>
        <CGME20181130134343epcas3p10313babda35e397cd1218af8ba3e1dbd@epcas3p1.samsung.com>
        <20181130134301.17963-4-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.2018 14:42, Neil Armstrong wrote:
> Now we support the TMDS Clock > 3.4GHz and support the SCDC Control
> operation in the DW-HDMI Controller, we can enable support for the
> HDMI2.0 3840x2160@60/50 RGB444 display modes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_venc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> index 0ba04f6813e6..66d73a932d19 100644
> --- a/drivers/gpu/drm/meson/meson_venc.c
> +++ b/drivers/gpu/drm/meson/meson_venc.c
> @@ -848,6 +848,8 @@ struct meson_hdmi_venc_vic_mode {
>  	{ 93, &meson_hdmi_encp_mode_2160p24 },
>  	{ 94, &meson_hdmi_encp_mode_2160p25 },
>  	{ 95, &meson_hdmi_encp_mode_2160p30 },
> +	{ 96, &meson_hdmi_encp_mode_2160p25 },
> +	{ 97, &meson_hdmi_encp_mode_2160p30 },
>  	{ 0, NULL}, /* sentinel */
>  };
>  

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

