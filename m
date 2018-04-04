Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1296969-1522884342-5-16894776440226832038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522884341; b=bEldYRxnPDvGAP6cKnKDKZUrvdEeGNXAZOcNjENIiEWIEin4Eg
    bJNAkxruAGidCoqTjJsEngjZkeoGPPHXyIQ1XEM0IFqcaZXDyILYIKXAqS3ThPV9
    Cl/Dn4NjULDi10gKP0VaTxLWGD3PrUT9HdwuAXH57Gunyp3e2dG1Ju3d0/MryrNi
    7aB56NtENIhSkjE5T8yduMNYDux11WouiNliGwwcfwT60+76Wrc18GCgWe9DOg2p
    fQAI+9RaHjuKiAfKYVQDfEDD+TWbqlU7jPOUsuOYgLP87an8p4xzO0fNNiRoW+Cq
    m5gfm60qEWqoOIVfoPlV43kibeO+nO3ekbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1522884341; bh=tIjzMse0OinVSxG53WdU9V1Utd4BhFnjgT01ZPl
    T0sE=; b=KRt9afdDRqwD2tZIJBbHMoeKHz+QHPgnszeFRIOracIE8h9D6SlATFv
    neZPQQV1DsekEObpSjihJdl7urEb7e+XYym9xykqmorKKqHRJ2IqIDEaGbtYeRkd
    THd9KLB/OudGvmcIQ02yzCCuzAZLhVYozP4XGaKMb0Pb2jDZ4fLNMjT6uKbJC4c5
    bFL75AF/bl2Cb/+K2wlrkD8LdHyQPNyZ1xHCjKBhvlw9Nt+G01mCV5pi9E4yIEH2
    XXxMFj3QGHTXopoIgvqhXCCybwtsSRJCVDUoRvYcyi1jvj2lI9Gs79xdhBdtwsi7
    Ey9YiFMic8ez/i+EAnTSVanFQVw0jUw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAGXIQtYG1HN7RY32i83ZQ4URmmLz4BM82qnUX7fv+Iaz6w2pX+DRyg3W/2kBMGFDnXCaDzw9hD9sClJFFFtNiKj7e+tRD71drNUpNKmIyA0AL5r8nd1
    xyoKCaNCT4JTDhjtDtBFnm2zHRV28eJnOH4v6i8cMR6gOdH5loSm/FXGUi0l8i5zq+jSM8JWeRLXccUUNQcanDmR/6Shm51RocYBtBTRvmvTx2D/ZBCuRa+r
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=K6HrmWtEAAAA:8 a=VwQbUJbxAAAA:8 a=CUCAClUMHHWWFQAMh7oA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=yV38gEssg_2GhkhKF82i:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbeDDXZj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 19:25:39 -0400
Received: from namei.org ([65.99.196.166]:55474 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752374AbeDDXZi (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Apr 2018 19:25:38 -0400
Date: Thu, 5 Apr 2018 09:25:19 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure
 boot)
In-Reply-To: <1119.1522858644@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1804050918330.21060@namei.org>
References: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com> <1119.1522858644@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 4 Apr 2018, David Howells wrote:

> > 6. There's a way to *decrease* the lockdown level below the configured
> > value.  (This ability itself may be gated by a config option.)
> > Choices include a UEFI protected variable,
> 
> By turning secure boot off, maybe?

It's surely reasonable to allow an already secure-booted system to be 
debugged without needing to be rebooted.



- James
-- 
James Morris
<jmorris@namei.org>

