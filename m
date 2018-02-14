Return-Path: <stable-commits-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463544-1518632641-2-2024123796052589873
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-commits-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518632640; b=ROFFOcItl0t3xU45psHnhEgMMnb2SS6w9Jv4jfT9LJNyRe+
    w0aP2H4Re0UZcIzrkKWWvEN6CfTFfdkH1MwqcLc4ZMcWCfPWf6TMa5CMCJkVSu5H
    j3nZ8W+HBOXhIagslIHI8eEyPB2k3jt/8EVJGTtFd1RnmcSflUyJ39cw+dWszX02
    skvTesxjxdTymcRL6D1rCRxe0RaqKhVV2R0a0ArXPdtZNUQtbQccefIhuu6+qZVa
    aZGKXDq9E0g6pveoSYB6SdJj/OUBZilUlVuqbucXA/pQ0Mg3X5gsWaWWlWxDz0QO
    lZRvXxZH7TfHIfce5AYel9U+jKahKh09gQBusUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :reply-to:list-id; s=arctest; t=1518632640; bh=x2oP4ESZYkfZbrn0v
    lnUTE/tFvxMy5/lx/NSspz8MH8=; b=Q1myFmQJoEsCZIrlOP9SjXSpIAb/heHOM
    +Iua2lCTXTdB37Dk4Q86eF2fyFv7xkFbw36EfonJ5sBeND0JDzllWolEfxTMxvqd
    xxhrZ0QJBoetVDX7JQVTuh0UOaz6B9HDlxPyo/wmtY9qAkXQ+ESkVxuduXHYN8uf
    kDs7ydRcQVUCEu/u5t3CFHlNmnJB9KEeTwBbCYqR9WUcwxTvXRXQUqZejy/xsBRH
    TcbIADeDnMxObzyXKe5S9SioTDdkOhcA5FxIvX1CksBLxETo/MnCZ+mQIJ1GRri1
    GIM5IRMHZZLOZj2Ewk/HkAORMay/jxB5ZVYBeiHtahF6/4jjOaJvw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-commits-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-commits-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161805AbeBNSXq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 13:23:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161742AbeBNSXo (ORCPT
        <rfc822;stable-commits@vger.kernel.org>);
        Wed, 14 Feb 2018 13:23:44 -0500
Date: Wed, 14 Feb 2018 19:23:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
        stable-commits@vger.kernel.org
Subject: Re: Patch "[Variant 2/Spectre-v2] arm64: Implement branch predictor
 hardening for Falkor" has been added to the 4.14-stable tree
Message-ID: <20180214182346.GD4611@kroah.com>
References: <1518616386206238@kroah.com>
 <CAOZdJXWZV4TDZchsYeHE_Oh+s1y3yjXE9NxVY9wz-vCkZVhN4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOZdJXWZV4TDZchsYeHE_Oh+s1y3yjXE9NxVY9wz-vCkZVhN4w@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-commits-owner@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org
X-Mailing-List: stable-commits@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 10:16:51AM -0600, Timur Tabi wrote:
> On Wed, Feb 14, 2018 at 7:53 AM,  <gregkh@linuxfoundation.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     [Variant 2/Spectre-v2] arm64: Implement branch predictor hardening for Falkor
> >
> > to the 4.14-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      arm64-implement-branch-predictor-hardening-for-falkor.patch
> > and it can be found in the queue-4.14 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please note that there is a follow-on patch, also from Shanker, that
> fixes this patch (it was slightly mangled when merged into 4.16-rc1):
> 
> https://www.spinics.net/lists/arm-kernel/msg633726.html
> 
> I would love for it to be included in 4.14.20, but it hasn't been
> merged into Linus' tree yet.  I will send a patch request when it does
> land in 4.16-rc2.

There's nothing I can do unless it's in Linus's tree :)
