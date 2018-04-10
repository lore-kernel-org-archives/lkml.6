Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeDJCnE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:43:04 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:33829 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeDJCnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:43:02 -0400
X-Google-Smtp-Source: AIpwx4+w+c9ArkYfhhozVcxvAeIDQgpBu1YGsNTT/VtijQnYyXg0TlaFqllsuK0fFTdghJrxsNqWbA==
Subject: Re: [PATCH] checkpatch: relax check for revert commit
To: Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc: linux-kernel@vger.kernel.org, Jia He <jia.he@hxt-semitech.com>
References: <1522679339-19067-1-git-send-email-hejianet@gmail.com>
 <1522679339-19067-2-git-send-email-hejianet@gmail.com>
 <d5f5fbc7-d01f-05e1-f8ac-c1db8ba5fd9e@gmail.com>
 <7d9467ac5aee4b81b5c58c167ac553c75dd26f4c.camel@perches.com>
 <979a4ce5-2c68-6186-476c-1214aed2cdbc@gmail.com>
 <e5d59c005cdf0183b866fd24a012ccc35118f121.camel@perches.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <7c4a079b-9708-2b6e-5462-2c1c6bbf08d2@gmail.com>
Date: Tue, 10 Apr 2018 10:42:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e5d59c005cdf0183b866fd24a012ccc35118f121.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2018 6:50 PM, Joe Perches Wrote:
> On Mon, 2018-04-09 at 14:37 +0800, Jia He wrote:
>> On 4/9/2018 1:07 AM, Joe Perches Wrote:
>>> On Sun, 2018-04-08 at 10:12 +0800, Jia He wrote:
>>>> Hi Andy & Joe
>>>>
>>>> Although it is minor, it is a real bug, I thought.
>>>>
>>>> Is there any comment? Thank you
>>> If you really want to do something useful here,
>>> quote the quote characters and compare for that.
>>>
>>>
>> Hi Joe, thanks for the comments
>> I am not sure I understand you comments here.
> Change the tests to allow quote characters instead
> of ignoring them.
>
> To do this matching, any internal  quote character in
> the actual commit string and the commit string from the
> patch must be perl quoted with \Q<string>\E so that the
> expected title can be matched properly.
Sorry,I didn't catch your point, even can't image how \Q \E is helpful. ;-)
Maybe I haven't explained my changes clearly.
e.g. commit f5c1350256fb ("Revert "XXX"")
2617                         } elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
2618                                  defined $rawlines[$linenr] &&
2619                                  $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
2620                                 $orig_desc = $1;
2621                                 $hasparens = 1;
line 2619, the match pattern ([^"]+)"\) will match NULL and let $orig_desc="" in 
this case.
My change is to let $orig_desc to be Revert "XXX"
Since the old code will check the commit id by git command to get the _real_ 
commit title.
I can't understand why I should use \Q \E here, sorry if I am missing something.

Cheers,
Jia
