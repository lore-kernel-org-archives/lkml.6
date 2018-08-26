Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7498C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 07:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BBF208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 07:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA6sm3tN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BBF208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeHZLK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 07:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeHZLK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 07:10:29 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D38E208C4;
        Sun, 26 Aug 2018 07:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535268527;
        bh=p6uSzjefdoKTdEf4CC2k6u8vyX2xO8XYAib4P0t3fQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YA6sm3tNqNt17/lqqTkcbNIKKrj0lRpSx+5TlX76HbFpkAVnbTt/dTu6v2YA3Ao68
         +8MLYT8BsMI7D0y1qWNT8c2FMHiw3ZZHYQzpXN6GGSlyWxTGOvwrP3FVhhJPokI7qi
         G6TPpeGydV7KjKvtKg/QfvNjjHZ+28aujPU8GG2w=
Date:   Sun, 26 Aug 2018 16:28:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/32] selftests/ftrace: Add --console hidden option
Message-Id: <20180826162843.82de7e0f4c342507c954c384@kernel.org>
In-Reply-To: <20180824214204.38e2004d@vmware.local.home>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443703653.23257.12015337438174061938.stgit@devbox>
        <20180824163737.0f47535a@gandalf.local.home>
        <20180825103513.5b86d42a7ee2d20435522fbb@kernel.org>
        <20180824214204.38e2004d@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 21:42:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 25 Aug 2018 10:35:13 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Fri, 24 Aug 2018 16:37:37 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Fri, 17 Aug 2018 01:30:36 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > > Add --console hidden option for debug test cases.
> > > > This option allows to put "sh" or something else
> > > > when the test case hits a bug.  
> > > 
> > > Can you add more information to why and how this would be used.  
> > 
> > For example, if you find a testcase which doesn't
> > pass, you can insert sh for interactive debug as below
> > 
> >   #!/bin/sh
> >   # description: sample test case
> > 
> >   good-command
> >   suspicious-wrong-command
> >   sh # <- add this for interactive debug
> > 
> 
> Ah! OK. But this needs to be explained a little better in the change
> log as well as in the comments for it.

Ah sorry I missed "I will add following example"... yes, of course
I add this to description.

Thank you,

> 
> Thanks!
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
