Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F75C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82EA21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGVg8/tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfBHWYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:24:05 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:50405 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBHWYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:24:04 -0500
Received: by mail-wm1-f54.google.com with SMTP id z5so5916330wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 14:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PuzhPYCQnwPS7hQlDPQR4gLyvaSK6NMRI7sOOWIURAs=;
        b=oGVg8/tj9SDbv4fG7ON032RSrekzRHDIDavXtPPkNmM8VvDrQh4wahiavPTgoSHLai
         qZI+ILtGR1OIKe7xm5OFJVC5BROZWtlq/GpTcIATtALGRXCTcIdBlq40a7vqvMT03oE3
         Yp5SSRT7d6ZKgBdmziMwaSiumrdK7KULMR+o4S/xRu8YO8VG+v5jR/gf2fnd7ieb7npv
         lSjxnTuF/kDBGkNojngLFbaN4aWhLgfVv6jO6cowc+NcsVlECy+neWPBIg5dGiNXn1aW
         TXTPgtZeuoxyc4cAoa3bT2ATZqVn9dZ5f4sxfkfbeGs7X0OJtbRLq3kJdN87RZZfYQct
         kmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PuzhPYCQnwPS7hQlDPQR4gLyvaSK6NMRI7sOOWIURAs=;
        b=UNLJa2lXNj6SEYXQOitaih3IE5o+X1eqz9LND5YpbLhK3qBcWsRaaTf/3/yO8c4QTj
         qZMFfa4jx+feDLd/DXevKut4uSUK4Zbylqcf67XqD/wcVHhZA1Tumh0RjaqjSz6PcwBm
         1f68BUcpKbquPv0zRUd1kYpPfI9MynqjHriqFmnpfR4LsXaSst/ce7FW3CXeb8UFusW1
         1M5csAT+BjJ3nUZ/3U+Myuf7Bvu4sufT2VxOXtxf44YHyRpCW7p5zJpoXZ9+/BrTYOtI
         Es8X2Usi55ZmfIlH0tsqu1nLOcGCP5Xvh8j5cpZNld+NmWritOBGRfnueDtWqtmywOxz
         YxBg==
X-Gm-Message-State: AHQUAuYyOVpoqlTElU2EsglBFotCtSMNbnRl9Za1mDDMWc6h2pZC9oyw
        Up5qkBwSgcshrrC90AysCA==
X-Google-Smtp-Source: AHgI3Ia/B4C3c0cHoIQa358561vQna1jjJh7dhqcwNETwIP20aTvCjzhVULf71dyEFCl1eBJmuzn6w==
X-Received: by 2002:adf:c505:: with SMTP id q5mr17860927wrf.84.1549664643065;
        Fri, 08 Feb 2019 14:24:03 -0800 (PST)
Received: from avx2 ([46.53.240.199])
        by smtp.gmail.com with ESMTPSA id c8sm2213363wrx.42.2019.02.08.14.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 14:24:02 -0800 (PST)
Date:   Sat, 9 Feb 2019 01:24:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux@rasmusvillemoes.dk, akpm@linux-foundation.org
Cc:     yamada.masahiro@socionext.com, viro@zeniv.linux.org.uk,
        ndesaulniers@google.com, luc.vanoostenryck@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: + build_bugh-add-wrapper-for-_static_assert.patch added to -mm
 tree
Message-ID: <20190208222400.GA17308@avx2>
References: <20190208220015.58Xfh%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208220015.58Xfh%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 02:00:15PM -0800, akpm@linux-foundation.org wrote:
> +#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)

Major ACK. Stating invariants is why userspace assert() was always
better.
