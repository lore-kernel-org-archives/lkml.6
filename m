Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB127C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48AC21904
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545339898;
	bh=7WuAmbJc9Lm4dnSeaR5VQIOInK8xJ5CsY1iFj/5eIM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nw/nXGRP7F33R7R5l0DLYPoDKvJKdEZHDq4yfMSz5/8c58DE/Fd5kwglSA1uSYz2q
	 XiRpXRysRQ8HwW/YGtVS5Xg6Dz5ei6FlegSNZDN0pOL0vLoKorLxg4GPnOwDCQc7ya
	 PiApEqwombCsoqzdsQRWENQYsxSo5oXAPbTPGQGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389806AbeLTVE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:04:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44799 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbeLTVEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:04:55 -0500
Received: by mail-ot1-f67.google.com with SMTP id f18so3213390otl.11;
        Thu, 20 Dec 2018 13:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CA7djEAA600KqNCvJ4e0eFqNNGuJG9dE5uF6Jyr/JaE=;
        b=n1aM0ZalxHMhJQK+LQsSizaP1CmMnP3PWuhbzL5cZ2Y/l8t/+GGTGIvqWuec0dchUO
         U4aJpUCuTIAZoNyfxTknCQZ0XqgAqBtT2niuLl9QBlSpmLKQSDf9a7St0tXg6WFr4ltk
         3F7KNEjseV9+lhenX+OPJRRTmqhRk3l+p9l9EfC9rr2ppOzZc7fMIPji0AVk1dYX/NMC
         g4SaMC+uCqRs7wgkQ63P3wS6zhPF+1Vg2tV+nui/+yVsKWo6cIh4XqNiESEeoSK8QG3a
         J2u8fiFykNdF/XIrta3uCHQPGENCVnHd+8GrZv56pQ+zNym3VDjCKTvESbrxTXkiCRKe
         Q/Mw==
X-Gm-Message-State: AA+aEWYdJtH4++cFkNCsDWyjCn3wgE1HTnHotkCvzib/yeGAxrfowHWm
        8TGLGhDZ3FPGzViIm5Plug==
X-Google-Smtp-Source: AFSGD/U5x6Rzu5D0Jm/jXHfeqb3R0zJTX2Nn8ytiZyT1S7X/WMS5qCS6IDW2D7e+yDmalDR9P+sDZQ==
X-Received: by 2002:a9d:43a6:: with SMTP id t38mr19840747ote.213.1545339894600;
        Thu, 20 Dec 2018 13:04:54 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id g25sm6352160otr.30.2018.12.20.13.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:04:53 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:04:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/7] dt-binding: riscv: sifive: add documentation for
 FU540-based boards
Message-ID: <20181220210452.GA26977@bogus>
References: <20181215052154.24347-1-paul.walmsley@sifive.com>
 <20181215052154.24347-7-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215052154.24347-7-paul.walmsley@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 21:21:53 -0800, Paul Walmsley wrote:
> Add DT binding documentation for boards based on the SiFive FU540 SoC.
> The first board, the HiFive Unleashed A00 (FU540), is described here:
> 
> https://static.dev.sifive.com/HiFive-Unleashed-Getting-Started-Guide-v1p1.pdf
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  .../devicetree/bindings/riscv/sifive/fu540.txt         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
