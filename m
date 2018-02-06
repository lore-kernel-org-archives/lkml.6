Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeBFINp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 03:13:45 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60864 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeBFINf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 03:13:35 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180206081332euoutp02f72db94c091d3953a02d7cadb0379c4c~QrmKGN7DR0376703767euoutp02v
X-AuditID: cbfec7f1-f793a6d00000326b-0a-5a7963abcf7a
Subject: Re: [PATCH v2] media: vb2: Fix videobuf2 to map correct area
To: Masami Hiramatsu <mhiramat@kernel.org>,
        Pawel Osciak <pawel@osciak.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        orito.takao@socionext.com, Fumihiro ATSUMI <atsumi@infinitegra.co.jp>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <cd355844-89d0-b49a-0244-c0e45fc68724@samsung.com>
Date: Tue, 06 Feb 2018 09:13:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <151790414344.19507.15297848847845554616.stgit@devbox>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7qrkyujDGbe07S4f3cJk8XZpjfs
        Fpd3zWGz6NmwldVi2aY/TBaLl6tZ3Lvzgd1iytuf7A4cHitefGb22LSqk83j8a+XbB59W1Yx
        epyY/p3F4/MmuQC2KC6blNSczLLUIn27BK6M9pUf2Qq+8VTM/f6ctYFxD1cXIweHhICJxL9f
        Ol2MnECmmMSFe+vZuhi5OIQEljJKrDp+Fcr5zCix4c1NRogqE4lXO+9BJZYxSjxsfsYE4Txn
        lNh+YTkLSJWwgKvEyYMnmEFsEYEKiR1tj8CKmAW2MErMWvkerIhNwFCi620XG4jNK2Ancb7p
        DjuIzSKgKvH0djcbyH2iAjESr/+4QZQISvyYfA+slVPAWaL90SdWEJtZwEri2b9WKFteYvOa
        t8wQtrhEc+tNFpC9EgL32SQW3L/ODvGCi8T9E3dYIGxhiVfHt0DFZSQuT+6GivczSjS1akPY
        Mxglzr3lhbCtJQ4fvwi1jE9i0rbpzJBw5JXoaBOCKPGQ+P12I9QYR4meHTvAbCGBaYwSf0+4
        TWCUn4XknVlIXpiF5IVZSF5YwMiyilEktbQ4Nz212EivODG3uDQvXS85P3cTIzDxnP53/OMO
        xvcnrA4xCnAwKvHw7kitiBJiTSwrrsw9xCjBwawkwut0vTxKiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOK9tVFukkEB6YklqdmpqQWoRTJaJg1OqgbH0w/0ctslrikv7u+zfHvT73iTrGhu181il
        RsmKqsYE0f/5elZrWZJj557N7uedunVmQfqSu/E53+z/50gzb9nWLhBZ98KK39i3K6n5A5Om
        6r/Hngzuapt+eMQpVNtOPNRmwq/H9uB1y9bNYQnfrJqPMMXXNIi98rf8a/u2xrHD/XD0zPkh
        SizFGYmGWsxFxYkA3SBF5jgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsVy+t/xy7qrkyujDN438Vvcv7uEyeJs0xt2
        i8u75rBZ9GzYymqxbNMfJovFy9Us7t35wG4x5e1PdgcOjxUvPjN7bFrVyebx+NdLNo++LasY
        PU5M/87i8XmTXABbFJdNSmpOZllqkb5dAldG+8qPbAXfeCrmfn/O2sC4h6uLkZNDQsBE4tXO
        e2wQtpjEhXvrgWwuDiGBJYwStxa+ZYVwnjNKnDu4lR2kSljAVeLkwRPMILaIQIXEi9d3GEGK
        mAW2MErs6ZvKAtExA6h9538mkCo2AUOJrrddYDt4BewkzjfdAZvEIqAq8fR2N1hcVCBGYurH
        jawQNYISPybfYwGxOQWcJdoffQKLMwuYSXx5eRjKlpfYvOYtM4QtLtHcepNlAqPgLCTts5C0
        zELSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBsbLt2M8tOxi73gUfYhTgYFTi
        4d2RWhElxJpYVlyZe4hRgoNZSYTX6Xp5lBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe8waVUUIC
        6YklqdmpqQWpRTBZJg5OqQbGuVrdU+xu7WXU0riyW7Nk5px/p0PkU06/MhRmenkhw+eXqeT+
        RoMTt8r+SzoXp28piz7pmK16QmLjxGOr9d5pxWqoX3JZprx3FvOb5ca1EY/KHE0mzVMtWV1i
        b8h62qsvg3evY0KB33ZJlYuVRpOsQiRmMDqqHVeqE3W7+Vjvm5KItkNq5B4lluKMREMt5qLi
        RADmhZtMkQIAAA==
X-CMS-MailID: 20180206081331eucas1p1946d1bb958133d78fa16515f7c3538e8
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180206080251epcas1p2845745f8edcb71fcce8babcd0c5c4f3a
X-RootMTR: 20180206080251epcas1p2845745f8edcb71fcce8babcd0c5c4f3a
References: <CGME20180206080251epcas1p2845745f8edcb71fcce8babcd0c5c4f3a@epcas1p2.samsung.com>
        <151790414344.19507.15297848847845554616.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On 2018-02-06 09:02, Masami Hiramatsu wrote:
> Fixes vb2_vmalloc_get_userptr() to ioremap correct area.
> Since the current code does ioremap the page address, if the offset > 0,
> it does not do ioremap the last page and results in kernel panic.
>
> This fixes to pass the size + offset to ioremap so that ioremap
> can map correct area. Also, this uses __pfn_to_phys() to get the physical
> address of given PFN.
>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Takao Orito <orito.takao@socionext.com>
> Reported-by: Fumihiro ATSUMI <atsumi@infinitegra.co.jp>

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>    Chanegs in v2:
>     - Fix to pass size + offset instead of changing address.
> ---
>   drivers/media/v4l2-core/videobuf2-vmalloc.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/v4l2-core/videobuf2-vmalloc.c b/drivers/media/v4l2-core/videobuf2-vmalloc.c
> index 3a7c80cd1a17..359fb9804d16 100644
> --- a/drivers/media/v4l2-core/videobuf2-vmalloc.c
> +++ b/drivers/media/v4l2-core/videobuf2-vmalloc.c
> @@ -106,7 +106,7 @@ static void *vb2_vmalloc_get_userptr(struct device *dev, unsigned long vaddr,
>   			if (nums[i-1] + 1 != nums[i])
>   				goto fail_map;
>   		buf->vaddr = (__force void *)
> -				ioremap_nocache(nums[0] << PAGE_SHIFT, size);
> +			ioremap_nocache(__pfn_to_phys(nums[0]), size + offset);
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
