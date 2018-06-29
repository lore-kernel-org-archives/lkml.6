Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D3EC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8843427EF0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8843427EF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755454AbeF2Mbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:31:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752301AbeF2Mbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:31:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 668657DAC6;
        Fri, 29 Jun 2018 12:31:33 +0000 (UTC)
Received: from x2.localnet (ovpn-122-27.rdu2.redhat.com [10.10.122.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5AE02142F20;
        Fri, 29 Jun 2018 12:31:32 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     rgb@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        aviro@redhat.com
Subject: Re: [RFC PATCH ghak59 V1 6/6] audit: extend config_change mark/watch/tree rule changes
Date:   Fri, 29 Jun 2018 08:31:31 -0400
Message-ID: <4353667.qdjHzgu0KO@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhScxWn9jP7wMdkVoQM-5i2RnMM2HJe-baHGu3D4NpJvpQ@mail.gmail.com>
References: <cover.1529003588.git.rgb@redhat.com> <e3584154c8594cf64e9293ec6f473cdaaabe2954.1529003588.git.rgb@redhat.com> <CAHC9VhScxWn9jP7wMdkVoQM-5i2RnMM2HJe-baHGu3D4NpJvpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 29 Jun 2018 12:31:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 29 Jun 2018 12:31:33 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sgrubb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 28, 2018 6:28:55 PM EDT Paul Moore wrote:
> On Thu, Jun 14, 2018 at 4:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Give a clue as to the source of mark, watch and tree rule changes.
> > 
> > See: https://github.com/linux-audit/audit-kernel/issues/50
> > See: https://github.com/linux-audit/audit-kernel/issues/59
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > kernel/audit.h          |  4 ++--
> > kernel/audit_fsnotify.c |  2 +-
> > kernel/audit_tree.c     | 24 ++++++++++++------------
> > kernel/audit_watch.c    |  6 ++++--
> > kernel/auditsc.c        |  4 ++--
> > 5 files changed, 21 insertions(+), 19 deletions(-)
> 
> I think having some additional context here would be helpful for
> everyone, so I agree with this on principle.  However, I think we need
> to get clarification from Steve that his parser is able to handle
> these richer "op" values.

Op fields are not searchable. So, they normally don't matter. But in general, 
once they are defined, they should not change. For the record, you can 
generally insert non-searchable fields anywhere and it doesn't matter. Only 
the searchable fields like loginuid, uid, pid, exe, etc matter to the parser.

-Steve


