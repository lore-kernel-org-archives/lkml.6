Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D933EC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E2E2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E2E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeJDT6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:58:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbeJDT6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:58:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C89B180F8F;
        Thu,  4 Oct 2018 13:05:20 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D15D117CFA;
        Thu,  4 Oct 2018 13:05:19 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] locking/lockdep: Make class->ops a percpu counter
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
References: <1538511560-10090-1-git-send-email-longman@redhat.com>
 <1538511560-10090-5-git-send-email-longman@redhat.com>
 <20181003074809.GJ26858@hirez.programming.kicks-ass.net>
 <62801eb9-16f2-606f-d3a2-61fef5b0a704@redhat.com>
 <d66681f3-8781-9793-1dcf-2436a284550b@redhat.com>
 <20181004101423.GA83274@gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a802775b-4833-426d-cff9-f4bdeb4c7d2e@redhat.com>
Date:   Thu, 4 Oct 2018 09:05:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181004101423.GA83274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 04 Oct 2018 13:05:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 06:14 AM, Ingo Molnar wrote:
> * Waiman Long <longman@redhat.com> wrote:
>
>> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
>> index b0d0b51c4d85..1fd82ff99c65 100644
>> --- a/include/linux/lockdep.h
>> +++ b/include/linux/lockdep.h
>> @@ -99,13 +99,8 @@ struct lock_class {
>>  	 */
>>  	unsigned int			version;
>>  
>> -	/*
>> -	 * Statistics counter:
>> -	 */
>> -	unsigned long			ops;
>> -
>> -	const char			*name;
>>  	int				name_version;
>> +	const char			*name;
> 'name' gets moved by the patch - better structure packing on 64-bit kernels?
>
> Looks good to me otherwise.
>
> Thanks,
>
> 	Ingo

Yes, that is done on purpose to pack the 2 integers together to remove
two 4-byte holes on 64-bit archs.

Cheers,
Longman

