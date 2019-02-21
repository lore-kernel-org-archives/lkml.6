Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDA0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE342086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SDEIGviz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfBUE1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:27:04 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:14086 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfBUE1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 23:27:03 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190221042658epoutp0421690d662f4d6ee419c982c974649b96~FRo0zaU0_1151411514epoutp04q
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:26:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190221042658epoutp0421690d662f4d6ee419c982c974649b96~FRo0zaU0_1151411514epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550723219;
        bh=VeRXkuwADdRuNYqLNbFnFRHqNTGPlxafU3/1nLzImzI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=SDEIGviz3af+lVCPIn3z5joj9pr4/oPOzQKThclo6Q38kDZZATaOpNA4DgPxilsVn
         nRJZrrNO6BBkMqLpUMXE6S/44fxC+xiA2R9b815m6MAMwtDdkOmV/G/WmIM5slW+pd
         lrCQwfxEjx+fSN6ZOVv1bKfGO3SJXKFzdvz2NHkc=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190221042656epcas1p34221422488852fad36a2f17385ae9483~FRoy2b0WY2689826898epcas1p3F;
        Thu, 21 Feb 2019 04:26:56 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-aa-5c6e289044a7
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.29.04288.0982E6C5; Thu, 21 Feb 2019 13:26:56 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3 2/2] drivers: devfreq: add tracing for scheduling
 work
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
In-Reply-To: <1550514069-9237-3-git-send-email-l.luba@partner.samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190221042656epcms1p1dbc8b4db8566003a8dd3ec6212343494@epcms1p1>
Date:   Thu, 21 Feb 2019 13:26:56 +0900
X-CMS-MailID: 20190221042656epcms1p1dbc8b4db8566003a8dd3ec6212343494
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29nmUVsd5+3TLtqBQg2dR52dLpal1KEshSCijHnQDzW3s7Ez
        7SLBCEsRC4Mim1ralQzxQupwYjY1MtNQKdFQplMMvCEW3aldqX/P9/C+z/O87/fimLRWHIzn
        cjqk5VglKfYStnaHyyLLw7j0aH1lLN1U0SCiRz/PieiBywse9Lh+Iz3SXiWmV6/1ALq+Z8KD
        Hu6qEdCrjVZAd5ZYBHT3QrEo0Zup1A8JmaLOcQ/m5VKHgFnufC9mrj+vA8xq8+Y08am8PTmI
        zULaUMRlqrNyuewE8shxRZJCHh9NRVI76R1kKMeqUAKZnJIWeTBXaYtHhhawynwblcbyPCnb
        u0erzteh0Bw1r0sgkSZLqdmpieJZFZ/PZUdlqlW7qOjoGLmtMCMv5+mbY5qrwvNzpUViPTBi
        pcATh0QcnJ6bBaXAC5cSRgB7l17YHjguIXzgb6OvvcaXSIXvbs0DO5YSJNSPdWJOXgZLLK0O
        XkxEwpbGCaEd+xGPAaxe3G3XxIhPAmgZHBA4zSSwonhW6MQbYNuTFkezJ3EYWstmXDX+cOzZ
        oocbL7+6B5zYD16ZHHCF9oGW7ybg1qm4+celWQiny4YwuzEkigCsu9PqEpXBt9V9YjuWEEfh
        0s96h5CQ2AonXze6RJPhfPmUQwgjQmDbYhVmXwRGhMOGdpmTXgeXvpSJ3LMY77ozb4Nm00NX
        5o2w/3atS5KBo/0zruUOAbgyPycqByGGf/s1/Odm+OdWA7A6EIA0vCob8ZQm7v8fbQaO84yg
        jaBjMMUMCByQayWNJ1XpUhFbwF9QmQHEMdJPYvbj0qWSLPbCRaRVK7T5SsSbgdw29A0s2D9T
        bTt2Tqeg5DGxsbF0HBUvpygyUNKQmJQuJbJZHcpDSIO07j4B7hmsBy37F1NLKNXkgXP7GANK
        vqNYn7pJfUgXZDHd7jtx8hrHT1gLFtok3FCXqMn/dGCg0j/xg/Vs6dSGFd0j1GJigr5Zg/f+
        wPoLk84s7xP8GvGOevzK9DWxXbOmtnc4/v4L9cdqwYOyLZtaL4XHDR8Oy9gx9bqvypC7q6Je
        FpAg3V5MCvkclorAtDz7F4CGmVG0AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190218182129eucas1p1804530445570fc73af89ed46b9a448b9
References: <1550514069-9237-3-git-send-email-l.luba@partner.samsung.com>
        <1550514069-9237-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190218182129eucas1p1804530445570fc73af89ed46b9a448b9@epcms1p1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>This patch add basic tracing of the devfreq workqueue and delayed work.
>It aims to capture changes of the polling intervals and device state.
>
>Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>---
> drivers/devfreq/devfreq.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>index 0ae3de7..660365a 100644
>--- a/drivers/devfreq/devfreq.c
>+++ b/drivers/devfreq/devfreq.c

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>



