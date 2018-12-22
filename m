Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F78BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDD221927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LIj2hCrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403842AbeLVAZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:25:36 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34011 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbeLVAZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:25:36 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so16937564itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 16:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=iT/tXq7UPR5qw5hExf6QS7jdNfGxlfSoq52Q8RIOUNc=;
        b=LIj2hCrDP6kJVThG+aUUG8nIEttg8iaRK54iuZHLStxdil5+ThTPyWUK6zK4MpONiZ
         qd3Jr7NaR4mQYWezaLjOgOfWQgEJ8kyk4OfzZLoL/rPs9vKEAzeuxMkQeYx9VRdeuHU7
         kkVxlE/Vo/KL/rHl2qTxKQLSstm9LK36wFPFCFcTlJlWbfRurlVMcQzxv01+k4EZQcJL
         CbDgHg/oHS0YDHkiAqWgoqKYKOahIYm8z67omrRi40FaNQupEq0pVGftDD4G9RP4g4JL
         QpZpTN32Lg4zmW/zG/DX4df5D++Co3ojIAfmD3Q77NPZ4Q6cppOdAItJHti5MuzB2J51
         bgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=iT/tXq7UPR5qw5hExf6QS7jdNfGxlfSoq52Q8RIOUNc=;
        b=Ruu/a/bDYXoqYvHHmrO8zyGNw4qefR1akX3DmUMH2dKDIfdV06aZ615crmiY++Y6G7
         8ZXB7uwCAIsW2IhvxIKKXCJ6EhK3MIRfzC5ruv8+fViJ0sOHm3YnXojfPWeAei+5YzqF
         Wp+25TH70Yq5eMk0QRj0QFaxlgB/rlXeoprsyjOegXUV4kbFwBvBD4Grm/PGaCDYj1jU
         KTbW7fX5lnTZTr0xYt8fXX5C9iQMHPMJXU2vG+Zn11tkzrozG41TOqnYFh5woJTMRNay
         kC54ntHgjU2Xo6HpoXPIt5ndPa77KcugwmmQwPEr5o2zT6OSI7fXjTAbViQbpagODgyM
         xprw==
X-Gm-Message-State: AA+aEWYcRnohYjoHFoGCuwQLSt9K3MfiF+dan2SWf2PD/zuTagK5QcjI
        2j8twKCQiBiPK2zwva6GDcQGEQ==
X-Google-Smtp-Source: ALg8bN44kBLNctfTcjxe1uLUkXINSfWS223kl/nZPk2Xv+5Zq2grXUyU2Y1od0ZfnzMVEDjSf8TflQ==
X-Received: by 2002:a24:7094:: with SMTP id f142mr3403994itc.90.1545438335644;
        Fri, 21 Dec 2018 16:25:35 -0800 (PST)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id g21sm1107156itg.44.2018.12.21.16.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 16:25:34 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Fri, 21 Dec 2018 16:25:34 -0800 (PST)
To:     Alistair Francis <Alistair.Francis@wdc.com>
cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RISC-V: defconfig: Enable Generic PCIE by default
In-Reply-To: <20181221220555.13679-1-alistair.francis@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1812211620030.777@viisi.sifive.com>
References: <20181221220555.13679-1-alistair.francis@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(fixed "Palmpalmer" again, might want to check your script for sending 
patches)

On Fri, 21 Dec 2018, Alistair Francis wrote:

> Enable generic PCIe by default in the RISC-V defconfig, this allows us
> to use QEMU's PCIe support out of the box.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks for updating this.  

I tried applying it against v4.20-rc7 and running "make savedefconfig", 
and there is a delta.  It is better if there is no delta.  Is this patch 
based on a different commit?  Or, is this patch not the product of "make 
savedefconfig"?   If the latter, please do:

make savedefconfig
cp defconfig arch/riscv/configs/defconfig

to clean up the diff.

thanks

- Paul
