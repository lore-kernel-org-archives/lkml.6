Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899CFC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E627213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t3AH/cSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E627213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJKRNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:13:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58335 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeJKRNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:13:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181011094703euoutp02c0bef5b68091fc09fa50cf03af1b5931~chNULOHrD0285202852euoutp029
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 09:47:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181011094703euoutp02c0bef5b68091fc09fa50cf03af1b5931~chNULOHrD0285202852euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539251223;
        bh=4fU7x1Io2ussEbMTduXFQbRMsViG7Us04QIUJmLjI7U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=t3AH/cSa3p723jW5nob5qcE8+cY3lVBt4kWjfXUOUgs00wdtmNcCg5J/Knx07J20L
         R9ZxVOG3/J+ls4GZhvs5f8DhtibXSq8IU6FL0kQUpg4obNNkEzslkymKmhu5ox4Iqd
         8lBIEfHNjUb4o+XjXZzG0wMBzt1sIZYy9IxF9jv4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181011094702eucas1p17abe1292a7d08d520c12b89708bff0eb~chNTTxCWp3171931719eucas1p1j;
        Thu, 11 Oct 2018 09:47:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F8.FB.04806.51C1FBB5; Thu, 11
        Oct 2018 10:47:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181011094701eucas1p2177080d98481b4d4ebcfad9960d7dd97~chNSImIbW1044610446eucas1p2Q;
        Thu, 11 Oct 2018 09:47:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181011094700eusmtrp1f623c9174b6116b3ba8c38ef45de4db0~chNR1hFsT2200222002eusmtrp1d;
        Thu, 11 Oct 2018 09:47:00 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-6a-5bbf1c152220
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2C.48.04284.41C1FBB5; Thu, 11
        Oct 2018 10:47:00 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181011094700eusmtip1c6e16976d489a75aedd18ac7a7b0f39f~chNRNC2tS1082810828eusmtip1E;
        Thu, 11 Oct 2018 09:46:59 +0000 (GMT)
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor
 only
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        jacopo <jacopo@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Thu, 11 Oct 2018 11:46:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTlzUyHoVLyaDXcgEvSxAWVLWp4CUZUiI5L4hITE3GrMiKRgukI
        rjFEDEIBERSpI6IkKloLKkpFSlyKAZR9EZeAWzAqAn5UFKOClEHl79xzz3n3npvH0ep+hTcX
        HbtHMMTqYrSskrFW/WjwmzDxfkTg1Yy5xPJxIcl528WSc2ezEWkqDiadH44i0maVaPKtLYUi
        p34VUqS1PI8lvzsGWVKa34BIS2YWRaQeDZEqfUh2mTdJNV2nFmLekm9BfGt7M81nFjsUfFa9
        H39X6nTlK/sLGH7o+TuaLzGnsnxHewXLv7HfYvhT5x4peEfJ5NXuG5TzI4WY6ATBELBgq3Kn
        o+wBtTsJ9rVlNSkSkUljRG4c4LlgOf+KMiIlp8ZXEFw6XcTKxVcE2U+GRjsOBF1VV1yNiBux
        2IYOy3whgpxGy6joC4LUr520810NXgVVJ2wjeDyeDWnWHwqniMY9DFg/dCBng8VBYOw1sk7M
        4KlwrcbMOidMwBvhZ3mIk1ZhT3h8potxYje8BhJtpSNWGk+BO715tIy94GXX+ZElABdwYD5p
        p2RzAhS9sFJy0HBoySxgZKyB7urbrjKeCLUn0xnZnITgmElylYt0BKV5ZaysCoHK6maFczsa
        +8L18gCZXgRFUi4ln8UDnvd6ygt5QLY1l5ZpFaQkq2X1NJCqi/+NfdjUQp9AWmlMTGlMNGlM
        NOn/3AuIMSMvIV7URwninFhhr7+o04vxsVH+2+P0JWj4M9YOVveXoXu/ttkR5pDWXTXgfS9C
        rdAliPv1dgQcrR2vCjANU6pI3f4DgiFuiyE+RhDtyIdjtF6qy/k3I9Q4SrdH2CUIuwXD3y7F
        uXknIj8TuRhch3y9PgWnHXnKpzSe/jnrxaJxfceXV1xcE9qREd5TOqk+onB992bpZujLPtXq
        ZZMDl37XsBmhM54SccmNAf07F7w2sz3k9me2Znqg9X2fY92hZ4s3rUyzJR308fWssGm6kz93
        K021R2iPBnPYirAdO16Tfbk+LvPqalaGb9Qy4k5d0EzaIOr+AAiW2KuIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42I5/e/4XV0Rmf3RBucb1S3WvHCwmPrwCZvF
        3NmTGC0urDO3uPu8hdHiyrZZzBbfrnQwWUz5s5zJ4vKuOWwWf+/8Y7PYOu8co8Wl/olMFrPe
        CFvMOixtMWmHlEXnjPVMDgIea+atYfS4fO0is0f/us+sHhPP6nrsnHWX3ePw14UsHv9vPGL2
        2LSqk83jzrU9bB4PDm1m8Zgy9wirx+dNcgE8UXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaW
        eobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZn3ccYCpolqi4MvECawPjDOEuRg4OCQETid3/67oY
        uTiEBJYyStx80M7cxcgJFJeRODmtgRXCFpb4c62LDaLoLaPEni232UASwgK+Eqe3TmYHsUUE
        dCS6t/1kBSliFnjHIvF2+jQmiI6jTBLrO7aBjWUTMJToetsF1s0rYCdxYfs/RhCbRUBVYvWJ
        VWBxUYEYiaOTW6BqBCVOznzCAmJzCgRKNOzeClbPLKAu8WfeJWYIW15i+9s5ULa4xK0n85km
        MArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yYW1yal66XnJ+7iRGYCrYd+7l5B+Ol
        jcGHGAU4GJV4eH9I7YsWYk0sK67MPcQowcGsJMKrPwMoxJuSWFmVWpQfX1Sak1p8iNEU6LmJ
        zFKiyfnANJVXEm9oamhuYWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoHRn6Vh
        yo8fW1iyxUu/iLPtq1Xv+lP1cZISZ1XyZdY6e7641bPCXxkulJjaUJvpIWT+2KNk+qenEW9Z
        3Dr7i65O0F6tJar0/528cHG9Ns9ey2NLC0+Xnt5saJKzdEviGbm1U+ujal4GzfMMzNhkdvz6
        1GW9M37rWNRHc7tm1mxbUDGBs/5G9nMlluKMREMt5qLiRADqcpJrGwMAAA==
