Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE60C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A55620856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDlmgwHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfBBQbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:31:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46375 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfBBQbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 11:31:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so10197023wrt.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 08:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hPRuyRmbkykCv0EW6mmzMJ6x8wBQt5uzj47jndC8DBY=;
        b=kDlmgwHomonLVcQK2WjhEwpvJRXwNxVcTRZKLObRuGTBMIQNEd4Qsn9hCvyy6UTGcH
         A1kHBSxZMypP2aixsbZV1cqrJ+SihYe2vGmmzA5sELj8KBqoWqnU+W2MmOD6JuGdQGXY
         zYN2amf8PoW3uyHs9bsqyyfmbPfn2eX6CcRodgt6xFlemZV+UyxFvtxLrQGr74ez119t
         he1kIzbCg1BzkFkK9jPB91NrZPG9JJMWa2xg9TH297CtsNheH4cXKjDcHZbapjpVn2wL
         TbUem6FAnUATHDhrL/pzmVKvQL8Yf8f2N3KIBY/b4APl8p81hScDLxjcmjWmgmNMLSZb
         +VZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hPRuyRmbkykCv0EW6mmzMJ6x8wBQt5uzj47jndC8DBY=;
        b=f45A/WSFpwJV/m5oSga4oEiPVlHv18Eu8owi+RZRpL28kIsfYM9T1rAt3prFYgYT88
         +oxCQhF5HYzwDXObzGJrT1P6si3BKSMagXBz2Yt3nQtZdrF8g4XRUXndwLDtfFGStikR
         VXuU4O4+FzKV1CIU7OAZme3W6PDwDTzFN4dEi/CX8YZPx7vrZ66NaY44Jub+AkEF6+I4
         SgytEXcRBXwKci+S09j8g1YDuyy5uZbNAV441moYmbmXS3zkMJ4WGOf1rKxvs4Unr+oU
         zQnamMyQkmJ85h4ZswK9lhJxTQVz0aaPAabNrGlZmZ9fJrUQEZwwtUSpZOBf/0WCOAkj
         GcXg==
X-Gm-Message-State: AJcUukfyhBCZn+f3OzH//EOl0taK6n8T9AtKJSXTCMNvseO6RI9LUjzW
        G0wQ81TQ+2gObJJoJ8fu+A==
X-Google-Smtp-Source: ALg8bN7Sw+FcYpeQ9JkEggIj41B+wByUbS1N6oKhqTHo7651Zh46w/+Ty2rkXZviathRS7JCk3swxQ==
X-Received: by 2002:adf:92c7:: with SMTP id 65mr40500871wrn.228.1549125069189;
        Sat, 02 Feb 2019 08:31:09 -0800 (PST)
Received: from avx2 ([46.53.245.251])
        by smtp.gmail.com with ESMTPSA id a8sm5951275wme.23.2019.02.02.08.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 08:31:08 -0800 (PST)
Date:   Sat, 2 Feb 2019 19:31:05 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhang Yanmin <yanmin.zhang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] linux/kernel.h: use 'short' to define USHRT_MAX,
 SHRT_MAX, SHRT_MIN
Message-ID: <20190202163105.GA28518@avx2>
References: <1549123585-13800-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1549123585-13800-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 01:06:24AM +0900, Masahiro Yamada wrote:
> The log of commit 44f564a4bf6a ("ipc: add definitions of USHORT_MAX
> and others") did not explain why it used (s16) and (u16) instead of
> (short) and (unsigned short).
> 
> Let's use (short) and (unsigned short), which is more sensible, and
> more consistent with the other MAX/MIN defines.
> 
> As you see in include/uapi/asm-generic/int-ll64.h, s16/u16 are
> typedef'ed as signed/unsigned short. So, this commit does not have
> a functional change.

> -#define USHRT_MAX	((u16)(~0U))
> -#define SHRT_MAX	((s16)(USHRT_MAX>>1))
> -#define SHRT_MIN	((s16)(-SHRT_MAX - 1))
> +#define USHRT_MAX	((unsigned short)(~0U))
					 ^   ^
					 +---+
					   unnecessary ()
> +#define SHRT_MAX	((short)(USHRT_MAX>>1))
> +#define SHRT_MIN	((short)(-SHRT_MAX - 1))

"short" and "unsigned short" are probably the most useless C types.
I doubt their usage should be promoted.
