Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3063729-1521207167-2-2787213859521462437
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521207167; b=HC6SMM83W/4u4GQ/S9pt0N8doJBXfWgZ73ObP0QuB7r1S9o
    sBEhi13RMRicojjNl6wj8DoaFMkZGJ3vb2pL/BUIJEx7sgiWxyZXWT3U2yUcHLto
    K4CsxC+VqgEeM/DVGdPNfh8zVWhtpsmtgNICZ6BG9f80u7rREUNVQux6j+Twh4qE
    U7l0HAfebsHnZXSW6X+vGiVBxWaSQoqD2JMewLQ5Pb26YxDOrOk+WwMY/PaKs4Aq
    9CQSV6s82QtnKdwlfkOCKc3rVuFiyXt7Xa34cUSrJjT71fQ0yJwPKi92y70Sy2q0
    nc3kXEuB41hwugbGSvkCELfysnWRMOuRavXHltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521207167; bh=bdpQcPo68RWM3efkYUNkVs216P
    uZ5Q1u0ZoJwc3WBV4=; b=nAtWJAS+GB8+5OEE1QsN2Uv35+I2Z47SLX6hhZGbRW
    ZLeRoqKOFXmv1JUIPDOw9+IOeOxKS39QU5t4VXKJezzlmGYuwA1COZLkGk0kbDRO
    ca4W0uTz6B7g0XI8cE9bXNb3bta07w+mV6x9oarD4UhHtjwpvE6yZgxiKMJSTiK9
    xedhm7ixiqOGPnjIyTMGhhvVBrpPcwcZ81mivcaHVATjvNeeB6ZFaUvGJcheqF5R
    A4K1rcp8n15R/2yw9FKZKXilXmKzOzVf0SGeany/6jFd31TSn1MTVPjSEbVo6jEL
    FkWU7w3/rD7sI/A8Cy7veT22D8BygPt4nWTpZ52LGE8A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeCPNcn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 09:32:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42384 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeCPNcn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 09:32:43 -0400
Date: Fri, 16 Mar 2018 14:32:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steve French <smfrench@gmail.com>
Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Thomas Backlund <tmb@mageia.org>,
        =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovskiy <pshilov@microsoft.com>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH 4.13 28/43] SMB3: Validate negotiate request must always
 be signed
Message-ID: <20180316133241.GC11397@kroah.com>
References: <28ffc363-5140-5685-d288-6e3dc07c6369@csail.mit.edu>
 <20180227085428.GA16879@kroah.com>
 <b20cbd94-ce9b-cb2c-dc95-a6821376823f@csail.mit.edu>
 <20180227124050.GB31888@kroah.com>
 <6bca5a97-f581-86b8-12ad-77147619d519@csail.mit.edu>
 <CAH2r5mt91WGHDk-+LP4EBTEfAOmrY2k6_X7KKjc0D+LcDCfxRw@mail.gmail.com>
 <309db6c4-7e21-bfbe-44d4-eb41f5516d5e@csail.mit.edu>
 <CAH2r5muUfsZsqaBqkAfi_dXRheib+7DN=VSsbGcV22C2MdJaGw@mail.gmail.com>
 <20180313092133.GA13325@kroah.com>
 <CAH2r5mvmiTaC4W=LAaOvWv6xGEMce957c+u+Af6wNgxudbO3_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mvmiTaC4W=LAaOvWv6xGEMce957c+u+Af6wNgxudbO3_w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 10:21:45AM -0500, Steve French wrote:
> There will be a fix needed to correct an oops in calc_signature,
> besides the easy patch (smb3 validate negotiate patch).

Ok, I still have no idea how to parse this for a stable tree submission.

So can someone please just send me a simple "apply these git ids to tree
X.X.y so we can fix the problem", otherwise I'm not going to do anything
here as I'm really confused,

greg k-h
