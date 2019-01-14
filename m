Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE497C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB73820660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpLH4LRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfANJTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:19:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41168 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfANJTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:19:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so10071244pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 01:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NKxgYoIUcONgbn8ufUpcNn9ZL20a+ylRBVSbkZW3TEY=;
        b=VpLH4LRcoO6Zjsq8bpGf/7JP6fVTCBxALOVWuhGEtxgKz3T5nKIA7ukHbtJ/75a9IW
         5/Upibc1vEQGhsRT3EYFRcU/ciGxhG/qRQD7JyLRsUakBRgWYWQTCJjihPdY4dJcsUgo
         /4OWAd1+HFOAmFbr/vtoN8B1ckpaBuxHcb0Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NKxgYoIUcONgbn8ufUpcNn9ZL20a+ylRBVSbkZW3TEY=;
        b=A30EDv6BG9pjf6+n0yFyBnHan7Q0QTBftyEQlNtYdO+1EQvIeOHABGt3zTgtf7PIDu
         I94nCa6rZOwbeaIHte1VOxdOM+NufUVqwapQjo0rrwfxWh5uBhASyf6X9F6iYhrNGDvn
         HIcOCocCyKLmLyf/+YcrQL4n47iphGYjvoADImEEBr6tphAkzBiX0uo0mZJsCdZ5whok
         y3xp+1kCFpjRlEr8RxYWbBTRyh8Vg7P+KMUf12gmIuP4XJZwaXOj+/OMCfaRPzWZUQ8x
         ubsCeTM6r2e9u+VOJwPIPtvUQhlDCbRZhYxn8eTC+ympsEABbZ19knbGjlR7cr8eKgE5
         7BTw==
X-Gm-Message-State: AJcUukccX4xqUh8f++1Y5t0PHUIJP0ImEkdOYDFotlNU5ctEgXXnhlFm
        nRBKEkRxotFmJyCOwPu40YKD
X-Google-Smtp-Source: ALg8bN4hHNIddDDH2wJowj13Ec3GzhUcCxPt7u0SyCRXCXQNXkASOZkydHFVl7H+jB/Yt6/LVH7b3Q==
X-Received: by 2002:a62:7c47:: with SMTP id x68mr24767559pfc.209.1547457539354;
        Mon, 14 Jan 2019 01:18:59 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6306:f12b:7d9b:d1a4:6536:aa21])
        by smtp.gmail.com with ESMTPSA id l19sm191860928pfi.71.2019.01.14.01.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 01:18:58 -0800 (PST)
Date:   Mon, 14 Jan 2019 14:48:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     afaerber@suse.de, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/6] Add clock support for Actions Semi S500 SoC
Message-ID: <20190114091850.GB13162@Mani-XPS-13-9360>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <154724706468.169631.2903523518830581075@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154724706468.169631.2903523518830581075@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Jan 11, 2019 at 02:51:04PM -0800, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2018-12-31 10:55:11)
> > Hello,
> > 
> > This patchset adds common clock support for Actions Semi S500 SoC of
> > the Owl family SoCs. This series is based on the initial work done
> > by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/
> > 
> > Since there isn't any update from him for long time, I took the liberty
> > to modify his patches, address review comments and send to list for review.
> > 
> > This series has been tested on Allo Sparky SBC.
> > 
> > Thanks,
> > Mani
> > 
> > Edgar Bernardi Righi (1):
> >   dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU
> > 
> > Manivannan Sadhasivam (5):
> >   clk: actions: Add configurable PLL delay
> >   ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
> >   ARM: dts: Remove fake UART clock for S500 based SBCs
> >   clk: actions: Add clock driver for S500 SoC
> >   MAINTAINERS: Add linux-actions mailing list for Actions Semi
> 
> What's the merge strategy for these patches? Some are for clk, others
> are for arm-soc, etc. I see a sandwich of patches too so it sounds like
> I can't even take just the clk ones for fear of breaking something that
> the dts bits in the middle clear out of the way.
> 

As we did with previous patchsets, clk patches will go through your tree
and I'll take the ARM/MAINTAINERS patches through Actions sub-tree. Let's
target these for 5.1. Even if your patches reach first, there won't be
any regression with existing DTS.

Thanks,
Mani

