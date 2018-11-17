Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D80CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4B72086B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqsgdUcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4B72086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbeKQKps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:45:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42105 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQKps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:45:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id j6so16038100edp.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 16:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r/X0XeoI274Z/zosRGl+eQruxl7JOPwAwYBeIBeKIbE=;
        b=bqsgdUcR76FNtzSuPkF1u5edS+Jk+4de2xj1PefoWOL2k2XsfGiVjKGl+qLV3nC6qR
         EDy9xdQfnX6HfrSrH1MljEDgafttQbiwdq6T/ZGXIVv8MrmVGV7nWiDPpmymtWBbM5gl
         PiDQnZwFUl+Ovo/cOFCuoUKFRupOEp9KIT1a/Mwg+9j9AvFPpviRoLx3DYgGNz/B0gOY
         kex/i9m7C9/Bb2YFYNVl/GnEhvPI5WYmBXml81P9b35/m03+G0SBQ5zvGD/F7FdPif/E
         uOsW4IzWj1SKswGPOObsAixZ7DGHWnnYzmIytHPaKFV/BmL9OLbYsOzpkbGb4QXJ2ykU
         02Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/X0XeoI274Z/zosRGl+eQruxl7JOPwAwYBeIBeKIbE=;
        b=l4tYpc5fY22oSmODorrmAKc1LvGmedSuiKl3yf9rSbrXr/5y65f4Pu4KwwOqgUoFQq
         nwk1vITLwXZ5E3YiU5y9ZoK+AHU/YTxY0urqO1BGh3QmqfruSDKheryTAy1pftpmZ4dH
         ysUmhSwkBTHL86JMMVH3ITjTHp5ijhGmnYgxIsAWhNIukREurxY0RMsUFwUhRZ0Pfcjs
         Ky+/x7v4TiHKZfLoDMZB/6Ec0SR4LIEoMadO2HAVSEEhlchqigSJLQugW9/tlfDXxL3O
         2MN4yzZ+OZCzy5Ng3hOIHLNYSVyHfImES0dOpSY4MSdBWJw5DfcRPvYgA7BqsiijSV+I
         lwRg==
X-Gm-Message-State: AGRZ1gKfwzKymu+ZbaZ6nuNkMTs4+frE4KfAFjGAA6S9+hjqzjXmgUco
        kQf5ngBYYEuDpAjr4KTrcQM=
X-Google-Smtp-Source: AJdET5eRVw5G7wNpbULTyjYMY9dqkO+5Vux2QCjlO60wpRtsxRQM7sXaFlZEegosZnq4PXmoOyXvhQ==
X-Received: by 2002:aa7:d30a:: with SMTP id p10mr9805704edq.137.1542414673034;
        Fri, 16 Nov 2018 16:31:13 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:787e:f271:ff1d:82b])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm5174446ejb.4.2018.11.16.16.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 16:31:12 -0800 (PST)
Date:   Sat, 17 Nov 2018 01:31:10 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] build_bug.h: remove all dummy BUILD_BUG_ON stubs
 for sparse
Message-ID: <20181117003109.jdac5rmjdmpmino7@ltop.local>
References: <1542349645-8852-1-git-send-email-yamada.masahiro@socionext.com>
 <1542349645-8852-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542349645-8852-2-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 03:27:25PM +0900, Masahiro Yamada wrote:
> The introduction of these dummy BUILD_BUG_ON stubs dates back to
> commit 903c0c7cdc21 ("sparse: define dummy BUILD_BUG_ON definition
> for sparse"). At that time, BUILD_BUG_ON() was implemented with the
> negative array trick, which Sparse complains about even if the
> condition can be optimized and evaluated to 0 at compile-time.

OK, but from what I understand, the motivation for commit 903c0c7cdc21
was not to avoid false warnings but to avoid having twice the same
warnings: "... So it causes sparse to detect an error too. This
reduces sparse's usefulness.").

I'm not opposed to this patch (on the contrary, I think it's better
to have exactly the same code for GCC than for sparse) but I think
that your commit message need to be adjusted.

Kind regards,
-- Luc
