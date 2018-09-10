Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503A5C43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30702086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d1HeyLnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30702086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbeIJRmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:42:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45193 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbeIJRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:42:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180910124847euoutp01bf253a8d360e18c7d2458857e02943bc~TCsJIvvYH3161831618euoutp01H
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 12:48:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180910124847euoutp01bf253a8d360e18c7d2458857e02943bc~TCsJIvvYH3161831618euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536583727;
        bh=uQO0h0ZmTt9ANQqVIpDyqrTOsJgPJ6R0dGHOZ2cqOmc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=d1HeyLnWpIYGo67UBBNa+sfv1FvhzayOXs7FKqGx7FzO3NLJX0Ojkr/XK+y1+krul
         rcuyw/cOgh1LUUY4Jo5A8SXNZXKcwJ/CymRkmfg4lYjNuBTeZ+EW2pz14Lmu0HTqAR
         jNmnE5hm/ILmhdU0eKE3FxJfDFZCaLoWO7bUugX4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180910124846eucas1p1498c193fa46bf1285649f91f49ce444b~TCsIK_7js1224212242eucas1p1q;
        Mon, 10 Sep 2018 12:48:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3E.C7.04294.E28669B5; Mon, 10
        Sep 2018 13:48:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180910124845eucas1p1b51674cd657757aadf5138e277e57ebe~TCsHYsLqt1779917799eucas1p18;
        Mon, 10 Sep 2018 12:48:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180910124845eusmtrp2bfc16b4dabc9488f8667b105bebceedf~TCsHHRhwZ3126931269eusmtrp2f;
        Mon, 10 Sep 2018 12:48:45 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-72-5b96682ed861
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 92.84.04128.D28669B5; Mon, 10
        Sep 2018 13:48:45 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180910124844eusmtip12ac25b60278a6bda718f86799dc7faf9~TCsGfGwrR1303813038eusmtip1Q;
        Mon, 10 Sep 2018 12:48:44 +0000 (GMT)
