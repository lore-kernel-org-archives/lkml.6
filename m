Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED4BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351C221788
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FqV9N5S3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351C221788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeHQKuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:50:11 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57267 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeHQKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:50:11 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180817074748euoutp02e25ca281e3063ff6e9b941fcb63676a3~LnGf5jqyn0060100601euoutp02U
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 07:47:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180817074748euoutp02e25ca281e3063ff6e9b941fcb63676a3~LnGf5jqyn0060100601euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1534492068;
        bh=7nsGmHi3S5cr/KR4gh57xMJXYesuxAucxZtlz/fPZdc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FqV9N5S3js65EHqpTYnXFylPzOMbZrbqrOCcDQ6rJziuJdJPIZMzeymne9u73tWpD
         h5UxRv7rIfdpysgb+V3NIFukOk1okD7jvegdIupEvRhsTH5sGWKYX2VNJBP8nE5n05
         Szxk9dSv1wSwg8VjuGsWZD8/9/RMLRumN54k6Te4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180817074748eucas1p29e1dad39c46640198e595d7c3a66410f~LnGfgFCgI1474814748eucas1p2u;
        Fri, 17 Aug 2018 07:47:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E8.9D.04806.3AD767B5; Fri, 17
        Aug 2018 08:47:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180817074747eucas1p1a70969aac4238b0c8db0d8e59f4af078~LnGev9y9l2871228712eucas1p1X;
        Fri, 17 Aug 2018 07:47:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180817074746eusmtrp21dfc6053cfbf7e1daacddb1888375676~LnGehtKWp1247012470eusmtrp28;
        Fri, 17 Aug 2018 07:47:46 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-6b-5b767da35146
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7F.7C.04284.2AD767B5; Fri, 17
        Aug 2018 08:47:46 +0100 (BST)
