Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A49C26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B69820880
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548012543;
	bh=fDBjE454Ydxp5PgLjL4Ibp70CQX1pm4wj4ILddvKLqU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=cNp0cIrLFCQR0vWf3oHcMxoMTbQe4qC8bixJXPsC9Rh1biZfWTpsJP9I9eGDGMetN
	 hofWtqQ8P2pnZZUJ9w/mBJmg1wyo2fAlYkgl4gAo2qxBZYs9IZMcZUOPDpkNoc1TSb
	 dBgpApAQ5mVgN7owfeEWZsOqbs5hegP6+dTTfjFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfATT2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 14:28:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfATT2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 14:28:37 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2414220861;
        Sun, 20 Jan 2019 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548012516;
        bh=fDBjE454Ydxp5PgLjL4Ibp70CQX1pm4wj4ILddvKLqU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tcf3n1+NQtP/6QFhTqY8qMERKwM8SNoSqrCBLYKRWEsnglzgRLUImMiIZCFm7WxTn
         Fg3pcu+OBsUBkDMv9w3oqztcXi8mU0AxbRQbn4BmiwzBuHfYroBG1AruoosCWl+BTQ
         IbU4ejxpZ0UlVyd42/tZh2X0tYcnDvhjPiIaJJ10=
Subject: Re: [PATCH v1 0/6] seccomp test fixes
To:     Kees Cook <keescook@chromium.org>, Tycho Andersen <tycho@tycho.ws>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, shuah <shuah@kernel.org>
References: <20190119001217.12660-1-tycho@tycho.ws>
 <CAGXu5jKtQZ5oKethjopCW75eDtj6fEdCANRqah+wUh2pYfdGiQ@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <debaac10-04ec-2d59-d2a8-8fce156d5d40@kernel.org>
Date:   Sun, 20 Jan 2019 12:28:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKtQZ5oKethjopCW75eDtj6fEdCANRqah+wUh2pYfdGiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/19 5:43 PM, Kees Cook wrote:
> On Fri, Jan 18, 2019 at 4:12 PM Tycho Andersen <tycho@tycho.ws> wrote:
>>
>> Hi all,
>>
>> Here are the fixes I previously mentioned I would send. I previously
>> assumed that the tests were mostly run as root, but it turns out
>> everything else besides the stuff I wrote in the seccomp tests either
>> sets NNP and doesn't require real root, so it all actually works. This
>> set of fixes should make most of the other tests work unprivileged,
>> while XFAIL-ing the one that requires real root.

Tycho, Thanks for a quick response in fixing the problems.
> 
> Awesome. This all looks good to me. :)
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> Shuah, can you take this series?
> 


Yes. I will take these in for rc5.

thanks,
-- Shuah

