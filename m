Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8964BECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 00:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505C520827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 00:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rUny8L6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505C520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeJ2J3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 05:29:47 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:55383 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeJ2J3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 05:29:46 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181029004326epoutp03b908baa2950bd0e2c7621fab37fffde8~h7Z0IV4QP1834418344epoutp03r;
        Mon, 29 Oct 2018 00:43:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181029004326epoutp03b908baa2950bd0e2c7621fab37fffde8~h7Z0IV4QP1834418344epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1540773806;
        bh=xa/NeqQDx+fO+blCfxTV+Eo3ar9024/Ej0UIY3/D8ps=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=rUny8L6H/Dw2/ZBwseHBnOn4qCpPWArkAmmHQziXrfnCswmpKSvc4QMEdUTA+U8x0
         jIpa0dBWlvxc5AildbHNcYUzg9+vMw6miPRV9qsy4qWPB4FkcGgrROHlTTlXaDcGRN
         ldqVbMJYo2Z4qxFZ6oCe+gnJwKI8ikd8ZaBUAj1Q=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181029004323epcas1p222743bfc0c2e37a436a6e6b9f8bfbd2c~h7ZxO0Zqg1687816878epcas1p2i;
        Mon, 29 Oct 2018 00:43:23 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.CB.04072.BA756DB5; Mon, 29 Oct 2018 09:43:23 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181029004322epcas1p4ddca49d3d523f9daee296a63edcf7371~h7ZxCaTCH2098320983epcas1p4V;
        Mon, 29 Oct 2018 00:43:22 +0000 (GMT)
