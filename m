Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3CBC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AA321019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQgiNJPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfAWLnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:43:23 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41240 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfAWLnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:43:23 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so1510712oii.8;
        Wed, 23 Jan 2019 03:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILcWHxcP0qhSay7gUW5VzM53ZiAeTz5VkQpRMgjnh1U=;
        b=aQgiNJPXU+P8Zwgk4ezR5xhpiSQkWxI3uOZdEc5RmxJcner22r8/v9kH9+kdi/i5/M
         2hfH/ZnGFC+O1obTpCLGhq9WN1qWfj3Gc9E6PBir5QSd/YWqynreAKOsdK6qc56j9wiB
         B2FsACt2d6GdkCFdLp2imLVlzdNgT3iBuAH4yZual1a0DY+l0ECsQcRuT69ZrOe6wykr
         YU2qsyKR26fxbv+No/xEK+OutQk/g4jBPupS+ECTbWQx+dWsjwnGQctTdqpga0hKXAPL
         4Xth1cA+Z0aiPbnl9YwqyuqYHsHmsOO0eFzJ/NTTvEjjAwDsjrtusc1pSB9v9QXyl31i
         ivrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILcWHxcP0qhSay7gUW5VzM53ZiAeTz5VkQpRMgjnh1U=;
        b=Lv9cmpMHphz6b5IIj7/ak/Y04YQEXBlZhw+wBxfjWZ5ZRjXi0Rtymp4PMVxfvjRjaq
         d7PR1Vxx9e37dm1y29pSDOofaZmefWEuq9NUePPLo8rK5sPLx+2C719d+sbqqg4ZeHaT
         RlYdLM616lr9pKx7fv2q2WlK7sIilePB74yZDAwAlNE2VV6Ao1W0z39KE3YYtr1wp+OF
         N7a6drCotNrmH/GN/ei2jSKR+UuHlcV5VtSCUGH64Cfonv+1eL8vW4Rq/HP6/6vbtkxa
         T86b2q7hyMKMwhjWtRs1uDyimxXq78dicmTZvzngn0aV6vHLddzqmGH0GMJTBdtMQTdS
         oU2g==
X-Gm-Message-State: AJcUukfVzRWWo0/rGOfPJUYoVoZikUeSULMjUk02vC/Dui7OnpXWSr0Y
        BQ/bNGyOh4JHEA1yJyF51JSVYQbOj5nHOl1E+BQ=
X-Google-Smtp-Source: ALg8bN6ah1Du4sDVxp0GJCEYzMxzQUKAhP+rp/mOwpFLgdaEMDr8oVaVhYdgCN7w5dUWqFzFlwaN66T3EtgfTGqyXos=
X-Received: by 2002:a05:6808:296:: with SMTP id z22mr1231469oic.67.1548243802777;
 Wed, 23 Jan 2019 03:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20190115171523.702-1-leonid.iziumtsev@gmail.com> <20190120105257.GP4635@vkoul-mobl>
In-Reply-To: <20190120105257.GP4635@vkoul-mobl>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 23 Jan 2019 09:43:19 -0200
Message-ID: <CAOMZO5Bn0zHLNyVgJyo5cAj=8E=8PLydnWvqVvH2j5g9zhinhA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: imx-dma: fix wrong callback invoke
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Leonid Iziumtsev <leonid.iziumtsev@gmail.com>,
        dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Sun, Jan 20, 2019 at 8:54 AM Vinod Koul <vkoul@kernel.org> wrote:

> This looks reasonable to me and I think should go to stable as well.
> Fabio can we get some testing done on this patch

I currently don't have access to a mx25pdk board. Will probably get
access to it next week.

Patch looks good though.
