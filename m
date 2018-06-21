Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2469DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1228208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4PaMtYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1228208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933194AbeFUMnj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:43:39 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40389 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbeFUMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:43:38 -0400
Received: by mail-wr0-f196.google.com with SMTP id g18-v6so3051230wro.7;
        Thu, 21 Jun 2018 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ETy0kytedYU9vdeOUfySQDInykzj/1Uit9O1rxJ2CI0=;
        b=D4PaMtYBqI4QUcp74CSIXFri4HWGFjpd7Xc1xcsKeKwe+1iBByAFLXht+zdgb/F9kr
         xDQ8elXeKGAgBu+y0nGhXgiNMVsQtCZLLK3zX4N32uK0EQkYptGgj4qX5IDelcLzj9ff
         QuvHgJUu57fWNgoS8x2ZoMw3OVdHNW6MmoOoLZqALOelvBAvyiMADHs51UO+DVGxBIxu
         Wh7FUgWSpEH2wrtX5c56Nfy9hLa7H7KFBr9mG3pjX4LIu10fkWJrpQ9rye1pqSaLtrg0
         y3mT8llAtRa4z9uve8nCzhJAKs1Y4C+kQQc4KHeedkh1or1iIXxtWwaZuWaqSM/spsw+
         rkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ETy0kytedYU9vdeOUfySQDInykzj/1Uit9O1rxJ2CI0=;
        b=n0PRq/t/7WbQ1ChcLhEqzs7HpmQbUpIvbSN0+DPDxHScwv7TGdF3M/VwrHZelYx08s
         DAqLU5zLbc5LmjLRkc4TSOkVpaT95nDX21SO+HlH9cPd526tWe3vwPjco9HMZIQGSsjg
         LR8WCp9kcxoR7NmNITq7ZFkaUxFZWWhY2TtXeY24NseNGROaKttTNyZ0iONbZdLBOtYU
         5JNc60hlB00k9sKCHqbdCENDRVcmuvNCwvHLFJRyfLecc3eyq+V5Hxkq2KdMFnfj3r5J
         y9MypJvoPXapOWOZVMObLbxTkv8+ae7PaTKUs+BsF+yfBhqR0Tv6faoXB6HJxpjzgHs4
         J3sg==
X-Gm-Message-State: APt69E1X1j3kkQFUHR7an820V2LMUPatVgRxEPusn/1cA6WvQPxjffRF
        fu27pkelzSI3DaW/QdXhnPfDkQ==
X-Google-Smtp-Source: ADUXVKKxXlhZxKsgHqWhU2EmJCCTIblZxLxzT2v/R+aDYGr6zdoogCVFOof+MGJ8Tnf/jD0NKdcJPg==
X-Received: by 2002:adf:c444:: with SMTP id a4-v6mr22700351wrg.20.1529585017172;
        Thu, 21 Jun 2018 05:43:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m10-v6sm6949046wrq.56.2018.06.21.05.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 05:43:36 -0700 (PDT)
Date:   Thu, 21 Jun 2018 14:43:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCHv4 3/3] x86: Add build salt to the vDSO and kernel linker
 scripts
Message-ID: <20180621124334.GA30110@gmail.com>
References: <20180612003224.3658-1-labbott@redhat.com>
 <20180612003224.3658-4-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612003224.3658-4-labbott@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Laura Abbott <labbott@redhat.com> wrote:

> 
> Both the kernel and the vDSO need to have unique build ids.
> Insert the build salt section to make the build ids unique.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/x86/entry/vdso/vdso-layout.lds.S | 3 ++-
>  arch/x86/kernel/vmlinux.lds.S         | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

What is the upstream merge plan for this series? kbuild tree?

Thanks,

	Ingo
