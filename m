Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D91FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E862E2183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864914;
	bh=SiRcfik1pVaO3bE4OkY/xyU6gni6O8s244uihLl493U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ur/Gu4sOcL2RXLyCRkbjKXX/Bmo01T1qrvjvz7hkDJ1bBsjMSb98+3wQEsZ5+YlYk
	 /Bjt3dnJX1CRA6xwVQxmKBRNuqg4jUuMLbPDCr0SqitHWrHO1gAjGEMwaRlrlpDIXk
	 lI4AtvO564C74eGeHgmTsmtx9MVehXeNXnA+Di7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfAGMlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbfAGMlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:41:49 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC2A021873;
        Mon,  7 Jan 2019 12:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864908;
        bh=SiRcfik1pVaO3bE4OkY/xyU6gni6O8s244uihLl493U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lD3p6X96GWJ6fMsg5YLPQ1uh9t2b6jx0FzCoV4UuAchjkJGIcegOLt+lDEBllOuDc
         19t1iXWwZvhWbzr/tUMIsN/c+WKN5QBrGVxijcARALI6mZ3LQMZxD9s3RHfy5thvvM
         UvabOYDMABdFNnfWxZ+LX+5dLVEaOP5AjhMKmObA=
Date:   Mon, 7 Jan 2019 18:10:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: use struct_size() in kzalloc()
Message-ID: <20190107124017.GH13372@vkoul-mobl.Dlink>
References: <20190104173215.GA29029@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104173215.GA29029@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-01-19, 11:32, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.

Applied, thanks

-- 
~Vinod
