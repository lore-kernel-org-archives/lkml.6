Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DEEC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9101220857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9101220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389464AbeG0Vee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730932AbeG0Ved (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:34:33 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C753820842;
        Fri, 27 Jul 2018 20:11:04 +0000 (UTC)
Date:   Fri, 27 Jul 2018 16:11:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jann Horn <jannh@google.com>, salyzyn@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Golden_Miller83@protonmail.ch, Greg KH <greg@kroah.com>,
        Kees Cook <keescook@google.com>, salyzyn@android.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
Message-ID: <20180727161103.797f12b7@gandalf.local.home>
In-Reply-To: <20180727195416.GF13922@thunk.org>
References: <CAKwvOdk9s+=kUwcPGQzZNxR7eOGAiiasAyWhZxgKom4_6h+oxA@mail.gmail.com>
        <20180726181558.25a5c3b8@gandalf.local.home>
        <753E9YR1QhdsPhsFoYuXCwfUzfyntDrc_A93hMUkktMi7lbh3KUZMcbfqKVWUfi15zYhuiDFant-ROa4QNV5shx74ff4hGngq2BOJDv-hq4=@protonmail.ch>
        <CAG48ez1U=5nTOrnOqwMuXhdER-7XxJUYLcyYNuczwasQLQ0gXA@mail.gmail.com>
        <20180727094730.3a448629@gandalf.local.home>
        <CAKwvOdmg4DSSwy9YBccYWzc+6ZU2yKSSFmfnj72wqbYDJU0gzw@mail.gmail.com>
        <20180727143141.4b53d554@gandalf.local.home>
        <CAMx4XWv3OazvURuN1XU2+5C5tNDzPuTniMn_T=XTA4P8_uwS_A@mail.gmail.com>
        <CAG48ez25zgjTQRux_rk1fn2DUVthtK31dRU9cxE+55pBGmYjXQ@mail.gmail.com>
        <CAG48ez1MdupASE1DMt0OWXv+rqZO-2GAbfDthEQcvNXrc2pTsQ@mail.gmail.com>
        <20180727195416.GF13922@thunk.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018 15:54:16 -0400
"Theodore Y. Ts'o" <tytso@mit.edu> wrote:

> More generally, stupid question, but does Android *really* need to
> have debugfs mounted?  And if so, can we figure out what facilities
> that are needed and can we find some other way of meeting those
> requirements?

I do know that they have applications that use ftrace. But then again,
the ftrace files are under its own tracefs file system (that just
happens to be mounted when debugfs is). That said, I would assume that
other Android utilities are using other debugfs files for system
status and such.

-- Steve
