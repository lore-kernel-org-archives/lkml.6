Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1617904-1519220862-2-9504357597618819628
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519220861; b=ZqO8d/rA1kfySLXNe1hPSHu126apA1vKp2FVFa0Uiw4tVBg
    +rgHEYUA4saBW+syGUufUTmwyzpuv82n2E2lyDuwU6GSl+Q4ctKnfHmf8SGnNiy9
    wrLWuwv0QC5ptJXg0/9SXbjeq1oGG+Bj6HCJDKxKH6RphK9Jq0zrt/dhpOvBVK+M
    znCZpEVmyLJ9pY8Tz3yVjP9XLgTkbH9yKxsKEyY2Bt76tKUiYLuPbW6ySbNvDAVg
    6BuBpia2tAg8Rd8U6564QY2IG93XvSlGVXBFxZInezCKoT7idnJUMSRBOo/3Cymb
    qwYTOYQWstdRSrp30/C2bDICFeWp253nqvbto0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519220861; bh=zL91awLiaS8AYsbFbnpWsN1Y9C
    b1OQi6sOpT8JmfqFE=; b=LGvJj6xbmkKd1KgGkI5hSRdBtzfNGi73AjNHqBtw1P
    +C8/x/VWCR/AJ1azFEyh+bgGncnSjHs6Z7gfY0xmp+m5zUeccKxLCsMD98faokMW
    WAqLRjq6PSULqGTxZnYF7BHmp1DtP21/xbqyRQXayp+ZsXXi5XJ1PAKB0O6Qt1T8
    B8nFvGm2GITgRdK+lXW9CiZw4BUivu0XC6oA8zpG+TgCBlZToDA/6rlPr7lUB4Og
    GOzZ8GMrgpUAMWMzGP0EzyW0/quzbP2bxiWBLFcJxVEhppx3RVNRh+ogFj9aKq6Z
    xULYNg+aFjwUghU6IERzwH+uYCwrWjkLZCb5ERroTcCA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965864AbeBUNrW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:47:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965862AbeBUNrV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:47:21 -0500
Date: Wed, 21 Feb 2018 14:47:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Brown <broonie@linaro.org>, Will Deacon <will.deacon@arm.com>,
        stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] arm64 spectre and meltdown mitigations for -stable
Message-ID: <20180221134723.GA11353@kroah.com>
References: <20180209134811.GB11309@arm.com>
 <20180221125340.GA15211@kroah.com>
 <CAKv+Gu_J_DxAferEYG7r+OQVSymdWmfxOA-NHBP9JU8AKFeouw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_J_DxAferEYG7r+OQVSymdWmfxOA-NHBP9JU8AKFeouw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 01:43:34PM +0000, Ard Biesheuvel wrote:
> On 21 February 2018 at 12:53, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Fri, Feb 09, 2018 at 01:48:11PM +0000, Will Deacon wrote:
> >> Hi Greg,
> >>
> >> I've put together a tag which includes all of the upstream arm64 spectre and
> >> meltdown mitigations based on v4.15. Please could you consider taking this
> >> into the 4.15 stable tree?
> >>
> >> I understand that Ard (cc'd) is using this stack to create a version for 4.14
> >> too.
> >
> > Do you know of anyone working on backporting this patch series to older
> > stable trees (i.e. 4.9.y and 4.4.y and possibly 3.18.y?)
> >
> >
> > I had some requests by some chip manufacturers who were wondering about
> > this, as they seem to be stuck on older kernels (of their own doing, not
> > our fault at all...)
> >
> > If not, no big deal, I'll just tell them they need to do the work
> > themselves if they care about those old kernel trees :)
> >
> 
> I had a stab at applying this series to v4.9 LTS as well as our own
> v4.9 LTS based stable tree (which has backports of lots of arch/arm64
> features applied on top), but there are just too many conflicts.
> Functionally, I don't think there are any real impediments, but the
> interaction with things like PAN emulation and the
> feature/errata/alternatives framework make backporting rather tedious.
> Combined with the fact that the Meltdown threat is rather theoretical
> for most things already deployed, I am not convinced that we are
> likely to end up with something that is more secure than what we
> started with.

Ugh, I was worried about PAN stuff :(

I'm guessing that the android-common trees might have an easier time of
this, I'll go ask the Google developers what they are considering for
these trees.

> In any case, I don't think this series should serve as the basis for a
> backport to v4.9 and earlier, and instead, it should probably focus on
> Spectre mitigation only (which is less intrusive AFAICT).

But we have x86 already working for 4.9.y :)

> We have someone in Linaro who is in charge of our stable kernel trees,
> but he will need help from someone who intimately understands the
> code. My focus was v4.14 primarily because of the significance to my
> team (the enterprise group in Linaro), and I cannot justify spending a
> disproportionate amount of time on kernel versions our members don't
> care about.

Fair enough, it makes sense not to drag this back to older kernels
unless someone really cares about it.  Thanks for the quick response,
I'll push back on the people asking about it to see if they even can
detect the issue on their devices...

thanks,

greg k-h
