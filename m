Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938B3C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5F225C02
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5F225C02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934922AbeF0QcN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:32:13 -0400
Received: from h2.hallyn.com ([78.46.35.8]:35930 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934479AbeF0QcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:32:11 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id C5CD0120D13; Wed, 27 Jun 2018 11:32:09 -0500 (CDT)
Date:   Wed, 27 Jun 2018 11:32:09 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <christian.brauner@canonical.com>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        security@kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] userns: move user access out of the mutex
Message-ID: <20180627163209.GA23160@mail.hallyn.com>
References: <20180625163419.216578-1-jannh@google.com>
 <20180626130757.GA10042@gmail.com>
 <CAG48ez2WwQVWtfh7sQCqn1E52V7V4_LxZaU+kV_r-YGOzNAsXg@mail.gmail.com>
 <20180627142315.GC31443@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627142315.GC31443@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christian Brauner (christian.brauner@canonical.com):
> On Tue, Jun 26, 2018 at 04:06:45PM +0200, Jann Horn wrote:
> > On Tue, Jun 26, 2018 at 3:08 PM Christian Brauner
> > <christian.brauner@canonical.com> wrote:
> > >
> > > On Mon, Jun 25, 2018 at 06:34:19PM +0200, Jann Horn wrote:
> > > > The old code would hold the userns_state_mutex indefinitely if
> > > > memdup_user_nul stalled due to e.g. a userfault region. Prevent that by
> > > > moving the memdup_user_nul in front of the mutex_lock().
> > > >
> > > > Note: This changes the error precedence of invalid buf/count/*ppos vs
> > > > map already written / capabilities missing.
> > > >
> > > > Fixes: 22d917d80e84 ("userns: Rework the user_namespace adding uid/gid...")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> 
> Acked-by: Christian Brauner <christian@brauner.io>

Acked-by: Serge Hallyn <serge@hallyn.com>

thanks.

-serge
