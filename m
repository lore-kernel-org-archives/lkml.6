Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F13C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE02206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE02206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeIGDCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:02:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44932 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeIGDC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:02:29 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 649B1D00;
        Thu,  6 Sep 2018 22:24:52 +0000 (UTC)
Date:   Thu, 6 Sep 2018 15:24:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Waiman Long <longman@redhat.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        manfred@colorfullife.com
Subject: Re: [PATCH v8 0/5] ipc: IPCMNI limit check for *mni & increase that
 limit
Message-Id: <20180906152451.e8c6ff58a867646ff5209cfc@linux-foundation.org>
In-Reply-To: <20180817165008.GB32382@linux-r8p5>
References: <1529317698-16575-1-git-send-email-longman@redhat.com>
        <20180817165008.GB32382@linux-r8p5>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 09:50:08 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:

> >Enforcing the range limit check may cause some existing applications to break
> >if they unwittingly set a value higher than 32k. To allow system administrators
> >to work around this issue, a new ipcmni_compat sysctl parameter can now be set
> >to restore the old behavior. This compatibility mode can only be set if the
> >ipcmni_extend boot parameter is not specified. Patch 5 implements this new
> >sysctl parameter.
> >
> >Waiman Long (5):
> >  ipc: IPCMNI limit check for msgmni and shmmni
> >  ipc: IPCMNI limit check for semmni
> 
> I've reviewed the first two which look good and are actual immediate fixes
> to the bogus user input. I haven't gotten around yet the rest of the patches
> but are at least a bit more controversial than the first two. As such, could
> patch 1 and 2 be picked up once the merge window closes, for v4.20? Although
> -stable might want in, this situation is quite historic, so it's not that
> urgent.

Thanks.  Could we please have a refresh and resend?  Hopefully Luis
will have time for another pass.
