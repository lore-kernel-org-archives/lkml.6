Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED4AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D77F2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D77F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbeJ3FUR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:20:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729553AbeJ3FUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:20:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDA5E9A760;
        Mon, 29 Oct 2018 20:30:00 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CB0D608EF;
        Mon, 29 Oct 2018 20:30:00 +0000 (UTC)
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
References: <20181029192521.23059-1-dave@stgolabs.net>
 <0afed890-7c5a-93ee-cdb9-e30775bd9cf1@redhat.com>
 <20181029200050.iejuxckzbm742dmw@linux-r8p5>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <3c5ba85b-5114-c751-0114-ac2cb64c02ea@redhat.com>
Date:   Mon, 29 Oct 2018 16:29:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181029200050.iejuxckzbm742dmw@linux-r8p5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 29 Oct 2018 20:30:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/2018 04:00 PM, Davidlohr Bueso wrote:
> On Mon, 29 Oct 2018, Waiman Long wrote:
>
>> I am wondering if /proc/stat_noirqs will be a more descriptive name of
>> the intent of this new procfs file or we should just go with the more
>> generic stat2 name.
>
> The reason why I went with '2' instead of a more rescriptive name
> was that I think of the call as a drop-in replacement/extention to
> stat. Therefore the same fields are maintained, otherwise with
> stat_noirqs
> I feel like instead of zeroing out, they should just be removed.
>
> But otoh, I have no strong objection in renaming either.
>
> Thanks,
> Davidlohr

I am just questioning the rationale for the stat2 name. I am not
advocating to use stat_noirqs neither.

BTW, since you are making stat2 compatible with stat, will that be
easier from the user API perspective if we use a sysctl parameter to
turn on and off IRQs reporting for /proc/stat, for example?

I know that there are pros and cons for each approach, I just want to
consider all the available options and choose the best one.

Cheers,
Longman



