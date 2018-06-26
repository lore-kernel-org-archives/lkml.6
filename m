Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3DDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DF721104
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DF721104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934129AbeFZX3f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:29:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752445AbeFZX3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:29:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC01240201CE;
        Tue, 26 Jun 2018 23:29:33 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D0921C665;
        Tue, 26 Jun 2018 23:29:33 +0000 (UTC)
Subject: Re: [PATCH] get_maintainer.pl: Add optional
 .get_maintainer.MAINTAINERS override
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     dzickus@redhat.com, jtoppins@redhat.com
References: <20180626182505.4176-1-prarit@redhat.com>
 <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
 <98fe3602-864a-3963-ac56-a743f1b61700@redhat.com>
 <56a7221b36f3969d340c72bac34942dd59cdc47f.camel@perches.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <21a533fc-f76d-caa0-8586-e7631e3721bf@redhat.com>
Date:   Tue, 26 Jun 2018 19:29:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <56a7221b36f3969d340c72bac34942dd59cdc47f.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 26 Jun 2018 23:29:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 26 Jun 2018 23:29:33 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'prarit@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/26/2018 07:04 PM, Joe Perches wrote:
> On Tue, 2018-06-26 at 18:52 -0400, Prarit Bhargava wrote:
>>
>> On 06/26/2018 04:16 PM, Joe Perches wrote:
>>> On Tue, 2018-06-26 at 14:25 -0400, Prarit Bhargava wrote:
>>>> OSes have additional maintainers that should be cc'd on patches or may
>>>> want to circulate internal patches.
>>>>
>>>> Parse the .get_maintainer.MAINTAINERS file.  Entries in the file
>>>> can begin with a '+' to indicate the email and list entries should be
>>>> added to the exiting MAINTAINERS output, or a '-' to indicate that the
>>>> entries should override the existing MAINTAINERS file.
>>>>
>>>> Also add a help entry for the .get_maintainers.ignore file.
>>>
>>> I see no reason for this patch to be applied.
>>> Why should it?
>>
>> The kernel has other vendor/OS changes like my patch, for example, 4efb442cc12e
>> ("kernel/panic.c: add TAINT_AUX").  From that commit message
>>
>>     Add an auxiliary taint flag to be used by distros and others.  This
>>     obviates the need to forward-port whatever internal solutions people
>>     have in favor of a single flag which they can map arbitrarily to a
>>     definition of their pleasing.
>>
>> The same principle should be applied to my patch in that distros no longer would
>> need to forward-port internal solutions similar to this.
>>
>>> Why shouldn't this be in your private repository?
>>
>> If you don't want it I'll carry it forward but that's a loss for both of us, and
>> as pointed out in the above commit, other distros.  If you do want to reject the
>> patch please let me know and I'll only submit the "get_maintainer.ignore" help
>> chunk.
> 
> I doubt it's a really a loss for others as whatever
> .get_maintainers.<foo> files would likely need to
> be customized for each distro.

That's the point of the patch.  Each distro would customize their own internal
.get_maintainers.MAINTAINERS file.

In any case, consider it dropped.

P.

> 
> I think the whole thing should be ignored.
> 
