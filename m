Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05AFC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEF7246DE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YHCESJXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEF7246DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933098AbeGDC2E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:28:04 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:10330 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752717AbeGDC2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:28:00 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180704022758epoutp02a9fa7f218141b4c4312b8c0c84053080~_CWscA7xx1650816508epoutp02c;
        Wed,  4 Jul 2018 02:27:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180704022758epoutp02a9fa7f218141b4c4312b8c0c84053080~_CWscA7xx1650816508epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530671279;
        bh=2Sx3FoWM18ZfQeJMUMC28rvd358i4f5GzE05Yk3OFDU=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=YHCESJXjDmNHODUolO8ESlPfa1J95MfW0j7iR3VyV6sjslr2rIayYtB5zeaP2oLZd
         ECs6zJIqUz1zqnCJn4KGa0SjJ9fehL6E3NMrCbSeavb2/r+OAeu3pNqCGGhY+xWb3l
         LU+SLlBWjL1mV3Ik3xC1WdjB7fpBS7L00gX0hwwI=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180704022755epcas1p1b90257f52bd3dfdf61c4ed92fa48076d~_CWpd_sfH1315413154epcas1p1x;
        Wed,  4 Jul 2018 02:27:55 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.D9.04187.BA03C3B5; Wed,  4 Jul 2018 11:27:55 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20180704022755epcas2p1dd5abd848b261f24e8811bac5a65b9be~_CWpJjAQl1054710547epcas2p1s;
        Wed,  4 Jul 2018 02:27:55 +0000 (GMT)
X-AuditID: b6c32a46-c4fff7000000105b-23-5b3c30ab1ed4
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.80.04192.BA03C3B5; Wed,  4 Jul 2018 11:27:55 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBB00M1RLIIT740@mmp1.samsung.com>; Wed, 04 Jul 2018 11:27:55 +0900 (KST)
Message-id: <5B3C30AA.3070302@samsung.com>
Date:   Wed, 04 Jul 2018 11:27:54 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 03/12] PM / devfreq: Don't adjust to user limits in
 governors
