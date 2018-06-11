Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5ZkeFMA7HlurRQAAmS7hNA
	; Mon, 11 Jun 2018 09:07:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4117D607BB; Mon, 11 Jun 2018 09:07:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CCC3660791;
	Mon, 11 Jun 2018 09:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCC3660791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754188AbeFKJHK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 05:07:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754066AbeFKJHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:07:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0F4C401EF04;
        Mon, 11 Jun 2018 09:07:08 +0000 (UTC)
Received: from krava (unknown [10.43.17.242])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6C578112D180;
        Mon, 11 Jun 2018 09:07:07 +0000 (UTC)
Date: Mon, 11 Jun 2018 11:07:06 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: Kim Phillips <kim.phillips@arm.com>, acme@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Test 6 dumps core on s390
Message-ID: <20180611090706.GA21328@krava>
References: <20180608131728.75084-1-tmricht@linux.ibm.com>
 <20180608095318.2ba14669fdc5da2004285bcf@arm.com>
 <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 11 Jun 2018 09:07:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 11 Jun 2018 09:07:08 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 09:00:53AM +0200, Thomas-Mich Richter wrote:
> On 06/08/2018 04:53 PM, Kim Phillips wrote:
> > On Fri, 8 Jun 2018 15:17:28 +0200
> > Thomas Richter <tmricht@linux.ibm.com> wrote:
> > 
> >> Perf test case 6 "Parse event definition strings"
> >> dumps core when executed on s390.
> > 
> > I reported it actually fails on any $ARCH system without
> > Intel Processor Trace (PT) h/w:
> > 
> > https://www.spinics.net/lists/linux-perf-users/msg06020.html
> > 
> > There was a follow-up patch sent here:
> > 
> > https://www.spinics.net/lists/linux-perf-users/msg06029.html
> > 
> > which worked for me, but I don't know what has/has-not transpired
> > since, other than it is still broken, as you found.
> > 
> > Kim
> 
> 
> Looks like this is still broken. I also can not find this patch on
> git clone -b perf/core git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
> 
> We actually need 2 patches
> - one to fix the core dump
> - one to test for x86 platform

right.. I forgot about those, will rebase/repost it

jirka
