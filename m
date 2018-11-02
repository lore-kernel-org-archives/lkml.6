Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02EAC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1A72082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR6yww0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1A72082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeKCF2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:28:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34109 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeKCF2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:28:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id f21-v6so2626060oig.1;
        Fri, 02 Nov 2018 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQV72AaQlDOU/+IelFQFot6Wn7joXYVUm6oQSWMCjAQ=;
        b=cR6yww0+0ML19DF/N8hjoTU2V/XgbVe7TBsKCeP0k50bM8sXDdfiq18XyXy1TskL9i
         Szntnjf1ompx1W7YRu/1X3p40aE9Zbhr0dSAevQkeayZYigFi7dt3LvLi4Yhd/GmBTaj
         ClfGHU6fK2ronlWee+iWA106i73p98Gin4Dbl5IBoQJKAm+WIZVcDunEEVDZ3tG3+IWL
         Eqh3d4koeP9DnQZuGdLJMkijZ9bWCEOcn5pOaYppeUycVx9chofN1UW4aBI4Ri6FYjnj
         BirW0fTbOVYG5uvrOw3nC/oemCk3tbTF+ngKma2wLYhred/9oHVDleQuPm4Wn5w60CUY
         CHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQV72AaQlDOU/+IelFQFot6Wn7joXYVUm6oQSWMCjAQ=;
        b=GW3XVSQNBMeFXVnv6nu9zu795iW6DHh8Gjb0+LNQ80ZNCaLFbUqsSgz6ABHfHm9EBz
         j0+mdhpukfFIOpoPytXHUDNF+YbtooZxWCb4gzyg7r59cdS4F3/lfNuuhiD2YtSZlskU
         6euuVk5aGKWRpVmbICjqE3RuUQbV4PeEdfh7ZujWC75q4s2AXwyvgzz6ww+jL5YEmkZo
         IM4WPczE4KlL7neNb3yEOPgbMughwAeuSsew1EuQZmIDf+cpuQk0cL/QTBMleWILMIGy
         62eayYo31M76GCjbfXJnE7UfORQw+oDKYrLLk3EaRDrhZhE65eEN4JyB2bBpNKYu6C0U
         VOjQ==
X-Gm-Message-State: AGRZ1gI5QbyS7Az3qUDZj53JCdhyma5eJyG7z1z5ccAOxos+arvnn+j5
        233GoZMaxHXeNgxyZhmoq8IBMlrJqLH/wxuhL4g=
X-Google-Smtp-Source: AJdET5eurYhCYD3nEGiWTRwVD8PFK9aun5T0FABkfT8f7REQN2bLafxB2F6vT896o2J9ITavIqpZfMyibUGG9rSvz70=
X-Received: by 2002:a54:4406:: with SMTP id k6-v6mr7962222oiw.300.1541190011831;
 Fri, 02 Nov 2018 13:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181102182857.064326086@linuxfoundation.org> <20181102182901.303280657@linuxfoundation.org>
In-Reply-To: <20181102182901.303280657@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 2 Nov 2018 20:19:36 +0000
Message-ID: <CADVatmNE4VcpjoEKdXTf_d0_M27shgB+x6FiXo1-JzRf+0sw9w@mail.gmail.com>
Subject: Re: [PATCH 4.14 053/143] x86/power: Fix some ordering bugs in __restore_processor_context()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, a.p.zijlstra@chello.nl,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Nov 2, 2018 at 6:51 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.

This has been fixed by another upstream commit:
7ee18d677989 ("x86/power: Make restore_processor_context() sane")

You can not directly apply it, will need backporting.

-- 
Regards
Sudip
