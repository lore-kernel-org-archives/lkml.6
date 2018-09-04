Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D70CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AA320869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AA320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeIDLkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:40:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbeIDLkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:40:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F327087927;
        Tue,  4 Sep 2018 07:16:24 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 323962023416;
        Tue,  4 Sep 2018 07:16:23 +0000 (UTC)
Date:   Tue, 4 Sep 2018 15:16:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     kirill.shutemov@linux.intel.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
Message-ID: <20180904071620.GL1740@192.168.1.3>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
 <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
 <20180904034414.GI1740@192.168.1.3>
 <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com>
 <20180904052036.GJ1740@192.168.1.3>
 <c4f65956-ad99-84ee-d4bf-044a6f0c5010@zytor.com>
 <20180904060649.GK1740@192.168.1.3>
 <44fc1530-eb88-d8c5-7465-e48c91799a98@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44fc1530-eb88-d8c5-7465-e48c91799a98@zytor.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 04 Sep 2018 07:16:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 04 Sep 2018 07:16:25 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/18 at 11:36pm, H. Peter Anvin wrote:
> On 09/03/18 23:06, Baoquan He wrote:
> >>
> >> That makes no sense.  I'm talking about *entering* the kernel; the second
> >> kernel should switch to 5-level mode as necessary.
> > 
> > OK, I didn't get your point. I forget what difficulty was met so that
> > Kirill need to take this way. In that way, we will never have chance to
> > put kernel above 64TB even from 5-level kernel to jump to 5-level
> > kernel.
> > 
> 
> It sounds like you have no intent of doing that anyway?  Now, that is
> something one could use an xloadflag for, as I previously stated: "this kernel
> supports being entered in 5-level mode."

I am willing to take any better way to improve. May need to make clear
why that was not taken. Not sure if Kirill still has the details.

Thanks
Baoquan

