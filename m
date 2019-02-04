Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99225C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFA0214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276512;
	bh=3LeQcrleV1Ywt6qc1cHtvbnDaWsHvm8vRVu3rC5TXts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tB5Nul2h+eKQMyUpRqU1ke6opqWGiDe0nuqub3Yf6BVxZ0zgcgLVfm7RUlNr+RQAZ
	 MS45sLkUN3qQIWTzd7BMLe5lDJXQaP/rtb+qJy0l0bMhz8hUZ+0h0advzB51wihmFM
	 RXLXVkUiuJiJMuLPLqLSDlRgFM/zY7H4hYLQrkBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfBDKfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:35:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfBDKfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:35:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 930E12070C;
        Mon,  4 Feb 2019 10:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276509;
        bh=3LeQcrleV1Ywt6qc1cHtvbnDaWsHvm8vRVu3rC5TXts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkJ10kjxtGmuXhaPpJvUEPavU5CIkYTZMXZzF3xTg0fpxi/7jGnPY4m67GyIOIt6f
         26jsjCXASCAPqTrljn2NYK6oaN/WC6byRSKahX6MImnZDv5rGXrlRnjidr/UOyQEoX
         M5nbJ/o5lCcEhfgXjUnEdX3IDmG41livZBC9DYyc=
Date:   Mon, 4 Feb 2019 11:35:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, ltp@lists.linux.it,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        chrubis <chrubis@suse.cz>
Subject: Re: [PATCH 4.14 00/68] 4.14.97-stable review
Message-ID: <20190204103506.GB3614@kroah.com>
References: <20190129113131.751891514@linuxfoundation.org>
 <CA+G9fYvh6axRDLWpR3_ozw46JUknsYgEjvYOZfQEUbhroHPVTA@mail.gmail.com>
 <CAOQ4uxiZ2ZPfcVNSX64ZD_JqQuBwz45_WAoNjpYEhfvTuHgZHQ@mail.gmail.com>
 <20190130193223.GA20667@kroah.com>
 <CAOQ4uxhVqttqKDyJjqe-F5JV7_LLcSUP+Xao+WYRDM4azt_4NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhVqttqKDyJjqe-F5JV7_LLcSUP+Xao+WYRDM4azt_4NQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 12:12:39PM +0200, Amir Goldstein wrote:
> > > > fanotify09 failed on arm64 devices running 4.14 version kernel
> > > > fanotify09.c:202: FAIL: first group got more than 2 events (72 > 48)
> > > > https://bugs.linaro.org/show_bug.cgi?id=4271
> > > >
> > >
> > > fanotify09 was added a new regression test case for commit
> > >   b469e7e47c8a: fanotify: fix handling of events on child sub-directory
> > >
> > > That commit was backported to v4.19. As I wrote in "backport hint", the bug
> > > exists in older kernels, but fix does not apply cleanly to older kernels.
> >
> > If someone were to provide a tested backport to 4.14 and older, I'll be
> > glad to queue it up (hint hint hint...)
> >
> 
> Attached backport applies and tested on 4.14 and 4.9

Nice, thanks for this!  Now queued up.

greg k-h
