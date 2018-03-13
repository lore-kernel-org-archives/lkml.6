Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2741264-1520932895-2-6321234139291185111
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
    t=1520932895; b=pEevTgftlezAKDQEggQmJX54hi8Lq/QWXe201l+VkMYROS5
    ngXTfmQds49b2LZHawa1KXTfhBpy1GKy+QTATQHnsGAfVDr1q1CfffORF67AVL+e
    K131SLBzb5ZUJ/wWnXdEj+gNnJU4IBDJ0bdCp1vxcDb9OPqiKT6dn9/2xOzsbFAc
    jme48L3eVgMQHJJKd+oQmb2yLL7P8WdKXhmUbLgbYI2jGjW29GphDPg3wu59RUI3
    NtPrmWtALLFtMNDt0Nlx0hEPejb5TdnlfpKRaTI8i6fEcpk9gamwripVWWTl63nd
    kM5Eh+m+OHN3IjjbpIIzDhtUFC1buTSmW2qc5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520932895; bh=6lR/eobS7Hu13CS6yWCOggGb6s
    y/RKyYa/Im1Sczbt0=; b=eVPkwVoCspsrdZWkyPN9iNXSjDushc0uq3eCEd7v/N
    q1MRR7/Lu2fwcqlt8hQaDVEPQXIfQkWvicguAhGK6CnEH0gfFAJC1u0Ri2axl+Go
    MfRkEvONEbcdv7uwM/aZs/zNFbY5sORXZ4dbPALjBpUe5vEQ5AICX4c3kRXNnWHx
    v9JpyWM8QEIGxOPEfkrm6oXXg8S6R4UGMq95Kmxw1udMBNINZwuwlNxpeTpgxQkn
    8bDKu6ZQuCwgIrb/gTq51GTqocGQYTGGAkhSaBg5MaakYBU94qoVEk0f8BSUA86n
    TgWzFbz2tNaHIt2R4hE41dPQwvZNs/OZgFb3QmvVsBCg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S1751975AbeCMJVd (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 05:21:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37588 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbeCMJVc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 05:21:32 -0400
Date: Tue, 13 Mar 2018 10:21:33 +0100
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
Message-ID: <20180313092133.GA13325@kroah.com>
References: <20171101151803.GB31285@kroah.com>
 <4ba67095-4075-688f-d3fb-157847aee4d9@csail.mit.edu>
 <28ffc363-5140-5685-d288-6e3dc07c6369@csail.mit.edu>
 <20180227085428.GA16879@kroah.com>
 <b20cbd94-ce9b-cb2c-dc95-a6821376823f@csail.mit.edu>
 <20180227124050.GB31888@kroah.com>
 <6bca5a97-f581-86b8-12ad-77147619d519@csail.mit.edu>
 <CAH2r5mt91WGHDk-+LP4EBTEfAOmrY2k6_X7KKjc0D+LcDCfxRw@mail.gmail.com>
 <309db6c4-7e21-bfbe-44d4-eb41f5516d5e@csail.mit.edu>
 <CAH2r5muUfsZsqaBqkAfi_dXRheib+7DN=VSsbGcV22C2MdJaGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5muUfsZsqaBqkAfi_dXRheib+7DN=VSsbGcV22C2MdJaGw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 11, 2018 at 07:37:55PM -0700, Steve French wrote:
> Just got a wireshark trace - this is a fairly trivial issue (missing
> the validate negotiate must be signed patch) - I had some trouble
> getting this version of the kernel running (unrelated issue) and on
> systems with access to Windows 2016...

Ok, I have no idea what this means, or what I should do here because of
it :(

Any hints for what to do with the stable tree?

totally confused,

greg k-h
