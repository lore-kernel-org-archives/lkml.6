Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeBEIsC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:48:02 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49563 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752671AbeBEIrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:47:51 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180205084749euoutp02b764ac51e341b059a5b4ca0fd8d1d062~QYazLX81g3071430714euoutp02q
X-AuditID: cbfec7f1-f793a6d00000326b-0d-5a781a342249
Subject: Re: [PATCH] [BUGFIX] media: vb2: Fix videobuf2 to map correct area
To: Masami Hiramatsu <mhiramat@kernel.org>,
        Pawel Osciak <pawel@osciak.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        orito.takao@socionext.com, Fumihiro ATSUMI <atsumi@infinitegra.co.jp>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <2af9a288-86e8-100a-4459-bc913f3cb99d@samsung.com>
Date: Mon, 05 Feb 2018 09:47:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.5.2
MIME-version: 1.0
In-reply-to: <151779784111.20697.5012233804870630070.stgit@devbox>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7omUhVRBjdn81ncv7uEyeJs0xt2
        i8u75rBZ9GzYymqxbNMfJovFy9Us7t35wG4x5e1PdgcOjxUvPjN7bFrVyebx+NdLNo++LasY
        PU5M/87i8XmTXABbFJdNSmpOZllqkb5dAlfGlav/WArO8FU8Wj+fvYHxHXcXIyeHhICJxIN7
        G9ggbDGJC/fWA9lcHEICSxkl/kzfxwrhfGaUWNvUzwrTcX3aD2aIxDJGiQ/HjrNDOM8ZJTr6
        rjGCVAkLeEt03j7BAmKLCFRI7Gh7xARSxCywhVFi1sr3YAk2AUOJrrddYMt5Bewkti67D7aC
        RUBVYkHHT7BBogIxEv83zmSHqBGU+DH5Hlgvp4CTRPe+x2D1zAJWEs/+tULZ8hKb17xlhrDF
        JZpbb7KALJYQeMwmsaj5IQvEDy4S77/MY4awhSVeHd/CDmHLSHR2HGSCsPsZJZpatSHsGYwS
        597yQtjWEoePX4Raxicxadt0oDkcQHFeiY42IYgSD4mGGa+hxjhK9Hz8wgQJoamMEo++7GOf
        wCg/C8k/s5D8MAvJD7OQ/LCAkWUVo0hqaXFuemqxkV5xYm5xaV66XnJ+7iZGYPo5/e/4xx2M
        709YHWIU4GBU4uG1iC+PEmJNLCuuzD3EKMHBrCTC63QdKMSbklhZlVqUH19UmpNafIhRmoNF
        SZzXNqotUkggPbEkNTs1tSC1CCbLxMEp1cBo1FStzqe5covP2fj6d0IGBycLf5v/TytYsjHs
        6TKT9l1KM5XFFDkCD617sstDZ0v0oszdZsuKjygoHjti65a1eob3BbboB1t0vm5S/91fUC56
        cg/PgfRp16U29tasuVfZoZfv+saK11o6JEPvxp5FV3oOhtyu4Lj8Zu1EryuCm+W5NphcUDJV
        YinOSDTUYi4qTgQAY3e6KjsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t/xa7rGUhVRBgv79C3u313CZHG26Q27
        xeVdc9gsejZsZbVYtukPk8Xi5WoW9+58YLeY8vYnuwOHx4oXn5k9Nq3qZPN4/Oslm0ffllWM
        Hiemf2fx+LxJLoAtissmJTUnsyy1SN8ugSvjytV/LAVn+CoerZ/P3sD4jruLkZNDQsBE4vq0
        H8wQtpjEhXvr2UBsIYEljBLvP0R2MXIB2c8ZJU6ufAeWEBbwlui8fYIFxBYRqJB48foOI0gR
        s8AWRok9fVNZIDqmM0os+jGJCaSKTcBQouttF1g3r4CdxNZl91lBbBYBVYkFHT8ZQWxRgRiJ
        Bc2HmCFqBCV+TL4HtoFTwEmie99jsHpmATOJLy8PQ9nyEpvXvGWGsMUlmltvskxgFJyFpH0W
        kpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBSth37uXkH46WNwYcYBTgY
        lXh4LeLLo4RYE8uKK3MPMUpwMCuJ8DpdBwrxpiRWVqUW5ccXleakFh9ilOZgURLn7d2zOlJI
        ID2xJDU7NbUgtQgmy8TBKdXAOFv1kc2MV2lVTV19ktV7wsVMWL5IT1dbI7RhV8f5xzEtr3J3
        nSmyKPy4ZvbtmweeTow7MW9plEbErbmuHX2Xv4of+VO7Wr+nJoTXIX+etc+CG4n3PY+uOfB7
        9QehiX3atwMO2ywNNyz5+0Jh2dXNucWdm8IizTaXLFE9vWvlTYOd/Et+npg+z0KJpTgj0VCL
        uag4EQA8/pEVkAIAAA==
X-CMS-MailID: 20180205084747eucas1p1ce06b2b7a8180f2df8975a6ee05a475a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180205023108epcas5p18456b3ecc412b6709dc27fe5af14b1f6
X-RootMTR: 20180205023108epcas5p18456b3ecc412b6709dc27fe5af14b1f6
References: <CGME20180205023108epcas5p18456b3ecc412b6709dc27fe5af14b1f6@epcas5p1.samsung.com>
        <151779784111.20697.5012233804870630070.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On 2018-02-05 03:30, Masami Hiramatsu wrote:
> Fixes vb2_vmalloc_get_userptr() to ioremap correct area.
> Since the current code does ioremap the page address, if the offset > 0,
> it does not do ioremap the last page and results in kernel panic.
>
> This fixes to pass the page address + offset to ioremap so that ioremap
> can map correct area. Also, this uses __pfn_to_phys() to get the physical
> address of given PFN.
>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Takao Orito <orito.takao@socionext.com>
> ---
>   drivers/media/v4l2-core/videobuf2-vmalloc.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/v4l2-core/videobuf2-vmalloc.c b/drivers/media/v4l2-core/videobuf2-vmalloc.c
> index 3a7c80cd1a17..896f2f378b40 100644
> --- a/drivers/media/v4l2-core/videobuf2-vmalloc.c
> +++ b/drivers/media/v4l2-core/videobuf2-vmalloc.c
> @@ -106,7 +106,7 @@ static void *vb2_vmalloc_get_userptr(struct device *dev, unsigned long vaddr,
>   			if (nums[i-1] + 1 != nums[i])
>   				goto fail_map;
>   		buf->vaddr = (__force void *)
> -				ioremap_nocache(nums[0] << PAGE_SHIFT, size);
> +			ioremap_nocache(__pfn_to_phys(nums[0]) + offset, size);

Thanks for reporting this issue. However the above line doesn't look like
a proper fix. Please note that at the end of that function there is already
"buf->vaddr += offset;".

IMHO the proper fix is to create a larger mapping, which would include the
in-page start offset:

ioremap_nocache(__pfn_to_phys(nums[0]), offset + size);

BTW, thanks for updating "<< PAGE_SHIFT" to better __pfn_to_phys() macro!

>   	} else {
>   		buf->vaddr = vm_map_ram(frame_vector_pages(vec), n_pages, -1,
>   					PAGE_KERNEL);
>
>
>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
