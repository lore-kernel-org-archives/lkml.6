Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F1CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6AD2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfBUTAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:00:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41250 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:00:49 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C047C108DA51E;
        Thu, 21 Feb 2019 11:00:48 -0800 (PST)
Date:   Thu, 21 Feb 2019 11:00:48 -0800 (PST)
Message-Id: <20190221.110048.486024032740639211.davem@davemloft.net>
To:     yamada.masahiro@socionext.com
Cc:     linux@roeck-us.net, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpfilter: remove extra header search paths for
 bpfilter_umh
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAK7LNASfiSrULgdG_tcm+m4wmyOjg4ZHYAB9EUgaGrjv=g-Zbg@mail.gmail.com>
References: <20190221144257.GA12892@roeck-us.net>
        <CAK7LNASfiSrULgdG_tcm+m4wmyOjg4ZHYAB9EUgaGrjv=g-Zbg@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Feb 2019 11:00:49 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 22 Feb 2019 00:54:47 +0900

> On Thu, Feb 21, 2019 at 11:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Thu, Jan 31, 2019 at 12:15:35PM +0900, Masahiro Yamada wrote:
>> > Currently, the header search paths -Itools/include and
>> > -Itools/include/uapi are not used. Let's drop the unused code.
>> >
>> > We can remove -I. too by fixing up one C file.
>> >
>>
>> This patch reintroduces the problem last fixed with commit ae40832e53c3
>> ("bpfilter: fix a build err"). Seen (at least) with gcc 7.4.0, 8.2.0.
>> binutils version is 2.31.1. Reverting this patch fixes the problem.
> 
> 
> Hmm. I cannot reproduce the build error with my gcc,
> but you are right.
> 
> 
> I'd like to get back only
> 'KBUILD_HOSTCFLAGS += -Itools/include/ -Itools/include/uapi'
> instead of the full revert.
> 
> If David is fine with it, I can send a patch with filling commit log.

If that really fixes the build regression, sure.
