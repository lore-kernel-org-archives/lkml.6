Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519218831-2-7745795576996449289
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
    t=1519218831; b=hJi1M42HnyDQJNK22Bc9QUErYWZJ5G+sgrkccEflpw9ALB8
    ajXo95snmYfq7giE/DWx3mmLGw9Og7Sltkqw/Tib4fKpHL0JMFyw6q7S6xgwzPl4
    b2Y6etRdACLrTavUd98mx9w/GIGdFhzRhLqt/pmTJrNgERVRxpaaE4JWfyKt+h/Q
    FeyrUM1wLFRtDKcwX9CuVV+G0ydoQGfA8QEepOng2EdKUV7O3JLaU+kZ5n/Zm1//
    xEvf9RqpUzFEVbav11/UYFK8PY/BBvTaZK7ZfJC5QrzJw0wJg/RC0yLepbAdKZ6n
    G0MdBwnb8p+TjEsYmndeNVBXMXPyXZsYJTUbxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519218831; bh=5y0k7c21+6WRpHIbcn0kpCB0Tu
    3+vYiooNLuPXIWqJQ=; b=bLjyEV6+msZH+tT1er/2oq9ZEWni0VWkZVqeNDjehv
    bFPXctvxTMMTEyTvyAnKujSBhFVdFYY2GBBfywSWVEJf42fxMfJNkoTpGuabqKHG
    kHnEG34sBAskRAgbsZTVxQblacMSQP6tra9ttATlDZlM6jYw4U6Rt8QSk9PkQonB
    HnZDxye8NTtZEPbLh0FdFwtArW/b8+IWSrolLUuwyRrrFW0DbpkhPJcdsp/iPd8A
    oumZTZtkWn5AdmbA+PEmQRjiIX+XEjZSYjXpgRWo+kddLJ0aJA1casiCtfAjG0Pc
    0ESz+sMRrgPnzfw2rlS/3jCkdcht3PV6AtOL9cQEsCzw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754589AbeBUNNe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:13:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754583AbeBUNNd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:13:33 -0500
Date: Wed, 21 Feb 2018 13:53:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Will Deacon <will.deacon@arm.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org
Subject: Re: [GIT PULL] arm64 spectre and meltdown mitigations for -stable
Message-ID: <20180221125340.GA15211@kroah.com>
References: <20180209134811.GB11309@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209134811.GB11309@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 01:48:11PM +0000, Will Deacon wrote:
> Hi Greg,
> 
> I've put together a tag which includes all of the upstream arm64 spectre and
> meltdown mitigations based on v4.15. Please could you consider taking this
> into the 4.15 stable tree?
> 
> I understand that Ard (cc'd) is using this stack to create a version for 4.14
> too.

Do you know of anyone working on backporting this patch series to older
stable trees (i.e. 4.9.y and 4.4.y and possibly 3.18.y?)


I had some requests by some chip manufacturers who were wondering about
this, as they seem to be stuck on older kernels (of their own doing, not
our fault at all...)

If not, no big deal, I'll just tell them they need to do the work
themselves if they care about those old kernel trees :)

thanks,

greg k-h