Received: from [106.116.147.122] (unknown [106.116.147.122]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180817074746eusmtip1551893c8c19d7b6381812a9fca92f43d~LnGeOWDX71051610516eusmtip16;
        Fri, 17 Aug 2018 07:47:46 +0000 (GMT)
Subject: Re: [PATCH] Revert
 "kbuild: create deterministic initramfs directory listings"
To:     =?UTF-8?Q?Bj=c3=b8rn_Forsman?= <bjorn.forsman@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, forney@google.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Date:   Fri, 17 Aug 2018 09:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAEYzJUHghs+2p4n1TesL3=VkCJcvs1TevjeFhqiQHdX+cqfqiQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87qLa8uiDf7c0bDomLmY3eLj2Svs
        Fpd3zWGz2HvvM6MDi8fOWXfZPRZsKvU4Mf07i8fnTXIBLFFcNimpOZllqUX6dglcGXN6ZrIW
        vOKpuNP8mK2BcT5XFyMHh4SAicS/11JdjFwcQgIrGCV+zljNAuF8YZRY23yFCcL5zCixcP8m
        5i5GTrCOpqdf2CESy4GqFk9mg3A+MkrsfLWWCWSusECkxJGrCSANIgI2El1zX4I1MwvkShw4
        +YodxGYTMJbYe7CDEcRmEVCVmPWlH6xGVCBC4siDhWBxXgFBiZMzn7CA2JwCgRKf5i1ngZgj
        LnHryXwmCFteonnrbGaQGyQEutklPvVMYIJoLpPoXvOCHeJqF4nd8+eyQtjCEq+Ob4GKy0j8
        3wkxSEKgXmLTlz1sEPYURol7c70hbGuJw8cvsoL8xSygKbF+lz5E2FHizNnjTJBg5JO48VYQ
        4hw+iUnbpjNDhHklOtqEIKqVJbZ8PQUNQkmJ1jfLGCcwKs1C8uQsJI/NQvLYLIS9CxhZVjGK
        p5YW56anFhvnpZbrFSfmFpfmpesl5+duYgQmldP/jn/dwbjvT9IhRgEORiUe3glrS6OFWBPL
        iitzDzFKcDArifDOPA8U4k1JrKxKLcqPLyrNSS0+xCjNwaIkzsunlRYtJJCeWJKanZpakFoE
        k2Xi4JRqYFztsv3lMZ3oZb6am7lnhNlJRS7bqmFrYaS89WaKipiSYevl31vnzTtc1hQSI6L+
        JXLWiozUHKGTxdaLWg3uT9Lfcn/h4Yh3t9pkkxg8ptvauCb9+bjqlovWkve6M4pyXiybkM93
        6a8M61uOLd4T2BVLJ4oo9wntb9Odx+zCWWz9YvHnr0Gn2JRYijMSDbWYi4oTAZP3jzQmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xu7qLasuiDQ72mVh0zFzMbvHx7BV2
        i8u75rBZ7L33mdGBxWPnrLvsHgs2lXqcmP6dxePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9
        Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jDk9M1kLXvFU3Gl+zNbAOJ+ri5GTQ0LA
        RKLp6Rf2LkYuDiGBpYwSh/b/YoZISEr0PjzADmELS/y51sUGUfSeUeLWtkZWkISwQKTEk7YP
        YEUiAjYSXXNfgjUzC+RKzFswjwmi4SqjxKunk8CK2ASMJfYe7GAEsXkF7CR2X38IFmcRUJWY
        9aUfrFlUIEJi9fIXrBA1ghInZz5hAbE5BQIlPs1bzgKxwExi3uaHUMvEJW49mc8EYctLNG+d
        zTyBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBo2nbs5+Yd
        jJc2Bh9iFOBgVOLhfbG+NFqINbGsuDL3EKMEB7OSCO/M80Ah3pTEyqrUovz4otKc1OJDjKZA
        z01klhJNzgdGel5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBsa5
        XaH83kduiGo27I7ZKrvuaIasVeaffPaCeyqBW19WVOyaE6zPLjV/n/OZSCEmqRszeOTuMHv8
        Y9bhWurhdzam79JDq6lHjzGVZf348n7rMnP/bAfrqM2i8kGBghPeJ0oGCmV5qQluDc3Zv6z+
        Vtl/gfpGE2eJ+e6SdikZm3Mf+Z+PXZLar8RSnJFoqMVcVJwIAKkrGpG8AgAA
Message-Id: <20180817074747eucas1p1a70969aac4238b0c8db0d8e59f4af078~LnGev9y9l2871228712eucas1p1X@eucas1p1.samsung.com>
X-CMS-MailID: 20180817074747eucas1p1a70969aac4238b0c8db0d8e59f4af078
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180816161825eucas1p11be9cea5d622b905154590bae90a47a4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180816161825eucas1p11be9cea5d622b905154590bae90a47a4
References: <CGME20180816161825eucas1p11be9cea5d622b905154590bae90a47a4@eucas1p1.samsung.com>
        <20180816161817.12267-1-andrzej.p@samsung.com>
        <CAEYzJUHghs+2p4n1TesL3=VkCJcvs1TevjeFhqiQHdX+cqfqiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjørn,

W dniu 17.08.2018 o 01:34, Bjørn Forsman pisze:
> On Thu, 16 Aug 2018 at 18:18, Andrzej Pietrasiewicz
> <andrzej.p@samsung.com> wrote:
>>
>> This reverts commit 9e6e0d5f2a2713402cf9dce69b9f9b516e4185d2.
>>
>> The reverted commit introduces broken builds. Even though the cpio archive
>> does contain all the specified files, it seems that the kernel, while
>> populating rootfs, scans the cpio buffer linearly and fails to create
>> files whose parent directories are nonexistent at the moment of this failed
>> creation. As a result, such files are not accessible when kernel boots into
>> initramfs.
>>

<snip>

> 
> I'm unable to reproduce it. On my system the listing is sorted so that
> it works (parent directories appear before files). I tried to run with
> LANG=C and it also sorts correctly. What is your LANG=? I think we
> better add a LANG=C somewhere in the kernel build system, because I
> think you have a LANG= that makes it sort differently. A quick fix
> would of course be to insert it right next to sort, but there may be
> other places that may break due to LANG= settings.
> 

Thanks for the tip. My LANG is pl_PL.UTF-8. Indeed, prefixing the "sort"
invocation in question with LANG=C does solve the problem. I don't feel
competent enough to say whether this is the correct place for the fix,
or if the fix should be made elsewhere. Another option is that it is the
"sort" itself that should be fixed (or the locale, or both).

Would you be able (as the author of the patch in question) to check if
there are other locales which cause the problem?

Thanks,

Andrzej
