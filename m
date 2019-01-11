Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5F4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADCC20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QfNhW28S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbfAKMpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:45:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43709 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbfAKMpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:45:14 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190111124512euoutp025de636c58a128f9c0faf10bc3cf31434~4y-H0LVL91208312083euoutp02Z
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 12:45:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190111124512euoutp025de636c58a128f9c0faf10bc3cf31434~4y-H0LVL91208312083euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547210712;
        bh=JWnN24DRrP5LPitt2BUMJHZDUQ20+IolgenvwLWLLvM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QfNhW28SMc/cFOX3Gokkg/sPS+DeTtlCFiUlo9uFDoMkywVjSGvcRsQZqxg7JmSui
         KtSnUnkCu3zIyR70RBPcjF4s1bV8mBHJV5dDFNYMW5+ZJ8/17rFzZQheuyiOgxvu2X
         YXQhEhjyWmB+UjmOrXH2YrbxkE1sAIqlb3w8J0+0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190111124511eucas1p1025ce6ef017d607711deca582020812a~4y-HcblEg0950909509eucas1p1T;
        Fri, 11 Jan 2019 12:45:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4E.CB.04806.7DF883C5; Fri, 11
        Jan 2019 12:45:11 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190111124510eucas1p108adb38cbf168cac1528102b1afe8071~4y-GrdvIc0630906309eucas1p1X;
        Fri, 11 Jan 2019 12:45:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190111124510eusmtrp1404017479d3629266361afd24210c81a~4y-GXyomk1062410624eusmtrp1T;
        Fri, 11 Jan 2019 12:45:10 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-04-5c388fd7309f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 53.91.04284.6DF883C5; Fri, 11
        Jan 2019 12:45:10 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190111124510eusmtip2ecebadf3ed733cb6039ccea54b4a5004~4y-GD8gCJ0055000550eusmtip2Y;
        Fri, 11 Jan 2019 12:45:10 +0000 (GMT)
Subject: Re: [PATCH] Fix stack memory disclosure
To:     Kees Cook <keescook@chromium.org>,
        Vlad Tsyrklevich <vlad@tsyrklevich.net>
Cc:     linux-fbdev@vger.kernel.org,
        Security Officers <security@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <8ae8354f-a197-2ee1-d056-ccbac02028cb@samsung.com>
