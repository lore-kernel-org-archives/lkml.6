Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751084AbeBFAGH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 19:06:07 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:61688 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeBFAFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 19:05:50 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180206000548epoutp0147ca4201230465a0a3ebba95d681aaf4~Qk8TXZLKJ2261522615epoutp01e
X-AuditID: b6c32a39-47fff70000000fc5-34-5a78f15b3df3
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A78F15B.30707@samsung.com>
Date: Tue, 06 Feb 2018 09:05:47 +0900
From: Inki Dae <inki.dae@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Arnd Bergmann <arnd@arndb.de>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] drm/exynos: g2d: use monotonic timestamps
In-reply-to: <20180117170131.2677586-1-arnd@arndb.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmrm70x4oogxebNCx6z51ksvg76Ri7
        xZWv79ksXty7yGLR//g1s8X58xvYLc42vWG32PT4GqvF5V1z2CxmnN/HZLH2yF12ixmTX7JZ
        tK3+wOrA6/H71yRGj02rOtk8tn97wOpxv/s4k8fmJfUe/46xe/RtWcXo8XmTXABHVKpNRmpi
        SmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtDFSgpliTmlQKGA
        xOJiJX07m6L80pJUhYz84hJbpWhDQyM9QwNzPSMjIz0T41grI1OgkoTUjI0X9jIVdItVPFhy
        mb2BsVWoi5GTQ0LAROLbyn62LkYuDiGBHYwSPb09TBDOd0aJ9gfb2GGqnj+ZA1W1gVFiXs8K
        sASvgKDEj8n3WLoYOTiYBeQljlzKBgkzC2hKvPgyiQXEFhK4xyhxZ2EYRLmGxO7Ji5lAylkE
        VCUeHnEHCbMBmRNX3GcDsUUFIiR2zv/GDrJKRKCbSeLGn0msIA6zwBtGib2HtjOCVAkLOEts
        f3aXGcTmFDCVOPJyNwvEoc3sEgfOVkLYLhLPJ5yCigtLvDq+hR1ksYSAtMSlo7YgMyUE2hkl
        dp29zgbh9DBKLF+8COpjY4lnC7uYIL7hk3j3tYcVoplXoqMNGnQeEhuXrGWFsB0lDr7cyw4J
        oA5GiQ/77rNPYJSdhRRGsxBhNAspjBYwMq9iFEstKM5NTy02LDDVK07MLS7NS9dLzs/dxAhO
        l1qWOxiPnfM5xCjAwajEwyuQURElxJpYVlyZe4hRgoNZSYTX6Xp5lBBvSmJlVWpRfnxRaU5q
        8SFGU2AYT2SWEk3OB6byvJJ4QxNLAxMzI2CSsjQ0VBLnDQhwiRISSE8sSc1OTS1ILYLpY+Lg
        lGpgVLJu1H6W7GWTtP1KLVNgdnWWgJz6Kf9flw4fmmbRbrJkoifbXlWVBe3Pw8WEbAP5jkp9
        Enl9a6bFY1eb526K1kFFh/7FVTwN+yqy9mHFx+dVMtEXjN+VFW/p/r/toeuimR3/Lh6O2C5y
        wfrznf6fQk8ClxqyVJx9b5L67sHZ7qtq8zKmGnuHK7EUZyQaajEXFScCADMYilStAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsVy+t9jQd3ojxVRBqv3Sln0njvJZPF30jF2
        iytf37NZvLh3kcWi//FrZovz5zewW5xtesNusenxNVaLy7vmsFnMOL+PyWLtkbvsFjMmv2Sz
        aFv9gdWB1+P3r0mMHptWdbJ5bP/2gNXjfvdxJo/NS+o9/h1j9+jbsorR4/MmuQCOKC6blNSc
        zLLUIn27BK6MjRf2MhV0i1U8WHKZvYGxVaiLkZNDQsBE4vmTOWxdjFwcQgLrGCW+r2ljB0nw
        CghK/Jh8j6WLkYODWUBe4silbAhTXWLKlFyI8geMEkfm/mSGKNeQ2D15MRNIDYuAqsTDI+4g
        YTYgc+KK+2wgYVGBCInuE5UgrSIC3UwSmxcvYQJxmAXeMEocffuTEaRBWMBZYvuzu8wQC7oY
        JXauARnKycEpYCpx5OVulgmM/LOQnDcL4bxZCOctYGRexSiZWlCcm55bbFRgmJdarlecmFtc
        mpeul5yfu4kRGCfbDmv17WC8vyT+EKMAB6MSD29GVkWUEGtiWXFl7iFGCQ5mJRFep+vlUUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5b+cdixQSSE8sSc1OTS1ILYLJMnFwSjUwWvh8Ec4pf65n
        cIYt/pJtdacmp8PCO9PFtikovVpZfe7p5ssfRAMXKop3NKRlPRIXKZVIrmew0Z1WLvbkqf6r
        +S+fnapsW2H3Y9393IyCg76fI6fUKdprObbbu8jpnNh1U8VxzlF7s5YNN/zkl1yUmNHXquJ6
        dm30nl3WBbuUxc7slD23fRO3EktxRqKhFnNRcSIAUV0Rx48CAAA=
