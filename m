Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CADC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503C32081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503C32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeK2VMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:12:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36084 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeK2VMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:12:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so1136936oix.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 02:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SL995F76wPDF32xTyZab36Pehc6H3R0u5YlV1mWqfX0=;
        b=Y8eVpcSwsZ1SXIWPsr3g9EjEbDyjHdJfcywiua6GYvz+mKXUeXGS5uq5yigaL5FWbc
         c5IWMyT7Iqxeu+9XI8k9oqJ9F8V77Xzj+c6aXwBu5iFfUrdkmMrBazsz0PlbXFeDRf+k
         mOeFZAmImCVZ0I+DBh6vht/o3ZtRQNN9nKvUHixOIVIx39/M5A3KnN++XgrVzeUalE5C
         JI9VZAYhbFSRMJYryZiUyl3vocupu1Hw3QTQh7RERlS9MXqhVRuNtkqhhNaVSLvyzXvp
         DHDZA+l8C/80/yYPX4waxImznKE9JTUCIH+JWPgy9GHp6mPqtgPXzWphYQeMID1b6Vow
         6WuQ==
X-Gm-Message-State: AA+aEWa4PBc9DqNC1g04lLbggUy5HVaxrhMRDjpgadqIuRPhu9OSopLd
        lBlUh1MMKriZWzYVBGEJlVEa18KyEUSVbaPRiKf9xw==
X-Google-Smtp-Source: AFSGD/WL4v+ETbVNiAvBHs/W97HXSPcd1wVVwzDsEnOl7Jij2WQ9hgfVA9V10te7O9wTZlXDHdzLpOX3ehJx0ditdW4=
X-Received: by 2002:aca:5c05:: with SMTP id q5mr463650oib.146.1543486052914;
 Thu, 29 Nov 2018 02:07:32 -0800 (PST)
MIME-Version: 1.0
References: <20181127115246.00967523@canb.auug.org.au> <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
 <20181127225013.133adc7d@canb.auug.org.au> <CAHC9VhSFSxBc+-O=GQMkiyiQz3S+_ZreicLhsoAuvR-oq2mi6g@mail.gmail.com>
In-Reply-To: <CAHC9VhSFSxBc+-O=GQMkiyiQz3S+_ZreicLhsoAuvR-oq2mi6g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 29 Nov 2018 11:07:21 +0100
Message-ID: <CAFqZXNuZCof=7CtyMq8JDyAgRmONYRZhhqr6bFVy9-F70-Uwrw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-next@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:52 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Nov 27, 2018 at 6:50 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi Ondrej,
> >
> > On Tue, 27 Nov 2018 09:53:32 +0100 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Hm... seems that there was some massive overhaul in the VFS code right
> > > at the wrong moment... There are new hooks for mounting now and the
> >
> > The mount changes have been in linux-next since before the last
> > release ...
> >
> > > code that our commit changes is now here:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/tree/security/selinux/hooks.c?h=for-next#n3131
> > >
> > > It seems that the logic is still the same, just now our patch (or the
> > > VFS one) needs to be updated to change the above line as such
> > > (untested pseudo-patch):
> > >
> > > - if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT)
> > > + if (fc->purpose == (FS_CONTEXT_FOR_KERNEL_MOUNT|FS_CONTEXT_FOR_SUBMOUNT))
> >
> > OK, so from tomorrow I will use that merge resolution.  Someone needs
> > to remember to tell Linus about this when the latter of the vfs and
> > selinux trees reach him.
>
> I will, or at least I'll do my best to remember; since we only have a
> few more week until the merge window I like my odds.  FWIW, I
> typically do a test merge on top of Linus' tree before sending the
> SELinux PR just to verify that everything is relatively clean and
> there are no surprises.
>
> Ondrej, please work with David Howells to ensure that submounts are
> handled correctly in his mount rework.

OK, I will verify that the SELinux submount fix rebased on top of
vfs/work.mount in the way I suggested above passes the same testing
(seliinux-testsuite + NFS crossmnt reproducer). I am now building two
kernels (vfs/work.mount with and without the fix) to test. Let me know
if there is anything more to do.

Thanks,

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
