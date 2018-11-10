Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4187C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EDA20825
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EDA20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKKAE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:04:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbeKKAE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:04:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 944D92D808;
        Sat, 10 Nov 2018 14:19:46 +0000 (UTC)
Received: from 117.195.187.81.in-addr.arpa (unknown [10.33.36.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6945C5D968;
        Sat, 10 Nov 2018 14:19:45 +0000 (UTC)
Subject: Re: [git pull] mount API series
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181031053355.GQ32577@ZenIV.linux.org.uk>
 <87a7mut9cm.fsf@xmission.com>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <2f4a2d58-dc7b-3a8f-65aa-9db432ce0a1e@redhat.com>
Date:   Sat, 10 Nov 2018 14:19:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87a7mut9cm.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sat, 10 Nov 2018 14:19:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 31/10/18 15:38, Eric W. Biederman wrote:
> Al Viro <viro@ZenIV.linux.org.uk> writes:
>
>> 	mount API series from David Howells.  Last cycle's objections
>> had been of the "I'd do it differently" variety and with no such
>> differently done variants having ever materialized over several
>> cycles...
> Absolutely not.
>
> My objections fundamentally is that I can find real problems when I look
> at the code.  Further the changes have not been incremental changes that
> have evolved the code from one state to another but complete
> replacements of code that make code review very difficult and bisection
> completely inapplicable.
>
> I also object that this series completely fails to fix the worst but I
> have ever seen in the mount API.  Whit no real intrest shown in working
> to fix it.
>
> A couple of bugs that I can see quickly.  Several of which I have
> previously reported:
>
> - There is an easily triggered NULL pointer deference with open_tree
>    and mount propagation.
>
>
Can you share some details of what this NULL dereference is? David and 
Al have been working on the changes as requested by Linus later in this 
thread, and they'd like to tidy up this issue too at the same time if 
possible. We are not asking you to actually provide a fix, in case you 
are too busy to do so, however it would be good to know what the issue 
is so that we can make sure that it is resolved in the next round of 
patches,

Steve.

