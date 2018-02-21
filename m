Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-288525-1519181373-2-7097483220107335602
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='ws',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519181372; b=tCGpEpYLbOr9pg8K91zmcvw1FwLGRTw6O+9m2k92DoCAsAM
    2pcvJubj2MvmVYKdmukLVyMsndytp8Vl7xFljGy0/4trgb4PfTK7V7zTeCYRwrII
    4zqQWg6DOpwrLd9NP22d0oGMDD9Tr9Slbxyt7Acw38zYGGy0boOsEpvLg0pmVXaW
    1R9iP3KTHy/KUWDcAMma3Od+OnSohmcgo7JC20VNWI7NynljFSP7PpKu8dpIBZH+
    8ykYJbXsXFXNGanKhmLKGy0g3ll+OO/CC0Oq9uRO8G+G6ZcGTlH6solBgnnS1SmI
    naXaFTbi/FVIRoV3K3GQyjvkrLm2/HJ1TUeRBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519181372; bh=Wg6cow7wh+wrOU/i2pQ/VvW7mg
    RLblVkkPVRWgzP55A=; b=gGhfesz2uScIjGplppC54hDR0sRUIclMvxzEo4EU0J
    Hy+/2HISPJyb3Gs5/Z1zV8RdRz560MP7o9XgLz/fuy+qfqgNkTuTPHbDbKFpqVqy
    KW7FIzXTx/6rGVKJadUKlIgwe+wpPOO0wIufyrJrM4K/zJ0z4Aby0XMKcfj3qVfG
    svNp0KuzGioK2g+encJFbyEgzByKNXrlyjFcXwwUoXm7IpsmSsZKLYiwWscnX+gC
    zqykAuKtZnZQMCceTDFqIuQrkHA/pZlWDyUHVddOXFrHFMQEbugdQ986IR3WB8kn
    eJISy7ZoZQvursZqD+j2lyO6N4Izg0y1WEI06p+X/jhA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b=kHriFsOO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.ws;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qbOOLPfW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tycho.ws header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b=kHriFsOO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.ws;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qbOOLPfW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tycho.ws header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeBUCtb (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 21:49:31 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44724 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbeBUCta (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Feb 2018 21:49:30 -0500
X-Google-Smtp-Source: AH8x226vXy+bXZLSapCeWwFFtmQM79eBczZsbigZP8rwJfG8SEnaCciWjiyJkx6P3dxbgXmLGJPSQg==
Date: Tue, 20 Feb 2018 19:49:25 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] ptrace, seccomp: add support for retrieving
 seccomp metadata
Message-ID: <20180221024925.2btdhf5oamn4tflz@cisco>
References: <20171115020019.13517-1-tycho@tycho.ws>
 <20171115020019.13517-2-tycho@tycho.ws>
 <20180220193051.GA22210@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220193051.GA22210@altlinux.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 10:30:52PM +0300, Dmitry V. Levin wrote:
> > +struct seccomp_metadata {
> > +	unsigned long filter_off;	/* Input: which filter */
> > +	unsigned int flags;		/* Output: filter's flags */
> > +};
> 
> This "unsigned long" field is unacceptable unless you are willing
> to implement a compat layer for this arch-dependent type.
> 
> Please use an arch-independent type instead.
> See e.g. struct ptrace_peeksiginfo_args or struct struct seccomp_data.

Whoops, sorry about that. I believe I've addressed it in
https://lkml.org/lkml/2018/2/20/755

Cheers,

Tycho
