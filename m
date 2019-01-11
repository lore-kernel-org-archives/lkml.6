Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A928EC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D586214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547167954;
	bh=ftTQbGhK72RKci2L0X0B2SCG+AirPqAYTNiMaxlJlxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kWl0xHi2AD7P1LbqnsggZ/ULdmgZu1My73eqBrFiYuOTOgMZsMsVbIM2znOwoTSpy
	 maQtfea2sqtk9VUh/VYCAqYZPKjtTKjIcfSTEZTNDn0ElRZEsQZl20rR+HaqOsoo8R
	 XhpKEI7v6gFQxOrFdO512v47huVZKCV9XGxoIylU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfAKAwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:52:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbfAKAwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:52:33 -0500
Received: from devnote (unknown [180.0.253.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6205420879;
        Fri, 11 Jan 2019 00:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547167953;
        bh=ftTQbGhK72RKci2L0X0B2SCG+AirPqAYTNiMaxlJlxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YG6reejRrUIP74fwG12RsA9FpPVBykJdNsN0uZ2EM4AIpVxZdYBtp/t5ScS7KaCG8
         bttCVilFRRYO6MF2Ez/yvTYNps4Qts7BGluVYUGK7Ki3/BrcWJdV/zWrZjvS4Ws5Lh
         qYlbGXBElffv4WBNOAmcGDg17Qn4Ap/GXQlbL35M=
Date:   Fri, 11 Jan 2019 09:52:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/9] x86/kprobes: Prohibit probing on optprobe template
 code
Message-Id: <20190111095229.f8a51ec73dc3ecf9ea64d6a0@kernel.org>
In-Reply-To: <20190110121034.766f37b4@gandalf.local.home>
References: <154708884117.6325.4454464467156828009.stgit@devbox>
        <154708887054.6325.3201133039718891603.stgit@devbox>
        <20190110060720.GA12546@kroah.com>
        <20190110235710.6b2a5cdb44ea05df73af997b@kernel.org>
        <20190110121034.766f37b4@gandalf.local.home>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 12:10:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 10 Jan 2019 23:57:10 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > Same for all patches in this series...  
> > 
> > Oops, sorry. I'll fix the format again.
> > BTW, I'm still considering I should make it other patches in this series
> > as improvement instead of fix, since those are just adding blacklist, and
> > usually user can avoid it with KPROBE_EVENTS_ON_NOTRACE=n (which is default).
> 
> The issue is that the other patches Cc stable, which they should not
> unless they are to go to stable.

Yes, I miss-Cc'd to stable the whole series.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
