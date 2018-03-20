Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1646101-1521559344-2-4131975041167991587
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521559343; b=fATszhA795q3BvJI33ZI0ocLMHz8kH7SuV39sUdXcXZimey
    C3Fx/LB6GK+tY5Tc6va7xwIQ3LNttq2BtPAz8bBZAfJl0M+rSoRYsXMn5OMeoP+H
    tbKlHbUfDiO0RNzeZS68X3XVBGds+dyJ9w9lVigCDFKsOA1j1vAJGBKi7fRQPiuN
    mrBdytthG+u5JaI+qtne+Um1Q8PH2eLFQe6zdXLV462CYjNZIfOCqTo/idFkxzsE
    cwH5Eh4t+nwA+BFJL5NLS0vfvwX7v3VVaujzsyaiYhGBcUUf8z7VRte0uKijngAy
    3yyduYUp9nLw9wIsyiEINbGqTxWVpFw+uDU/j+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521559343; bh=12whLLRVrxfrVTM0hQm7uutvd6
    nDRaE/HVBI+aZxK38=; b=M2mE/ZcmRm8KQwoL4M24ZVeFgXASgHjQbS7/4Nr9lA
    mRYD+7k7eXkI5//Ohj47KFH6Acvd3FWgz/sV25T8LLQm1PaEAWpyOipW7/Kb3NtQ
    Ryxx8a1NotfKD1dSh2VlC3dx3/PnOoFrXYrVcOxfuMdGKjkRFh/tTYeZKM5icYgs
    bGD7l0kWvvrN6xTGTk18GD3RlpYSch54i79YZQ91mUvLVlS1LCYkiicRbY4pze7A
    gyNGX0LIgKt1gvVsWdl/zAjuz7QvPmG/0Jja84IZtIozI5QWFYzqgoNzJIDAbSkB
    zr0QLgjrwMwz70pbhM3wxTzHjcDW6Qjpe0DvHRNffsqQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeCTPWW (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 11:22:22 -0400
Received: from verein.lst.de ([213.95.11.211]:37730 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeCTPWV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Mar 2018 11:22:21 -0400
Date: Tue, 20 Mar 2018 16:22:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/36] aio: implement io_pgetevents
Message-ID: <20180320152220.GC23920@lst.de>
References: <20180305212743.16664-1-hch@lst.de> <20180305212743.16664-9-hch@lst.de> <20180320021241.GE7282@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320021241.GE7282@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:12:41PM -0700, Darrick J. Wong wrote:
> > Note that unlike many other signal related calls we do not pass a sigmask
> > size, as that would get us to 7 arguments, which aren't easily supported
> > by the syscall infrastructure.  It seems a lot less painful to just add a
> > new syscall variant in the unlikely case we're going to increase the
> > sigset size.
> 
> I'm assuming there's a proposed manpage update for this somewhere? :)

In this commit:

http://git.infradead.org/users/hch/libaio.git/commitdiff/49f77d595210393ce7b125cb00233cf737402f56
