Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAC4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A872070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yJyejL0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfBUEOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:14:42 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53436 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfBUEOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 23:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EwQNmrXW/4QZg2c9rz8eEIt9GBPXaqF74W4KjGm6Yrs=; b=yJyejL0uZvqdgfRDRhI53GqQwb
        2Ru9LuOEdXcxQr3R+8/EVkwWbm9GfZ9ASZC/O2VrHPzyheTVN7lD/BCwQdcS5108FwS2ggjSd/She
        W45idHmzW+JvN3Pzs7X4tKTJBf/2qQ68tuogXHu5hgTinm9fdFQGSyqbsYHMg3qa1xP2qr2O6EeST
        bLmv3KyWwgGaCsLRtLta1GTscnoYNtwQuI+yMZOJHzd0hLLwt7dODWoBWAkh9Bc3Gjzt0u++ztpW/
        ZlDxbrY6QmKDvIDkJDnIZXnxxOsDjQ5LQCzSZebnygR/EMjw8nCMCObR4ZO7eQqRzGlrWu5pxF+82
        bJ6zYLtw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwfkq-0005T4-5U; Thu, 21 Feb 2019 04:14:36 +0000
Subject: Re: [PATCH 3/6] lib/string: Use correct docstring format
To:     Kees Cook <keescook@chromium.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190218232308.11241-1-tobin@kernel.org>
 <20190218232308.11241-4-tobin@kernel.org>
 <CAGXu5jJ++_VufY8t3WYsGW8VN-3yJEbVpOi_67RxHPicCC-K6A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <45959376-49a1-467b-835e-f335fbd1c470@infradead.org>
Date:   Wed, 20 Feb 2019 20:14:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ++_VufY8t3WYsGW8VN-3yJEbVpOi_67RxHPicCC-K6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 4:07 PM, Kees Cook wrote:
> On Mon, Feb 18, 2019 at 3:24 PM Tobin C. Harding <tobin@kernel.org> wrote:
>>
>> Currently the docstring comments for strscpy() are not in the correct
>> format.  Prior to working on this file fix up the docstring.
>>
>> Use correct docstring format for strscpy().
> 
> Is this attached to "make htmldocs" anywhere? Maybe in the device
> driver api doc? That's where I put refcount_t. See
> driver-api/basics.rst and put something like:
> 
> String Handling
> --------------------
> 
> .. kernel-doc:: lib/string.c
>    :internal:
> 
> and add that chunk to this patch.

It's already in Documentation/core-api/kernel-api.rst, under
"String Manipulation."

> Acked-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 
>>
>> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
>> ---
>>  lib/string.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/string.c b/lib/string.c
>> index 7f1d72db53c5..65969cf32f5d 100644
>> --- a/lib/string.c
>> +++ b/lib/string.c
>> @@ -159,11 +159,9 @@ EXPORT_SYMBOL(strlcpy);
>>   * @src: Where to copy the string from
>>   * @count: Size of destination buffer
>>   *
>> - * Copy the string, or as much of it as fits, into the dest buffer.
>> - * The routine returns the number of characters copied (not including
>> - * the trailing NUL) or -E2BIG if the destination buffer wasn't big enough.
>> - * The behavior is undefined if the string buffers overlap.
>> - * The destination buffer is always NUL terminated, unless it's zero-sized.
>> + * Copy the string, or as much of it as fits, into the dest buffer.  The
>> + * behavior is undefined if the string buffers overlap.  The destination
>> + * buffer is always NUL terminated, unless it's zero-sized.
>>   *
>>   * Preferred to strlcpy() since the API doesn't require reading memory
>>   * from the src string beyond the specified "count" bytes, and since
>> @@ -175,6 +173,9 @@ EXPORT_SYMBOL(strlcpy);
>>   * doesn't unnecessarily force the tail of the destination buffer to be
>>   * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy(),
>>   * check the return size, then just memset() the tail of the dest buffer.
>> + *
>> + * Return: The number of characters copied (not including the trailing
>> + *         NUL) or -E2BIG if the destination buffer wasn't big enough.
>>   */
>>  ssize_t strscpy(char *dest, const char *src, size_t count)
>>  {
>> --
>> 2.20.1
>>
> 
> 


-- 
~Randy