Date:   Fri, 11 Jan 2019 13:45:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <c0a93d03-f150-6363-2df7-b2dec8a8638a@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduzned3r/RYxBm++i1qc6c61ONH3gdXi
        8q45bBZX/3YwWlx7MpXFgdVjdsNFFo9NqzrZPM5v5PX4vEkugCWKyyYlNSezLLVI3y6BK2Nx
        zwSWglOcFQ8WzWNrYPzG3sXIySEhYCLxb8Z81i5GLg4hgRWMEgt/X4ZyvjBKPOlfwgLhfGaU
        +P6hlQ2m5UvPMSaIxHJGif5TB6Ba3jNKXJs2jQmkSljAQOLZlgYwW0QgQGLrs1OsIDazQL7E
        65s3wSaxCVhJTGxfxdjFyMHBK2Ancf96EEiYRUBV4kPjQ1aQsKhAhET/GXWQMK+AoMTJmU9Y
        QGxOAXuJy0sus0BMlJfY/nYOM8gJEgL97BJn5v9hhTjURWLP6V4oW1ji1fEtUD/LSJye3MMC
        0TCdUeLNr6VQznpGiTVnjjFBVFlLHD5+EewKZgFNifW79CHCjhJL+n+yg4QlBPgkbrwVhDiC
        T2LStunMEGFeiY42IYhqNYkNyzawwazt2rmSGcL2kPg9p5N9AqPiLCSvzULyziyEvQsYmVcx
        iqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJpLT/45/3cG470/SIUYBDkYlHt4OX/MYIdbE
        suLK3EOMEhzMSiK8p/MsYoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzVjM8iBYSSE8sSc1OTS1I
        LYLJMnFwSjUwtoYXi2p2fpkr/e384TShyF92LI9e3jbl27rdvlz70v3dB7nCs3b7Kxq8/v/b
        zbqB9d+CZM/JF70Zd/yu+xgR5nPAco5Lnr6TR4eM3lE91W6mGmnN3TKHkmyac3USapdvZF2z
        5CD75svv5soo5DH7n2LLeFE3WTtFxWqj3f3+s+G8E1kjVloosRRnJBpqMRcVJwIANa65byAD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xe7rX+i1iDB7/kLA4051rcaLvA6vF
        5V1z2Cyu/u1gtLj2ZCqLA6vH7IaLLB6bVnWyeZzfyOvxeZNcAEuUnk1RfmlJqkJGfnGJrVK0
        oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbingksBac4Kx4smsfWwPiNvYuR
        k0NCwETiS88xpi5GLg4hgaWMEg0T7jB3MXIAJWQkjq8vg6gRlvhzrYsNouYto8Tv/vOMIAlh
        AQOJZ1samEBsEQE/iZc7rrFDFHUySfw7uQmsiFkgX6Ltx1tmEJtNwEpiYvsqRpAFvAJ2Evev
        B4GEWQRUJT40PmQFsUUFIiRuPexgAbF5BQQlTs58AmZzCthLXF5ymQVipLrEn3mXmCFseYnt
        b+cwT2AUnIWkZRaSsllIyhYwMq9iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjJBtx35u3sF4
        aWPwIUYBDkYlHt4OX/MYIdbEsuLK3EOMEhzMSiK8p/MsYoR4UxIrq1KL8uOLSnNSiw8xmgI9
        MZFZSjQ5Hxi9eSXxhqaG5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGFOP
        3Z90sfzrvD+cnXOnH5my7PzjoyY7VqWoV2xnE7rzLEnUPeeI1u0FbCErHP9v7NdY6M3wRlde
        5afZp/B6U6EXYVN329ivXjZv/w2FXB9jgYX5Su/MvHbYeVQ9KTm6u4jLNtYmXezBt21r8qb9
        ZM9U2cfgfuWa4cyTdTr3JBgYGecnlc+ZM0eJpTgj0VCLuag4EQA2tebzpgIAAA==
X-CMS-MailID: 20190111124510eucas1p108adb38cbf168cac1528102b1afe8071
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190108234243epcas4p3b9ec45a771e71a0c3a3af7eeea93905d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190108234243epcas4p3b9ec45a771e71a0c3a3af7eeea93905d
References: <20190106075408.58405-1-vlad@tsyrklevich.net>
        <CGME20190108234243epcas4p3b9ec45a771e71a0c3a3af7eeea93905d@epcas4p3.samsung.com>
        <CAGXu5jKiKA79mnTwCxTKsXBBKAvaoaX=CH61pLXdxtWQvUhhuQ@mail.gmail.com>
        <c0a93d03-f150-6363-2df7-b2dec8a8638a@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/10/2019 04:10 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 01/09/2019 12:41 AM, Kees Cook wrote:
>> On Sat, Jan 5, 2019 at 11:51 PM Vlad Tsyrklevich <vlad@tsyrklevich.net> wrote:
>>>
>>> Using [1] for static analysis I found that the OMAPFB_QUERY_PLANE,
>>> OMAPFB_GET_COLOR_KEY, OMAPFB_GET_DISPLAY_INFO, and OMAPFB_GET_VRAM_INFO
>>> cases could all leak uninitialized stack memory--either due to
>>> uninitialized padding or 'reserved' fields.
>>>
>>> Fix them by clearing the shared union used to store copied out data.
>>>
>>> [1] https://github.com/vlad902/kernel-uninitialized-memory-checker
>>>
>>> Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Fixes: b39a982ddecf ("OMAP: DSS2: omapfb driver")
> 
> Thanks.
> 
>> Since this driver is orphaned (according to MAINTAINERS), I think this
>> fix should go via Bart's tree. Bart, can you take this?
> 
> Sure, I will merge it tomorrow (I plan to send fbdev fixes pull request to
> Linus next week).

Patch queued for 5.0 (with patch subject prefixed with "omap2fb: "), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
