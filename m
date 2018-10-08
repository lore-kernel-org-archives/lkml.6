Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC1DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28D92087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28D92087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeJHN4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:56:55 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48710 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJHN4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:56:55 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::4572])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 64E4413EC1839;
        Sun,  7 Oct 2018 23:46:44 -0700 (PDT)
Date:   Sun, 07 Oct 2018 23:46:41 -0700 (PDT)
Message-Id: <20181007.234641.2199470135547877917.davem@davemloft.net>
To:     keescook@chromium.org
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunvdc: Remove VLA usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAGXu5jKV3eLJJsemxNEjZuANRd8-TnRkMSmiztVyY5mgC2ySHw@mail.gmail.com>
References: <20180906000926.GA18830@beast>
        <CAGXu5jJ-Hbj143Sv7ikxmLnBPyvcd1cGoT5fSbwG21LomnsORw@mail.gmail.com>
        <CAGXu5jKV3eLJJsemxNEjZuANRd8-TnRkMSmiztVyY5mgC2ySHw@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 07 Oct 2018 23:46:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Sun, 7 Oct 2018 23:16:01 -0700

> On Mon, Sep 24, 2018 at 8:19 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Sep 5, 2018 at 5:09 PM, Kees Cook <keescook@chromium.org> wrote:
>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>> moves the math for cookie calculation into macros and allocates a fixed
>>> size array for the maximum number of cookies and adds a runtime sanity check.
>>> (Note that the size was always fixed, but just hidden from the compiler.)
>>>
>>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Friendly ping. Jens, can you take this?
> 
> Dave, should this go via you instead? I'll take it via my tree if no
> one else wants it...

Please resend to me and CC: sparclinux@vger.kernel.org and I'll take it.

Thanks.
