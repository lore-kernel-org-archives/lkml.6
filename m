Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D46EECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9F820840
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIpcGXOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9F820840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeGNJJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 05:09:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35725 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeGNJJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 05:09:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so17965665wrt.2;
        Sat, 14 Jul 2018 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DCsdCR13+M3joHpIL1owN+R21bV3ahrQ0Zmd++RQfGA=;
        b=qIpcGXOd3dfXcRRqcB94Oy+PrkQ2JK4A7j6PPN/NuPqZkgxwF2B5Y3Uy7c9fC+2pLT
         CxPyI+nI7Oh5VuVZoQbIRt+/YKsMnxcFOdOnVCunz0jNPrDgb8VwtslsDVlnAWttOjGn
         TkpC9U+zrBbaJKqbThc3EHB/4Oi3Lss9ta8/yu9hVEMpTLO4OKTjEGtnCGYXDqTllh9n
         NvILmkch2ZN0OjvzD+YEOGiI+mAvZOp6B3jCGqKpabDXKyD2HVO+GKBDncysemEqRV8k
         LlSqnkNbIuI/LuO5SM65k7/JzhZuxrOeJT2SRmTgEd7tBEMk7y+to0TlcDSHXjbyMTZN
         yo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DCsdCR13+M3joHpIL1owN+R21bV3ahrQ0Zmd++RQfGA=;
        b=CJKe0XV8ngvWwYm8ETPigDH6mwEi8ZfDDRB1PFKgMDCKnOQn4U2oBN4yK+OB8Ippag
         aGKzzyPhBwo1gGygbayD6rfBzoanrvMFgzD2nCxTb1QOA75cFUId3p/7fg/SApD3Ah0D
         OMaak+NJyZTzstMl/dp/T+BO2lX661lk4StRPw4fgaiJrrA9TcAxWKVEU1NqdZReLBia
         yGjSh0aUiHbT9sIk4bAKl/V37AZxO7TAw00x77eEX5Ln0MF160zBQYQH1x9a0xmncZaS
         vtl6S02nVrT/YwleRVWOFOGYm+YiB+RfMrvMVPKZqaXZE0PFlyLQXNszS+W/nLCAVVop
         xZew==
X-Gm-Message-State: AOUpUlFfqLQROXHBv3zKiAHwuZvkb4PH9R9DR3vJ/X/DXDnzaITicWgA
        qtjFlnyag1k8XE6FMmgoq2M=
X-Google-Smtp-Source: AAOMgpeelLv2fgOS1+VfCif+PkZO7rzuOPe0HH7TDvRuDOiZaT8ojqr5b/NsejI6C+oBwi0g1+iUTQ==
X-Received: by 2002:adf:c4f0:: with SMTP id o45-v6mr6918992wrf.173.1531558278080;
        Sat, 14 Jul 2018 01:51:18 -0700 (PDT)
Received: from localhost ([195.46.23.67])
        by smtp.gmail.com with ESMTPSA id z3-v6sm289415wmf.12.2018.07.14.01.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 01:51:17 -0700 (PDT)
Date:   Sat, 14 Jul 2018 08:51:09 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] Input: pxrc - fix leak of usb_device
Message-ID: <20180714085109.mbhk6aybpjsbuq6l@penguin>
References: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
 <20180714080920.GA15123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714080920.GA15123@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 10:09:20AM +0200, Marcus Folkesson wrote:
> Hi Alexey,
> 
> Good catch!
> 
> On Fri, Jul 13, 2018 at 11:07:57PM +0300, Alexey Khoroshilov wrote:
> > pxrc_probe() calls usb_get_dev(), but there is no usb_put_dev()
> > anywhere in the driver.
> > 
> > The patch adds one to error handling code and to pxrc_disconnect().
> > 
> > Found by Linux Driver Verification project (linuxtesting.org).
> > 
> > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> 
> Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Hmm, the biggest question however if we need to "take" the device, as I
do not think interface can outlive the device, and whether we actually
need to store it in pxrc, as we only need it during set up, as far as I
can see.

Thanks.

-- 
Dmitry
