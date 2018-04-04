Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-940803-1522872133-2-7170299376134173072
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522872132; b=mtBPMnF4bC8cBCU1TI98jwMJufkK+/LhxiEPZI/W2tsJkFPuJz
    n6E4ojfRDBHsLNgdHcwS8DWFPqFarNOOeXSubqX1/U/GGuksI/45ermEnqOEd5KO
    sHVqlRPD1/U7P6UwqGUJIjHpKMslHQzE2uDsYqcIZx2yoRVSN9WkaCBzHMqRod1u
    b8mwMxr7XriTzTmSx3OD4khXqx17tj6PFUuOXJNcq8i8B60hOSRLilQdU0nFRMyx
    1MwunaUeyqa+/R9qoSnW3ycgusqnWgN/ZQuQgUdR4XGLtc4qJKWBZMRP6VEvXR6t
    adGUMTCCn7Q/Zcy5sRSdREU+4N5ftFep67Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1522872132; bh=uvdqzT0hc3UM+NlqewKjkPrPKsovDlWR/w1wodI
    fmaE=; b=Rx3JhMvVgCGVqa05tiCOPfGjwOG+owFb0sofCsgyD0kLapjFQhfQK1+
    3HtgqEynvX7CsJwZah9kfztZbGiu47c8/J3/z852yU1HQ850D2zYtFRZaun6RX1W
    4jg2e1bQ6homqM2UrAXnq39MWTaQeEGnsqWWHZfcYzT0le3JFsunR3E85qFZaEZP
    zTvv8PD/TbZ5Lt4NXnyjMxco/lJNFsHQm8sRJ3nrPHxdT70C28PCYMFYSB2aEnf1
    8dbabvN5gDBTlY4ZYB0kjb7vQj9zojCEtl+XDXzOmi8CKFU5bAeg82RMreQauFvc
    o23+eOPlJ7GCDjTFFO2PzfFb5mS1tjQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC9kZwwsPaRT+/tvBGizt2UlstkS5rdKXs8ZbJHLlMXkMZmEDq5dhpoJj71UO+OIhpGY+83kf3yyerE6swrYcUlfDRangKcNh4W2atnZKvT+BgxnXjFi
    U2qqXT/JJ0Uxy79k+SLCFMPWLnwSHDObi6bFwFXBRCjbXpMloHCkzDAaebE/xrH2yx3QXx/0SNnGVQxXYRn6w0MDYajxwR5pAYHVdVZI++FosXwBabkpjZOV
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=4k33LHvR82cvuXCTUc8A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeDDUB7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 16:01:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35229 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbeDDUB6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 16:01:58 -0400
Date: Wed, 4 Apr 2018 22:01:47 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Jones <pjones@redhat.com>
cc: Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <20180404184255.exdrtpqnxlqme7tl@redhat.com>
Message-ID: <alpine.DEB.2.21.1804042148480.1492@nanos.tec.linutronix.de>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org> <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk> <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com> <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com> <CACdnJuutJeeaaB2kwma0MMd9uDDbKavoHEk4koDLe1M6gYZWXQ@mail.gmail.com> <CALCETrVR_EcbKv5-4AR6Zm02XHhJQQGNDeO8FGkMbYozmuDTJw@mail.gmail.com>
 <20180404184255.exdrtpqnxlqme7tl@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 4 Apr 2018, Peter Jones wrote:
> That is to say, as a result of the way malware has been written, our way
> of thinking about it is often that it's a way to build a boot loader for
> a malicious kernel, so that's how we wind up talking about it.  Are we
> concerned with malware stealing your data?  Yes, but Secure Boot is only
> indirectly about that.  It's primarily about denying the malware easy
> mechanisms to build a persistence mechanism.  The uid-0 != ring-0 aspect
> is useful independent of Secure Boot, but Secure Boot without it falls
> way short of accomplishing its goal.

I think we can all agree that

  The uid-0 != ring-0 aspect is useful independent of Secure Boot

There is probably resonable consensus about the second part of this
sentence as well:

   but Secure Boot without it falls way short of accomplishing its goal.

Now where the disagreement lies is the way how the uid/ring0 aspect is tied
to secure boot, which makes it impossible to be useful independent of
Secure Boot.

So the real question is, how can we make 'lockdown' usable and useful
without Secure Boot and at the same time not violate the constraints of
the Secure Boot scenario.

If we can agree on the above then I hope that we can focus on the technical
problems instead of arguing in circles.

Thanks,

	tglx
