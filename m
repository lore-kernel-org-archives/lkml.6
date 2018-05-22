Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeEVImi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:42:38 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:55507 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeEVImh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:42:37 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w4M8gTOH024604
X-Nifty-SrcIP: [209.85.217.180]
X-Google-Smtp-Source: AB8JxZodbMfbeSJpA5U4GzJYJSnFucSDefipeG5Sd+LpW8hEZfWILMJikxf1ciRNMJ8dUYIvzg498J3XtvwuI5ZT6V0=
MIME-Version: 1.0
In-Reply-To: <20180522082117.p2b5jt5qtuwarqwo@gmail.com>
References: <20180518115619.jqb4hqdym7fmrs2p@gmail.com> <CAK7LNASuhoJsaBz6RjumbQnqhtyLJGLjkhGSs5-bvDz1TOuGww@mail.gmail.com>
 <20180522082117.p2b5jt5qtuwarqwo@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 22 May 2018 17:41:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNARgW-YdGbtT3sJt_UpE02CEAvE9csm8Oc2SoSZo71Bt8w@mail.gmail.com>
Message-ID: <CAK7LNARgW-YdGbtT3sJt_UpE02CEAvE9csm8Oc2SoSZo71Bt8w@mail.gmail.com>
Subject: Re: [PATCH v4] scripts/tags.sh: use `find` for $ALLSOURCE_ARCHS generation
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-22 17:21 GMT+09:00 Joey Pabalinas <joeypabalinas@gmail.com>:
> On Tue, May 22, 2018 at 03:01:07PM +0900, Masahiro Yamada wrote:
>> The commit log is wrong.
>>
>>
>> 2018-05-18 20:56 GMT+09:00 Joey Pabalinas <joeypabalinas@gmail.com>:
>> > Parsing `ls` is fragile at best and _will_ fail when $tree
>> > contains spaces.
>>
>> This statement is wrong.
>>
>> The cause of the problem is not using whatever command you use,
>> but missing quoting.
>> The following would work even  if $tree contains spaces:
>>
>>     for arch in `ls "${tree}arch"`; do
>
> Ah, to be completely honest that case didn't even occur to me.
>
>> BTW, what was your motivation of this patch?
>>
>> Does ${tree} contain spaces?
>
>>
>> If the file path contains spaces, the top Makefile terminates it earlier.
>>
>> Makefile:128: *** main directory cannot contain spaces nor colons.  Stop.
>
> It doesn't; I didn't realize the Makefile already had a guard against
> spaces in paths. It was something I noticed when poking at something
> else and I thought it might be something worth fixing.
>
> But now I agree with you that this patch isn't really needed at all. I can
> no longer think of a case where even the original
>
>> for arch in `ls ${tree}arch`; do
>
> would break since spaces are not allowed at all.
>
> Well, on the bright side, the times you happen to be wrong are also the
> times where you learn the most :)
>


I see some new motivations for this patch now.

  - The current code includes 'Kconfig' in ALLSOURCE_ARCHS,
    but it should not.

  - Simplify the code, removing the find_all_archs().


If you are motivated for v5,
how about this?

  - Remove the double-quotes from "${tree}arch/"
    (Because the rest parts of this script do not have double-quoting,
     I do not see point in adding it in this line only.)

  - Update the git-log to not mention the hypothetical space things.




-- 
Best Regards
Masahiro Yamada
