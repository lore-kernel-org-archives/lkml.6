Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FBFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6FF20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6FF20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404410AbeKWEMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:12:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732076AbeKWEMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:12:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2E7430D34E5;
        Thu, 22 Nov 2018 17:32:31 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-33.brq.redhat.com [10.40.200.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C08307E3BF;
        Thu, 22 Nov 2018 17:32:28 +0000 (UTC)
Date:   Thu, 22 Nov 2018 18:32:45 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] execve.2: document an effect of BINPRM_BUF_SIZE increase
 to 256
Message-ID: <20181122173245.GF20018@asgard.redhat.com>
References: <20181116174911.6fcff580@alans-desktop>
 <20181121160753.GA32685@asgard.redhat.com>
 <CAKgNAkhFikJXeOx3W3yL3EUKa9ruXtAw93m4M=N+3Kg-bXbPDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkhFikJXeOx3W3yL3EUKa9ruXtAw93m4M=N+3Kg-bXbPDQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 22 Nov 2018 17:32:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 04:59:24PM +0100, Michael Kerrisk (man-pages) wrote:
> Hi Eugene,
> 
> On Wed, 21 Nov 2018 at 17:07, Eugene Syromiatnikov <esyr@redhat.com> wrote:
> >
> > Increase of BINPRM_BUF_SIZE to 256 increases the limit on the possible
> > interpreter line length for scripts to 255.
> 
> I don't see this in the kernel source tree? Could you point me at the
> right source file / git commit?

Sorry, it's a corresponding man page update for a proposed kernel
change[1][2], and I failed to Cc: all the related parties properly.

[1] https://lkml.org/lkml/2018/11/12/2330
[2] https://lkml.org/lkml/2018/11/12/2328

> Thanks,
> 
> Michael
> 
> > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> > ---
> >  man2/execve.2 | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/man2/execve.2 b/man2/execve.2
> > index d2bb861..f4e37d6 100644
> > --- a/man2/execve.2
> > +++ b/man2/execve.2
> > @@ -633,8 +633,9 @@ prototype:
> >  .in
> >  .\"
> >  .SS Interpreter scripts
> > -A maximum line length of 127 characters is allowed for the first line in
> > -an interpreter script.
> > +Before Linux 4.20, a maximum line length of 127 characters was allowed
> > +for the first line in an interpreter script.
> > +In Linux 4.20 onwards, this limit was increased up to 255 characters.
> >  .PP
> >  The semantics of the
> >  .I optional-arg
> > --
> > 2.1.4
> >
> 
> 
> -- 
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
