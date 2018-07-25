Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29715C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BD820891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BD820891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbeGYQNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:13:31 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:47094 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbeGYQNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:13:31 -0400
Received: by mail-qk0-f196.google.com with SMTP id o2-v6so5071676qkc.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 08:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qZi5F5hz5jWJp5maHjZGiMG3J86Ec9jIUqPq+ttQDNU=;
        b=CN/6LkG8hR5qX6zdWpgZ5u03MTEudCSBzbToY3lWDeZ6h2zvKP25JnR5bz/Hbl0Gfx
         eP2L5pl2nufraGts3hVNT/boKS5l5HzLWDqsSI4DewbzwGc7zgEttxB4pdRIMuznuusT
         I/gWbOY+JmMkuj5DyqKErut+buSpTSQHbP+uwqZSDiHVjMAPz9/a77awLJ24LIDcvm2t
         Dy2xY5IYo//yhWx0ik0m5+N1vDgVqokYmFioIg3Y4qrlIQRQpHJlSTk7y6TVzcdHCkOK
         FMK5cIbWj3EBI6/mDzHypIGnkA70fTb80vU+GBl7z2qZ5IOUIqrJMtdyb/vBV1IqT5R0
         4THg==
X-Gm-Message-State: AOUpUlHa3jQs9sxS4y5Wq8dVJCU4GEC6pQWY5mXdkXklIKt/23SZ/yAM
        w+BwYkafzPvnYGED9rtw6MF9BTzUL/c=
X-Google-Smtp-Source: AAOMgpfcRAEBLKuLsuWvyTUkXvtCrMygWFT7XYUqFyntAoQIoFVUa3BMpwEdDjHh4Ugro4S90ZjEPg==
X-Received: by 2002:a37:5142:: with SMTP id f63-v6mr19833738qkb.369.1532530884373;
        Wed, 25 Jul 2018 08:01:24 -0700 (PDT)
Received: from laptop.jcline.org (075-177-179-204.res.spectrum.com. [75.177.179.204])
        by smtp.gmail.com with ESMTPSA id f64-v6sm17110595qkf.2.2018.07.25.08.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 08:01:23 -0700 (PDT)
Subject: Re: [PATCH] scripts: Add Python 3 support to
 tracing/draw_functrace.py
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180720193528.1341-1-jcline@redhat.com>
 <CAK7LNAQWotaFhMAnW=Ah8aFO8VMxUB4bXursTe6JTZxcTzettQ@mail.gmail.com>
From:   Jeremy Cline <jcline@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jcline@redhat.com; keydata=
 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
 X/87hZ4pdW/aOXUAgQ==
Message-ID: <fd435ffe-5323-6c71-8945-b3b22ee80e84@redhat.com>
Date:   Wed, 25 Jul 2018 11:01:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQWotaFhMAnW=Ah8aFO8VMxUB4bXursTe6JTZxcTzettQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2018 10:39 AM, Masahiro Yamada wrote:
> 2018-07-21 4:35 GMT+09:00 Jeremy Cline <jcline@redhat.com>:
>> Use the print function. This maintains Python 2 support and should have
>> no functional change.
>>
>> Signed-off-by: Jeremy Cline <jcline@redhat.com>
>> ---
>>  scripts/tracing/draw_functrace.py | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
>> index db40fa04cd51..7d44e796d362 100755
>> --- a/scripts/tracing/draw_functrace.py
>> +++ b/scripts/tracing/draw_functrace.py
>> @@ -20,6 +20,7 @@ Usage:
>>         $ scripts/draw_functrace.py < raw_trace_func > draw_functrace
>>         Then you have your drawn trace in draw_functrace
>>  """
>> +from __future__ import print_function
> 
> What do you need this line for?
> 
> I have not tested this,
> but I guess print(CallTree.ROOT) will work for Python 2.

Although "print(CallTree.ROOT)" (as a statement) works in Python 2,
its behavior is different than print (as a function) in Python 3. In
this case, there's no additional arguments being provided so the
behavior will match, but if someone added an argument it would work
differently on Python 2 vs Python 3:

Python 2.7.15
>>> print("hello", "world")
('hello', 'world')

Python 3.6.6
>>> print("hello, "world")
  File "<stdin>", line 1
    print("hello, "world")
                       ^
SyntaxError: invalid syntax

Importing the print_function works on Python 2.6+[0] and changes print
to be a function in Python 2 so it'll behave the same in 2 and 3. Given
that this script doesn't appear to change much it's probably not going
to save anyone from making that mistake, though. Would you prefer a
patch without it?

[0] https://docs.python.org/3/library/__future__.html

Regards,
Jeremy

> 
> 
> 
>>
>>  import sys, re
>> @@ -123,7 +124,7 @@ def main():
>>                 tree = tree.getParent(caller)
>>                 tree = tree.calls(callee, calltime)
>>
>> -       print CallTree.ROOT
>> +       print(CallTree.ROOT)
>>
>>  if __name__ == "__main__":
>>         main()
>> --
>> 2.17.1
>>
> 
> 
> 
