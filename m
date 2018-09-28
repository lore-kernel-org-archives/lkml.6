Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646FCC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F4C20685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F4C20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeI2A6o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:58:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbeI2A6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:58:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3977C0578FA;
        Fri, 28 Sep 2018 18:33:41 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A41584DA8E;
        Fri, 28 Sep 2018 18:33:40 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] debugobjects: Disable lockdep tracking of
 debugobjects internal locks
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, chuhu@redhat.com
References: <1537886469-18227-1-git-send-email-longman@redhat.com>
 <1537886469-18227-3-git-send-email-longman@redhat.com>
 <20180925153241.GD29985@hirez.programming.kicks-ass.net>
 <e3275861-6fbe-70c6-c005-2bfe80cbba0b@redhat.com>
 <20180925163150.GE29985@hirez.programming.kicks-ass.net>
 <e6dc78dc-fdd5-81b7-9a6a-c3e0f02286cc@redhat.com>
Organization: Red Hat
Message-ID: <52e6048f-c361-e6bc-7840-a55bbd30416f@redhat.com>
Date:   Fri, 28 Sep 2018 14:33:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <e6dc78dc-fdd5-81b7-9a6a-c3e0f02286cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 28 Sep 2018 18:33:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 12:36 PM, Waiman Long wrote:
> On 09/25/2018 12:31 PM, Peter Zijlstra wrote:
>> Also, where is the performance benefit here. The normal lock_acquire
>> path doesn't change gobal state (it will not see new lock ordering in
>> 99%+ of the cases).
>>
>> Typically we only push the lock on the task local lock stack, compute
>> the new hash, and do the hash lookup, find it already exists and return.
>>
>> So what is the expensive part, and can we do something about that?
> I will need to do some experimentation to find out. Will update this
> thread with my finding.
>

I have sent out a patchset on improving lockdep performance that
hopefully will help to alleviate the problems that I saw. I still have
other ideas about further changes I want to investigate, but that will
wait until I am done with the current lockdep patchset.

-Longman

