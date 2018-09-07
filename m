Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA81C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150272077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hjWO2rPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150272077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbeIGSzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:55:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeIGSzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OG7CpCqwDTHhoXbBOHqBcBUWNn3zGgm6Vv7WweSw7So=; b=hjWO2rPLXO6nzGeWOlf1LlpQh
        b6JAdQ9U1qo8kbCROD0HuD9nAZYGYMWgCz4ycQcLRxS9q94U0RYATWsMWK6/4XFvQKbFfaR8gagnW
        5pSblOX88N+O8RjdHXApbSsvVL6KrT+nmi1iTbPeNvCleX9+IYLhE6fMBa+COuIldw10HjYiCd3ti
        YhL+JtdyIqBbzPsdT1FNdRn7KAMGpWMk7gaWgUoEZAUBWuOlKxxJC2yQJrlY7YdSS03gfAKqJroFD
        2xmEYYYu+cBGaFlqM14WSEgMaAFfa6wPbgblWv0II93NfEqdP4OAdpFboYErR/tfsT7fDQV9dxX6k
        c4kt6N8vg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyHWC-0006NJ-C2; Fri, 07 Sep 2018 14:13:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF5FD2024E43D; Fri,  7 Sep 2018 16:13:50 +0200 (CEST)
Date:   Fri, 7 Sep 2018 16:13:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf: enum overflow in uapi/linux/perf_event.h
Message-ID: <20180907141350.GK24142@hirez.programming.kicks-ass.net>
References: <a70172863fa7d3c138f788b18d36524bd45b0a73.1536326078.git.christophe.leroy@c-s.fr>
 <20180907134246.GC24106@hirez.programming.kicks-ass.net>
 <ae32181d-37b2-1a13-3c72-66775e05ff88@c-s.fr>
 <20180907135817.GF24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907135817.GF24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 03:58:17PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 07, 2018 at 01:50:18PM +0000, Christophe Leroy wrote:
> > 
> > 
> > On 09/07/2018 01:42 PM, Peter Zijlstra wrote:
> > > On Fri, Sep 07, 2018 at 01:27:19PM +0000, Christophe Leroy wrote:
> > > > On PPC32, enums are 32 bits, so __PERF_SAMPLE_CALLCHAIN_EARLY is
> > > > out of scope. The following sparse warning is encountered:
> > > > 
> > > >    CHECK   arch/powerpc/kernel/process.c
> > > > ./include/uapi/linux/perf_event.h:147:56: warning: cast truncates bits from constant value (8000000000000000 becomes 0)
> > > 
> > > Urgh... what compiler is that? I've not seen anything like that from the
> > > build bots.
> > > 
> > 
> > [root@pc16082vm linux-powerpc]# sparse --version
> > 0.5.2
> > 
> > [root@pc16082vm linux-powerpc]# ppc-linux-gcc --version
> > ppc-linux-gcc (GCC) 5.4.0
> 
> Ah, that's a sparse warning. But does your GCC agree? The thing is,
> sparse uses the C enum spec, but I suspect GCC uses the C++ enum spec
> and it all works fine.

What does the below proglet print on your PPC32 box? I suspect the
output will be:

400000000000

and all is well.

---
#include <stdio.h>

enum ponies {
	big = 1ULL<<46,
};

int main(int argc, char **argv)
{
	unsigned long long val = big;
	printf("%Lx\n", val);
	return 0;
}

