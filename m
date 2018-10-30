Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DBBC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727242080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727242080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeJ3RwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:52:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6151 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeJ3RwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:52:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A679A6E13;
        Tue, 30 Oct 2018 08:59:22 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20410608EF;
        Tue, 30 Oct 2018 08:59:20 +0000 (UTC)
Date:   Tue, 30 Oct 2018 16:59:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Omar Sandoval <osandov@fb.com>, x86@kernel.org,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
Message-ID: <20181030085917.GC11408@MiWiFi-R3L-srv>
References: <1540593788-28181-1-git-send-email-bhsharma@redhat.com>
 <20181027100241.GB1884@MiWiFi-R3L-srv>
 <CACi5LpPf9Zr1beowRNGmLZY7DtS3JDt8D=FONjqas9yo7TyCjg@mail.gmail.com>
 <20181030020752.GB11408@MiWiFi-R3L-srv>
 <CACi5LpP0_s9zAF+QfKpU+kG6BKqqkiwQhcW-WFZ0=SnBeX7ZXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACi5LpP0_s9zAF+QfKpU+kG6BKqqkiwQhcW-WFZ0=SnBeX7ZXA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 30 Oct 2018 08:59:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 10/30/18 at 12:33pm, Bhupesh Sharma wrote:
> > Why it's broken? Have you investigated and figured out why it's broken?
> > If fix, what patch will it look like? Does the patch prove it's not
> > worth using the current way?
> >
> > Have you thought about this in advance? Or still like before, you said
> > on arm64 you found different boards have different behaviour, then
> > makedumpfile maintainer Kazu said he investigated and found it may be
> > caused by KALSR. This time, for this KCORE_REMAP adding, can you help to
> > investigate further and give an answer to the issue you found and
> > raised?
> 
> Ofcourse, the patchset which added vmcoreinfo into kcore was discussed
> and it was agreed that this was a better approach to move forward and hence
> accepted in mainline.

Currently I am wondering why x86_64 need add page_offset_base to
vmcoreinfo. Is it because any feature or userspace tool is broken if
page_offset_base is not added into vmcoreinfo? 

Why KCORE_REMAP adding broke makedumpfile, do you find out the root
cause and what it looks like if you fix it in the current way?

Can you list the reasons one by one as below with short sentence?
1)
2)
3)

> 
> Regarding the makedumpfile issue, I have already provided a detailed
> reply to Kazu (you are Cc'ed on the thread) and also proposed a
> makedumpfile approach which
> reads the 'page_offset_base' value from kcore (using the kernel
> interface provided by this patch),
> [on which you are Cc'ed as well]:

This is your replying mail link:
https://www.spinics.net/lists/kexec/msg21616.html

Then what on earth do you want to fix in this patch?

So Kazu's patch which decuding page_offset_base like x86 64 have done works.
Yes, and your way using vmcoreinfo in kcore also works, but this is not
the reason which supports you to discard the old way Kazu suggested. Now
we are talking about why you want to discard the old way, and adding
page_offset_base to vmcoreinfo.

Please elaborate and reply with simple and clear logic.

Thanks
Baoquan

