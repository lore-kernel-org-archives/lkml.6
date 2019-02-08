Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A42C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708492146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3SKHIz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfBHCBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:01:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42185 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfBHCBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:01:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id m6so914639pfa.9;
        Thu, 07 Feb 2019 18:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rCXYuL2yAB+lK2US45/0mGxsgwjtq+ulyYDwTWv61C0=;
        b=t3SKHIz8BoD7qGbeZngs12TnU5mv/oLSbdc3Aa4Sy5LggK3MnB3vo20Wgn/o/cg98k
         60NDhIa35S38Duzo9bU4OjSFSG7A8G3CtfRtFlF3MtpfteAtnbgENz0TZlv2GGP+pCJT
         LnA6Ne57lzA8S7HJpc83udB2BNF/emDruyTW31yikjUkh+/ITkE7c8cpFNmFoJiJBuFl
         Pwe8PtHUg6XbGhqTolyhZO6vEn7EZhkMYRI9xUQc3CFbbZPfwFZECmeiPDGsjtYd8+xa
         wgYmeyFW/5NonKtjaLD0dyUp/BslcoGtsrUAsxWRNOkhl9w/0T9mbuwDy+q2Tqh37YhW
         Xtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rCXYuL2yAB+lK2US45/0mGxsgwjtq+ulyYDwTWv61C0=;
        b=RxErkFDtkCPX7QGMfsW8ZQ/SEIKS2VtSF68QNKBZ+jM9IMQXrPymcnhSPOQeDBp4S4
         js7zhEp3uVgUhoH3fivDalsxlC3p97iPEXplVp6DS0C8pv6eNmOxBO7Hjy1tvMK8p+YY
         wQCW4M2vmwr1oKaePIkViZy5XfjDWb7x5EFcW95R8PaLi8VF76cfSlFrY9dtVcmXQWD3
         bCvREpiFhHyOv3ozflNv7SBTWsH1k8FZ3VVMMeaeIsEhBK/MVDBHuvMh1RqcxEphKQRZ
         l98hzXsoviGuXx36SgD6yEkI3jN5+s6wRxMgEmU9Rj43nYucBVP+dXhpSsSpP/d1B/Ci
         wKeQ==
X-Gm-Message-State: AHQUAuZFybJcq5PdZ0jakFX8SMccI8piO03hrFH2f21dqlERvLxoOy8u
        oSYCB1MWY1D9oTHvjkefUpQ=
X-Google-Smtp-Source: AHgI3Ia3XMfxae7D9RdSp4kC4yA9+lfsmjUeA4uj2E54LxMcvUG1ISZrl0dFGrEqvsX9Bjqbzxa4Og==
X-Received: by 2002:a63:ce08:: with SMTP id y8mr13032128pgf.388.1549591301268;
        Thu, 07 Feb 2019 18:01:41 -0800 (PST)
Received: from localhost ([110.70.55.31])
        by smtp.gmail.com with ESMTPSA id q5sm588767pfi.165.2019.02.07.18.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 18:01:40 -0800 (PST)
Date:   Fri, 8 Feb 2019 11:01:37 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        dyoung@redhat.com, sergey.senozhatsky@gmail.com, pmladek@suse.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
Message-ID: <20190208020137.GA22600@jagdpanzerIV>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing Steven

  https://lore.kernel.org/lkml/20190207124635.3885-1-mpe@ellerman.id.au/T/#u

On (02/07/19 23:46), Michael Ellerman wrote:
> Arch code can set a "dump stack arch description string" which is
> displayed with oops output to describe the hardware platform.
> 
> It is useful to initialise this as early as possible, so that an early
> oops will have the hardware description.
> 
> However in practice we discover the hardware platform in stages, so it
> would be useful to be able to incrementally fill in the hardware
> description as we discover it.
> 
> This patch adds that ability, by creating dump_stack_add_arch_desc().
> 
> If there is no existing string it behaves exactly like
> dump_stack_set_arch_desc(). However if there is an existing string it
> appends to it, with a leading space.
> 
> This makes it easy to call it multiple times from different parts of the
> code and get a reasonable looking result.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

You probably can have a __init buffer somewhere in ppc code, append
data to it, step by step, and call dump_stack_set_arch_desc() all
the time.

But no real objections; dump_stack_add_arch_desc() can do.

FWIW,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
