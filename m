Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B767C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C012086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="piqirC6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfBUEVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:21:46 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:55648 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfBUEVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 23:21:46 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190221042143epoutp0103fbfe2f28bbda2f79a0d90bd998e614~FRkOz591J1896418964epoutp01u
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:21:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190221042143epoutp0103fbfe2f28bbda2f79a0d90bd998e614~FRkOz591J1896418964epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550722903;
        bh=p/ltNYd8J/gOhJEAuvMRU1oPQERrLXZPVnpiOkagw5o=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=piqirC6tJta89qOiKwIrM4KVVdH5zV+EqLk9jLTw/976cymZE9+syknWbxK07ol1G
         gFIQbt22ve+vA7CSH4m/UxElrKKkqEC5fmytSVDJeHyCgDkiDoZTXJYw2tdVxqAmF8
         1eY+ir6JsFxJbVJeG27ZuN2TeYtDDQBfmjtlOCiQ=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190221042139epcas1p36f2b84a6e1d4bc84389307497cc54efb~FRkK-ihGe0956909569epcas1p36;
        Thu, 21 Feb 2019 04:21:39 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-9d-5c6e27537175
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.E0.04074.3572E6C5; Thu, 21 Feb 2019 13:21:39 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3 1/2] trace: events: add devfreq trace event file
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1550514069-9237-2-git-send-email-l.luba@partner.samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190221042138epcms1p76259d54fecdec5093b78651573076d71@epcms1p7>
Date:   Thu, 21 Feb 2019 13:21:38 +0900
X-CMS-MailID: 20190221042138epcms1p76259d54fecdec5093b78651573076d71
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmgW6wel6MwecLnBYbZ6xntbj+5Tmr
        xdmmN+wWtxpkLC7vmsNm8bn3CKPF2iN32S0uHVjAZPF5w2NGi30dD5gsDr9pZ3Xg9pjdcJHF
        o2XfLXaPg+/2MHm833eVzaNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403N
        DAx1DS0tzJUU8hJzU22VXHwCdN0yc4DOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUW
        pOQUWBboFSfmFpfmpesl5+daGRoYGJkCFSZkZ3y6d4+14AxLxZxfE1gaGO8wdzFyckgImEjM
        eLWPDcQWEtjBKPF0uXkXIwcHr4CgxN8dwiBhYQF3ieW7mlkhSpQkGm7uY4aI60t0PNjGCGKz
        CehKbN1wlwXEFhFYxigx9611FyMXB7PACyaJB+fOMkHs4pWY0f6UBcKWlti+fCtYM6eAl8Sr
        ly+gakQlbq5+yw5jvz82nxHCFpFovXcW6mZBiQc/dzPCzJkx5T/UzGqJRz0XmUEWSwi0MEqs
        mrkNaqi+xJm5J9kgHvOVeHkfLMwioCrx9vwKqBIXiV2L34HZzALyEtvfzmEGKWcW0JRYv0sf
        Iswn8e5rDyvMKzvmPYFqVZM4tHsJ1MkyEqenL4Q600Ni29bLbCDnCAlcZJRoOLOHZQKj/CxE
        8M5Csm0WwrYFjMyrGMVSC4pz01OLDQsMkSN0EyM4dWqZ7mCccs7nEKMAB6MSD++GiNwYIdbE
        suLK3EOMEhzMSiK8h0TyYoR4UxIrq1KL8uOLSnNSiw8xmgI9PZFZSjQ5H5jW80riDU2NjI2N
        LUwMzUwNDZXEedc7OMcICaQnlqRmp6YWpBbB9DFxcEo1MJ56K7N0+4/5hz//DeS/UrvhJt9N
        x2dzUhaufsCxYmVzaN+Rb/tOZexJX/PyQ/90Limmn1nncn4meTklHEvW2pG6ZKvCiZtsxmoW
        DrcteH6VnWg67tz5pVXefunz0A7utqi30+JV5vsYx8UZa18yufjsDf9lm3vF156dfDv5M0uo
        TlxMwB31ptdKLMUZiYZazEXFiQCUiF1ZswMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190218182129eucas1p236fc8ccddd9a8cde25c15f7545276885
References: <1550514069-9237-2-git-send-email-l.luba@partner.samsung.com>
        <1550514069-9237-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190218182129eucas1p236fc8ccddd9a8cde25c15f7545276885@epcms1p7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>The patch adds a new file for with trace events for devfreq
>framework. They are used for performance analysis of the framework.
>It also contains updates in MAINTAINERS file adding new entry for
>devfreq maintainers.
>
>Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>---
> MAINTAINERS                    |  1 +
> include/trace/events/devfreq.h | 40 ++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 41 insertions(+)
> create mode 100644 include/trace/events/devfreq.h

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Thanks!


Cheers,
MyungJoo
