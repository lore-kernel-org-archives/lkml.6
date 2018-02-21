Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-84399-1519173866-3-1424211539848785315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519173865; b=t2CUX9YuoeSoaDWsrsuj0PEDREkAL6olUAsXCGTEyhKRWLM
    74LO4uoq+IBnrnxnMyt2vtAvne2r8QA+EUE9iZYyNQtlm1fh5D5aYptxAbeTNimv
    7NuEMuOkSutsY8oCG1GrA4+d7KQ7eIg3Il0JiPZrJsIs2Q/M0c/9JEHW7WM4WAYV
    6Z2MvPsGe5hwcJiOIc1h65fs8CY85llOFxHwZORpFpr1574RWV7g7+spMDaBSA+H
    FITwjukbfiDW5aP0B++6gUG6CpSyV+y9qGzwsl2b56t9mKjIjrY0iIl2I2AuKlJ0
    Adp70jC6/40ahbuxUrNN3mRcth5vOAE4MMYpgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519173865; bh=t233A1EIgh+/C/y18XwIsn1bsrCKNYQ0AF8zGa3mOXM=; b=P
    J/pMSGrEnkxV/PP2rZOAcgZaO5SBd4rhqxPVjOibnA9f4hJDIlNK8ybpnKI226Ze
    gis43zymatMBkLG1DHDhJ0K6/6MMCMZyyk6Yw1I7j4/f/iFPkbNq63BbdfCXny43
    R1R1emJjUauYTUZMICoC5Cl0UgLJ/RuzwCZN3nS2ClnIBw93JfVwACAq+zFeUR0a
    B5ddoZR7nTkIC3b7akBF8vlSQYy4D+rZXIfCe5KQtKgtENOeiSJLZxRqgzETYjia
    mMCqEdPu/8urjoM7WsFWFG3oRMQweNXhKIqJuqLSxwhW1TS91zs66j8MEvd4VI+t
    xByEeGualUEiBtuO8jYJw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeBUAoJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 19:44:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41540 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeBUAoJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Feb 2018 19:44:09 -0500
Date: Tue, 20 Feb 2018 16:44:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, criu@openvz.org, gdb@sourceware.org,
        devel@lists.open-mpi.org, rr-dev@mozilla.org,
        Arnd Bergmann <arnd@arndb.de>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrei Vagin <avagin@openvz.org>
Subject: Re: [PATCH v5 0/4] vm: add a syscall to map a process memory into a
 pipe
Message-Id: <20180220164406.3ec34509376f16841dc66e34@linux-foundation.org>
In-Reply-To: <1515479453-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1515479453-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue,  9 Jan 2018 08:30:49 +0200 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> This patches introduces new process_vmsplice system call that combines
> functionality of process_vm_read and vmsplice.

All seems fairly strightforward.  The big question is: do we know that
people will actually use this, and get sufficient value from it to
justify its addition?


