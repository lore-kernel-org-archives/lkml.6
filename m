Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3998809-1521236143-2-9996817410875013944
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521236142; b=kVLq0Gds5oDP31Z5vFZos8d0Ou9BROnUDeWuG63fjvVyKIy
    Ju7lht4y+OIH9cZeStgSNs4A3CRxKUNCebCqAA+IIJzIxI47DKx0QGml8UPkyOwk
    ws1QfyExPa/Uw5WwUYApuOWlVT8aiUBGsDfkzT0HEjofAe2ktiDASwHwXQ/iQzwG
    tpnsO9OKXdhTRMxnK4bNyQxXzF8lwXTnUKW+raziBqaT2hXwQH0ZZYlw4x/MbJad
    Mdkj/fK7/EF28dnT1NhLmcnZhCu8J2hpW2+J+5Zg8hmP1GQc1bnm9+tOOpfH3YzB
    dMaTW3YTPaXK8GoNyxMG29RvhWOm8xMJCddmjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521236142; bh=CXQbQZvHriJoLVoqT5AU4egnZWPRwGvWYb3YvreYrv8=; b=k
    7gDq5ua9b3Fs4q7aiYazYH2IHvb9mAVynoMjzv871SBVH1pIwzmMx9cIgclyGbRT
    6iW9LcTSNK/X+1IoPUO62RGn98DQh6QQQrKJgnkDPXKiVCye66mwUJJqwqcFnGS8
    bmNFBUgknhO0jxPymODKqQo29b/9efiTOYinPzBXk544S/iGRNGbcYNJYaxIiDn9
    BmGEWoz74z2aOqslYOk/iSN2oh49NIcZ4RgwK0TXA+EyoJPMr8xcGW9bpYxHFD+/
    VmfvnFr7UQKercvxwtDwJawOYzhNlS2FptgQRwY8Z3D9klwVRrSiqYTjSp+6gJXf
    Bh7R8UW60TvrY3J+T//LA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeCPVfj convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 16 Mar 2018 17:35:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46932 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeCPVfj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 17:35:39 -0400
Date: Fri, 16 Mar 2018 14:35:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jerome Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>
Subject: Re: [PATCH 02/14] mm/hmm: fix header file if/else/endif maze
Message-Id: <20180316143537.0d49a76ec48ec0ab034af93b@linux-foundation.org>
In-Reply-To: <20180316211801.GB4861@redhat.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
        <20180316191414.3223-3-jglisse@redhat.com>
        <20180316140959.b603888e2a9ba2e42e56ba1f@linux-foundation.org>
        <20180316211801.GB4861@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Mar 2018 17:18:02 -0400 Jerome Glisse <jglisse@redhat.com> wrote:

> On Fri, Mar 16, 2018 at 02:09:59PM -0700, Andrew Morton wrote:
> > On Fri, 16 Mar 2018 15:14:07 -0400 jglisse@redhat.com wrote:
> > 
> > > From: Jérôme Glisse <jglisse@redhat.com>
> > > 
> > > The #if/#else/#endif for IS_ENABLED(CONFIG_HMM) were wrong.
> > 
> > "were wrong" is not a sufficient explanation of the problem, especially
> > if we're requesting a -stable backport.  Please fully describe the
> > effects of a bug when fixing it?
> 
> Build issue (compilation failure) if you have multiple includes of
> hmm.h through different headers is the most obvious issue. So it
> will be very obvious with any big driver that include the file in
> different headers.

That doesn't seem to warrant a -stable backport?  The developer of such
a driver will simply fix the headers?

> I can respin with that. Sorry again for not being more explanatory
> it is always hard for me to figure what is not obvious to others.

I updated the changelog, no respin needed.
