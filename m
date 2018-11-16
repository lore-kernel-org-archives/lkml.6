Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE1DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4593C2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="vXGkOBHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4593C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390228AbeKQD53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:57:29 -0500
Received: from imap.thunk.org ([74.207.234.97]:40004 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbeKQD5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IUzcsxs8ZNekcFrI1bbroQXB92XGndmnsoBhXexEKmY=; b=vXGkOBHpgX+fSAxEfNfmAOlYam
        GLzrjQMeQEtE2aqZa2gZZco1SPwZb+TOgc4l5NNHx9P8qkt8EoI/MiqNyDkWX/xWoODRv/Znu4tfP
        ZfKJW0dKqyiKrH+hgw9N/1JzoLB6N1UX3U82KDwbPG58RQVtk6iy5uXF0Erk/88oI1fw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gNi9q-0004u5-2X; Fri, 16 Nov 2018 17:43:54 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BA41E7A47B5; Fri, 16 Nov 2018 12:43:52 -0500 (EST)
Date:   Fri, 16 Nov 2018 12:43:52 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
Message-ID: <20181116174352.GH20617@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
 <20181111131445.GB25441@infradead.org>
 <20181111134241.GA2447@thunk.org>
 <20181112082013.GA9307@infradead.org>
 <79d7d4b2-e9b3-00b4-2ad0-789888f7ee36@redhat.com>
 <20181116093225.GA17033@infradead.org>
 <fa3ed175-13a3-bedf-ebf9-ddf46a2decd5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3ed175-13a3-bedf-ebf9-ddf46a2decd5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 10:45:11AM +0100, Paolo Bonzini wrote:
> On 16/11/18 10:32, Christoph Hellwig wrote:
> > On Mon, Nov 12, 2018 at 11:17:29AM +0100, Paolo Bonzini wrote:
> >>> Well, that's what we have the security_file_ioctl() LSM hook for so that
> >>> your security model can arbitrate access to ioctls.
> >>
> >> Doesn't that have TOC-TOU races by design?
> > 
> > If you want to look at the command - yes.  If you just want to filter
> > read vs write vs ioctl, no.
> 
> Yeah, but looking at the command is what Ted wants.  The thing that we
> did in RHEL was a single sysfs bool that allows unfiltered access,
> because it was sort of enough and made the delta very small.  But for
> upstream I want to do it right, even if that means learning all that
> new-fangled BPF stuff. :)

I'd argue that a purpose-built eBPF access control facility is
superior to the security_file_ioctl() LSM hook because it can make
available to the authorization function access to the cached results
of the SCSI INQUIRY command, and it avoids needing to duplicate
knowledge of how to parse the parameters of the SG_IO ioctl in the LSM
module as well as in the SCSI stack.

Just because you *could* implement anything in terms of a turing
machine tape doesn't mean that it is good idea.  Similarly, just
because you *can* implement something as an LSM hook doesn't mean that
it's the best design.

> >> Also, what about SG_IO giving write access to files that are only opened
> >> read-only (and only have read permissions)?
> > 
> > Allowing SG_IO on read-only permissions sounds like a reall bad idea,
> > filtering or not.
> 
> I would even agree, however it's allowed right now and I would be
> surprised if no one was relying on it in good faith ("I'm just doing an
> INQUIRY, why do I need to open O_RDWR").  And indeed:
> 
> $ sudo chmod a+r /dev/sda
> $ strace -e openat sg_inq /dev/sda
> openat(AT_FDCWD, "/dev/sda", O_RDONLY|O_NONBLOCK) = 3
>                              ^^^^^^^^
> 
> So it would be a regression.

Ugh, that's... unfortunate.  I suppose we could try to figure out all
of the SCSI commands that would have to be white-listed to be allowed
using O_RDONLY from historical usage, but that would be a huge job,
and it's highly likely we would miss some anyway.  OTOH, this could be
called a security botch that should be fixed, and if we make a best
effort to white list all of the innocuous cases such as SCSI INQUIRY,
maybe that would be acceptible.

					- Ted
