Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92F1C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983B820820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983B820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeKATzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:55:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbeKATzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:55:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2BFCD37E85;
        Thu,  1 Nov 2018 10:53:24 +0000 (UTC)
Received: from 117.195.187.81.in-addr.arpa (unknown [10.33.36.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9066F5D9CB;
        Thu,  1 Nov 2018 10:53:22 +0000 (UTC)
Subject: Re: [git pull] mount API series
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181031053355.GQ32577@ZenIV.linux.org.uk>
 <CAHk-=whAE6gVi18=u4sSWe1m2RWPh19YCkKQmW4Kx+NQX1mg8w@mail.gmail.com>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <af28fc2c-d207-875e-8070-f64ead878b5a@redhat.com>
Date:   Thu, 1 Nov 2018 10:53:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=whAE6gVi18=u4sSWe1m2RWPh19YCkKQmW4Kx+NQX1mg8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 01 Nov 2018 10:53:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 31/10/18 16:18, Linus Torvalds wrote:
> On Tue, Oct 30, 2018 at 10:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>          mount API series from David Howells.  Last cycle's objections
>> had been of the "I'd do it differently" variety and with no such
>> differently done variants having ever materialized over several
>> cycles...
> Having just lurked on the discussions about the bugs in here, I don't
> think this is ready. Maybe they got fixed, but if so, it was recent
> and it was pretty fundamental.
>
> The stated aim of the series is to make the mount API _better_, not
> worse. And right now it looks like a "two steps back, one theoretical
> step forwards" kind of better.
>
>                Linus

The design of the new mount API has been under discussion for some time, 
both on the mailing lists, and also at LSF/MM too. Al and David (and 
others) have put a lot of work into getting to the current position, and 
have specifically requested input from Eric about his concerns over past 
cycles.

When I look at the discussions I'm seeing two main issues (please 
correct me if you think I'm wrong about this) which are (a) whether the 
design is correct and (b) whether there are still bugs in the current 
patch set.

Which of these are you most concerned about? It seems to me that there 
is not a lot of point in spending a large amount of time in additional 
review/testing of the current patch set if the overall design is set to 
be rejected. If your concerns are only with the robustness/stability of 
the patch set, then that provides a clear route to resolving the current 
impasse, at least assuming that Eric is able to enumerate the issues 
that he has discovered.

It looks like David has already provided a fix for one of the issues 
which Eric mentioned in his recent email. Eric it would be good if you 
could confirm that this addresses that particular concern,

Steve.