In-reply-to: <20180703234705.227473-4-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmhe5qA5tog9kN+hZ/Jx1jt5j+5DKL
        xaaP71kt5h85x2pxdtlBNos1tw8xWjQvXs9mcbbpDbvF/a9HGS0u75rDZvG59wijxdLrF5ks
        Pm94zGhxu3EFm8Wp65/ZLM6cvsRq0br3CLvFxq8eDkIea+atYfT4/WsSo8fshossHjvuLmH0
        2LSqk83jzrU9bB77565h97hyoonVY8vVdhaPvi2rGD0+b5IL4I5KtclITUxJLVJIzUvOT8nM
        S7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBek1JoSwxpxQoFJBYXKykb2dTlF9a
        kqqQkV9cYqsUbWhopGdoYK5nZASkjWOtjEyBShJSM45PPMJW8J6n4sjqDsYGxi1cXYycHBIC
        JhLXDu5g7WLk4hAS2MEoMe3UGXaQhJDAd0aJG+2WMEUbHn5jgSjazSjxbsJfRpAEr4CgxI/J
        94ASHBzMAvISRy5lg4SZBTQltu5ezw5Rf5dRYnHTN2aIei2Jt58fsoLYLAKqEvPWHmIBsdmA
        4vtf3GADsfkFFCWu/ngMNl9UIEJi5/xvYAeJCARLLPh5HuwIZoHXLBILW36DDRIWCJO4svc6
        WDOngLnEvjm/wN6REDjFLtFxfQYbxAsuEq8vHmSBsIUlXh3fwg5hS0s8W7WREaKhnVHiy4tm
        qO4JjBIfTm1mgqgylni2sIsJ4jk+iY7Df9lBfpYQ4JXoaBOCKPGQuN29AxpG2xkllk87zTqB
        UXYWUjDNQgTTLKRgWsDIvIpRLLWgODc9tdiowEivODG3uDQvXS85P3cTIzgJa7ntYFxyzucQ
        owAHoxIP74pS62gh1sSy4srcQ4wSHMxKIryd+jbRQrwpiZVVqUX58UWlOanFhxhNgaE8kVlK
        NDkfmCHySuINTY2MjY0tTM0tjQ0slcR5GW8KRAsJpCeWpGanphakFsH0MXFwSjUwhjOvuxVw
        can6RKmpyTz6tceaMxcUPf3O9Gjlac5X1g67kvqks+Zt2OxvkCZcclPrsE2d3aSMA9Pyty31
        mjhFXMWabSbv1o5jDaxJC7yDW1K3b5Q5vWor71XHvX3+15TPXPMW/5yeUMm0+v85rkur245N
        /75c3CcojDe27KTGkYVGjn7JriK6SizFGYmGWsxFxYkAzM2Zu9gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t9jAd3VBjbRBq+WSVr8nXSM3WL6k8ss
        Fps+vme1mH/kHKvF2WUH2SzW3D7EaNG8eD2bxdmmN+wW978eZbS4vGsOm8Xn3iOMFkuvX2Sy
        +LzhMaPF7cYVbBanrn9mszhz+hKrReveI+wWG796OAh5rJm3htHj969JjB6zGy6yeOy4u4TR
        Y9OqTjaPO9f2sHnsn7uG3ePKiSZWjy1X21k8+rasYvT4vEkugDuKyyYlNSezLLVI3y6BK+P4
        xCNsBe95Ko6s7mBsYNzC1cXIySEhYCKx4eE3li5GLg4hgZ2MEq2PD7KCJHgFBCV+TL4HlODg
        YBaQlzhyKRskzCygLjFp3iJmiPr7jBLrls1ghKjXknj7+SFYL4uAqsS8tYdYQGw2oPj+FzfY
        QGx+AUWJqz8eM4LMFBWIkOg+UQkSFhEIlvjQ3MMGMpNZ4C2LxNJv/8FmCguESVzZe50NYtl2
        Rok/vcvAFnAKmEvsm/OLdQKjwCwkt85CuHUWklsXMDKvYpRMLSjOTc8tNiowykst1ytOzC0u
        zUvXS87P3cQIjMpth7X6dzA+XhJ/iFGAg1GJh3dFqXW0EGtiWXFl7iFGCQ5mJRHee7+AQrwp
        iZVVqUX58UWlOanFhxilOViUxHn5849FCgmkJ5akZqemFqQWwWSZODilGhijuc9Pfry20ODg
        eibhpfW19ZXtYfvYz988E7heqLGk5X8Za8Sv5AlmLx5IqOtzOj51OqoRKVZ8/G+XWYaTjeBc
        kcdn3NQcXzSaGTn3C7QHNH3cvz04RMHBtKNVWPyt8vyeG24Tde6tObHgpLZmJofgjy8qkiF1
        E+cdv3OfwcTAdsECXfWk7UosxRmJhlrMRcWJAFYLDSHGAgAA
X-CMS-MailID: 20180704022755epcas2p1dd5abd848b261f24e8811bac5a65b9be
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703235028epcas4p2921421ea854565c23dfa54db9fb6ada8
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703235028epcas4p2921421ea854565c23dfa54db9fb6ada8@epcas4p2.samsung.com>
        <20180703234705.227473-4-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
> Several governors use the user space limits df->min/max_freq to adjust
> the target frequency. This is not necessary, since update_devfreq()
> already takes care of this. Instead the governor can request the available
> min/max frequency by setting the target frequency to DEVFREQ_MIN/MAX_FREQ
> and let update_devfreq() take care of any adjustments.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> Changes in v5:
> - none
> 
> Changes in v4:
> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - squashed "PM / devfreq: Remove redundant frequency adjustment from governors"
>   and "PM / devfreq: governors: Return device frequency limits instead of user
>   limits"
> - updated subject and commit message
> - use DEVFREQ_MIN/MAX_FREQ instead of df->scaling_min/max_freq
> ---
>  drivers/devfreq/governor.h                |  3 +++
>  drivers/devfreq/governor_performance.c    |  5 +----
>  drivers/devfreq/governor_powersave.c      |  2 +-
>  drivers/devfreq/governor_simpleondemand.c | 12 +++---------
>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
>  5 files changed, 12 insertions(+), 26 deletions(-)

Actually, I preferred to use 'df->scaling_min/max_freq'
instead of DEVFREQ_MIN/MAX_FREQ. But, DEVFREQ_MIN/MAX_FREQ is other way. 

So, Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
