Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4qfBNXfJGFvhZQAAmS7hNA
	; Thu, 07 Jun 2018 05:59:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7219D602FC; Thu,  7 Jun 2018 05:59:07 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="UBa72C/Q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5BF3F602FC;
	Thu,  7 Jun 2018 05:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BF3F602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeFGF7D (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:59:03 -0400
Received: from services.gouders.net ([141.101.32.176]:42395 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbeFGF7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:59:02 -0400
Received: from localhost (ltea-047-066-004-082.pools.arcor-ip.net [47.66.4.82])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w575uZrl008943
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jun 2018 07:56:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528350996; bh=+gt+oUMnRWXu3BZrUPkh69qnzCO4g36b/UQHwblPYJg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=UBa72C/QKATvCBqK98JNX+ebdhm2UDEXI9k+p8nrtLz0cWk+Otf4Jiiudb70agD+A
         mAQnSn6SgxUyC4slxcXfa84yqLlyBnKyKW7xPxt9EcrtoulQadooWefyEWgJylWYMe
         6f2o9NtMGek668Gr2nKo5Is1hQlK1Dl8nXaH5WfQ=
From: Dirk Gouders <dirk@gouders.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC 0/1] mconf: Emacs-like isearch
In-Reply-To: <CAK7LNARWC3J4V=Nx9rypwaWK8Lsv9A6J3LDW7s6E1xjc0JDE4A@mail.gmail.com>
        (Masahiro Yamada's message of "Thu, 7 Jun 2018 11:02:37 +0900")
References: <20180606215616.12817-1-dirk@gouders.net>
        <a594b5a7-d5c8-e938-df4e-dbba93ff3837@infradead.org>
        <ghzi07v944.fsf@lena.gouders.net>
        <f833ff8b-75ed-3ca4-ec24-a129a05902d1@infradead.org>
        <ghr2ljv5c9.fsf@lena.gouders.net>
        <CAK7LNARWC3J4V=Nx9rypwaWK8Lsv9A6J3LDW7s6E1xjc0JDE4A@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date: Thu, 07 Jun 2018 07:56:33 +0200
Message-ID: <ghmuw7uoku.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> 2018-06-07 8:54 GMT+09:00 Dirk Gouders <dirk@gouders.net>:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>>
>>> On 06/06/2018 03:32 PM, Dirk Gouders wrote:
>>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>>
>>>>> On 06/06/2018 02:56 PM, Dirk Gouders wrote:
>>>>>> Hello,
>>>>>>
>>>>>> being an Emacs user, I frequently find myself pressing CTRL-s in mconf
>>>>>> to search for some menu entry, especially in large menus.
>
>
> I use Emacs, but I have never typed Ctrl-s in menuconfig.
>
> Is it important to use the same key pattern as in Emacs?
>
> You intercepted Ctrl-*
>
> Currently, Ctrl-C terminates the program,
> but this patch makes it no-op.

Yes, Segher also pointed out that I at least should have mentioned this
in the cover letter.  I simply forgot that, but I was aware that
forced raw-mode probably is not acceptable.

I'd say it's not important to start isearch with CTRL-s, I am just so
used to it.  So, I am open for suggestions.  Meanwhile, in a V2 I will
try to stay with CTRL-s (and probably another unused simpler key) but
also create a possibility to toggle raw-mode with default off.

>>>>>> I decided to implement a basic isearch in mconf and would like to hear
>>>>>> if others find this functionality useful, as well.
>>>>>>
>>>>>> The new functionality is started with pressing CTRL-s followed by
>>>>>> characters that form the search string.  To search for further
>>>>>> occurences of an entered string, press CTRL-s instead of further
>>>>>> characters.
>>>>>>
>>>>>> For example: to navigate to the USB device drivers, press CTRL-s de ENTER ENTER usb ENTER ENTER
>>>>>
>>>>> Not being an emacs user, what is the "de" for above?
>>>>
>>>> "de" (with my .config) causes a match for "Device Drivers" --
>>>> no other menu entry matching the string "de" is befor that entry.
>>>>
>>>
>>> Device Drivers is the first match for me also.
>>>
>>> To get to the USB drivers, I have to enter:
>>>       CTRL-s de ENTER ENTER CTRL-s usb ENTER ENTER
>>
>> Yes, I left out the second CTRL-s, thank you!
>>
>> Oh well, I shouldn't have sent this late at night, then I would probably
>> have explained the needed input as:
>>
>>      1) CTRL-s  // start isearch
>>      2) de      // substring that matches "Device Drivers"
>>      3) ENTER   // quit isearch
>>      4) ENTER   // enter Device Drivers menu
>>      5) CTRL-s  // start isearch
>>      6) usb     // navigate to USB support
>>      7) ENTER   // quit isearch
>>      8) ENTER   // enter USB support menu
>
>
> Hmm.
>
> I tried this, but I was a bit annoyed.
>
>
> I wonder if this could be more user-friendly.
>
> For example, I want KEY_UP/DOWN/LEFT/RIGHT
> to quit the search mode without pressing ENTER.

Thank you for testing it.  Concerning annoyance, did you mean the isearch
functionality itself or the incomplete implementation, i.e. the missing
possibility to use above keys?

I will handle the above keys in V2, additionally to fixing a problem
with mismatches.

Dirk
