Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C9AC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E120420895
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kqdSKvbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E120420895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeG1HHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 03:07:18 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:31554 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeG1HHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 03:07:17 -0400
Received: from mail-ua0-f169.google.com (mail-ua0-f169.google.com [209.85.217.169]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w6S5fwx2005915;
        Sat, 28 Jul 2018 14:41:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w6S5fwx2005915
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532756519;
        bh=z8KjIi1Dn85sxSz+TYmmynKB2daBqs+s7c97qFqXNMc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=kqdSKvbH9MsWgAELZm6crTDmBk0ZQLoE63BHv1aZL0h6ADosNnCsJGvTsPjrHMT99
         8sbU9Hrg9j5uujs+MmvKH57xsz4m8w/8kMw4r6D8v5J5KvZI7kjO+KiXyX68oi6NW/
         QfR0ME/kIohi78QCuHQg+ZCJoLDB+z/d6u2mCsiOZpU9OfQbNZKMB05eagvzfeaxon
         rBXJXuFMn+A2ucRLRH0uwMnpWPtJd7L2PHby+mJv2O57M7mdxvve9GAccOMiAlBxax
         Vl7RA/za83OQwZnpzXISwanQBiwKW9Ezc3CdP06SB808qev1eRa4olTgQ6d+qAG+U0
         kdv17W+qnMJgg==
X-Nifty-SrcIP: [209.85.217.169]
Received: by mail-ua0-f169.google.com with SMTP id k25-v6so4707850uao.11;
        Fri, 27 Jul 2018 22:41:59 -0700 (PDT)
X-Gm-Message-State: AOUpUlFzzsnTGDscwagYl5IzGNtxdt8n6jdWDR9INvZ4WMIa6hs2rrAR
        8jWZsmVHfKPriUsiUq2dNDoQYESmc8mhvjIUuuA=
X-Google-Smtp-Source: AAOMgpc3lDHKU/QCrQZWPC0rKClDwjsFs+d4lsQoYD9fJuOfTVBw8CeUc4QGIt7EAe1lHl34r1x5HqFR+WyvuO1DgJQ=
X-Received: by 2002:ab0:4946:: with SMTP id a6-v6mr6586408uad.82.1532756518229;
 Fri, 27 Jul 2018 22:41:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 22:41:17
 -0700 (PDT)
In-Reply-To: <fd435ffe-5323-6c71-8945-b3b22ee80e84@redhat.com>
References: <20180720193528.1341-1-jcline@redhat.com> <CAK7LNAQWotaFhMAnW=Ah8aFO8VMxUB4bXursTe6JTZxcTzettQ@mail.gmail.com>
 <fd435ffe-5323-6c71-8945-b3b22ee80e84@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 28 Jul 2018 14:41:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASW2y5Q-hu5uCK6te0J+=bGtC6OG98EbBiREA7UFwSZqQ@mail.gmail.com>
Message-ID: <CAK7LNASW2y5Q-hu5uCK6te0J+=bGtC6OG98EbBiREA7UFwSZqQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: Add Python 3 support to tracing/draw_functrace.py
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-26 0:01 GMT+09:00 Jeremy Cline <jcline@redhat.com>:
> On 07/25/2018 10:39 AM, Masahiro Yamada wrote:
>> 2018-07-21 4:35 GMT+09:00 Jeremy Cline <jcline@redhat.com>:
>>> Use the print function. This maintains Python 2 support and should have
>>> no functional change.
>>>
>>> Signed-off-by: Jeremy Cline <jcline@redhat.com>
>>> ---
>>>  scripts/tracing/draw_functrace.py | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
>>> index db40fa04cd51..7d44e796d362 100755
>>> --- a/scripts/tracing/draw_functrace.py
>>> +++ b/scripts/tracing/draw_functrace.py
>>> @@ -20,6 +20,7 @@ Usage:
>>>         $ scripts/draw_functrace.py < raw_trace_func > draw_functrace
>>>         Then you have your drawn trace in draw_functrace
>>>  """
>>> +from __future__ import print_function
>>
>> What do you need this line for?
>>
>> I have not tested this,
>> but I guess print(CallTree.ROOT) will work for Python 2.
>
> Although "print(CallTree.ROOT)" (as a statement) works in Python 2,
> its behavior is different than print (as a function) in Python 3. In
> this case, there's no additional arguments being provided so the
> behavior will match, but if someone added an argument it would work
> differently on Python 2 vs Python 3:
>
> Python 2.7.15
>>>> print("hello", "world")
> ('hello', 'world')
>
> Python 3.6.6
>>>> print("hello, "world")
>   File "<stdin>", line 1
>     print("hello, "world")
>                        ^
> SyntaxError: invalid syntax

Yes, I know this.


> Importing the print_function works on Python 2.6+[0] and changes print
> to be a function in Python 2 so it'll behave the same in 2 and 3. Given
> that this script doesn't appear to change much it's probably not going
> to save anyone from making that mistake, though. Would you prefer a
> patch without it?

Either will do.
If it is tedious to respin, I will pick this up.


I saw only one simple print statement in this script,
so I wanted to ask you if this had some reason
I might be missing.

Anyway, we will remove 'from __future__ import print_function'
when Python 2 retires.



> [0] https://docs.python.org/3/library/__future__.html
>
> Regards,
> Jeremy
>
>>
>>
>>
>>>
>>>  import sys, re
>>> @@ -123,7 +124,7 @@ def main():
>>>                 tree = tree.getParent(caller)
>>>                 tree = tree.calls(callee, calltime)
>>>
>>> -       print CallTree.ROOT
>>> +       print(CallTree.ROOT)
>>>
>>>  if __name__ == "__main__":
>>>         main()
>>> --
>>> 2.17.1
>>>
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