Subject: Re: [PATCH 1/4] fbdev: Drop FBINFO_CAN_FORCE_OUTPUT flag
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        nouveau@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 10 Sep 2018 14:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxNcRjH9zvn3HNPl3v9uiXPiuKOTNML83KimTA7f5mZeavRpdOt6V65
        py7FuDRlNb0t1a1QLnpd5WVR3lrRrRQaGZqXFk2k9xANnU6N/z6/7/N8f8/32R6GVL+QOTNh
        hkjeaNCGa2gFVVk/+sTTKzQjwCdljGIrG+vlbHfBacTmd7wh2YLmMpK9aHZin4/00WystZxm
        e2yZBJuTcp1gmxP1bENSv4x9Vp1Ls9+TkmRs+y/VWhWXY26luLvf8iiuKvuNnLPe6Sa4weRG
        GXf/XKmce5doI7gzsb0013evjeaGrrluVuxS+AXz4WEm3ui9JkgR+v5bExVhVRx+mjmGzOgR
        k4DsGMDLYMDaRousxoUIXrVtlXgYQfrQ6gSkGOchBJaSdGrK0NPbIZMKBQjSPg3LJEcfAuuI
        SmQH7A+p/QNIZEe8B+qySuSigcQ9JHSYPxJigcarIDW+eKKJwgvgcur5cWaYmXgHJDcvFGUl
        todGy4eJwXbYD9Jq4uUik9gNbn7NJcU/AY/KofdEHSUZTFDRZSGkpBsgNm5gMrUDfLbdkEs8
        G/5UXSAkcyaCnp+XKelRjqC0uX7SvRrqbK0yMRGJF0F5tbck+0PT64eUKANWwcuv9lIgFaRV
        ZpKSrITTcWqp2x0qrlTQU2MTqopIiTmoan+BUtC87P/WzP5vtex/c/MQWYxm8VGCXscLSw38
        IS9BqxeiDDqvfQf019D4tT36bRu+harH9tYizCDNdCUTcTZALdOahGh9LQKG1DgqqxdnBKiV
        wdroGN54YI8xKpwXapELQ2lmKVUeIQFqrNNG8vt5PoI3TlUJxs7ZjLaFxah1g+uvtgaajp/S
        /Hib6qkien0LdTE1bRuP3Q5x2V0UdGq/z4pN0aNffl86nn/khG5uy9t21xUHcZyTd5Rb/VKH
        dU0jRcr55i37fHemd3otL+4IefxF41I2I+t848/O0pb0k9stO2oe+K10NxVMa/h01McQeA53
        NQmWNXNuT59/RUMJodolHqRR0P4F3Bl0BWkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xu7q6GdOiDWZ+Y7fYdvIYu8XL5R2M
        Fgsf3mW2WH5mHbPFogYxiytf37NZNC9ez2bx5vh0JovZEzYzWZzpzrU40feB1eLyrjlsFt/7
        +lgtbv/mc+DzmN1wkcVj77cFLB47Z91l91i85yWTx6f+k6we++euYfe4332cyaO3+R2bx/t9
        V9k8Pm+SC+CK0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst
        0rdL0Mt48O0US8FirooL0/8wNjCe5uhi5OSQEDCRePPuIWsXIxeHkMBSRonf61+ydDFyACVk
        JI6vL4OoEZb4c62LDaLmLaPEmcW3mEASwgKOEhM/fGQEsUUE4iU6T5xmhCjqZ5S4dXsCO0iC
        WeAds8T/J/IgNpuAlcTE9lVgDbwCdhJPHr5lAbFZBFQllk6cBxYXFYiQuPWwgwWiRlDi5Mwn
        YDangI3EpAPtUDPVJf7Mu8QMYctLbH87h3kCo+AsJC2zkJTNQlK2gJF5FaNIamlxbnpusZFe
        cWJucWleul5yfu4mRmDcbjv2c8sOxq53wYcYBTgYlXh4OQqmRguxJpYVV+YeYpTgYFYS4d2l
        My1aiDclsbIqtSg/vqg0J7X4EKMp0BMTmaVEk/OBKSWvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFl
        lJBAemJJanZqakFqEUwfEwenVAOj0W9ZqaOdl6dUyCxdOOOvuOT9WexLZWZLNmo+nDTTY35w
        1vlGFS8Fnn3/p50LvvnxCnuFroTKtFN7vHiPbty9zVtFM93Q6Naifbs+H5y9p3+pwPrJxoXC
        sqcvV0eVHol66G4QtS11teHnS9/ueJttXLmjgqHP9c0aW9WzkhtmSAvMcFs8L2e6tBJLcUai
        oRZzUXEiAC6Nx0HxAgAA
Message-Id: <20180910124845eucas1p1b51674cd657757aadf5138e277e57ebe~TCsHYsLqt1779917799eucas1p18@eucas1p1.samsung.com>
X-CMS-MailID: 20180910124845eucas1p1b51674cd657757aadf5138e277e57ebe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180822085418epcas5p30ab8aa4b49ba204f4891760af002bce1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180822085418epcas5p30ab8aa4b49ba204f4891760af002bce1
References: <CGME20180822085418epcas5p30ab8aa4b49ba204f4891760af002bce1@epcas5p3.samsung.com>
        <20180822085405.10787-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/22/2018 10:54 AM, Daniel Vetter wrote:
> This was only added for the drm's fbdev emulation support, so that it
> would try harder to show the Oops.
> 
> Unfortunately this never really worked reliably, and in practice ended
> up pushing the real Oops off the screen due to plentyfull locking,
> sleep-while-atomic and other issues. So we removed all that support
> from the fbdev emulation a while back. Aside: We've also removed the
> kgdb support, for similar reasons.
> 
> Since it's such a small patch I figured I don't split this up into the
> usual 3-phase removal.
> 
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: David Lechner <david@lechnology.com>
> Cc: nouveau@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
