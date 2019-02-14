Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4570DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09297222D2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HR26u753"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437780AbfBNJeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:34:18 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:29209 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbfBNJeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:34:18 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190214093415epoutp0414030988b83b8c7f807e43787d63a665~DMUHKZfZJ0870108701epoutp04K;
        Thu, 14 Feb 2019 09:34:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190214093415epoutp0414030988b83b8c7f807e43787d63a665~DMUHKZfZJ0870108701epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550136855;
        bh=uaPi7M30ctf1feqq52Mnqz+fil0NH6xi1AyPdVgfvbU=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=HR26u753wA8eV/XV+wk7HoQOwj4ljpUFRa2Zhh7he1GuNytvDTZFXzmypHLx0odXL
         t0a2GKBqSvP+vCfvF13+v8zIuwyExJXdiovxP6nq3UgcmQyhSTmYpFL6tz5RNidnIT
         pZqyQc3oGAwgZG1JgSVo1Ehym+OeXwtPK1WMR7k4=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214093415epcas1p143f05f8a1476a2b6167968fd660ecb77~DMUG8lFdw1370613706epcas1p1Y;
        Thu, 14 Feb 2019 09:34:15 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.F8.04074.716356C5; Thu, 14 Feb 2019 18:34:15 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190214093414epcas1p334dab08f4185005462419be75ac9c8da~DMUGw9A653103731037epcas1p3n;
        Thu, 14 Feb 2019 09:34:14 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-cc-5c653617bb80
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id B8.D3.04015.616356C5; Thu, 14 Feb
        2019 18:34:14 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMW00680T8ZO210@mmp2.samsung.com>; Thu, 14 Feb 2019 18:34:14 +0900 (KST)
Subject: Re: [PATCH v3 00/13] ASoC: dmaengine updates, secondary CPU DAI for
 Odroid boards
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <0ca54fa6-b043-8131-2e68-da5012a5df4d@samsung.com>
Date:   Thu, 14 Feb 2019 10:34:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7bCmga64WWqMQW8zm8WVi4eYLKY+fMJm
        cf78BnaLb1c6mCwu75rDZnFxxRcmBzaPDZ+b2Dx2zrrL7rFpVSebR9+WVYwenzfJBbBGcdmk
        pOZklqUW6dslcGW8W/2DpeAjY8Wpm8eZGhgPMHYxcnJICJhILJ3zlKmLkYtDSGAHo0TDgo2M
        EM53RolFvQfYYKr69qxng0hsYJRYfG8zlHOfUWLqr1lMIFXCAjES/6+3sYDYIgJiErfndDJ3
        MXJwMAtUSRzd7AwSZhMwlOg92ge2mlfATuLCvxnsIDaLgKrEnRXTWUFsUYEIicO976BqBCV+
        TL4HNpJTwFri39rnYPXMApoSL75MYoGwxSWO3b/JCGHLS2xe85YZ5DYJgTNsEi+mXWOG+MBF
        4mXPbDaQeyQEpCUuHbWFCFdL7NreDVXfwSjRcmE7VL21xOHjF1khhvJJvPvawwrRyyvR0SYE
        UeIh8bl5FdjrQgJ9jBJX7uZNYJSZheTsWUhOnYXk1FlITl3AyLKKUSy1oDg3PbXYsMBQrzgx
        t7g0L10vOT93EyM4MWiZ7mCccs7nEKMAB6MSD2+FUEqMEGtiWXFl7iFGCQ5mJRHei0apMUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR51zs4xwgJpCeWpGanphakFsFkmTg4pRoYVymJPi3e9jZg
        +n7rcwY7ZzI+E9nsk2Nvtvq07ipGLxmj97s6S7yK5n1svZy63mtDmtyC01fXTrgUZfWrVfee
        i4GMdwu77s2kSOFX0rYPbf+938azUyHc8a11tPdHdbt3CqkKD0JPmouYPhRj+7JOdep7LQ6f
        veEqsbsZv+nsX+SWFP/Xa4qaEktxRqKhFnNRcSIAcTMwDQgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t9jQV0xs9QYg9W3jS2uXDzEZDH14RM2
        i/PnN7BbfLvSwWRxedccNouLK74wObB5bPjcxOaxc9Zddo9NqzrZPPq2rGL0+LxJLoA1issm
        JTUnsyy1SN8ugSvj3eofLAUfGStO3TzO1MB4gLGLkZNDQsBEom/PerYuRi4OIYF1jBLT735m
        hHAeMkq0H+5l6mLk4BAWiJGYvyQXpEFEQEzi9pxOZhCbWaBK4uyn6awQ9RMYJVYfW84CkmAT
        MJToPdoHtoFXwE7iwr8Z7CA2i4CqxJ0VIA2cHKICERIfn+5jgqgRlPgx+R5YL6eAtcS/tc/Z
        QfYyC6hLTJmSC7FLXOLY/ZuMELa8xOY1b5knMArMQtI9C6FjFpKOWUg6FjCyrGKUTC0ozk3P
        LTYqMMxLLdcrTswtLs1L10vOz93ECAz8bYe1+nYw3l8Sf4hRgINRiYdXQSAlRog1say4MvcQ
        owQHs5II70Wj1Bgh3pTEyqrUovz4otKc1OJDjNIcLErivLfzjkUKCaQnlqRmp6YWpBbBZJk4
        OKUaGDtffTpwQeP7nBmLZpt+F1v5LFXXWUpHqvl/PFcNp/pdXsuiLYd1j1Uz5QrxBD8RPvOn
        7JPR/a0/f/lHZj5Z6+S2q31ixVf/7pp3J2p11ud+OfvXvb90GvPK/y9uXlIq+n6d87OFm2Xn
        vZDsrudyi1ziX97/U5E+7av0qpytq/2/dsnP3nqo2VSJpTgj0VCLuag4EQD24dlUeAIAAA==
X-CMS-MailID: 20190214093414epcas1p334dab08f4185005462419be75ac9c8da
CMS-TYPE: 101P
X-CMS-RootMailID: 20190213184252epcas1p131e1023b7f6ec280e880b160a4a96345
References: <CGME20190213184252epcas1p131e1023b7f6ec280e880b160a4a96345@epcas1p1.samsung.com>
        <20190213184212.5473-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 19:41, Sylwester Nawrocki wrote:
> This is a rebased version with the build break fixed and added 
> Krzysztof's Acks.

Please ignore this patch set, it contains wrong versions of few
patches on top, I will resend shortly. 