X-CMS-MailID: 20180206000547epcas1p2a052f5add7febaf22283e7b469e5f091
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180117170211epcas5p12a9b274b2b0d0b0522c909be3644eebb
X-RootMTR: 20180117170211epcas5p12a9b274b2b0d0b0522c909be3644eebb
References: <CGME20180117170211epcas5p12a9b274b2b0d0b0522c909be3644eebb@epcas5p1.samsung.com>
        <20180117170131.2677586-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



2018년 01월 18일 02:01에 Arnd Bergmann 이(가) 쓴 글:
> The exynos DRM driver uses real-time 'struct timeval' values
> for exporting its timestamps to user space. This has multiple
> problems:
> 
> 1. signed seconds overflow in y2038
> 2. the 'struct timeval' definition is deprecated in the kernel
> 3. time may jump or go backwards after a 'settimeofday()' syscall
> 4. other DRM timestamps are in CLOCK_MONOTONIC domain, so they
>    can't be compared
> 5. exporting microseconds requires a division by 1000, which may
>    be slow on some architectures.
> 
> The code existed in two places before, but the IPP portion was
> removed in 8ded59413ccc ("drm/exynos: ipp: Remove Exynos DRM
> IPP subsystem"), so we no longer need to worry about it.
> 
> Ideally timestamps should just use 64-bit nanoseconds instead, but
> of course we can't change that now. Instead, this tries to address
> the first four points above by using monotonic 'timespec' values.
> 
> According to Tobias Jakobi, user space doesn't care about the
> timestamp at the moment, so we can change the format. Even if
> there is something looking at them, it will work just fine with
> monotonic times as long as the application only looks at the
> relative values between two events.
> 
> Link: https://patchwork.kernel.org/patch/10038593/
> Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Picked it up.

Thanks,
Inki Dae

> ---
> v2: rebased to what will be in 4.15, now that ipp is gone,
>     updated changelog text based on input from Tobias.
> ---
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> index 2b8bf2dd6387..9effe40f5fa5 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -926,7 +926,7 @@ static void g2d_finish_event(struct g2d_data *g2d, u32 cmdlist_no)
>  	struct drm_device *drm_dev = g2d->subdrv.drm_dev;
>  	struct g2d_runqueue_node *runqueue_node = g2d->runqueue_node;
>  	struct drm_exynos_pending_g2d_event *e;
> -	struct timeval now;
> +	struct timespec64 now;
>  
>  	if (list_empty(&runqueue_node->event_list))
>  		return;
> @@ -934,9 +934,9 @@ static void g2d_finish_event(struct g2d_data *g2d, u32 cmdlist_no)
>  	e = list_first_entry(&runqueue_node->event_list,
>  			     struct drm_exynos_pending_g2d_event, base.link);
>  
> -	do_gettimeofday(&now);
> +	ktime_get_ts64(&now);
>  	e->event.tv_sec = now.tv_sec;
> -	e->event.tv_usec = now.tv_usec;
> +	e->event.tv_usec = now.tv_nsec / NSEC_PER_USEC;
>  	e->event.cmdlist_no = cmdlist_no;
>  
>  	drm_send_event(drm_dev, &e->base);
> 
