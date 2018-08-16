Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDCDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6702E21486
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCkO9UM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6702E21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404220AbeHPTYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:24:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39054 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389145AbeHPTYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:24:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so2247138pff.6;
        Thu, 16 Aug 2018 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i9pFJBq24KRYK273d5wToUZtyPASu+oWEZ/t8Kj+OMM=;
        b=YCkO9UM3uzgP23V7s5h8hky6Pv61hLg6cr0i13pvN7zCry6VHw6S5reGOGqSX37XoB
         1dTkMedAaGvTY/tiUUOWP9airR3xaUAIn+hBrT7UxPlp4yLb0rgDKRNlGuPZp5P09bWS
         VZT3H4IZSGOBZAdz1pYtvng1DInuB4zgSXrxgLf795uj6N8xfxib2K/Yc5xkQ1wd4Tmj
         0g3Fuu3ET3KYz3FFKCUNqan+mFf7AL++QhZ4vBLLNuQyjgI7UVg/qVuRNwIbZHtL5n0g
         Xub0PFx1a0mcyQxYKpnnMcYFOvcfuwYOGg+7n+kvv5ZV8zCRB4aKEUPeKzOfKZCW0cFb
         EEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9pFJBq24KRYK273d5wToUZtyPASu+oWEZ/t8Kj+OMM=;
        b=Wkv3zCs5q6ZgJDRx4S/QFW7MNGdWOlJ9Wm6obbl1Q/njzqvsNNNL56sqsX6DHgWeCt
         4bUeWde/TMV2vA9zf83VHn5RjfB/OY73x9CLYnzfbnmyTUy1TzazyRzdhy+BM3oZfMUv
         KO1BXz4fcTkjTTOWJG0pKNK0NFjyI1yM4sYOLpTcDBC3a1FgswJOi1mOMa95WY4fghLO
         YD+e7/VuIwlqVQ/e0ZtVa6CqbtmS7h0swjaPcBNHfqCZuidq7Zl/7AbgqzDxIhdFxjbT
         Lxzu2G7u6A4GQJDptACloLMZpl/L9aeS1FJhryXnwkkun/MIMjhUs3LyfF5KZm3nW4Pw
         bkww==
X-Gm-Message-State: AOUpUlFfKFJlhIQ1iCdNVdDXf8slLyCE5257ajniVGbJPAFewpoKvLBm
        YHTb3Tvi8A9ZLG3Smeyy2i3m6wT0APT8Ff/QEWU=
X-Google-Smtp-Source: AA+uWPxQyyotF5qMEfjRdnEPeiL8uBeh0YVHBVpRU9oLo7+GF1VhzJn0vGhkzMYTxufUrR5Bc1LftaTDnicDL1WbJi0=
X-Received: by 2002:a63:6b86:: with SMTP id g128-v6mr30112713pgc.344.1534436708074;
 Thu, 16 Aug 2018 09:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <17763.1534350685@warthog.procyon.org.uk> <87pnyiew8x.fsf@xmission.com>
In-Reply-To: <87pnyiew8x.fsf@xmission.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 16 Aug 2018 11:24:56 -0500
Message-ID: <CAH2r5muKOWBe9zMM8duNJ3rp1bzQh-mUj5zYoARO5pmc4de_+A@mail.gmail.com>
Subject: Re: Should we split the network filesystem setup into two phases?
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     David Howells <dhowells@redhat.com>,
        trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Steve Dickson <steved@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ebiederm@redhat.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-nfs@vger.kernel.org,
        CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 2:56 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> David Howells <dhowells@redhat.com> writes:
>
> > Having just re-ported NFS on top of the new mount API stuff, I find that I
> > don't really like the idea of superblocks being separated by communication
> > parameters - especially when it might seem reasonable to be able to adjust
> > those parameters.
> >
> > Does it make sense to abstract out the remote peer and allow (a) that to be
> > configured separately from any superblocks using it and (b) that to be used to
> > create superblocks?
<snip>
> At least for devpts we always create a new filesystem instance every
> time mount(2) is called.  NFS seems to have the option to create a new
> filesystem instance every time mount(2) is called as well, (even if the
> filesystem parameters are the same).  And depending on the case I can
> see the attraction for other filesystems as well.
>
> So I don't think we can completely abandon the option for filesystems
> to always create a new filesystem instance when mount(8) is called.

In cifs we attempt to match new mounts to existing tree connections
(instances of connections to a \\server\share) from other mount(s)
based first on whether security settings match (e.g. are both
Kerberos) and then on whether encryption is on/off and whether this is
a snapshot mount (smb3 previous versions feature).  If neither is
mounted with a snaphsot and the encryption settings match then
we will use the same tree id to talk with the server as the other
mounts use.  Interesting idea to allow mount to force a new
tree id.

What was the NFS mount option you were talking about?
Looking at the nfs man page the only one that looked similar
was "nosharecache"

> I most definitely support thinking this through and figuring out how it
> best make sense for the new filesystem API to create new filesystem
> instances or fail to create new filesystems instances.

Yes - it is an interesting question.

-- 
Thanks,

Steve
