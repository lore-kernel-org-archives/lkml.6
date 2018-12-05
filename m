Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5C3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D472081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D472081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeLEOVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:21:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLEOVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:21:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6091537E87;
        Wed,  5 Dec 2018 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-56.pek2.redhat.com [10.72.12.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A65F91001F54;
        Wed,  5 Dec 2018 14:21:17 +0000 (UTC)
Subject: Re: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com> <20181203150809.GA4794@zn.tnic>
 <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
 <20181205113032.GF29510@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <3d1a7e68-34c5-d118-fe09-7c9bc14cce84@redhat.com>
Date:   Wed, 5 Dec 2018 22:21:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181205113032.GF29510@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 05 Dec 2018 14:21:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年12月05日 19:30, Borislav Petkov 写道:
> On Tue, Dec 04, 2018 at 05:35:09PM +0800, lijiang wrote:
>> There are more people to review and improve this document together, that would
>> be fine.
> 
> That's basically kernel development :)
> 
>> Generating VMCOREINFO is easy in the first kernel, for example:
>> # makedumpfile -g VMCOREINFO -x vmlinux
> 
> I get:
> 
> $ makedumpfile -g VMCOREINFO -x vmlinux
> The kernel version is not supported.
> The makedumpfile operation may be incomplete.
> 
> The vmcoreinfo is saved to VMCOREINFO.
> 
> makedumpfile Completed.
> 
> But the text file looks ok AFAICT. Please add that command to the
> documentation file.
> 

Ok, no problem.

>> For these two *why*, it should be easy to understand. Because user-space tools
>> need to know basic information, such as the symbol values, field offset, structure
>> size, etc. Otherwise, these tools won't know how to analyze the memory of the crash
>> kernel.
> 
> That's clear. The question is *why* *exactly* is every piece of export
> needed.
> 
>> For the second question 'how they are used', we can get the answer
>> from user-space tools, such as makedumpfile, crash tools. Therefore,
>> it may not need to explain any more in kernel document. On the other
>> hand, if we must put these contents into kernel document, i have to
>> say, that would be a hard task.
> 
> You can put one or two sentences for each, stating what they're used
> for. This way, people can go and look up makedumpfile source code for
> further info and people trying to add new items to VMCOREINFO can look
> in this documentation here first to figure out whether maybe the info
> they need has been exported already.
> 

This is a considerate suggestion.

I will try my best to do that.

Thanks.

Lianbo.

> Thx.
> 
