Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3372BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7F620B80
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndh7A6Bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7F620B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbeHPGrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 02:47:25 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:42197 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeHPGrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 02:47:25 -0400
Received: by mail-pl0-f52.google.com with SMTP id g6-v6so1395292plq.9;
        Wed, 15 Aug 2018 20:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeQZOMeMpOKGfaXsOwragLqCQdx5PxTXiqFC1w5ec2o=;
        b=ndh7A6BmYHPOD23jqIvMqCSRv6PBzF0SlAbP2rAo8dGCZc8ddjx+54DZ9LyOCaQkGw
         +ztjFmoDhxJSwoBAbNj3oMt8BZpkizXaGz0Za0mdyEevuP86SEqEWlHsRfg5UDY3NoRD
         gk1xvkzubSSyJTNIJoF7Kiy593FfpcF8tHB6RMr7XHnyDmqmG9hkh/F2X+UAvwPj4005
         bF5s43W+QBBulo18niqbdEYyoLeA+GleHjyPqeifAPzaj+40mXca8EBdHb6aEQRF2/9S
         +Qi3G4hnFtDTr1AV+KigPkGVUfqdq4yonYGPm7CYxUUABGwWDN+j/kAvwnBGZc17MCr7
         R2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeQZOMeMpOKGfaXsOwragLqCQdx5PxTXiqFC1w5ec2o=;
        b=XKMpaIMrNbgabqF30/SwYSYc6k9CdbpKORY6tpeMnrXGnBgHGTV4i8VSWtFBjrV3Cv
         4XcMSVoizqGwo6DxazuPOz55UfUOJcsr4ydX1gKwwPzO+HkcPfdvtEuek1R7DkPPMWvr
         X9PrCjnrOI8BeBmlFtRqnqKM8zuv5o6ooFb0/EipUezlBVi8EHVfhWyO0WwZv6T1WIAy
         g9A/zTyfwSZ+9xJRHJ7d74ULxvrRlzX9aoDb9TjBIg9wFjg9L8ISv9BHhDKqEoEsPGZy
         aT3BejU9Xwb8VDPADV6Rgol9wTfsusE2oXE1MDrAVvIZmBICUn8KCDd/OUPeRI9VJNzE
         3ZpQ==
X-Gm-Message-State: AOUpUlHosXDOpqPWBUml3QJybl5euBZVWEVdq5+6bgif74NjCz1MvfuZ
        ZzU+lTiHHJmupc4FtclQyxXOT17KSv8N947keLN08adQ
X-Google-Smtp-Source: AA+uWPzHSMlfmGfEIIaav5kZizfC/Oz7y/2FYq21971AQFrAroTdbYlXmi0a6YaI1knLhYjO/m+hO+QD7/142/heAi4=
X-Received: by 2002:a17:902:20e9:: with SMTP id v38-v6mr27308351plg.107.1534391516749;
 Wed, 15 Aug 2018 20:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <17763.1534350685@warthog.procyon.org.uk>
In-Reply-To: <17763.1534350685@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 15 Aug 2018 22:51:45 -0500
Message-ID: <CAH2r5msjAYbXdnmC4Hb5TO155BC2vcMLq7XJ1H37TBiQTcsO7w@mail.gmail.com>
Subject: Re: Should we split the network filesystem setup into two phases?
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <sfrench@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ebiederm@redhat.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is worth further detailed discussion re:SMB3 as there are some fascinating
protocol features that might help here, but my first thought is just the obvious
one - this could help 'DFS' (the global name space feature almost all modern
CIFS/SMB3 implement) work a little better in the client.  A share can
be represented by an array of \\server\share\path targets although typically
only one except in the DFS case  (and server can be an ipv4 or
ipv6 address or host name (which could have multiple addresses).
It could be over RDMA, TCP, and even other protocols (as the transport).

There are various examples of DFS referrals in
https://msdn.microsoft.com/en-us/library/cc227066.aspx section 4.

But since SMB3 also supports transparent failover, and "share move"
and "server move" features, as well as multichannel - I would like
to better understand the patch set to see if it helps/hurts.

But until I dive into the patch set more and try it, hard for me to speculate.
Has anyone looked at the CIFS/SMB3 changes needed?

On Wed, Aug 15, 2018 at 11:32 AM David Howells <dhowells@redhat.com> wrote:
>
> Having just re-ported NFS on top of the new mount API stuff, I find that I
> don't really like the idea of superblocks being separated by communication
> parameters - especially when it might seem reasonable to be able to adjust
> those parameters.
>
> Does it make sense to abstract out the remote peer and allow (a) that to be
> configured separately from any superblocks using it and (b) that to be used to
> create superblocks?
>
> Note that what a 'remote peer' is would be different for different
> filesystems:
>
>  (*) For NFS, it would probably be a named server, with address(es) attached
>      to the name.  In lieu of actually having a name, the initial IP address
>      could be used.
>
>  (*) For CIFS, it would probably be a named server.  I'm not sure if CIFS
>      allows an abstraction for a share that can move about inside a domain.

CIFS/SMB3 has fairly mature support (in the protocol) for various types
of share redirection (not just 'DFS' that is supported by most every
NAS server, and Macs, Windows, Linux clients etc).  There are also
very interesting features introduced with SMB 3.1.1 allowing 'tree
connect contexts"
which some important servers in the last few years implement.

This is worth more discussion - SMB3 (in particular the SMB3.1.1 dialect) has
a lot of interesting features here.



-- 
Thanks,

Steve
