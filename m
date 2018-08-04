Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EDFC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F828217B9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FtNx6tUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F828217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeHDJcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 05:32:21 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:22500 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeHDJcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 05:32:21 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180804073237epoutp04fa463aebcb96e5f4cb1f983b00fbb027~HnghwUM1c2420324203epoutp04l
        for <linux-kernel@vger.kernel.org>; Sat,  4 Aug 2018 07:32:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180804073237epoutp04fa463aebcb96e5f4cb1f983b00fbb027~HnghwUM1c2420324203epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533367957;
        bh=n1KwOO66Nk56cbrl+maJWjHsGriECtXjOvnpgVKnqwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtNx6tUjhScxPPNpR6pERVG2/Bs3iX1pnxnhUpaXnWLfrZUbYNZylI8LSAC2uCCW6
         ZobLMAEcp8sReZzX7iOtdpYH92MwElrUW02dqvYiS13MSaNzVTCA5kNh5jura++9ou
         c1CMVmpIAI5z/nZPCU112cKBwDgdI1JWqZr/Lgok=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.193]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20180804073235epcas5p46cdc75f89fd14e42e77f4225dbc08c60~Hnggc6Y-C2865928659epcas5p4G;
        Sat,  4 Aug 2018 07:32:35 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.6F.04304.396556B5; Sat,  4 Aug 2018 16:32:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20180804073234epcas5p4e3ed929df6b4d35c8831cb0fe3d98e58~HngfSE6Sd0407704077epcas5p4Q;
        Sat,  4 Aug 2018 07:32:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180804073234epsmtrp11d3b5b350ec08a7c1e0a4d639f98073c~HngfQqFO32501325013epsmtrp1L;
        Sat,  4 Aug 2018 07:32:34 +0000 (GMT)
X-AuditID: b6c32a4b-221ff700000010d0-fb-5b6556933fca
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.99.03759.296556B5; Sat,  4 Aug 2018 16:32:34 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.161.94]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180804073232epsmtip2bece2795310f8fd2faf0450c05de8f50~HngdvSWRi2726827268epsmtip2R;
        Sat,  4 Aug 2018 07:32:32 +0000 (GMT)
From:   Satendra Singh Thakur <satendra.t@samsung.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     sst2005@gmail.com, Satendra Singh Thakur <satendra.t@samsung.com>
Subject: Re: Re: [PATCH] drm/kms/crtc: Saving crtc->primary into a drm_plane
 pointer instead of dereferencing it every time. 
Date:   Sat,  4 Aug 2018 13:02:21 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180730133355.GB20303@art_vandelay>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmhu7ksNRog6+bDSx6z51ksrjy9T2b
        xc4Hu9gtLu+aw2ax8ONWFou151tZLO5uOMtosfz0dWYHDo/ZDRdZPHbOusvusf3bA1aPeScD
        Pe53H2fy2DlpL5NH35ZVjB6fN8kFcESl2mSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
        WpgrKeQl5qbaKrn4BOi6ZeYAXaakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVWKNjQ00jM0
        MNczMgLSprFWRqZAJQmpGafn1Bc8Z65oufCOvYHxP1MXIyeHhICJxKEJc5i7GLk4hAR2M0r8
        X3CGCcL5xCjxrHMPK0iVkMA3RonZd4xhOhruX2OFKNrLKHHgwVR2iKIvjBKv3heD2GxARc/n
        zAArEhF4yShxs+UMkMPBwSzgKrF0jhpIjbBAvcTsq9fAFrAIqEoc+byGFWKBnMTNc53MIDan
        gJHEnnUPWUDmSAhsYZN4emQ1G0iCV6BM4tzMz4wQDS4SvVMnsUHYwhKvjm9hh7ClJF72t0HZ
        kxklms/6QQxazShx9mIvVMJeomXKARaI4zQl1u/SBwkzC/BJ9P5+wgQSlhDglehoE4KoVpFY
        +eIwM8z4Pwu6oG72kJiycjYbJBxaGSV+tNpMYJSdhTB0ASPjKkbJ1ILi3PTUYtMC47zUcr3i
        xNzi0rx0veT83E2M4ISm5b2DcdM5n0OMAhyMSjy8DDUp0UKsiWXFlbmHGCU4mJVEeNMPAIV4
        UxIrq1KL8uOLSnNSiw8xmgIDcCKzlGhyPjDZ5pXEG5oamZkZWBqYGluYGSqJ837wC44WEkhP
        LEnNTk0tSC2C6WPi4JRqYNQvnrfjZo+hrkSjrEZH5nfuEgv+9rfHDzkmr3yed6/3z7mTd7jT
        J9TuWTxH9fDzFcwVrQbvsztefnD4eLKAyfT+zcKL11pCIw5rzmHr4Pyvfux7gqqqe0Rzkq63
        X6zK8bvWKuckOXv1NS7O5nZrfbSX/6zx/I2/TENFgh+dVU6KXnNp1uQvAUosxRmJhlrMRcWJ
        APgLoCR+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSvO6ksNRog/mNUha9504yWVz5+p7N
        YueDXewWl3fNYbNY+HEri8Xa860sFnc3nGW0WH76OrMDh8fshossHjtn3WX32P7tAavHvJOB
        Hve7jzN57Jy0l8mjb8sqRo/Pm+QCOKK4bFJSczLLUov07RK4Mk7PqS94zlzRcuEdewPjf6Yu
        Rk4OCQETiYb711i7GLk4hAR2M0pse9PACpGQklj2ZhsbhC0ssfLfc3aIok+MEs1b7jKCJNiA
        up/PmQHWLSLwllGidedpFpAEs4C7xL05v9hBbGGBWokLM96CrWMRUJU48nkN2AZeAVeJTzN+
        MENskJO4ea4TzOYUMJLYs+4h2BwhAUOJ0+uPsk9g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgx
        t7g0L10vOT93EyM4OLU0dzBeXhJ/iFGAg1GJh5ehJiVaiDWxrLgy9xCjBAezkghv+gGgEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYztB2/qSx8SENhv
        0lDoL1owdYF0+venhsps3MFv54q1rXlz7KNh5QsdRauOrs0TD5q0TBBObRZzWhxr7Zi28KOL
        Z7qTQNH8N5zlioxRnzz+ViruYZ2nw39RLn6P4ByLujCvi+KrlAoW7At68024IU8ox07ANOIp
        B9+2vRzRU1c39zWe2ahkp8RSnJFoqMVcVJwIAOT2soZKAgAA
Message-Id: <20180804073234epcas5p4e3ed929df6b4d35c8831cb0fe3d98e58~HngfSE6Sd0407704077epcas5p4Q@epcas5p4.samsung.com>
X-CMS-MailID: 20180804073234epcas5p4e3ed929df6b4d35c8831cb0fe3d98e58
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180804073234epcas5p4e3ed929df6b4d35c8831cb0fe3d98e58
References: <20180730133355.GB20303@art_vandelay>
        <CGME20180804073234epcas5p4e3ed929df6b4d35c8831cb0fe3d98e58@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 at 09:33:55 -0400 Sean Paul wrote:

>Maybe this is simpler, but not overwhelmingly so.

>To be honest, I'm a bit concerned with the volume of no-op patches you're
>sending to the list. I so appreciate and encourage your participation,
>but perhaps we could redirect your efforts. 
>Again, *thank you* for your patches, it's great to have you here.

>Sean


Hello Mr Sean,
Thanks for the comments , I will take care of this in future.
Thanks
-Satendra