Message-Id: <20181011094701eucas1p2177080d98481b4d4ebcfad9960d7dd97~chNSImIbW1044610446eucas1p2Q@eucas1p2.samsung.com>
X-CMS-MailID: 20181011094701eucas1p2177080d98481b4d4ebcfad9960d7dd97
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
        <20180906122436.25610-1-linus.walleij@linaro.org>
        <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
        <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 2018-10-11 11:29, Linus Walleij wrote:
> On Thu, Oct 11, 2018 at 11:01 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>
>> I've just noticed that this patch causes regression on Samsung
>> Exynos4412-based Trats2 board. Conversion to GPIO descriptor breaks
>> operation when regulators used shared GPIO:  sii9234 i2c driver
>> is not able to get vcc33mhl regulator (it uses shared GPIO enable
>> line with vsil12 regulator).
> So I guess this means that this physical GPIO line will enable the
> vcc33mhl and the vsil12 regulators at the same time?

Right. It is so common case, that regulator core has special code for
handling shared enable GPIO.

>> This issue has been already pointed in case of commits:
>> 37fa23dbccbd97663acc085bd79246f427e603a1
>> d1dae72fab2c377ff463742eefd8ac0f9e99b7b9
>> ab4d11e2c2329cf7cb7be31ff22489aae4dee5dc
> A big sorry for my ignorance, I guess the information overload
> on the mailing list just makes me miss the important points.
> I'll try to be better, sadly I constantly fail to keep everything
> in mind and constantly break things like this.
>
>> Maybe it would be better to first solve the handling of shared enable
>> GPIO in the descriptor-based interface before converting more regulators
>> and stepping into this issue again?
> I am trying to solve it, but I just don't have systems to reproduce all
> kinds of things. It's a bit stressful since this is one of those runtime
> things that is hard to test when devising a patch for systems I don't
> have.
>
> I am kind of relying on system maintainers to test things.
>
> I was aware of the usecase "several consumers takes the same
> GPIO line" (Mark told me several times...) so it was in the back of
> my mind, but it's just hard to see when we were gonna run into it.
> So it is the fixed regulators, on Samsung boards, I see.

I don't think this is Samsung specific. I saw similar solution on various
other boards too. Sharing enable gpio is rather common thing. The issue
happens if there are separate drivers for each hw block and they need to
enable it from their code.

> Anyways. Let's try to fix it now then instead of me constantly
> hitting this and breaking it. It happens because it is just unintuitive
> so I share your frustration.

I try to test linux-next daily to catch such thing as early as possible
and help others to fix their code. Feel free add me on cc: so I will
test it.

> I don't want to generally make it possible for a gpio line to be
> retrieved nonexclusively. We need the semantics to help people
> do the right thing.
>
> So I was thinking to introduce
> gpiod_get_nonexclusive() to explicitly handle this case for the few
> systems that use shared GPIO lines, let me see what I can do.

The old interface also didn't allow sharing GPIO easily, so regulator
core has special code for shared enable gpio. However I still have no
idea how to do this cleanly using descriptor.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

