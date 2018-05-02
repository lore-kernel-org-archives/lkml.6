Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751029AbeEBJQi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:16:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39908 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbeEBJQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:16:35 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180502091633euoutp0282c3910835e500fd23dbc42933b8d35e~qyScCCmDR0493804938euoutp02Z
X-AuditID: cbfec7f4-6f9ff700000043e4-cb-5ae981efaf81
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] thermal: exynos: always check for critical trip
 points existence
Date: Wed, 02 May 2018 11:16:30 +0200
Message-id: <10453315.SITKVXMJzS@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180501090018.GF27619@mai>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djPc7rvG19GGUy+aGQx77Osxfwr11gt
        Lu+aw2bxufcIo8WM8/uYLJ487GNzYPPYOesuu8fiPS+ZPO5c28Pm8XmTXABLFJdNSmpOZllq
        kb5dAlfGs5MVBZPYK+Z828LawHiatYuRk0NCwERi65FXbF2MXBxCAisYJf7O/AmWEBL4zCjx
        s7kWpmjl9lVQ8WWMEtd++0A0/GaUWNc1ix0kwSZgJTGxfRUjiC0ioCfR+L6NCaSIWWAVo0T/
        p3dMIAlhgViJOZc+s4HYLAKqEnfOnAWL8wpoSSxY/xosLirgJbFlXztYnFNAU6Kx9wYzRI2g
        xI/J91hAbGYBeYl9+6eyQtg6EmePrWOEuHQFm8TfWWIQtovEnwMHoeLCEq+Ob2GHsGUkLk/u
        ZgE5TkKgmVHi2449zBCJCYwSe9YLQdjWEoePX4RawCcxadt0oBoOoDivREcbVImHxO0Xp6DB
        6CjR+u8qMyRUbjJK7N/xnW0Co+wsJHfPQnL3LCR3L2BkXsUonlpanJueWmyUl1quV5yYW1ya
        l66XnJ+7iRGYDk7/O/5lB+OuP0mHGAU4GJV4eA3yXkQJsSaWFVfmHmKU4GBWEuFd2fEsSog3
        JbGyKrUoP76oNCe1+BCjNAeLkjhvnEZdlJBAemJJanZqakFqEUyWiYNTqoHRIbpvbmF3tfDM
        uVKe227GPTlzvrql4UnmhezXoY4/jk7c/vG4TvDh90kfP9jIV8XefCG2K8My33Lzvc5zBzav
        /xiuldcuW79heV2nyzqPb9EG+gG6fVt+sd5Wl1dyuPFq+vXDE9NTNklVbWSxrG/Tyl33PXxh
        yKzd+2WWqPvMzV3e/ig0UFNGiaU4I9FQi7moOBEA+CASfgMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t/xq7rvG19GGRxZJGgx77Osxfwr11gt
        Lu+aw2bxufcIo8WM8/uYLJ487GNzYPPYOesuu8fiPS+ZPO5c28Pm8XmTXABLFJdNSmpOZllq
        kb5dAlfGs5MVBZPYK+Z828LawHiatYuRk0NCwERi5fZVQDYXh5DAEkaJHbOOskM4fxklXq38
        xwZSxSZgJTGxfRUjiC0ioCfR+L6NCaSIWWAVo8TK1l5mkISwQKzEnEufwRpYBFQl7pw5ywRi
        8wpoSSxY/xosLirgJbFlXztYnFNAU6Kx9wYzxLZWRommpresEA2CEj8m32MBsZkF5CX27Z/K
        CmFrSazfeZxpAiP/LCRls5CUzUJStoCReRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg4G47
        9nPLDsaud8GHGAU4GJV4eA3yXkQJsSaWFVfmHmKU4GBWEuFd2fEsSog3JbGyKrUoP76oNCe1
        +BCjNAeLkjjveYPKKCGB9MSS1OzU1ILUIpgsEwenVAOj7qrNSXXzDmZ/urFqRvqjybkdDfrT
        0jad3Mf9jFdGZP7afykmZekzH2+bw533sKTuwUOWCRJfj63833djU+WnK5uu1cyN6/9woPGa
        Y9YxxVQ29/gJj/84vPn5fMJBG424nfdteb5OU2mRK5BT5950PfvYG4USSc6ufyt2dyzP0OTf
        b8w35V3XMSWW4oxEQy3mouJEADnCNqZYAgAA
X-CMS-MailID: 20180502091631eucas1p1e310f34a39383e01cfbf9eef992db260
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180502091631eucas1p1e310f34a39383e01cfbf9eef992db260
X-RootMTR: 20180502091631eucas1p1e310f34a39383e01cfbf9eef992db260
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <5229331.iYYXeBBCxK@amdc3058> <20180501090018.GF27619@mai>
        <CGME20180502091631eucas1p1e310f34a39383e01cfbf9eef992db260@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 01, 2018 11:00:18 AM Daniel Lezcano wrote:
> On Mon, Apr 30, 2018 at 05:24:15PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Monday, April 30, 2018 04:44:50 PM Daniel Lezcano wrote:
> > > On Thu, Apr 26, 2018 at 01:51:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > * Check for critical trip point existence in exynos_tmu_initialize()
> > > >   so it is checked on all SoCs (except Exynos5433 for now).
> > > 
> > > Why "except Exynos5433" ?
> > 
> > I was a bit vague here - Exynos5433 DTS needs to be fixed first to define
> > critical trip points.
> 
> Is it possible to fix the DT in the series, so we get rid of the "FIXME" ?

This DT change needs more effort so it is planned for some later time
(also doing it in this series would create dependency on arm-soc tree).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
