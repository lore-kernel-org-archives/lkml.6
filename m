Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65997C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266F620831
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rS37x5nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266F620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeKAXNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:13:22 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50716 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728192AbeKAXNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:13:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 900AA8EE179;
        Thu,  1 Nov 2018 07:10:14 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q8slHTOrFVx4; Thu,  1 Nov 2018 07:10:14 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E1D8B8EE0BA;
        Thu,  1 Nov 2018 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1541081414;
        bh=eBWW4hk4Zuj7T2PXmMtao8skRRHjYw5FMkF5Zp100pA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rS37x5nrxDc8CrbFHv7FiLXhU6BQpqa4MWrtkldNljBc7HPIrYtOVfv8HXvo6Plfh
         /LpAbnAuDnaNxM/c4OWlubW/f83jNEFgqIGKB4Ouw0y0XooDJXF/xVD5q0M7yrrhvS
         /zGP3CKrgXQaJi/UKMY+N0Gs+uj8mb31qL3PBhvQ=
Message-ID: <1541081413.2853.6.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 0/1] ns: introduce binfmt_misc namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jann Horn <jannh@google.com>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, dima@arista.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Thu, 01 Nov 2018 07:10:13 -0700
In-Reply-To: <CAG48ez3HnkRM6bUZMNjuTy5DgujgamEKhZOEWDfCjqW7fTJSzQ@mail.gmail.com>
References: <20181010161430.11633-1-laurent@vivier.eu>
         <7ed6f823-547b-922d-59ff-aba9c4c3ab39@vivier.eu>
         <1541041159.4632.6.camel@HansenPartnership.com>
         <CAG48ez3HnkRM6bUZMNjuTy5DgujgamEKhZOEWDfCjqW7fTJSzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-01 at 04:51 +0100, Jann Horn wrote:
> On Thu, Nov 1, 2018 at 3:59 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Tue, 2018-10-16 at 11:52 +0200, Laurent Vivier wrote:
> > > Hi,
> > > 
> > > Any comment on this last version?
> > > 
> > > Any chance to be merged?
> > 
> > I've got a use case for this:  I went to one of the Graphene talks
> > in Edinburgh and it struck me that we seem to keep reinventing the
> > type of sandboxing that qemu-user already does.  However if you
> > want to do an x86 on x86 sandbox, you can't currently use the
> > binfmt_misc mechanism because that has you running *every* binary
> > on the system emulated. Doing it per user namespace fixes this
> > problem and allows us to at least cut down on all the pointless
> > duplication.
> 
> Waaaaaait. What? qemu-user does not do "sandboxing". qemu-user makes
> your code slower and *LESS* secure. As far as I know, qemu-user is
> only intended for purposes like development and testing.

Sandboxing is about protecting the cloud service provider (and other
tenants) from horizontal attack by reducing calls to the shared kernel.
 I think it's pretty indisputable that full emulation is an effective
sandbox in that regard.

We can argue for about bugginess vs completeness, but technologically
qemu-user already has most of the system calls, which seems to be a
significant problem with other sandboxes.  I also can't dispute it's
slower, but that's a tradeoff for people to make.

James

