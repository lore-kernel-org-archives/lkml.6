Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1646101-1521559911-2-2550730974082948318
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
    t=1521559911; b=rOIVmd57ZCZqqiI9K3Z8KkNnaUYDhOODP6G6rOk3JGr/Qgi
    LNDbwCGMcCY9aZCTo06unLRgawfUv3o9YUS//2iDRHbwqr5qciwoWPbSi0Om0sMr
    0cM+KD7MU8WBK2N/9MyS+jkNyW4fUnCp8xgp++snNAT5uVf+nPZKzgo0IXTz+m4E
    x6ue6Sg/DM/XRAn7Ss57vlQyWXzNzBq0SvVLpLA7wKmcGO6S5c9M1Vu/LrZZng+J
    WthnGeXBzux/Enx/jL8np1NA9KzJpBbBEKk/chsEwKXN1Xa7Nka+TEwsDLD0SSix
    xd+3XtwJMmhE5cspI8bUBwGOsfcdX8upXcWZ84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521559911; bh=Igf92drq52ovHeX5fCrjG9fpLS
    LpG8BrBJN+3RlrWBs=; b=OtH5bZFRx2Tjr5F2YhL+dIevM/sTTx4wZGScM72+Yc
    MWS2yno3YWMy1Hf2Co5qGKpfSy4gS6iRq1rRFit0GNTMBjqXybU8Wn7RIoNT1FlT
    0VMxk+L2UaK9FVw+S0xOW3PmSnCtiQX9CzFPWEAwhvFsgj/uxxoAwpKva/0itVhD
    NUjtYlOgCMe/pqFGwU9iqcR0hrZGrmyKpe4CBSCNfaQVW8nDpILPmNmxhC0fM0UT
    VP7lAoQOTEKULD3ev3kSYt51l4Kg9VmFjtLVK8BhrrM22m7sj4iBq16baJX40DGv
    0eWhLyr3jDpg4DuWwI80QK1VycDSHHtwJKBW4buVqLeQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1751458AbeCTPbs (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 11:31:48 -0400
Received: from verein.lst.de ([213.95.11.211]:37770 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751334AbeCTPbr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Mar 2018 11:31:47 -0400
Date: Tue, 20 Mar 2018 16:31:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/36] aio: implement io_pgetevents
Message-ID: <20180320153145.GA24313@lst.de>
References: <20180305212743.16664-1-hch@lst.de> <20180305212743.16664-9-hch@lst.de> <20180320021241.GE7282@magnolia> <20180320152220.GC23920@lst.de> <x49muz2pxwq.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49muz2pxwq.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 11:30:29AM -0400, Jeff Moyer wrote:
> > In this commit:
> >
> > http://git.infradead.org/users/hch/libaio.git/commitdiff/49f77d595210393ce7b125cb00233cf737402f56
> 
> BTW, the man pages are shipped in the man-pages package, now.
> Christoph, I can forward the change to Michael after this series goes
> in.  Just let me know what's easiest for you.

I'd be more than happy to send patch to Michael if we get these
patches merged finally :)
