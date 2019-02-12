Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1057222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ilwFCC63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfBLSRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:17:20 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:23931 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfBLSRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:17:20 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190212181716epoutp02470ad282c956909eb1596f82921389b8~CsKMuRkas0297202972epoutp02c;
        Tue, 12 Feb 2019 18:17:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190212181716epoutp02470ad282c956909eb1596f82921389b8~CsKMuRkas0297202972epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549995436;
        bh=ODGOMFOmG6VwcdZrNR7ru+sSI8QnZNaR412u3nHxWh8=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=ilwFCC636DIP7jxqjU4zk4V0hpYfIJEfPqkvigZJONlFkhU6CXVoS6F/C5W1eMlIu
         7dGkE0i/TlWlgRA3PtG+wkIvQvFslGGKsfgmO3f+nr9iDOuai1jh2qI5ihXhHLJ56C
         wAyV5K0FgjWKKXoNi05SwIxLZssMBiT3nwf3ZyhU=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190212181716epcas2p29f5712a7eea769acea58f148f433b170~CsKMG2Gyo1890818908epcas2p2j;
        Tue, 12 Feb 2019 18:17:16 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.1D.04136.BAD036C5; Wed, 13 Feb 2019 03:17:15 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190212181715epcas2p3ccff8e32af14578c21ee754292de25b1~CsKL0aco_0294502945epcas2p3V;
        Tue, 12 Feb 2019 18:17:15 +0000 (GMT)
X-AuditID: b6c32a46-2bfff70000001028-c0-5c630dabde08
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id B7.50.03689.BAD036C5; Wed, 13 Feb
        2019 03:17:15 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMT00BMYS4N3990@mmp2.samsung.com>; Wed, 13 Feb 2019 03:17:15 +0900 (KST)
Subject: Re: [PATCH 00/22] ASoC: dmaengine updates, secondary CPU DAI for
 Odroid boards
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <7289d7f5-3ca3-c932-e1e8-bef0eb727226@samsung.com>
Date:   Tue, 12 Feb 2019 19:17:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <20190212164032.GH20635@sirena.org.uk>
Content-type: text/plain; charset="windows-1252"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZdljTQnc1b3KMQfM3S4srFw8xWWycsZ7V
        YurDJ2wW589vYLf4dqWDyeLyrjlsFjPO72OyWHvkLrvFxRVfmBw4PTZ8bmLz2DnrLrvHplWd
        bB59W1YxenzeJBfAGsVlk5Kak1mWWqRvl8CV0Tyln63gL3vFq+OvWBsY17F1MXJySAiYSFw8
        OZmpi5GLQ0hgB6PEwdtLoJzvjBJ7/79jhana2LCGBcQWEtjAKPH+Wh1E0X1GiaZrx5lBEsIC
        kRLHZzwEKxIRUJa4+n0vC0gRs8BVRomPP+aBFbEJGEr0Hu1jBLF5Bewkjv34DmazCKhKXFg/
        nwnEFhWIkDjc+w6qRlDix+R7YEM5BYwlXu+ZAjaHWcBAYsaUw0wQtrjEsfs3GSFseYnNa94y
        gyyWEHjMJrG48RjUCy4STdM/MEPY0hLPVm1khLCrJXZt74Zq6GCUaLmwHarIWuLw8YusEFP5
        JDoO/2XvYuQAivNKdLQJQZR4SMyeOp0REhTbGCUWrbrKNIFRZhaSw2chOXYWkmNnITl2ASPL
        Kkax1ILi3PTUYqMCI73ixNzi0rx0veT83E2M4OSh5baDcck5n0OMAhyMSjy8K44mxQixJpYV
        V+YeYpTgYFYS4U1jTo4R4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvtQem60kEB6YklqdmpqQWoR
        TJaJg1OqgfGgg+iU8L8WMVWL7sQe4atP4QqO3xk0+dSxP+/7Uz8uOyChZLbwxY+YC5kXrt8x
        D9ozo+BWmGqfXUT4kWO7Su5d1PL+qLT0VLJ0hPyzcHtrlZqgup5fLMxXLfgZf4rxXV9mM//n
        1Zv3yu86nOvmLeeTyFn/oO7Fn/X2r0Vm3lm+/PZhF9fCaflKLMUZiYZazEXFiQDNSXa2GgMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t9jQd3VvMkxBhNvalhcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktLq74wuTA6bHhcxObx85Zd9k9Nq3q
        ZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujOYp/WwFf9krXh1/xdrAuI6ti5GTQ0LARGJj
        wxqWLkYuDiGBdYwS527cY4RwHjJKTLq2mrmLkYNDWCBSYv2NCpAGEQFliavf94I1MAtcZZS4
        2rKNDaJhB6PEro2LGEGq2AQMJXqP9oHZvAJ2Esd+fAezWQRUJS6sn88EYosKREh8fLqPCaJG
        UOLH5HssIDangLHE6z1TwBYzC+hJ3L+oBRJmFhCXOHb/JiOELS+xec1b5gmMArOQdM9C6JiF
        pGMWko4FjCyrGCVTC4pz03OLjQqM8lLL9YoTc4tL89L1kvNzNzECI2PbYa3+HYyPl8QfYhTg
        YFTi4V1xNClGiDWxrLgy9xCjBAezkghvGnNyjBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe/vxj
        kUIC6YklqdmpqQWpRTBZJg5OqQbGZnfRJb/WPP67quGW16y3ShYPD16wmzPHaPed7hsn5Yy1
        tj9jTdHbc0u97SJL+E51JZegiScPbqpxc3scPWGaUdahRkH7Hq9CeTXWMF+d4niOgDXn37jm
        my2yrzJiFvvLUXS8ZNfKU69K3PferW7aL56ZEbFETv8qc/gv5mO/e9jr54duP+KoxFKckWio
        xVxUnAgAwjDtU4gCAAA=
X-CMS-MailID: 20190212181715epcas2p3ccff8e32af14578c21ee754292de25b1
CMS-TYPE: 102P
X-CMS-RootMailID: 20190207170044epcas2p3d00762663b971845bc86db84af7d3b23
References: <CGME20190207170044epcas2p3d00762663b971845bc86db84af7d3b23@epcas2p3.samsung.com>
        <20190207170028.720-1-s.nawrocki@samsung.com>
        <20190212164032.GH20635@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 17:40, Mark Brown wrote:
> On Thu, Feb 07, 2019 at 06:00:08PM +0100, Sylwester Nawrocki wrote:
> 
>> I am not entirely sure we should be removing the
>> SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag like this, it might all
>> be a bit more explicit with the flag.
> 
> I'm fairly happy with what you're doing here and the Samsung driver is
> the only user so the view of people working on that is pretty important
> here.  I've gone ahead and applied the first few patches so they don't
> need rereviewing, the rest looked fine modulo the comments from
> Krzysztof.
 
Thank you, I've just resent the whole series with Krzysztof's comments 
addressed and with few more clean up patches added.

I've found one minor problem with the Odroid machine driver patch - 
limiting sampling rate to same value on both PCMs doesn't work properly.
I've got a patch fixing that almost ready and will post it tomorrow as
a folow up or v3 of "ASoC: samsung: odroid: Add support for secondary 
CPU DAI".
