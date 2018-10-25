Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4787BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86A220838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IuZcJ9mr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UiIdugMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86A220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeJYOCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:02:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeJYOCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:02:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C582C602BA; Thu, 25 Oct 2018 05:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540445502;
        bh=veWBQpMVpPklvc99nzVyn74lBus8U7yE6n+wgi2BPzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IuZcJ9mrFSuXW46Vu5Kr0in5aiJh/YAz0OWKsgOMEkMk02/IVAsYy5ucqKMfwS1tf
         cKjjBK6yXaQrVd+5ySHQq2zzuLZAN6jTKW/LidLVOi4dfzXqVbF0FNgOr41lUwNd2u
         QUcLalYPb2UN78TX+fjfeJWw45jYKFozqAc3KRt0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B0ACF602BA;
        Thu, 25 Oct 2018 05:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540445501;
        bh=veWBQpMVpPklvc99nzVyn74lBus8U7yE6n+wgi2BPzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UiIdugMfGD4Lbjyh23pVXxbvK9cQyhOH84GeRHVfHHBFDptGDMf5MtmIp0l+bJD8O
         8jIEXVNbSvrivin3/lFF/kvWnFMLTeBYcVgC8301mmqHcwRQvYNv/1I6TBZW1OGcbs
         Bd9MIqddEqOPHwud/TrYF09CUZoIWa0p5H/UyaHY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Oct 2018 11:01:41 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Arun Sudhilal <getarunks@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
In-Reply-To: <alpine.DEB.2.21.1810230711220.2343@hadrien>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
 <20181022181122.GK18839@dhcp22.suse.cz>
 <CABOM9Zpq41Ox8wQvsNjgfCtwuqh6CnyeW1B09DWa1TQN+JKf0w@mail.gmail.com>
 <20181023053359.GL18839@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810230711220.2343@hadrien>
Message-ID: <9bd14fb3c0ce8ca9a33c33ce81e66037@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-23 11:43, Julia Lawall wrote:
> On Tue, 23 Oct 2018, Michal Hocko wrote:
> 
>> [Trimmed CC list + Julia - there is indeed no need to CC everybody 
>> maintain a
>> file you are updating for the change like this]
>> 
>> On Tue 23-10-18 10:16:51, Arun Sudhilal wrote:
>> > On Mon, Oct 22, 2018 at 11:41 PM Michal Hocko <mhocko@kernel.org> wrote:
>> > >
>> > > On Mon 22-10-18 22:53:22, Arun KS wrote:
>> > > > Remove managed_page_count_lock spinlock and instead use atomic
>> > > > variables.
>> > >
>> >
>> > Hello Michal,
>> > > I assume this has been auto-generated. If yes, it would be better to
>> > > mention the script so that people can review it and regenerate for
>> > > comparision. Such a large change is hard to review manually.
>> >
>> > Changes were made partially with script.  For totalram_pages and
>> > totalhigh_pages,
>> >
>> > find dir -type f -exec sed -i
>> > 's/totalram_pages/atomic_long_read(\&totalram_pages)/g' {} \;
>> > find dir -type f -exec sed -i
>> > 's/totalhigh_pages/atomic_long_read(\&totalhigh_pages)/g' {} \;
>> >
>> > For managed_pages it was mostly manual edits after using,
>> > find mm/ -type f -exec sed -i
>> > 's/zone->managed_pages/atomic_long_read(\&zone->managed_pages)/g' {}
>> > \;
>> 
>> I guess we should be able to use coccinelle for this kind of change 
>> and
>> reduce the amount of manual intervention to absolute minimum.
> 
> Coccinelle looks like it would be desirable, especially in case the 
> word
> zone is not always used.
> 
> Arun, please feel free to contact me if you want to try it and need 
> help.
Hello Julia,

I was able to come up .cocci for replacing managed_pages,

@@
struct zone *z;
@@
(
z->managed_pages = ...
|
- z->managed_pages
+ atomic_long_read(&z->managed_pages)
)

@@
struct zone *z;
expression e1;
@@
- z->managed_pages = e1
+ atomic_long_set(&z->managed_pages, e1)

@@
expression e,e1;
@@
- e->managed_pages += e1
+ atomic_long_add(e1, &e->managed_pages)

@@
expression z;
@@
- z.managed_pages
+ atomic_long_read(&z.managed_pages)

But I m not able to use same method for unsigned long 
variables(totalram_pages)

@@
unsigned long totalram_pages;
@@
(
totalram_pages = ...
|
-totalram_pages
+atomic_long_read(&totalram_pages)
)

This throws error,

spatch test1.cocci mm/page_alloc.c
init_defs_builtins: /usr/lib/coccinelle/standard.h
HANDLING: mm/page_alloc.c

previous modification:
MINUS
   >>> atomic_long_read(&rule starting on line 1:totalram_pages)

According to environment 1:
    rule starting on line 1.totalram_pages -> page_idx ^ (1 <<
order)

current modification:
MINUS
   >>> atomic_long_read(&rule starting on line 1:totalram_pages)

According to environment 1:
    rule starting on line 1.totalram_pages -> page_idx

Fatal error: exception Failure("rule starting on line 1: already tagged 
token:
C code context
File "mm/internal.h", line 175, column 8,  charpos = 5368
     around = 'page_idx', whole content =        return page_idx ^ (1 << 
order);")

Regards,
Arun


> 
> julia
