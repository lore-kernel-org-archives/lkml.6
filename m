Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F08C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254B620657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OiUzYzh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfAQJSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:18:24 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44899 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfAQJSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:18:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so7721911edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 01:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TbC5ugNB2Sa8RrbjnuWFYz8/+NGYQmf7yxC+1mkduYw=;
        b=OiUzYzh4KtdcJHhwyHqCsPuU14uYxYI2ae2Egzt4X/MlVIq9FozYWNzfq/AMO7VrBt
         hy7r/FZrBWSa9inP4hwg/FKRehAbfgNQ8GIb+pX7EGmdKnb42jYszZf14FMg4foShpsU
         0NAwJpIMxKiwd3pwwDkyLSJmTRmeweARVXjDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TbC5ugNB2Sa8RrbjnuWFYz8/+NGYQmf7yxC+1mkduYw=;
        b=W8celwYa/swgevwZuxfWL2INqqqkA8q0E6basfGrWWvewCKV0TVB4sHXA+dh+50V2B
         cfAz/R68zgqRpZV0L4F3wbuZQ3M5QKAkF0WPH1VgZbc8kuts9wJ7JmBn7mxOQj6JN1GK
         38SbQrHrkEdmivuqCXfCc5heoyDZqeJCa4JA8l0XXMX1P8e3H6LnS2XbIRflfvfrGSGa
         /tgfq4n8y8kbBwO6Dm/tGFx4oxCBjmsClBK+3wLEXzuxDIIUIawPdHP8Y97WxtiG7Cl+
         qLV73dTWA718vcTLGWcsTEUJDET/G1b8oiLeYvaupu6u46hDslFEtLEnIYO8OW7+mdHv
         xyeQ==
X-Gm-Message-State: AJcUukdH52Ia03//T/qtscKtvxn9kR7CRjTQoJva9pdb68AjALey/FvZ
        G0oOTgN/K6oFiLvqsXluIOQLXA==
X-Google-Smtp-Source: ALg8bN6Sxej+TEXoD9E65eEug4T1DZrGXrM+q3A4qh6DaL+YSlSq63EpyRmy5C0+AvGHnHvGLdvZqw==
X-Received: by 2002:a05:6402:121a:: with SMTP id c26mr10635290edw.104.1547716699507;
        Thu, 17 Jan 2019 01:18:19 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p22-v6sm3372586ejb.76.2019.01.17.01.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 01:18:18 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:13:08 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] dma-buf: Fix kerneldoc comment for struct dma_fence_array
Message-ID: <20190117091308.GA3271@phenom.ffwll.local>
Mail-Followup-To: Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
References: <20190116153436.3b244cda@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116153436.3b244cda@lwn.net>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 03:34:36PM -0700, Jonathan Corbet wrote:
> The kerneldoc comment for struct dma_fence_array lacks a description
> of the "work" member, leading to this docs-build warning:
> 
>   ./include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
> 
> Add a description and make the warning go away.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Applied for 5.1, thanks for your patch.
-Daniel

> ---
> Hopefully I've sent this to the right place; perhaps this file needs to be
> added to the MAINTAINERS entry?
> 
>  include/linux/dma-fence-array.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/dma-fence-array.h b/include/linux/dma-fence-array.h
> index bc8940ca280d..c0ff417b4770 100644
> --- a/include/linux/dma-fence-array.h
> +++ b/include/linux/dma-fence-array.h
> @@ -40,6 +40,7 @@ struct dma_fence_array_cb {
>   * @num_fences: number of fences in the array
>   * @num_pending: fences in the array still pending
>   * @fences: array of the fences
> + * @work: internal irq_work function
>   */
>  struct dma_fence_array {
>  	struct dma_fence base;
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