X-AuditID: b6c32a35-3f1ff70000000fe8-8f-5bd657ab3a4b
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.CF.03701.AA756DB5; Mon, 29 Oct 2018 09:43:22 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PHC005WH4OAEO70@mmp1.samsung.com>; Mon, 29 Oct 2018 09:43:22 +0900 (KST)
Message-id: <5BD657AA.1080108@samsung.com>
Date:   Mon, 29 Oct 2018 09:43:22 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Sangbeom Kim <sbkim73@samsung.com>
Cc:     kernel-janitors@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 6/8] clk: s2mps11: constify clk_ops structure
In-reply-to: <1540619262-22681-7-git-send-email-Julia.Lawall@lip6.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmge7q8GvRBs872Sw2zljParHswWlG
        i623pC3On9/AbvGx5x6rxeVdc9gsZpzfx2Rx8ZSrxcUVX5gs/l3byOLA5fH+Riu7x6ZVnWwe
        e7dkefRtWcXo8XmTXABrVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
        qq2Si0+ArltmDtBJSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8
        dL3k/FwrQwMDI1OgwoTsjAU7P7MWHOComL39JlMD4we2LkZODgkBE4m9j88zdzFycQgJ7GCU
        mPX8HyOE851RYtLHxawwVdvuPQazhQR2M0qc77QDsXkFBCV+TL7H0sXIwcEsIC9x5FI2SJhZ
        QFNi6+717BDldxkl7lz2BynhFdCS6JzrARJmEVCVOH70MxOIzQYU3v/iBtg9/AKKEld/PGYE
        sUUFIiR2zv8GNkZEwFtixcYrbBDjNzFJLG1IA7GFBRwlttyYB3YZp4CrRPO9o1AXP2aT+N0l
        D2G7SPzZdJ8FwhaWeHV8CzvIORIC0hKXjtqCfCsh0M4o8eVFMyuEM4FR4sOpzUwQDcYSzxZ2
        MUEs5pN497WHFaKZV6KjTQiixENiV8NVaBheZpSY8+E00wRG2VlIITQLEUKzkEJoASPzKkax
        1ILi3PTUYsMCQ+So28QITntapjsYp5zzOcQowMGoxMP7gPtatBBrYllxZe4hRgkOZiUR3hBp
        oBBvSmJlVWpRfnxRaU5q8SFGU2AQT2SWEk3OB6bkvJJ4Q1MjY2NjCxNDM1NDQyVx3idSc6OF
        BNITS1KzU1MLUotg+pg4OKUaGMWblvr1ciofOrUmY7PXxF+BFSUOZS7iSoZiPosOhbQfdn0Y
        8KOhVbrVRs+OVaqj1rhzxRzJi74Mapf0vyQeP+AgvfL4PcVflyKbP8YZsfFqNax1vrehTDlM
        W2tuyvrVnB9PX9G+aftGu2yr0sWZB4WVa4LeVYarzYvK/Mzxycn/7dKjT+dZKLEUZyQaajEX
        FScCAHJ34ZyRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jAd1V4deiDboOGVlsnLGe1WLZg9OM
        FltvSVucP7+B3eJjzz1Wi8u75rBZzDi/j8ni4ilXi4srvjBZ/Lu2kcWBy+P9jVZ2j02rOtk8
        9m7J8ujbsorR4/MmuQDWKC6blNSczLLUIn27BK6MBTs/sxYc4KiYvf0mUwPjB7YuRk4OCQET
        iW33HrN2MXJxCAnsZJSYe2UqWIJXQFDix+R7LF2MHBzMAvISRy5lg4SZBdQlJs1bxAxRf59R
        Ysaq6UwgNbwCWhKdcz1AalgEVCWOH/3MBGKzAYX3v7gBNpJfQFHi6o/HjCDlogIREt0nKkHC
        IgLeEis2XmGDGL+JSWLSpXoQW1jAUWLLjXlQp11mlPj5cjsLSIJTwFWi+d5R1gmMArOQXDoL
        4dJZSC5dwMi8ilEytaA4Nz232KjAMC+1XK84Mbe4NC9dLzk/dxMjMAK2Hdbq28F4f0n8IUYB
        DkYlHt4H3NeihVgTy4orcw8xSnAwK4nwhkgDhXhTEiurUovy44tKc1KLDzFKc7AoifPezjsW
        KSSQnliSmp2aWpBaBJNl4uCUamDkLS4WFlaxuPSO4/LFDaV8riLnY5c8CkmX/S00aetNg6nJ
        iq1b776/LfavZbdOs7pizFaNpgcP/tQ9NnRaxceYwJ7Ao/z8sev59R/Orud9cetYooeHbJKU
        7z0TpXfK3yxNNYqsTh490ZwiKCTwhbFb7Z3+VebCL3vO8y5sm6N+qXlRTmHn6qVKLMUZiYZa
        zEXFiQBodC1UfAIAAA==
X-CMS-MailID: 20181029004322epcas1p4ddca49d3d523f9daee296a63edcf7371
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181027062328epcas3p1aed374207b7d5da30147ceea33585b67
References: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
        <CGME20181027062328epcas3p1aed374207b7d5da30147ceea33585b67@epcas3p1.samsung.com>
        <1540619262-22681-7-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 10월 27일 14:47, Julia Lawall wrote:
> The clk_ops structure is only stored in the ops fields of
> clk_init_data structures.  This field is const, so the clk_ops
> structure can be const as well.
> 
> Identified and transformed using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/clk/clk-s2mps11.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
> index 5b419b82f7ca..2ce370c804aa 100644
> --- a/drivers/clk/clk-s2mps11.c
> +++ b/drivers/clk/clk-s2mps11.c
> @@ -71,7 +71,7 @@ static unsigned long s2mps11_clk_recalc_rate(struct clk_hw *hw,
>  	return 32768;
>  }
>  
> -static struct clk_ops s2mps11_clk_ops = {
> +static const struct clk_ops s2mps11_clk_ops = {
>  	.prepare	= s2mps11_clk_prepare,
>  	.unprepare	= s2mps11_clk_unprepare,
>  	.is_prepared	= s2mps11_clk_is_prepared,
> 
> 
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
