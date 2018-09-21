Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B006ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BE421568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="FS//hYZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BE421568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391416AbeIVCJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:09:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32970 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391319AbeIVCJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:09:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so6460357pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+hhBYQFcLfNo12hhfuATW5WW1qUUhYBI8Nhr9TPTUDg=;
        b=FS//hYZ+cEVUised2ea+UCe/h6c/b5r0gQ1lqcuajToHK5XsEIFH7lUjWFsN/m4iaf
         XN797B8y/L62CX2xfQRZOGN1wvqgxCkORXlFkNuH4uL8mpMiDfxeWNyPYEaONOadR2LO
         Rfp7WSNWRkcHfPo9SU+T/drDZdFlJAEI0FFjtoElVetpozZMAHaqZ2ZPL8lH/UkDgskC
         GCHra+Cs/S52w2rjima5JOyPPX24AoRPLOinP+z56uz78/QzM4DamX+CVnx532GT2/JQ
         ikibjlWW7a0X6UUj2ol3JunwofSu4rGDd8YnhSkF1s8WxnOW3UOHsga6TsL6M871U5tC
         ZRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+hhBYQFcLfNo12hhfuATW5WW1qUUhYBI8Nhr9TPTUDg=;
        b=g6Uo2wrPhXdvk8shzUPQLmkzrgbgYYo4vBmrFN31tYnatSjTJjOJsO4Aljs7BrDUIC
         I7zWOMyRkZ31nh9ZvG/vwtWUwZtVHemTdFAT4tXoQvRoH+CwkHGJYXGdA7acpvUY6xZS
         +9d88c8w3whBy+qZNhHbQxq/YZ3S2YdVbW+GeArIGtdid434BnNmQ8ECMaXRdpnGGAI4
         omUtm6tD9cYLuZB61lfwJc7Ql1L7po1iNMZxSqbE79UL4FKxxFVHGIJg9aYw2vlZmwRQ
         T+BmnVzRqXfxaIIb9GT1hnmeBva+n4tLwLwjJSH+r4Ep7Aq1FTAHiRWmi5uRPKIQsrY7
         wELA==
X-Gm-Message-State: APzg51AfyWPr/+e1AITyGbtmTLHUHCqSlqqxCqSD992qyeAAe8yHntKv
        LuJAt+OW4TglpOqX5UAajptl1Q==
X-Google-Smtp-Source: ANB0VdaLsW7ch447+oHGSgs3HbNcz34uxLR5dR6KtXCTwXrqp25MYP+5mR7j074Kim3u3kVco2q7yQ==
X-Received: by 2002:a62:e11:: with SMTP id w17-v6mr48676615pfi.242.1537561143996;
        Fri, 21 Sep 2018 13:19:03 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id m10-v6sm3653174pgp.94.2018.09.21.13.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 13:19:03 -0700 (PDT)
Date:   Fri, 21 Sep 2018 13:18:56 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] decnet: Remove unnecessary check for dev->name
Message-ID: <20180921131856.0100018f@xeon-e3>
In-Reply-To: <20180921193034.808-1-natechancellor@gmail.com>
References: <20180921193034.808-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 12:30:34 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> Clang warns that the address of a pointer will always evaluated as true
> in a boolean context.
> 
> net/decnet/dn_dev.c:1366:10: warning: address of array 'dev->name' will
> always evaluate to 'true' [-Wpointer-bool-conversion]
>                                 dev->name ? dev->name : "???",
>                                 ~~~~~^~~~ ~
> 1 warning generated.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/116
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Makes sense name in net_device is an array.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
